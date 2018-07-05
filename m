Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C262C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 12:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D07F924067
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 12:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="GmKzi8Z7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D07F924067
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753946AbeGEMSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 08:18:23 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:38710 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753824AbeGEMSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 08:18:22 -0400
Received: from trochilidae.toradex.int (unknown [46.140.72.82])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id F1CAE5C1BF9;
        Thu,  5 Jul 2018 14:18:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1530793101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:content-type:content-transfer-encoding:
         in-reply-to:references; bh=zxRLT9PTaZ2MDYVTHGbstKdBLzqJq2JQPwNigiZOSK0=;
        b=GmKzi8Z7FQfXJfYf1VJ9rWo/hswm61LXgL6bgRctXCuNK0+wPKhd5aes26hRTjv1MYkveF
        y0f2UZKleUIMx3zL8Q0t5AwSbORpxkzNRLZrphefVSk4VZn6oTEsayuOqWVOpbe8p2agNd
        1ZGuwxrC4te20HwAsyk8Hl9BSjhCnh8=
From:   Stefan Agner <stefan@agner.ch>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     marcel@ziswiler.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>
Subject: [PATCH] mmc: sdhci: do not try to use 3.3V signaling if not supported
Date:   Thu,  5 Jul 2018 14:18:19 +0200
Message-Id: <20180705121819.7157-1-stefan@agner.ch>
X-Mailer: git-send-email 2.18.0
X-Spamd-Result: default: False [-2.10 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         RCPT_COUNT_FIVE(0.00)[6];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         TO_DN_SOME(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         MID_CONTAINS_FROM(1.00)[];
         ASN(0.00)[asn:6830, ipnet:46.140.0.0/17, country:AT];
         RCVD_TLS_ALL(0.00)[];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For eMMC devices it is valid to only support 1.8V signaling. When
vqmmc is set to a fixed 1.8V regulator the stack tries to set 3.3V
initially and prints the following warning:
   mmc1: Switching to 3.3V signalling voltage failed

Clear the MMC_SIGNAL_VOLTAGE_330 flag in case 3.3V is signaling is
not available. This prevents the stack from even trying to use
3.3V signaling and avoids the above warning.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/mmc/host/sdhci.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 1c828e0e9905..a7b5602ef6f7 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3734,14 +3734,21 @@ int sdhci_setup_host(struct sdhci_host *host)
 	    mmc_gpio_get_cd(host->mmc) < 0)
 		mmc->caps |= MMC_CAP_NEEDS_POLL;
 
-	/* If vqmmc regulator and no 1.8V signalling, then there's no UHS */
 	if (!IS_ERR(mmc->supply.vqmmc)) {
 		ret = regulator_enable(mmc->supply.vqmmc);
+
+		/* If vqmmc provides no 1.8V signalling, then there's no UHS */
 		if (!regulator_is_supported_voltage(mmc->supply.vqmmc, 1700000,
 						    1950000))
 			host->caps1 &= ~(SDHCI_SUPPORT_SDR104 |
 					 SDHCI_SUPPORT_SDR50 |
 					 SDHCI_SUPPORT_DDR50);
+
+		/* In eMMC case vqmmc might be a fixed 1.8V regulator */
+		if (!regulator_is_supported_voltage(mmc->supply.vqmmc, 2700000,
+						    3600000))
+			host->flags &= ~SDHCI_SIGNALING_330;
+
 		if (ret) {
 			pr_warn("%s: Failed to enable vqmmc regulator: %d\n",
 				mmc_hostname(mmc), ret);
-- 
2.18.0

