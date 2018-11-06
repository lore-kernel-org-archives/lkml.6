Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA6F8C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9926020685
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="NRKfh4n3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9926020685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389024AbeKGBHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 20:07:03 -0500
Received: from mail-eopbgr810055.outbound.protection.outlook.com ([40.107.81.55]:20224
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388819AbeKGBHC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 20:07:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KVcy8HpXOJwPtcJRpYC8zooaRYElMrQ4h7GlHaLrWS4=;
 b=NRKfh4n3M+I99H4svzGpe+YqoOl/hCmNvOUuEhAHlVC0fzQp8ugeYZEcIWSrY/Xcmb/gwXj2L+ETsO2efGld/D2R40rpb46gMQM4PldFQJ92vcE8yGztOP0uBSv104hU8Mk5YuZsOVpEk4N77vKOwcTAQBwp3qMVSR7No1/O+jE=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1801.namprd12.prod.outlook.com (10.175.91.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Tue, 6 Nov 2018 15:41:13 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::4c23:f551:bc6a:554e]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::4c23:f551:bc6a:554e%4]) with mapi id 15.20.1294.032; Tue, 6 Nov 2018
 15:41:13 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "corbet@lwn.net" <corbet@lwn.net>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "reinette.chatre@intel.com" <reinette.chatre@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "pombredanne@nexb.com" <pombredanne@nexb.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "qianyue.zj@alibaba-inc.com" <qianyue.zj@alibaba-inc.com>,
        "xiaochen.shen@intel.com" <xiaochen.shen@intel.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Singh, Brijesh" <brijesh.singh@amd.com>,
        "Hurwitz, Sherry" <sherry.hurwitz@amd.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "jannh@google.com" <jannh@google.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "rian@alum.mit.edu" <rian@alum.mit.edu>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "Moger, Babu" <Babu.Moger@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: [PATCH v6 07/14] arch/x86: Initialize the resource functions that are
 different
Thread-Topic: [PATCH v6 07/14] arch/x86: Initialize the resource functions
 that are different
Thread-Index: AQHUdeclBCqDORpcE0aUj9EQaWnfZw==
Date:   Tue, 6 Nov 2018 15:41:13 +0000
Message-ID: <20181106154034.15386-8-babu.moger@amd.com>
References: <20181106154034.15386-1-babu.moger@amd.com>
In-Reply-To: <20181106154034.15386-1-babu.moger@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0401CA0010.namprd04.prod.outlook.com
 (2603:10b6:803:21::20) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1801;20:uQ4HVs+RSNNQ1fBecjiiaq6OI5Kff+4vYtq+4xRLYLSOrDWgHryG+Q4Ob2Wgyn+P7Mk6CWTBfxD2sb6ZoYaxd7IrPEeA1E+mY/Ep7tUwA91SxKmZY5I6F6KFdwhUk97UdhPZiZzw0hZ62ItMmw6GdwSGRoqeQWZI5MJCoqeSQVXtuNC4gL8lMdD5ckAvPVdbA3nHk5xpxKNBsqvH8YT4cG1GIm3Ejc/TInUZGB9cxA6SxYym+YhuTd4FtfeFCkYh
x-ms-office365-filtering-correlation-id: 43ad9ac4-2eac-45fa-2808-08d643fe47e9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1801;
x-ms-traffictypediagnostic: DM5PR12MB1801:
x-microsoft-antispam-prvs: <DM5PR12MB18016EF9691FB441B700E26395CB0@DM5PR12MB1801.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(269456686620040)(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823302103)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DM5PR12MB1801;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1801;
x-forefront-prvs: 0848C1A6AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(396003)(376002)(366004)(199004)(189003)(476003)(6512007)(486006)(53936002)(2900100001)(76176011)(52116002)(26005)(186003)(102836004)(6506007)(446003)(11346002)(99286004)(4326008)(106356001)(386003)(105586002)(3846002)(6486002)(6116002)(1076002)(68736007)(66066001)(36756003)(14454004)(8676002)(81156014)(81166006)(2616005)(8936002)(7406005)(5660300001)(6436002)(316002)(2906002)(7416002)(305945005)(7736002)(54906003)(110136005)(575784001)(25786009)(72206003)(86362001)(478600001)(71190400001)(2201001)(71200400001)(2501003)(97736004)(256004)(14444005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1801;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: AnFiW3LXfYPaH6HlIWcYKEVCzP+QbNhLfpxYSruG4U4o7muqdj1eg+XRL50HHIS0rJHkddmc88/DCLj9yPXgxKKTV/EtNMOBEdZcE9ayVBlHnOApUCF4z8zbV4wgx6IwTPJMDUhwV3CjjAwSSqb93gvMYTeVrzT8r5vky0bMFZdTsbpcvbqpByGoeb1zk18gdG9maF3hda2BuuvXkfETOyTnY/azQ/atgQ1hy+Q1w75t9xQ2VDrbkj/rcDNzoa2d2MOMAjEturdXNcylmHwAFfjmXSpJJml4mFryety1tAG7UKjTA+TkBPNZKBNEhmm8wXxikc55VruksrTIMnIYl4hlC2DHSd0iPSTZMLT7FZI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43ad9ac4-2eac-45fa-2808-08d643fe47e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2018 15:41:13.0373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1801
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initialize the resource functions that are different between the
vendors. Some features are initialized differently between the vendors.
Add _intel suffix to Intel specific functions.

For example, MBA feature varies significantly between Intel and AMD.
Separate the initialization of these resource functions. That way we
can easily add AMD's functions later.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 arch/x86/kernel/cpu/resctrl.c             | 34 +++++++++++++++++++----
 arch/x86/kernel/cpu/resctrl.h             |  8 ++++--
 arch/x86/kernel/cpu/resctrl_ctrlmondata.c |  4 +--
 3 files changed, 37 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl.c b/arch/x86/kernel/cpu/resctrl.c
index ddb2c65a309a..3f77d5fcb2dc 100644
--- a/arch/x86/kernel/cpu/resctrl.c
+++ b/arch/x86/kernel/cpu/resctrl.c
@@ -57,7 +57,8 @@ int max_name_width, max_data_width;
 bool rdt_alloc_capable;
=20
 static void
-mba_wrmsr(struct rdt_domain *d, struct msr_param *m, struct rdt_resource *=
r);
+mba_wrmsr_intel(struct rdt_domain *d, struct msr_param *m,
+		struct rdt_resource *r);
 static void
 cat_wrmsr(struct rdt_domain *d, struct msr_param *m, struct rdt_resource *=
r);
=20
@@ -171,10 +172,7 @@ struct rdt_resource rdt_resources_all[] =3D {
 		.rid			=3D RDT_RESOURCE_MBA,
 		.name			=3D "MB",
 		.domains		=3D domain_init(RDT_RESOURCE_MBA),
-		.msr_base		=3D IA32_MBA_THRTL_BASE,
-		.msr_update		=3D mba_wrmsr,
 		.cache_level		=3D 3,
-		.parse_ctrlval		=3D parse_bw,
 		.format_str		=3D "%d=3D%*u",
 		.fflags			=3D RFTYPE_RES_MB,
 	},
@@ -356,7 +354,8 @@ u32 delay_bw_map(unsigned long bw, struct rdt_resource =
*r)
 }
