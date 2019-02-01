Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A955BC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 22:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DC252146E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 22:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="cMXsu85o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbfBAWz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 17:55:59 -0500
Received: from mail-eopbgr690070.outbound.protection.outlook.com ([40.107.69.70]:46228
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727047AbfBAWz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 17:55:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b2kENYtyGQcFHUanjcLv25rC1vNRVqw3MQ6Y2JPgobw=;
 b=cMXsu85o/2co1KY+8/zBRzr/ch7A2XKR7E0iHv0lXoYWem5HbEnM2UKhMv+RO10+I/H35G6bD8L5rExfaYwBq0NeADhgtxbTTTZpmLCdcHHoLtZ8ICqiYTzfPE/kJBmgtWS35yLqBWSx8qQbpNP3Vfyd/KmWFjdOAGn4M88rfWo=
Received: from BN7PR12MB2593.namprd12.prod.outlook.com (20.176.176.31) by
 BN7PR12MB2628.namprd12.prod.outlook.com (20.176.176.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Fri, 1 Feb 2019 22:55:51 +0000
Received: from BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::b9f3:7490:d57d:8dc5]) by BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::b9f3:7490:d57d:8dc5%2]) with mapi id 15.20.1580.019; Fri, 1 Feb 2019
 22:55:51 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@suse.de" <bp@suse.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: [PATCH 1/5] x86/MCE/AMD: Add new MP5, NBIO, and PCIE SMCA bank types
Thread-Topic: [PATCH 1/5] x86/MCE/AMD: Add new MP5, NBIO, and PCIE SMCA bank
 types
Thread-Index: AQHUuoFHplexZOVLS0Gr8c7sg1118A==
Date:   Fri, 1 Feb 2019 22:55:51 +0000
Message-ID: <20190201225534.8177-2-Yazen.Ghannam@amd.com>
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
x-microsoft-exchange-diagnostics: 1;BN7PR12MB2628;20:0rPsp3JjnWmFWiPPek9kcYnrAEXB8d9wbKKyj+7Zm6NC48N381bxPp5yDadqccz4iIj/y81tptigyrTf9dipT31xqWI89nnIRwUJ3Y1lKgisyzCHuZ0E0QjoXk576h26LVXMopI7GjCvy7s5HwPV9Kc9h4z+ognYzdUDQ6Tkq8L8WliaY10w4xsBkk+8j/6ENkGLAjveclv3pET5aWemxNEgkjOQU9m1WP2um+QMQfcxf2F+clJYTvBIkTEnBywH
x-ms-office365-filtering-correlation-id: d0054f87-eaa2-4258-d467-08d6889869a2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN7PR12MB2628;
x-ms-traffictypediagnostic: BN7PR12MB2628:
x-microsoft-antispam-prvs: <BN7PR12MB26288F41D007065B73712734F8920@BN7PR12MB2628.namprd12.prod.outlook.com>
x-forefront-prvs: 09352FD734
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(136003)(39860400002)(366004)(189003)(199004)(186003)(1076003)(2351001)(106356001)(71190400001)(14444005)(52116002)(256004)(15650500001)(3846002)(105586002)(50226002)(6512007)(6116002)(25786009)(5640700003)(6436002)(66066001)(71200400001)(26005)(478600001)(6486002)(76176011)(316002)(97736004)(2906002)(11346002)(305945005)(7736002)(81166006)(8676002)(81156014)(54906003)(68736007)(446003)(36756003)(6916009)(99286004)(6506007)(2616005)(476003)(386003)(86362001)(102836004)(4326008)(14454004)(72206003)(217873002)(2501003)(8936002)(53936002)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR12MB2628;H:BN7PR12MB2593.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: s2/8Uwp9ymuPD5PE6kZgobUBnVPoCqphW9AgJqQ2ixIjVuqf0G3rWZbY7hr+5iZExJLXWp9l9SWMwqFAXDMMkrGvhL6DZgsd3PvniRtbfCHHDQ653Ro0wRoYHSWwTHgHvsueIsntvqHrUOcnXaL8h3obVXgezEhi/St/xfhzvKd78LM1rxtcLvbfC0+h4GjZx40sIiytYLsJkrln7Vu6OSjNbd4BnqtA/ZbBFIfQDmjxNjtuWRwiTfovfScOXAHbQHQC5O8BxpD4pvreJwKSaP3S9sM960whxdoB7k6qzcYJ3Uj/VxgTO+fpgr+jO0GWqumahtMHsxx9V13XxZcpDcu4AW/CAJ8dH10fHSTyyQh19evJ2DIalWoY++6MJd4O83Eae5eUSn+Lt1o28JZMvUUkhFFbgPFXyCctfHbu+IU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0054f87-eaa2-4258-d467-08d6889869a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2019 22:55:50.3185
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

