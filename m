Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE69C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 20:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5690E20827
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 20:30:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="u6yl2iyg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5690E20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbeJaFZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 01:25:40 -0400
Received: from mail-eopbgr40066.outbound.protection.outlook.com ([40.107.4.66]:47616
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725743AbeJaFZj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 01:25:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BNI7VbNHrZYR45mvOaU4FWpC0qp3ozEtl01AmDOwS/U=;
 b=u6yl2iygBojwLxsmDQ3TP0TUH5A6XwEwvorLtE+K9SpQ87M+lKQ8jliKJVxmqPFD+tbPjty/ipCB5U+VTbpm2ZjOCDfGrorKfkrKAm8suJPrjCRJHrO6jf8RgMmwm9HtRwkaMHmZ3UR8spwQIYuBBZXq1FlW4YFrzr/TpCl918Q=
Received: from DB6PR0402MB2727.eurprd04.prod.outlook.com (10.172.245.17) by
 DB6PR0402MB2920.eurprd04.prod.outlook.com (10.172.248.143) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.19; Tue, 30 Oct 2018 20:30:37 +0000
Received: from DB6PR0402MB2727.eurprd04.prod.outlook.com
 ([fe80::e012:b6c0:4c6c:c314]) by DB6PR0402MB2727.eurprd04.prod.outlook.com
 ([fe80::e012:b6c0:4c6c:c314%4]) with mapi id 15.20.1273.027; Tue, 30 Oct 2018
 20:30:37 +0000
From:   Roy Pledge <roy.pledge@nxp.com>
To:     "stuyoder@gmail.com" <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Leo Li <leoyang.li@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     Youri Querry <youri.querry_1@nxp.com>,
        Roy Pledge <roy.pledge@nxp.com>
Subject: [PATCH v1 1/2] bus: mc-bus: Add support for mapping shareable portals
Thread-Topic: [PATCH v1 1/2] bus: mc-bus: Add support for mapping shareable
 portals
Thread-Index: AQHUcI9qH+mPzbXUkkeH/d/lTd6AeA==
Date:   Tue, 30 Oct 2018 20:30:37 +0000
Message-ID: <1540931418-10697-2-git-send-email-roy.pledge@nxp.com>
References: <1540931418-10697-1-git-send-email-roy.pledge@nxp.com>
In-Reply-To: <1540931418-10697-1-git-send-email-roy.pledge@nxp.com>
Reply-To: Roy Pledge <roy.pledge@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: BYAPR02CA0026.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::39) To DB6PR0402MB2727.eurprd04.prod.outlook.com
 (2603:10a6:4:94::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=roy.pledge@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [72.142.119.78]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR0402MB2920;6:zYbms865/5iMCcKYVjUqyjR9/yvtH4fEFabmbEaZPKHMPOgCKp5yjn4FFtDmkOfeMwg3vCajdyRaMt1a0ZqQ3C/PwZjQVM9mqsgVzB9Q3h4lpwCCIuI5oj0t0GUEvEbjhg6cQ82Twt8k+0g3jUej+AZUOqoelL4f5a4EbOrkxMya4D2aVmOFCoWx3sOrMEEoMZFtGsT2Hy8IH3/O5IY7Q5Zs7sGE1eG3dRlh7KKElYUJFWxPqXLZ3NMtZbE6dLQGcaZ9utS+z9Xt6qkLq/UUXJ2amOq08yG1R8b97Jx+uKtFEpGPRrZpUd3lfEetY8Ha37XQzBWbdQqK5puUcxJ26lEDrtHU/w+pgRt7BZt2I47b8DK5+1NfE4Np11pMxejexkFB0OKtOnM+WwkFV19C5Nl8q0kTXLg/sPJ0onorntBBntC/0m4jhau8V8BW8w0I1HYqus6FdeuWDevqUApw6g==;5:qKCL3J2ECDh+x9jYrpzHeK1JwUpHdG7KY1vdlLX8mgDsRFxQK4nWzj8Cr61z/8QronQazKdVEap31d9e1X5Ne6P5hZ1SNySvq4QQG+C4ya3kT/DI4TtQ4G27eHNFOqI7Tu6lBQ9kDdtjyC6cbuFVg6sZlX/u1tjf6OIp6eVHpks=;7:cPvL6pGyKA/17hGq2KO81CQfwtUNS+heStpTc1wLNlBVwTrjHpYM2qMMIA64B8oSIZ5v0FxYMjQsdvJ4Sw53yK0e3h1OQsoYsobmFFRc83eCkCgzESx7DOI0JHq4TAmBpE1gQR4OyCPnWODcP1upww==
x-ms-office365-filtering-correlation-id: 788f035f-3c5e-4c13-35e5-08d63ea68cf9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB6PR0402MB2920;
x-ms-traffictypediagnostic: DB6PR0402MB2920:
x-microsoft-antispam-prvs: <DB6PR0402MB2920F729A40EA1AD1DE51C2186CC0@DB6PR0402MB2920.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(227817650892897)(275809806118684)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DB6PR0402MB2920;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0402MB2920;
x-forefront-prvs: 08417837C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(376002)(39860400002)(396003)(346002)(199004)(189003)(43066004)(7736002)(81156014)(8676002)(99286004)(3450700001)(6486002)(81166006)(2501003)(76176011)(68736007)(6436002)(97736004)(8936002)(2900100001)(102836004)(305945005)(14454004)(71190400001)(105586002)(53936002)(478600001)(6512007)(52116002)(5250100002)(6506007)(386003)(36756003)(106356001)(71200400001)(186003)(5660300001)(3846002)(50226002)(2616005)(11346002)(446003)(256004)(54906003)(486006)(14444005)(476003)(110136005)(86362001)(44832011)(66066001)(25786009)(575784001)(316002)(4326008)(26005)(2201001)(39060400002)(2906002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0402MB2920;H:DB6PR0402MB2727.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 9fcp3n3ceJA//8J6BNBFmZM/sEolSRAwGrVk2UZCs6uIsq+b81cDJ9pAnTRXcTxBwShFusR+YNWdDFqCK//TY/2+Hw1xZYjkNG8o9tkgtwH2pK9E99VRwKOdzY7qAUeEsWLSsLdV/lZFqaf52EgVM1VOLlfQkGVP/soX/T9fH8gHd1cSK6ANInzCVndSVLAH7AuxbvHkYw0d4b61RthVWKFa4Si0rOd0mO7OcPgzKPEg037VCAkPSFd6p2G6z+P0sg0Heh9vveUMf/Vgyg2b3xVJsernRvmPeDVvSTjFuZQZZVbfu7w2kedtOuehn2Y1OZYljB5ElbRu8hlQeJqBSF/vgkE2d1iwsBvy755T7tg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 788f035f-3c5e-4c13-35e5-08d63ea68cf9
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2018 20:30:37.4613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2920
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Starting with v5 of NXP QBMan devices the hardware supports using
regular cacheable/shareable memory as the backing store for the
portals.

This patch adds support for the new portal mode by switching to
use the DPRC get object region v2 command which returns both
a base address and offset for the portal memory. The new portal
region is identified as shareable through the addition of a new
flag.

Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
---
 drivers/bus/fsl-mc/dprc.c           |  3 ++-
 drivers/bus/fsl-mc/fsl-mc-bus.c     | 14 ++++++++++++--
 drivers/bus/fsl-mc/fsl-mc-private.h | 17 ++++++++++++++---
 3 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/bus/fsl-mc/dprc.c b/drivers/bus/fsl-mc/dprc.c
index 1c3f621..bde856d 100644
--- a/drivers/bus/fsl-mc/dprc.c
+++ b/drivers/bus/fsl-mc/dprc.c
@@ -461,8 +461,9 @@ int dprc_get_obj_region(struct fsl_mc_io *mc_io,
=20
 	/* retrieve response parameters */
 	rsp_params =3D (struct dprc_rsp_get_obj_region *)cmd.params;
-	region_desc->base_offset =3D le64_to_cpu(rsp_params->base_addr);
+	region_desc->base_offset =3D le64_to_cpu(rsp_params->base_offset);
 	region_desc->size =3D le32_to_cpu(rsp_params->size);
+	region_desc->base_address =3D le64_to_cpu(rsp_params->base_addr);
=20
 	return 0;
 }
diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bu=
s.c
index f0404c6..25ad422 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -487,10 +487,18 @@ static int fsl_mc_device_get_mmio_regions(struct fsl_=
mc_device *mc_dev,
 				"dprc_get_obj_region() failed: %d\n", error);
 			goto error_cleanup_regions;
 		}
-
-		error =3D translate_mc_addr(mc_dev, mc_region_type,
+		/* Older MC only returned region offset and no base address
+		 * If base address is in the region_desc use it otherwise
+		 * revert to old mechanism
+		 */
+		if (region_desc.base_address)
+			regions[i].start =3D region_desc.base_address +
+						region_desc.base_offset;
+		else
+			error =3D translate_mc_addr(mc_dev, mc_region_type,
 					  region_desc.base_offset,
 					  &regions[i].start);
+
 		if (error < 0) {
 			dev_err(parent_dev,
 				"Invalid MC offset: %#x (for %s.%d\'s region %d)\n",
@@ -504,6 +512,8 @@ static int fsl_mc_device_get_mmio_regions(struct fsl_mc=
_device *mc_dev,
 		regions[i].flags =3D IORESOURCE_IO;
 		if (region_desc.flags & DPRC_REGION_CACHEABLE)
 			regions[i].flags |=3D IORESOURCE_CACHEABLE;
+		if (region_desc.flags & DPRC_REGION_SHAREABLE)
+			regions[i].flags |=3D IORESOURCE_MEM;
 	}
=20
 	mc_dev->regions =3D regions;
diff --git a/drivers/bus/fsl-mc/fsl-mc-private.h b/drivers/bus/fsl-mc/fsl-m=
c-private.h
index ea11b4f..28e40d1 100644
--- a/drivers/bus/fsl-mc/fsl-mc-private.h
+++ b/drivers/bus/fsl-mc/fsl-mc-private.h
@@ -79,9 +79,11 @@ int dpmcp_reset(struct fsl_mc_io *mc_io,
=20
 /* DPRC command versioning */
 #define DPRC_CMD_BASE_VERSION			1
+#define DPRC_CMD_2ND_VERSION			2
 #define DPRC_CMD_ID_OFFSET			4
=20
 #define DPRC_CMD(id)	(((id) << DPRC_CMD_ID_OFFSET) | DPRC_CMD_BASE_VERSION=
)
+#define DPRC_CMD_V2(id)	(((id) << DPRC_CMD_ID_OFFSET) | DPRC_CMD_2ND_VERSI=
ON)
=20
 /* DPRC command IDs */
 #define DPRC_CMDID_CLOSE                        DPRC_CMD(0x800)
@@ -99,7 +101,7 @@ int dpmcp_reset(struct fsl_mc_io *mc_io,
 #define DPRC_CMDID_GET_CONT_ID                  DPRC_CMD(0x830)
 #define DPRC_CMDID_GET_OBJ_COUNT                DPRC_CMD(0x159)
 #define DPRC_CMDID_GET_OBJ                      DPRC_CMD(0x15A)
-#define DPRC_CMDID_GET_OBJ_REG                  DPRC_CMD(0x15E)
+#define DPRC_CMDID_GET_OBJ_REG                  DPRC_CMD_V2(0x15E)
 #define DPRC_CMDID_SET_OBJ_IRQ                  DPRC_CMD(0x15F)
=20
 struct dprc_cmd_open {
@@ -199,9 +201,15 @@ struct dprc_rsp_get_obj_region {
 	/* response word 0 */
 	__le64 pad;
 	/* response word 1 */
-	__le64 base_addr;
+	__le64 base_offset;
 	/* response word 2 */
 	__le32 size;
+	u8 pad2[3];
+	/* response word 3 */
+	__le32 flags;
+	__le32 pad3;
+	/* response word 4 */
+	__le64 base_addr;
 };
=20
 struct dprc_cmd_set_obj_irq {
@@ -334,6 +342,7 @@ int dprc_set_obj_irq(struct fsl_mc_io *mc_io,
 /* Region flags */
 /* Cacheable - Indicates that region should be mapped as cacheable */
 #define DPRC_REGION_CACHEABLE	0x00000001
+#define DPRC_REGION_SHAREABLE	0x00000002
=20
 /**
  * enum dprc_region_type - Region type
@@ -342,7 +351,8 @@ int dprc_set_obj_irq(struct fsl_mc_io *mc_io,
  */
 enum dprc_region_type {
 	DPRC_REGION_TYPE_MC_PORTAL,
-	DPRC_REGION_TYPE_QBMAN_PORTAL
+	DPRC_REGION_TYPE_QBMAN_PORTAL,
+	DPRC_REGION_TYPE_QBMAN_MEM_BACKED_PORTAL
 };
=20
 /**
@@ -360,6 +370,7 @@ struct dprc_region_desc {
 	u32 size;
 	u32 flags;
 	enum dprc_region_type type;
+	u64 base_address;
 };
=20
 int dprc_get_obj_region(struct fsl_mc_io *mc_io,
--=20
2.7.4

