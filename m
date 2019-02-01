Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE43C282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 22:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B90CD2146E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 22:56:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jbqjAks5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbfBAW4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 17:56:02 -0500
Received: from mail-eopbgr690070.outbound.protection.outlook.com ([40.107.69.70]:46228
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726331AbfBAW4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 17:56:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7shpxIRa4HxVHNzAqbmFvECUP9TRbRPPa/+JMZjP/f4=;
 b=jbqjAks5+gSLIEa7Fa/QA4Wthewl9BTOuPO3DN8c2FWx3/EUR6krxBAIuFBcAXtW+7sr97n+hmi7LdO7PVXRJZXi/NhEdZkjYic7n7U5SK1Mwee7XkWfXqP/7CNqyhEp1q5bAQDSI3jciCMDzFTaYOFiuZWcdJM5kc2uRiVW03E=
Received: from BN7PR12MB2593.namprd12.prod.outlook.com (20.176.176.31) by
 BN7PR12MB2628.namprd12.prod.outlook.com (20.176.176.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Fri, 1 Feb 2019 22:55:52 +0000
Received: from BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::b9f3:7490:d57d:8dc5]) by BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::b9f3:7490:d57d:8dc5%2]) with mapi id 15.20.1580.019; Fri, 1 Feb 2019
 22:55:52 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@suse.de" <bp@suse.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: [PATCH 2/5] x86/MCE/AMD: Add new McaTypes for CS, PSP, and SMU
