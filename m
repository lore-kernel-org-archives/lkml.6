Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA1A7C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 04:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68DF62192C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 04:42:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68DF62192C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbeHFGtB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 02:49:01 -0400
Received: from inva020.nxp.com ([92.121.34.13]:41672 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726449AbeHFGtB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 02:49:01 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 1D8921A00A7;
        Mon,  6 Aug 2018 06:41:46 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 8266C1A00DB;
        Mon,  6 Aug 2018 06:41:43 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id D6F4140283;
        Mon,  6 Aug 2018 12:41:39 +0800 (SGT)
From:   Yangbo Lu <yangbo.lu@nxp.com>
To:     netdev@vger.kernel.org, Richard Cochran <richardcochran@gmail.com>,
        "David S . Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, Yangbo Lu <yangbo.lu@nxp.com>
Subject: [PATCH] ptp_qoriq: use div_u64/div_u64_rem for 64-bit division
Date:   Mon,  6 Aug 2018 12:39:11 +0800
Message-Id: <20180806043911.15437-1-yangbo.lu@nxp.com>
X-Mailer: git-send-email 2.14.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a fix-up patch for below build issue with multi_v7_defconfig.

drivers/ptp/ptp_qoriq.o: In function `qoriq_ptp_probe':
ptp_qoriq.c:(.text+0xd0c): undefined reference to `__aeabi_uldivmod'

Fixes: 91305f281262 ("ptp_qoriq: support automatic configuration for ptp timer")
Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
 drivers/ptp/ptp_qoriq.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/ptp/ptp_qoriq.c b/drivers/ptp/ptp_qoriq.c
index 095c185..fdd49c2 100644
--- a/drivers/ptp/ptp_qoriq.c
+++ b/drivers/ptp/ptp_qoriq.c
@@ -373,6 +373,7 @@ static int qoriq_ptp_auto_config(struct qoriq_ptp *qoriq_ptp,
 	u64 freq_comp;
 	u64 max_adj;
 	u32 nominal_freq;
+	u32 remainder = 0;
 	u32 clk_src = 0;
 
 	qoriq_ptp->cksel = DEFAULT_CKSEL;
@@ -400,7 +401,8 @@ static int qoriq_ptp_auto_config(struct qoriq_ptp *qoriq_ptp,
 	 * freq_ratio = reference_clock_freq / nominal_freq
 	 */
 	freq_comp = ((u64)1 << 32) * nominal_freq;
-	if (do_div(freq_comp, clk_src))
+	freq_comp = div_u64_rem(freq_comp, clk_src, &remainder);
+	if (remainder)
 		freq_comp++;
 
 	qoriq_ptp->tmr_add = freq_comp;
@@ -411,7 +413,7 @@ static int qoriq_ptp_auto_config(struct qoriq_ptp *qoriq_ptp,
 	 * freq_ratio = reference_clock_freq / nominal_freq
 	 */
 	max_adj = 1000000000ULL * (clk_src - nominal_freq);
-	max_adj = max_adj / nominal_freq - 1;
+	max_adj = div_u64(max_adj, nominal_freq) - 1;
 	qoriq_ptp->caps.max_adj = max_adj;
 
 	return 0;
-- 
1.7.1

