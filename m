Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63426C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12E482082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oBLACdtv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12E482082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729215AbeLJTJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 14:09:16 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:58078 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729196AbeLJTJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 14:09:13 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBAJ8nKW115853;
        Mon, 10 Dec 2018 19:08:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=r+EJebpnfrk/sWr6hWd1Ab7LVK03r8tKPcKLYy60yB0=;
 b=oBLACdtvYCNiRAd/eeuakcbkSeNj3uEx/yoEksT2LXEEaUzGU9VlB/E15TpuPuz0tLso
 yEWIp/y48F2JfHLDAlfn99GkkFJwMmJSOQwlbasMgfDHtBRkuLq8m6AqtFwvRsuHjEc4
 gdyLYAoMGUKaH58H9FsNDe20q7zbR3WLhpWZlcSgvKZKgVPw1OKt5ZHsw15UK2CVQEJq
 tTeW8zh8OaYfkVmOrGcEWDiC1oddNKLkigaOFMCiemvT2bV9bqG7nF9KPTHduhoKLofD
 qTAg2AK+4FQmHhLdzNSM3YC+8xm9ZNarjDoEmwwKby6W00ZHEkbm/I+0rRuR7CNyb72C Bg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2p83fe01d8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Dec 2018 19:08:54 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wBAJ8r1d006397
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Dec 2018 19:08:53 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wBAJ8re6018718;
        Mon, 10 Dec 2018 19:08:53 GMT
Received: from marawils-linux.us.oracle.com (/10.141.196.37)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 10 Dec 2018 11:08:52 -0800
From:   Maran Wilson <maran.wilson@oracle.com>
To:     x86@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, jgross@suse.com
Cc:     boris.ostrovsky@oracle.com, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, roger.pau@citrix.com, rkrcmar@redhat.com,
        maran.wilson@oracle.com
Subject: [PATCH v9 4/7] xen/pvh: Move Xen specific PVH VM initialization out of common file
Date:   Mon, 10 Dec 2018 11:08:45 -0800
Message-Id: <1544468926-737-2-git-send-email-maran.wilson@oracle.com>
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

This patch moves the small block of code used for initializing Xen PVH
virtual machines into the Xen specific file. This initialization is not
going to be needed for Qemu/KVM guests. Moving it out of the common file
is going to allow us to compile kernels in the future without CONFIG_XEN
that are still capable of being booted as a Qemu/KVM guest via the PVH
entry point.

Signed-off-by: Maran Wilson <maran.wilson@oracle.com>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/platform/pvh/enlighten.c | 29 ++++++++++++++++++++---------
 arch/x86/xen/enlighten_pvh.c      | 22 +++++++++++++++++++++-
 include/xen/xen.h                 |  3 +++
 3 files changed, 44 insertions(+), 10 deletions(-)

diff --git a/arch/x86/platform/pvh/enlighten.c b/arch/x86/platform/pvh/enlighten.c
index 491932991202..637bd74ba32d 100644
--- a/arch/x86/platform/pvh/enlighten.c
+++ b/arch/x86/platform/pvh/enlighten.c
@@ -81,27 +81,38 @@ static void __init init_pvh_bootparams(void)
 	x86_init.acpi.get_root_pointer = pvh_get_root_pointer;
 }
 
+/*
+ * If we are trying to boot a Xen PVH guest, it is expected that the kernel
+ * will have been configured to provide the required override for this routine.
+ */
+void __init __weak xen_pvh_init(void)
+{
+	xen_raw_printk("Error: Missing xen PVH initialization\n");
+	BUG();
+}
+
+/*
+ * When we add support for other hypervisors like Qemu/KVM, this routine can
+ * selectively invoke the appropriate initialization based on guest type.
+ */
+static void hypervisor_specific_init(void)
+{
+	xen_pvh_init();
+}
+
 /*
  * This routine (and those that it might call) should not use
  * anything that lives in .bss since that segment will be cleared later.
  */
 void __init xen_prepare_pvh(void)
 {
-	u32 msr;
-	u64 pfn;
-
 	if (pvh_start_info.magic != XEN_HVM_START_MAGIC_VALUE) {
 		xen_raw_printk("Error: Unexpected magic value (0x%08x)\n",
 				pvh_start_info.magic);
 		BUG();
 	}
 
-	xen_pvh = 1;
-	xen_start_flags = pvh_start_info.flags;
-
-	msr = cpuid_ebx(xen_cpuid_base() + 2);
-	pfn = __pa(hypercall_page);
-	wrmsr_safe(msr, (u32)pfn, (u32)(pfn >> 32));
+	hypervisor_specific_init();
 
 	init_pvh_bootparams();
 }
diff --git a/arch/x86/xen/enlighten_pvh.c b/arch/x86/xen/enlighten_pvh.c
index 6be7bc719b38..41a7d6ad74e0 100644
--- a/arch/x86/xen/enlighten_pvh.c
+++ b/arch/x86/xen/enlighten_pvh.c
@@ -1,5 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <linux/types.h>
+#include <linux/acpi.h>
+
+#include <asm/io_apic.h>
+#include <asm/hypervisor.h>
+
+#include <xen/xen.h>
+#include <asm/xen/interface.h>
+#include <asm/xen/hypercall.h>
 
 /*
  * PVH variables.
@@ -8,3 +15,16 @@
  * after startup_{32|64} is invoked, which will clear the .bss segment.
  */
 bool xen_pvh __attribute__((section(".data"))) = 0;
+
+void __init xen_pvh_init(void)
+{
+	u32 msr;
+	u64 pfn;
+
+	xen_pvh = 1;
+	xen_start_flags = pvh_start_info.flags;
+
+	msr = cpuid_ebx(xen_cpuid_base() + 2);
+	pfn = __pa(hypercall_page);
+	wrmsr_safe(msr, (u32)pfn, (u32)(pfn >> 32));
+}
diff --git a/include/xen/xen.h b/include/xen/xen.h
index d7a2678da77f..0e2156786ad2 100644
--- a/include/xen/xen.h
+++ b/include/xen/xen.h
@@ -29,6 +29,9 @@ extern bool xen_pvh;
 
 extern uint32_t xen_start_flags;
 
+#include <xen/interface/hvm/start_info.h>
+extern struct hvm_start_info pvh_start_info;
+
 #ifdef CONFIG_XEN_DOM0
 #include <xen/interface/xen.h>
 #include <asm/xen/hypervisor.h>
-- 
2.16.1

