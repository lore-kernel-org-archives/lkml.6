Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA09C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD7752084E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RZsQJGwa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD7752084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbeLJTKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 14:10:06 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:34418 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727156AbeLJTKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 14:10:06 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBAJ8WVb158142;
        Mon, 10 Dec 2018 19:09:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=e2xVc/HkEiF1UxbONEUODMxPLCpybomt3hGIki/DEyY=;
 b=RZsQJGwaqli+/65ru+18DGDc/IRT8Kn7ePB1FguqBMe/XMAr5rLPjfmOwSxl9bF6r7+D
 uvbHq9/BDyFUl7MWcFuSbhj5HcxmfDr3pakImC2LEcy7rrYwAMYksIw3z+VgHog8KL92
 eF7zM0hS1g79nK1yKk63NpM2GhS9Z40y75jyaUgi991qPWa4c+B34sDfB4JGoYSmqcVF
 wNdVbqjn7XiB2MGMbEP0NSEBN2no3HS6xM97uxO0WxiuPcsFFteZzxLLSf0mRPkE/+A1
 I6OW9iUZjT73bdNTgXX+t/bSaQH1DeTR/HmKRbvYcqmuKJFx0pyK7VSos6KR23NmU3Vt 5g== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2p85ctyw4a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Dec 2018 19:09:48 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wBAJ9hRr005616
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Dec 2018 19:09:43 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wBAJ9gfS019169;
        Mon, 10 Dec 2018 19:09:42 GMT
Received: from marawils-linux.us.oracle.com (/10.141.196.37)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 10 Dec 2018 11:09:42 -0800
From:   Maran Wilson <maran.wilson@oracle.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, jgross@suse.com
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        roger.pau@citrix.com, boris.ostrovsky@oracle.com,
        rkrcmar@redhat.com, maran.wilson@oracle.com
Subject: [PATCH v9 7/7] KVM: x86: Allow Qemu/KVM to use PVH entry point
Date:   Mon, 10 Dec 2018 11:09:35 -0800
Message-Id: <1544468975-971-1-git-send-email-maran.wilson@oracle.com>
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

For certain applications it is desirable to rapidly boot a KVM virtual
machine. In cases where legacy hardware and software support within the
guest is not needed, Qemu should be able to boot directly into the
uncompressed Linux kernel binary without the need to run firmware.

There already exists an ABI to allow this for Xen PVH guests and the ABI
is supported by Linux and FreeBSD:

   https://xenbits.xen.org/docs/unstable/misc/pvh.html

This patch enables Qemu to use that same entry point for booting KVM
guests.

Signed-off-by: Maran Wilson <maran.wilson@oracle.com>
Suggested-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Suggested-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Tested-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/Kbuild                   |  2 +-
 arch/x86/platform/pvh/Makefile    |  4 ++--
 arch/x86/platform/pvh/enlighten.c | 42 +++++++++++++++++++++++++++++----------
 3 files changed, 34 insertions(+), 14 deletions(-)

diff --git a/arch/x86/Kbuild b/arch/x86/Kbuild
index 2089e4414300..c625f57472f7 100644
--- a/arch/x86/Kbuild
+++ b/arch/x86/Kbuild
@@ -7,7 +7,7 @@ obj-$(CONFIG_KVM) += kvm/
 # Xen paravirtualization support
 obj-$(CONFIG_XEN) += xen/
 
-obj-$(CONFIG_XEN_PVH) += platform/pvh/
+obj-$(CONFIG_PVH) += platform/pvh/
 
 # Hyper-V paravirtualization support
 obj-$(subst m,y,$(CONFIG_HYPERV)) += hyperv/
diff --git a/arch/x86/platform/pvh/Makefile b/arch/x86/platform/pvh/Makefile
index 9fd25efcd2a3..5dec5067c9fb 100644
--- a/arch/x86/platform/pvh/Makefile
+++ b/arch/x86/platform/pvh/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 OBJECT_FILES_NON_STANDARD_head.o := y
 
