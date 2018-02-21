Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1521561-1519218505-5-10763201531480292391
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519218505; b=QfPPFrlJAPElwJBSgXPXlPV6zzCHiTL1YaiTrNqGXfUbRIy
    hsPfnfUDhx+4/J3p+wW3NL8FkcLE6ExyTlZncIDtXSAcCLw6TIZneiUAGXRzRd/r
    UG2Wdx27XVF6G3ju/8V4GcdigN1hsE292Tsf3F2NgCfDL1LLnEFt4N6XyT692IPG
    Mg1DA32LW0FREribxZm7E5OZgkXq0VvvWt6wvsssS2/rxM22a5PvUeq2LU4t+XCC
    /5m1IesecmZtye3573Eqb7vwPnoskbdVCPd9YnwR9V5m/x92gW+LfrxUHLMA6+uA
    R7UeBW5fLk4WD9OeAsWnuZv4zK5dKPMtllNjUvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519218505; bh=C3jaJ0paLHn56W9dtPsfzFi7VE
    vF880VI2Y3grUG1gc=; b=EvVN0nQbnXv8G59L3DVuRr+A8P3O1vQA1buEUXUUDA
    1FxSlndPBKpRyRumgg1w3AN2JzBT30pU/YzTUcqeicWdfjfFrDkPYQ3XT02ie56e
    3Y4c92Sm9ftMIcUzZ0nRFEWERNVOx12ewrOddjXSAWKRAmzXtdZX+tK209XtDDWf
    UgFpZtrS6rWL2+LMBtADs3aWRF/IejHneSigx/R/3kceiLc1FUsaDkv4JuvpqoYt
    M9yxVNcDp8AVzNmM7v5uTV0UsHUHX3fUbX4ARl/2UpIRwM3OMWGc1e1h3utqlZFb
    UHho2xIb9GBnWEqHl/1xxN09SeVTXQptGdyp4OHiogTA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965246AbeBUNIH (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 08:08:07 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:42060 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965286AbeBUNIF (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Feb 2018 08:08:05 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nathan Fontenot <nfont@linux.vnet.ibm.com>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.15 022/163] powerpc/numa: Invalidate numa_cpu_lookup_table on cpu remove
Date: Wed, 21 Feb 2018 13:47:31 +0100
Message-Id: <20180221124531.401530753@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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

Cc: stable@vger.kernel.org
Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Reviewed-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/include/asm/topology.h          |    5 +++++
 arch/powerpc/mm/numa.c                       |    5 -----
 arch/powerpc/platforms/pseries/hotplug-cpu.c |    2 ++
 3 files changed, 7 insertions(+), 5 deletions(-)

--- a/arch/powerpc/include/asm/topology.h
+++ b/arch/powerpc/include/asm/topology.h
@@ -44,6 +44,11 @@ extern int sysfs_add_device_to_node(stru
 extern void sysfs_remove_device_from_node(struct device *dev, int nid);
 extern int numa_update_cpu_topology(bool cpus_locked);
 
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
@@ -142,11 +142,6 @@ static void reset_numa_cpu_lookup_table(
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
@@ -36,6 +36,7 @@
 #include <asm/xics.h>
 #include <asm/xive.h>
 #include <asm/plpar_wrappers.h>
+#include <asm/topology.h>
 
 #include "pseries.h"
 #include "offline_states.h"
@@ -331,6 +332,7 @@ static void pseries_remove_processor(str
 			BUG_ON(cpu_online(cpu));
 			set_cpu_present(cpu, false);
 			set_hard_smp_processor_id(cpu, -1);
+			update_numa_cpu_lookup_table(cpu, -1);
 			break;
 		}
 		if (cpu >= nr_cpu_ids)
