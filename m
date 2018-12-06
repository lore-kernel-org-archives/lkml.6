Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B93C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 06:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03B3F20989
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 06:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LN+1Pi69"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03B3F20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729073AbeLFGHL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 01:07:11 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:49870 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728904AbeLFGHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 01:07:11 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB660BUr188608;
        Thu, 6 Dec 2018 06:06:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=vPo8PEWl8MwRDXOc9f6xQL8UvHGeRZ0TI2T0Zv3tnR4=;
 b=LN+1Pi69CPR0P3fZtNt3U4dpIR5JTT/iT0G8r8hR7BgfDY/PuNhX/LczzZrZaKv7SbbW
 WsjM8TU3QKVPZOB9uokTZEdmNsOdyeuyD36P9hOS6UQk3QttRCjg2Ey8+1/wpEOWcRN1
 J5+D4VqPjQvQ+Sun43Fe89Koiig4U+1OBmHMbOcxxxqMuvTz1eWRYr4CY6tr1FTHN8wW
 QptyJKgeXpeRAE2x65RhnLf6EtHwFzqxitDXDiaES7uWzQgaOSVntChmhyGZFFojJgmF
 KRNXlupwVmM1HNQqooGkSOzJh7qbFmP4NfG56fcoDj82z+wp1wuBnLSieOhDNFkHRpUU Xg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2p3ftfa95e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Dec 2018 06:06:45 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wB666i1d026847
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Dec 2018 06:06:44 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wB666hIu007493;
        Thu, 6 Dec 2018 06:06:43 GMT
Received: from marawils-linux.us.oracle.com (/10.141.196.37)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 05 Dec 2018 22:06:43 -0800
From:   Maran Wilson <maran.wilson@oracle.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, jgross@suse.com
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        roger.pau@citrix.com, boris.ostrovsky@oracle.com,
        rkrcmar@redhat.com, maran.wilson@oracle.com
Subject: [PATCH v8 7/7] KVM: x86: Allow Qemu/KVM to use PVH entry point
Date:   Wed,  5 Dec 2018 22:06:35 -0800
Message-Id: <1544076395-22187-1-git-send-email-maran.wilson@oracle.com>
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
 arch/x86/Kconfig                  |  8 ++++++++
 arch/x86/platform/pvh/Makefile    |  4 ++--
 arch/x86/platform/pvh/enlighten.c | 42 +++++++++++++++++++++++++++++----------
 4 files changed, 42 insertions(+), 14 deletions(-)

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
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index c2a22a74abee..61d5ee30027e 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -802,6 +802,14 @@ config PVH
 	  This option enables the PVH entry point for guest virtual machines
 	  as specified in the x86/HVM direct boot ABI.
 
+config KVM_GUEST_PVH
+	bool "Support for running as a KVM PVH guest"
+	depends on KVM_GUEST
+	select PVH
+	---help---
+	  This option enables starting KVM guests via the PVH entry point as
+	  specified in the x86/HVM direct boot ABI.
+
 config KVM_DEBUG_FS
 	bool "Enable debug information for KVM Guests in debugfs"
 	depends on KVM_GUEST && DEBUG_FS
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

