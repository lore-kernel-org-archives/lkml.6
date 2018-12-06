Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 002DBC04EBF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 06:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B141320989
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 06:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="R2TWceC2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B141320989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729182AbeLFGGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 01:06:05 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:60692 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729158AbeLFGGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 01:06:03 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB65xESK025057;
        Thu, 6 Dec 2018 06:05:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=9SQ9C4gx7/tSUpU1UOAJA1wHr3nxmNx8qjsppVdb7/A=;
 b=R2TWceC2KYDQrXVUqrhOUBoA0X4bSoDoFEJ4ppoZ7pbrpqTT3srpfh/5QStek7Otky6X
 CiwMRob35/7m73/67PlO1m74mdUeluhQYqz7gdrlpj7ZWoTHHKUd/jCJ4d7DqUnGjYAZ
 GWDj7T3FffsT1n3ee09wt/3S3w0OyDDCCyjGO7q9EBzyqi/KPMjyO4QJz8qLgKxXsYrd
 eB7tMQaJ+ol6XFPxBVEL8Ld7PRL5JZdgfPCl2WyoEB2jKrlVcUMXy+mlbmZHDsdN9vby
 UQfnQEKi2sXOwId/ydJf2ACRuWDwdzGIPV/aYoPSmKse3sZzsX+L1Va1mSKXdbbtVmjG nA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2p3hqu6c4x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Dec 2018 06:05:40 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wB665dUE016967
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Dec 2018 06:05:40 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wB665dOT015386;
        Thu, 6 Dec 2018 06:05:39 GMT
Received: from marawils-linux.us.oracle.com (/10.141.196.37)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 05 Dec 2018 22:05:38 -0800
From:   Maran Wilson <maran.wilson@oracle.com>
To:     x86@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, jgross@suse.com
Cc:     boris.ostrovsky@oracle.com, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, roger.pau@citrix.com, rkrcmar@redhat.com,
        maran.wilson@oracle.com
Subject: [PATCH v8 5/7] xen/pvh: Move Xen code for getting mem map via hcall out of common file
Date:   Wed,  5 Dec 2018 22:05:30 -0800
Message-Id: <1544076330-21992-3-git-send-email-maran.wilson@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1544076152-21637-1-git-send-email-maran.wilson@oracle.com>
References: <1544076152-21637-1-git-send-email-maran.wilson@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9098 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812060055
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to refactor PVH entry code so that support for other hypervisors
like Qemu/KVM can be added more easily.

The original design for PVH entry in Xen guests relies on being able to
obtain the memory map from the hypervisor using a hypercall. When we
extend the PVH entry ABI to support other hypervisors like Qemu/KVM,
a new mechanism will be added that allows the guest to get the memory
map without needing to use hypercalls.

For Xen guests, the hypercall approach will still be supported. In
preparation for adding support for other hypervisors, we can move the
code that uses hypercalls into the Xen specific file. This will allow us
to compile kernels in the future without CONFIG_XEN that are still capable
of being booted as a Qemu/KVM guest via the PVH entry point.

Signed-off-by: Maran Wilson <maran.wilson@oracle.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/platform/pvh/enlighten.c | 29 ++++++++++++++---------------
 arch/x86/xen/enlighten_pvh.c      | 20 ++++++++++++++++++++
 2 files changed, 34 insertions(+), 15 deletions(-)

diff --git a/arch/x86/platform/pvh/enlighten.c b/arch/x86/platform/pvh/enlighten.c
index 637bd74ba32d..8040b3fbf545 100644
--- a/arch/x86/platform/pvh/enlighten.c
+++ b/arch/x86/platform/pvh/enlighten.c
@@ -8,11 +8,7 @@
 #include <asm/e820/api.h>
 #include <asm/x86_init.h>
 
-#include <asm/xen/interface.h>
-#include <asm/xen/hypercall.h>
-
 #include <xen/xen.h>
-#include <xen/interface/memory.h>
 #include <xen/interface/hvm/start_info.h>
 
 /*
@@ -31,21 +27,24 @@ static u64 pvh_get_root_pointer(void)
 	return pvh_start_info.rsdp_paddr;
 }
 
+/*
+ * Xen guests are able to obtain the memory map from the hypervisor via the
+ * HYPERVISOR_memory_op hypercall.
+ * If we are trying to boot a Xen PVH guest, it is expected that the kernel
+ * will have been configured to provide an override for this routine to do
+ * just that.
+ */
+void __init __weak mem_map_via_hcall(struct boot_params *ptr __maybe_unused)
+{
+	xen_raw_printk("Error: Could not find memory map\n");
+	BUG();
+}
+
 static void __init init_pvh_bootparams(void)
 {
-	struct xen_memory_map memmap;
-	int rc;
-
 	memset(&pvh_bootparams, 0, sizeof(pvh_bootparams));
 
-	memmap.nr_entries = ARRAY_SIZE(pvh_bootparams.e820_table);
-	set_xen_guest_handle(memmap.buffer, pvh_bootparams.e820_table);
-	rc = HYPERVISOR_memory_op(XENMEM_memory_map, &memmap);
-	if (rc) {
-		xen_raw_printk("XENMEM_memory_map failed (%d)\n", rc);
-		BUG();
-	}
-	pvh_bootparams.e820_entries = memmap.nr_entries;
+	mem_map_via_hcall(&pvh_bootparams);
 
 	if (pvh_bootparams.e820_entries < E820_MAX_ENTRIES_ZEROPAGE - 1) {
 		pvh_bootparams.e820_table[pvh_bootparams.e820_entries].addr =
diff --git a/arch/x86/xen/enlighten_pvh.c b/arch/x86/xen/enlighten_pvh.c
index 41a7d6ad74e0..35b7599d2d0b 100644
--- a/arch/x86/xen/enlighten_pvh.c
+++ b/arch/x86/xen/enlighten_pvh.c
@@ -1,13 +1,18 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/acpi.h>
 
+#include <xen/hvc-console.h>
+
 #include <asm/io_apic.h>
 #include <asm/hypervisor.h>
+#include <asm/e820/api.h>
 
 #include <xen/xen.h>
 #include <asm/xen/interface.h>
 #include <asm/xen/hypercall.h>
 
+#include <xen/interface/memory.h>
+
 /*
  * PVH variables.
  *
@@ -28,3 +33,18 @@ void __init xen_pvh_init(void)
 	pfn = __pa(hypercall_page);
 	wrmsr_safe(msr, (u32)pfn, (u32)(pfn >> 32));
 }
+
+void __init mem_map_via_hcall(struct boot_params *boot_params_p)
+{
+	struct xen_memory_map memmap;
+	int rc;
+
+	memmap.nr_entries = ARRAY_SIZE(boot_params_p->e820_table);
+	set_xen_guest_handle(memmap.buffer, boot_params_p->e820_table);
+	rc = HYPERVISOR_memory_op(XENMEM_memory_map, &memmap);
+	if (rc) {
+		xen_raw_printk("XENMEM_memory_map failed (%d)\n", rc);
+		BUG();
+	}
+	boot_params_p->e820_entries = memmap.nr_entries;
+}
-- 
2.16.1

