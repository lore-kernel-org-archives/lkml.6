Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E02BBC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A139A2172B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:46:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A139A2172B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730848AbeHCJlp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 05:41:45 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50148 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727594AbeHCJlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 05:41:45 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1flUnE-00079m-ES; Fri, 03 Aug 2018 07:46:36 +0000
From:   Colin King <colin.king@canonical.com>
To:     Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        Amitkumar Karwar <amit.karwar@redpinesignals.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rsi: remove redundant variables bss, wh and temp_flash_content
Date:   Fri,  3 Aug 2018 08:46:36 +0100
Message-Id: <20180803074636.20479-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variables bss, wh and temp_flash_content are being assigned but are
never used hence they are redundant and can be removed.

Cleans up clang warnings:
warning: variable 'bss' set but not used [-Wunused-but-set-variable]
warning: variable 'wh' set but not used [-Wunused-but-set-variable]
warning: variable 'temp_flash_content' set but not used
 [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/wireless/rsi/rsi_91x_hal.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/net/wireless/rsi/rsi_91x_hal.c b/drivers/net/wireless/rsi/rsi_91x_hal.c
index 27e6baf12e90..01edf960ff3c 100644
--- a/drivers/net/wireless/rsi/rsi_91x_hal.c
+++ b/drivers/net/wireless/rsi/rsi_91x_hal.c
@@ -57,7 +57,6 @@ int rsi_prepare_mgmt_desc(struct rsi_common *common, struct sk_buff *skb)
 	struct ieee80211_vif *vif;
 	struct rsi_mgmt_desc *mgmt_desc;
 	struct skb_info *tx_params;
-	struct ieee80211_bss_conf *bss = NULL;
 	struct rsi_xtended_desc *xtend_desc = NULL;
 	u8 header_size;
 	u32 dword_align_bytes = 0;
@@ -91,7 +90,6 @@ int rsi_prepare_mgmt_desc(struct rsi_common *common, struct sk_buff *skb)
 
 	tx_params->internal_hdr_size = header_size;
 	memset(&skb->data[0], 0, header_size);
-	bss = &vif->bss_conf;
 	wh = (struct ieee80211_hdr *)&skb->data[header_size];
 
 	mgmt_desc = (struct rsi_mgmt_desc *)skb->data;
@@ -148,7 +146,6 @@ int rsi_prepare_data_desc(struct rsi_common *common, struct sk_buff *skb)
 	struct ieee80211_hdr *wh = NULL;
 	struct ieee80211_tx_info *info;
 	struct skb_info *tx_params;
-	struct ieee80211_bss_conf *bss;
 	struct rsi_data_desc *data_desc;
 	struct rsi_xtended_desc *xtend_desc;
 	u8 ieee80211_size = MIN_802_11_HDR_LEN;
@@ -159,7 +156,6 @@ int rsi_prepare_data_desc(struct rsi_common *common, struct sk_buff *skb)
 
 	info = IEEE80211_SKB_CB(skb);
 	vif = info->control.vif;
-	bss = &vif->bss_conf;
 	tx_params = (struct skb_info *)info->driver_data;
 
 	header_size = FRAME_DESC_SZ + sizeof(struct rsi_xtended_desc);
@@ -288,7 +284,6 @@ int rsi_send_data_pkt(struct rsi_common *common, struct sk_buff *skb)
 	struct ieee80211_tx_info *info;
 	struct skb_info *tx_params;
 	struct ieee80211_bss_conf *bss;
-	struct ieee80211_hdr *wh;
 	int status = -EINVAL;
 	u8 header_size;
 
@@ -304,7 +299,6 @@ int rsi_send_data_pkt(struct rsi_common *common, struct sk_buff *skb)
 	bss = &vif->bss_conf;
 	tx_params = (struct skb_info *)info->driver_data;
 	header_size = tx_params->internal_hdr_size;
-	wh = (struct ieee80211_hdr *)&skb->data[header_size];
 
 	if (((vif->type == NL80211_IFTYPE_STATION) ||
 	     (vif->type == NL80211_IFTYPE_P2P_CLIENT)) &&
@@ -747,13 +741,11 @@ static int ping_pong_write(struct rsi_hw *adapter, u8 cmd, u8 *addr, u32 size)
 static int auto_fw_upgrade(struct rsi_hw *adapter, u8 *flash_content,
 			   u32 content_size)
 {
-	u8 cmd, *temp_flash_content;
+	u8 cmd;
 	u32 temp_content_size, num_flash, index;
 	u32 flash_start_address;
 	int status;
 
-	temp_flash_content = flash_content;
-
 	if (content_size > MAX_FLASH_FILE_SIZE) {
 		rsi_dbg(ERR_ZONE,
 			"%s: Flash Content size is more than 400K %u\n",
-- 
2.17.1

