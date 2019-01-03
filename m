Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80819C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 10:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 351C620815
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 10:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3pZ5Dd6e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730910AbfACKS6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 05:18:58 -0500
Received: from mail-eopbgr750054.outbound.protection.outlook.com ([40.107.75.54]:13561
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726618AbfACKS5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 05:18:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B3ydZSOwKnLWfyweRuaabcb29rCV/jtsPJ9rCHchejI=;
 b=3pZ5Dd6eLBlj6DkUnYiTzrZU5VBLUPzFPAGh65ixYgZRAFUYOiLBrW+EkuhVgu8Ga/alMl/xXZ66zhyzzFw+jiHOmAs6tiYkUMCiGoqlCfuIOx5GQfmrAZLmX07mMrybuUXiSmX0r2D909shV5IR7CUIDzd6N7tcb1yH6PR5/zM=
Received: from MN2PR12MB3088.namprd12.prod.outlook.com (20.178.241.29) by
 MN2PR12MB3069.namprd12.prod.outlook.com (20.178.240.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.7; Thu, 3 Jan 2019 10:18:14 +0000
Received: from MN2PR12MB3088.namprd12.prod.outlook.com
 ([fe80::84f:52f7:9e06:56]) by MN2PR12MB3088.namprd12.prod.outlook.com
 ([fe80::84f:52f7:9e06:56%3]) with mapi id 15.20.1495.005; Thu, 3 Jan 2019
 10:18:13 +0000
From:   "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
CC:     "Agrawal, Akshu" <Akshu.Agrawal@amd.com>,
        "djkurtz@chromium.org" <djkurtz@chromium.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: AMD: Add delay before starting to capture
Thread-Topic: [PATCH] ASoC: AMD: Add delay before starting to capture
Thread-Index: AQHUo02imjPlpUOJIkieuHvQLigEvw==
Date:   Thu, 3 Jan 2019 10:18:13 +0000
Message-ID: <1546510559-17798-1-git-send-email-akshu.agrawal@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BMXPR01CA0022.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:d::32) To MN2PR12MB3088.namprd12.prod.outlook.com
 (2603:10b6:208:c4::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.156.251]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MN2PR12MB3069;20:NVAO38tW6MaLj0cu9L4+bWB06cv1gYmezpSNF9gF2nBdIIYODMMem/NnkhEIP4/LzMYAW9kQw4XWDnxy3TwXFTus9eaBclEPukR1HUTOmpjSwPtErCVtbUqoyUXNmrENPMhfSTPohYDQ29Jzyll6V6SzzhBweDtu1kmpuRM9zxp1NcvoahtHnK3uDpTnEfDkxFP9ZS8PSBTX/jYMWzTQ64BBeQ7wMLEpKJpq4OQaSVm5dbSh6jGh4Pl45Fp4GSA5
x-ms-office365-filtering-correlation-id: 74bdcdab-b233-439b-aeef-08d67164c476
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MN2PR12MB3069;
x-ms-traffictypediagnostic: MN2PR12MB3069:
x-microsoft-antispam-prvs: <MN2PR12MB3069184C5D4AF1A2E094E882F88D0@MN2PR12MB3069.namprd12.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(10201501046)(3231475)(944501520)(52105112)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:MN2PR12MB3069;BCL:0;PCL:0;RULEID:;SRVR:MN2PR12MB3069;
x-forefront-prvs: 0906E83A25
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(136003)(346002)(39860400002)(396003)(189003)(199004)(486006)(25786009)(476003)(2616005)(68736007)(186003)(6346003)(6512007)(26005)(72206003)(5660300001)(39060400002)(54906003)(6436002)(6486002)(478600001)(109986005)(14454004)(97736004)(6506007)(4326008)(102836004)(386003)(99286004)(53936002)(316002)(52116002)(59246006)(2906002)(106356001)(105586002)(36756003)(8936002)(6116002)(305945005)(8676002)(81166006)(71190400001)(81156014)(66066001)(86362001)(7736002)(256004)(1671002)(3846002)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3069;H:MN2PR12MB3088.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wUrvqlDjlzjO84CBqSKQsKN2W9NQW20H2FKJ0SoAxSn+tVvtn51XTcKi90UTNOM4Ng321b7Tf6x6/Gu3bjEGxMonkgXsCIptZGa0Yy6aN8+wjA83garYteXhHUJAAsIiFdok9WYcBHa5C1NPQhklfzeswc7fUQQyX7CobOxr8E3cqCkMr2wSewuPk2Bha0dj5ZXk4ubKmJxsMMuuC8gI97Rx4raApNHsHctabNcKt86Ki3+gDvjvZ447lkI/ttBs6AOr7ptciB/ONEFKy7+7TTtjlZCjSOm+xtAIAh5z4bUyNWfxg+DXgIgdzDyf7tGg
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74bdcdab-b233-439b-aeef-08d67164c476
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2019 10:18:13.8182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3069
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On capture through dmic we observe a glitch at the start of record.
This is because we start capturing even before dmic is ready to send
out data. The glitch seen last for ~20msec.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
---
 sound/soc/amd/acp-da7219-max98357a.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da721=
9-max98357a.c
index a5daad9..72b1cf4 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -44,6 +44,8 @@
=20
 #define CZ_PLAT_CLK 48000000
 #define DUAL_CHANNEL		2
+#define ADAU7002_DELAY_MS  20
+
=20
 static struct snd_soc_jack cz_jack;
 static struct clk *da7219_dai_clk;
@@ -213,6 +215,7 @@ static int cz_dmic0_startup(struct snd_pcm_substream *s=
ubstream)
 	struct snd_soc_pcm_runtime *rtd =3D substream->private_data;
 	struct snd_soc_card *card =3D rtd->card;
 	struct acp_platform_info *machine =3D snd_soc_card_get_drvdata(card);
+	int ret;
=20
 	/*
 	 * On this platform for PCM device we support stereo
@@ -225,7 +228,17 @@ static int cz_dmic0_startup(struct snd_pcm_substream *=
substream)
 				   &constraints_rates);
=20
 	machine->cap_i2s_instance =3D I2S_BT_INSTANCE;
-	return da7219_clk_enable(substream);
+	ret =3D da7219_clk_enable(substream);
+	if (ret)
+		return ret;
+	/*
+	 * On some platforms, it takes ~20 msec for PDM DMICs and ADAU7002
+	 * to settle and start producing proper audio data.
+	 */
+	msleep(ADAU7002_DELAY_MS);
+	/* Delay in frames for 48Khz, 16bit, 2 channel */
+	runtime->delay =3D ADAU7002_DELAY_MS * 48;
+	return 0;
 }
