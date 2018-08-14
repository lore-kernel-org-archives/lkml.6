Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E0FC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50D8221727
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:30:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50D8221727
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389468AbeHNUSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:18:30 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53120 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388543AbeHNUS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:18:29 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id F1EA8BDB;
        Tue, 14 Aug 2018 17:30:21 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        Wei Liu <wei.liu2@citrix.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.17 07/97] xen/netfront: dont cache skb_shinfo()
Date:   Tue, 14 Aug 2018 19:16:19 +0200
Message-Id: <20180814171433.458173068@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180814171433.160434170@linuxfoundation.org>
References: <20180814171433.160434170@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Juergen Gross <jgross@suse.com>

commit d472b3a6cf63cd31cae1ed61930f07e6cd6671b5 upstream.

skb_shinfo() can change when calling __pskb_pull_tail(): Don't cache
its return value.

Cc: stable@vger.kernel.org
Signed-off-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Wei Liu <wei.liu2@citrix.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/xen-netfront.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -894,7 +894,6 @@ static RING_IDX xennet_fill_frags(struct
 				  struct sk_buff *skb,
 				  struct sk_buff_head *list)
 {
-	struct skb_shared_info *shinfo = skb_shinfo(skb);
 	RING_IDX cons = queue->rx.rsp_cons;
 	struct sk_buff *nskb;
 
@@ -903,15 +902,16 @@ static RING_IDX xennet_fill_frags(struct
 			RING_GET_RESPONSE(&queue->rx, ++cons);
 		skb_frag_t *nfrag = &skb_shinfo(nskb)->frags[0];
 
-		if (shinfo->nr_frags == MAX_SKB_FRAGS) {
+		if (skb_shinfo(skb)->nr_frags == MAX_SKB_FRAGS) {
 			unsigned int pull_to = NETFRONT_SKB_CB(skb)->pull_to;
 
 			BUG_ON(pull_to <= skb_headlen(skb));
 			__pskb_pull_tail(skb, pull_to - skb_headlen(skb));
 		}
-		BUG_ON(shinfo->nr_frags >= MAX_SKB_FRAGS);
+		BUG_ON(skb_shinfo(skb)->nr_frags >= MAX_SKB_FRAGS);
 
-		skb_add_rx_frag(skb, shinfo->nr_frags, skb_frag_page(nfrag),
+		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
+				skb_frag_page(nfrag),
 				rx->offset, rx->status, PAGE_SIZE);
 
 		skb_shinfo(nskb)->nr_frags = 0;


