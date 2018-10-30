Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A87B1C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 494F62080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="c+o064hR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 494F62080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727704AbeJaBVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 21:21:07 -0400
Received: from mail-sn1nam01on0071.outbound.protection.outlook.com ([104.47.32.71]:6317
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726646AbeJaBVH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 21:21:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4B0iDwPybJA66YybDdibDIl0j5KYt/8/PR1aIojuVzA=;
 b=c+o064hRNcWlQPKJd3ppsPE2u3CAIKu2HevPhn1hOYF/JtwglJM5HW5xE8AY7YmwH1rRYU8ltHHBH8p1O7Jyv6bE+vJrMovm3jY916ncWgpLaqpwuQd095XLpztER0gr9SMf5t9A8XoCPkC39DXcGL3hwLI7Tp64HXboIgxqBhM=
Received: from BL0PR12MB2355.namprd12.prod.outlook.com (52.132.10.161) by
 BL0PR12MB2579.namprd12.prod.outlook.com (52.132.27.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.26; Tue, 30 Oct 2018 16:26:53 +0000
Received: from BL0PR12MB2355.namprd12.prod.outlook.com
 ([fe80::c1c5:b396:dfc6:6c2]) by BL0PR12MB2355.namprd12.prod.outlook.com
 ([fe80::c1c5:b396:dfc6:6c2%5]) with mapi id 15.20.1273.027; Tue, 30 Oct 2018
 16:26:53 +0000
From:   "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
CC:     "Agrawal, Akshu" <Akshu.Agrawal@amd.com>,
        "djkurtz@chromium.org" <djkurtz@chromium.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] ASoC: AMD: Fix race condition between register access
Thread-Topic: [PATCH v2] ASoC: AMD: Fix race condition between register access
Thread-Index: AQHUcG1dplU2Qx48aked/GXo/GPKZg==
Date:   Tue, 30 Oct 2018 16:26:52 +0000
Message-ID: <1540916701-22028-1-git-send-email-akshu.agrawal@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BM1PR01CA0074.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1::14) To BL0PR12MB2355.namprd12.prod.outlook.com
 (2603:10b6:207:4c::33)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.156.251]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR12MB2579;20:G/9KFyWHiKOjvoQ6B9mzt6OrkBEcovs0aUWkGMCh7DOruIn2bVxCNdW4RNe/U9Xo2T8RZOeBm6XQ1rg+lbqazkICEjPt0G8eLpXSUorK56sPMqzGJkAOZrnRDFBb6TDsbuYwqHBpWGJ3NOW+YEW75nPYVBmw+4JhOskChRjLK5lEPnOGuhr+fRjPPl/5kgDpNcWd/9oewcP+2kk6jLV0mI7w7L3b5i2cTKfBoLeNbDFDGDa0tku23sI6A8bgVp3b
x-ms-office365-filtering-correlation-id: 61ea7c1d-d44a-4070-9011-08d63e847fc2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BL0PR12MB2579;
x-ms-traffictypediagnostic: BL0PR12MB2579:
x-microsoft-antispam-prvs: <BL0PR12MB25794177285285489D83AF97F8CC0@BL0PR12MB2579.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BL0PR12MB2579;BCL:0;PCL:0;RULEID:;SRVR:BL0PR12MB2579;
x-forefront-prvs: 08417837C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(39860400002)(396003)(366004)(376002)(189003)(199004)(2616005)(6436002)(2900100001)(109986005)(6116002)(5660300001)(386003)(3846002)(5250100002)(97736004)(26005)(6506007)(186003)(86362001)(6512007)(72206003)(53936002)(59246006)(25786009)(7736002)(106356001)(476003)(8676002)(102836004)(68736007)(36756003)(105586002)(8936002)(256004)(316002)(81156014)(81166006)(6486002)(14454004)(54906003)(39060400002)(66066001)(14444005)(71190400001)(4326008)(1671002)(2906002)(71200400001)(99286004)(52116002)(478600001)(486006)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR12MB2579;H:BL0PR12MB2355.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 81RVehLw43tknZn0YuSAOqp3ELD05xpxypRarV7Z608Z8axQKaBbICxnqIGhiUEWrlVSJTMzngf7CrJbSy5WIa/k22soyQj8kSjLB3Lnf/UtmjYILQI4+K8GAEq2ZRqx3KrkRaVCp0IfCedDZOZYsWHFEfGz2LHz7lGT/o/iYEV1Qpws1tFt3fUoG99xJGOb0blIcfWMQiJGRRIZVROSdj8BGplBba9LAi/Ptt1yCt/QeOtUw/1+dh+rlQdxqi4Bs0Wh8+xUqZdPL3bXX15G39KbcXVF+ZmJAK0/crtIb6wMLbGAXIZHLbTZuDjAe8ukUi9PlX7qzHpeKo/HS7/9xQqnzMvYJHbFCp0jJSoH9bk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61ea7c1d-d44a-4070-9011-08d63e847fc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2018 16:26:52.9722
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2579
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During simultaneous running of playback and capture, we
got hit by incorrect value write on common register. This was due
to race condition between 2 streams.
Fixing this by locking the common register access.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
v2: Added 2 helper functions, removed locking in ch enable/disable as they
are separate registers.
 sound/soc/amd/acp-pcm-dma.c | 63 ++++++++++++++++++++++++++++++++++-------=
----
 1 file changed, 48 insertions(+), 15 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 0ac4b5b..5be9c2d 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -121,6 +121,9 @@
 	.periods_max =3D CAPTURE_MAX_NUM_PERIODS,
 };
