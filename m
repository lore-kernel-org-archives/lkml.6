Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 220D7C64EB9
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 19:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E148B206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 19:35:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E148B206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbeJCCTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 22:19:55 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49691 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbeJCCTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 22:19:54 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w92JYQEA2076649
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 2 Oct 2018 12:34:26 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w92JYQUO2076646;
        Tue, 2 Oct 2018 12:34:26 -0700
Date:   Tue, 2 Oct 2018 12:34:26 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mike Travis <tipbot@zytor.com>
Message-ID: <tip-2647c43c7f3ba4b752bfce261d53b16e2f5bc9e3@git.kernel.org>
Cc:     mingo@kernel.org, peterz@infradead.org, rajvi.jingar@intel.com,
        douly.fnst@cn.fujitsu.com, mike.travis@hpe.com,
        len.brown@intel.com, gxm.linux.kernel@gmail.com,
        pasha.tatashin@oracle.com, linux-kernel@vger.kernel.org,
        kstewart@linuxfoundation.org, sivanich@hpe.com,
        russ.anderson@hpe.com, dimitri.sivanich@hpe.com,
        tglx@linutronix.de, hpa@zytor.com, pombredanne@nexb.com,
        bp@alien8.de, hedi.berriche@hpe.com, gregkh@linuxfoundation.org,
        rja@hpe.com
Reply-To: kstewart@linuxfoundation.org, pasha.tatashin@oracle.com,
          linux-kernel@vger.kernel.org, len.brown@intel.com,
          gxm.linux.kernel@gmail.com, mike.travis@hpe.com,
          rajvi.jingar@intel.com, douly.fnst@cn.fujitsu.com,
          peterz@infradead.org, mingo@kernel.org, sivanich@hpe.com,
          hpa@zytor.com, dimitri.sivanich@hpe.com, tglx@linutronix.de,
          russ.anderson@hpe.com, rja@hpe.com, gregkh@linuxfoundation.org,
          hedi.berriche@hpe.com, bp@alien8.de, pombredanne@nexb.com
In-Reply-To: <20181002180144.923579706@stormcage.americas.sgi.com>
References: <20181002180144.923579706@stormcage.americas.sgi.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/tsc: Fix UV TSC initialization
Git-Commit-ID: 2647c43c7f3ba4b752bfce261d53b16e2f5bc9e3
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  2647c43c7f3ba4b752bfce261d53b16e2f5bc9e3
Gitweb:     https://git.kernel.org/tip/2647c43c7f3ba4b752bfce261d53b16e2f5bc9e3
Author:     Mike Travis <mike.travis@hpe.com>
AuthorDate: Tue, 2 Oct 2018 13:01:46 -0500
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 2 Oct 2018 21:29:16 +0200

x86/tsc: Fix UV TSC initialization

The recent rework of the TSC calibration code introduced a regression on UV
systems as it added a call to tsc_early_init() which initializes the TSC
ADJUST values before acpi_boot_table_init().  In the case of UV systems,
that is a necessary step that calls uv_system_init().  This informs
tsc_sanitize_first_cpu() that the kernel runs on a platform with async TSC
resets as documented in commit 341102c3ef29 ("x86/tsc: Add option that TSC
on Socket 0 being non-zero is valid")

Fix it by skipping the early tsc initialization on UV systems and let TSC
init tests take place later in tsc_init().

Fixes: cf7a63ef4e02 ("x86/tsc: Calibrate tsc only once")
Suggested-by: Hedi Berriche <hedi.berriche@hpe.com>
Signed-off-by: Mike Travis <mike.travis@hpe.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Russ Anderson <rja@hpe.com>
Reviewed-by: Dimitri Sivanich <sivanich@hpe.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Russ Anderson <russ.anderson@hpe.com>
Cc: Dimitri Sivanich <dimitri.sivanich@hpe.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Len Brown <len.brown@intel.com>
Cc: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: Xiaoming Gao <gxm.linux.kernel@gmail.com>
Cc: Rajvi Jingar <rajvi.jingar@intel.com>
Link: https://lkml.kernel.org/r/20181002180144.923579706@stormcage.americas.sgi.com

---
 arch/x86/kernel/tsc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 6490f618e096..b52bd2b6cdb4 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
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
