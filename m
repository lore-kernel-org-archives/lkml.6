Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AFE3C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 03:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B480221533
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 03:49:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="e7C2/tfb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B480221533
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbeI0KGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 06:06:02 -0400
Received: from mail-pu1apc01on0125.outbound.protection.outlook.com ([104.47.126.125]:41666
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727385AbeI0KGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 06:06:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p6SBK+OZft7qFuBGskVa9Sb1d9GyYt42dSiBvu3wZ3A=;
 b=e7C2/tfbelzUN5mL2pvcXAVBlgBJAg6DK6rURHywFsL46n6eVAj1JxPDhOAw7oJFIFrZdrWct2qxq9ne7AX9xbV8Bz5e18zBRfD8RiHNF7EsnI9BQtgxQGBhv4ANrUss2wqBnmklZmHwQPBwHGAWKC0GuduYc8YYMr/k9VvYe10=
Received: from HK0P153MB0129.APCP153.PROD.OUTLOOK.COM (52.133.156.18) by
 HK0P153MB0177.APCP153.PROD.OUTLOOK.COM (52.133.210.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Thu, 27 Sep 2018 03:49:49 +0000
Received: from HK0P153MB0129.APCP153.PROD.OUTLOOK.COM
 ([fe80::8584:ad93:130a:6267]) by HK0P153MB0129.APCP153.PROD.OUTLOOK.COM
 ([fe80::8584:ad93:130a:6267%3]) with mapi id 15.20.1207.011; Thu, 27 Sep 2018
 03:49:49 +0000
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
        vkuznets <vkuznets@redhat.com>,
        Jork Loeser <Jork.Loeser@microsoft.com>
Subject: [PATCH V3 10/13] x86/hyper-v: Add HvFlushGuestAddressList hypercall
 support
Thread-Topic: [PATCH V3 10/13] x86/hyper-v: Add HvFlushGuestAddressList
 hypercall support
Thread-Index: AQHUVhUjI9nGWlGZLUCbqLrddHAAAQ==
Date:   Thu, 27 Sep 2018 03:49:49 +0000
Message-ID: <20180927034829.2230-11-Tianyu.Lan@microsoft.com>
References: <20180927034829.2230-1-Tianyu.Lan@microsoft.com>
In-Reply-To: <20180927034829.2230-1-Tianyu.Lan@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tianyu.Lan@microsoft.com; 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HK0P153MB0177;6:nndrzxGRHrQvpeFq8pDfmQcVk0XcqQvUiDwT8Oqh1ohQLzFcqkeMIuWJc72BdI86JNDXkcEQN9ROL0M3cuJq15O/FuHjIzDUOhPJDLKcedRjzrTD5wn+eha9OrGOENV9yseNamfHdrr9rBAmsDqjA1IyjB3PzkMmyEuTGFNgVPYiQ5+7HxVrpEWulWocQxz6gxUQ3HDdGGhCOZ4AuNP0i8qxZtUFK1S6RW35qajUl4FiozpG3KQ6HyMGBFXkVgpeEjZ6zplCOEu1SCvo0BSjawUzVxno6jyXy+lQE2dGnCwk4OI8L2AdH2cagtOzTmUdfIV3a8gXKXr/UMrtuplh43ZpdP0oBU/jMqvKcjF+m68RmOvWdFuvWYiBOi1hmetykAuR/7m/+Or0R69g/uCRKI9Y6MG9c3vsmWrVIGTXry4nTEpNO4UrXZ1jZ7ZUjr1sJrfEt1gRVlSQ8TAUKdqP0w==;5:Dh3x9KB+6BD37lG8FGqvpaS/sXjKd2yWGFls6iBTpcVzkAgSystx5Zl3Vybg9XfcF0ZUhMhV/G/a7mb8eaaJ55Fl0XS/yuPaiSBjVTMqeiZPKpitEy0FT5Z2ayeTXDtolhKePUuNsbRz7gDBEFx7vVfV341vFUHX4R+9r+8v+1s=;7:ZlEXwVGEHrq/5OpppseuBZ50D5XP8rtN8ehbZ58AnxThvMJaz60L8hlJKnJbBPGyb7kx2hkkoT5BxeNX1K0kFWVZ5drSrRUtaveaGvBCOkqktStWW8LGneb++su9OWPRo91GOqJD0jg9Va560onlP6zTa3CpWNXW8MulHAv8g0FKut5SNGqY2u5uHP4hCF5JkoW8JnZWiVuNHyWwfTYUSAx3H6/aXjKJ0puqrz9DOT9uBihDi6ZfjLPdIbcBK70Q
x-ms-office365-filtering-correlation-id: d5f72851-ffa8-409b-9a2f-08d6242c462f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:HK0P153MB0177;
x-ms-traffictypediagnostic: HK0P153MB0177:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <HK0P153MB017797FED44B21E8AD8AE11292140@HK0P153MB0177.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051);SRVR:HK0P153MB0177;BCL:0;PCL:0;RULEID:;SRVR:HK0P153MB0177;
x-forefront-prvs: 0808323E97
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6029001)(376002)(136003)(396003)(346002)(39860400002)(366004)(199004)(189003)(105586002)(99286004)(10290500003)(486006)(478600001)(68736007)(106356001)(14454004)(72206003)(81156014)(6486002)(8676002)(6506007)(1671002)(81166006)(6512007)(2900100001)(2906002)(6436002)(76176011)(8936002)(10090500001)(3846002)(6116002)(54906003)(36756003)(316002)(59246006)(102836004)(26005)(1076002)(5660300001)(5250100002)(109986005)(107886003)(11346002)(446003)(2616005)(4326008)(25786009)(476003)(22452003)(7416002)(53936002)(86612001)(86362001)(71190400001)(71200400001)(14444005)(66066001)(7736002)(256004)(305945005)(97736004)(575784001);DIR:OUT;SFP:1102;SCL:1;SRVR:HK0P153MB0177;H:HK0P153MB0129.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: F6rs/jOCKTGHvgUYLQtHjIkP7dM4fX/ZeMaEGJUH7/ub2IQ3Bc8DPK/BXMrofvAh/8CyD5iNLm84xgKr/JXwefl4B1IaAk0tlPlrjSp7wo1cvkzvAfbEi2UHUYLIUtoWC7gPpUydHhUz1ZnUXIp5V33bx2PPRSZQmPU2ix80XTlYOSfLjejoFHSYkVsNmMYvgxAApyLprGvyHELe1Fxc+/xc8hGUcw143nd+6B7+J3pFOJYKGl2aTDNmYIMtN3FopIBipviA5Ase3U/mINVdmwLvEitUF+ROQA65J2wjCC/3Xg1KOiQ5+63Sue/GuaDTbnnnfUv+Cnb4d4tdS9OSdD5YFzKk73CR4L2HHjpv1QM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5f72851-ffa8-409b-9a2f-08d6242c462f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2018 03:49:49.0522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0177
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hyper-V provides HvFlushGuestAddressList() hypercall to flush EPT tlb
with specified ranges. This patch is to add the hypercall support.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
Change since v2:
      Fix some coding style issues
        - Move HV_MAX_FLUSH_PAGES and HV_MAX_FLUSH_REP_COUNT to
	hyperv-tlfs.h.
	- Calculate HV_MAX_FLUSH_REP_COUNT in the macro definition
	- Use HV_MAX_FLUSH_REP_COUNT to define length of gpa_list in
	struct hv_guest_mapping_flush_list.