-obj-$(CONFIG_XEN_PVH) += enlighten.o
-obj-$(CONFIG_XEN_PVH) += head.o
+obj-$(CONFIG_PVH) += enlighten.o
+obj-$(CONFIG_PVH) += head.o
diff --git a/arch/x86/platform/pvh/enlighten.c b/arch/x86/platform/pvh/enlighten.c
index 8040b3fbf545..62f5c7045944 100644
--- a/arch/x86/platform/pvh/enlighten.c
+++ b/arch/x86/platform/pvh/enlighten.c
@@ -8,6 +8,8 @@
 #include <asm/e820/api.h>
 #include <asm/x86_init.h>
 
+#include <asm/xen/interface.h>
+
 #include <xen/xen.h>
 #include <xen/interface/hvm/start_info.h>
 
@@ -40,11 +42,28 @@ void __init __weak mem_map_via_hcall(struct boot_params *ptr __maybe_unused)
 	BUG();
 }
 
-static void __init init_pvh_bootparams(void)
+static void __init init_pvh_bootparams(bool xen_guest)
 {
 	memset(&pvh_bootparams, 0, sizeof(pvh_bootparams));
 
-	mem_map_via_hcall(&pvh_bootparams);
+	if ((pvh_start_info.version > 0) && (pvh_start_info.memmap_entries)) {
+		struct hvm_memmap_table_entry *ep;
+		int i;
+
+		ep = __va(pvh_start_info.memmap_paddr);
+		pvh_bootparams.e820_entries = pvh_start_info.memmap_entries;
+
+		for (i = 0; i < pvh_bootparams.e820_entries ; i++, ep++) {
+			pvh_bootparams.e820_table[i].addr = ep->addr;
+			pvh_bootparams.e820_table[i].size = ep->size;
+			pvh_bootparams.e820_table[i].type = ep->type;
+		}
+	} else if (xen_guest) {
+		mem_map_via_hcall(&pvh_bootparams);
+	} else {
+		/* Non-xen guests are not supported by version 0 */
+		BUG();
+	}
 
 	if (pvh_bootparams.e820_entries < E820_MAX_ENTRIES_ZEROPAGE - 1) {
 		pvh_bootparams.e820_table[pvh_bootparams.e820_entries].addr =
@@ -75,7 +94,7 @@ static void __init init_pvh_bootparams(void)
 	 * environment (i.e. hardware_subarch 0).
 	 */
 	pvh_bootparams.hdr.version = (2 << 8) | 12;
-	pvh_bootparams.hdr.type_of_loader = (9 << 4) | 0; /* Xen loader */
+	pvh_bootparams.hdr.type_of_loader = ((xen_guest ? 0x9 : 0xb) << 4) | 0;
 
 	x86_init.acpi.get_root_pointer = pvh_get_root_pointer;
 }
@@ -90,13 +109,10 @@ void __init __weak xen_pvh_init(void)
 	BUG();
 }
 
-/*
- * When we add support for other hypervisors like Qemu/KVM, this routine can
- * selectively invoke the appropriate initialization based on guest type.
- */
-static void hypervisor_specific_init(void)
+static void hypervisor_specific_init(bool xen_guest)
 {
-	xen_pvh_init();
+	if (xen_guest)
+		xen_pvh_init();
 }
 
 /*
@@ -105,13 +121,17 @@ static void hypervisor_specific_init(void)
  */
 void __init xen_prepare_pvh(void)
 {
+
+	u32 msr = xen_cpuid_base();
+	bool xen_guest = !!msr;
+
 	if (pvh_start_info.magic != XEN_HVM_START_MAGIC_VALUE) {
 		xen_raw_printk("Error: Unexpected magic value (0x%08x)\n",
 				pvh_start_info.magic);
 		BUG();
 	}
 
-	hypervisor_specific_init();
+	hypervisor_specific_init(xen_guest);
 
-	init_pvh_bootparams();
+	init_pvh_bootparams(xen_guest);
 }
-- 
2.16.1