=20
 static int cz_dmic1_startup(struct snd_pcm_substream *substream)
@@ -234,6 +247,7 @@ static int cz_dmic1_startup(struct snd_pcm_substream *s=
ubstream)
 	struct snd_soc_pcm_runtime *rtd =3D substream->private_data;
 	struct snd_soc_card *card =3D rtd->card;
 	struct acp_platform_info *machine =3D snd_soc_card_get_drvdata(card);
+	int ret;
=20
 	/*
 	 * On this platform for PCM device we support stereo
@@ -247,7 +261,17 @@ static int cz_dmic1_startup(struct snd_pcm_substream *=
substream)
=20
 	machine->cap_i2s_instance =3D I2S_SP_INSTANCE;
 	machine->capture_channel =3D CAP_CHANNEL0;
-	return da7219_clk_enable(substream);
+	ret =3D da7219_clk_enable(substream);
+	if (ret)
+		return ret;
+	/*
+	 * On some platforms, it takes ~20 msec for PDM DMICs and ADAU7002
+	 * to settle and start producing proper audio data.
+	 */
+	msleep(ADAU7002_DELAY_MS);
+	/* Delay in frames for 48Khz, 16bit, 2 channel */
+	runtime->delay =3D ADAU7002_DELAY_MS * 48;
+	return 0;
 }
=20
 static void cz_dmic_shutdown(struct snd_pcm_substream *substream)
--=20
1.9.1

