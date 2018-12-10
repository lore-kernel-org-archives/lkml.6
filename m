Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28111C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE14C2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jgxyqS2A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE14C2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbeLJTJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 14:09:11 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:41926 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727725AbeLJTJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 14:09:10 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBAJ8YEC121067;
        Mon, 10 Dec 2018 19:08:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=9SQ9C4gx7/tSUpU1UOAJA1wHr3nxmNx8qjsppVdb7/A=;
 b=jgxyqS2AzfyVe9IXXzm9qWGB/9FODbaTiBN7UfPTWqSkWC7uxtlVvWZWZB8cvqr/TCLw
 KNSFd7D6+WsDa7vhNB4S1iEpq4M/6P3O5hnGlJY0dEOEJY6CtVcgwNcF2f2FX1QMopwB
 S/yQqQdPJ9lZNrN9wgASIvv7091PYHVqXbN9biXb5pWnPZFKXk1DLrhgGms2NpuI6xJH
 0O/V6IPAxr5gRa19cjIbqElhlggMGLkWa3BstPc3ZcYWHxVDiz6b5mylZZZMOMcpE8zW
 ZuMGoMhwpRR+2b3FsZ8nXIm7+zupG5aCc0fRwBKWsKm37T/3s3kqK36JWz+IqEM8tvwf mA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2p86kqqtdf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Dec 2018 19:08:54 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wBAJ8rWn006400
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Dec 2018 19:08:54 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wBAJ8rZR024745;
        Mon, 10 Dec 2018 19:08:53 GMT
Received: from marawils-linux.us.oracle.com (/10.141.196.37)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 10 Dec 2018 11:08:53 -0800
From:   Maran Wilson <maran.wilson@oracle.com>
To:     x86@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, jgross@suse.com
Cc:     boris.ostrovsky@oracle.com, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, roger.pau@citrix.com, rkrcmar@redhat.com,
        maran.wilson@oracle.com
Subject: [PATCH v9 5/7] xen/pvh: Move Xen code for getting mem map via hcall out of common file
Date:   Mon, 10 Dec 2018 11:08:46 -0800
Message-Id: <1544468926-737-3-git-send-email-maran.wilson@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1544468734-32763-1-git-send-email-maran.wilson@oracle.com>
References: <1544468734-32763-1-git-send-email-maran.wilson@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9103 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812100170
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

