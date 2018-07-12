Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF6CC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 10:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55CB820C0C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 10:15:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55CB820C0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbeGLKYa convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 06:24:30 -0400
Received: from mga09.intel.com ([134.134.136.24]:43590 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726534AbeGLKYa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 06:24:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jul 2018 03:15:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,342,1526367600"; 
   d="scan'208";a="53823334"
Received: from irsmsx110.ger.corp.intel.com ([163.33.3.25])
  by fmsmga007.fm.intel.com with ESMTP; 12 Jul 2018 03:15:33 -0700
Received: from irsmsx104.ger.corp.intel.com ([169.254.5.225]) by
 irsmsx110.ger.corp.intel.com ([169.254.15.197]) with mapi id 14.03.0319.002;
 Thu, 12 Jul 2018 11:15:32 +0100
From:   "Metzger, Markus T" <markus.t.metzger@intel.com>
To:     Hugh Dickins <hughd@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     "Shishkin, Alexander" <alexander.shishkin@intel.com>,
        "Kleen, Andi" <andi.kleen@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [bug] kpti, perf_event, bts: sporadic truncated trace
Thread-Topic: [bug] kpti, perf_event, bts: sporadic truncated trace
Thread-Index: AdQZxQrLJqR+Gl12Q6mi7nedU16ktA==
Date:   Thu, 12 Jul 2018 10:15:32 +0000
Message-ID: <A78C989F6D9628469189715575E55B236B330102@IRSMSX104.ger.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZDU3MDViOTgtNGQ4NS00MDM4LWJkMmMtOTE5MzdmOTQzMzUzIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoianRCY1BLcmtYVWE0K3pDamI3Q2JMOHpCWlpYc0I4YzJmbGE2ZjJqSmhvYmVyUFRJXC9MMGpocDVuN0NWdTdXM00ifQ==
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [163.33.239.180]
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Starting with 4.15 I noticed that BTS is sporadically missing the tail
of the trace in the perf_event data buffer.  It shows as

    [decode error (1): instruction overflow]

in GDB.  Chances to see this are higher the longer the debuggee is
running.  With this [1] tiny patch to one of GDB's tests, I am able to
reproduce it reliably on my box.  To run the test, use:

    $ make -s check RUNTESTFLAGS="gdb.btrace/exception.exp"

from the gdb/ sub-directory in the GDB build directory.

The issue remains when I use 'nopti' on the kernel command-line.


Bisecting yielded commit

    c1961a4 x86/events/intel/ds: Map debug buffers in cpu_entry_area

I reverted the commit on top of v4.17 [2] and the issue disappears
when I use 'nopti' on the kernel command-line.

regards,
markus.


[1]
diff --git a/gdb/testsuite/gdb.btrace/exception.exp b/gdb/testsuite/gdb.btrace/exception.exp
index 9408d61..a24ddd3 100755
--- a/gdb/testsuite/gdb.btrace/exception.exp
+++ b/gdb/testsuite/gdb.btrace/exception.exp
@@ -36,16 +36,12 @@ if ![runto_main] {
 gdb_test_no_output "set record function-call-history-size 0"
 
 # set bp
-set bp_1 [gdb_get_line_number "bp.1" $srcfile]
 set bp_2 [gdb_get_line_number "bp.2" $srcfile]
-gdb_breakpoint $bp_1
 gdb_breakpoint $bp_2
 
-# trace the code between the two breakpoints
-gdb_continue_to_breakpoint "cont to bp.1" ".*$srcfile:$bp_1\r\n.*"
 # increase the BTS buffer size - the trace can be quite big
-gdb_test_no_output "set record btrace bts buffer-size 128000"
-gdb_test_no_output "record btrace"
+gdb_test_no_output "set record btrace bts buffer-size 1024000"
+gdb_test_no_output "record btrace bts"
 gdb_continue_to_breakpoint "cont to bp.2" ".*$srcfile:$bp_2\r\n.*"
 
 # show the flat branch trace


[2]
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 8a10a045b57b..46381f73c595 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -3,7 +3,6 @@
 #include <linux/types.h>
 #include <linux/slab.h>
 
-#include <asm/cpu_entry_area.h>
 #include <asm/perf_event.h>
 #include <asm/tlbflush.h>
 #include <asm/insn.h>
@@ -282,67 +281,17 @@ void fini_debug_store_on_cpu(int cpu)
 
 static DEFINE_PER_CPU(void *, insn_buffer);
 
-static void ds_update_cea(void *cea, void *addr, size_t size, pgprot_t prot)
-{
-	unsigned long start = (unsigned long)cea;
-	phys_addr_t pa;
-	size_t msz = 0;
-
-	pa = virt_to_phys(addr);
-
-	preempt_disable();
-	for (; msz < size; msz += PAGE_SIZE, pa += PAGE_SIZE, cea += PAGE_SIZE)
-		cea_set_pte(cea, pa, prot);
-
-	/*
-	 * This is a cross-CPU update of the cpu_entry_area, we must shoot down
-	 * all TLB entries for it.
-	 */
-	flush_tlb_kernel_range(start, start + size);
-	preempt_enable();
-}
-
-static void ds_clear_cea(void *cea, size_t size)
-{
-	unsigned long start = (unsigned long)cea;
-	size_t msz = 0;
-
-	preempt_disable();
-	for (; msz < size; msz += PAGE_SIZE, cea += PAGE_SIZE)
-		cea_set_pte(cea, 0, PAGE_NONE);
-
-	flush_tlb_kernel_range(start, start + size);
-	preempt_enable();
-}
-
-static void *dsalloc_pages(size_t size, gfp_t flags, int cpu)
-{
-	unsigned int order = get_order(size);
-	int node = cpu_to_node(cpu);
-	struct page *page;
-
-	page = __alloc_pages_node(node, flags | __GFP_ZERO, order);
-	return page ? page_address(page) : NULL;
-}
-
-static void dsfree_pages(const void *buffer, size_t size)
-{
-	if (buffer)
-		free_pages((unsigned long)buffer, get_order(size));
-}
-
 static int alloc_pebs_buffer(int cpu)
 {
-	struct cpu_hw_events *hwev = per_cpu_ptr(&cpu_hw_events, cpu);
-	struct debug_store *ds = hwev->ds;
-	size_t bsiz = x86_pmu.pebs_buffer_size;
-	int max, node = cpu_to_node(cpu);
-	void *buffer, *ibuffer, *cea;
+	struct debug_store *ds = per_cpu(cpu_hw_events, cpu).ds;
+	int node = cpu_to_node(cpu);
+	int max;
+	void *buffer, *ibuffer;
 
 	if (!x86_pmu.pebs)
 		return 0;
 
-	buffer = dsalloc_pages(bsiz, GFP_KERNEL, cpu);
+	buffer = kzalloc_node(x86_pmu.pebs_buffer_size, GFP_KERNEL, node);
 	if (unlikely(!buffer))
 		return -ENOMEM;
 
@@ -353,94 +302,99 @@ static int alloc_pebs_buffer(int cpu)
 	if (x86_pmu.intel_cap.pebs_format < 2) {
 		ibuffer = kzalloc_node(PEBS_FIXUP_SIZE, GFP_KERNEL, node);
 		if (!ibuffer) {
-			dsfree_pages(buffer, bsiz);
+			kfree(buffer);
 			return -ENOMEM;
 		}
 		per_cpu(insn_buffer, cpu) = ibuffer;
 	}
-	hwev->ds_pebs_vaddr = buffer;
-	/* Update the cpu entry area mapping */
-	cea = &get_cpu_entry_area(cpu)->cpu_debug_buffers.pebs_buffer;
-	ds->pebs_buffer_base = (unsigned long) cea;
-	ds_update_cea(cea, buffer, bsiz, PAGE_KERNEL);
+
+	max = x86_pmu.pebs_buffer_size / x86_pmu.pebs_record_size;
+
+	ds->pebs_buffer_base = (u64)(unsigned long)buffer;
 	ds->pebs_index = ds->pebs_buffer_base;
-	max = x86_pmu.pebs_record_size * (bsiz / x86_pmu.pebs_record_size);
-	ds->pebs_absolute_maximum = ds->pebs_buffer_base + max;
+	ds->pebs_absolute_maximum = ds->pebs_buffer_base +
+		max * x86_pmu.pebs_record_size;
+
 	return 0;
 }
 
 static void release_pebs_buffer(int cpu)
 {
-	struct cpu_hw_events *hwev = per_cpu_ptr(&cpu_hw_events, cpu);
-	void *cea;
+	struct debug_store *ds = per_cpu(cpu_hw_events, cpu).ds;
 
-	if (!x86_pmu.pebs)
+	if (!ds || !x86_pmu.pebs)
 		return;
 
 	kfree(per_cpu(insn_buffer, cpu));
 	per_cpu(insn_buffer, cpu) = NULL;
 
-	/* Clear the fixmap */
-	cea = &get_cpu_entry_area(cpu)->cpu_debug_buffers.pebs_buffer;
-	ds_clear_cea(cea, x86_pmu.pebs_buffer_size);
-	dsfree_pages(hwev->ds_pebs_vaddr, x86_pmu.pebs_buffer_size);
-	hwev->ds_pebs_vaddr = NULL;
+	kfree((void *)(unsigned long)ds->pebs_buffer_base);
+	ds->pebs_buffer_base = 0;
 }
 
 static int alloc_bts_buffer(int cpu)
 {
-	struct cpu_hw_events *hwev = per_cpu_ptr(&cpu_hw_events, cpu);
-	struct debug_store *ds = hwev->ds;
-	void *buffer, *cea;
-	int max;
+	struct debug_store *ds = per_cpu(cpu_hw_events, cpu).ds;
+	int node = cpu_to_node(cpu);
+	int max, thresh;
+	void *buffer;
 
 	if (!x86_pmu.bts)
 		return 0;
 
-	buffer = dsalloc_pages(BTS_BUFFER_SIZE, GFP_KERNEL | __GFP_NOWARN, cpu);
+	buffer = kzalloc_node(BTS_BUFFER_SIZE, GFP_KERNEL | __GFP_NOWARN, node);
 	if (unlikely(!buffer)) {
 		WARN_ONCE(1, "%s: BTS buffer allocation failure\n", __func__);
 		return -ENOMEM;
 	}
-	hwev->ds_bts_vaddr = buffer;
-	/* Update the fixmap */
-	cea = &get_cpu_entry_area(cpu)->cpu_debug_buffers.bts_buffer;
-	ds->bts_buffer_base = (unsigned long) cea;
-	ds_update_cea(cea, buffer, BTS_BUFFER_SIZE, PAGE_KERNEL);
+
+	max = BTS_BUFFER_SIZE / BTS_RECORD_SIZE;
+	thresh = max / 16;
+
+	ds->bts_buffer_base = (u64)(unsigned long)buffer;
 	ds->bts_index = ds->bts_buffer_base;
-	max = BTS_RECORD_SIZE * (BTS_BUFFER_SIZE / BTS_RECORD_SIZE);
-	ds->bts_absolute_maximum = ds->bts_buffer_base + max;
-	ds->bts_interrupt_threshold = ds->bts_absolute_maximum - (max / 16);
+	ds->bts_absolute_maximum = ds->bts_buffer_base +
+		max * BTS_RECORD_SIZE;
+	ds->bts_interrupt_threshold = ds->bts_absolute_maximum -
+		thresh * BTS_RECORD_SIZE;
+
 	return 0;
 }
 
 static void release_bts_buffer(int cpu)
 {
-	struct cpu_hw_events *hwev = per_cpu_ptr(&cpu_hw_events, cpu);
-	void *cea;
+	struct debug_store *ds = per_cpu(cpu_hw_events, cpu).ds;
 
-	if (!x86_pmu.bts)
+	if (!ds || !x86_pmu.bts)
 		return;
 
-	/* Clear the fixmap */
-	cea = &get_cpu_entry_area(cpu)->cpu_debug_buffers.bts_buffer;
-	ds_clear_cea(cea, BTS_BUFFER_SIZE);
-	dsfree_pages(hwev->ds_bts_vaddr, BTS_BUFFER_SIZE);
-	hwev->ds_bts_vaddr = NULL;
+	kfree((void *)(unsigned long)ds->bts_buffer_base);
+	ds->bts_buffer_base = 0;
 }
 
 static int alloc_ds_buffer(int cpu)
 {
-	struct debug_store *ds = &get_cpu_entry_area(cpu)->cpu_debug_store;
+	int node = cpu_to_node(cpu);
+	struct debug_store *ds;
+
+	ds = kzalloc_node(sizeof(*ds), GFP_KERNEL, node);
+	if (unlikely(!ds))
+		return -ENOMEM;
 
-	memset(ds, 0, sizeof(*ds));
 	per_cpu(cpu_hw_events, cpu).ds = ds;
+
 	return 0;
 }
 
 static void release_ds_buffer(int cpu)
 {
+	struct debug_store *ds = per_cpu(cpu_hw_events, cpu).ds;
+
+	if (!ds)
+		return;
+
 	per_cpu(cpu_hw_events, cpu).ds = NULL;
+	kfree(ds);
 }
 
 void release_ds_buffers(void)
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 9f3711470ec1..4eb9c12915e4 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -200,8 +200,6 @@ struct cpu_hw_events {
 	 * Intel DebugStore bits
 	 */
 	struct debug_store	*ds;
-	void			*ds_pebs_vaddr;
-	void			*ds_bts_vaddr;
 	u64			pebs_enabled;
 	int			n_pebs;
 	int			n_large_pebs;

Intel Deutschland GmbH
Registered Address: Am Campeon 10-12, 85579 Neubiberg, Germany
Tel: +49 89 99 8853-0, www.intel.de
Managing Directors: Christin Eisenschmid, Christian Lamprechter
Chairperson of the Supervisory Board: Nicole Lau
Registered Office: Munich
Commercial Register: Amtsgericht Muenchen HRB 186928

