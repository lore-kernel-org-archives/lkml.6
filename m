Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72CB2C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 177CE20673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="bWnSal9N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 177CE20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731780AbeGSOke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 10:40:34 -0400
Received: from mail-sg2apc01on0110.outbound.protection.outlook.com ([104.47.125.110]:44800
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727441AbeGSOke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 10:40:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5AWgZpkk/edxqKo56xUgK6cRx9Hlc0ZeD2gyBxHTMZ0=;
 b=bWnSal9NIJ4trhKV1kyJOLEC0jZIRel6TNBMFOn3KmrSeF/NHjd1Sf+UvC6u5QSv97ad8xa6XrunsJvvYo0+IOrjQnAdXcOIs9H4E1KfMLTFq0QP3cMhFYpIP544Pw/qsIGbpERK678N2oywEPdPnqTkq2G4zRfv2+5BiAXoOMU=
Received: from SG2P15301MB0093.APCP153.PROD.OUTLOOK.COM (10.170.136.145) by
 SG2P15301MB0093.APCP153.PROD.OUTLOOK.COM (10.170.136.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.10; Thu, 19 Jul 2018 13:56:56 +0000
Received: from SG2P15301MB0093.APCP153.PROD.OUTLOOK.COM
 ([fe80::f916:a637:8730:be25]) by SG2P15301MB0093.APCP153.PROD.OUTLOOK.COM
 ([fe80::f916:a637:8730:be25%4]) with mapi id 15.20.0995.008; Thu, 19 Jul 2018
 13:56:56 +0000
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
Subject: [Update PATCH V3 1/4] X86/Hyper-V: Add flush
 HvFlushGuestPhysicalAddressSpace hypercall support
Thread-Topic: [Update PATCH V3 1/4] X86/Hyper-V: Add flush
 HvFlushGuestPhysicalAddressSpace hypercall support
Thread-Index: AQHUH2ha52yGXnLvTUCxheQ0HIxRSA==
Date:   Thu, 19 Jul 2018 13:56:55 +0000
Message-ID: <20180719135626.123819-1-Tianyu.Lan@microsoft.com>
References: <20180719083946.121493-1-Tianyu.Lan@microsoft.com>
In-Reply-To: <20180719083946.121493-1-Tianyu.Lan@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tianyu.Lan@microsoft.com; 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SG2P15301MB0093;6:kZCZPORQznD7+d4JklVJetHgYjMFP3QcMQQwVKLrP3U93RJQO3qQb7ffztiRUfWtfQVFQNT28CYFpj5WDH1gRNceNtaYAD/Rflj4ZmbR3wdhe1RXDbWLXSwyBXUEAAT9wJ8J0UvwKKYfwNr+BtWcfdDl9syoP1lCfyZYayaBDYyfw2jlOkZ63uOOchz5F87OX09M0UBxbcXiNWKS/blHTZHsInXJSLTsBFJEPF0mycIAu1gLbiQqWrNGF/G/1UqzmXh7zfh3NMOcMVHsTgPIIelOS09Iw5/PPEPzBkG3cdVv7Rph9Jqg8QNciet6FK6ynYys2V/7rf/0BeCXiaW2M2l+qYX8Vw5QvP3mv6TTLlDQUER/w1iWFDF1+g5T8jCHgi4iZBNOPWn3CNhrHRB6hiVhwYGKEP/bjs2R5S+Frah4oXqvdSZGqIBGbEFOc/5IUhyAK6Te5d/yKh9O5cKFNQ==;5:2vw9TiR3gifR3q3kcf0cwC9cZaMQg1R1QgeIhLKN/yk9mt9HvzDylYHOMGYlTgVHc/9s4rdDsF5JmML8YrQ4EH2Acok4OkqUggEvh2Fr3IzhwSaHN0wCCNCm6ubTq31vvgqMpcenpN734qsislUyI7Wc3VTMgKJCffOn9uRcz+Y=;7:2leYRvrHrjs3E77fu5c07fT8oTiOCTAeb+ytuhy+IOh25Ph6ExPA+PkgIrSP3C6rZRY7DzfXFr62v8UrWlLtvcevN0gp+VG5+UcXi/S96xc6k+GspZsOKdhZxc9rOxTmfgpIXY0s3Ym6WLKSCrf1N4pd+QcJHkgFqWb6QKbv49SInobGTxZ8+ggv9djj7XKwN/A1iJde8qxX7D2bU/jljuH2JjogVEmQyIaX/uafBrt6FzBdM944RxdqKlXy6peP
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 25e63fd9-e762-454f-d3cd-08d5ed7f7d44
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(2017052603328)(7193020);SRVR:SG2P15301MB0093;
x-ms-traffictypediagnostic: SG2P15301MB0093:
x-microsoft-antispam-prvs: <SG2P15301MB00932ECAA50A7A9BEE5FCF1292520@SG2P15301MB0093.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:SG2P15301MB0093;BCL:0;PCL:0;RULEID:;SRVR:SG2P15301MB0093;
x-forefront-prvs: 0738AF4208
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6029001)(136003)(376002)(346002)(396003)(366004)(39860400002)(199004)(189003)(7416002)(476003)(5250100002)(66066001)(22452003)(36756003)(5660300001)(53936002)(102836004)(6506007)(1671002)(72206003)(11346002)(446003)(99286004)(3846002)(478600001)(86612001)(10290500003)(59246006)(2616005)(14444005)(486006)(575784001)(86362001)(14454004)(1076002)(6116002)(256004)(6436002)(25786009)(305945005)(97736004)(316002)(7736002)(6486002)(54906003)(81166006)(81156014)(4326008)(10090500001)(8676002)(6512007)(8936002)(105586002)(26005)(2900100001)(109986005)(106356001)(2906002)(68736007)(76176011)(49343001)(213903007);DIR:OUT;SFP:1102;SCL:1;SRVR:SG2P15301MB0093;H:SG2P15301MB0093.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: K6NMfS1ahCN6uf++wGm/eoWRkPbYyMC3TdIWFWjBh+Wkfr22ipu8+EhRoD+pta8zyN/Ht5niiaDLwGQfz0zT8o8DOBvdoYIk0REnE1wsvgNGlJVhMW0COOQj4mLQDU9uIbngy/jT6Fi1nVwblmzUiV+tHvLY0Ib2pNNNKTl9z8z/rsDQDPHOoFUTQrVseyfuUJbENgspoOS0Xf+8kHUEkic+WdrVbSmajZSHAuKRvgb9HHrxYTUDGRQfmM/DqPVIhQQU9qs9/S1HdI9TKEJNsOjkIn8+EwomK0FSaYcpML+z0CU6DRaqwwoiLt6xmP2i34yY2PZB6XGZO6i7HU6tnpexBVTgIlMW/lEtEKPdbZo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25e63fd9-e762-454f-d3cd-08d5ed7f7d44
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2018 13:56:55.5280
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2P15301MB0093
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
Change since v3
	Remove GPL boilerplate.

 arch/x86/hyperv/Makefile           |  2 +-
 arch/x86/hyperv/nested.c           | 53 ++++++++++++++++++++++++++++++++++=
++++
 arch/x86/include/asm/hyperv-tlfs.h |  8 ++++++
 arch/x86/include/asm/mshyperv.h    |  2 ++
 4 files changed, 64 insertions(+), 1 deletion(-)
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
index 000000000000..3ad9d0fdea63
--- /dev/null
+++ b/arch/x86/hyperv/nested.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Hyper-V nested virtualization code.
+ *
+ * Copyright (C) 2018, Microsoft, Inc.
+ *
+ * Author : Lan Tianyu <Tianyu.Lan@microsoft.com>
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
