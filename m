Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6887C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 07:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BC3220664
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 07:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="V8U9f+mG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BC3220664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729367AbeJ2Q0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 12:26:30 -0400
Received: from mail-by2nam03on0074.outbound.protection.outlook.com ([104.47.42.74]:21088
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729155AbeJ2Q0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 12:26:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gRQwAne3u0Eja5eceDm322Ca69E8MSEU/juDS+0oeqw=;
 b=V8U9f+mGr4kC20jy7Y17Q2W0hBQSvjMvJCaLu6m+0QrGHL7R8iVg9zmFXa8i9LGdHzCZpBwOFK3IFIY/OFSxkaVN0/mPfijzxg/wN1TjP8kRmvMMbGwKFd30FT6U4QWbJ9IHwUKEtBeOx75ETFh+Ir7lFnMyzP2xRjkletFmQgk=
Received: from BL0PR12MB2355.namprd12.prod.outlook.com (52.132.10.161) by
 BL0PR12MB2563.namprd12.prod.outlook.com (52.132.27.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.21; Mon, 29 Oct 2018 07:38:58 +0000
Received: from BL0PR12MB2355.namprd12.prod.outlook.com
 ([fe80::c1c5:b396:dfc6:6c2]) by BL0PR12MB2355.namprd12.prod.outlook.com
 ([fe80::c1c5:b396:dfc6:6c2%5]) with mapi id 15.20.1273.027; Mon, 29 Oct 2018
 07:38:58 +0000
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
Subject: [PATCH] ASoC: AMD: Fix race condition between register access
Thread-Topic: [PATCH] ASoC: AMD: Fix race condition between register access
Thread-Index: AQHUb1pzdMz/+70qDECyhKOsI06n2g==
Date:   Mon, 29 Oct 2018 07:38:58 +0000
Message-ID: <1540798621-32627-1-git-send-email-akshu.agrawal@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BM1PR01CA0095.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00::11)
 To BL0PR12MB2355.namprd12.prod.outlook.com (2603:10b6:207:4c::33)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.156.251]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR12MB2563;20:QFPUNVlRdV29qFczlgKuPs2gBeeSwlOOmfRi+P10AfPwS+RuA4ev9ixwsLdkoaUFfrgd9s3vN7TFvVnrsdgWw5dmODV7oi24zR0yPny95DXSjTItz0JnvTvZGVejlWtD+SvTaCoEgfD2o8CtbNhlKFTC5mgiMixtBLphpwaFyS+rmfmuOP9l3E8C+mWPxJ7TRhgOvKd7Wa9o/sBZruvGacymlDnfJ4UvhteI/zXiwwWUtIvUdkaZnBznVuNOArni
