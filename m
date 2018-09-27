Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92009C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5017B20836
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:13:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5017B20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbeI0PaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:30:21 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55412 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727634AbeI0PaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:30:20 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3BEF61120;
        Thu, 27 Sep 2018 09:13:03 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.18 44/88] xen/netfront: dont bug in case of too many frags
Date:   Thu, 27 Sep 2018 11:03:25 +0200
Message-Id: <20180927090306.164812304@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180927090300.631426620@linuxfoundation.org>
References: <20180927090300.631426620@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Juergen Gross <jgross@suse.com>

commit ad4f15dc2c70b1de5e0a64d27335962fbc9cf71c upstream.

Commit 57f230ab04d291 ("xen/netfront: raise max number of slots in
xennet_get_responses()") raised the max number of allowed slots by one.
This seems to be problematic in some configurations with netback using
a larger MAX_SKB_FRAGS value (e.g. old Linux kernel with MAX_SKB_FRAGS
defined as 18 instead of nowadays 17).

Instead of BUG_ON() in this case just fall back to retransmission.

Fixes: 57f230ab04d291 ("xen/netfront: raise max number of slots in xennet_get_responses()")
Cc: stable@vger.kernel.org
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/xen-netfront.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -907,7 +907,11 @@ static RING_IDX xennet_fill_frags(struct
 			BUG_ON(pull_to <= skb_headlen(skb));
 			__pskb_pull_tail(skb, pull_to - skb_headlen(skb));
 		}
-		BUG_ON(skb_shinfo(skb)->nr_frags >= MAX_SKB_FRAGS);
+		if (unlikely(skb_shinfo(skb)->nr_frags >= MAX_SKB_FRAGS)) {
+			queue->rx.rsp_cons = ++cons;
+			kfree_skb(nskb);
+			return ~0U;
+		}
 
 		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
 				skb_frag_page(nfrag),
@@ -1044,6 +1048,8 @@ err:
 		skb->len += rx->status;
 
 		i = xennet_fill_frags(queue, skb, &tmpq);
+		if (unlikely(i == ~0U))
+			goto err;
 
 		if (rx->flags & XEN_NETRXF_csum_blank)
 			skb->ip_summed = CHECKSUM_PARTIAL;


