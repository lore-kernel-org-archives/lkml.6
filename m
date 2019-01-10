Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40788C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 07:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0628C20685
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 07:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZRvP1rFm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbfAJHyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 02:54:50 -0500
Received: from mail-eopbgr710065.outbound.protection.outlook.com ([40.107.71.65]:18752
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727582AbfAJHyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 02:54:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1PcWnPebNnPIVLkW4tBwV78VDsHdlQmrQjrZSuH5O1Y=;
 b=ZRvP1rFm0/gmBLJAiA2IOZGpA8vU7/xXcbsqBYVQqMQ3LDlvHVNxk5ZPTjaJNhojCVwngbOE8i+fJzfvzrrt1CCpJBT8Vcsevi43rxbSlT/oZF5eNPMUwhdU89WHW1ihpbMLARNiatbiaNpu2aZZ2uYglaXNI3chbHeHJ0BUb2Y=
Received: from BYAPR12MB3237.namprd12.prod.outlook.com (20.179.93.25) by
 BYAPR12MB2664.namprd12.prod.outlook.com (20.176.255.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.7; Thu, 10 Jan 2019 07:54:47 +0000
Received: from BYAPR12MB3237.namprd12.prod.outlook.com
 ([fe80::a96e:ffd:3bd6:c5f5]) by BYAPR12MB3237.namprd12.prod.outlook.com
 ([fe80::a96e:ffd:3bd6:c5f5%4]) with mapi id 15.20.1516.015; Thu, 10 Jan 2019
 07:54:47 +0000
From:   "S, Shirish" <Shirish.S@amd.com>
To:     --cc=Borislav Petkov <bp@alien8.de>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "maintainer : X86 ARCHITECTURE" <x86@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "open list : X86 ARCHITECTURE" <linux-kernel@vger.kernel.org>,
        "S, Shirish" <Shirish.S@amd.com>
Subject: [PATCH 2/3] x86/mce/amd: carve out MC4_MISC thresholding quirk
Thread-Topic: [PATCH 2/3] x86/mce/amd: carve out MC4_MISC thresholding quirk
Thread-Index: AQHUqLnBKXA5dE9UhU6IEJUr8rZxXw==
Date:   Thu, 10 Jan 2019 07:54:46 +0000
Message-ID: <1547106849-3476-3-git-send-email-shirish.s@amd.com>
References: <1547106849-3476-1-git-send-email-shirish.s@amd.com>
In-Reply-To: <1547106849-3476-1-git-send-email-shirish.s@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BMXPR01CA0008.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:d::18) To BYAPR12MB3237.namprd12.prod.outlook.com
 (2603:10b6:a03:136::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Shirish.S@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.156.251]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB2664;20:kmwrrz019+c++6w++7o2o1UYtJxusI2GNxWHdWp3bBZuBY8PUIUyLxBUJT9kfyhxTWalTKIrT5b+AHFG5ZooIWJmNOe9+PJTzTOH67JhYK2AjyU/Dd9rjB/O9ROzLLIjJZYVeuIVJWckJDPFvIi8FNEWj3aZtTPhuCQY2A4xBLeCyKLW4Ce0OABKwf2wQawEUPlwgbK6eN8IWvsmixWjLbjy36Y9isxx9mF70ag2MzwupKSbHVD61WU47mDXcm4s
x-ms-office365-filtering-correlation-id: 90ded562-18cd-4dad-baa2-08d676d0e3cf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB2664;
x-ms-traffictypediagnostic: BYAPR12MB2664:
x-microsoft-antispam-prvs: <BYAPR12MB26641EB7DBDE62FD1028F31CF2840@BYAPR12MB2664.namprd12.prod.outlook.com>
x-forefront-prvs: 0913EA1D60
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(39860400002)(366004)(136003)(189003)(199004)(102836004)(6512007)(186003)(386003)(97736004)(66066001)(72206003)(6506007)(68736007)(86362001)(575784001)(26005)(6116002)(81166006)(478600001)(316002)(52116002)(81156014)(486006)(54906003)(25786009)(76176011)(2906002)(3846002)(99286004)(53936002)(105586002)(6916009)(2616005)(256004)(4326008)(71190400001)(71200400001)(36756003)(446003)(7736002)(6436002)(305945005)(14454004)(5660300001)(106356001)(11346002)(6486002)(8936002)(8676002)(476003)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2664;H:BYAPR12MB3237.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: n8fJG6wkbZ1oV0QWSOhQyqV2uu3OJw1Bc2H8Ty8l1AthMz9z3o6O+71OpeUVkmEl6TQJUq+2sWhFkL5OEAJE271rF2PBspqU8Wt53ggs/yLNWQDUohzMe+bA5IiJnspVAaT1xguGhgKYk2u4KINeGrTcWcf704VXgIq0A/i6rmNMLSwPAj9Jc0IAv+V27b8CSsfiynpb9IEy0/J2Wyv+r894TwCDc2DeaoBBai1S1WVa2VGgcldiWdu0ohHTS5rCT2/Qprp7/Rzc5yFKBuVT+sdUvA5G6EWcejb6x5C17pRy+lWl1dYbNseJzXA1SH5c
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90ded562-18cd-4dad-baa2-08d676d0e3cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2019 07:54:46.9164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2664
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MC4_MISC thresholding quirk needs to be applied during S5 -> S0 and
S3 -> S0 state transitions, which follow different code paths, hence
carve it out so as to facilitate its application in both scenarios.

Signed-off-by: Shirish S <shirish.s@amd.com>
---
 arch/x86/include/asm/mce.h     |  1 +
 arch/x86/kernel/cpu/mce/core.c | 64 +++++++++++++++++++++++---------------=
----
 2 files changed, 36 insertions(+), 29 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index c1a812b..328b65c 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -216,6 +216,7 @@ int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 =
umc, u64 *sys_addr);
 static inline void mce_amd_feature_init(struct cpuinfo_x86 *c) { }
 static inline int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, =
