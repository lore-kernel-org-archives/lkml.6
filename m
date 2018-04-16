Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AIpwx4/zQBwd86X+SFF+/jsFv0xaO3MwsDWyFJiOuoagtJHeSBmk61ElCfToWUqhyuojY5L2bt+7
ARC-Seal: i=1; a=rsa-sha256; t=1523839401; cv=none;
        d=google.com; s=arc-20160816;
        b=rIO5l07DGlJdXtJ1WY5nlmTmTR4qEK/6U6js1aGUc80w/XuN3dLl4epJ7ZFxX7q4Uz
         bIOI5xifu+MM1YTwFbxxazySOdhJ8xaNczL11sY85AMgznB8oqneh7ka/OADKRmnUmEX
         gOvFG68gOQUjQvrcxymg92Qrh1Ppc8LfERdm64VkNMYkAtmupsgRGj/pz1Om6NouDEEg
         rjsvcDV8zKhnGRiJIAOlM7Wwm3E/k0LdCQhXs2qlIFmetO3QCGs9/yjlGy6WTRuvMIcZ
         0vYkX21AbjCX9s0+QEf3Ssz0+IxAT/L/eaQ91z75LrxE5VWSfpyee2YRYSSPWPfJ3pLg
         Tfsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:cc:subject:date:to:from
         :arc-authentication-results;
        bh=YQSIxon5YnGKxXypyNszR5IdIdHnPUYtsNG6LyC/kck=;
        b=xpuLO+bAT2R76DIoKGbJ4e/hj5eZLktsz7pNNEAsvEUnCCOFOaC042uZdLW9SsJpCw
         eRNHEVQFtmvU6piKB40MBhjoo8G7Nf5gYVgQ364WdsTnEL+SegPqvYBnimc/XX/1mBiE
         H8MntuRvv/Q5iRazhVyzhwGJqUSNrLJxbJ+TLZ3JZEgaNs68MgOC1cznU2OHfrZUJ4wC
         DlX1AmuJxeGicSqfzG4S9ISGxgTGFbsk1SoOey0Z9tZ4CRCqpXqQj6vV5qOUHATTjdVS
         peq7wVptRqKl2Qr19fpx3CUGtjrHnH90WfQ0gZlGNRMaGvo9zfTm7cKjfFcUPcnW3BYg
         2oPA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: Oleg Drokin <oleg.drokin@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 James Simmons <jsimmons@infradead.org>,
 Andreas Dilger <andreas.dilger@intel.com>
Date: Mon, 16 Apr 2018 10:42:37 +1000
Subject: [PATCH 3/6] staging: lustre: remove
 include/linux/libcfs/linux/linux-cpu.h
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Message-ID: <152383935737.23409.2271901486597092772.stgit@noble>
In-Reply-To: <152383910760.23409.2327082725637657049.stgit@noble>
References: <152383910760.23409.2327082725637657049.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597861424153712105?=
X-GMAIL-MSGID: =?utf-8?q?1597861424153712105?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This include file contains definitions used when CONFIG_SMP
is in effect.  Other includes contain corresponding definitions
for when it isn't.
This can be hard to follow, so move the definitions to the one place.

As HAVE_LIBCFS_CPT is defined precisely when CONFIG_SMP, we discard
that macro and just use CONFIG_SMP when needed.
---
 .../staging/lustre/include/linux/libcfs/libcfs.h   |    1 
 .../lustre/include/linux/libcfs/libcfs_cpu.h       |   33 ++++++++
 .../lustre/include/linux/libcfs/linux/linux-cpu.h  |   78 --------------------
 drivers/staging/lustre/lnet/libcfs/libcfs_cpu.c    |    4 +
 4 files changed, 35 insertions(+), 81 deletions(-)
 delete mode 100644 drivers/staging/lustre/include/linux/libcfs/linux/linux-cpu.h

diff --git a/drivers/staging/lustre/include/linux/libcfs/libcfs.h b/drivers/staging/lustre/include/linux/libcfs/libcfs.h
index e59d107d6482..aca1f19c4977 100644
--- a/drivers/staging/lustre/include/linux/libcfs/libcfs.h
+++ b/drivers/staging/lustre/include/linux/libcfs/libcfs.h
@@ -78,7 +78,6 @@
 #include <linux/timex.h>
 #include <linux/uaccess.h>
 #include <stdarg.h>
-#include <linux/libcfs/linux/linux-cpu.h>
 
 #include <linux/libcfs/libcfs_debug.h>
 #include <linux/libcfs/libcfs_private.h>
diff --git a/drivers/staging/lustre/include/linux/libcfs/libcfs_cpu.h b/drivers/staging/lustre/include/linux/libcfs/libcfs_cpu.h
index 61bce77fddd6..829c35e68db8 100644
--- a/drivers/staging/lustre/include/linux/libcfs/libcfs_cpu.h
+++ b/drivers/staging/lustre/include/linux/libcfs/libcfs_cpu.h
@@ -72,10 +72,43 @@
 #ifndef __LIBCFS_CPU_H__
 #define __LIBCFS_CPU_H__
 
