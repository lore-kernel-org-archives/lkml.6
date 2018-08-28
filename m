Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0110AC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 19:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88CDA20856
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 19:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=compulab.co.il header.i=@compulab.co.il header.b="ERZUCpc/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88CDA20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=compulab.co.il
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbeH1XkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 19:40:19 -0400
Received: from softlayer.compulab.co.il ([50.23.254.55]:42618 "EHLO
        compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726807AbeH1XkS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 19:40:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=compulab.co.il; s=default; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=lwb87Jhqu1uE9HzpIkOY4FkFJVP/FN8HaEYUGV8lel8=; b=ERZUCpc/HYHqs2cHsm6DtCgKYl
        dxDKfVy13I4IfBAhm7W8RBjqmQ62X+1kG/mxwwJazNpR3DPOymmjjKqF93F7R8jwkDY4EdhfVxSGV
        hnYIIkG35pBM7zF929r0AnEEpXQidDsATbdQRhhjjLfhz113mKy/yyWFeLLjeVBWwV/XsjkYZsxCx
        13Q1SQOr5NBIMkRYxnjWJ45vzPUCAKpLMFM4YPAtXn0wMMOzs53vb/dlrREl2DoqdJFlyXtgsdp8d
        GrZ2Y49Vfw63ikOLslKdYQ96p3Dekt2intnP3pC95XT5McQjcnUGmBFWtZJibTSAGJdN2iwJbO1Lg
        pZoUjilw==;
Received: from [37.142.126.90] (port=34931 helo=zimbra-mta.compulab.co.il)
        by softlayer.compulab.co.il with esmtp (Exim 4.87)
        (envelope-from <kirill.kapranov@compulab.co.il>)
        id 1fujxD-0005dh-QD; Tue, 28 Aug 2018 22:47:08 +0300
Received: from localhost (localhost [127.0.0.1])
        by zimbra-mta.compulab.co.il (Postfix) with ESMTP id 943C6482AF6;
        Tue, 28 Aug 2018 22:47:06 +0300 (IDT)
Received: from zimbra-mta.compulab.co.il ([127.0.0.1])
        by localhost (zimbra-mta.compulab.co.il [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 8Wjb7u8twOET; Tue, 28 Aug 2018 22:47:06 +0300 (IDT)
Received: from localhost (localhost [127.0.0.1])
        by zimbra-mta.compulab.co.il (Postfix) with ESMTP id 36513482AFF;
        Tue, 28 Aug 2018 22:47:06 +0300 (IDT)
X-Virus-Scanned: amavisd-new at zimbra-mta.compulab.co.il
Received: from zimbra-mta.compulab.co.il ([127.0.0.1])
        by localhost (zimbra-mta.compulab.co.il [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id YynNUlXvutUZ; Tue, 28 Aug 2018 22:47:06 +0300 (IDT)
Received: from zimbra01.compulab.co.il (zimbra01.compulab.co.il [192.168.10.66])
        by zimbra-mta.compulab.co.il (Postfix) with ESMTP id EED20482AF6;
        Tue, 28 Aug 2018 22:47:05 +0300 (IDT)
Date:   Tue, 28 Aug 2018 22:47:05 +0300 (IDT)
From:   Kirill kapranov <kirill.kapranov@compulab.co.il>
To:     Mark Brown <broonie@kernel.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, festevam@gmail.com,
        linux@roeck-us.net
Message-ID: <2024176715.614.1535485625914.JavaMail.root@compulab.co.il>
In-Reply-To: <20180826132415.GB2414@sirena.org.uk>
References: <20180821095303.27664-1-geert+renesas@glider.be> <35fbd3ae-3ac3-f6ef-874b-3d99c4d4d29a@compulab.co.il> <20180823102121.GC5207@sirena.org.uk> <a1bba27e-a287-c162-a238-eeae1e84d63c@compulab.co.il> <20180826132415.GB2414@sirena.org.uk>
Subject: Re: [PATCH -next] spi: Fix double IDR allocation with DT aliases
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.10]
X-Mailer: Zimbra 8.0.1_GA_5438 (ZimbraWebClient - FF52 (Linux)/8.0.1_GA_5438)
Thread-Topic: Fix double IDR allocation with DT aliases
Thread-Index: sLpuLnC6fKJGIEy7uj/+imKItdx31g==
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - softlayer.compulab.co.il
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - compulab.co.il
X-Get-Message-Sender-Via: softlayer.compulab.co.il: acl_c_recent_authed_mail_ips_text_entry: kirill.kapranov@compulab.co.il|compulab.co.il
X-Authenticated-Sender: softlayer.compulab.co.il: kirill.kapranov@compulab.co.il
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Right, that clearly wasn't an intended effect, though - should be using
> the max of the big constant and the maximum static ID.

Due to difficulties of enumeration of all device in a system, I propose
to assign safe sub-range for dynamic IDs in the upper-half of ID range the following way.

NOTE-0: This patch has to be applied after Geert's patch,
which fixes double call of idr_alloc. (above in the thread). Many thanks, Geert!

NOTE-1: The best solution, IMHO, would be migration to property_get_*
functions, declared in linux/property.h 

[PATCH] Eliminate possibility of conflict between static and dynamic IDs

For systems without DT support allocate dynamical bus ID in a safe sub-range
(if given), otherwise in upper half of the range so as to avoid possible
conflict between statically and dynamically allocated IDs.

Signed-off-by: Kirill Kapranov <kirill.kapranov@compulab.co.il>
---
 drivers/spi/Kconfig |  8 ++++++++
 drivers/spi/spi.c   | 22 +++++++++++++++++++++-
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 671d078349cc..7498fae0113b 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -47,6 +47,14 @@ config SPI_MASTER
 
 if SPI_MASTER
 
+config SPI_MASTER_DYN_BUS_NUM_FIRST
+	int "First dynamically assigned SPI bus ID" if EXPERT
+	default 0
+	help
+	  This value can be used as the beginning of sub-range for dynamic
+	  allocation of SPI bus ID in case of absence of DT. If -1 chosen, the
+	  sub-range will be allocated in upper half of the SPI bus ID range.
+
 config SPI_MEM
 	bool "SPI memory extension"
 	help
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 9da0bc5a036c..3ac0cf0ab49c 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -49,6 +49,18 @@
 
 #include "internals.h"
 
+#ifndef CHAR_BIT
+#define CHAR_BIT 8	/* Normally in <limits.h> */
+#endif
+#if !defined(CONFIG_SPI_MASTER_DYN_BUS_NUM_FIRST) || \
+	CONFIG_SPI_MASTER_DYN_BUS_NUM_FIRST < 0
+//Half of the biggest signed int of this size
+#define SPI_DYN_FIRST_NUM (((1 << \
+	(sizeof(((struct spi_controller*)0)->bus_num) * CHAR_BIT - 1)) - 1) / 2)
+#else
+#define SPI_DYN_FIRST_NUM CONFIG_SPI_MASTER_DYN_BUS_NUM_FIRST
+#endif
+
 static DEFINE_IDR(spi_master_idr);
 
 static void spidev_release(struct device *dev)
@@ -2167,7 +2179,15 @@ int spi_register_controller(struct spi_controller *ctlr)
 	}
 	if (ctlr->bus_num < 0) {
 		first_dynamic = of_alias_get_highest_id("spi");
-		if (first_dynamic < 0)
+
+		if (first_dynamic == -ENOSYS)
+			/*
+			 * In case of system without DT support, allocate
+			 * dynamic bus ID in safe range, higher than the bound,
+			 * to avoid conflict between static and dynamic ID
+			 */
+			first_dynamic = SPI_DYN_FIRST_NUM;
+		else if (first_dynamic < 0)
 			first_dynamic = 0;
 		else
 			first_dynamic++;
-- 
2.11.0