x-ms-office365-filtering-correlation-id: 0d039e89-927b-45a1-5f51-08d63d7195da
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BL0PR12MB2563;
x-ms-traffictypediagnostic: BL0PR12MB2563:
x-microsoft-antispam-prvs: <BL0PR12MB2563D687B2D73F6FC37B3015F8F30@BL0PR12MB2563.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BL0PR12MB2563;BCL:0;PCL:0;RULEID:;SRVR:BL0PR12MB2563;
x-forefront-prvs: 084080FC15
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(366004)(39860400002)(376002)(346002)(189003)(199004)(86362001)(106356001)(66066001)(476003)(486006)(105586002)(2616005)(1857600001)(68736007)(2906002)(81166006)(81156014)(316002)(54906003)(5660300001)(478600001)(4326008)(5250100002)(186003)(36756003)(8676002)(1671002)(14444005)(256004)(6436002)(2900100001)(97736004)(386003)(72206003)(6486002)(6506007)(71200400001)(71190400001)(39060400002)(6116002)(26005)(3846002)(6512007)(52116002)(8936002)(102836004)(109986005)(14454004)(7736002)(305945005)(99286004)(53936002)(25786009)(59246006);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR12MB2563;H:BL0PR12MB2355.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: pSe1u0W+fALVO12BRxURNs8JlEj4J3J5c8l3SUWzRhNHLHNq3EQeqmLkufB17bbL0mEmRvIe3ASI7nIsExlUZH0LdP3k3ChhJE9OnEzXv3Wk7Sx7EIHVMijBXRVFKniLuE6xcA4y2RrokpBshS8zCvpidwtK99LE6A6F6yeph54wSABrJqCnOGSo8+cMd8ZFIigNS5goWt7H8tGSXOS83gWNxyK4jHmmDhzFwN47/1fxb0jxYp9TSO/oOeOc5o/MXTYwzDIe4bYR59zKYQ6w8WruRcAupbaVrWciZRN1xZEnper7TcN4UrEGzd3jCTasUxEdHjUdjq32eUyie4ywpj70vMPZZGs2Db2RfmA/dww=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d039e89-927b-45a1-5f51-08d63d7195da
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2018 07:38:58.7188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2563
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
 sound/soc/amd/acp-pcm-dma.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 0ac4b5b..993a7db 100644
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
@@ -168,9 +171,12 @@ static void config_dma_descriptor_in_sram(void __iomem=
 *acp_mmio,
 					  acp_dma_dscr_transfer_t *descr_info)
 {
 	u32 sram_offset;
+	unsigned long flags;
=20
 	sram_offset =3D (descr_idx * sizeof(acp_dma_dscr_transfer_t));
=20
+	spin_lock_irqsave(&lock, flags);
+
 	/* program the source base address. */
 	acp_reg_write(sram_offset, acp_mmio, mmACP_SRBM_Targ_Idx_Addr);
 	acp_reg_write(descr_info->src,	acp_mmio, mmACP_SRBM_Targ_Idx_Data);
@@ -181,6 +187,8 @@ static void config_dma_descriptor_in_sram(void __iomem =
*acp_mmio,
 	/* program the number of bytes to be transferred for this descriptor. */
 	acp_reg_write(sram_offset + 8,	acp_mmio, mmACP_SRBM_Targ_Idx_Addr);
 	acp_reg_write(descr_info->xfer_val, acp_mmio, mmACP_SRBM_Targ_Idx_Data);
+
+	spin_unlock_irqrestore(&lock, flags);
 }
=20
 static void pre_config_reset(void __iomem *acp_mmio, u16 ch_num)
@@ -309,8 +317,12 @@ static void acp_pte_config(void __iomem *acp_mmio, str=
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
@@ -333,6 +345,8 @@ static void acp_pte_config(void __iomem *acp_mmio, stru=
ct page *pg,
 		/* Move to next physically contiguos page */
 		pg++;
 	}
+
+	spin_unlock_irqrestore(&lock, flags);
 }
=20
 static void config_acp_dma(void __iomem *acp_mmio,
@@ -367,6 +381,7 @@ static void acp_dma_cap_channel_enable(void __iomem *ac=
p_mmio,
 				       u16 cap_channel)
 {
 	u32 val, ch_reg, imr_reg, res_reg;
+	unsigned long flags;
=20
 	switch (cap_channel) {
 	case CAP_CHANNEL1:
@@ -381,6 +396,8 @@ static void acp_dma_cap_channel_enable(void __iomem *ac=
p_mmio,
 		imr_reg =3D mmACP_I2SMICSP_IMR0;
 		break;
 	}
+	spin_lock_irqsave(&lock, flags);
+
 	val =3D acp_reg_read(acp_mmio,
 			   mmACP_I2S_16BIT_RESOLUTION_EN);
 	if (val & ACP_I2S_MIC_16BIT_RESOLUTION_EN) {
@@ -393,12 +410,15 @@ static void acp_dma_cap_channel_enable(void __iomem *=
acp_mmio,
 	val &=3D ~ACP_I2SMICSP_IMR1__I2SMICSP_RXFOM_MASK;
 	acp_reg_write(val, acp_mmio, imr_reg);
 	acp_reg_write(0x1, acp_mmio, ch_reg);
+
+	spin_unlock_irqrestore(&lock, flags);
 }
=20
 static void acp_dma_cap_channel_disable(void __iomem *acp_mmio,
 					u16 cap_channel)
 {
 	u32 val, ch_reg, imr_reg;
+	unsigned long flags;
=20
 	switch (cap_channel) {
 	case CAP_CHANNEL1:
@@ -411,11 +431,15 @@ static void acp_dma_cap_channel_disable(void __iomem =
*acp_mmio,
 		ch_reg =3D mmACP_I2SMICSP_RER0;
 		break;
 	}
+	spin_lock_irqsave(&lock, flags);
+
 	val =3D acp_reg_read(acp_mmio, imr_reg);
 	val |=3D ACP_I2SMICSP_IMR1__I2SMICSP_RXDAM_MASK;
 	val |=3D ACP_I2SMICSP_IMR1__I2SMICSP_RXFOM_MASK;
 	acp_reg_write(val, acp_mmio, imr_reg);
 	acp_reg_write(0x0, acp_mmio, ch_reg);
+
+	spin_unlock_irqrestore(&lock, flags);
 }
=20
 /* Start a given DMA channel transfer */
@@ -847,6 +871,7 @@ static int acp_dma_hw_params(struct snd_pcm_substream *=
substream,
 	int status;
 	uint64_t size;
 	u32 val =3D 0;
+	unsigned long flags;
 	struct page *pg;
 	struct snd_pcm_runtime *runtime;
 	struct audio_substream_data *rtd;
@@ -870,6 +895,8 @@ static int acp_dma_hw_params(struct snd_pcm_substream *=
substream,
 		}
 	}
 	if (adata->asic_type =3D=3D CHIP_STONEY) {
+		spin_lock_irqsave(&lock, flags);
+
 		val =3D acp_reg_read(adata->acp_mmio,
 				   mmACP_I2S_16BIT_RESOLUTION_EN);
 		if (substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK) {
@@ -893,6 +920,8 @@ static int acp_dma_hw_params(struct snd_pcm_substream *=
substream,
 		}
 		acp_reg_write(val, adata->acp_mmio,
 			      mmACP_I2S_16BIT_RESOLUTION_EN);
+
+		spin_unlock_irqrestore(&lock, flags);
 	}
=20
 	if (substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK) {
--=20
1.9.1

