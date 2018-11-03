Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC486C65C22
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 00:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91CE22081B
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 00:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="lRBo6zFO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91CE22081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbeKCJYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 05:24:44 -0400
Received: from mail-eopbgr730132.outbound.protection.outlook.com ([40.107.73.132]:13314
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726083AbeKCJYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 05:24:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=elB0b4RJANMXOrrcDtXxiAgB4JKjjV1p01hdytDqM2s=;
 b=lRBo6zFOk5OQmvJWJBj7o0yN/fWJpUMYNMX1OXooRzHR2JGySc9ccHnCAg9b5Ixp3jVtSQq7WgvLQ3Ct4azBeTT2imtsyVETlBDvn92g2VQgDHoZNT45CUFaNDsSRR9MCgUHjAiyePqT7rWyyDXYZTCTkCEQiG78opnm9GPMWj0=
Received: from MWHPR21MB0766.namprd21.prod.outlook.com (10.173.51.20) by
 MWHPR21MB0286.namprd21.prod.outlook.com (10.173.53.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1294.2; Sat, 3 Nov 2018 00:15:18 +0000
Received: from MWHPR21MB0766.namprd21.prod.outlook.com
 ([fe80::1982:5e59:2489:88e6]) by MWHPR21MB0766.namprd21.prod.outlook.com
 ([fe80::1982:5e59:2489:88e6%14]) with mapi id 15.20.1339.000; Sat, 3 Nov 2018
 00:15:18 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "will.deacon@arm.com" <will.deacon@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        vkuznets <vkuznets@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>
CC:     Michael Kelley <mikelley@microsoft.com>
Subject: [PATCH v3 2/4] arm64: hyperv: Add support for Hyper-V as a hypervisor
Thread-Topic: [PATCH v3 2/4] arm64: hyperv: Add support for Hyper-V as a
 hypervisor
Thread-Index: AQHUcwpNYNgy9IxOSUapoVdlB+kp4Q==
Date:   Sat, 3 Nov 2018 00:15:18 +0000
Message-ID: <1541204037-18043-3-git-send-email-mikelley@microsoft.com>
References: <1541204037-18043-1-git-send-email-mikelley@microsoft.com>
In-Reply-To: <1541204037-18043-1-git-send-email-mikelley@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR2201CA0011.namprd22.prod.outlook.com
 (2603:10b6:301:28::24) To MWHPR21MB0766.namprd21.prod.outlook.com
 (2603:10b6:300:76::20)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [131.107.174.136]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR21MB0286;6:XxpPWksUWcChTAxeJZwzW++b3/v0wBXaTeVWEbm1fWbiG1d2h20yoxxqxdDZFDScuMT5WZD29rFkXBWKWm4D8bvSIwVwIWw4/XeSIPtHvwP5z6TJXR2QbBtfwYBV0dpr3LUKeBpBuRxfHzZBBr8E3iZ4Y1dr2g+ZMXx/SPrKHGgqJt0pGMmhR8zDuLP2tKMfdrKzhnTTW2IdNYiR1lSvDxPYxvvjvhljq82snRCiSSP/miqWOenOjSjjyDrKm69goveQ3/xch9W+H3slgqFvWLrRLCcySqV+TiygZC1C8Z8lU299ZvN8KSw6iRfu/0mKrOtiRbvZtsjimNEHn+2g1i1UWq4XtfT5wEmTWAFUovD7bDK68EOqUBsNVqRiCB0GqwnvCzL+nXnelI9s4M56P9fqalHOaKaS4LbwR9OUqPD9FTonYTX43wR3q8VUrCGcLKRzUp0UWP7g0Z6xd6kXYg==;5:cBRkTFXFgUghgU/cVi/VUjM/yLSismYDvEX13XhJBn2R9wZy8K0a5K59TdP/AA8xS8RRWYooU2q2921fTBwEAwmpdYjvZ9seS9sTsGdtkpluZzWKX8pcmdEfuL4JE+niYSit1oZHE9X+GSKyGlVtbWLoj3iSK/RJ3Nk5xZjYqco=;7:OEfHaIVhcHfLoqqjdzumIZBfe3D8ePROX6S0C2CLjvGKZo46B83kdRLCd27bXp2bIbA0J8LKKSN9AOner/o2V5Ytia8Yx7iQlU4rGdi/Joo2OzJQs0X1iofBwEmMqG9RFRMckIGWsXuFaO/gihXBKw==
x-ms-office365-filtering-correlation-id: 46ce24dc-49c1-4e5f-702d-08d641216f9c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MWHPR21MB0286;
x-ms-traffictypediagnostic: MWHPR21MB0286:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-o365eop-header: O365_EOP: Allow for Unauthenticated Relay
x-o365ent-eop-header: Message processed by -  O365_ENT: Allow from ranges
 (Engineering ONLY)
x-microsoft-antispam-prvs: <MWHPR21MB0286ABE1B56EF1210B7F08F6D7C80@MWHPR21MB0286.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(8220035)(2401047)(8121501046)(5005006)(10201501046)(3231382)(944501410)(52105095)(2018427008)(3002001)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:MWHPR21MB0286;BCL:0;PCL:0;RULEID:;SRVR:MWHPR21MB0286;
x-forefront-prvs: 08457955C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(136003)(366004)(39860400002)(189003)(199004)(6506007)(316002)(386003)(2501003)(7736002)(81156014)(81166006)(2201001)(22452003)(2900100001)(99286004)(66066001)(8936002)(53936002)(53946003)(476003)(3846002)(14454004)(110136005)(10090500001)(36756003)(76176011)(5660300001)(6636002)(1511001)(86362001)(305945005)(8676002)(52116002)(86612001)(11346002)(6116002)(4326008)(14444005)(7416002)(256004)(97736004)(102836004)(486006)(10290500003)(71200400001)(71190400001)(4744004)(6512007)(6486002)(25786009)(186003)(105586002)(26005)(2616005)(107886003)(68736007)(446003)(478600001)(106356001)(2906002)(6436002)(2004002)(921003)(1121003)(579004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR21MB0286;H:MWHPR21MB0766.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: G1JyCFzHQFXkMfnkSCBCbIgCKdIUgzn7EZ7r1OoTIzEle74zdZmPNR6ZCacgPM1iqkRmZNuB1/Sykk9QDrHUbFeyg6V+eW+rQH0hkfOdH/4nUewRL0/euAmA2s7iaW9QCzeSyBp/Z+gF17cEkBa6lEW9YRGvWz8dN8lww2titlHZGIY6l8qvKlKCMnRXThN40SPlSNP+AZfpSUbtqhYWDR1RrbxgSMF+Q3l5OgS2hVu9b645tolzgilIjvCiIRFLvefTjuRDSpPIdk55hN+t52PGtm3cv0LHbbze0mOYPF2uJoKMA6m72o9+LiVXjPCY5B4yCoa8EkQ80t3byLB3PoV6giE7NjT2o/XgrY7pbCU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46ce24dc-49c1-4e5f-702d-08d641216f9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2018 00:15:18.3315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0286
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ARM64-specific code to enable Hyper-V. This code includes:
* Detecting Hyper-V and initializing the guest/Hyper-V interface
* Setting up Hyper-V's synthetic clocks
* Making hypercalls using the HVC instruction
* Setting up VMbus and stimer0 interrupts
* Setting up kexec and crash handlers
This code is architecture dependent code and is mostly driven by
architecture independent code in the VMbus driver in drivers/hv/hv.c
and drivers/hv/vmbus_drv.c.

This code is built only when CONFIG_HYPERV is enabled.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 MAINTAINERS                  |   1 +
 arch/arm64/Makefile          |   1 +
 arch/arm64/hyperv/Makefile   |   2 +
 arch/arm64/hyperv/hv_hvc.S   |  54 ++++++
 arch/arm64/hyperv/hv_init.c  | 441 +++++++++++++++++++++++++++++++++++++++=
++++
 arch/arm64/hyperv/mshyperv.c | 178 +++++++++++++++++
 6 files changed, 677 insertions(+)
 create mode 100644 arch/arm64/hyperv/Makefile
 create mode 100644 arch/arm64/hyperv/hv_hvc.S
 create mode 100644 arch/arm64/hyperv/hv_init.c
 create mode 100644 arch/arm64/hyperv/mshyperv.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 00c7bad..6e55f55 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6800,6 +6800,7 @@ F:	arch/x86/kernel/cpu/mshyperv.c
 F:	arch/x86/hyperv
 F:	arch/arm64/include/asm/hyperv-tlfs.h
 F:	arch/arm64/include/asm/mshyperv.h
+F:	arch/arm64/hyperv
 F:	drivers/hid/hid-hyperv.c
 F:	drivers/hv/
 F:	drivers/input/serio/hyperv-keyboard.c
diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index b4e994c..114fdfa 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -106,6 +106,7 @@ core-y		+=3D arch/arm64/kernel/ arch/arm64/mm/
 core-$(CONFIG_NET) +=3D arch/arm64/net/
 core-$(CONFIG_KVM) +=3D arch/arm64/kvm/
 core-$(CONFIG_XEN) +=3D arch/arm64/xen/
+core-$(CONFIG_HYPERV) +=3D arch/arm64/hyperv/
 core-$(CONFIG_CRYPTO) +=3D arch/arm64/crypto/
 libs-y		:=3D arch/arm64/lib/ $(libs-y)
 core-$(CONFIG_EFI_STUB) +=3D $(objtree)/drivers/firmware/efi/libstub/lib.a
diff --git a/arch/arm64/hyperv/Makefile b/arch/arm64/hyperv/Makefile
new file mode 100644
index 0000000..988eda5
--- /dev/null
+++ b/arch/arm64/hyperv/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-y		:=3D hv_init.o hv_hvc.o mshyperv.o
diff --git a/arch/arm64/hyperv/hv_hvc.S b/arch/arm64/hyperv/hv_hvc.S
new file mode 100644
index 0000000..8263696
--- /dev/null
+++ b/arch/arm64/hyperv/hv_hvc.S
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Microsoft Hyper-V hypervisor invocation routines
+ *
+ * Copyright (C) 2018, Microsoft, Inc.
+ *
+ * Author : Michael Kelley <mikelley@microsoft.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as publishe=
d
+ * by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
+ * NON INFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ */
+
+#include <linux/linkage.h>
+
+	.text
+/*
+ * Do the HVC instruction.  For Hyper-V the argument is always 1.
+ * x0 contains the hypercall control value, while additional registers
+ * vary depending on the hypercall, and whether the hypercall arguments
+ * are in memory or in registers (a "fast" hypercall per the Hyper-V
+ * TLFS).  When the arguments are in memory x1 is the guest physical
+ * address of the input arguments, and x2 is the guest physical
+ * address of the output arguments.  When the arguments are in
+ * registers, the register values depends on the hypercall.  Note
+ * that this version cannot return any values in registers.
+ */
+ENTRY(hv_do_hvc)
+	hvc #1
+	ret
+ENDPROC(hv_do_hvc)
+
+/*
+ * This variant of HVC invocation is for hv_get_vpreg and
+ * hv_get_vpreg_128. The input parameters are passed in registers
+ * along with a pointer in x4 to where the output result should
+ * be stored. The output is returned in x15 and x16.  x18 is used as
+ * scratch space to avoid buildng a stack frame, as Hyper-V does
+ * not preserve registers x0-x17.
+ */
+ENTRY(hv_do_hvc_fast_get)
+	mov x18, x4
+	hvc #1
+	str x15,[x18]
+	str x16,[x18,#8]
+	ret
+ENDPROC(hv_do_hvc_fast_get)
diff --git a/arch/arm64/hyperv/hv_init.c b/arch/arm64/hyperv/hv_init.c
new file mode 100644
index 0000000..aa1a8c0
--- /dev/null
+++ b/arch/arm64/hyperv/hv_init.c
@@ -0,0 +1,441 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Initialization of the interface with Microsoft's Hyper-V hypervisor,
+ * and various low level utility routines for interacting with Hyper-V.
+ *
+ * Copyright (C) 2018, Microsoft, Inc.
+ *
+ * Author : Michael Kelley <mikelley@microsoft.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as publishe=
d
+ * by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
+ * NON INFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ */
+
+
+#include <linux/types.h>
+#include <linux/version.h>
+#include <linux/export.h>
+#include <linux/vmalloc.h>
+#include <linux/mm.h>
+#include <linux/clocksource.h>
+#include <linux/sched_clock.h>
+#include <linux/acpi.h>
+#include <linux/module.h>
+#include <linux/hyperv.h>
+#include <linux/slab.h>
+#include <linux/cpuhotplug.h>
+#include <linux/psci.h>
+#include <asm-generic/bug.h>
+#include <asm/hypervisor.h>
+#include <asm/hyperv-tlfs.h>
+#include <asm/mshyperv.h>
+#include <asm/sysreg.h>
+#include <clocksource/arm_arch_timer.h>
+
+static bool	hyperv_initialized;
+struct		ms_hyperv_info ms_hyperv;
+EXPORT_SYMBOL_GPL(ms_hyperv);
+
+static struct ms_hyperv_tsc_page *tsc_pg;
+
+struct ms_hyperv_tsc_page *hv_get_tsc_page(void)
+{
+	return tsc_pg;
+}
+EXPORT_SYMBOL_GPL(hv_get_tsc_page);
+
+static u64 read_hv_sched_clock_tsc(void)
+{
+	u64 current_tick =3D hv_read_tsc_page(tsc_pg);
+
+	if (current_tick =3D=3D U64_MAX)
+		current_tick =3D hv_get_vpreg(HV_REGISTER_TIME_REFCOUNT);
+
+	return current_tick;
+}
+
+static u64 read_hv_clock_tsc(struct clocksource *arg)
+{
+	u64 current_tick =3D hv_read_tsc_page(tsc_pg);
+
+	if (current_tick =3D=3D U64_MAX)
+		current_tick =3D hv_get_vpreg(HV_REGISTER_TIME_REFCOUNT);
+
+	return current_tick;
+}
+
+static struct clocksource hyperv_cs_tsc =3D {
+		.name		=3D "hyperv_clocksource_tsc_page",
+		.rating		=3D 400,
+		.read		=3D read_hv_clock_tsc,
+		.mask		=3D CLOCKSOURCE_MASK(64),
+		.flags		=3D CLOCK_SOURCE_IS_CONTINUOUS,
+};
+
+static u64 read_hv_sched_clock_msr(void)
+{
+	return hv_get_vpreg(HV_REGISTER_TIME_REFCOUNT);
+}
+
+static u64 read_hv_clock_msr(struct clocksource *arg)
+{
+	return hv_get_vpreg(HV_REGISTER_TIME_REFCOUNT);
+}
+
+static struct clocksource hyperv_cs_msr =3D {
+	.name		=3D "hyperv_clocksource_msr",
+	.rating		=3D 400,
+	.read		=3D read_hv_clock_msr,
+	.mask		=3D CLOCKSOURCE_MASK(64),
+	.flags		=3D CLOCK_SOURCE_IS_CONTINUOUS,
+};
+
+struct clocksource *hyperv_cs;
+EXPORT_SYMBOL_GPL(hyperv_cs);
+
+u32 *hv_vp_index;
+EXPORT_SYMBOL_GPL(hv_vp_index);
+
+u32 hv_max_vp_index;
+
+static int hv_cpu_init(unsigned int cpu)
+{
+	u64 msr_vp_index;
+
+	hv_get_vp_index(msr_vp_index);
+
+	hv_vp_index[smp_processor_id()] =3D msr_vp_index;
+
+	if (msr_vp_index > hv_max_vp_index)
+		hv_max_vp_index =3D msr_vp_index;
+
+	return 0;
+}
+
+/*
+ * This function is invoked via the ACPI clocksource probe mechanism. We
+ * don't actually use any values from the ACPI GTDT table, but we set up
+ * the Hyper-V synthetic clocksource and do other initialization for
+ * interacting with Hyper-V the first time.  Using early_initcall to invok=
e
+ * this function is too late because interrupts are already enabled at tha=
t
+ * point, and sched_clock_register must run before interrupts are enabled.
+ *
+ * 1. Setup the guest ID.
+ * 2. Get features and hints info from Hyper-V
+ * 3. Setup per-cpu VP indices.
+ * 4. Register Hyper-V specific clocksource.
+ * 5. Register the scheduler clock.
+ */
+
+static int __init hyperv_init(struct acpi_table_header *table)
+{
+	struct hv_get_vp_register_output result;
+	u32	a, b, c, d;
+	u64	guest_id;
+	int	i;
+
+	/*
+	 * If we're in a VM on Hyper-V, the ACPI hypervisor_id field will
+	 * have the string "MsHyperV".
+	 */
+	if (strncmp((char *)&acpi_gbl_FADT.hypervisor_id, "MsHyperV", 8))
+		return 1;
+
+	/* Setup the guest ID */
+	guest_id =3D generate_guest_id(0, LINUX_VERSION_CODE, 0);
+	hv_set_vpreg(HV_REGISTER_GUEST_OSID, guest_id);
+
+	/* Get the features and hints from Hyper-V */
+	hv_get_vpreg_128(HV_REGISTER_PRIVILEGES_AND_FEATURES, &result);
+	ms_hyperv.features =3D lower_32_bits(result.registervaluelow);
+	ms_hyperv.misc_features =3D upper_32_bits(result.registervaluehigh);
+
+	hv_get_vpreg_128(HV_REGISTER_FEATURES, &result);
+	ms_hyperv.hints =3D lower_32_bits(result.registervaluelow);
+
+	pr_info("Hyper-V: Features 0x%x, hints 0x%x\n",
+		ms_hyperv.features, ms_hyperv.hints);
+
+	/*
+	 * Direct mode is the only option for STIMERs provided Hyper-V
+	 * on ARM64, so Hyper-V doesn't actually set the flag.  But add the
+	 * flag so the architecture independent code in drivers/hv/hv.c
+	 * will correctly use that mode.
+	 */
+	ms_hyperv.misc_features |=3D HV_STIMER_DIRECT_MODE_AVAILABLE;
+
+	/*
+	 * Hyper-V on ARM64 doesn't support AutoEOI.  Add the hint
+	 * that tells architecture independent code not to use this
+	 * feature.
+	 */
+	ms_hyperv.hints |=3D HV_DEPRECATING_AEOI_RECOMMENDED;
+
+	/* Get information about the Hyper-V host version */
+	hv_get_vpreg_128(HV_REGISTER_HYPERVISOR_VERSION, &result);
+	a =3D lower_32_bits(result.registervaluelow);
+	b =3D upper_32_bits(result.registervaluelow);
+	c =3D lower_32_bits(result.registervaluehigh);
+	d =3D upper_32_bits(result.registervaluehigh);
+	pr_info("Hyper-V: Host Build %d.%d.%d.%d-%d-%d\n",
+		b >> 16, b & 0xFFFF, a, d & 0xFFFFFF, c, d >> 24);
+
+	/* Allocate percpu VP index */
+	hv_vp_index =3D kmalloc_array(num_possible_cpus(), sizeof(*hv_vp_index),
+				    GFP_KERNEL);
+	if (!hv_vp_index)
+		return 1;
+
+	for (i =3D 0; i < num_possible_cpus(); i++)
+		hv_vp_index[i] =3D VP_INVAL;
+
+	if (cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "arm64/hyperv_init:online",
+			      hv_cpu_init, NULL) < 0)
+		goto free_vp_index;
+
+	/*
+	 * Try to set up what Hyper-V calls the "TSC reference page", which
+	 * uses the ARM Generic Timer virtual counter with some scaling
+	 * information to provide a fast and stable guest VM clocksource.
+	 * If the TSC reference page can't be set up, fall back to reading
+	 * the guest clock provided by Hyper-V's synthetic reference time
+	 * register.
+	 */
+	if (ms_hyperv.features & HV_MSR_REFERENCE_TSC_AVAILABLE) {
+
+		u64		tsc_msr;
+		phys_addr_t	phys_addr;
+
+		tsc_pg =3D __vmalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL, PAGE_KERNEL);
+		if (tsc_pg) {
+			phys_addr =3D page_to_phys(vmalloc_to_page(tsc_pg));
+			tsc_msr =3D hv_get_vpreg(HV_REGISTER_REFERENCE_TSC);
+			tsc_msr &=3D GENMASK_ULL(11, 0);
+			tsc_msr =3D tsc_msr | 0x1 | (u64)phys_addr;
+			hv_set_vpreg(HV_REGISTER_REFERENCE_TSC, tsc_msr);
+			hyperv_cs =3D &hyperv_cs_tsc;
+			sched_clock_register(read_hv_sched_clock_tsc,
+						64, HV_CLOCK_HZ);
+		}
+	}
+
+	if (!hyperv_cs &&
+	    (ms_hyperv.features & HV_MSR_TIME_REF_COUNT_AVAILABLE)) {
+		hyperv_cs =3D &hyperv_cs_msr;
+		sched_clock_register(read_hv_sched_clock_msr,
+						64, HV_CLOCK_HZ);
+	}
+
+	if (hyperv_cs) {
+		hyperv_cs->archdata.vdso_direct =3D false;
+		clocksource_register_hz(hyperv_cs, HV_CLOCK_HZ);
+	}
+
+	hyperv_initialized =3D true;
+	return 0;
+
+free_vp_index:
+	kfree(hv_vp_index);
+	hv_vp_index =3D NULL;
+	return 1;
+}
+TIMER_ACPI_DECLARE(hyperv, ACPI_SIG_GTDT, hyperv_init);
+
+/*
+ * This routine is called before kexec/kdump, it does the required cleanup=
.
+ */
+void hyperv_cleanup(void)
+{
+	/* Reset our OS id */
+	hv_set_vpreg(HV_REGISTER_GUEST_OSID, 0);
+
+}
+EXPORT_SYMBOL_GPL(hyperv_cleanup);
+
+/*
+ * hv_do_hypercall- Invoke the specified hypercall
+ */
+u64 hv_do_hypercall(u64 control, void *input, void *output)
+{
+	u64 input_address;
+	u64 output_address;
+
+	input_address =3D input ? virt_to_phys(input) : 0;
+	output_address =3D output ? virt_to_phys(output) : 0;
+	return hv_do_hvc(control, input_address, output_address);
+}
+EXPORT_SYMBOL_GPL(hv_do_hypercall);
+
+/*
+ * hv_do_fast_hypercall8 -- Invoke the specified hypercall
+ * with arguments in registers instead of physical memory.
+ * Avoids the overhead of virt_to_phys for simple hypercalls.
+ */
+
+u64 hv_do_fast_hypercall8(u16 code, u64 input)
+{
+	u64 control;
+
+	control =3D (u64)code | HV_HYPERCALL_FAST_BIT;
+	return hv_do_hvc(control, input);
+}
+EXPORT_SYMBOL_GPL(hv_do_fast_hypercall8);
+
+
+/*
+ * Set a single VP register to a 64-bit value.
+ */
+void hv_set_vpreg(u32 msr, u64 value)
+{
+	union hv_hypercall_status status;
+
+	status.as_uint64 =3D hv_do_hvc(
+		HVCALL_SET_VP_REGISTERS | HV_HYPERCALL_FAST_BIT |
+			HV_HYPERCALL_REP_COUNT_1,
+		HV_PARTITION_ID_SELF,
+		HV_VP_INDEX_SELF,
+		msr,
+		0,
+		value,
+		0);
+
+	/*
+	 * Something is fundamentally broken in the hypervisor if
+	 * setting a VP register fails. There's really no way to
+	 * continue as a guest VM, so panic.
+	 */
+	BUG_ON(status.status !=3D HV_STATUS_SUCCESS);
+}
+EXPORT_SYMBOL_GPL(hv_set_vpreg);
+
+
+/*
+ * Get the value of a single VP register, and only the low order 64 bits.
+ */
+u64 hv_get_vpreg(u32 msr)
+{
+	union hv_hypercall_status status;
+	struct hv_get_vp_register_output output;
+
+	status.as_uint64 =3D hv_do_hvc_fast_get(
+		HVCALL_GET_VP_REGISTERS | HV_HYPERCALL_FAST_BIT |
+			HV_HYPERCALL_REP_COUNT_1,
+		HV_PARTITION_ID_SELF,
+		HV_VP_INDEX_SELF,
+		msr,
+		&output);
+
+	/*
+	 * Something is fundamentally broken in the hypervisor if
+	 * getting a VP register fails. There's really no way to
+	 * continue as a guest VM, so panic.
+	 */
+	BUG_ON(status.status !=3D HV_STATUS_SUCCESS);
+
+	return output.registervaluelow;
+}
+EXPORT_SYMBOL_GPL(hv_get_vpreg);
+
+/*
+ * Get the value of a single VP register that is 128 bits in size.  This i=
s a
+ * separate call in order to avoid complicating the calling sequence for
+ * the much more frequently used 64-bit version.
+ */
+void hv_get_vpreg_128(u32 msr, struct hv_get_vp_register_output *result)
+{
+	union hv_hypercall_status status;
+
+	status.as_uint64 =3D hv_do_hvc_fast_get(
+		HVCALL_GET_VP_REGISTERS | HV_HYPERCALL_FAST_BIT |
+			HV_HYPERCALL_REP_COUNT_1,
+		HV_PARTITION_ID_SELF,
+		HV_VP_INDEX_SELF,
+		msr,
+		result);
+
+	/*
+	 * Something is fundamentally broken in the hypervisor if
+	 * getting a VP register fails. There's really no way to
+	 * continue as a guest VM, so panic.
+	 */
+	BUG_ON(status.status !=3D HV_STATUS_SUCCESS);
+
+	return;
+
+}
+EXPORT_SYMBOL_GPL(hv_get_vpreg_128);
+
+void hyperv_report_panic(struct pt_regs *regs, long err)
+{
+	static bool panic_reported;
+	u64 guest_id;
+
+	/*
+	 * We prefer to report panic on 'die' chain as we have proper
+	 * registers to report, but if we miss it (e.g. on BUG()) we need
+	 * to report it on 'panic'.
+	 */
+	if (panic_reported)
+		return;
+	panic_reported =3D true;
+
+	guest_id =3D hv_get_vpreg(HV_REGISTER_GUEST_OSID);
+
+	/*
+	 * Hyper-V provides the ability to store only 5 values.
+	 * Pick the passed in error value, the guest_id, and the PC.
+	 * The first two general registers are added arbitrarily.
+	 */
+	hv_set_vpreg(HV_REGISTER_CRASH_P0, err);
+	hv_set_vpreg(HV_REGISTER_CRASH_P1, guest_id);
+	hv_set_vpreg(HV_REGISTER_CRASH_P2, regs->pc);
+	hv_set_vpreg(HV_REGISTER_CRASH_P3, regs->regs[0]);
+	hv_set_vpreg(HV_REGISTER_CRASH_P4, regs->regs[1]);
+
+	/*
+	 * Let Hyper-V know there is crash data available
+	 */
+	hv_set_vpreg(HV_REGISTER_CRASH_CTL, HV_CRASH_CTL_CRASH_NOTIFY);
+}
+EXPORT_SYMBOL_GPL(hyperv_report_panic);
+
+/*
+ * hyperv_report_panic_msg - report panic message to Hyper-V
+ * @pa: physical address of the panic page containing the message
+ * @size: size of the message in the page
+ */
+void hyperv_report_panic_msg(phys_addr_t pa, size_t size)
+{
+	/*
+	 * P3 to contain the physical address of the panic page & P4 to
+	 * contain the size of the panic data in that page. Rest of the
+	 * registers are no-op when the NOTIFY_MSG flag is set.
+	 */
+	hv_set_vpreg(HV_REGISTER_CRASH_P0, 0);
+	hv_set_vpreg(HV_REGISTER_CRASH_P1, 0);
+	hv_set_vpreg(HV_REGISTER_CRASH_P2, 0);
+	hv_set_vpreg(HV_REGISTER_CRASH_P3, pa);
+	hv_set_vpreg(HV_REGISTER_CRASH_P4, size);
+
+	/*
+	 * Let Hyper-V know there is crash data available along with
+	 * the panic message.
+	 */
+	hv_set_vpreg(HV_REGISTER_CRASH_CTL,
+	       (HV_CRASH_CTL_CRASH_NOTIFY | HV_CRASH_CTL_CRASH_NOTIFY_MSG));
+}
+EXPORT_SYMBOL_GPL(hyperv_report_panic_msg);
+
+bool hv_is_hyperv_initialized(void)
+{
+	return hyperv_initialized;
+}
+EXPORT_SYMBOL_GPL(hv_is_hyperv_initialized);
diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
new file mode 100644
index 0000000..3ef0555
--- /dev/null
+++ b/arch/arm64/hyperv/mshyperv.c
@@ -0,0 +1,178 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Core routines for interacting with Microsoft's Hyper-V hypervisor,
+ * including setting up VMbus and STIMER interrupts, and handling
+ * crashes and kexecs. These interactions are through a set of
+ * static "handler" variables set by the architecture independent
+ * VMbus and STIMER drivers.  This design is used to meet x86/x64
+ * requirements for avoiding direct linkages and allowing the VMbus
+ * and STIMER drivers to be unloaded and reloaded.
+ *
+ * Copyright (C) 2018, Microsoft, Inc.
+ *
+ * Author : Michael Kelley <mikelley@microsoft.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as publishe=
d
+ * by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
+ * NON INFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ */
+
+#include <linux/types.h>
+#include <linux/export.h>
+#include <linux/interrupt.h>
+#include <linux/kexec.h>
+#include <linux/acpi.h>
+#include <linux/ptrace.h>
+#include <asm/hyperv-tlfs.h>
+#include <asm/mshyperv.h>
+
+static void (*vmbus_handler)(void);
+static void (*hv_stimer0_handler)(void);
+static void (*hv_kexec_handler)(void);
+static void (*hv_crash_handler)(struct pt_regs *regs);
+
+static int vmbus_irq;
+static long __percpu *vmbus_evt;
+static long __percpu *stimer0_evt;
+
+irqreturn_t hyperv_vector_handler(int irq, void *dev_id)
+{
+	if (vmbus_handler)
+		vmbus_handler();
+	return IRQ_HANDLED;
+}
+
+/* Must be done just once */
+void hv_setup_vmbus_irq(void (*handler)(void))
+{
+	int result;
+
+	vmbus_handler =3D handler;
+	vmbus_irq =3D acpi_register_gsi(NULL, HYPERVISOR_CALLBACK_VECTOR,
+				 ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_HIGH);
+	if (vmbus_irq <=3D 0) {
+		pr_err("Can't register Hyper-V VMBus GSI. Error %d",
+			vmbus_irq);
+		vmbus_irq =3D 0;
+		return;
+	}
+	vmbus_evt =3D alloc_percpu(long);
+	result =3D request_percpu_irq(vmbus_irq, hyperv_vector_handler,
+			"Hyper-V VMbus", vmbus_evt);
+	if (result) {
+		pr_err("Can't request Hyper-V VMBus IRQ %d. Error %d",
+			vmbus_irq, result);
+		free_percpu(vmbus_evt);
+		acpi_unregister_gsi(vmbus_irq);
+		vmbus_irq =3D 0;
+	}
+}
+EXPORT_SYMBOL_GPL(hv_setup_vmbus_irq);
+
+/* Must be done just once */
+void hv_remove_vmbus_irq(void)
+{
+	if (vmbus_irq) {
+		free_percpu_irq(vmbus_irq, vmbus_evt);
+		free_percpu(vmbus_evt);
+		acpi_unregister_gsi(vmbus_irq);
+	}
+}
+EXPORT_SYMBOL_GPL(hv_remove_vmbus_irq);
+
+/* Must be done by each CPU */
+void hv_enable_vmbus_irq(void)
+{
+	enable_percpu_irq(vmbus_irq, 0);
+}
+EXPORT_SYMBOL_GPL(hv_enable_vmbus_irq);
+
+/* Must be done by each CPU */
+void hv_disable_vmbus_irq(void)
+{
+	disable_percpu_irq(vmbus_irq);
+}
+EXPORT_SYMBOL_GPL(hv_disable_vmbus_irq);
+
+/* Routines to do per-architecture handling of STIMER0 when in Direct Mode=
 */
+
+static irqreturn_t hv_stimer0_vector_handler(int irq, void *dev_id)
+{
+	if (hv_stimer0_handler)
+		hv_stimer0_handler();
+	return IRQ_HANDLED;
+}
+
+int hv_setup_stimer0_irq(int *irq, int *vector, void (*handler)(void))
+{
+	int localirq;
+	int result;
+
+	localirq =3D acpi_register_gsi(NULL, HV_STIMER0_IRQNR,
+			ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_HIGH);
+	if (localirq <=3D 0) {
+		pr_err("Can't register Hyper-V stimer0 GSI. Error %d",
+			localirq);
+		*irq =3D 0;
+		return -1;
+	}
+	stimer0_evt =3D alloc_percpu(long);
+	result =3D request_percpu_irq(localirq, hv_stimer0_vector_handler,
+					 "Hyper-V stimer0", stimer0_evt);
+	if (result) {
+		pr_err("Can't request Hyper-V stimer0 IRQ %d. Error %d",
+			localirq, result);
+		free_percpu(stimer0_evt);
+		acpi_unregister_gsi(localirq);
+		*irq =3D 0;
+		return -1;
+	}
+
+	hv_stimer0_handler =3D handler;
+	*vector =3D HV_STIMER0_IRQNR;
+	*irq =3D localirq;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(hv_setup_stimer0_irq);
+
+void hv_remove_stimer0_irq(int irq)
+{
+	hv_stimer0_handler =3D NULL;
+	if (irq) {
+		free_percpu_irq(irq, stimer0_evt);
+		free_percpu(stimer0_evt);
+		acpi_unregister_gsi(irq);
+	}
+}
+EXPORT_SYMBOL_GPL(hv_remove_stimer0_irq);
+
+void hv_setup_kexec_handler(void (*handler)(void))
+{
+	hv_kexec_handler =3D handler;
+}
+EXPORT_SYMBOL_GPL(hv_setup_kexec_handler);
+
+void hv_remove_kexec_handler(void)
+{
+	hv_kexec_handler =3D NULL;
+}
+EXPORT_SYMBOL_GPL(hv_remove_kexec_handler);
+
+void hv_setup_crash_handler(void (*handler)(struct pt_regs *regs))
+{
+	hv_crash_handler =3D handler;
+}
+EXPORT_SYMBOL_GPL(hv_setup_crash_handler);
+
+void hv_remove_crash_handler(void)
+{
+	hv_crash_handler =3D NULL;
+}
+EXPORT_SYMBOL_GPL(hv_remove_crash_handler);
--=20
1.8.3.1

