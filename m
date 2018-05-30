Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753390AbeE3LUg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:20:36 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60996 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752536AbeE3LHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:07:07 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Nathan Fontenot" <nfont@linux.vnet.ibm.com>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        "Tyrel Datwyler" <tyreld@linux.vnet.ibm.com>
Date: Wed, 30 May 2018 11:52:41 +0100
Message-ID: <lsq.1527677561.116555141@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 077/153] powerpc/numa: Invalidate numa_cpu_lookup_table
 on cpu remove
In-Reply-To: <lsq.1527677560.486731940@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.2.102-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Nathan Fontenot <nfont@linux.vnet.ibm.com>

commit 1d9a090783bef19fe8cdec878620d22f05191316 upstream.

When DLPAR removing a CPU, the unmapping of the cpu from a node in
unmap_cpu_from_node() should also invalidate the CPUs entry in the
numa_cpu_lookup_table. There is not a guarantee that on a subsequent
DLPAR add of the CPU the associativity will be the same and thus
could be in a different node. Invalidating the entry in the
numa_cpu_lookup_table causes the associativity to be read from the
device tree at the time of the add.

The current behavior of not invalidating the CPUs entry in the
numa_cpu_lookup_table can result in scenarios where the the topology
layout of CPUs in the partition does not match the device tree
or the topology reported by the HMC.

This bug looks like it was introduced in 2004 in the commit titled
"ppc64: cpu hotplug notifier for numa", which is 6b15e4e87e32 in the
linux-fullhist tree. Hence tag it for all stable releases.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Reviewed-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
[bwh: Backported to 3.2:
 - update_numa_cpu_lookup_table() wasn't defined anywhere before
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/powerpc/include/asm/topology.h
+++ b/arch/powerpc/include/asm/topology.h
@@ -89,6 +89,11 @@ extern void __init dump_numa_cpu_topolog
 extern int sysfs_add_device_to_node(struct sys_device *dev, int nid);
 extern void sysfs_remove_device_from_node(struct sys_device *dev, int nid);
 
+static inline void update_numa_cpu_lookup_table(unsigned int cpu, int node)
+{
+	numa_cpu_lookup_table[cpu] = node;
+}
+
 #else
 
 static inline void dump_numa_cpu_topology(void) {}
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -32,6 +32,7 @@
 #include <asm/pSeries_reconfig.h>
 #include <asm/xics.h>
 #include "plpar_wrappers.h"
+#include <asm/topology.h>
 #include "offline_states.h"
 
 /* This version can't take the spinlock, because it never returns */
@@ -319,6 +320,7 @@ static void pseries_remove_processor(str
 			BUG_ON(cpu_online(cpu));
 			set_cpu_present(cpu, false);
 			set_hard_smp_processor_id(cpu, -1);
+			update_numa_cpu_lookup_table(cpu, -1);
 			break;
 		}
 		if (cpu >= nr_cpu_ids)
