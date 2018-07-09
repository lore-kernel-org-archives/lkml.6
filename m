Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C14C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 13:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C54220881
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 13:17:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C54220881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932764AbeGINR0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 09:17:26 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36682 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754437AbeGINRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 09:17:24 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fcW2b-0001jy-6s; Mon, 09 Jul 2018 13:17:21 +0000
From:   Colin King <colin.king@canonical.com>
To:     Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ath6kl: remove redundant variables netlen, orig_buf, orig_len, dropped and stats
Date:   Mon,  9 Jul 2018 14:17:20 +0100
Message-Id: <20180709131720.6668-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variables netlen, orig_buf, orig_len, dropped and stats are assigned values
but are never used hence they are redundant and can be removed.

Cleans up clang warnings:
warning: variable 'netlen' set but not used [-Wunused-but-set-variable]
warning: variable 'orig_buf' set but not used [-Wunused-but-set-variable]
warning: variable 'orig_len' set but not used [-Wunused-but-set-variable]
warning: variable 'dropped' set but not used [-Wunused-but-set-variable]
warning: variable 'stats' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/wireless/ath/ath6kl/htc_pipe.c | 10 ++--------
 drivers/net/wireless/ath/ath6kl/main.c     |  3 +--
 drivers/net/wireless/ath/ath6kl/txrx.c     |  2 --
 3 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/ath/ath6kl/htc_pipe.c b/drivers/net/wireless/ath/ath6kl/htc_pipe.c
index 546243e11737..434b66829646 100644
--- a/drivers/net/wireless/ath/ath6kl/htc_pipe.c
+++ b/drivers/net/wireless/ath/ath6kl/htc_pipe.c
@@ -746,10 +746,8 @@ static int ath6kl_htc_pipe_tx_complete(struct ath6kl *ar, struct sk_buff *skb)
 	struct htc_endpoint *ep;
 	struct htc_packet *packet;
 	u8 ep_id, *netdata;
-	u32 netlen;
 
 	netdata = skb->data;
-	netlen = skb->len;
 
 	htc_hdr = (struct htc_frame_hdr *) netdata;
 
@@ -855,12 +853,8 @@ static int htc_process_trailer(struct htc_target *target, u8 *buffer,
 {
 	struct htc_credit_report *report;
 	struct htc_record_hdr *record;
-	u8 *record_buf, *orig_buf;
-	int orig_len, status;
-
-	orig_buf = buffer;
-	orig_len = len;
-	status = 0;
+	u8 *record_buf;
+	int status = 0;
 
 	while (len > 0) {
 		if (len < sizeof(struct htc_record_hdr)) {
diff --git a/drivers/net/wireless/ath/ath6kl/main.c b/drivers/net/wireless/ath/ath6kl/main.c
index 808fb30be9ad..0c61dbaa62a4 100644
--- a/drivers/net/wireless/ath/ath6kl/main.c
+++ b/drivers/net/wireless/ath/ath6kl/main.c
@@ -272,7 +272,7 @@ int ath6kl_read_fwlogs(struct ath6kl *ar)
 {
 	struct ath6kl_dbglog_hdr debug_hdr;
 	struct ath6kl_dbglog_buf debug_buf;
-	u32 address, length, dropped, firstbuf, debug_hdr_addr;
+	u32 address, length, firstbuf, debug_hdr_addr;
 	int ret, loop;
 	u8 *buf;
 
@@ -303,7 +303,6 @@ int ath6kl_read_fwlogs(struct ath6kl *ar)
 	address = TARG_VTOP(ar->target_type,
 			    le32_to_cpu(debug_hdr.dbuf_addr));
 	firstbuf = address;
-	dropped = le32_to_cpu(debug_hdr.dropped);
 	ret = ath6kl_diag_read(ar, address, &debug_buf, sizeof(debug_buf));
 	if (ret)
 		goto out;
diff --git a/drivers/net/wireless/ath/ath6kl/txrx.c b/drivers/net/wireless/ath/ath6kl/txrx.c
index 618d12ed4b40..b22ed499f7ba 100644
--- a/drivers/net/wireless/ath/ath6kl/txrx.c
+++ b/drivers/net/wireless/ath/ath6kl/txrx.c
@@ -1701,7 +1701,6 @@ void aggr_recv_addba_req_evt(struct ath6kl_vif *vif, u8 tid_mux, u16 seq_no,
 	struct ath6kl_sta *sta;
 	struct aggr_info_conn *aggr_conn = NULL;
 	struct rxtid *rxtid;
-	struct rxtid_stats *stats;
 	u16 hold_q_size;
 	u8 tid, aid;
 
@@ -1722,7 +1721,6 @@ void aggr_recv_addba_req_evt(struct ath6kl_vif *vif, u8 tid_mux, u16 seq_no,
 		return;
 
 	rxtid = &aggr_conn->rx_tid[tid];
-	stats = &aggr_conn->stat[tid];
 
 	if (win_sz < AGGR_WIN_SZ_MIN || win_sz > AGGR_WIN_SZ_MAX)
 		ath6kl_dbg(ATH6KL_DBG_WLAN_RX, "%s: win_sz %d, tid %d\n",
-- 
2.17.1

