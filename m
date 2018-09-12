Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D29B9C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 12:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 854DA20882
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 12:42:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 854DA20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbeILRqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 13:46:31 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:43704 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbeILRqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 13:46:31 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g04TA-0000EE-CJ; Wed, 12 Sep 2018 14:42:08 +0200
Date:   Wed, 12 Sep 2018 14:42:08 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
cc:     stable@vger.kernel.org
Subject: [PATCH stable] x86/tsc: Prevent result truncation on 32 bit
Message-ID: <alpine.DEB.2.21.1809121439390.9957@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: x86/tsc: Prevent result truncation on 32 bit
From: Chuanhua Lei <chuanhua.lei@linux.intel.com>
Date: Thu Sep 6 18:03:23 2018 +0800

From: Chuanhua Lei <chuanhua.lei@linux.intel.com>

Commit 17f6bac2249356c795339e03a0742cd79be3cab8 upstream.

Loops per jiffy is calculated by multiplying tsc_khz with 1e3 and then
dividing it by HZ.
    
Both tsc_khz and the temporary variable holding the multiplication result
are of type unsigned long, so on 32bit the result is truncated to the lower
32bit.
    
Use u64 as type for the temporary variable and cast tsc_khz to it before
multiplying.
    
[ tglx: Backport to stable. Due to massive code changes is the upstream
  	commit not applicable anymore. The issue has gone unnoticed in
  	kernels pre 4.19 because the bogus LPJ value gets fixed up in a
  	later stage of early boot, but it still might cause subtle and hard
  	to debug issues between these two points. ]

Fixes: dd759d93f4dd ("x86/timers: Add simple udelay calibration")
Signed-off-by: Chuanhua Lei <chuanhua.lei@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: yixin.zhu@linux.intel.com
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Len Brown <len.brown@intel.com>
Cc: Pavel Tatashin <pavel.tatashin@microsoft.com>
Cc: Rajvi Jingar <rajvi.jingar@intel.com>
Cc: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: Ville Syrjala <ville.syrjala@linux.intel.com>
Link: https://lkml.kernel.org/r/1536228203-18701-1-git-send-email-chuanhua.lei@linux.intel.com

---
 arch/x86/kernel/tsc.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1343,7 +1343,7 @@ device_initcall(init_tsc_clocksource);
 
 void __init tsc_early_delay_calibrate(void)
 {
-	unsigned long lpj;
+	u64 lpj;
 
 	if (!boot_cpu_has(X86_FEATURE_TSC))
 		return;
@@ -1355,7 +1355,7 @@ void __init tsc_early_delay_calibrate(vo
 	if (!tsc_khz)
 		return;
 
-	lpj = tsc_khz * 1000;
+	lpj = (u64)tsc_khz * 1000;
 	do_div(lpj, HZ);
 	loops_per_jiffy = lpj;
 }
