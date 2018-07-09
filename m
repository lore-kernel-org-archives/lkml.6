Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8229EC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1955120673
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="FFd6AxaW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1955120673
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932806AbeGIJCu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 05:02:50 -0400
Received: from mail-sg2apc01on0112.outbound.protection.outlook.com ([104.47.125.112]:22378
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754403AbeGIJCm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 05:02:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+tk0MaA82E9RaTKTcqD52l0qj4gld4RTuBD3g2mD/5w=;
 b=FFd6AxaWChLA248sy9/hrOz0WjGtZDsbE8PWFDI5sSMYgHOz2lZDs3Ab9KHT1QoVTxC4FmOCtHbynQHRAMt4C3S1zOidD+ic/6UzkUBavo6wamT/TVPUfu9MJONgiGYjGWRmsFqJPFWVXA7tf8COPtWaC48TbS8jEA/faWCLSRQ=
Received: from SG2P15301MB0093.APCP153.PROD.OUTLOOK.COM (10.170.136.145) by
 SG2P15301MB0063.APCP153.PROD.OUTLOOK.COM (10.170.136.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.15; Mon, 9 Jul 2018 09:02:35 +0000
Received: from SG2P15301MB0093.APCP153.PROD.OUTLOOK.COM
 ([fe80::f916:a637:8730:be25]) by SG2P15301MB0093.APCP153.PROD.OUTLOOK.COM
 ([fe80::f916:a637:8730:be25%4]) with mapi id 15.20.0952.013; Mon, 9 Jul 2018
 09:02:35 +0000
From:   Tianyu Lan <Tianyu.Lan@microsoft.com>
CC:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>
Subject: [PATCH V2 1/5] X86/Hyper-V: Add flush
 HvFlushGuestPhysicalAddressSpace hypercall support
Thread-Topic: [PATCH V2 1/5] X86/Hyper-V: Add flush
 HvFlushGuestPhysicalAddressSpace hypercall support
Thread-Index: AQHUF2OTueZcpG5JbkW4yjhT+Jne3Q==
Date:   Mon, 9 Jul 2018 09:02:34 +0000
Message-ID: <20180709090218.15342-2-Tianyu.Lan@microsoft.com>
References: <20180709090218.15342-1-Tianyu.Lan@microsoft.com>
In-Reply-To: <20180709090218.15342-1-Tianyu.Lan@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SG2P15301MB0063;7:mxqBVgV/9lq8Fsve6piOPlSJ5Q8G4UQhFzo2ukvTqPkFeT6CRu/XHFSkRFUeuPoEknPSvgQSlIGv/lvk+zJFhzYIH4/C8yvUFSl1xDOpYA8Mgs+11Z0GqWoeZ3KmGBNVhfWo36pI4iDZrgDAdnL2OxlK9LUN8gMgEY/uIL4pJiip0t9+icIzyawFo05PfbQsZeYBJSVGJ2ULJMxFO4yl/dJ54gr9x7m60a16qFJYWvl+btnG0uWQf69nUT2zsa06
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 02e2d429-5874-4e4a-10e6-08d5e57ab691
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(2017052603328)(7193020);SRVR:SG2P15301MB0063;
x-ms-traffictypediagnostic: SG2P15301MB0063:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tianyu.Lan@microsoft.com; 
x-microsoft-antispam-prvs: <SG2P15301MB0063B0AD0263E8F41D263B0292440@SG2P15301MB0063.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:SG2P15301MB0063;BCL:0;PCL:0;RULEID:;SRVR:SG2P15301MB0063;
x-forefront-prvs: 07283408BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6029001)(376002)(136003)(396003)(366004)(39860400002)(346002)(199004)(189003)(256004)(14444005)(105586002)(76176011)(86362001)(6486002)(575784001)(72206003)(66066001)(59246006)(86612001)(6512007)(97736004)(6436002)(2616005)(476003)(8936002)(486006)(14454004)(446003)(11346002)(7416002)(81156014)(81166006)(8676002)(4326008)(109986005)(68736007)(25786009)(2900100001)(106356001)(6116002)(3846002)(1076002)(36756003)(5660300001)(53936002)(305945005)(7736002)(1671002)(5250100002)(54906003)(99286004)(26005)(102836004)(22452003)(10090500001)(10290500003)(2906002)(478600001)(6506007)(316002)(49343001)(2004002)(213903007);DIR:OUT;SFP:1102;SCL:1;SRVR:SG2P15301MB0063;H:SG2P15301MB0093.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: kT2egFiYgQsAi/5yTLwGf04WtPL0Xaq8dTwhPPYFWGX++WttnbcO6FTycf4Br6A0XOFcH9WVLAe2epuqh2adCi1rBLsOWHu0g9FnXRlMk9HrCqw+zZXQGoh1kjTzY4DjeCQ6+s7VRpqeXn8l7IMCNP0a/TmHe59ttA7Wzxn29TpAD6567rn7XM8/0v1uXslZvwmxknQEL3vOP6NR+N0XyQl0ehNwzP/FwzbTHnaB7tYYpfBWRiGu3kIvA4vxsb2WdtxjdhFcQ9tHWDi0/dXqtFF1FIL/iOW3Y/BzLZG20b1eiEIUj0L+4fwH2GVZ4krr2dXF86s0lX/i+rI/f7B110abge1M/fnApWxPW2SWUmE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02e2d429-5874-4e4a-10e6-08d5e57ab691
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2018 09:02:35.0100
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2P15301MB0063
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hyper-V supports a pv hypercall HvFlushGuestPhysicalAddressSpace to
flush nested VM address space mapping in l1 hypervisor and it's to
reduce overhead of flushing ept tlb among vcpus. This patch is to
implement it.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/hyperv/Makefile           |  2 +-
 arch/x86/hyperv/nested.c           | 64 ++++++++++++++++++++++++++++++++++=
++++
 arch/x86/include/asm/hyperv-tlfs.h |  8 +++++
 arch/x86/include/asm/mshyperv.h    |  2 ++
 4 files changed, 75 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/hyperv/nested.c

diff --git a/arch/x86/hyperv/Makefile b/arch/x86/hyperv/Makefile
index b173d404e3df..b21ee65c4101 100644
--- a/arch/x86/hyperv/Makefile
+++ b/arch/x86/hyperv/Makefile
@@ -1,2 +1,2 @@
-obj-y			:=3D hv_init.o mmu.o
+obj-y			:=3D hv_init.o mmu.o nested.o
 obj-$(CONFIG_X86_64)	+=3D hv_apic.o
diff --git a/arch/x86/hyperv/nested.c b/arch/x86/hyperv/nested.c
new file mode 100644
index 000000000000..74dd38b5221d
--- /dev/null
+++ b/arch/x86/hyperv/nested.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Hyper-V nested virtualization code.
+ *
+ * Copyright (C) 2018, Microsoft, Inc.
+ *
+ * Author : Lan Tianyu <Tianyu.Lan@microsoft.com>
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
+ *
+ */
+
+
+#include <linux/types.h>
+#include <asm/hyperv-tlfs.h>
+#include <asm/mshyperv.h>
+#include <asm/tlbflush.h>
+
+int hyperv_flush_guest_mapping(u64 as)
+{
+	struct hv_guest_mapping_flush **flush_pcpu;
+	struct hv_guest_mapping_flush *flush;
+	u64 status;
+	unsigned long flags;
+	int ret =3D -EFAULT;
+
+	if (!hv_hypercall_pg)
+		goto fault;
+
+	local_irq_save(flags);
+
+	flush_pcpu =3D (struct hv_guest_mapping_flush **)
+		this_cpu_ptr(hyperv_pcpu_input_arg);
+
+	flush =3D *flush_pcpu;
+
+	if (unlikely(!flush)) {
+		local_irq_restore(flags);
+		goto fault;
+	}
+
+	flush->address_space =3D as;
+	flush->flags =3D 0;
+
+	status =3D hv_do_hypercall(HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE,
+				 flush, NULL);
+	local_irq_restore(flags);
+
+	if (!(status & HV_HYPERCALL_RESULT_MASK))
+		ret =3D 0;
+
+fault:
+	return ret;
+}
+EXPORT_SYMBOL_GPL(hyperv_flush_guest_mapping);
diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hype=
rv-tlfs.h
index b8c89265baf0..08e24f552030 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -309,6 +309,7 @@ struct ms_hyperv_tsc_page {
 #define HV_X64_MSR_REENLIGHTENMENT_CONTROL	0x40000106
=20
 /* Nested features (CPUID 0x4000000A) EAX */
+#define HV_X64_NESTED_GUEST_MAPPING_FLUSH	BIT(18)
 #define HV_X64_NESTED_MSR_BITMAP		BIT(19)
=20
 struct hv_reenlightenment_control {
@@ -350,6 +351,7 @@ struct hv_tsc_emulation_status {
 #define HVCALL_SEND_IPI_EX			0x0015
 #define HVCALL_POST_MESSAGE			0x005c
 #define HVCALL_SIGNAL_EVENT			0x005d
+#define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE 0x00af
=20
 #define HV_X64_MSR_VP_ASSIST_PAGE_ENABLE	0x00000001
 #define HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_SHIFT	12
@@ -741,6 +743,12 @@ struct ipi_arg_ex {
 	struct hv_vpset vp_set;
 };
=20
+/* HvFlushGuestPhysicalAddressSpace hypercalls */
+struct hv_guest_mapping_flush {
+	u64 address_space;
+	u64 flags;
+};
+
 /* HvFlushVirtualAddressSpace, HvFlushVirtualAddressList hypercalls */
 struct hv_tlb_flush {
 	u64 address_space;
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyper=
v.h
index 3cd14311edfa..a6a615b49876 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -302,6 +302,7 @@ void hyperv_reenlightenment_intr(struct pt_regs *regs);
 void set_hv_tscchange_cb(void (*cb)(void));
 void clear_hv_tscchange_cb(void);
 void hyperv_stop_tsc_emulation(void);
+int hyperv_flush_guest_mapping(u64 as);
=20
 #ifdef CONFIG_X86_64
 void hv_apic_init(void);
@@ -321,6 +322,7 @@ static inline struct hv_vp_assist_page *hv_get_vp_assis=
t_page(unsigned int cpu)
 {
 	return NULL;
 }
+static inline int hyperv_flush_guest_mapping(u64 as) { return -1; }
 #endif /* CONFIG_HYPERV */
=20
 #ifdef CONFIG_HYPERV_TSCPAGE
--=20
2.14.3