u64 *sys_addr) { return -EINVAL; };
 #endif
+void quirk_fam15_mc4_misc_thresholding(void);
=20
 static inline void mce_hygon_feature_init(struct cpuinfo_x86 *c) { return =
mce_amd_feature_init(c); }
=20
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.=
c
index d0c5416..51f61cf 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1570,6 +1570,39 @@ static void quirk_sandybridge_ifu(int bank, struct m=
ce *m, struct pt_regs *regs)
 	m->cs =3D regs->cs;
 }
=20
+/*
+ * Turn off MC4_MISC thresholding banks on all family 15 models since
+ * they're not supported there.
+ */
+void quirk_fam15_mc4_misc_thresholding(void)
+{
+	if (boot_cpu_data.x86 =3D=3D 0x15) {
+		int i;
+		u64 hwcr;
+		bool need_toggle;
+		u32 msrs[] =3D {
+			0x00000413, /* MC4_MISC0 */
+			0xc0000408, /* MC4_MISC1 */
+		};
+
+		rdmsrl(MSR_K7_HWCR, hwcr);
+
+		/* McStatusWrEn has to be set */
+		need_toggle =3D !(hwcr & BIT(18));
+
+		if (need_toggle)
+			wrmsrl(MSR_K7_HWCR, hwcr | BIT(18));
+
+		/* Clear CntP bit safely */
+		for (i =3D 0; i < ARRAY_SIZE(msrs); i++)
+			msr_clear_bit(msrs[i], 62);
+
+		/* restore old settings */
+		if (need_toggle)
+			wrmsrl(MSR_K7_HWCR, hwcr);
+	}
+}
+
 /* Add per CPU specific workarounds here */
 static int __mcheck_cpu_apply_quirks(struct cpuinfo_x86 *c)
 {
@@ -1611,35 +1644,8 @@ static int __mcheck_cpu_apply_quirks(struct cpuinfo_=
x86 *c)
 		if (c->x86 =3D=3D 0x15 && c->x86_model <=3D 0xf)
 			mce_flags.overflow_recov =3D 1;
=20
-		/*
-		 * Turn off MC4_MISC thresholding banks on all models since
-		 * they're not supported there.
-		 */
-		if (c->x86 =3D=3D 0x15) {
-			int i;
-			u64 hwcr;
-			bool need_toggle;
-			u32 msrs[] =3D {
-				0x00000413, /* MC4_MISC0 */
-				0xc0000408, /* MC4_MISC1 */
-			};
-
-			rdmsrl(MSR_K7_HWCR, hwcr);
-
-			/* McStatusWrEn has to be set */
-			need_toggle =3D !(hwcr & BIT(18));
-
-			if (need_toggle)
-				wrmsrl(MSR_K7_HWCR, hwcr | BIT(18));
-
-			/* Clear CntP bit safely */
-			for (i =3D 0; i < ARRAY_SIZE(msrs); i++)
-				msr_clear_bit(msrs[i], 62);
-
-			/* restore old settings */
-			if (need_toggle)
-				wrmsrl(MSR_K7_HWCR, hwcr);
-		}
+		quirk_fam15_mc4_misc_thresholding();
+
 	}
=20
 	if (c->x86_vendor =3D=3D X86_VENDOR_INTEL) {
--=20
2.7.4