+#include <linux/cpu.h>
+#include <linux/cpuset.h>
+#include <linux/topology.h>
+
 /* any CPU partition */
 #define CFS_CPT_ANY		(-1)
 
 #ifdef CONFIG_SMP
+/** virtual processing unit */
+struct cfs_cpu_partition {
+	/* CPUs mask for this partition */
+	cpumask_var_t			cpt_cpumask;
+	/* nodes mask for this partition */
+	nodemask_t			*cpt_nodemask;
+	/* spread rotor for NUMA allocator */
+	unsigned int			cpt_spread_rotor;
+};
+
+
+/** descriptor for CPU partitions */
+struct cfs_cpt_table {
+	/* version, reserved for hotplug */
+	unsigned int			ctb_version;
+	/* spread rotor for NUMA allocator */
+	unsigned int			ctb_spread_rotor;
+	/* # of CPU partitions */
+	unsigned int			ctb_nparts;
+	/* partitions tables */
+	struct cfs_cpu_partition	*ctb_parts;
+	/* shadow HW CPU to CPU partition ID */
+	int				*ctb_cpu2cpt;
+	/* all cpus in this partition table */
+	cpumask_var_t			ctb_cpumask;
+	/* all nodes in this partition table */
+	nodemask_t			*ctb_nodemask;
+};
+
 /**
  * return cpumask of CPU partition \a cpt
  */
diff --git a/drivers/staging/lustre/include/linux/libcfs/linux/linux-cpu.h b/drivers/staging/lustre/include/linux/libcfs/linux/linux-cpu.h
deleted file mode 100644
index 6035376f2830..000000000000
--- a/drivers/staging/lustre/include/linux/libcfs/linux/linux-cpu.h
+++ /dev/null
@@ -1,78 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * GPL HEADER START
- *
- * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 only,
- * as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License version 2 for more details (a copy is included
- * in the LICENSE file that accompanied this code).
- *
- * GPL HEADER END
- */
-/*
- * Copyright (c) 2010, Oracle and/or its affiliates. All rights reserved.
- * Copyright (c) 2012, Intel Corporation.
- */
-/*
- * This file is part of Lustre, http://www.lustre.org/
- * Lustre is a trademark of Sun Microsystems, Inc.
- *
- * libcfs/include/libcfs/linux/linux-cpu.h
- *
- * Basic library routines.
- *
- * Author: liang@whamcloud.com
- */
-
-#ifndef __LIBCFS_LINUX_CPU_H__
-#define __LIBCFS_LINUX_CPU_H__
-
-#ifndef __LIBCFS_LIBCFS_H__
-#error Do not #include this file directly. #include <linux/libcfs/libcfs.h> instead
-#endif
-
-#include <linux/cpu.h>
-#include <linux/cpuset.h>
-#include <linux/topology.h>
-
-#ifdef CONFIG_SMP
-
-#define HAVE_LIBCFS_CPT
-
-/** virtual processing unit */
-struct cfs_cpu_partition {
-	/* CPUs mask for this partition */
-	cpumask_var_t			cpt_cpumask;
-	/* nodes mask for this partition */
-	nodemask_t			*cpt_nodemask;
-	/* spread rotor for NUMA allocator */
-	unsigned int			cpt_spread_rotor;
-};
-
-/** descriptor for CPU partitions */
-struct cfs_cpt_table {
-	/* version, reserved for hotplug */
-	unsigned int			ctb_version;
-	/* spread rotor for NUMA allocator */
-	unsigned int			ctb_spread_rotor;
-	/* # of CPU partitions */
-	unsigned int			ctb_nparts;
-	/* partitions tables */
-	struct cfs_cpu_partition	*ctb_parts;
-	/* shadow HW CPU to CPU partition ID */
-	int				*ctb_cpu2cpt;
-	/* all cpus in this partition table */
-	cpumask_var_t			ctb_cpumask;
-	/* all nodes in this partition table */
-	nodemask_t			*ctb_nodemask;
-};
-
-#endif /* CONFIG_SMP */
-#endif /* __LIBCFS_LINUX_CPU_H__ */
diff --git a/drivers/staging/lustre/lnet/libcfs/libcfs_cpu.c b/drivers/staging/lustre/lnet/libcfs/libcfs_cpu.c
index 76291a350406..5818f641455f 100644
--- a/drivers/staging/lustre/lnet/libcfs/libcfs_cpu.c
+++ b/drivers/staging/lustre/lnet/libcfs/libcfs_cpu.c
@@ -37,7 +37,7 @@
 struct cfs_cpt_table   *cfs_cpt_table __read_mostly;
 EXPORT_SYMBOL(cfs_cpt_table);
 
-#ifndef HAVE_LIBCFS_CPT
+#ifndef CONFIG_SMP
 
 #define CFS_CPU_VERSION_MAGIC	   0xbabecafe
 
@@ -225,4 +225,4 @@ cfs_cpu_init(void)
 	return cfs_cpt_table ? 0 : -1;
 }
 
-#endif /* HAVE_LIBCFS_CPT */
+#endif /* CONFIG_SMP */
