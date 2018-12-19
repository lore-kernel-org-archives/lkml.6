Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B32C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 07:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DF8E2184A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 07:29:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbeLSH3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 02:29:41 -0500
Received: from helmsgmaster01.f-secure.com ([193.110.108.20]:37218 "EHLO
        helmsgmaster01.f-secure.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725290AbeLSH3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 02:29:40 -0500
Received: from pps.filterd (helmsgmaster01.f-secure.com [127.0.0.1])
        by helmsgmaster01.f-secure.com (8.16.0.27/8.16.0.27) with SMTP id wBJ6tDoG009798;
        Wed, 19 Dec 2018 08:59:45 +0200
Received: from helex02.fi.f-secure.com ([10.190.48.73])
        by helmsgmaster01.f-secure.com with ESMTP id 2pfe6205b2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 19 Dec 2018 08:59:45 +0200
Received: from lambda.inversepath.com (10.191.8.145) by
 helex01.FI.F-Secure.com (10.190.48.70) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 19 Dec 2018 08:58:29 +0200
Received: from lambda.inversepath.com (localhost [127.0.0.1])
        by lambda.inversepath.com (OpenSMTPD) with ESMTP id 2747125d;
        Wed, 19 Dec 2018 06:58:28 +0000 (UTC)
Date:   Wed, 19 Dec 2018 07:58:28 +0100
From:   Andrea Barisani <andrea@inversepath.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        <linux-kernel@vger.kernel.org>
CC:     Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH v4.14 1/1]: nvmem: imx-ocotp: account for addressing gaps to
 ensure consistent read/write on i.MX SoCs
Message-ID: <20181219065828.GD2843@lambda.inversepath.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-GPG-Key: 0x864C9B9E
X-GPG-Fingerprint: 0A76 074A 02CD E989 CE7F  AC3F DA47 578E 864C 9B9E
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Originating-IP: [10.191.8.145]
X-ClientProxiedBy: helex01.FI.F-Secure.com (10.190.48.70) To
 helex01.FI.F-Secure.com (10.190.48.70)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The nvmem-imx-ocotp driver does not currently handle addressing gaps between
OTP banks which can be present in i.MX System-on-Chip part numbers.

This leads to inconsistencies between the interpretation of the offset
argument in read and write operations, not only requiring specific
workarounds but also resulting in the impossibility of reading the entire OTP
bank.

Additionally this inconsistency violates the NVMEM subsystem principle of
exposing a userspace binary interface for read/write operations against a
pseudo-file.

This patch accounts for addressing gaps, depending on the specific i.MX model
being addressed.

Signed-off-by: Andrea Barisani <andrea@inversepath.com>

---
 drivers/nvmem/imx-ocotp.c |   49 ++++++++++++++++++++++++++++++------
 1 file changed, 41 insertions(+), 8 deletions(-)

