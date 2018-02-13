Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932976AbeBMAYa (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 19:24:30 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:55655 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932743AbeBMAY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 19:24:28 -0500
X-Google-Smtp-Source: AH8x225+nmKgJwGJUY3hQTgw64Szxs6BP14wPGiDFMj3aTFvWCReknTxkMiClCM4vpiem7hrcHD8XA==
Date: Mon, 12 Feb 2018 16:24:25 -0800 (PST)
From: David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Andrew Morton <akpm@linux-foundation.org>
cc: Jonathan Corbet <corbet@lwn.net>, Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org
Subject: [patch 1/2] mm, page_alloc: extend kernelcore and movablecore for
 percent
Message-ID: <alpine.DEB.2.10.1802121622470.179479@chino.kir.corp.google.com>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both kernelcore= and movablecore= can be used to define the amount of
ZONE_NORMAL and ZONE_MOVABLE on a system, respectively.  This requires
the system memory capacity to be known when specifying the command line,
however.

This introduces the ability to define both kernelcore= and movablecore=
as a percentage of total system memory.  This is convenient for systems
software that wants to define the amount of ZONE_MOVABLE, for example, as
a proportion of a system's memory rather than a hardcoded byte value.

To define the percentage, the final character of the parameter should be
a '%'.

Signed-off-by: David Rientjes <rientjes@google.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 44 ++++++++++++-------------
 mm/page_alloc.c                                 | 43 +++++++++++++++++++-----
 2 files changed, 57 insertions(+), 30 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1825,30 +1825,30 @@
 	keepinitrd	[HW,ARM]
 
 	kernelcore=	[KNL,X86,IA-64,PPC]
-			Format: nn[KMGTPE] | "mirror"
-			This parameter
-			specifies the amount of memory usable by the kernel
-			for non-movable allocations.  The requested amount is
-			spread evenly throughout all nodes in the system. The
-			remaining memory in each node is used for Movable
-			pages. In the event, a node is too small to have both
-			kernelcore and Movable pages, kernelcore pages will
-			take priority and other nodes will have a larger number
-			of Movable pages.  The Movable zone is used for the
-			allocation of pages that may be reclaimed or moved
-			by the page migration subsystem.  This means that
-			HugeTLB pages may not be allocated from this zone.
-			Note that allocations like PTEs-from-HighMem still
-			use the HighMem zone if it exists, and the Normal
-			zone if it does not.
-
-			Instead of specifying the amount of memory (nn[KMGTPE]),
-			you can specify "mirror" option. In case "mirror"
+			Format: nn[KMGTPE] | nn% | "mirror"
+			This parameter specifies the amount of memory usable by
+			the kernel for non-movable allocations.  The requested
+			amount is spread evenly throughout all nodes in the
+			system as ZONE_NORMAL.  The remaining memory is used for
+			movable memory in its own zone, ZONE_MOVABLE.  In the
+			event, a node is too small to have both ZONE_NORMAL and
+			ZONE_MOVABLE, kernelcore memory will take priority and
+			other nodes will have a larger ZONE_MOVABLE.
+
+			ZONE_MOVABLE is used for the allocation of pages that
+			may be reclaimed or moved by the page migration
+			subsystem.  This means that HugeTLB pages may not be
+			allocated from this zone.  Note that allocations like
+			PTEs-from-HighMem still use the HighMem zone if it
+			exists, and the Normal zone if it does not.
+
+			It is possible to specify the exact amount of memory in
+			the form of "nn[KMGTPE]", a percentage of total system
+			memory in the form of "nn%", or "mirror".  If "mirror"
 			option is specified, mirrored (reliable) memory is used
 			for non-movable allocations and remaining memory is used
-			for Movable pages. nn[KMGTPE] and "mirror" are exclusive,
-			so you can NOT specify nn[KMGTPE] and "mirror" at the same
-			time.
+			for Movable pages.  "nn[KMGTPE]", "nn%", and "mirror"
+			are exclusive, so you cannot specify multiple forms.
 
 	kgdbdbgp=	[KGDB,HW] kgdb over EHCI usb debug port.
 			Format: <Controller#>[,poll interval]
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -272,7 +272,9 @@ static unsigned long __meminitdata dma_reserve;
 static unsigned long __meminitdata arch_zone_lowest_possible_pfn[MAX_NR_ZONES];
 static unsigned long __meminitdata arch_zone_highest_possible_pfn[MAX_NR_ZONES];
 static unsigned long __initdata required_kernelcore;
+static unsigned long required_kernelcore_percent __initdata;
 static unsigned long __initdata required_movablecore;
+static unsigned long required_movablecore_percent __initdata;
 static unsigned long __meminitdata zone_movable_pfn[MAX_NUMNODES];
 static bool mirrored_kernelcore;
 
@@ -6477,7 +6479,18 @@ static void __init find_zone_movable_pfns_for_nodes(void)
 	}
 
 	/*
-	 * If movablecore=nn[KMG] was specified, calculate what size of
+	 * If kernelcore=nn% or movablecore=nn% was specified, calculate the
+	 * amount of necessary memory.
+	 */
+	if (required_kernelcore_percent)
+		required_kernelcore = (totalpages * 100 * required_kernelcore_percent) /
+				       10000UL;
+	if (required_movablecore_percent)
+		required_movablecore = (totalpages * 100 * required_movablecore_percent) /
+					10000UL;
+
+	/*
+	 * If movablecore= was specified, calculate what size of
 	 * kernelcore that corresponds so that memory usable for
 	 * any allocation type is evenly spread. If both kernelcore
 	 * and movablecore are specified, then the value of kernelcore
@@ -6717,18 +6730,30 @@ void __init free_area_init_nodes(unsigned long *max_zone_pfn)
 	zero_resv_unavail();
 }
 
-static int __init cmdline_parse_core(char *p, unsigned long *core)
+static int __init cmdline_parse_core(char *p, unsigned long *core,
+				     unsigned long *percent)
 {
 	unsigned long long coremem;
+	char *endptr;
+
 	if (!p)
 		return -EINVAL;
 
-	coremem = memparse(p, &p);
-	*core = coremem >> PAGE_SHIFT;
+	/* Value may be a percentage of total memory, otherwise bytes */
+	coremem = simple_strtoull(p, &endptr, 0);
+	if (*endptr == '%') {
+		/* Paranoid check for percent values greater than 100 */
+		WARN_ON(coremem > 100);
 
-	/* Paranoid check that UL is enough for the coremem value */
-	WARN_ON((coremem >> PAGE_SHIFT) > ULONG_MAX);
+		*percent = coremem;
+	} else {
+		coremem = memparse(p, &p);
+		/* Paranoid check that UL is enough for the coremem value */
+		WARN_ON((coremem >> PAGE_SHIFT) > ULONG_MAX);
 
+		*core = coremem >> PAGE_SHIFT;
+		*percent = 0UL;
+	}
 	return 0;
 }
 
@@ -6744,7 +6769,8 @@ static int __init cmdline_parse_kernelcore(char *p)
 		return 0;
 	}
 
-	return cmdline_parse_core(p, &required_kernelcore);
+	return cmdline_parse_core(p, &required_kernelcore,
+				  &required_kernelcore_percent);
 }
 
 /*
@@ -6753,7 +6779,8 @@ static int __init cmdline_parse_kernelcore(char *p)
  */
 static int __init cmdline_parse_movablecore(char *p)
 {
-	return cmdline_parse_core(p, &required_movablecore);
+	return cmdline_parse_core(p, &required_movablecore,
+				  &required_movablecore_percent);
 }
 
 early_param("kernelcore", cmdline_parse_kernelcore);
