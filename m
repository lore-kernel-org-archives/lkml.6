Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A780C43149
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 19:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 306002759E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 14:51:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 306002759E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966895AbeF1Ovp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 10:51:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58894 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966669AbeF1Ovb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 10:51:31 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 334204076063;
        Thu, 28 Jun 2018 14:51:31 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 982CB111CD33;
        Thu, 28 Jun 2018 14:51:29 +0000 (UTC)
From:   Andrew Jones <drjones@redhat.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     jeremy.linton@arm.com, ard.biesheuvel@linaro.org,
        sudeep.holla@arm.com, shunyong.yang@hxt-semitech.com,
        yu.zheng@hxt-semitech.com, catalin.marinas@arm.com,
        will.deacon@arm.com
Subject: [PATCH] arm64: acpi: reenumerate topology ids
Date:   Thu, 28 Jun 2018 16:51:28 +0200
Message-Id: <20180628145128.10057-1-drjones@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 28 Jun 2018 14:51:31 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 28 Jun 2018 14:51:31 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'drjones@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When booting with devicetree, and the devicetree has the cpu-map
node, the topology IDs that are visible from sysfs are generated
with counters. ACPI, on the other hand, uses ACPI table pointer
offsets, which, while guaranteed to be unique, look a bit weird.
Instead, we can generate DT identical topology IDs for ACPI by
just using counters for the leaf nodes and by remapping the
non-leaf table pointer offsets to counters.

Cc: Jeremy Linton <jeremy.linton@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Andrew Jones <drjones@redhat.com>
---

v1:
Reworked this since the RFC in order to make the algorithm more
obvious. It wasn't clear in the RFC that the ACPI nodes could be
in any order, although they could have been. I've tested that
this works with nodes in arbitrary order by hacking the QEMU
PPTT table generator[*].

Note, while this produces equivalent topology IDs to what the
DT cpu-map node produces for all sane configs, if PEs are
threads (have MPIDR.MT set), but the cpu-map does not specify
threads, then, while the DT parsing code will happily call the
threads "cores", ACPI will see that the PPTT leaf nodes are for
threads and produce different topology IDs. I see this difference
as a bug with the DT parsing which can be addressed separately.

[*] https://github.com/rhdrjones/qemu/commits/virt-cpu-topology


 arch/arm64/kernel/topology.c | 70 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 55 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index f845a8617812..7ef457401b24 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -316,6 +316,10 @@ static void __init reset_cpu_topology(void)
 }
 
 #ifdef CONFIG_ACPI
+
+#define acpi_topology_mktag(x)	(-((x) + 1))
+#define acpi_topology_istag(x)	((x) < 0)
+
 /*
  * Propagate the topology information of the processor_topology_node tree to the
  * cpu_topology array.
@@ -323,27 +327,31 @@ static void __init reset_cpu_topology(void)
 static int __init parse_acpi_topology(void)
 {
 	bool is_threaded;
-	int cpu, topology_id;
+	int package_id = 0;
+	int cpu, ret;
 
 	is_threaded = read_cpuid_mpidr() & MPIDR_MT_BITMASK;
 
+	/*
+	 * Loop through all PEs twice. In the first loop store parent
+	 * tags into the IDs. In the second loop we reset the IDs as
+	 * 0..N-1 per parent tag.
+	 */
+
 	for_each_possible_cpu(cpu) {
 		int i, cache_id;
 
-		topology_id = find_acpi_cpu_topology(cpu, 0);
-		if (topology_id < 0)
-			return topology_id;
-
-		if (is_threaded) {
-			cpu_topology[cpu].thread_id = topology_id;
-			topology_id = find_acpi_cpu_topology(cpu, 1);
-			cpu_topology[cpu].core_id   = topology_id;
-		} else {
-			cpu_topology[cpu].thread_id  = -1;
-			cpu_topology[cpu].core_id    = topology_id;
-		}
-		topology_id = find_acpi_cpu_topology_package(cpu);
-		cpu_topology[cpu].package_id = topology_id;
+		ret = find_acpi_cpu_topology(cpu, 0);
+		if (ret < 0)
+			return ret;
+
+		if (is_threaded)
+			ret = find_acpi_cpu_topology(cpu, 1);
+		else
+			cpu_topology[cpu].thread_id = -1;
+		cpu_topology[cpu].core_id = acpi_topology_mktag(ret);
+		ret = find_acpi_cpu_topology_package(cpu);
+		cpu_topology[cpu].package_id = acpi_topology_mktag(ret);
 
 		i = acpi_find_last_cache_level(cpu);
 
@@ -358,6 +366,38 @@ static int __init parse_acpi_topology(void)
 		}
 	}
 
+	for_each_possible_cpu(cpu) {
+		int package_tag = cpu_topology[cpu].package_id;
+		int core_id = 0, cpu2;
+
+		if (!acpi_topology_istag(package_tag))
+			continue;
+
+		for_each_possible_cpu(cpu2) {
+			if (cpu_topology[cpu2].package_id != package_tag)
+				continue;
+
+			if (is_threaded) {
+				int core_tag = cpu_topology[cpu2].core_id;
+				int thread_id = 0, cpu3;
+
+				for_each_possible_cpu(cpu3) {
+					if (cpu_topology[cpu3].core_id != core_tag)
+						continue;
+
+					cpu_topology[cpu3].thread_id = thread_id++;
+					cpu_topology[cpu3].core_id = core_id;
+					cpu_topology[cpu3].package_id = package_id;
+				}
+				++core_id;
+			} else {
+				cpu_topology[cpu2].core_id = core_id++;
+				cpu_topology[cpu2].package_id = package_id;
+			}
+		}
+		++package_id;
+	}
+
 	return 0;
 }
 
-- 
1.8.3.1