--- linux-4.14.89/drivers/nvmem/imx-ocotp.c.orig	2018-12-18 10:30:49.363322853 +0100
+++ linux-4.14.89/drivers/nvmem/imx-ocotp.c	2018-12-18 10:31:18.143778980 +0100
@@ -114,6 +114,8 @@ static int imx_ocotp_read(void *context,
 {
 	struct ocotp_priv *priv = context;
 	unsigned int count;
+	unsigned int base_offset;
+	const char *compat;
 	u32 *buf = val;
 	int i, ret;
 	u32 index;
@@ -139,11 +141,42 @@ static int imx_ocotp_read(void *context,
 		goto read_end;
 	}
 
+	compat = of_get_property(priv->dev->of_node, "compatible", NULL);
+
 	for (i = index; i < (index + count); i++) {
-		*buf++ = readl(priv->base + IMX_OCOTP_OFFSET_B0W0 +
-			       i * IMX_OCOTP_OFFSET_PER_WORD);
+		/*
+		 * On specific i.MX P/Ns there are addressing gaps between
+		 * contiguous OTP banks which must be accounted for when
+		 * reading OTP banks from mapped memory.
+		 *
+		 * This is necessary to make the imx_ocotp_read() offset
+		 * interpretation consistent with imx_ocotp_write(), which
+		 * does not require to account for gaps as it uses the offset
+		 * value to derive the bank index and pass it directly to the
+		 * OCOTP controller (rather than being used for mapped memory
+		 * addressing).
+		 */
+		base_offset = IMX_OCOTP_OFFSET_B0W0 + i * IMX_OCOTP_OFFSET_PER_WORD;
+
+		if (strcmp(compat, "fsl,imx6sx-ocotp")) {
+			/* 44.5.43 [IMX6SXRM]
+			 * 256 bytes gap between Bank5 Word7 (21B_C6F0h, offset 0x6f0) and
+			 * Bank10 Word1 (21B_CA10h, offset 0xa10)
+			 */
+			if (base_offset > 0x6f0)
+				base_offset += 0x100;
+		} else if (strcmp(compat, "fsl,imx6ul-ocotp")) {
+			/* 35.5.59 [IMX6ULRM]
+			 * 256 bytes gap between Bank5 Word7 (21B_C6F0h, offset 0x6f0) and
+			 * Bank6 Word0 (21B_C800h, offset 0x800)
+			 */
+			if (base_offset > 0x6f0)
+				base_offset += 0x100;
+		}
+
+		*buf++ = readl(priv->base + base_offset);
 
-		/* 47.3.1.2
+		/* 47.3.1.2 [IMX6SDLRM]
 		 * For "read locked" registers 0xBADABADA will be returned and
 		 * HW_OCOTP_CTRL[ERROR] will be set. It must be cleared by
 		 * software before any new write, read or reload access can be
@@ -205,7 +238,7 @@ static int imx_ocotp_write(void *context
 
 	writel(timing, priv->base + IMX_OCOTP_ADDR_TIMING);
 
-	/* 47.3.1.3.2
+	/* 47.3.1.3.2 [IMX6SDLRM]
 	 * Check that HW_OCOTP_CTRL[BUSY] and HW_OCOTP_CTRL[ERROR] are clear.
 	 * Overlapped accesses are not supported by the controller. Any pending
 	 * write or reload must be completed before a write access can be
@@ -217,7 +250,7 @@ static int imx_ocotp_write(void *context
 		goto write_end;
 	}
 
-	/* 47.3.1.3.3
+	/* 47.3.1.3.3 [IMX6SDLRM]
 	 * Write the requested address to HW_OCOTP_CTRL[ADDR] and program the
 	 * unlock code into HW_OCOTP_CTRL[WR_UNLOCK]. This must be programmed
 	 * for each write access. The lock code is documented in the register
@@ -234,7 +267,7 @@ static int imx_ocotp_write(void *context
 
 	writel(ctrl, priv->base + IMX_OCOTP_ADDR_CTRL);
 
-	/* 47.3.1.3.4
+	/* 47.3.1.3.4 [IMX6SDLRM]
 	 * Write the data to the HW_OCOTP_DATA register. This will automatically
 	 * set HW_OCOTP_CTRL[BUSY] and clear HW_OCOTP_CTRL[WR_UNLOCK]. To
 	 * protect programming same OTP bit twice, before program OCOTP will
@@ -254,7 +287,7 @@ static int imx_ocotp_write(void *context
 	 */
 	writel(*buf, priv->base + IMX_OCOTP_ADDR_DATA);
 
-	/* 47.4.1.4.5
+	/* 47.4.1.4.5 [IMX6SDLRM]
 	 * Once complete, the controller will clear BUSY. A write request to a
 	 * protected or locked region will result in no OTP access and no
 	 * setting of HW_OCOTP_CTRL[BUSY]. In addition HW_OCOTP_CTRL[ERROR] will
@@ -272,7 +305,7 @@ static int imx_ocotp_write(void *context
 		goto write_end;
 	}
 
-	/* 47.3.1.4
+	/* 47.3.1.4 [IMX6SDLRM]
 	 * Write Postamble: Due to internal electrical characteristics of the
 	 * OTP during writes, all OTP operations following a write must be
 	 * separated by 2 us after the clearing of HW_OCOTP_CTRL_BUSY following

-- 
Andrea Barisani     Head of Hardware Security |     F-Secure
                                      Founder | Inverse Path

https://www.f-secure.com             https://inversepath.com
0x864C9B9E 0A76 074A 02CD E989 CE7F AC3F DA47 578E 864C 9B9E
       "Pluralitas non est ponenda sine necessitate"
