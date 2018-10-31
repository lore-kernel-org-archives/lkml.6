Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D59C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 21:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 775DD2054F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 21:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="sImR5I5a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 775DD2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726001AbeKAGYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 02:24:03 -0400
Received: from mail-eopbgr740044.outbound.protection.outlook.com ([40.107.74.44]:32704
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725755AbeKAGYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 02:24:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jWXv4v/lsKqCR8s47n1envOrwjv0lObi2yhVk3ABEfU=;
 b=sImR5I5a/WbbqH30b4bj/qlE7+Eq6Y+IY29fLh2k/GnETeEc8yJwIXXWEOABl3svszJ6Dw+WkpRaPPZmbbLSHoqPcq6XXs9oQ+L1XX3Tduj4sr2MFFfbcFkP4DEP+YwSUjN0mDMLpwBBOmbaOIKx9/ueWOKRBPizejJTHKLdRr8=
Received: from BL0PR12MB2355.namprd12.prod.outlook.com (52.132.10.161) by
 BL0PR12MB2545.namprd12.prod.outlook.com (52.132.11.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.26; Wed, 31 Oct 2018 21:24:11 +0000
Received: from BL0PR12MB2355.namprd12.prod.outlook.com
 ([fe80::c1c5:b396:dfc6:6c2]) by BL0PR12MB2355.namprd12.prod.outlook.com
 ([fe80::c1c5:b396:dfc6:6c2%5]) with mapi id 15.20.1273.027; Wed, 31 Oct 2018
 21:24:11 +0000
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
Subject: [PATCH v3] ASoC: AMD: Fix race condition between register access
Thread-Topic: [PATCH v3] ASoC: AMD: Fix race condition between register access
Thread-Index: AQHUcWAQzfisXNxXQ02U4HpErY99Zg==
Date:   Wed, 31 Oct 2018 21:24:10 +0000
Message-ID: <1541020930-17337-1-git-send-email-akshu.agrawal@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BM1PR0101CA0011.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:18::21) To BL0PR12MB2355.namprd12.prod.outlook.com
 (2603:10b6:207:4c::33)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.156.251]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR12MB2545;20:cpaoujpmsu4YfhbdtDZb5A9VEuJmWWYqsR1jtvlwNjHc+MNaSgjbH3A8L8wTIsDAJn9awV6+G0YbfQcEGPGWjLvKmVWzJ45dPxqtnwXdHspNv7jVVhZ3j/hEQ5e/PDYgJ1qx3YHJ1oSnaaDODF+vb8pg5mNu8geetLsXjfz5xxLDI4zL0fe9XMWl4xor/Lk3sdP9qaV8Xiq7tgq0L5KYQLu2Wou/y3oWLzqwau2dgx5kECcRiZeJGOCpDXF7KHPh
