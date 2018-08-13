Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F33C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 03:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA59B2183C
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 03:17:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA59B2183C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbeHMF5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 01:57:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57810 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728055AbeHMF5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 01:57:54 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B11CF8780F;
        Mon, 13 Aug 2018 03:17:39 +0000 (UTC)
Received: from jason-ThinkPad-T450s.redhat.com (ovpn-12-183.pek2.redhat.com [10.72.12.183])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B36872156712;
        Mon, 13 Aug 2018 03:17:36 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, jbrouer@redhat.com,
        mst@redhat.com, Jason Wang <jasowang@redhat.com>
Subject: [RFC PATCH net-next V2 1/6] net: core: factor out generic XDP check and process routine
Date:   Mon, 13 Aug 2018 11:17:25 +0800
Message-Id: <1534130250-5302-2-git-send-email-jasowang@redhat.com>
In-Reply-To: <1534130250-5302-1-git-send-email-jasowang@redhat.com>
References: <1534130250-5302-1-git-send-email-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 13 Aug 2018 03:17:39 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 13 Aug 2018 03:17:39 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jasowang@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/core/dev.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index f68122f..605c66e 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4392,13 +4392,9 @@ int do_xdp_generic(struct bpf_prog *xdp_prog, struct sk_buff *skb)
 }
 EXPORT_SYMBOL_GPL(do_xdp_generic);
 
-static int netif_rx_internal(struct sk_buff *skb)
+static int netif_do_generic_xdp(struct sk_buff *skb)
 {
-	int ret;
-
-	net_timestamp_check(netdev_tstamp_prequeue, skb);
-
-	trace_netif_rx(skb);
+	int ret = XDP_PASS;
 
 	if (static_branch_unlikely(&generic_xdp_needed_key)) {
 		int ret;
@@ -4408,15 +4404,28 @@ static int netif_rx_internal(struct sk_buff *skb)
 		ret = do_xdp_generic(rcu_dereference(skb->dev->xdp_prog), skb);
 		rcu_read_unlock();
 		preempt_enable();
-
-		/* Consider XDP consuming the packet a success from
-		 * the netdev point of view we do not want to count
-		 * this as an error.
-		 */
-		if (ret != XDP_PASS)
-			return NET_RX_SUCCESS;
 	}
 
+	return ret;
+}
+
+static int netif_rx_internal(struct sk_buff *skb)
+{
+	int ret;
+
+	net_timestamp_check(netdev_tstamp_prequeue, skb);
+
+	trace_netif_rx(skb);
+
+	ret = netif_do_generic_xdp(skb);
+
+	/* Consider XDP consuming the packet a success from
+	 * the netdev point of view we do not want to count
+	 * this as an error.
+	 */
+	if (ret != XDP_PASS)
+		return NET_RX_SUCCESS;
+
 #ifdef CONFIG_RPS
 	if (static_key_false(&rps_needed)) {
 		struct rps_dev_flow voidflow, *rflow = &voidflow;
-- 
2.7.4

