Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751887AbeECMVH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 08:21:07 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41056 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751729AbeECMU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 08:20:59 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A2D8A607CF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=absahu@codeaurora.org
From: Abhishek Sahu <absahu@codeaurora.org>
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, Andy Gross <andy.gross@linaro.org>,
        Archit Taneja <architt@codeaurora.org>,
        Abhishek Sahu <absahu@codeaurora.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v2 01/14] mtd: rawnand: helper function for setting up ECC parameters
Date: Thu,  3 May 2018 17:50:28 +0530
Message-Id: <1525350041-22995-2-git-send-email-absahu@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1525350041-22995-1-git-send-email-absahu@codeaurora.org>
References: <1525350041-22995-1-git-send-email-absahu@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 2c8f8afa7f92 ("mtd: nand: add generic helpers to check,
match, maximize ECC settings") provides generic helpers which
drivers can use for setting up ECC parameters.

Since same board can have different ECC strength nand chips so
following is the logic for setting up ECC strength and ECC step
size, which can be used by most of the drivers.

1. If both ECC step size and ECC strength are already set
   (usually by DT) then just check whether this setting
   is supported by NAND controller.
2. If NAND_ECC_MAXIMIZE is set, then select maximum ECC strength
   supported by NAND controller.
3. Otherwise, try to match the ECC step size and ECC strength closest
   to the chip's requirement. If available OOB size can't fit the chip
   requirement then select maximum ECC strength which can be fit with
   available OOB size with warning.

This patch introduces nand_ecc_param_setup function which calls the
required helper functions for the above logic. The drivers can use
this single function instead of calling the 3 helper functions
individually.

CC: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
---
* Changes from v1:

  NEW PATCH

 drivers/mtd/nand/raw/nand_base.c | 42 ++++++++++++++++++++++++++++++++++++++++
 include/linux/mtd/rawnand.h      |  3 +++
 2 files changed, 45 insertions(+)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 72f3a89..dd7a984 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -6249,6 +6249,48 @@ int nand_maximize_ecc(struct nand_chip *chip,
 }
 EXPORT_SYMBOL_GPL(nand_maximize_ecc);
 
+/**
+ * nand_ecc_param_setup - Set the ECC strength and ECC step size
+ * @chip: nand chip info structure
+ * @caps: ECC engine caps info structure
+ * @oobavail: OOB size that the ECC engine can use
+ *
+ * Choose the ECC strength according to following logic
+ *
+ * 1. If both ECC step size and ECC strength are already set (usually by DT)
+ *    then check if it is supported by this controller.
+ * 2. If NAND_ECC_MAXIMIZE is set, then select maximum ECC strength.
+ * 3. Otherwise, try to match the ECC step size and ECC strength closest
+ *    to the chip's requirement. If available OOB size can't fit the chip
+ *    requirement then fallback to the maximum ECC step size and ECC strength
+ *    and print the warning.
+ *
+ * On success, the chosen ECC settings are set.
+ */
+int nand_ecc_param_setup(struct nand_chip *chip,
+			 const struct nand_ecc_caps *caps, int oobavail)
+{
+	int ret;
+
+	if (chip->ecc.size && chip->ecc.strength)
+		return nand_check_ecc_caps(chip, caps, oobavail);
+
+	if (chip->ecc.options & NAND_ECC_MAXIMIZE)
+		return nand_maximize_ecc(chip, caps, oobavail);
+
+	if (!nand_match_ecc_req(chip, caps, oobavail))
+		return 0;
+
+	ret = nand_maximize_ecc(chip, caps, oobavail);
+	if (!ret)
+		pr_warn("ECC (step, strength) = (%d, %d) not supported on this controller. Fallback to (%d, %d)\n",
+			chip->ecc_step_ds, chip->ecc_strength_ds,
+			chip->ecc.size, chip->ecc.strength);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(nand_ecc_param_setup);
+
 /*
  * Check if the chip configuration meet the datasheet requirements.
 
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 5dad59b..afc7447 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -1627,6 +1627,9 @@ int nand_match_ecc_req(struct nand_chip *chip,
 int nand_maximize_ecc(struct nand_chip *chip,
 		      const struct nand_ecc_caps *caps, int oobavail);
 
+int nand_ecc_param_setup(struct nand_chip *chip,
+			 const struct nand_ecc_caps *caps, int oobavail);
+
 /* Default write_oob implementation */
 int nand_write_oob_std(struct mtd_info *mtd, struct nand_chip *chip, int page);
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc.
is a member of Code Aurora Forum, hosted by The Linux Foundation