x-ms-office365-filtering-correlation-id: 859eaf58-f5c3-4136-54e1-08d63f77329d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BL0PR12MB2545;
x-ms-traffictypediagnostic: BL0PR12MB2545:
x-microsoft-antispam-prvs: <BL0PR12MB254514CC25FED84141B462EBF8CD0@BL0PR12MB2545.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231382)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BL0PR12MB2545;BCL:0;PCL:0;RULEID:;SRVR:BL0PR12MB2545;
x-forefront-prvs: 084285FC5C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(396003)(136003)(366004)(199004)(189003)(6116002)(3846002)(86362001)(486006)(5660300001)(256004)(25786009)(5250100002)(14444005)(6506007)(105586002)(476003)(81166006)(6512007)(36756003)(39060400002)(8936002)(2616005)(102836004)(66066001)(478600001)(81156014)(2906002)(2900100001)(68736007)(4326008)(97736004)(54906003)(316002)(6486002)(26005)(386003)(53936002)(59246006)(109986005)(99286004)(52116002)(305945005)(72206003)(8676002)(186003)(106356001)(7736002)(71190400001)(1671002)(71200400001)(14454004)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR12MB2545;H:BL0PR12MB2355.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: aveAiSuKkDri2jc8teXPHDSBUsFo2CGvTVwPsk4yIbuPVcMCrtfWdCoZXg2mAN3QXuOIFC+JqvULZMjZy4bSWVHoZyS3opS6QJXAnDihJrzbU4VG9UYDvSaaawJzUOidsvetcANUxl8DALeeAwAkcJ8hw2RHT/yB1wuCgmnzGV+QVfU+aVn10U63voY1iIU2khhlVXiJ9hd1BKh/ByJ1i5i2rAEiEhJnenmYzyEClD7AmbCDicPt8Qk8L0Gl4e5f8jr4IFT7DoT+4ToH180DyjmAqc7LUGIj0uKPCuEt5sLfH6aO2Ms8Rh/dOHdKulywHF9HDb8Of8QOMFviDIyh1LquxpQgcEWa2esgq1sUFYE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 859eaf58-f5c3-4136-54e1-08d63f77329d
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2018 21:24:10.9990
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2545
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
v3: Modified helper acp_reg_read_mod_write, moved pte locks to helper
 sound/soc/amd/acp-pcm-dma.c | 66 ++++++++++++++++++++++++++++++-----------=
----
 1 file changed, 44 insertions(+), 22 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 0ac4b5b..0d4c2eb 100644
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
@@ -131,6 +134,31 @@ static void acp_reg_write(u32 val, void __iomem *acp_m=
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
+				   u32 mask, u32 value)
+{
+	u32 val;
+	unsigned long flags;
+
+	spin_lock_irqsave(&lock, flags);
+	val =3D acp_reg_read(acp_mmio, addr);
+	val &=3D ~mask;
+	val |=3D (mask & value);
+	acp_reg_write(val, acp_mmio, addr);
+	spin_unlock_irqrestore(&lock, flags);
+}
+
 /*
  * Configure a given dma channel parameters - enable/disable,
  * number of descriptors, priority
@@ -172,15 +200,12 @@ static void config_dma_descriptor_in_sram(void __iome=
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
@@ -311,24 +336,22 @@ static void acp_pte_config(void __iomem *acp_mmio, st=
ruct page *pg,
 	u32 offset;
=20
 	offset	=3D ACP_DAGB_GRP_SRBM_SRAM_BASE_OFFSET + (pte_offset * 8);
+
 	for (page_idx =3D 0; page_idx < (num_of_pages); page_idx++) {
 		/* Load the low address of page int ACP SRAM through SRBM */
-		acp_reg_write((offset + (page_idx * 8)),
-			      acp_mmio, mmACP_SRBM_Targ_Idx_Addr);
 		addr =3D page_to_phys(pg);
=20
 		low =3D lower_32_bits(addr);
 		high =3D upper_32_bits(addr);
=20
-		acp_reg_write(low, acp_mmio, mmACP_SRBM_Targ_Idx_Data);
+		acp_reg_write_srbm_targ(acp_mmio, (offset + (page_idx * 8)),
+					low);
=20
 		/* Load the High address of page int ACP SRAM through SRBM */
-		acp_reg_write((offset + (page_idx * 8) + 4),
-			      acp_mmio, mmACP_SRBM_Targ_Idx_Addr);
-
 		/* page enable in ACP */
 		high |=3D BIT(31);
-		acp_reg_write(high, acp_mmio, mmACP_SRBM_Targ_Idx_Data);
+		acp_reg_write_srbm_targ(acp_mmio, (offset + (page_idx * 8) + 4),
+					high);
=20
 		/* Move to next physically contiguos page */
 		pg++;
@@ -870,29 +893,28 @@ static int acp_dma_hw_params(struct snd_pcm_substream=
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
+				       val, val);
 	}
=20
 	if (substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK) {
--=20
1.9.1

