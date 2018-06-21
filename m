Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E4E2C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 04:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 334C12075E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 04:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qxwaQKVV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 334C12075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932534AbeFUE7U (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 00:59:20 -0400
Received: from mail-eopbgr690062.outbound.protection.outlook.com ([40.107.69.62]:2899
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932231AbeFUE7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 00:59:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/i16SP9hAsGD0Anr9EhMsrsaVgu/aBWxXaunr/LWm5s=;
 b=qxwaQKVV8ZrJZtWqskakwm8mTTZo1VQtT6ZWWyo/eieH0bvBuKf9unt0vWxT19UfIllGfx2YlbxRozHj/f6rV5ytU/GcZtuecPp9CHGswif8o3LTs90xg7Dp20+ukHiP3igbhuEGGwVCp5ol1SqZgamiChnYfRLTATC29Q3hnS0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com; 
Received: from akshu-HP-EliteBook-745-G2.amd.com (202.56.249.162) by
 DM5PR12MB2360.namprd12.prod.outlook.com (2603:10b6:4:b4::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.20; Thu, 21 Jun 2018 04:58:59 +0000
From:   Akshu Agrawal <akshu.agrawal@amd.com>
Cc:     djkurtz@chromium.org, akshu.agrawal@amd.com,
        Alexander.Deucher@amd.com,
        "Agrawal, Akshu" <Akshu.Agrawal@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        alsa-devel@alsa-project.org (moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM...), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] ASoC: AMD: Change codec to channel link as per hardware redesign
Date:   Thu, 21 Jun 2018 12:58:16 +0800
Message-Id: <1529557112-5525-1-git-send-email-akshu.agrawal@amd.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [202.56.249.162]
X-ClientProxiedBy: MAXPR0101CA0027.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:d::13) To DM5PR12MB2360.namprd12.prod.outlook.com
 (2603:10b6:4:b4::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f36fa7b0-05e5-49f6-fa46-08d5d733bb87
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB2360;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2360;3:8h83g2NcsA8GebBBHUXudw5clTrDYzLE6S/P3QtblEEnmzy9FMH5qKa4nbgsI5vzfyJbf6ZnnCYMg3ueCHwZpoOmM2sJJUvxonar8K76IBxcIJdycI3qEMk0CvP0ios2xfbrkxs5cXZjIReTSQ03QJExzTRUKcfZEG+AViWbKvLbTK5fZQ6dJReLjNrtb8yMlXmolFNw2vyxNACXv5AQFzr2w+qrTyoZwY8GS3Owt69HQLnCMa64mODm3s+slTBp;25:/mcJEJKaAhiRfajIjoK0A0DwlU0fzAy6aRbNwNHGd6D3dPT5QA0Vh+L/rWJZMBEvZXSxrKzE1LvNSGx1GxZS06yOnS7xE2SDZHUSodx4Zpgh64SwGGb2HJynjY2ssQyrNZhJgzDD9FtFkyUWsqP2mRvbQgK3/nCMwX+keFYfKeNMkPMqTjabMGYdWp6nBSgWrR9Ak45D4L42B4eOop9ssxit5D0KBZRrtawbuYqQfsiL6IgcUMwuVzhH/wLiM5sSX14eCvAuUEPDfShhK6vmqUCRzi8LnpxrCSBS+muuB3yjJ4ZXVQ+UtCa4JkcsbomLUVVAWjQtNxVfFYe3Fsvqgw==;31:4uv1AXTM7qUoyNDk5hl15IsHPv/GtYAjtTgGaAMjG1MSnOBeKWMSrBiFe+KkkNVK41eSZ1Y6VnZWsiNJE70Y6Mtik7vF+yGd6SA8r7iYxEED1blUtBvENUBFjHzNZFc9I5WZaRbl2BgKH1ltJlI8qVbirUM/f0+SCTeedpvtG2VHeKyVpgiyeviaOCWdtzSgjWuHQDQ6dc/lb/oDCa1W6IIvrbAL16mXGrK8HRfcI24=
X-MS-TrafficTypeDiagnostic: DM5PR12MB2360:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2360;20:048JvHjoP7DmaE8pudHpwOE6MKPUYb/8JPlnS33zVp2Nu3dNEh6NNjSH03w3xOuK3jKPspDh/EQwTUFE9AfipX8gtc888BdXJMBgE3KWNUZBSVziJmjC6thU8yd5wSEFw1LXUnntzlGkCcuHBUghyr95084Sr4V2QFo5QSiUCoQtptPqQmm6neGEvFGQ5DGNMvJuTIsTuBtwWl1p3QwlzILpujSa2l43U+bFGONh8GMaot1VK9spQz53fkAEpeCKVVBKJOqnte2w+cpWd0vNFNEbGLTTiZSyDBKxtKLDSURT/ew8LyQ5Vjb8lPwQZymCFWUEZpGix6Onyl8biTqP1xNi3VQEEF+T4K2mHayHneoCSWMtArB83H2QLNXtu6WVi11rFD/04Gm2zO08deALSy3lf8/tI4Jgi9AWr47DtycEvQIlkCNazQUq+JDo/+JiAZO2DtExBBtw4Ixvz+Uauj2I6SJjUclsfqmsOFXgBlfHZwvdYTZ4/lFomjfLGoaT;4:8IUzq6mmhJ4KDyLA/CCi1qpvLjn7Spv2pbVQOdrvsADtMjmrKuY08JwtHhj+ywtECg5D4kqISq0Slvt7fQSeI/TXte1i5omw5IqvveLeNVI7wwX+0FER68eZkyoWtkx7KNJcPs6esnRg3zk32WCK4xqnuetbk8YuBq519TVXvjp4JT3ZXnZJVtBtx51FSyisF1AnjLEPGZ6Tcg4vG66sUa8qGRvCk7lRWa7PQbWsYNahrKRwNq8hDSXrMNUOIoj8Z7yl6gff73u18+zZY9ZzyCSKG/KdBHPOSoJL7X5Fl5+kepH+rXBWTBNkZOxwQoKc
X-Microsoft-Antispam-PRVS: <DM5PR12MB236009499358B789D9959130F8760@DM5PR12MB2360.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DM5PR12MB2360;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB2360;
X-Forefront-PRVS: 07106EF9B9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(39860400002)(396003)(376002)(366004)(346002)(189003)(199004)(81156014)(1671002)(2906002)(81166006)(8676002)(8936002)(48376002)(50466002)(6116002)(3846002)(6666003)(47776003)(316002)(54906003)(36756003)(16586007)(109986005)(66066001)(5660300001)(39060400002)(97736004)(53936002)(4326008)(106356001)(2616005)(476003)(51416003)(7696005)(52116002)(956004)(105586002)(16526019)(86362001)(478600001)(68736007)(186003)(486006)(50226002)(26005)(386003)(72206003)(305945005)(44832011)(7736002)(25786009)(53416004)(6486002)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2360;H:akshu-HP-EliteBook-745-G2.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR12MB2360;23:0choFSebLZzt3tE13S1ofCyh5tC1AvVuGuGeb4Gds?=
 =?us-ascii?Q?au3Zg1ufvp48/v296huPgA3S/J/aVKPXAzZ+qRim9ySdbjDtKa7Iq9RMIHDY?=
 =?us-ascii?Q?TYDZUcjfEqRFT6qEewjCPZej0R3tQuWcxOVLKsEdF0MwRyy/GYCBar47EGUG?=
 =?us-ascii?Q?thS8GLjFijNq4g1DQlyTCPgpDXZ9xnUIUWJ1iy7M8oYCRuEWxkVLF2XPkYzN?=
 =?us-ascii?Q?Y8R/ye9GcaadOIRm0tycmoZTwll4qEaAYqHuuj5dJEKHNz3X82Pn0eQJoyHg?=
 =?us-ascii?Q?au3MZKHI+uawDK+m76RKIO1hN4y40bF28KBT9ksy6juGqsIWgAXuvBRdfwak?=
 =?us-ascii?Q?JmqtTpI7WX5o+BGpAzQD5napKV3jDZd5jIBrf4vcvtsPfLKDqqg0/BE8yQ7N?=
 =?us-ascii?Q?kup4lG5FAfwiMZwlXF7D3rHyKHOEwc4HqQkuz9o458slGGL5y2oVFuFErRQk?=
 =?us-ascii?Q?6TuBuB1nCXtCuyqGOnGzttEycYnTMwhCUOmvx88BS6GpbDYGy8DAnRXLG8fp?=
 =?us-ascii?Q?0huWp4IowBY/6mi20o6zQI+HY5Kw7FhDMI35B2DRSJtzssfLb3of+H5iD15g?=
 =?us-ascii?Q?Uw9o2j2FWvmxXb5v0JyhuXjYdyIt5cK8stqUvP+jOu/rhZI0PwCNu6nSVbPw?=
 =?us-ascii?Q?acBG+FpIlDU20oICsN4RuZXte9b0nBp/PQV8zJcn51NG+WuKbXr413llxydo?=
 =?us-ascii?Q?Ij2QX28ZtZu8jB58m5BYmm/ZrCCpBsykOJ9/zfgOH+aTV+Jhcr9BLo7wireO?=
 =?us-ascii?Q?RMzWZxIXr9DYb0iQXRhhIvl8gAle6lLZOI+TmnhWVkTqJH3tUdXiWmlI1p76?=
 =?us-ascii?Q?N4FLsZnTkmnR5a0lyuynDKUyUNSV7wjdIMIhvbOj6ipgvAq8dHoHB0tVoabI?=
 =?us-ascii?Q?Jisu84VqCkGIiho8QZXbK1kjTrY2FEEoneQL6jju37VFD0Q/LSlz2M0l2E0+?=
 =?us-ascii?Q?Mt4EPJoZc7wYcXbRckmHJH82DOsb2eFLmFJ3ptbMFh8toIETPghkUPVwk7Un?=
 =?us-ascii?Q?E/IRwcZgG0a9VLYij709bD6OC2tK173x77Ovav5n9zJWhOV8ANGEHK6FdoMR?=
 =?us-ascii?Q?rjFBzvU67hByDCRc0L7NcLzhOnVzliGd0tqkkRfZRnfNCAaj2OtVWdsRsrbd?=
 =?us-ascii?Q?2paRgwCdiAq5cYwH2m4PTkK//4ITkYcq/6fbdTxeiOjnX1FMu0pSy2OuViMT?=
 =?us-ascii?Q?e/vjS/q+pQ4Byi2tHWDZWZ2PmSRjyHlCcpCWqRAAKJIvaUit9ddKrRdhT0+/?=
 =?us-ascii?Q?gQ4j3rX6jsa1HJwiDs=3D?=
X-Microsoft-Antispam-Message-Info: OFLwyMisjjRvBZ74gxjgYtJOVw1ZKB8NPXzS4BwEz8CiLT/jhBC+adzqLavu/jsdLwYwNSbyF6XP6RUEO9BGrN7HLjiNJxm+Cf7DDFvrSWHlA2ntgNdbwUdZT2Gi+4VDxk9J8IR94F1AWdMOOxLbJDsJxcXxKxgYulEDUSbFHvBMsPQ40k7eabMa4ye9WdTEV5aTjH73bIKN1Fi8bE5IJcAfaMjhbg9BiUdSKrBZBEiac5dDxWQTfULKQfSADoCKTR5t4ak8f0wXiuK+0ZfAAoHmFlf9FoSsdiDSuRUfbgdhw+MauGloiGsAIhjDmrn/Ag14D4iqWYHyUmBZhSLY1Q==
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2360;6:yxrc1Ox93e5h4vnDP2Y/x/ITAp5dVs3o57GsIiTTtu3zRKkFEgoOPuYc8r06PpWYM0V1XWzhywKsbW4jwjM8qMQGyWQ3dkRhES8h/d2/PGJUoKdqwroOUnLlcvLo1ip8Tp3Uya70nlBTe6IRsdUFFin/oU8Eq2rK8Q8Fbym7RsrI/Iet73o/3ZE6R9p5KVdsrxpfSwcB0zC3icMtXVOH4W0w0fkBIioks5iMbXgILD0xj+QcFLW9pQVcdm1/Wjl4JjJ2w/VjRdcD+s2hnL2AFAN/gJO7oerlH+yqzPZrTW2yhNhqxCBoOWnETkDF/bzFloYG6LPwdt1xXQAAY9zos7Z6RuHNWfZJuGbRAWTiXF/C9O/ifQytxKTIxFUzwU792onl9PDz24sLqqzDHQo7IH6U0G1leHO1iqte2bpaLYuMgPXcPt0+Fi2Kt7knoIihqhpMTt8cyYoMs10YQHpB1Q==;5:cTHRzRWH1P0ZG1lPb8EsXQzI/4q60huwEKEK63rZpliK8VueWMlQVBugfNaglL3Z5H+KJfCdDDyl1CVo8J0cf+PShPAtxL0Kfwcdl90PUO4RWD1cuVO5LvFoMZ+T56731aMPo+lTabPafK43UrpSZgUcqwqmxA6ap509eyJ8TsY=;24:HBRdiWrQzvw4gDbI0iPrpPb1fOPwFvHNb3Lf0YOdkE2alY42tHNA26VQ6WtNGuwMGPq+7vgIH96ak4KsUhzYMrvvj1G14jVE2bPWMayghIg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2360;7:UEtgvQ+jL1HYFcEVy9VbkLUBgw4Ai7iqRoy9JSH2TAYRpV4lN3LQzk24wcKz+7Ysz8jP2kFKIoNSxv72LzFmU0kZw80RXDNVsRPJbDoZncukw5/4psATzfamQOGf4QqDoopdeXs2lfxnfa+MVniXSy2euakeC5mrzGyM4dBmC9jKyA9PDxqQprqxClwvDWB9tG0tdwUk0gt8mT0n7tUJXtPkwNfmXZOC0KA8rceMjNejnNxqVy/kDNDpSgGK8Pad;20:y55+ceMdlx7C8aefNJ+EAiDcZTIIeCyT+7vUHggQ8FyF3fwuQnex0ceUVQI2tJvJebfsKvNf7CbxLLd2QywxcFprQfsCfZGbPFWIhK6c2ZiMwGTRxg53fma8i1W6GvBy6g8xYUC0b0o1WvKW5afM0+O9zzK2Zc30z0It6o/r08xH8FUSiag1bmApCiaXWvskqtRVUSiaUhFUxTc6K8e2J4iiVEx4e6gA2tPgGDcIlr+HMNdOamvh1SwWpDrz5NPO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2018 04:58:59.0940 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f36fa7b0-05e5-49f6-fa46-08d5d733bb87
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2360
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>

This is a correction to match acutal hardware configuration.
The hardware configuration looks like:
I2S_BT -> SPK(Max) + DMIC(Adau)
I2S_SP -> DA7219 Headset

No actual products have been shipped with previous configuration.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
 sound/soc/amd/acp-da7219-max98357a.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index ccddc66..566bd26 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -148,7 +148,7 @@ static int cz_da7219_startup(struct snd_pcm_substream *substream)
 	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
 				   &constraints_rates);
 
-	machine->i2s_instance = I2S_BT_INSTANCE;
+	machine->i2s_instance = I2S_SP_INSTANCE;
 	return da7219_clk_enable(substream);
 }
 
