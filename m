Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BA9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 698412147A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="OsoqGj8D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729712AbfBSU0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 15:26:18 -0500
Received: from mail-eopbgr790045.outbound.protection.outlook.com ([40.107.79.45]:45346
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729626AbfBSU0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 15:26:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7Dj7CFeYv6Pm/QC8x7JqHrOp8uo0ln6/MNqlzTTAaA=;
 b=OsoqGj8DmJIPkhsfrztEv1K2Zt1Zf6iFw3LGAms2RytUkTgWq69jo0skDIq4s1AFr69Pr4HTXP+FJaistHZqdrJa+hFBUtMs43Q7ydviaFQvKnf2Evp6geyJnPQR0rvbl6HlwoEHVsnrE5cZQnmvRfUju9GHfNtd0Y0/5w32zYs=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2845.namprd12.prod.outlook.com (52.135.102.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Tue, 19 Feb 2019 20:26:10 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::35e5:6f95:dfe:efe]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::35e5:6f95:dfe:efe%2]) with mapi id 15.20.1622.018; Tue, 19 Feb 2019
 20:26:10 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>
Subject: [PATCH 4/5] EDAC/amd64: Support more than two Controllers for Chip
 Select handling
Thread-Topic: [PATCH 4/5] EDAC/amd64: Support more than two Controllers for
 Chip Select handling
Thread-Index: AQHUyJFZIoXiFFPdbUiWkc9CLBaM1A==
Date:   Tue, 19 Feb 2019 20:26:09 +0000
Message-ID: <20190219202536.15462-4-Yazen.Ghannam@amd.com>
References: <20190219202536.15462-1-Yazen.Ghannam@amd.com>
In-Reply-To: <20190219202536.15462-1-Yazen.Ghannam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN2PR01CA0031.prod.exchangelabs.com (2603:10b6:804:2::41)
 To SN6PR12MB2639.namprd12.prod.outlook.com (2603:10b6:805:6f::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 979473ae-9172-454a-b15e-08d696a87313
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR12MB2845;
x-ms-traffictypediagnostic: SN6PR12MB2845:
x-microsoft-exchange-diagnostics: 1;SN6PR12MB2845;20:OpWqNA/6YWIVOs9P3P4eMWW9iadpFm2TP/mxJsQN55+HdhuzDZeGFS4G7/6d4zRRXvWNDxhYzO8Y9EN3/AHp13wfQhwP85XNRa5GIQ0CgTew/PDlj0ySHVo9FxE1mIr2+Fkrd+xqj9gUPuFYO/CEUKJdB7+hPoLtWtw3wzwDxJEOYUnBN/EA3DSWvoQ2fff4JLN99st/fjo5N20WAPxHMZILV5kvmGYvsUBnpT49zYt9qVUZiU2XhGm/PQ0UVpVG
x-microsoft-antispam-prvs: <SN6PR12MB2845D447A87C5ADB3E24D7BEF87C0@SN6PR12MB2845.namprd12.prod.outlook.com>
x-forefront-prvs: 09538D3531
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(376002)(346002)(396003)(39860400002)(199004)(189003)(2351001)(256004)(6506007)(386003)(8676002)(54906003)(5660300002)(4326008)(8936002)(50226002)(14444005)(68736007)(1076003)(97736004)(76176011)(102836004)(2501003)(105586002)(316002)(6116002)(81156014)(86362001)(305945005)(106356001)(7736002)(3846002)(53936002)(52116002)(81166006)(6916009)(6512007)(71190400001)(446003)(36756003)(72206003)(5640700003)(11346002)(14454004)(2906002)(6436002)(2616005)(26005)(476003)(478600001)(66066001)(6486002)(25786009)(186003)(486006)(71200400001)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2845;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lYJCZY7yWVu42j6RT/67lcseHWrtCJbFdGTveLOBgY0LOL4xQ2jMhSWstTudONRkm+1uqiz2j1Ri3yLOTLSjlhGpWsJZzvrE5f37EIDLAhECWfger96tUyXNFyo81HDKmhvt8LVPIhBb7PjL+OrqHobagxE3PHFNNIQcT8E9i/QhyQL8nYziQorTx0QxDKT0zWGmNRIAqUpc2xmcoavd2oXo3zrzvR556/7NoiAmkDx1+H6cLIF4snKOz91lYGYCE5rmXrEeVMa2L6rw2n5Pro3wwIFlZvSHzcyVLQxwxUKjPUp6Vr3WGgeGWCnmgaxQ9P9T/lzDHB857v0pKI4nyjfEPs/o5Lb/96cxi97YqEj0ghpkHfR50vyWQ2gCid22KXkF6jlLrO+5LOAkGCYrtzQcFgoRCnaNsu5L6SZV9L8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 979473ae-9172-454a-b15e-08d696a87313
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2019 20:25:54.1471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2845
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

The struct chip_select array that's used for saving Chip Select bases
and masks is fixed at length of two. There should be one struct
chip_select for each controller, so this array should be increased to
support systems that may have more than two controllers.

Increase the size of the struct chip_select array to eight, which is the
largest number of controllers per die currently supported on AMD
systems.

Also, carve out the Fam17h+ reading of the bases/masks into a separate
function. This effectively reverts the original bases/masks reading code
to pre-Fam17h support.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/edac/amd64_edac.c | 113 ++++++++++++++++++++------------------
 drivers/edac/amd64_edac.h |   5 +-
 2 files changed, 62 insertions(+), 56 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index bacd2cb22f29..656788699c64 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -911,89 +911,94 @@ static void prep_chip_selects(struct amd64_pvt *pvt)
 	} else if (pvt->fam =3D=3D 0x15 && pvt->model =3D=3D 0x30) {
 		pvt->csels[0].b_cnt =3D pvt->csels[1].b_cnt =3D 4;
 		pvt->csels[0].m_cnt =3D pvt->csels[1].m_cnt =3D 2;
+	} else if (pvt->fam >=3D 0x17) {
+		int umc;
+
+		for_each_umc(umc) {
+			pvt->csels[umc].b_cnt =3D 8;
+			pvt->csels[umc].m_cnt =3D 4;
+		}
+
 	} else {
 		pvt->csels[0].b_cnt =3D pvt->csels[1].b_cnt =3D 8;
 		pvt->csels[0].m_cnt =3D pvt->csels[1].m_cnt =3D 4;
 	}
 }
