Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B59C43444
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BD28206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="FPwcmLWu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387540AbfAPPKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 10:10:49 -0500
Received: from mail-eopbgr820053.outbound.protection.outlook.com ([40.107.82.53]:39875
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2393891AbfAPPKo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 10:10:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0NGsMuJ2bFXmo+uXICFum0dJU9yS4Nllkpqawab+Hyk=;
 b=FPwcmLWuxftQlHmhKEfILmSss/UM1mR3lRUEuLuaI2Js9zgqUvpzIm+F4cUlh8Orvd54l59M2feWCypjcShldXVnomWQC6KHYB4kXD3GQIJjGUSUjHaVGMBqGsqd+sR3k1SGv4ntyhjv+rCM/tYkAdLFeZ+6kEXTWbG+yv9Zajw=
Received: from MN2PR12MB3248.namprd12.prod.outlook.com (20.179.82.219) by
 MN2PR12MB2878.namprd12.prod.outlook.com (20.179.80.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.15; Wed, 16 Jan 2019 15:10:40 +0000
Received: from MN2PR12MB3248.namprd12.prod.outlook.com
 ([fe80::c818:e3a0:c248:802f]) by MN2PR12MB3248.namprd12.prod.outlook.com
 ([fe80::c818:e3a0:c248:802f%3]) with mapi id 15.20.1537.018; Wed, 16 Jan 2019
 15:10:40 +0000
From:   "S, Shirish" <Shirish.S@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "maintainer : X86 ARCHITECTURE" <x86@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "open list : X86 ARCHITECTURE" <linux-kernel@vger.kernel.org>,
        "S, Shirish" <Shirish.S@amd.com>
Subject: [PATCH 2/2] x86/mce/amd: carve out MC4_MISC thresholding quirk
Thread-Topic: [PATCH 2/2] x86/mce/amd: carve out MC4_MISC thresholding quirk
Thread-Index: AQHUra2kVnXd3Qf5EkWPkkmzdXhRRA==
Date:   Wed, 16 Jan 2019 15:10:40 +0000
Message-ID: <1547651417-23583-3-git-send-email-shirish.s@amd.com>
References: <1547651417-23583-1-git-send-email-shirish.s@amd.com>
In-Reply-To: <1547651417-23583-1-git-send-email-shirish.s@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BM1PR01CA0087.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1::27) To MN2PR12MB3248.namprd12.prod.outlook.com
 (2603:10b6:208:103::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Shirish.S@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [165.204.156.251]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MN2PR12MB2878;20:wUPlvA8K+bjiz08m7ihTCARpgiwmXnHGUiWbowUhcS6DqaZc4nYI1o46DljF8LpY7psPzymO2+EzImbUqdjBXrQTeqq/FpRQISBt4MgnWTVCB2iX6NO19vX8Smjz6xgbnK35NYc9xCvtEqtq0iD52ypWJE5GBFJ3+hBDMSAQ4gR25twkZwBouk5LpK6X9L0KSkyczzIYLFB16Fv52yywRS9sS+zD/NrZiZaxQohVlAyCNnteGM9iYL7EXYZZNDKE
x-ms-office365-filtering-correlation-id: e9162af6-1e1d-453e-ee1c-08d67bc4c6ef
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MN2PR12MB2878;
x-ms-traffictypediagnostic: MN2PR12MB2878:
x-microsoft-antispam-prvs: <MN2PR12MB2878DA59F510E1B4EE4340E8F2820@MN2PR12MB2878.namprd12.prod.outlook.com>
x-forefront-prvs: 091949432C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(346002)(376002)(366004)(396003)(54534003)(199004)(189003)(25786009)(26005)(5660300001)(14454004)(7736002)(486006)(305945005)(105586002)(54906003)(99286004)(446003)(11346002)(476003)(2616005)(52116002)(53936002)(4326008)(76176011)(102836004)(6506007)(386003)(186003)(3846002)(6116002)(72206003)(6512007)(478600001)(2906002)(316002)(86362001)(6916009)(81166006)(36756003)(81156014)(8676002)(68736007)(50226002)(6486002)(97736004)(8936002)(256004)(6436002)(106356001)(71200400001)(71190400001)(14444005)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB2878;H:MN2PR12MB3248.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BNVxyMNUU82261qdjMK1i+zhQ9v/+6Tv7RQO6zS8a7sMzcaj3+ay+fnrBERC2V6lGwATQQZm7FHqEPC+QnUhjGy5StNTnVckSvhQXKhpIy6OCLteWMJgPu7Tx13dTEfxutZS5d2IQB53pSnEJKhtkb7mqRxTE4G+zQioC4c7M1r1U5N6EUrx59pkYh3poXdF5sfpc9+aJ6mQzEOAXPfA+w34qOENaoVZNNkMbGXM+dfXPiLIu7nwFKfnMLE5M3XqiewYi0rxsuXCHJSAPOGWaD366HDlkzQ3eG4uOUYgMCKMj90VGlLItWNX1nG+Lfh1ebZgaudTZ1xUwCOScUVYsEc/OQeuM2ptijZhJUuD1mr0mBOmGTwNuyRF/f7MocWG4aCYmEhbSvYG3TpBkMeBgG1EQ9o8IIEPNcghKS0tjQU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9162af6-1e1d-453e-ee1c-08d67bc4c6ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2019 15:10:36.9240
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2878
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MC4_MISC thresholding quirk needs to be applied during S5 -> S0 and
S3 -> S0 state transitions, which follow different code paths, hence
carve it out and move it mce_amd_feature_init(), which is  the converging
point of both code paths.

Changelog[v2]:
 - move the quirk to mce/amd.c

Signed-off-by: Shirish S <shirish.s@amd.com>
---
 arch/x86/kernel/cpu/mce/amd.c  | 34 ++++++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/mce/core.c | 29 -----------------------------
 2 files changed, 34 insertions(+), 29 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 89298c8..f6a5c96 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -545,6 +545,33 @@ prepare_threshold_block(unsigned int bank, unsigned in=
t block, u32 addr,
 	return offset;
 }
=20
+void mc4_misc_thresholding_quirk(void)
+{
+	int i;
+	u64 hwcr;
+	bool need_toggle;
+	u32 msrs[] =3D {
+		0x00000413, /* MC4_MISC0 */
+		0xc0000408, /* MC4_MISC1 */
+	};
+
+	rdmsrl(MSR_K7_HWCR, hwcr);
+
+	/* McStatusWrEn has to be set */
+	need_toggle =3D !(hwcr & BIT(18));
+
+	if (need_toggle)
+		wrmsrl(MSR_K7_HWCR, hwcr | BIT(18));
+
+	/* Clear CntP bit safely */
+	for (i =3D 0; i < ARRAY_SIZE(msrs); i++)
+		msr_clear_bit(msrs[i], 62);
+
+	/* restore old settings */
+	if (need_toggle)
+		wrmsrl(MSR_K7_HWCR, hwcr);
+}
+
 /* cpu init entry point, called from mce.c with preempt off */
 void mce_amd_feature_init(struct cpuinfo_x86 *c)
 {
@@ -552,6 +579,13 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
 	unsigned int bank, block, cpu =3D smp_processor_id();
 	int offset =3D -1;
=20
+	/*
+	 * Turn off MC4_MISC thresholding banks on all family 15 models since
+	 * they're not supported there.
+	 */
+	if (c->x86 =3D=3D 0x15)
+		mc4_misc_thresholding_quirk();
+
 	for (bank =3D 0; bank < mca_cfg.banks; ++bank) {
 		if (mce_flags.smca)
 			smca_configure(bank, cpu);
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.=
c
index d0c5416..6063ae2 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1611,35 +1611,6 @@ static int __mcheck_cpu_apply_quirks(struct cpuinfo_=
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
 	}
=20
 	if (c->x86_vendor =3D=3D X86_VENDOR_INTEL) {
--=20
2.7.4

