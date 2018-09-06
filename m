Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ABE2C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 20:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDF172075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 20:32:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDF172075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729153AbeIGBKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 21:10:07 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2]:63943 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726116AbeIGBKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 21:10:06 -0400
Received: from [IPv6:2a01:cb1d:1a3:2a00:dacb:8aff:fef1:ed46] (unknown [IPv6:2a01:cb1d:1a3:2a00:dacb:8aff:fef1:ed46])
        (Authenticated sender: sed)
        by smtp2-g21.free.fr (Postfix) with ESMTPSA id 80CAC2003E0;
        Thu,  6 Sep 2018 22:32:44 +0200 (CEST)
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Cedric Roux <sed@free.fr>
Subject: [PATCH v2] ARM: s3c24xx: Correct SD card write protect detection on
 Mini2440
Message-ID: <96fe9889-2649-7a1e-23bf-b4d16713d212@free.fr>
Date:   Thu, 6 Sep 2018 22:35:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mini2440 computer uses "active high" to signal that the "write protect"
of the inserted MMC is set. The current code uses the opposite, leading to
a wrong detection of write protection. The solution is simply to use
".wprotect_invert = 1" in the description of the MMC.

Signed-off-by: Cedric Roux <sed@free.fr>
---
 arch/arm/mach-s3c24xx/mach-mini2440.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/mach-mini2440.c b/arch/arm/mach-s3c24xx/mach-mini2440.c
index 95753e0..4cd8d45 100644
--- a/arch/arm/mach-s3c24xx/mach-mini2440.c
+++ b/arch/arm/mach-s3c24xx/mach-mini2440.c
@@ -232,10 +232,11 @@ static struct s3c2410fb_mach_info mini2440_fb_info __initdata = {
 /* MMC/SD  */
 
 static struct s3c24xx_mci_pdata mini2440_mmc_cfg __initdata = {
-   .gpio_detect   = S3C2410_GPG(8),
-   .gpio_wprotect = S3C2410_GPH(8),
-   .set_power     = NULL,
-   .ocr_avail     = MMC_VDD_32_33|MMC_VDD_33_34,
+	.wprotect_invert = 1,
+	.gpio_detect   = S3C2410_GPG(8),
+	.gpio_wprotect = S3C2410_GPH(8),
+	.set_power     = NULL,
+	.ocr_avail     = MMC_VDD_32_33|MMC_VDD_33_34,
 };
 
 /* NAND Flash on MINI2440 board */
-- 
2.18.0