=20
+static void read_umc_base_mask(struct amd64_pvt *pvt)
+{
+	int cs, umc;
+
+	for_each_umc(umc) {
+		u32 umc_base_reg =3D get_umc_base(umc) + UMCCH_BASE_ADDR;
+		u32 umc_mask_reg =3D get_umc_base(umc) + UMCCH_ADDR_MASK;
+
+		for_each_chip_select(cs, 0, pvt) {
+			u32 *base =3D &pvt->csels[umc].csbases[cs];
+			u32 *mask =3D &pvt->csels[umc].csmasks[cs];
+
+			u32 base_reg =3D umc_base_reg + (cs * 4);
+			u32 mask_reg =3D umc_mask_reg + ((cs >> 1) * 4);
+
+			if (!amd_smn_read(pvt->mc_node_id, base_reg, base))
+				edac_dbg(0, "  DCSB%d[%d]=3D0x%08x reg: 0x%x\n",
+					 umc, cs, *base, base_reg);
+
+			if (!amd_smn_read(pvt->mc_node_id, mask_reg, mask))
+				edac_dbg(0, "    DCSM%d[%d]=3D0x%08x reg: 0x%x\n",
+					 umc, cs, *mask, mask_reg);
+		}
+	}
+}
+
 /*
  * Function 2 Offset F10_DCSB0; read in the DCS Base and DCS Mask register=
s
  */
 static void read_dct_base_mask(struct amd64_pvt *pvt)
 {
-	int base_reg0, base_reg1, mask_reg0, mask_reg1, cs;
+	int cs;
=20
 	prep_chip_selects(pvt);
=20
-	if (pvt->umc) {
-		base_reg0 =3D get_umc_base(0) + UMCCH_BASE_ADDR;
-		base_reg1 =3D get_umc_base(1) + UMCCH_BASE_ADDR;
-		mask_reg0 =3D get_umc_base(0) + UMCCH_ADDR_MASK;
-		mask_reg1 =3D get_umc_base(1) + UMCCH_ADDR_MASK;
-	} else {
-		base_reg0 =3D DCSB0;
-		base_reg1 =3D DCSB1;
-		mask_reg0 =3D DCSM0;
-		mask_reg1 =3D DCSM1;
-	}
+	if (pvt->umc)
+		return read_umc_base_mask(pvt);
=20
 	for_each_chip_select(cs, 0, pvt) {
-		int reg0   =3D base_reg0 + (cs * 4);
-		int reg1   =3D base_reg1 + (cs * 4);
+		int reg0   =3D DCSB0 + (cs * 4);
+		int reg1   =3D DCSB1 + (cs * 4);
 		u32 *base0 =3D &pvt->csels[0].csbases[cs];
 		u32 *base1 =3D &pvt->csels[1].csbases[cs];
=20
-		if (pvt->umc) {
-			if (!amd_smn_read(pvt->mc_node_id, reg0, base0))
-				edac_dbg(0, "  DCSB0[%d]=3D0x%08x reg: 0x%x\n",
-					 cs, *base0, reg0);
+		if (!amd64_read_dct_pci_cfg(pvt, 0, reg0, base0))
+			edac_dbg(0, "  DCSB0[%d]=3D0x%08x reg: F2x%x\n",
+				 cs, *base0, reg0);
=20
-			if (!amd_smn_read(pvt->mc_node_id, reg1, base1))
-				edac_dbg(0, "  DCSB1[%d]=3D0x%08x reg: 0x%x\n",
-					 cs, *base1, reg1);
-		} else {
-			if (!amd64_read_dct_pci_cfg(pvt, 0, reg0, base0))
-				edac_dbg(0, "  DCSB0[%d]=3D0x%08x reg: F2x%x\n",
-					 cs, *base0, reg0);
-
-			if (pvt->fam =3D=3D 0xf)
-				continue;
+		if (pvt->fam =3D=3D 0xf)
+			continue;
=20
-			if (!amd64_read_dct_pci_cfg(pvt, 1, reg0, base1))
-				edac_dbg(0, "  DCSB1[%d]=3D0x%08x reg: F2x%x\n",
-					 cs, *base1, (pvt->fam =3D=3D 0x10) ? reg1
-								: reg0);
-		}
+		if (!amd64_read_dct_pci_cfg(pvt, 1, reg0, base1))
+			edac_dbg(0, "  DCSB1[%d]=3D0x%08x reg: F2x%x\n",
+				 cs, *base1, (pvt->fam =3D=3D 0x10) ? reg1
+							: reg0);
 	}
=20
 	for_each_chip_select_mask(cs, 0, pvt) {
-		int reg0   =3D mask_reg0 + (cs * 4);
-		int reg1   =3D mask_reg1 + (cs * 4);
+		int reg0   =3D DCSM0 + (cs * 4);
+		int reg1   =3D DCSM1 + (cs * 4);
 		u32 *mask0 =3D &pvt->csels[0].csmasks[cs];
 		u32 *mask1 =3D &pvt->csels[1].csmasks[cs];
=20
-		if (pvt->umc) {
-			if (!amd_smn_read(pvt->mc_node_id, reg0, mask0))
-				edac_dbg(0, "    DCSM0[%d]=3D0x%08x reg: 0x%x\n",
-					 cs, *mask0, reg0);
-
-			if (!amd_smn_read(pvt->mc_node_id, reg1, mask1))
-				edac_dbg(0, "    DCSM1[%d]=3D0x%08x reg: 0x%x\n",
-					 cs, *mask1, reg1);
-		} else {
-			if (!amd64_read_dct_pci_cfg(pvt, 0, reg0, mask0))
-				edac_dbg(0, "    DCSM0[%d]=3D0x%08x reg: F2x%x\n",
-					 cs, *mask0, reg0);
+		if (!amd64_read_dct_pci_cfg(pvt, 0, reg0, mask0))
+			edac_dbg(0, "    DCSM0[%d]=3D0x%08x reg: F2x%x\n",
+				 cs, *mask0, reg0);
=20
-			if (pvt->fam =3D=3D 0xf)
-				continue;
+		if (pvt->fam =3D=3D 0xf)
+			continue;
=20
-			if (!amd64_read_dct_pci_cfg(pvt, 1, reg0, mask1))
-				edac_dbg(0, "    DCSM1[%d]=3D0x%08x reg: F2x%x\n",
-					 cs, *mask1, (pvt->fam =3D=3D 0x10) ? reg1
-								: reg0);
-		}
+		if (!amd64_read_dct_pci_cfg(pvt, 1, reg0, mask1))
+			edac_dbg(0, "    DCSM1[%d]=3D0x%08x reg: F2x%x\n",
+				 cs, *mask1, (pvt->fam =3D=3D 0x10) ? reg1
+							: reg0);
 	}
 }
=20
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 6c6ce783208a..f672ed3325db 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -96,6 +96,7 @@
 /* Hardware limit on ChipSelect rows per MC and processors per system */
 #define NUM_CHIPSELECTS			8
 #define DRAM_RANGES			8
+#define NUM_CONTROLLERS			8
=20
 #define ON true
 #define OFF false
@@ -351,8 +352,8 @@ struct amd64_pvt {
 	u32 dbam0;		/* DRAM Base Address Mapping reg for DCT0 */
 	u32 dbam1;		/* DRAM Base Address Mapping reg for DCT1 */
=20
-	/* one for each DCT */
-	struct chip_select csels[2];
+	/* one for each DCT/UMC */
+	struct chip_select csels[NUM_CONTROLLERS];
=20
 	/* DRAM base and limit pairs F1x[78,70,68,60,58,50,48,40] */
 	struct dram_range ranges[DRAM_RANGES];
--=20
2.17.1

