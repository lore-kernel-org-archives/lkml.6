Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C23C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 10:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3EF72089F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 10:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="QVDUO4/1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbfAGKi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 05:38:27 -0500
Received: from mail-eopbgr820080.outbound.protection.outlook.com ([40.107.82.80]:49904
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726686AbfAGKi1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 05:38:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A5gRta7cXfU50ypCr09C531+ReW9evNI+iHokAVrPws=;
 b=QVDUO4/1UFqH0fPZFu3sHWD02Un0RD+hvCEV5m5FzXHlwS0RPrCdn57/rNOpIbzEy0aLtCk8wWnsDHC1vx3268775Mu1cMjhwoVbQ7BdN2uzL5/eUnN6TuDQjW6zAEwG8GdAiRAiHAI6C9rHHZ9obOoR+QJZSeE9TLF+rymgM/o=
Received: from MN2PR12MB3248.namprd12.prod.outlook.com (20.179.82.219) by
 MN2PR12MB3391.namprd12.prod.outlook.com (20.178.242.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.7; Mon, 7 Jan 2019 10:37:24 +0000
Received: from MN2PR12MB3248.namprd12.prod.outlook.com
 ([fe80::c0b8:71fb:e1f0:d13a]) by MN2PR12MB3248.namprd12.prod.outlook.com
 ([fe80::c0b8:71fb:e1f0:d13a%3]) with mapi id 15.20.1495.011; Mon, 7 Jan 2019
 10:37:24 +0000
From:   "S, Shirish" <Shirish.S@amd.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "maintainer : X86 ARCHITECTURE" <x86@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "open list : X86 ARCHITECTURE" <linux-kernel@vger.kernel.org>,
        "S, Shirish" <Shirish.S@amd.com>
Subject: [PATCH 2/2] x86/mce/amd: Ensure quirks are applied in resume path as
 well
Thread-Topic: [PATCH 2/2] x86/mce/amd: Ensure quirks are applied in resume
 path as well
Thread-Index: AQHUpnT6RX1zZkZcBk29IptIsRwq2g==
Date:   Mon, 7 Jan 2019 10:37:24 +0000
Message-ID: <1546857399-2926-3-git-send-email-shirish.s@amd.com>
References: <1546857399-2926-1-git-send-email-shirish.s@amd.com>
In-Reply-To: <1546857399-2926-1-git-send-email-shirish.s@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BM1PR01CA0120.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:40::14) To MN2PR12MB3248.namprd12.prod.outlook.com
 (2603:10b6:208:103::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Shirish.S@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.156.251]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MN2PR12MB3391;20:ul7sW1M7pL8koxqtBx0M+z4X27C621nPQL1zDueyyO7aPgqMZ2JZZxqaIhL4j2jWRAHvbxvvITNnZdU2vb2lR3JEJXCv6lj7QAcAJPFS5fDjfzzlJmqFZWAT1QSFbTlcKTNuyHsxIqPyYdAsBakSH5GT80kLjtCqs74pxeV+JDP120qV9jh/hAYLXi2Vm6zfNQL3zxrus4SUL6Pq4PFKUSHzIdZR2mpDsHJj9/ZRWOzX7AaXZ857l/SRpyyH8sT9
x-ms-office365-filtering-correlation-id: 237d59c3-d7e8-439e-4eac-08d6748c1ca3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MN2PR12MB3391;
x-ms-traffictypediagnostic: MN2PR12MB3391:
x-microsoft-antispam-prvs: <MN2PR12MB33913107E0B4616BFF30D322F2890@MN2PR12MB3391.namprd12.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3231475)(944501520)(52105112)(3002001)(10201501046)(93006095)(93001095)(6055026)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:MN2PR12MB3391;BCL:0;PCL:0;RULEID:;SRVR:MN2PR12MB3391;
x-forefront-prvs: 0910AAF391
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(346002)(39860400002)(396003)(136003)(189003)(199004)(2906002)(81156014)(8936002)(36756003)(26005)(14454004)(316002)(3846002)(99286004)(54906003)(72206003)(68736007)(486006)(476003)(478600001)(66066001)(86362001)(109986005)(6436002)(6116002)(5660300001)(6512007)(4326008)(2616005)(53936002)(105586002)(59246006)(106356001)(71190400001)(71200400001)(6486002)(76176011)(52116002)(6506007)(102836004)(386003)(256004)(14444005)(97736004)(7736002)(305945005)(8676002)(81166006)(25786009)(1671002)(186003)(11346002)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3391;H:MN2PR12MB3248.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rcdLFfu7ZdvOcQww5QJWOf0hwBfk02vu37PeijkE+piaSz3PLz+S67BlRuyVwDtnCmSLm3FGsaPnTS/uwvbuofMiUcn/GY9nVkCqtaPI92J+m27PYf5FTrDbR//LHNvDoPbj9DiVai7EN2jqI4lh2liBhUMa1yqgA7X2pq+OZE2FqGrgt1tF1IJWIYnxKg9A6OtT510P2Xe6pXbKnOk21zu42WWBCBBiEDE/ru+qQJKyFjTaNoNduO+gKUacruxPioqR7I3p7tN6WCkgIjZ9uyooJNl3TybgHwsW6W6p0eCVv/9t35q6FVaes9DL+IPK
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 237d59c3-d7e8-439e-4eac-08d6748c1ca3
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2019 10:37:24.7054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3391
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

