Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9998EC04ABB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 03:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FC5320882
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 03:17:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FC5320882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbeILIUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 04:20:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55766 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728125AbeILIUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 04:20:10 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 87F6B87A72;
        Wed, 12 Sep 2018 03:17:46 +0000 (UTC)
Received: from jason-ThinkPad-T450s.redhat.com (ovpn-12-130.pek2.redhat.com [10.72.12.130])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DF7102027EA4;
        Wed, 12 Sep 2018 03:17:41 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        mst@redhat.com, jasowang@redhat.com
Subject: [PATCH net-next V2 05/11] tuntap: tweak on the path of skb XDP case in tun_build_skb()
Date:   Wed, 12 Sep 2018 11:17:03 +0800
Message-Id: <20180912031709.14112-6-jasowang@redhat.com>
In-Reply-To: <20180912031709.14112-1-jasowang@redhat.com>
References: <20180912031709.14112-1-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Wed, 12 Sep 2018 03:17:46 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Wed, 12 Sep 2018 03:17:46 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jasowang@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we're sure not to go native XDP, there's no need for several things
like bh and rcu stuffs. So this patch introduces a helper to build skb
and hold page refcnt. When we found we will go through skb path, build
skb directly.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/tun.c | 39 ++++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 257cf7342d54..946c6148ed75 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1635,6 +1635,23 @@ static bool tun_can_build_skb(struct tun_struct *tun, struct tun_file *tfile,
 	return true;
 }
 
+static struct sk_buff *__tun_build_skb(struct page_frag *alloc_frag, char *buf,
+				       int buflen, int len, int pad, int delta)
+{
+	struct sk_buff *skb = build_skb(buf, buflen);
+
+	if (!skb)
+		return ERR_PTR(-ENOMEM);
+
+	skb_reserve(skb, pad - delta);
+	skb_put(skb, len);
+
+	get_page(alloc_frag->page);
+	alloc_frag->offset += buflen;
+
+	return skb;
+}
+
 static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 				     struct tun_file *tfile,
 				     struct iov_iter *from,
@@ -1642,7 +1659,6 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 				     int len, int *skb_xdp)
 {
 	struct page_frag *alloc_frag = &current->task_frag;
-	struct sk_buff *skb;
 	struct bpf_prog *xdp_prog;
 	int buflen = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 	unsigned int delta = 0;
@@ -1672,10 +1688,12 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 	 * of xdp_prog above, this should be rare and for simplicity
 	 * we do XDP on skb in case the headroom is not enough.
 	 */
-	if (hdr->gso_type || !xdp_prog)
+	if (hdr->gso_type || !xdp_prog) {
 		*skb_xdp = 1;
-	else
-		*skb_xdp = 0;
+		return __tun_build_skb(alloc_frag, buf, buflen, len, pad, delta);
+	}
+
+	*skb_xdp = 0;
 
 	local_bh_disable();
 	rcu_read_lock();
@@ -1719,22 +1737,13 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 			trace_xdp_exception(tun->dev, xdp_prog, act);
 			/* fall through */
 		case XDP_DROP:
-			goto err_xdp;
+			goto out;
 		}
 	}
 	rcu_read_unlock();
 	local_bh_enable();
 
-	skb = build_skb(buf, buflen);
-	if (!skb)
-		return ERR_PTR(-ENOMEM);
-
-	skb_reserve(skb, pad - delta);
-	skb_put(skb, len);
-	get_page(alloc_frag->page);
-	alloc_frag->offset += buflen;
-
-	return skb;
+	return __tun_build_skb(alloc_frag, buf, buflen, len, pad, delta);
 
 err_redirect:
 	put_page(alloc_frag->page);
-- 
2.17.1