Thread-Topic: [PATCH 2/5] x86/MCE/AMD: Add new McaTypes for CS, PSP, and SMU
Thread-Index: AQHUuoFHtrcFp+ijY0mfPK23ECp77A==
Date:   Fri, 1 Feb 2019 22:55:52 +0000
Message-ID: <20190201225534.8177-3-Yazen.Ghannam@amd.com>
References: <20190201225534.8177-1-Yazen.Ghannam@amd.com>
In-Reply-To: <20190201225534.8177-1-Yazen.Ghannam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN2PR01CA0027.prod.exchangelabs.com (2603:10b6:804:2::37)
 To BN7PR12MB2593.namprd12.prod.outlook.com (2603:10b6:408:28::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN7PR12MB2628;20:JI5ZA6cuxWY8pZX2DmEhOSK3FTZSWf4v77VBel5nknLVQ7LmKnxAT9wF/C4NTe3kGHzM6hB7ut3H1H+DWg9kgehozmGqenQH2P7GOAdln+ZKIN+rFNtpVmX0gxrvpJzPurziEtTBoFRyKP4NmPQG2y4r417s/0xlGJrvw54Nchna7GeVRHgLarH7myl0ZKi6iqv1hCBaVlQybzoM6PoNZvleJoz0CMxHaYzxa2FXgRXJapc08I8rN8rCcaKuUiTm
x-ms-office365-filtering-correlation-id: 280e4b5e-4cfe-46ed-014d-08d688986a2f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN7PR12MB2628;
x-ms-traffictypediagnostic: BN7PR12MB2628:
x-microsoft-antispam-prvs: <BN7PR12MB262848E0F2508AF66AC184ADF8920@BN7PR12MB2628.namprd12.prod.outlook.com>
x-forefront-prvs: 09352FD734
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(136003)(39860400002)(366004)(189003)(199004)(186003)(1076003)(2351001)(106356001)(71190400001)(14444005)(52116002)(256004)(3846002)(105586002)(50226002)(6512007)(6116002)(25786009)(5640700003)(6436002)(66066001)(71200400001)(26005)(478600001)(6486002)(76176011)(316002)(97736004)(2906002)(11346002)(305945005)(7736002)(81166006)(8676002)(81156014)(54906003)(68736007)(446003)(36756003)(6916009)(99286004)(6506007)(2616005)(476003)(386003)(86362001)(102836004)(4326008)(14454004)(72206003)(2501003)(8936002)(53936002)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR12MB2628;H:BN7PR12MB2593.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: uZoyDGoh//KsKNsiHdk9dMz2hIeRtG/JG2A29VOFnxchqRFGEYwjuRc0qNnc/SMSw7wn9wSQoKwrUSS/B36yzbZf+sPh2zLhBjdtEL9PRcCW5yNzBEbnYEOIj7ZTyIktFKWEei4eESEyoUo+8IXU2RpNvbrX8QjV2z1WuWCHlqjLBFf0raySQpBLG7v/CFwVBAdgcf9xKpJ6oIbFbjiw7D2YsNoRtMd2ar8KGYdSxuDn3hYTPb2GhoL+zmCg2ttyi3InC+XIhbc2P4XSfx3Geqa5dxK/UsWi/0spdHovj56mrffjkbXCgoDO6f40M0NjLJQwwdJXjw1yMgzxIw5HfIbUgfTikJOosKV8Zm6DZmdXtcNj5/YdPEppdiX/07v1kZMKqc5qYkGCpAC4Rp3V4XGgYq06AujOvZYoJjdg88E=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 280e4b5e-4cfe-46ed-014d-08d688986a2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2019 22:55:51.2642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2628
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

The existing CS, PSP, and SMU SMCA bank types will see new versions (as
indicated by their McaTypes) in future SMCA systems.

Add the new (HWID, MCATYPE) tuples for these new versions. Reuse the
same names as the older versions, since they are logically the same to
the user. SMCA systems won't mix and match IP blocks with different
McaType versions in the same system, so there isn't a need to
distinguish them. The MCA_IPID register is saved when logging an MCA
error, and that can be used to triage the error.

Also, add the new error descriptions to edac_mce_amd. Some error types
(positions in the list) are overloaded compared to the previous
McaTypes. Therefore, just create new lists of the error descriptions to
keep things simple even if some of the error descriptions are the same
between versions.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/include/asm/mce.h    |  3 ++
 arch/x86/kernel/cpu/mce/amd.c |  6 ++++
 drivers/edac/mce_amd.c        | 55 +++++++++++++++++++++++++++++++++++
 3 files changed, 64 insertions(+)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 91b65d859ca8..299a38536567 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -307,11 +307,14 @@ enum smca_bank_types {
 	SMCA_FP,	/* Floating Point */
 	SMCA_L3_CACHE,	/* L3 Cache */
 	SMCA_CS,	/* Coherent Slave */
+	SMCA_CS_V2,	/* Coherent Slave */
 	SMCA_PIE,	/* Power, Interrupts, etc. */
 	SMCA_UMC,	/* Unified Memory Controller */
 	SMCA_PB,	/* Parameter Block */
 	SMCA_PSP,	/* Platform Security Processor */
+	SMCA_PSP_V2,	/* Platform Security Processor */
 	SMCA_SMU,	/* System Management Unit */
+	SMCA_SMU_V2,	/* System Management Unit */
 	SMCA_MP5,	/* Microprocessor 5 Unit */
 	SMCA_NBIO,	/* Northbridge IO Unit */
 	SMCA_PCIE,	/* PCI Express Unit */
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 00f60b8c7e4f..bd1331b241ca 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -88,11 +88,14 @@ static struct smca_bank_name smca_names[] =3D {
 	[SMCA_FP]	=3D { "floating_point",	"Floating Point Unit" },
 	[SMCA_L3_CACHE]	=3D { "l3_cache",		"L3 Cache" },
 	[SMCA_CS]	=3D { "coherent_slave",	"Coherent Slave" },
+	[SMCA_CS_V2]	=3D { "coherent_slave",	"Coherent Slave" },
 	[SMCA_PIE]	=3D { "pie",		"Power, Interrupts, etc." },
 	[SMCA_UMC]	=3D { "umc",		"Unified Memory Controller" },
 	[SMCA_PB]	=3D { "param_block",	"Parameter Block" },
 	[SMCA_PSP]	=3D { "psp",		"Platform Security Processor" },
+	[SMCA_PSP_V2]	=3D { "psp",		"Platform Security Processor" },
 	[SMCA_SMU]	=3D { "smu",		"System Management Unit" },
+	[SMCA_SMU_V2]	=3D { "smu",		"System Management Unit" },
 	[SMCA_MP5]	=3D { "mp5",		"Microprocessor 5 Unit" },
 	[SMCA_NBIO]	=3D { "nbio",		"Northbridge IO Unit" },
 	[SMCA_PCIE]	=3D { "pcie",		"PCI Express Unit" },
@@ -153,6 +156,7 @@ static struct smca_hwid smca_hwid_mcatypes[] =3D {
 	/* Data Fabric MCA types */
 	{ SMCA_CS,	 HWID_MCATYPE(0x2E, 0x0), 0x1FF },
 	{ SMCA_PIE,	 HWID_MCATYPE(0x2E, 0x1), 0xF },
+	{ SMCA_CS_V2,	 HWID_MCATYPE(0x2E, 0x2), 0x3FFF },
=20
 	/* Unified Memory Controller MCA type */
 	{ SMCA_UMC,	 HWID_MCATYPE(0x96, 0x0), 0x3F },
@@ -162,9 +166,11 @@ static struct smca_hwid smca_hwid_mcatypes[] =3D {
=20
 	/* Platform Security Processor MCA type */
 	{ SMCA_PSP,	 HWID_MCATYPE(0xFF, 0x0), 0x1 },
+	{ SMCA_PSP_V2,	 HWID_MCATYPE(0xFF, 0x1), 0x3FFFF },
=20
 	/* System Management Unit MCA type */
 	{ SMCA_SMU,	 HWID_MCATYPE(0x01, 0x0), 0x1 },
+	{ SMCA_SMU_V2,	 HWID_MCATYPE(0x01, 0x1), 0x7FF },
=20
 	/* Microprocessor 5 Unit MCA type */
 	{ SMCA_MP5,	 HWID_MCATYPE(0x01, 0x2), 0x3FF },
diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index 5ab4ab3f0ce6..184c90172d17 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -257,6 +257,23 @@ static const char * const smca_cs_mce_desc[] =3D {
 	"ECC error on probe filter access",
 };
=20
+static const char * const smca_cs2_mce_desc[] =3D {
+	"Illegal Request",
+	"Address Violation",
+	"Security Violation",
+	"Illegal Response",
+	"Unexpected Response",
+	"Request or Probe Parity Error",
+	"Read Response Parity Error",
+	"Atomic Request Parity Error",
+	"SDP read response had no match in the CS queue",
+	"Probe Filter Protocol Error",
+	"Probe Filter ECC Error",
+	"SDP read response had an unexpected RETRY error",
+	"Counter overflow error",
+	"Counter underflow error",
+};
+
 static const char * const smca_pie_mce_desc[] =3D {
 	"HW assert",
 	"Internal PIE register security violation",
@@ -281,10 +298,45 @@ static const char * const smca_psp_mce_desc[] =3D {
 	"PSP RAM ECC or parity error",
 };
=20
+static const char * const smca_psp2_mce_desc[] =3D {
+	"High SRAM ECC or parity error",
+	"Low SRAM ECC or parity error",
+	"Instruction Cache Bank 0 ECC or parity error",
+	"Instruction Cache Bank 1 ECC or parity error",
+	"Instruction Tag Ram 0 parity error",
+	"Instruction Tag Ram 1 parity error",
+	"Data Cache Bank 0 ECC or parity error",
+	"Data Cache Bank 1 ECC or parity error",
+	"Data Cache Bank 2 ECC or parity error",
+	"Data Cache Bank 3 ECC or parity error",
+	"Data Tag Bank 0 parity error",
+	"Data Tag Bank 1 parity error",
+	"Data Tag Bank 2 parity error",
+	"Data Tag Bank 3 parity error",
+	"Dirty Data Ram parity error",
+	"TLB Bank 0 parity error",
+	"TLB Bank 1 parity error",
+	"System Hub Read Buffer ECC or parity error",
+};
+
 static const char * const smca_smu_mce_desc[] =3D {
 	"SMU RAM ECC or parity error",
 };
=20
+static const char * const smca_smu2_mce_desc[] =3D {
+	"High SRAM ECC or parity error",
+	"Low SRAM ECC or parity error",
+	"Data Cache Bank A ECC or parity error",
+	"Data Cache Bank B ECC or parity error",
+	"Data Tag Cache Bank A ECC or parity error",
+	"Data Tag Cache Bank B ECC or parity error",
+	"Instruction Cache Bank A ECC or parity error",
+	"Instruction Cache Bank B ECC or parity error",
+	"Instruction Tag Cache Bank A ECC or parity error",
+	"Instruction Tag Cache Bank B ECC or parity error",
+	"System Hub Read Buffer ECC or parity error",
+};
+
 static const char * const smca_mp5_mce_desc[] =3D {
 	"High SRAM ECC or parity error",
 	"Low SRAM ECC or parity error",
@@ -328,11 +380,14 @@ static struct smca_mce_desc smca_mce_descs[] =3D {
 	[SMCA_FP]	=3D { smca_fp_mce_desc,	ARRAY_SIZE(smca_fp_mce_desc)	},
 	[SMCA_L3_CACHE]	=3D { smca_l3_mce_desc,	ARRAY_SIZE(smca_l3_mce_desc)	},
 	[SMCA_CS]	=3D { smca_cs_mce_desc,	ARRAY_SIZE(smca_cs_mce_desc)	},
+	[SMCA_CS_V2]	=3D { smca_cs2_mce_desc,	ARRAY_SIZE(smca_cs2_mce_desc)	},
 	[SMCA_PIE]	=3D { smca_pie_mce_desc,	ARRAY_SIZE(smca_pie_mce_desc)	},
 	[SMCA_UMC]	=3D { smca_umc_mce_desc,	ARRAY_SIZE(smca_umc_mce_desc)	},
 	[SMCA_PB]	=3D { smca_pb_mce_desc,	ARRAY_SIZE(smca_pb_mce_desc)	},
 	[SMCA_PSP]	=3D { smca_psp_mce_desc,	ARRAY_SIZE(smca_psp_mce_desc)	},
+	[SMCA_PSP_V2]	=3D { smca_psp2_mce_desc,	ARRAY_SIZE(smca_psp2_mce_desc)	},
 	[SMCA_SMU]	=3D { smca_smu_mce_desc,	ARRAY_SIZE(smca_smu_mce_desc)	},
+	[SMCA_SMU_V2]	=3D { smca_smu2_mce_desc,	ARRAY_SIZE(smca_smu2_mce_desc)	},
 	[SMCA_MP5]	=3D { smca_mp5_mce_desc,	ARRAY_SIZE(smca_mp5_mce_desc)	},
 	[SMCA_NBIO]	=3D { smca_nbio_mce_desc,	ARRAY_SIZE(smca_nbio_mce_desc)	},
 	[SMCA_PCIE]	=3D { smca_pcie_mce_desc,	ARRAY_SIZE(smca_pcie_mce_desc)	},
--=20
2.17.1

