Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751296AbeDDMmv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 08:42:51 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40268 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750915AbeDDMms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 08:42:48 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E44B560F5F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=absahu@codeaurora.org
From: Abhishek Sahu <absahu@codeaurora.org>
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, Andy Gross <andy.gross@linaro.org>,
        Archit Taneja <architt@codeaurora.org>,
        Abhishek Sahu <absahu@codeaurora.org>
Subject: [PATCH 1/9] mtd: nand: qcom: use the ecc strength from device parameter
Date: Wed,  4 Apr 2018 18:12:17 +0530
Message-Id: <1522845745-6624-2-git-send-email-absahu@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1522845745-6624-1-git-send-email-absahu@codeaurora.org>
References: <1522845745-6624-1-git-send-email-absahu@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the driver uses the ECC strength specified in
device tree. The ONFI or JEDEC device parameter page
contains the ‘ECC correctability’ field which indicates the
number of bits that the host should be able to correct per
512 bytes of data. The ecc correctability is assigned in
chip parameter during device probe time. QPIC/EBI2 NAND
supports 4/8-bit ecc correction. The Same kind of board
can have different NAND parts so use the ecc strength
from device parameter (if its non zero) instead of
device tree.

Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
---
 drivers/mtd/nand/qcom_nandc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mtd/nand/qcom_nandc.c b/drivers/mtd/nand/qcom_nandc.c
index 563b759..8dd40de 100644
--- a/drivers/mtd/nand/qcom_nandc.c
+++ b/drivers/mtd/nand/qcom_nandc.c
@@ -2334,6 +2334,14 @@ static int qcom_nand_host_setup(struct qcom_nand_host *host)
 		return -EINVAL;
 	}
 
+	/*
+	 * Read the required ecc strength from NAND device and overwrite
+	 * the device tree ecc strength for devices which require
+	 * ecc correctability bits >= 8
+	 */
+	if (chip->ecc_strength_ds >= 8)
+		ecc->strength = 8;
+
 	wide_bus = chip->options & NAND_BUSWIDTH_16 ? true : false;
 
 	if (ecc->strength >= 8) {
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
