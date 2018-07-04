Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D3DC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 11:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFC95241ED
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 11:46:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFC95241ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934680AbeGDLqB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 07:46:01 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42529 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932758AbeGDLp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 07:45:57 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fagEM-0006uL-6h; Wed, 04 Jul 2018 11:45:54 +0000
From:   Colin King <colin.king@canonical.com>
To:     Manish Chopra <manish.chopra@cavium.com>,
        Rahul Verma <rahul.verma@cavium.com>,
        Dept-GELinuxNICDev@cavium.com,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] qlogic: netxen: remove various redundant variables
Date:   Wed,  4 Jul 2018 12:45:53 +0100
Message-Id: <20180704114553.8293-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variables consumer, cmd_desc, end_cnt and no_of_desc are being assigned
but are never used hence they are redundant and can be removed.

Cleans up clang warnings:
warning: variable 'consumer' set but not used [-Wunused-but-set-variable]
warning: variable 'cmd_desc' set but not used [-Wunused-but-set-variable]
warning: variable 'end_cnt' set but not used [-Wunused-but-set-variable]
warning: variable 'no_of_desc' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/qlogic/netxen/netxen_nic_hw.c   | 10 ++--------
 drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c |  4 +---
 2 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/netxen/netxen_nic_hw.c b/drivers/net/ethernet/qlogic/netxen/netxen_nic_hw.c
index 1cd39c9a0345..52ad80621335 100644
--- a/drivers/net/ethernet/qlogic/netxen/netxen_nic_hw.c
+++ b/drivers/net/ethernet/qlogic/netxen/netxen_nic_hw.c
@@ -566,9 +566,8 @@ static int
 netxen_send_cmd_descs(struct netxen_adapter *adapter,
 		struct cmd_desc_type0 *cmd_desc_arr, int nr_desc)
 {
-	u32 i, producer, consumer;
+	u32 i, producer;
 	struct netxen_cmd_buffer *pbuf;
-	struct cmd_desc_type0 *cmd_desc;
 	struct nx_host_tx_ring *tx_ring;
 
 	i = 0;
@@ -580,7 +579,6 @@ netxen_send_cmd_descs(struct netxen_adapter *adapter,
 	__netif_tx_lock_bh(tx_ring->txq);
 
 	producer = tx_ring->producer;
-	consumer = tx_ring->sw_consumer;
 
 	if (nr_desc >= netxen_tx_avail(tx_ring)) {
 		netif_tx_stop_queue(tx_ring->txq);
@@ -595,8 +593,6 @@ netxen_send_cmd_descs(struct netxen_adapter *adapter,
 	}
 
 	do {
-		cmd_desc = &cmd_desc_arr[i];
-
 		pbuf = &tx_ring->cmd_buf_arr[producer];
 		pbuf->skb = NULL;
 		pbuf->frag_count = 0;
@@ -2350,7 +2346,7 @@ static int netxen_md_entry_err_chk(struct netxen_adapter *adapter,
 static int netxen_parse_md_template(struct netxen_adapter *adapter)
 {
 	int num_of_entries, buff_level, e_cnt, esize;
-	int end_cnt = 0, rv = 0, sane_start = 0, sane_end = 0;
+	int rv = 0, sane_start = 0, sane_end = 0;
 	char *dbuff;
 	void *template_buff = adapter->mdump.md_template;
 	char *dump_buff = adapter->mdump.md_capture_buff;
@@ -2386,8 +2382,6 @@ static int netxen_parse_md_template(struct netxen_adapter *adapter)
 			break;
 		case RDEND:
 			entry->hdr.driver_flags |= NX_DUMP_SKIP;
-			if (!sane_end)
-				end_cnt = e_cnt;
 			sane_end += 1;
 			break;
 		case CNTRL:
diff --git a/drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c b/drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c
index 8259e8309320..69aa7fc392c5 100644
--- a/drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c
+++ b/drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c
@@ -2073,7 +2073,7 @@ netxen_nic_xmit_frame(struct sk_buff *skb, struct net_device *netdev)
 	struct skb_frag_struct *frag;
 
 	u32 producer;
-	int frag_count, no_of_desc;
+	int frag_count;
 	u32 num_txd = tx_ring->num_desc;
 
 	frag_count = skb_shinfo(skb)->nr_frags + 1;
@@ -2093,8 +2093,6 @@ netxen_nic_xmit_frame(struct sk_buff *skb, struct net_device *netdev)
 
 		frag_count = 1 + skb_shinfo(skb)->nr_frags;
 	}
-	/* 4 fragments per cmd des */
-	no_of_desc = (frag_count + 3) >> 2;
 
 	if (unlikely(netxen_tx_avail(tx_ring) <= TX_STOP_THRESH)) {
 		netif_stop_queue(netdev);
-- 
2.17.1

