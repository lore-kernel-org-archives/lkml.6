Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3035C04ABB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 03:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8800420882
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 03:17:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8800420882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbeILIUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 04:20:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44548 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726027AbeILIUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 04:20:05 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3BD4340241C0;
        Wed, 12 Sep 2018 03:17:41 +0000 (UTC)
Received: from jason-ThinkPad-T450s.redhat.com (ovpn-12-130.pek2.redhat.com [10.72.12.130])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 89E1B2027EA4;
        Wed, 12 Sep 2018 03:17:38 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        mst@redhat.com, jasowang@redhat.com
Subject: [PATCH net-next V2 04/11] tuntap: simplify error handling in tun_build_skb()
Date:   Wed, 12 Sep 2018 11:17:02 +0800
Message-Id: <20180912031709.14112-5-jasowang@redhat.com>
In-Reply-To: <20180912031709.14112-1-jasowang@redhat.com>
References: <20180912031709.14112-1-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 12 Sep 2018 03:17:41 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 12 Sep 2018 03:17:41 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jasowang@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no need to duplicate page get logic in each action. So this
patch tries to get page and calculate the offset before processing XDP
actions (except for XDP_DROP), and undo them when meet errors (we
don't care the performance on errors). This will be used for factoring
out XDP logic.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/tun.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 372caf7d67d9..257cf7342d54 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1701,17 +1701,13 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 			xdp_do_flush_map();
 			if (err)
 				goto err_redirect;
-			rcu_read_unlock();
-			local_bh_enable();
-			return NULL;
+			goto out;
 		case XDP_TX:
 			get_page(alloc_frag->page);
 			alloc_frag->offset += buflen;
 			if (tun_xdp_tx(tun->dev, &xdp) < 0)
 				goto err_redirect;
-			rcu_read_unlock();
-			local_bh_enable();
-			return NULL;
+			goto out;
 		case XDP_PASS:
 			delta = orig_data - xdp.data;
 			len = xdp.data_end - xdp.data;
@@ -1742,7 +1738,7 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 
 err_redirect:
 	put_page(alloc_frag->page);
-err_xdp:
+out:
 	rcu_read_unlock();
 	local_bh_enable();
 	this_cpu_inc(tun->pcpu_stats->rx_dropped);
-- 
2.17.1

