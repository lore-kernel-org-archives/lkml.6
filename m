Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA79DC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A63E92087F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:34:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A63E92087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933081AbeGIMez (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 08:34:55 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35866 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932601AbeGIMev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 08:34:51 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fcVNO-0007XD-Vo; Mon, 09 Jul 2018 12:34:47 +0000
From:   Colin King <colin.king@canonical.com>
To:     Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ath10k: remove redundant pointers 'dev' and 'noa'
Date:   Mon,  9 Jul 2018 13:34:46 +0100
Message-Id: <20180709123446.14796-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Pointers dev and noa are being assigned but are never used hence they
are redundant and can be removed.

Cleans up clang warnings:
warning: variable 'dev' set but not used [-Wunused-but-set-variable]
warning: variable 'noa' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/wireless/ath/ath10k/ahb.c     | 5 -----
 drivers/net/wireless/ath/ath10k/wmi-tlv.c | 2 --
 2 files changed, 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/ahb.c b/drivers/net/wireless/ath/ath10k/ahb.c
index fa39ffffd34d..c9bd0e2b5db7 100644
--- a/drivers/net/wireless/ath/ath10k/ahb.c
+++ b/drivers/net/wireless/ath/ath10k/ahb.c
@@ -133,11 +133,8 @@ static void ath10k_ahb_clock_deinit(struct ath10k *ar)
 static int ath10k_ahb_clock_enable(struct ath10k *ar)
 {
 	struct ath10k_ahb *ar_ahb = ath10k_ahb_priv(ar);
-	struct device *dev;
 	int ret;
 
-	dev = &ar_ahb->pdev->dev;
-
 	if (IS_ERR_OR_NULL(ar_ahb->cmd_clk) ||
 	    IS_ERR_OR_NULL(ar_ahb->ref_clk) ||
 	    IS_ERR_OR_NULL(ar_ahb->rtc_clk)) {
@@ -451,12 +448,10 @@ static int ath10k_ahb_resource_init(struct ath10k *ar)
 {
 	struct ath10k_ahb *ar_ahb = ath10k_ahb_priv(ar);
 	struct platform_device *pdev;
-	struct device *dev;
 	struct resource *res;
 	int ret;
 
 	pdev = ar_ahb->pdev;
-	dev = &pdev->dev;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
diff --git a/drivers/net/wireless/ath/ath10k/wmi-tlv.c b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
index 8c49a26fc571..fc0f98487d11 100644
--- a/drivers/net/wireless/ath/ath10k/wmi-tlv.c
+++ b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
@@ -1785,7 +1785,6 @@ ath10k_wmi_tlv_op_gen_vdev_start(struct ath10k *ar,
 {
 	struct wmi_tlv_vdev_start_cmd *cmd;
 	struct wmi_channel *ch;
-	struct wmi_p2p_noa_descriptor *noa;
 	struct wmi_tlv *tlv;
 	struct sk_buff *skb;
 	size_t len;
@@ -1843,7 +1842,6 @@ ath10k_wmi_tlv_op_gen_vdev_start(struct ath10k *ar,
 	tlv = ptr;
 	tlv->tag = __cpu_to_le16(WMI_TLV_TAG_ARRAY_STRUCT);
 	tlv->len = 0;
-	noa = (void *)tlv->value;
 
 	/* Note: This is a nested TLV containing:
 	 * [wmi_tlv][wmi_p2p_noa_descriptor][wmi_tlv]..
-- 
2.17.1

