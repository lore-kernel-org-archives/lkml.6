Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F5EC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 17:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45BAA20684
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 17:59:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45BAA20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbeJCAoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 20:44:15 -0400
Received: from relay2.sgi.com ([192.48.180.65]:60103 "EHLO relay.sgi.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726305AbeJCAoP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 20:44:15 -0400
Received: from stormcage.americas.sgi.com (stormcage.americas.sgi.com [128.162.236.70])
        by relay2.corp.sgi.com (Postfix) with ESMTP id E9190304043;
        Tue,  2 Oct 2018 10:59:40 -0700 (PDT)
Received: by stormcage.americas.sgi.com (Postfix, from userid 5508)
        id 08AFE20160707; Tue,  2 Oct 2018 13:01:45 -0500 (CDT)
Message-Id: <20181002180144.923579706@stormcage.americas.sgi.com>
References: <20181002180144.636925675@stormcage.americas.sgi.com>
User-Agent: quilt/0.46-1
Date:   Tue, 02 Oct 2018 13:01:46 -0500
From:   Mike Travis <mike.travis@hpe.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Hedi Berriche <hedi.berriche@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Borislav Petkov <bp@alien8.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Len Brown <len.brown@intel.com>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>,
        Xiaoming Gao <gxm.linux.kernel@gmail.com>,
        Rajvi Jingar <rajvi.jingar@intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH 2/2] x86/tsc: Fix UV TSC initialization
Content-Disposition: inline; filename=fix_tsc_early_init
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix regression introduced by

commit cf7a63ef4e02 ("x86/tsc: Calibrate tsc only once")

as it added a call to tsc_early_init() which initializes the TSC ADJUST
values before acpi_boot_table_init().  In the case of UV systems,
that is a necessary step thats calls uv_system_init().  This informs
tsc_sanitize_first_cpu() that we're on a platform with async TSC resets
as documented in

commit 341102c3ef29 ("x86/tsc: Add option that TSC on Socket 0 being non-zero is valid")

Fix by skipping the early tsc initialization on UV systems and let TSC
init tests take place later in tsc_init().

Fixes: cf7a63ef4e02 ("x86/tsc: Calibrate tsc only once") 
Signed-off-by: Mike Travis <mike.travis@hpe.com>
Suggested-by: Hedi Berriche <hedi.berriche@hpe.com>
Reviewed-by: Russ Anderson <rja@hpe.com>
Reviewed-by: Dimitri Sivanich <sivanich@hpe.com>
---
 arch/x86/kernel/tsc.c |    4 ++++
 1 file changed, 4 insertions(+)

--- linux.orig/arch/x86/kernel/tsc.c
+++ linux/arch/x86/kernel/tsc.c
@@ -26,6 +26,7 @@
 #include <asm/apic.h>
 #include <asm/intel-family.h>
 #include <asm/i8259.h>
+#include <asm/uv/uv.h>
 
 unsigned int __read_mostly cpu_khz;	/* TSC clocks / usec, not used here */
 EXPORT_SYMBOL(cpu_khz);
@@ -1433,6 +1434,9 @@ void __init tsc_early_init(void)
 {
 	if (!boot_cpu_has(X86_FEATURE_TSC))
 		return;
+	/* Don't change UV TSC multi-chassis synchronization */
+	if (is_early_uv_system())
+		return;
 	if (!determine_cpu_tsc_frequencies(true))
 		return;
 	loops_per_jiffy = get_loops_per_jiffy();

-- 