@@ -163,7 +163,7 @@ static int cz_max_startup(struct snd_pcm_substream *substream)
 	struct snd_soc_card *card = rtd->card;
 	struct acp_platform_info *machine = snd_soc_card_get_drvdata(card);
 
-	machine->i2s_instance = I2S_SP_INSTANCE;
+	machine->i2s_instance = I2S_BT_INSTANCE;
 	return da7219_clk_enable(substream);
 }
 
@@ -178,7 +178,7 @@ static int cz_dmic_startup(struct snd_pcm_substream *substream)
 	struct snd_soc_card *card = rtd->card;
 	struct acp_platform_info *machine = snd_soc_card_get_drvdata(card);
 
-	machine->i2s_instance = I2S_SP_INSTANCE;
+	machine->i2s_instance = I2S_BT_INSTANCE;
 	return da7219_clk_enable(substream);
 }
 
@@ -204,16 +204,27 @@ static void cz_dmic_shutdown(struct snd_pcm_substream *substream)
 
 static struct snd_soc_dai_link cz_dai_7219_98357[] = {
 	{
-		.name = "amd-da7219-play-cap",
-		.stream_name = "Playback and Capture",
+		.name = "amd-da7219-play",
+		.stream_name = "Playback",
 		.platform_name = "acp_audio_dma.0.auto",
-		.cpu_dai_name = "designware-i2s.3.auto",
+		.cpu_dai_name = "designware-i2s.1.auto",
 		.codec_dai_name = "da7219-hifi",
 		.codec_name = "i2c-DLGS7219:00",
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
 				| SND_SOC_DAIFMT_CBM_CFM,
 		.init = cz_da7219_init,
 		.dpcm_playback = 1,
+		.ops = &cz_da7219_cap_ops,
+	},
+	{
+		.name = "amd-da7219-cap",
+		.stream_name = "Capture",
+		.platform_name = "acp_audio_dma.0.auto",
+		.cpu_dai_name = "designware-i2s.2.auto",
+		.codec_dai_name = "da7219-hifi",
+		.codec_name = "i2c-DLGS7219:00",
+		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
+				| SND_SOC_DAIFMT_CBM_CFM,
 		.dpcm_capture = 1,
 		.ops = &cz_da7219_cap_ops,
 	},
@@ -221,7 +232,7 @@ static void cz_dmic_shutdown(struct snd_pcm_substream *substream)
 		.name = "amd-max98357-play",
 		.stream_name = "HiFi Playback",
 		.platform_name = "acp_audio_dma.0.auto",
-		.cpu_dai_name = "designware-i2s.1.auto",
+		.cpu_dai_name = "designware-i2s.3.auto",
 		.codec_dai_name = "HiFi",
 		.codec_name = "MX98357A:00",
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
@@ -233,7 +244,7 @@ static void cz_dmic_shutdown(struct snd_pcm_substream *substream)
 		.name = "dmic",
 		.stream_name = "DMIC Capture",
 		.platform_name = "acp_audio_dma.0.auto",
-		.cpu_dai_name = "designware-i2s.2.auto",
+		.cpu_dai_name = "designware-i2s.3.auto",
 		.codec_dai_name = "adau7002-hifi",
 		.codec_name = "ADAU7002:00",
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
-- 
1.9.1

