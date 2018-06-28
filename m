Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 211A2C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 09:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E95727158
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 09:23:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E95727158
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hxt-semitech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752764AbeF1JXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 05:23:02 -0400
Received: from mx01.hxt-semitech.com.96.203.223.in-addr.arpa ([223.203.96.7]:55230
        "EHLO barracuda.hxt-semitech.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750802AbeF1JXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 05:23:01 -0400
X-ASG-Debug-ID: 1530177766-093b7e43b2a5720001-xx1T2L
Received: from HXTBJIDCEMVIW01.hxtcorp.net (localhost [10.128.0.14]) by barracuda.hxt-semitech.com with ESMTP id 0xeOAI1TKUxfpkVd (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NO); Thu, 28 Jun 2018 17:22:46 +0800 (CST)
X-Barracuda-Envelope-From: shunyong.yang@hxt-semitech.com
Received: from y.localdomain (10.5.21.109) by HXTBJIDCEMVIW01.hxtcorp.net
 (10.128.0.14) with Microsoft SMTP Server (TLS) id 15.0.847.32; Thu, 28 Jun
 2018 17:22:48 +0800
From:   Shunyong Yang <shunyong.yang@hxt-semitech.com>
To:     <catalin.marinas@arm.com>
CC:     <will.deacon@arm.com>, <jeremy.linton@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Shunyong Yang <shunyong.yang@hxt-semitech.com>,
        Joey Zheng <yu.zheng@hxt-semitech.com>
Subject: [RFC PATCH] arm64: topology: Map PPTT node offset to logic physical package id
Date:   Thu, 28 Jun 2018 17:18:28 +0800
X-ASG-Orig-Subj: [RFC PATCH] arm64: topology: Map PPTT node offset to logic physical package id
Message-ID: <1530177508-15298-1-git-send-email-shunyong.yang@hxt-semitech.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.5.21.109]
X-ClientProxiedBy: HXTBJIDCEMVIW01.hxtcorp.net (10.128.0.14) To
 HXTBJIDCEMVIW01.hxtcorp.net (10.128.0.14)
X-Barracuda-Connect: localhost[10.128.0.14]
X-Barracuda-Start-Time: 1530177766
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA
X-Barracuda-URL: https://192.168.50.101:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at hxt-semitech.com
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.4965 1.0000 0.0000
X-Barracuda-Spam-Score: 1.20
X-Barracuda-Spam-Status: No, SCORE=1.20 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=SORTED_RECIPS
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.52503
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
        1.20 SORTED_RECIPS          Recipient list is sorted by address
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As PPTT spec doesn't define the physical package id,
find_acpi_cpu_topology_package() will return offset of the node with
Physical package field set when querying physical package id. So, it
returns 162(0xA2) in following example.

[0A2h 0162   1]                Subtable Type : 00 [Processor Hierarchy
Node]
[0A3h 0163   1]                       Length : 1C
[0A4h 0164   2]                     Reserved : 0000
[0A6h 0166   4]        Flags (decoded below) : 00000003
                            Physical package : 1
                     ACPI Processor ID valid : 1
[0AAh 0170   4]                       Parent : 00000000
[0AEh 0174   4]            ACPI Processor ID : 00001000
[0B2h 0178   4]      Private Resource Number : 00000002
[0B6h 0182   4]             Private Resource : 0000006C
[0BAh 0186   4]             Private Resource : 00000084

So, when "cat physical_package" in /sys/devices/system/cpu/cpu0/topology/,
it will output 162(0xA2). And if some items are added before the node
above, the output will change to other value.

This patch maps the node offset to a logic package id. It maps the first
node offset to 0, the second to 1, and so on.

Then, it will not output a big value, such as 162 above. And it will
not change when some nodes(Physical package not set) are added.

And as long as the nodes with Physical package field set in PPTT keeps
the real hardware order, the logic id can map to hardware package id to
some extent.

Hope to get feedback from you.

Cc: Joey Zheng <yu.zheng@hxt-semitech.com>
Signed-off-by: Shunyong Yang <shunyong.yang@hxt-semitech.com>
---
 arch/arm64/kernel/topology.c | 53 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index f845a8617812..c219224b36e8 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -320,11 +320,59 @@ static void __init reset_cpu_topology(void)
  * Propagate the topology information of the processor_topology_node tree to the
  * cpu_topology array.
  */
+
+struct package_id_map {
+	int topology_id;
+	int package_id;
+	struct list_head list;
+};
+
+static int map_package_id(int topology_id, int *max_package_id,
+			  struct list_head *head)
+{
+	struct list_head *pos;
+	struct package_id_map *entry;
+
+	list_for_each(pos, head) {
+		entry = container_of(pos, struct package_id_map, list);
+		if (entry->topology_id == topology_id)
+			goto done;
+	}
+
+	/* topology_id not found in the list */
+	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		return topology_id;
+
+	entry->topology_id = topology_id;
+	entry->package_id = *max_package_id;
+	list_add(&entry->list, head);
+	*max_package_id = *max_package_id + 1;
+
+done:
+	return entry->package_id;
+}
+
+static void destroy_map(struct list_head *head)
+{
+	struct package_id_map *entry;
+	struct list_head *pos, *q;
+
+	list_for_each_safe(pos, q, head) {
+		entry = container_of(pos, struct package_id_map, list);
+		list_del(pos);
+		kfree(entry);
+	}
+}
+
 static int __init parse_acpi_topology(void)
 {
 	bool is_threaded;
 	int cpu, topology_id;
+	struct list_head package_id_list;
+	int max_package_id = 0;
 
+	INIT_LIST_HEAD(&package_id_list);
 	is_threaded = read_cpuid_mpidr() & MPIDR_MT_BITMASK;
 
 	for_each_possible_cpu(cpu) {
@@ -343,7 +391,9 @@ static int __init parse_acpi_topology(void)
 			cpu_topology[cpu].core_id    = topology_id;
 		}
 		topology_id = find_acpi_cpu_topology_package(cpu);
-		cpu_topology[cpu].package_id = topology_id;
+		cpu_topology[cpu].package_id = map_package_id(topology_id,
+							&max_package_id,
+							&package_id_list);
 
 		i = acpi_find_last_cache_level(cpu);
 
@@ -358,6 +408,7 @@ static int __init parse_acpi_topology(void)
 		}
 	}
 
+	destroy_map(&package_id_list);
 	return 0;
 }
 
-- 
1.8.3.1

