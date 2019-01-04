Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF535C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 09:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A03C217F5
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 09:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Qn/E5VZb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbfADJhg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 04:37:36 -0500
Received: from mail-eopbgr750052.outbound.protection.outlook.com ([40.107.75.52]:43712
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727256AbfADJhf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 04:37:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A5gRta7cXfU50ypCr09C531+ReW9evNI+iHokAVrPws=;
 b=Qn/E5VZbgAyVw1fCZN07NOm2V6dsjFuopqSUV7je+lYENYpYSOfkc26zWR3rCxwYERkr3EFshYgyEU/oXZn7fISWnz1AHdmc772Fdd2FjpT1BDyGJUiKlHmIsdRMx0TQjNMYB9bg9hfDtLCWo+Fznr9e//2UjRQR+ogQvPCnKdc=
Received: from MN2PR12MB3248.namprd12.prod.outlook.com (20.179.82.219) by
 MN2PR12MB2943.namprd12.prod.outlook.com (20.179.81.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Fri, 4 Jan 2019 09:37:32 +0000
Received: from MN2PR12MB3248.namprd12.prod.outlook.com
 ([fe80::c0b8:71fb:e1f0:d13a]) by MN2PR12MB3248.namprd12.prod.outlook.com
 ([fe80::c0b8:71fb:e1f0:d13a%3]) with mapi id 15.20.1495.005; Fri, 4 Jan 2019
 09:37:32 +0000
From:   "S, Shirish" <Shirish.S@amd.com>
CC:     "S, Shirish" <Shirish.S@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        Kees Cook <keescook@chromium.org>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] x86/mce/amd: Ensure quirks are applied in resume path as
 well
Thread-Topic: [PATCH 2/2] x86/mce/amd: Ensure quirks are applied in resume
 path as well
Thread-Index: AQHUpBEdiyhvJSw8SEaVVed85AAizA==
Date:   Fri, 4 Jan 2019 09:37:32 +0000
Message-ID: <1546594609-22403-3-git-send-email-shirish.s@amd.com>
References: <1546594609-22403-1-git-send-email-shirish.s@amd.com>
In-Reply-To: <1546594609-22403-1-git-send-email-shirish.s@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BMXPR01CA0043.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:c::29) To MN2PR12MB3248.namprd12.prod.outlook.com
 (2603:10b6:208:103::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Shirish.S@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.156.251]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MN2PR12MB2943;20:mOlvw7XhRBbbgOiOLMzxPeMnQJXPNY+ldGnM5l1v2FqylBT2JcJmj8QV2LrP4gvrLWDlsf8mzecmBGorWNAC6jUwjQhyy9fyHxHVfsgS6OUw+zRJvLw4PHElCAy8nGdnKVSl2ZH5238+dQBMU4haDHlEIgd/xzcRulNNDiAp16RYmAYB/38CyT+1KmZEtCA5o6bUoumdSdLTd4euBkrrxOkbvnBwkcrIsdvTkagXz4XLdLjjgDn3RWE8/VWwFDDC
x-ms-office365-filtering-correlation-id: f568e1a3-4c79-44bf-925f-08d672284024
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MN2PR12MB2943;
x-ms-traffictypediagnostic: MN2PR12MB2943:
x-microsoft-antispam-prvs: <MN2PR12MB29436BD34D130627135838E5F28E0@MN2PR12MB2943.namprd12.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231475)(944501520)(52105112)(6055026)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:MN2PR12MB2943;BCL:0;PCL:0;RULEID:;SRVR:MN2PR12MB2943;
x-forefront-prvs: 0907F58A24
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(376002)(366004)(346002)(396003)(189003)(199004)(6512007)(4326008)(53936002)(316002)(109986005)(2616005)(14454004)(478600001)(72206003)(446003)(11346002)(476003)(3846002)(6486002)(6436002)(106356001)(14444005)(256004)(6116002)(486006)(1671002)(54906003)(76176011)(102836004)(2906002)(5660300001)(99286004)(105586002)(66066001)(26005)(36756003)(68736007)(305945005)(7736002)(86362001)(59246006)(97736004)(186003)(386003)(6506007)(71190400001)(71200400001)(52116002)(25786009)(8936002)(8676002)(81156014)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB2943;H:MN2PR12MB3248.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: llETvKMNOq93HFUOIYJRDemnzqSHZiAl+8DWOGSetjO1wuvGZONt46GK0bgmYxHyKQodGF7jC9MsIBRTgPL6lAXsmmXJBia8Vvzu5psP1mPeSpDX5M1S+JY1dPCGfSMM6zLh0jzKm3FS1oKTY8euw8tAQBvMY/qxAB2kq6cfBiiaNOqf2QQA/qKECclU+nObToz9N4T9d9vWuRKwFFAxd1MWYKArMshxBBjFqriy/61olzJHcsRJdBqxVTzlu2i5TPNjEYP6sO4mGYbbQ5uJclIIL0d5SWSTLcEd+1RE3at/hmBBW1guor9K3Qz5tTbj
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f568e1a3-4c79-44bf-925f-08d672284024
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2019 09:37:32.3653
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2943
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds threshold quirk applicable for family 15
in resume path as well, since mce_amd_feature_init()
does not have quirks applied when originating from mce_syscore_resume(),
resulting in the below message at every successful resume:

"[Firmware Bug]: cpu 0, invalid threshold interrupt offset ..."

Signed-off-by: Shirish S <shirish.s@amd.com>
---
 arch/x86/kernel/cpu/mce/amd.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 89298c8..27cbf66 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -545,6 +545,34 @@ prepare_threshold_block(unsigned int bank, unsigned in=
t block, u32 addr,
 	return offset;
 }
=20
+void disable_err_thresholding(struct cpuinfo_x86 *c)
+{
+	int i;
+	u64 hwcr;
+	bool need_toggle;
+	u32 msrs[] =3D {
+		0x00000413, /* MC4_MISC0 */
+		0xc0000408, /* MC4_MISC1 */
+	};
+
+	if (c->x86_model >=3D 0x10 && c->x86_model <=3D 0x7f) {
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
 /* cpu init entry point, called from mce.c with preempt off */
 void mce_amd_feature_init(struct cpuinfo_x86 *c)
 {
@@ -552,6 +580,12 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
 	unsigned int bank, block, cpu =3D smp_processor_id();
 	int offset =3D -1;
=20
+	/* Disable error thresholding bank in S3 resume path as well,
+	 * for 15h family
+	 */
+	if (c->x86 =3D=3D 0x15)
+		disable_err_thresholding(c);
+
 	for (bank =3D 0; bank < mca_cfg.banks; ++bank) {
 		if (mce_flags.smca)
 			smca_configure(bank, cpu);
--=20
2.7.4

