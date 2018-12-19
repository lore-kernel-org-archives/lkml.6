Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56847C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 19:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 279C42080D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 19:55:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729486AbeLSTzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 14:55:05 -0500
Received: from mga05.intel.com ([192.55.52.43]:23615 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729137AbeLSTzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 14:55:04 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Dec 2018 11:55:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,373,1539673200"; 
   d="scan'208";a="111904064"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by orsmga003.jf.intel.com with ESMTP; 19 Dec 2018 11:55:03 -0800
Subject: [PATCH] x86/cpu: sort cpuinfo flags
To:     linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Wed, 19 Dec 2018 11:50:14 -0800
Message-Id: <20181219195014.A0962820@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

I frequently find myself contemplating my life choices as I try to
find 3-character entries in the 1,000-character, unsorted "flags:"
field of /proc/cpuinfo.

Sort that field, giving me hours back in my day.

This eats up ~1200 bytes (NCAPINTS*2*32) of space for the sorted
array.  I used an 'unsigned short' to use 1/4 of the space on 64-bit
that would have been needed had pointers been used in the array.

An alternatve, requiring no array, would be to do the sort at runtime,
but it seems ridiculous for a 500-cpu system to do 500 sorts for each
'cat /proc/cpuinfo'.

Another would be to just cache the *string* that results from this,
which would be even faster at runtime because it could do a single
seq_printf() and would consume less space.  But, that would
require a bit more infrastructure to make sure that the produced
string never changed and was consistent across all CPUs, unless
we want to store a string per 'struct cpuinfo_x86'.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Jia Zhang <qianyue.zj@alibaba-inc.com>
Cc: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Cc: linux-kernel@vger.kernel.org
---

 b/arch/x86/kernel/cpu/proc.c |   80 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 74 insertions(+), 6 deletions(-)

diff -puN arch/x86/kernel/cpu/proc.c~x86-sorted-flags arch/x86/kernel/cpu/proc.c
--- a/arch/x86/kernel/cpu/proc.c~x86-sorted-flags	2018-12-19 11:48:46.562987402 -0800
+++ b/arch/x86/kernel/cpu/proc.c	2018-12-19 11:48:46.567987402 -0800
@@ -1,8 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/smp.h>
+#include <linux/sort.h>
 #include <linux/timex.h>
 #include <linux/string.h>
 #include <linux/seq_file.h>
+#include <linux/spinlock.h>
 #include <linux/cpufreq.h>
 
 #include "cpu.h"
@@ -54,6 +56,76 @@ static void show_cpuinfo_misc(struct seq
 }
 #endif
 
+#define X86_NR_CAPS	(32*NCAPINTS)
+/*
+ * x86_cap_flags[] is an array of string pointers.  This
+ * (x86_sorted_cap_flags[]) is an array of array indexes
+ * *referring* to x86_cap_flags[] entries.  It is sorted
+ * to make it quick to print a sorted list of cpu flags in
+ * /proc/cpuinfo.
+ */
+static unsigned short x86_sorted_cap_flags[X86_NR_CAPS] = { -1, };
+static int x86_cmp_cap(const void *a_ptr, const void *b_ptr)
+{
+	unsigned short a = *(unsigned short *)a_ptr;
+	unsigned short b = *(unsigned short *)b_ptr;
+
+	/* Don't need to swap equal entries (presumably NULLs) */
+	if (x86_cap_flags[a] == x86_cap_flags[b])
+		return 0;
+	/* Put NULL elements at the end: */
+	if (x86_cap_flags[a] == NULL)
+		return -1;
+	if (x86_cap_flags[b] == NULL)
+		return 1;
+
+	return strcmp(x86_cap_flags[a], x86_cap_flags[b]);
+}
+
+static void x86_sort_cap_flags(void)
+{
+	static DEFINE_SPINLOCK(lock);
+	int i;
+
+	/*
+	 * It's possible that multiple threads could race
+	 * to here and both sort the list.  The lock keeps
+	 * them from trying to sort concurrently.
+	 */
+	spin_lock(&lock);
+
+	/* Initialize the list with 0->i, removing the -1's: */
+	for (i = 0; i < X86_NR_CAPS; i++)
+		x86_sorted_cap_flags[i] = i;
+
+	sort(x86_sorted_cap_flags, X86_NR_CAPS,
+	     sizeof(x86_sorted_cap_flags[0]),
+	     x86_cmp_cap, NULL);
+
+	spin_unlock(&lock);
+}
+
+static void show_cpuinfo_flags(struct seq_file *m, struct cpuinfo_x86 *c)
+{
+	int i;
+
+	if (x86_sorted_cap_flags[0] == (unsigned short)-1)
+		x86_sort_cap_flags();
+
+	seq_puts(m, "flags\t\t:");
+
+	for (i = 0; i < X86_NR_CAPS; i++) {
+		/*
+		 * Go through the flag list in alphabetical
+		 * order to make reading this field easier.
+		 */
+		int cap = x86_sorted_cap_flags[i];
+
+		if (cpu_has(c, cap) && x86_cap_flags[cap] != NULL)
+			seq_printf(m, " %s", x86_cap_flags[cap]);
+	}
+}
+
 static int show_cpuinfo(struct seq_file *m, void *v)
 {
 	struct cpuinfo_x86 *c = v;
@@ -96,15 +168,11 @@ static int show_cpuinfo(struct seq_file
 
 	show_cpuinfo_core(m, c, cpu);
 	show_cpuinfo_misc(m, c);
-
-	seq_puts(m, "flags\t\t:");
-	for (i = 0; i < 32*NCAPINTS; i++)
-		if (cpu_has(c, i) && x86_cap_flags[i] != NULL)
-			seq_printf(m, " %s", x86_cap_flags[i]);
+	show_cpuinfo_flags(m, c);
 
 	seq_puts(m, "\nbugs\t\t:");
 	for (i = 0; i < 32*NBUGINTS; i++) {
-		unsigned int bug_bit = 32*NCAPINTS + i;
+		unsigned int bug_bit = x86_NR_CAPS + i;
 
 		if (cpu_has_bug(c, bug_bit) && x86_bug_flags[i])
 			seq_printf(m, " %s", x86_bug_flags[i]);
_
