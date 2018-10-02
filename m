Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F61C00449
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 01:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A279921473
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 01:08:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A279921473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-mips.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbeJBHtX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 03:49:23 -0400
Received: from eddie.linux-mips.org ([148.251.95.138]:34050 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbeJBHtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 03:49:23 -0400
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23994583AbeJBBItoarV3 (ORCPT
        <rfc822;stable@vger.kernel.org> + 2 others);
        Tue, 2 Oct 2018 03:08:49 +0200
Date:   Tue, 2 Oct 2018 02:08:49 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH 1/2] rtc: cmos: Fix non-ACPI undefined reference to
 `hpet_rtc_interrupt'
In-Reply-To: <alpine.LFD.2.21.1810020122330.20762@eddie.linux-mips.org>
Message-ID: <alpine.LFD.2.21.1810020132270.20762@eddie.linux-mips.org>
References: <alpine.LFD.2.21.1810020122330.20762@eddie.linux-mips.org>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a commit 311ee9c151ad ("rtc: cmos: allow using ACPI for RTC alarm 
instead of HPET") `rtc-cmos' regression causing a link error:

drivers/rtc/rtc-cmos.o: In function `cmos_platform_probe':
rtc-cmos.c:(.init.text+0x33c): undefined reference to `hpet_rtc_interrupt'
rtc-cmos.c:(.init.text+0x3f4): undefined reference to `hpet_rtc_interrupt'

with non-ACPI platforms using this driver.  The cause is the change of 
the condition guarding the use of `hpet_rtc_interrupt'.

Previously it was a call to `is_hpet_enabled'.  That function is static 
inline and has a hardcoded 0 result for non-ACPI platforms, which imply 
!HPET_EMULATE_RTC.  Consequently the compiler optimized the whole block 
away including the reference to `hpet_rtc_interrupt', which never made 
it to the link stage.

Now the guarding condition is a call to `use_hpet_alarm', which is not 
static inline and therefore the compiler may not be able to prove that 
it actually always returns 0 for non-ACPI platforms.  Consequently the 
build breaks with an unsatisfied reference, because `hpet_rtc_interrupt' 
is nowhere defined at link time.

Fix the problem by marking `use_hpet_alarm' inline.  As the `inline' 
keyword serves as an optimization hint rather than a requirement the 
compiler is still free to choose whether inlining will be beneficial or 
not for ACPI platforms.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
Fixes: 311ee9c151ad ("rtc: cmos: allow using ACPI for RTC alarm instead of HPET")
Cc: stable@vger.kernel.org # 4.18+
---
 drivers/rtc/rtc-cmos.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

linux-rtc-cmos-use-hpet-alarm-inline.diff
Index: linux-20180812-4maxp64/drivers/rtc/rtc-cmos.c
===================================================================
--- linux-20180812-4maxp64.orig/drivers/rtc/rtc-cmos.c
+++ linux-20180812-4maxp64/drivers/rtc/rtc-cmos.c
@@ -167,7 +167,7 @@ static inline int hpet_unregister_irq_ha
 #endif
 
 /* Don't use HPET for RTC Alarm event if ACPI Fixed event is used */
-static int use_hpet_alarm(void)
+static inline int use_hpet_alarm(void)
 {
 	return is_hpet_enabled() && !use_acpi_alarm;
 }