Add the (HWID, MCATYPE) tuples and names for the new MP5, NBIO, and
PCIE SMCA bank types.

Also, add their respective error descriptions to edac_mce_amd.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/include/asm/mce.h    |  3 +++
 arch/x86/kernel/cpu/mce/amd.c | 12 ++++++++++++
 drivers/edac/mce_amd.c        | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 47 insertions(+)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index c1a812bd5a27..91b65d859ca8 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -312,6 +312,9 @@ enum smca_bank_types {
 	SMCA_PB,	/* Parameter Block */
 	SMCA_PSP,	/* Platform Security Processor */
 	SMCA_SMU,	/* System Management Unit */
+	SMCA_MP5,	/* Microprocessor 5 Unit */
+	SMCA_NBIO,	/* Northbridge IO Unit */
+	SMCA_PCIE,	/* PCI Express Unit */
 	N_SMCA_BANK_TYPES
 };
=20
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index ed3327342b40..00f60b8c7e4f 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -93,6 +93,9 @@ static struct smca_bank_name smca_names[] =3D {
 	[SMCA_PB]	=3D { "param_block",	"Parameter Block" },
 	[SMCA_PSP]	=3D { "psp",		"Platform Security Processor" },
 	[SMCA_SMU]	=3D { "smu",		"System Management Unit" },
+	[SMCA_MP5]	=3D { "mp5",		"Microprocessor 5 Unit" },
+	[SMCA_NBIO]	=3D { "nbio",		"Northbridge IO Unit" },
+	[SMCA_PCIE]	=3D { "pcie",		"PCI Express Unit" },
 };
=20
 static u32 smca_bank_addrs[MAX_NR_BANKS][NR_BLOCKS] __ro_after_init =3D
@@ -162,6 +165,15 @@ static struct smca_hwid smca_hwid_mcatypes[] =3D {
=20
 	/* System Management Unit MCA type */
 	{ SMCA_SMU,	 HWID_MCATYPE(0x01, 0x0), 0x1 },
+
+	/* Microprocessor 5 Unit MCA type */
+	{ SMCA_MP5,	 HWID_MCATYPE(0x01, 0x2), 0x3FF },
+
+	/* Northbridge IO Unit MCA type */
+	{ SMCA_NBIO,	 HWID_MCATYPE(0x18, 0x0), 0x1F },
+
+	/* PCI Express Unit MCA type */
+	{ SMCA_PCIE,	 HWID_MCATYPE(0x46, 0x0), 0x1F },
 };
=20
 struct smca_bank smca_banks[MAX_NR_BANKS];
diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index c605089d899f..5ab4ab3f0ce6 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -285,6 +285,35 @@ static const char * const smca_smu_mce_desc[] =3D {
 	"SMU RAM ECC or parity error",
 };
=20
+static const char * const smca_mp5_mce_desc[] =3D {
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
+};
+
+static const char * const smca_nbio_mce_desc[] =3D {
+	"ECC or Parity error",
+	"PCIE error",
+	"SDP ErrEvent error",
+	"SDP Egress Poison Error",
+	"IOHC Internal Poison Error",
+};
+
+static const char * const smca_pcie_mce_desc[] =3D {
+	"CCIX PER Message logging",
+	"CCIX Read Response with Status: Non-Data Error",
+	"CCIX Write Response with Status: Non-Data Error",
+	"CCIX Read Response with Status: Data Error",
+	"CCIX Non-okay write response with data error",
+};
+
 struct smca_mce_desc {
 	const char * const *descs;
 	unsigned int num_descs;
@@ -304,6 +333,9 @@ static struct smca_mce_desc smca_mce_descs[] =3D {
 	[SMCA_PB]	=3D { smca_pb_mce_desc,	ARRAY_SIZE(smca_pb_mce_desc)	},
 	[SMCA_PSP]	=3D { smca_psp_mce_desc,	ARRAY_SIZE(smca_psp_mce_desc)	},
 	[SMCA_SMU]	=3D { smca_smu_mce_desc,	ARRAY_SIZE(smca_smu_mce_desc)	},
+	[SMCA_MP5]	=3D { smca_mp5_mce_desc,	ARRAY_SIZE(smca_mp5_mce_desc)	},
+	[SMCA_NBIO]	=3D { smca_nbio_mce_desc,	ARRAY_SIZE(smca_nbio_mce_desc)	},
+	[SMCA_PCIE]	=3D { smca_pcie_mce_desc,	ARRAY_SIZE(smca_pcie_mce_desc)	},
 };
=20
 static bool f12h_mc0_mce(u16 ec, u8 xec)
--=20
2.17.1