=20
 static void
-mba_wrmsr(struct rdt_domain *d, struct msr_param *m, struct rdt_resource *=
r)
+mba_wrmsr_intel(struct rdt_domain *d, struct msr_param *m,
+		struct rdt_resource *r)
 {
 	unsigned int i;
=20
@@ -875,6 +874,25 @@ static __init bool get_rdt_resources(void)
 	return (rdt_mon_capable || rdt_alloc_capable);
 }
=20
+static __init void rdt_init_res_defs_intel(void)
+{
+	struct rdt_resource *r;
+
+	for_each_rdt_resource(r) {
+		if (r->rid =3D=3D RDT_RESOURCE_MBA) {
+			r->msr_base =3D IA32_MBA_THRTL_BASE;
+			r->msr_update =3D mba_wrmsr_intel;
+			r->parse_ctrlval =3D parse_bw_intel;
+		}
+	}
+}
+
+static __init void rdt_init_res_defs(void)
+{
+	if (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_INTEL)
+		rdt_init_res_defs_intel();
+}
+
 static enum cpuhp_state rdt_online;
=20
 static int __init resctrl_late_init(void)
@@ -882,6 +900,12 @@ static int __init resctrl_late_init(void)
 	struct rdt_resource *r;
 	int state, ret;
=20
+	/*
+	 * Initialize functions(or definitions) that are different
+	 * between vendors here.
+	 */
+	rdt_init_res_defs();
+
 	/* Run quirks first */
 	rdt_quirks();
=20
diff --git a/arch/x86/kernel/cpu/resctrl.h b/arch/x86/kernel/cpu/resctrl.h
index e5f7bf6a8d09..8731b7c91c28 100644
--- a/arch/x86/kernel/cpu/resctrl.h
+++ b/arch/x86/kernel/cpu/resctrl.h
@@ -444,8 +444,8 @@ struct rdt_resource {
=20
 int parse_cbm(struct rdt_parse_data *data, struct rdt_resource *r,
 	      struct rdt_domain *d);
-int parse_bw(struct rdt_parse_data *data, struct rdt_resource *r,
-	     struct rdt_domain *d);
+int parse_bw_intel(struct rdt_parse_data *data, struct rdt_resource *r,
+		   struct rdt_domain *d);
=20
 extern struct mutex rdtgroup_mutex;
=20
@@ -468,6 +468,10 @@ enum {
 	RDT_NUM_RESOURCES,
 };
=20
+#define for_each_rdt_resource(r)					      \
+	for (r =3D rdt_resources_all; r < rdt_resources_all + RDT_NUM_RESOURCES;\
+	     r++)
+
 #define for_each_capable_rdt_resource(r)				      \
 	for (r =3D rdt_resources_all; r < rdt_resources_all + RDT_NUM_RESOURCES;\
 	     r++)							      \
diff --git a/arch/x86/kernel/cpu/resctrl_ctrlmondata.c b/arch/x86/kernel/cp=
u/resctrl_ctrlmondata.c
index e8d21306d0f9..78089ae8683c 100644
--- a/arch/x86/kernel/cpu/resctrl_ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl_ctrlmondata.c
@@ -64,8 +64,8 @@ static bool bw_validate(char *buf, unsigned long *data, s=
truct rdt_resource *r)
 	return true;
 }
=20
-int parse_bw(struct rdt_parse_data *data, struct rdt_resource *r,
-	     struct rdt_domain *d)
+int parse_bw_intel(struct rdt_parse_data *data, struct rdt_resource *r,
+		   struct rdt_domain *d)
 {
 	unsigned long bw_val;
=20
--=20
2.17.1

