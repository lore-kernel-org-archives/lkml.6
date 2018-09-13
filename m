Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F99CC07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 135B120854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:06:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 135B120854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732015AbeIMTQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:16:00 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35590 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731651AbeIMTP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:15:59 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 52839D39;
        Thu, 13 Sep 2018 14:06:19 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Chuanhua Lei <chuanhua.lei@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        yixin.zhu@linux.intel.com, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Len Brown <len.brown@intel.com>,
        Pavel Tatashin <pasha.tatashin@microsoft.com>,
        Rajvi Jingar <rajvi.jingar@intel.com>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: [PATCH 4.18 185/197] x86/tsc: Prevent result truncation on 32bit
Date:   Thu, 13 Sep 2018 15:32:14 +0200
Message-Id: <20180913131848.961235382@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131841.568116777@linuxfoundation.org>
References: <20180913131841.568116777@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chuanhua Lei <chuanhua.lei@linux.intel.com>

commit 17f6bac2249356c795339e03a0742cd79be3cab8 upstream.

Loops per jiffy is calculated by multiplying tsc_khz with 1e3 and then
dividing it by HZ.

Both tsc_khz and the temporary variable holding the multiplication result
are of type unsigned long, so on 32bit the result is truncated to the lower
32bit.

Use u64 as type for the temporary variable and cast tsc_khz to it before
multiplying.

[ tglx: Massaged changelog and removed pointless braces ]

[ tglx: Backport to stable. Due to massive code changes is the upstream
  	commit not applicable anymore. The issue has gone unnoticed in
  	kernels pre 4.19 because the bogus LPJ value gets fixed up in a
  	later stage of early boot, but it still might cause subtle and hard
  	to debug issues between these two points. ]

Fixes: cf7a63ef4e02 ("x86/tsc: Calibrate tsc only once")
Signed-off-by: Chuanhua Lei <chuanhua.lei@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: yixin.zhu@linux.intel.com
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Len Brown <len.brown@intel.com>
Cc: Pavel Tatashin <pasha.tatashin@microsoft.com>
Cc: Rajvi Jingar <rajvi.jingar@intel.com>
Cc: Dou Liyang <douly.fnst@cn.fujitsu.com>
Link: https://lkml.kernel.org/r/1536228203-18701-1-git-send-email-chuanhua.lei@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

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