Change since v1:
       Add hyperv tlb flush struct to avoid use kvm tlb flush struct
in the hyperv file.
---
 arch/x86/hyperv/nested.c           | 84 ++++++++++++++++++++++++++++++++++=
++++
 arch/x86/include/asm/hyperv-tlfs.h | 32 +++++++++++++++
 arch/x86/include/asm/mshyperv.h    | 16 ++++++++
 3 files changed, 132 insertions(+)

diff --git a/arch/x86/hyperv/nested.c b/arch/x86/hyperv/nested.c
index b8e60cc50461..a6fdfec63c7d 100644
--- a/arch/x86/hyperv/nested.c
+++ b/arch/x86/hyperv/nested.c
@@ -7,6 +7,7 @@
  *
  * Author : Lan Tianyu <Tianyu.Lan@microsoft.com>
  */
+#define pr_fmt(fmt)  "Hyper-V: " fmt
=20
=20
 #include <linux/types.h>
@@ -54,3 +55,86 @@ int hyperv_flush_guest_mapping(u64 as)
 	return ret;
 }
 EXPORT_SYMBOL_GPL(hyperv_flush_guest_mapping);
+
+static int fill_flush_list(union hv_gpa_page_range gpa_list[],
+		int offset, u64 start_gfn, u64 pages)
+{
+	int gpa_n =3D offset;
+	u64 cur =3D start_gfn;
+	u64 additional_pages;
+
+	do {
+		/*
+		 * If flush requests exceed max flush count, go back to
+		 * flush tlbs without range.
+		 */
+		if (gpa_n >=3D HV_MAX_FLUSH_REP_COUNT)
+			return -ENOSPC;
+
+		additional_pages =3D min_t(u64, pages, HV_MAX_FLUSH_PAGES) - 1;
+
+		gpa_list[gpa_n].page.additional_pages =3D additional_pages;
+		gpa_list[gpa_n].page.largepage =3D false;
+		gpa_list[gpa_n].page.basepfn =3D cur;
+
+		pages -=3D additional_pages + 1;
+		cur +=3D additional_pages + 1;
+		gpa_n++;
+	} while (pages > 0);
+
+	return gpa_n;
+}
+
+int hyperv_flush_guest_mapping_range(u64 as, struct hyperv_tlb_range *rang=
e)
+{
+	struct hv_guest_mapping_flush_list **flush_pcpu;
+	struct hv_guest_mapping_flush_list *flush;
+	u64 status =3D 0;
+	unsigned long flags;
+	int ret =3D -ENOTSUPP;
+	int gpa_n =3D 0;
+
+	if (!hv_hypercall_pg)
+		goto fault;
+
+	local_irq_save(flags);
+
+	flush_pcpu =3D (struct hv_guest_mapping_flush_list **)
+		this_cpu_ptr(hyperv_pcpu_input_arg);
+
+	flush =3D *flush_pcpu;
+	if (unlikely(!flush)) {
+		local_irq_restore(flags);
+		goto fault;
+	}
+
+	flush->address_space =3D as;
+	flush->flags =3D 0;
+
+	if (!range->flush_list)
+		gpa_n =3D fill_flush_list(flush->gpa_list, gpa_n,
+				range->start_gfn, range->pages);
+	else if (range->parse_flush_list_func)
+		gpa_n =3D range->parse_flush_list_func(flush->gpa_list, gpa_n,
+				range->flush_list, fill_flush_list);
+	else
+		gpa_n =3D -1;
+
+	if (gpa_n < 0) {
+		local_irq_restore(flags);
+		goto fault;
+	}
+
+	status =3D hv_do_rep_hypercall(HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_LIST,
+				     gpa_n, 0, flush, NULL);
+
+	local_irq_restore(flags);
+
+	if (!(status & HV_HYPERCALL_RESULT_MASK))
+		ret =3D 0;
+	else
+		ret =3D status;
+fault:
+	return ret;
+}
+EXPORT_SYMBOL_GPL(hyperv_flush_guest_mapping_range);
diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hype=
rv-tlfs.h
index e977b6b3a538..e38743328dfc 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -10,6 +10,7 @@
 #define _ASM_X86_HYPERV_TLFS_H
