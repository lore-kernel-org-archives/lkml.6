Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D81AC43612
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 07:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1342E2173B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 07:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="TqlATEl2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbfAJHzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 02:55:01 -0500
Received: from mail-eopbgr710082.outbound.protection.outlook.com ([40.107.71.82]:37149
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726137AbfAJHzA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 02:55:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BhPeRBlWwOtbHRXLvuAeEhDU9FBPiZYhVYpdrPCNzIs=;
 b=TqlATEl2YkeZIYb4D0Rs1KS1sGaQs0pD+GYm82/zQFf8UO+4H3/HhUbQ5lROTHDiPKxvzCEwHdrvWsn/XfvwPY5U2nY+i/FEqyq7wRShugOkOP54JTeXe87myGVARFhiH6saAIX68Qo7lO8jY/lWIoark2GL7DL5m72vrepIRTk=
Received: from BYAPR12MB3237.namprd12.prod.outlook.com (20.179.93.25) by
 BYAPR12MB2664.namprd12.prod.outlook.com (20.176.255.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.7; Thu, 10 Jan 2019 07:54:57 +0000
Received: from BYAPR12MB3237.namprd12.prod.outlook.com
 ([fe80::a96e:ffd:3bd6:c5f5]) by BYAPR12MB3237.namprd12.prod.outlook.com
 ([fe80::a96e:ffd:3bd6:c5f5%4]) with mapi id 15.20.1516.015; Thu, 10 Jan 2019
 07:54:57 +0000
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
Subject: [PATCH 3/3] x86/mce/amd: apply MC4_MISC thresholding quirk in resume
 path
Thread-Topic: [PATCH 3/3] x86/mce/amd: apply MC4_MISC thresholding quirk in
 resume path
Thread-Index: AQHUqLnHB13ZKEhKo02PPEZFF2WZ2Q==
Date:   Thu, 10 Jan 2019 07:54:57 +0000
Message-ID: <1547106849-3476-4-git-send-email-shirish.s@amd.com>
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
x-microsoft-exchange-diagnostics: 1;BYAPR12MB2664;20:4d8UovsRvooGvKgB99vhwVvvaza/Rk5OJZut9lnZ55M3Mzo1iyJWrS7HgRzWk1bceCYJ/eNG2WmP8xjfpS7fvZWgqkcj1Xmzbtg8JY7sqi+Tb8AS7w5sBk5xLHGRGixz9MrD8MbLvk+joJDfggy67CQs7O5KijJpf27JWlYv3Dl51EvUPtSVJj6Qp0c1Uo9aN2DmUQtueDWXEVpU+tdNJBOU5XVWC4r5zs2CH6oGvXobG/Xq7CLE6Sn3Ohh6Jgc3
x-ms-office365-filtering-correlation-id: 38320609-0289-4a10-3791-08d676d0e9c3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB2664;
x-ms-traffictypediagnostic: BYAPR12MB2664:
x-microsoft-antispam-prvs: <BYAPR12MB2664D41BCC273E617D12C886F2840@BYAPR12MB2664.namprd12.prod.outlook.com>
x-forefront-prvs: 0913EA1D60
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(39860400002)(366004)(136003)(189003)(199004)(102836004)(6512007)(186003)(386003)(97736004)(66066001)(72206003)(6506007)(68736007)(86362001)(26005)(6116002)(81166006)(478600001)(316002)(52116002)(81156014)(486006)(54906003)(25786009)(76176011)(2906002)(3846002)(99286004)(53936002)(105586002)(6916009)(2616005)(256004)(4326008)(71190400001)(71200400001)(36756003)(446003)(7736002)(6436002)(305945005)(14454004)(5660300001)(106356001)(11346002)(6486002)(8936002)(8676002)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2664;H:BYAPR12MB3237.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8w9zCX1qKprwRCNLxKV2X04Jij+H/i6oKBRtfdWl5zuj80pRyvTxBrJDABazOLQ39mWJ21ZAwnVMEKrk+pDOt+K9ml/3ESCEASCycHr1LMAnVKHGigl2Krua2YXkWEWUKHcqF5tw1Sd7eFSLkGjKmHUYspQZcNbLSjPK4fNbBuyMW3cbCxevo+l+5Koa3sY7yICReh1aWhvZgr1C/FRWc+2k5GBb5xgrpBcqem8YwzeMNs4H2aHdnr28C9ykUzv/cnbxH9t9dvVXm2kK+Oyj+KfwQpvkMJgSqvcb9+v1DULinal53IIBc3k6NsCv7KDx
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38320609-0289-4a10-3791-08d676d0e9c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2019 07:54:57.1976
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2664
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are 2 code paths leading to mce_amd_feature_init() as below.
1) S5 -> S0: (boot)
secondary_startup_64 -> start_kernel -> identify_boot_cpu ->
identify_cpu ->
mcheck_cpu_init (calls  __mcheck_cpu_apply_quirks before) ->
mce_amd_feature_init

2) S3 -> S0: (resume)
syscore_resume -> mce_syscore_resume -> mce_amd_feature_init

Its clear that the quirks are not applied in S3 -> S0 path, hence apply
the same.

Signed-off-by: Shirish S <shirish.s@amd.com>
---
 arch/x86/kernel/cpu/mce/amd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 89298c8..ab1b12a 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -552,6 +552,12 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
 	unsigned int bank, block, cpu =3D smp_processor_id();
 	int offset =3D -1;
=20
+	/*
+	 * mcheck_cpu_init() is not called when called by mce_syscore_resume(),
+	 * hence re-apply quirks, to be on safer side.
+	 */
+	quirk_fam15_mc4_misc_thresholding();
+
 	for (bank =3D 0; bank < mca_cfg.banks; ++bank) {
 		if (mce_flags.smca)
 			smca_configure(bank, cpu);
--=20
2.7.4

