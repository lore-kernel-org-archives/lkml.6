Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B67C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2BB820846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QK6/c9DG";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Uja/17Qm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2BB820846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932967AbeFTIwT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:52:19 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49634 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753906AbeFTIpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:45:04 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9BBFA60B10; Wed, 20 Jun 2018 07:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529479677;
        bh=GEjbLk+ZDg0Uh7Dn0hTtktdHgbTWSSeEmQiP0fuJweQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QK6/c9DGb44pNmr75cEK21hFFn7crlAC0HOInOyfMXuvtddQJbORwSU70PP4TV+9z
         Z5HT7/j/n6AyXMVnOs5tT2rwUj/GHwlNOXHvwPAjwLfS/afCYg7LAc1AA+35OFvzKp
         IR3Skq5curI26dEVs8Gt8S120oTqsrRhYiEs7qw4=
Received: from absahu-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: absahu@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4102560B11;
        Wed, 20 Jun 2018 07:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529479676;
        bh=GEjbLk+ZDg0Uh7Dn0hTtktdHgbTWSSeEmQiP0fuJweQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uja/17QmEp4G78lpbTNk6uAQ9PuWfz7u00u4U79Bq6Fxbqc+RdKUd/U1m3Ji2pfYN
         7k8I0gdiJEsh6saACo75HILzLUKAA+2swihSMkyTbIfQzVlK5pvVJLKjBOwgiDiZS5
         SuwroZHLKfK5aF+iyAXe3ZLhKQ7eY6fuMW2oeQOI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4102560B11
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=absahu@codeaurora.org
From:   Abhishek Sahu <absahu@codeaurora.org>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, Andy Gross <andy.gross@linaro.org>,
        Archit Taneja <architt@codeaurora.org>,
        Abhishek Sahu <absahu@codeaurora.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v4 01/15] mtd: rawnand: helper function for setting up ECC configuration
Date:   Wed, 20 Jun 2018 12:57:28 +0530
Message-Id: <1529479662-4026-2-git-send-email-absahu@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1529479662-4026-1-git-send-email-absahu@codeaurora.org>
References: <1529479662-4026-1-git-send-email-absahu@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
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
   available OOB size.

This patch introduces nand_ecc_choose_conf function which calls the
required helper functions for the above logic. The drivers can use
this single function instead of calling the 3 helper functions
individually.

CC: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
---
* Changes from v3:
  1. call nand_maximize_ecc() 2 times to make code more clear.

* Changes from v2:

  1. Renamed function to nand_ecc_choose_conf.
  2. Minor code reorganization to remove warning and 2 function calls
     for nand_maximize_ecc.

* Changes from v1:
  NEW PATCH

 drivers/mtd/nand/raw/nand_base.c | 33 +++++++++++++++++++++++++++++++++
 include/linux/mtd/rawnand.h      |  3 +++
 2 files changed, 36 insertions(+)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 10c4f991..c64e3fc 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -6287,6 +6287,39 @@ int nand_maximize_ecc(struct nand_chip *chip,
 }
 EXPORT_SYMBOL_GPL(nand_maximize_ecc);
 
+/**
+ * nand_ecc_choose_conf - Set the ECC strength and ECC step size
+ * @chip: nand chip info structure
+ * @caps: ECC engine caps info structure
+ * @oobavail: OOB size that the ECC engine can use
+ *
+ * Choose the ECC configuration according to following logic
+ *
+ * 1. If both ECC step size and ECC strength are already set (usually by DT)
+ *    then check if it is supported by this controller.
+ * 2. If NAND_ECC_MAXIMIZE is set, then select maximum ECC strength.
+ * 3. Otherwise, try to match the ECC step size and ECC strength closest
+ *    to the chip's requirement. If available OOB size can't fit the chip
+ *    requirement then fallback to the maximum ECC step size and ECC strength.
+ *
+ * On success, the chosen ECC settings are set.
+ */
+int nand_ecc_choose_conf(struct nand_chip *chip,
+			 const struct nand_ecc_caps *caps, int oobavail)
+{
+	if (chip->ecc.size && chip->ecc.strength)
+		return nand_check_ecc_caps(chip, caps, oobavail);
+
+	if (chip->ecc.options & NAND_ECC_MAXIMIZE)
+		return nand_maximize_ecc(chip, caps, oobavail);
+
+	if (!nand_match_ecc_req(chip, caps, oobavail))
+		return 0;
+
+	return nand_maximize_ecc(chip, caps, oobavail);
+}
+EXPORT_SYMBOL_GPL(nand_ecc_choose_conf);
+
 /*
  * Check if the chip configuration meet the datasheet requirements.
 
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 3e8ec3b..03a0061 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -1650,6 +1650,9 @@ int nand_match_ecc_req(struct nand_chip *chip,
 int nand_maximize_ecc(struct nand_chip *chip,
 		      const struct nand_ecc_caps *caps, int oobavail);
 
+int nand_ecc_choose_conf(struct nand_chip *chip,
+			 const struct nand_ecc_caps *caps, int oobavail);
+
 /* Default write_oob implementation */
 int nand_write_oob_std(struct mtd_info *mtd, struct nand_chip *chip, int page);
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc.
is a member of Code Aurora Forum, hosted by The Linux Foundation