=20
 #include <linux/types.h>
+#include <asm/page.h>
=20
 /*
  * The below CPUID leaves are present if VersionAndFeatures.HypervisorPres=
ent
@@ -353,6 +354,7 @@ struct hv_tsc_emulation_status {
 #define HVCALL_POST_MESSAGE			0x005c
 #define HVCALL_SIGNAL_EVENT			0x005d
 #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE 0x00af
+#define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_LIST 0x00b0
=20
 #define HV_X64_MSR_VP_ASSIST_PAGE_ENABLE	0x00000001
 #define HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_SHIFT	12
@@ -750,6 +752,36 @@ struct hv_guest_mapping_flush {
 	u64 flags;
 };
=20
+/*
+ *  HV_MAX_FLUSH_PAGES =3D "additional_pages" + 1. It's limited
+ *  by the bitwidth of "additional_pages" in union hv_gpa_page_range.
+ */
+#define HV_MAX_FLUSH_PAGES (2048)
+
+/* HvFlushGuestPhysicalAddressList hypercall */
+union hv_gpa_page_range {
+	u64 address_space;
+	struct {
+		u64 additional_pages:11;
+		u64 largepage:1;
+		u64 basepfn:52;
+	} page;
+};
+
+/*
+ * All input flush parameters should be in single page. The max flush
+ * count is equal with how many entries of union hv_gpa_page_range can
+ * be populated into the input parameter page.
+ */
+#define HV_MAX_FLUSH_REP_COUNT (PAGE_SIZE - 2 * sizeof(u64) /	\
+				sizeof(union hv_gpa_page_range))
+
+struct hv_guest_mapping_flush_list {
+	u64 address_space;
+	u64 flags;
+	union hv_gpa_page_range gpa_list[HV_MAX_FLUSH_REP_COUNT];
+};
+
 /* HvFlushVirtualAddressSpace, HvFlushVirtualAddressList hypercalls */
 struct hv_tlb_flush {
 	u64 address_space;
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyper=
v.h
index f37704497d8f..19f49fbcf94d 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -22,6 +22,16 @@ struct ms_hyperv_info {
=20
 extern struct ms_hyperv_info ms_hyperv;
=20
+struct hyperv_tlb_range {
+	u64 start_gfn;
+	u64 pages;
+	struct list_head *flush_list;
+	int (*parse_flush_list_func)(union hv_gpa_page_range gpa_list[],
+		int offset, struct list_head *flush_list,
+		int (*fill_flush_list)(union hv_gpa_page_range gpa_list[],
+		int offset, u64 start_gfn, u64 end_gfn));
+};
+
 /*
  * Generate the guest ID.
  */
@@ -348,6 +358,7 @@ void set_hv_tscchange_cb(void (*cb)(void));
 void clear_hv_tscchange_cb(void);
 void hyperv_stop_tsc_emulation(void);
 int hyperv_flush_guest_mapping(u64 as);
+int hyperv_flush_guest_mapping_range(u64 as, struct hyperv_tlb_range *rang=
e);
=20
 #ifdef CONFIG_X86_64
 void hv_apic_init(void);
@@ -368,6 +379,11 @@ static inline struct hv_vp_assist_page *hv_get_vp_assi=
st_page(unsigned int cpu)
 	return NULL;
 }
 static inline int hyperv_flush_guest_mapping(u64 as) { return -1; }
+static inline int hyperv_flush_guest_mapping_range(u64 as,
+		struct hyperv_tlb_range *range)
+{
+	return -1;
+}
 #endif /* CONFIG_HYPERV */
=20
 #ifdef CONFIG_HYPERV_TSCPAGE
--=20
2.14.4
