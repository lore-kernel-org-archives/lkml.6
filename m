Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 444A1C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 06:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDDE7241A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 06:52:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDDE7241A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753042AbeGEGwP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 02:52:15 -0400
Received: from mga17.intel.com ([192.55.52.151]:22477 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751609AbeGEGwN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 02:52:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jul 2018 23:52:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,311,1526367600"; 
   d="scan'208";a="237967152"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by orsmga005.jf.intel.com with ESMTP; 04 Jul 2018 23:52:12 -0700
Received: from fmsmsx158.amr.corp.intel.com (10.18.116.75) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 4 Jul 2018 23:52:12 -0700
Received: from shsmsx104.ccr.corp.intel.com (10.239.4.70) by
 fmsmsx158.amr.corp.intel.com (10.18.116.75) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 4 Jul 2018 23:52:12 -0700
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.57]) by
 SHSMSX104.ccr.corp.intel.com ([169.254.5.81]) with mapi id 14.03.0319.002;
 Thu, 5 Jul 2018 14:52:10 +0800
From:   "Tian, Baofeng" <baofeng.tian@intel.com>
To:     "'tglx@linutronix.de'" <tglx@linutronix.de>,
        "'mingo@redhat.com'" <mingo@redhat.com>,
        "'hpa@zytor.com'" <hpa@zytor.com>,
        "'x86@kernel.org'" <x86@kernel.org>,
        "'rostedt@goodmis.org'" <rostedt@goodmis.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Debug: Add cpu registers dump in case of kernel panic
Thread-Topic: [PATCH] Debug: Add cpu registers dump in case of kernel panic
Thread-Index: AdQRnRkBDw5KvJbBS9yHsZ4vuyGuCAAAJL4QAKO0fYA=
Date:   Thu, 5 Jul 2018 06:52:09 +0000
Message-ID: <EEBA739CCF11FE49B73E1FB4690F5EE649E29D94@SHSMSX101.ccr.corp.intel.com>
References: <0038B620BAC72941BCBF48AEB892976C02CADD3F@shsmsx102.ccr.corp.intel.com>
 <EEBA739CCF11FE49B73E1FB4690F5EE649E1B316@shsmsx102.ccr.corp.intel.com>
In-Reply-To: <EEBA739CCF11FE49B73E1FB4690F5EE649E1B316@shsmsx102.ccr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNTkzNDE5ZDQtYjU2ZC00YWRiLWI4YTItNjJhZGM5YzA3YjM3IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiVGlDeSs5Q0FSTWxUSXdQMHRPdUVPZDVYSFpESFAxSHJVbktsWFEyTnRBc245K25oSjB5VXR0eFMyTlhcL3EyUEwifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resubmit again for review, this patch save register and used for RAM dump.

Ramdump is an debug feature used to analysis complex panic/hang issues, it will recover all the data after pull the RAM to host and use an host tool to decode and analysis the RAM.

Thanks
Tim

From: Tian, Baofeng 
Sent: Monday, July 2, 2018 8:46 AM
To: tglx@linutronix.de; mingo@redhat.com; hpa@zytor.com; x86@kernel.org; rostedt@goodmis.org; linux-kernel@vger.kernel.org
Subject: [PATCH] Debug: Add cpu registers dump in case of kernel panic

From: "Tian, Baofeng" <baofeng.tian@intel.com>
Subject: [PATCH] Debug: Add cpu registers dump in case of kernel panic

When kernel panic, the value of cpu registers are needed
for analyzing, through whole ramdump to restore the crash
point.

We store CPU registers to RAM before cpu stopped, then get
them with whole ram dump after warm reset.Those registers
are used in analysis of dumped RAM image.

Signed-off-by: Baofeng, Tian <baofeng.tian@intel.com>
Signed-off-by: Emmanuel Berthier <emmanuel.berthier@intel.com>
---
 arch/x86/kernel/smp.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/smp.c b/arch/x86/kernel/smp.c
index 5c574df..484831d 100644
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -117,6 +117,20 @@
 static atomic_t stopping_cpu = ATOMIC_INIT(-1);
 static bool smp_no_nmi_ipi = false;
 
+static DEFINE_PER_CPU(struct pt_regs, cpu_regs);
+
+/* Store regs of this CPU for RAM dump decoding help */
+static inline void store_regs(struct pt_regs *regs)
+{
+     struct pt_regs *print_regs;
+
+     print_regs = &get_cpu_var(cpu_regs);
+     crash_setup_regs(print_regs, regs);
+
+     /* Flush CPU cache */
+     wbinvd();
+}
+
 /*
  * this function sends a 'reschedule' IPI to another CPU.
  * it goes straight through and wastes no time serializing
@@ -163,6 +177,7 @@ static int smp_stop_nmi_callback(unsigned int val, struct pt_regs *regs)
      if (raw_smp_processor_id() == atomic_read(&stopping_cpu))
            return NMI_HANDLED;
 
+     store_regs(regs);
      cpu_emergency_vmxoff();
      stop_this_cpu(NULL);
 
@@ -173,9 +188,10 @@ static int smp_stop_nmi_callback(unsigned int val, struct pt_regs *regs)
  * this function calls the 'stop' function on all other CPUs in the system.
  */
 
-asmlinkage __visible void smp_reboot_interrupt(void)
+__visible void smp_reboot_interrupt(struct pt_regs *regs)
 {
      ipi_entering_ack_irq();
+     store_regs(regs);
      cpu_emergency_vmxoff();
      stop_this_cpu(NULL);
      irq_exit();
@@ -247,6 +263,7 @@ static void native_stop_other_cpus(int wait)
      }
 
 finish:
+     store_regs(NULL);
      local_irq_save(flags);
      disable_local_APIC();
      mcheck_cpu_clear(this_cpu_ptr(&cpu_info));
-- 
2.7.4

