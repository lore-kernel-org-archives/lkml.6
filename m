Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77BD8C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B4DA208EC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:01:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B4DA208EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388427AbeGKOGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 10:06:25 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:5373 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387708AbeGKOGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 10:06:24 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b460dcf0000>; Wed, 11 Jul 2018 07:01:51 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 11 Jul 2018 07:01:54 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 11 Jul 2018 07:01:54 -0700
Received: from dhcp-10-21-25-168.Nvidia.com (10.21.25.201) by
 HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1347.2; Wed, 11 Jul 2018 14:01:51 +0000
From:   Aapo Vienamo <avienamo@nvidia.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>
CC:     Aapo Vienamo <avienamo@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/7] soc/tegra: pmc: Factor out DPD register bit calculation
Date:   Wed, 11 Jul 2018 17:01:28 +0300
Message-ID: <1531317693-3520-3-git-send-email-avienamo@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531317693-3520-1-git-send-email-avienamo@nvidia.com>
References: <1531317693-3520-1-git-send-email-avienamo@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.21.25.201]
X-ClientProxiedBy: UKMAIL102.nvidia.com (10.26.138.15) To HQMAIL101.nvidia.com
 (172.20.187.10)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factor out the the code to calculate the correct DPD register and bit
number for a given pad. This logic will be needed to query the status
register.

Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
Acked-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/soc/tegra/pmc.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index f926332..393ca72 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -922,11 +922,12 @@ tegra_io_pad_find(struct tegra_pmc *pmc, enum tegra_io_pad id)
 	return NULL;
 }
 
-static int tegra_io_pad_prepare(enum tegra_io_pad id, unsigned long *request,
-				unsigned long *status, u32 *mask)
+static int tegra_io_pad_get_dpd_register_bit(enum tegra_io_pad id,
+					     unsigned long *request,
+					     unsigned long *status,
+					     u32 *mask)
 {
 	const struct tegra_io_pad_soc *pad;
-	unsigned long rate, value;
 
 	pad = tegra_io_pad_find(pmc, id);
 	if (!pad) {
@@ -947,6 +948,19 @@ static int tegra_io_pad_prepare(enum tegra_io_pad id, unsigned long *request,
 		*request = pmc->soc->regs->dpd2_req;
 	}
 
+	return 0;
+}
+
+static int tegra_io_pad_prepare(enum tegra_io_pad id, unsigned long *request,
+				unsigned long *status, u32 *mask)
+{
+	unsigned long rate, value;
+	int err;
+
+	err = tegra_io_pad_get_dpd_register_bit(id, request, status, mask);
+	if (err)
+		return err;
+
 	if (pmc->clk) {
 		rate = clk_get_rate(pmc->clk);
 		if (!rate) {
-- 
2.7.4