=20
+/* Lock to protect access to registers */
+static DEFINE_SPINLOCK(lock);
+
 static u32 acp_reg_read(void __iomem *acp_mmio, u32 reg)
 {
 	return readl(acp_mmio + (reg * 4));
@@ -131,6 +134,33 @@ static void acp_reg_write(u32 val, void __iomem *acp_m=
mio, u32 reg)
 	writel(val, acp_mmio + (reg * 4));
 }
=20
+static void acp_reg_write_srbm_targ(void __iomem *acp_mmio,
+				    u32 addr, u32 data)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&lock, flags);
+	acp_reg_write(addr, acp_mmio, mmACP_SRBM_Targ_Idx_Addr);
+	acp_reg_write(data, acp_mmio, mmACP_SRBM_Targ_Idx_Data);
+	spin_unlock_irqrestore(&lock, flags);
+}
+
+static void acp_reg_read_mod_write(void __iomem *acp_mmio, u32 addr,
+				   u32 mask, bool set)
+{
+	u32 val;
+	unsigned long flags;
+
+	spin_lock_irqsave(&lock, flags);
+	val =3D acp_reg_read(acp_mmio, addr);
+	if (set)
+		val |=3D mask;
+	else
+		val &=3D ~mask;
+	acp_reg_write(val, acp_mmio, addr);
+	spin_unlock_irqrestore(&lock, flags);
+}
+
 /*
  * Configure a given dma channel parameters - enable/disable,
  * number of descriptors, priority
@@ -172,15 +202,12 @@ static void config_dma_descriptor_in_sram(void __iome=
m *acp_mmio,
 	sram_offset =3D (descr_idx * sizeof(acp_dma_dscr_transfer_t));
=20
 	/* program the source base address. */
-	acp_reg_write(sram_offset, acp_mmio, mmACP_SRBM_Targ_Idx_Addr);
-	acp_reg_write(descr_info->src,	acp_mmio, mmACP_SRBM_Targ_Idx_Data);
+	acp_reg_write_srbm_targ(acp_mmio, sram_offset, descr_info->src);
 	/* program the destination base address. */
-	acp_reg_write(sram_offset + 4,	acp_mmio, mmACP_SRBM_Targ_Idx_Addr);
-	acp_reg_write(descr_info->dest, acp_mmio, mmACP_SRBM_Targ_Idx_Data);
-
+	acp_reg_write_srbm_targ(acp_mmio, sram_offset + 4, descr_info->dest);
 	/* program the number of bytes to be transferred for this descriptor. */
-	acp_reg_write(sram_offset + 8,	acp_mmio, mmACP_SRBM_Targ_Idx_Addr);
-	acp_reg_write(descr_info->xfer_val, acp_mmio, mmACP_SRBM_Targ_Idx_Data);
+	acp_reg_write_srbm_targ(acp_mmio, sram_offset + 8,
+				descr_info->xfer_val);
 }
=20
 static void pre_config_reset(void __iomem *acp_mmio, u16 ch_num)
@@ -309,8 +336,12 @@ static void acp_pte_config(void __iomem *acp_mmio, str=
uct page *pg,
 	u32 low;
 	u32 high;
 	u32 offset;
+	unsigned long flags;
=20
 	offset	=3D ACP_DAGB_GRP_SRBM_SRAM_BASE_OFFSET + (pte_offset * 8);
+
+	spin_lock_irqsave(&lock, flags);
+
 	for (page_idx =3D 0; page_idx < (num_of_pages); page_idx++) {
 		/* Load the low address of page int ACP SRAM through SRBM */
 		acp_reg_write((offset + (page_idx * 8)),
@@ -333,6 +364,8 @@ static void acp_pte_config(void __iomem *acp_mmio, stru=
ct page *pg,
 		/* Move to next physically contiguos page */
 		pg++;
 	}
+
+	spin_unlock_irqrestore(&lock, flags);
 }
=20
 static void config_acp_dma(void __iomem *acp_mmio,
@@ -870,29 +903,29 @@ static int acp_dma_hw_params(struct snd_pcm_substream=
 *substream,
 		}
 	}
 	if (adata->asic_type =3D=3D CHIP_STONEY) {
-		val =3D acp_reg_read(adata->acp_mmio,
-				   mmACP_I2S_16BIT_RESOLUTION_EN);
 		if (substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK) {
 			switch (rtd->i2s_instance) {
 			case I2S_BT_INSTANCE:
-				val |=3D ACP_I2S_BT_16BIT_RESOLUTION_EN;
+				val =3D ACP_I2S_BT_16BIT_RESOLUTION_EN;
 				break;
 			case I2S_SP_INSTANCE:
 			default:
-				val |=3D ACP_I2S_SP_16BIT_RESOLUTION_EN;
+				val =3D ACP_I2S_SP_16BIT_RESOLUTION_EN;
 			}
 		} else {
 			switch (rtd->i2s_instance) {
 			case I2S_BT_INSTANCE:
-				val |=3D ACP_I2S_BT_16BIT_RESOLUTION_EN;
+				val =3D ACP_I2S_BT_16BIT_RESOLUTION_EN;
 				break;
 			case I2S_SP_INSTANCE:
 			default:
-				val |=3D ACP_I2S_MIC_16BIT_RESOLUTION_EN;
+				val =3D ACP_I2S_MIC_16BIT_RESOLUTION_EN;
 			}
 		}
-		acp_reg_write(val, adata->acp_mmio,
-			      mmACP_I2S_16BIT_RESOLUTION_EN);
+		acp_reg_read_mod_write(adata->acp_mmio,
+				       mmACP_I2S_16BIT_RESOLUTION_EN,
+				       val,
+				       true);
 	}
=20
 	if (substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK) {
--=20
1.9.1

