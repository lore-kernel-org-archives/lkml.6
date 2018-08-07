Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE5C2C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 19:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 987C5214E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 19:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="dk6htlvc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 987C5214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390473AbeHGV51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 17:57:27 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40817 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389192AbeHGV51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 17:57:27 -0400
Received: by mail-pf1-f194.google.com with SMTP id e13-v6so9070554pff.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 12:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=subject:date:message-id:in-reply-to:references:cc:from:to;
        bh=kstVtcNsgZUc7SUcEaqzSqyeXb2OI35+ht6gHHiQd4s=;
        b=dk6htlvcsBfYKJvo2GORRneAM9nEVg+3EsBct41gVKWSEFTp4SvZ7/JAVUr0P8YeMc
         fbJM5qgvqgCyvb8YsD0q1V4/dCqaB0utrIFPNuQ+sFqkznkzufkpmVtiWK0BqdB1Uk9b
         jd6ngZEelng44LAW7J6zAp4WLZ8h3Oj1TD7cdz0ffdWmsLPkqLhQspx3zAczIVLQ6fm/
         uuStoEQaxKz2hcF5wC7jxgalt6MyN+5wDdFJxcWzr0h+gMT+XUYqgontK1m1FS9NbflH
         vD3BqAVAWJ4eTjowic/mYba+BfwkhXkLVRjLNPZ0l1UKLVnr1VaMcv+f2kPEERL1vCPy
         ElJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :cc:from:to;
        bh=kstVtcNsgZUc7SUcEaqzSqyeXb2OI35+ht6gHHiQd4s=;
        b=b2GHPvU7DeX+NVKlc0P2y1rpnbHwzVqAMKIn0du27l6Aq12gH34xmXBPqp7xuQ13nr
         9HMNtHWFmcnQIhIOwMUI5v2hWst+h+2u/RHXjUJkPD3Q1Xu1Yaqaxe0S5dlZ222zyyOi
         IVFGduxnPNgWqMyMAFw5s9ozKDeNcrUPiW6r7hxCdz2N1aIH1vtzhMohS9T6es3RWN0Y
         qdyj2356o1lpX270XobyfTuzv1Q9Ym07Nqo8LhrF2eoMxK4IY80RgVTFoVIgazebNxzw
         sVAGaQU6QBpisK7UHr9zYCQhW4Tnlk7PVTc93uQs9FdDfpm42kYZv7lXAOTM3jjcB1CV
         +36w==
X-Gm-Message-State: AOUpUlFpvxqg0djxImB5wLynWWQFHORZo5V4+UttZAoYCzqtpHfQhjxC
        ruD5JRulOWS8CoBt2RyE7jo1VA==
X-Google-Smtp-Source: AAOMgpe1EmQw2jycLEktKzbWRZqnoAcfpEn0offwE/+WE41mU8pgIw04AzgLps+RqlCB8GUN0+iDRw==
X-Received: by 2002:a63:ae02:: with SMTP id q2-v6mr19563048pgf.189.1533670891483;
        Tue, 07 Aug 2018 12:41:31 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id 16-v6sm3668860pfp.6.2018.08.07.12.41.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 12:41:30 -0700 (PDT)
Subject: [PATCH v2 1/2] spi-nor: add support for ISSI's block unlocking scheme
Date:   Tue,  7 Aug 2018 12:40:58 -0700
Message-Id: <20180807194059.26348-2-palmer@sifive.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180807194059.26348-1-palmer@sifive.com>
References: <20180807194059.26348-1-palmer@sifive.com>
Cc:     dwmw2@infradead.org, computersforpeace@gmail.com,
        boris.brezillon@bootlin.com, richard@nod.at,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Wesley W. Terpstra" <wesley@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>
From:   Palmer Dabbelt <palmer@sifive.com>
To:     marek.vasut@gmail.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Wesley W. Terpstra" <wesley@sifive.com>

ISSI uses a non-standard scheme to control block protection, with bit 5
of the status registerr controlling an additional block protection bit.
This patch disables all the block protection bits whenever an ISSI chip
is seen.

We might also want to trigger an error when writing SR_TB to these
chips, as it aliases with this extra protection bit in the status
register.  It looks like that's always conditional on SNOR_F_HAS_SR_TB,
so at least what's there is safe.

Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
 include/linux/mtd/spi-nor.h   |  2 ++
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index d9c368c44194..aab93463a5e7 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -1515,6 +1515,44 @@ static int macronix_quad_enable(struct spi_nor *nor)
 	return 0;
 }
 
+/**
+ * issi_unlock() - clear BP[0123] write-protection.
+ * @nor:	pointer to a 'struct spi_nor'
+ *
+ * Bits [2345] of the Status Register are BP[0123].
+ * ISSI chips use a different block protection scheme than other chips.
+ * Just disable the write-protect unilaterally.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+static int issi_unlock(struct spi_nor *nor)
+{
+	int ret, val;
+	u8 mask = SR_BP0 | SR_BP1 | SR_BP2 | SR_BP3;
+
+	val = read_sr(nor);
+	if (val < 0)
+		return val;
+	if (!(val & mask))
+		return 0;
+
+	write_enable(nor);
+
+	write_sr(nor, val & ~mask);
+
+	ret = spi_nor_wait_till_ready(nor);
+	if (ret)
+		return ret;
+
+	ret = read_sr(nor);
+	if (ret > 0 && !(ret & mask)) {
+		return 0;
+	} else {
+		dev_err(nor->dev, "ISSI Block Protection Bits not cleared\n");
+		return -EINVAL;
+	}
+}
+
 /*
  * Write status Register and configuration register with 2 bytes
  * The first byte will be written to the status register, while the
@@ -2747,6 +2785,9 @@ static int spi_nor_init(struct spi_nor *nor)
 		spi_nor_wait_till_ready(nor);
 	}
 
+	if (JEDEC_MFR(nor->info) == SNOR_MFR_ISSI)
+		issi_unlock(nor);
+
 	if (nor->quad_enable) {
 		err = nor->quad_enable(nor);
 		if (err) {
@@ -2926,7 +2967,7 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
 	if (ret)
 		return ret;
 
-	if (nor->addr_width) {
+	if (nor->addr_width && JEDEC_MFR(info) != SNOR_MFR_ISSI) {
 		/* already configured from SFDP */
 	} else if (info->addr_width) {
 		nor->addr_width = info->addr_width;
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index e60da0d34cc1..da422a37d383 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -23,6 +23,7 @@
 #define SNOR_MFR_ATMEL		CFI_MFR_ATMEL
 #define SNOR_MFR_GIGADEVICE	0xc8
 #define SNOR_MFR_INTEL		CFI_MFR_INTEL
+#define SNOR_MFR_ISSI		0x9d
 #define SNOR_MFR_MICRON		CFI_MFR_ST /* ST Micro <--> Micron */
 #define SNOR_MFR_MACRONIX	CFI_MFR_MACRONIX
 #define SNOR_MFR_SPANSION	CFI_MFR_AMD
@@ -121,6 +122,7 @@
 #define SR_BP0			BIT(2)	/* Block protect 0 */
 #define SR_BP1			BIT(3)	/* Block protect 1 */
 #define SR_BP2			BIT(4)	/* Block protect 2 */
+#define SR_BP3			BIT(5)  /* Block protect 3 (on ISSI chips) */
 #define SR_TB			BIT(5)	/* Top/Bottom protect */
 #define SR_SRWD			BIT(7)	/* SR write protect */
 /* Spansion/Cypress specific status bits */
-- 
2.16.4

