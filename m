Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id LBCkNIY/GVu7WwAAmS7hNA
	; Thu, 07 Jun 2018 14:24:51 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 806CD6089E; Thu,  7 Jun 2018 14:24:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E98BA602FC;
	Thu,  7 Jun 2018 14:24:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E98BA602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933550AbeFGOYt (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:24:49 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40133 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933376AbeFGOYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:24:37 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbe-0005Zm-Jg; Thu, 07 Jun 2018 15:09:38 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb6-000329-Pg; Thu, 07 Jun 2018 15:09:04 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Nathan Fontenot" <nfont@linux.vnet.ibm.com>,
        "Tyrel Datwyler" <tyreld@linux.vnet.ibm.com>,
        "Michael Ellerman" <mpe@ellerman.id.au>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.683372353@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 219/410] powerpc/numa: Invalidate numa_cpu_lookup_table
 on cpu remove
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/powerpc/include/asm/topology.h          | 5 +++++
 arch/powerpc/mm/numa.c                       | 5 -----
 arch/powerpc/platforms/pseries/hotplug-cpu.c | 2 ++
 3 files changed, 7 insertions(+), 5 deletions(-)

--- a/arch/powerpc/include/asm/topology.h
+++ b/arch/powerpc/include/asm/topology.h
@@ -44,6 +44,11 @@ extern void __init dump_numa_cpu_topolog
 extern int sysfs_add_device_to_node(struct device *dev, int nid);
 extern void sysfs_remove_device_from_node(struct device *dev, int nid);
 
+static inline void update_numa_cpu_lookup_table(unsigned int cpu, int node)
+{
+	numa_cpu_lookup_table[cpu] = node;
+}
+
 static inline int early_cpu_to_node(int cpu)
 {
 	int nid;
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -162,11 +162,6 @@ static void reset_numa_cpu_lookup_table(
 		numa_cpu_lookup_table[cpu] = -1;
 }
 
-static void update_numa_cpu_lookup_table(unsigned int cpu, int node)
-{
-	numa_cpu_lookup_table[cpu] = node;
-}
-
 static void map_cpu_to_node(int cpu, int node)
 {
 	update_numa_cpu_lookup_table(cpu, node);
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -31,6 +31,7 @@
 #include <asm/vdso_datapage.h>
 #include <asm/xics.h>
 #include <asm/plpar_wrappers.h>
+#include <asm/topology.h>
 
 #include "offline_states.h"
 
@@ -328,6 +329,7 @@ static void pseries_remove_processor(str
 			BUG_ON(cpu_online(cpu));
 			set_cpu_present(cpu, false);
 			set_hard_smp_processor_id(cpu, -1);
+			update_numa_cpu_lookup_table(cpu, -1);
 			break;
 		}
 		if (cpu >= nr_cpu_ids)
