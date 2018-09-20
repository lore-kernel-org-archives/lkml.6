Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1B8ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C02F21523
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:23:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C02F21523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733229AbeITXH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 19:07:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53180 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726990AbeITXHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 19:07:25 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8KHEM5a018347
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 13:22:55 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mmenkuk6y-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 13:22:54 -0400
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ego@linux.vnet.ibm.com>;
        Thu, 20 Sep 2018 11:22:54 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com (9.17.130.16)
        by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 20 Sep 2018 11:22:49 -0600
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8KHMmel49741966
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 20 Sep 2018 10:22:48 -0700
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D04A178063;
        Thu, 20 Sep 2018 11:22:48 -0600 (MDT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7B9FB7805E;
        Thu, 20 Sep 2018 11:22:48 -0600 (MDT)
Received: from sofia.ibm.com (unknown [9.124.212.176])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 20 Sep 2018 11:22:48 -0600 (MDT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
        id 5805B2E2DAB; Thu, 20 Sep 2018 22:52:45 +0530 (IST)
From:   "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Neuling <mikey@neuling.org>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
        Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
        Anton Blanchard <anton@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [PATCH v8 3/3] powerpc/sysfs: Add topology/smallcore_thread_siblings[_list]
Date:   Thu, 20 Sep 2018 22:52:39 +0530
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1537464159-25919-1-git-send-email-ego@linux.vnet.ibm.com>
References: <1537464159-25919-1-git-send-email-ego@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18092017-8235-0000-0000-00000E03409B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009741; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01091142; UDB=6.00563758; IPR=6.00871165;
 MB=3.00023416; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-20 17:22:52
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092017-8236-0000-0000-000042B5FE9B
Message-Id: <1537464159-25919-4-git-send-email-ego@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-20_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809200167
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

This patch adds two sysfs attributes named smallcore_thread_siblings
and smallcore_thread_siblings_list to the "topology" attribute group
for each CPU device.

The read-only attributes
/sys/device/system/cpu/cpuN/topology/smallcore_thread_siblings and
/sys/device/system/cpu/cpuN/topology/smallcore_thread_siblings_list
will the online siblings of CPU N that share the L1 cache with it on
big-core configurations in cpumask format and cpu-list format
respectively.

Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 Documentation/ABI/testing/sysfs-devices-system-cpu | 14 ++++
 arch/powerpc/kernel/sysfs.c                        | 88 ++++++++++++++++++++++
 2 files changed, 102 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index 7331822..2a80dc2 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -511,3 +511,17 @@ Description:	Control Symetric Multi Threading (SMT)
 
 			 If control status is "forceoff" or "notsupported" writes
 			 are rejected.
+
+What:		/sys/devices/system/cpu/cpu#/topology/smallcore_thread_siblings
+		/sys/devices/system/cpu/cpu#/topology/smallcore_thread_siblings_list
+Date:		Sept 2018
+Contact:	Linux for PowerPC mailing list <linuxppc-dev@ozlabs.org>
+Description: 	CPU topology files that describe the thread siblings of a
+		logical CPU that share the L1-cache with it on POWER9
+		big-core configurations.
+
+		smallcore_thread_siblings: internal kernel map of
+		cpu#'s hardware threads that share L1-cache with cpu#.
+
+		smallcore_thread_siblings_list: human-readable list of
+		cpu#'s hardware threads that share L1-cache with cpu#.
diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
index 755dc98..f9c7d96 100644
--- a/arch/powerpc/kernel/sysfs.c
+++ b/arch/powerpc/kernel/sysfs.c
@@ -18,6 +18,7 @@
 #include <asm/smp.h>
 #include <asm/pmc.h>
 #include <asm/firmware.h>
+#include <asm/cputhreads.h>
 
 #include "cacheinfo.h"
 #include "setup.h"
@@ -714,6 +715,62 @@ static void sysfs_create_dscr_default(void)
 #endif /* HAS_PPC_PMC_PA6T */
 #endif /* HAS_PPC_PMC_CLASSIC */
 
+static ssize_t smallcore_thread_siblings_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	int cpu = dev->id;
+
+	return cpumap_print_to_pagebuf(false, buf, cpu_smallcore_mask(cpu));
+}
+static DEVICE_ATTR_RO(smallcore_thread_siblings);
+
+static ssize_t smallcore_thread_siblings_list_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	int cpu = dev->id;
+
+	return cpumap_print_to_pagebuf(true, buf, cpu_smallcore_mask(cpu));
+}
+static DEVICE_ATTR_RO(smallcore_thread_siblings_list);
+
+static struct attribute *smallcore_attrs[] = {
+	&dev_attr_smallcore_thread_siblings.attr,
+	&dev_attr_smallcore_thread_siblings_list.attr,
+	NULL
+};
+
+static const struct attribute_group smallcore_attr_group = {
+	.name = "topology",
+	.attrs = smallcore_attrs
+};
+
+static int smallcore_register_cpu_online(unsigned int cpu)
+{
+	int err;
+	struct device *cpu_dev = get_cpu_device(cpu);
+
+	if (!has_big_cores)
+		return 0;
+
+	err = sysfs_merge_group(&cpu_dev->kobj, &smallcore_attr_group);
+
+	return err;
+}
+
+static int smallcore_unregister_cpu_online(unsigned int cpu)
+{
+	struct device *cpu_dev = get_cpu_device(cpu);
+
+	if (!has_big_cores)
+		return 0;
+
+	sysfs_unmerge_group(&cpu_dev->kobj, &smallcore_attr_group);
+
+	return 0;
+}
+
 static int register_cpu_online(unsigned int cpu)
 {
 	struct cpu *c = &per_cpu(cpu_devices, cpu);
@@ -1060,3 +1117,34 @@ static int __init topology_init(void)
 	return 0;
 }
 subsys_initcall(topology_init);
+
+/*
+ * NOTE: The smallcore_register_cpu_online
+ *       (resp. smallcore_unregister_cpu_online) callback will merge
+ *       (resp. unmerge) a couple of additional attributes to the
+ *       "topology" attribute group of a CPU device when the CPU comes
+ *       online (resp. goes offline).
+ *
+ *       Hence, the registration of these callbacks must happen after
+ *       topology_sysfs_init() is called so that the topology
+ *       attribute group is created before these additional attributes
+ *       can be merged/unmerged. We cannot register these callbacks in
+ *       topology_init() since this function is called before
+ *       topology_sysfs_init(). Hence we define the following
+ *       late_initcall for this purpose.
+ */
+static int __init smallcore_topology_init(void)
+{
+	int r;
+
+	if (!has_big_cores)
+		return 0;
+
+	r = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
+			      "powerpc/topology/smallcore:online",
+			      smallcore_register_cpu_online,
+			      smallcore_unregister_cpu_online);
+	WARN_ON(r < 0);
+	return 0;
+}
+late_initcall(smallcore_topology_init);
-- 
1.9.4

