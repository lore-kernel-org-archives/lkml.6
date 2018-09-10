Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 130BCC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9191B20870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:25:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bkFqr2Pt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9191B20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbeIJWUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 18:20:54 -0400
Received: from mail-bn3nam01on0063.outbound.protection.outlook.com ([104.47.33.63]:61567
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727742AbeIJWUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 18:20:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UdWVUPrPGk3R5nTrnzK1SdzKbvJRAKBiVKTWBABl0BE=;
 b=bkFqr2PtX6xY8nPaL5oxKOFpBkv+Uxib+teyjmCsKesI43ZEGwzg0CHCXF4NFvvZTrFM9uYPcYi9CV8/s357donPB3nCFkewNxgx3Mz1fX2Qf4wT2Gp2NLjm5vYj09DDQBgyaotNC95nM+ls5aXNIf1OVAtDvGFBsiEwDETsgXw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com; 
Received: from amd-chromium.amd.com (165.204.156.251) by
 MW2PR12MB2361.namprd12.prod.outlook.com (2603:10b6:907:7::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.15; Mon, 10 Sep 2018 17:25:30 +0000
From:   Akshu Agrawal <akshu.agrawal@amd.com>
Cc:     akshu.agrawal@amd.com, djkurtz@chromium.org,
        Alexander.Deucher@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        alsa-devel@alsa-project.org (moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM...), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] ASoC: AMD: Fix simultaneous playback and capture on different channel
Date:   Mon, 10 Sep 2018 22:50:27 +0530
Message-Id: <1536600049-4073-1-git-send-email-akshu.agrawal@amd.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.156.251]
X-ClientProxiedBy: PN1PR0101CA0048.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:c::34) To MW2PR12MB2361.namprd12.prod.outlook.com
 (2603:10b6:907:7::32)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76314b4e-b279-4e49-6d49-08d617426ea3
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MW2PR12MB2361;
X-Microsoft-Exchange-Diagnostics: 1;MW2PR12MB2361;3:oThu4V1jUp/VxBMQfpQ2O4G2oyPHTUWeW6ky+p9p6fxnmb7v6u6ssVYz1F4UXB/flgj7XpdFwmcFMLihb4nCl94zVB1sg3gz6kwt06/8ku8c4dWM/8+rm4sSk5DZTX7S9ParsvTbYa+P11Kh7p3spAT7KMNeGned75iu11zu33B8tgB0gM83pwitXE9ZsiwCP6sO6UT6jTxu5J1SZOi+Z98yVevkH2kIOKZih6wQ016as/d9/U1auOil0MCTPqKx;25:4t/bnyXQ6u4hLiFfEjA5Dw6uWdxXRKaLOZAXeLMMnKeW2Xxt0zcEKKIVV8oTqx1u/ahOWpL7dpFIaJ+oE8/HMMCJj62N36MN8J3AYHPiFWUfg2Qs2geQy30MuwXr/QJpBMfmpPPcany9ghhSWkMZ+ktu8cRgfvIlCYEbvHAxxbXc9fQt5dHAUEp4v8mDctAz6jF7ZFKVPZPWt5d5Pn5u53M79ntOygxfzW6QKxoqg5Tt1Tqqoa0t7wLXQXwJSbEzT2bjLZdGc7C/PCMQM3V3MiEvB0uCbHYchW5nnrz9k7FXXAuvMy1ScxJ5P6p7ftM3/zi611/MO6RXu99QfjPWBA==;31:obv6AFE0fjrfKiow1HAg9DCswGNCo1CI/DfBJYrPkFHL/a1KRc1hvmG8bmuZS+OJqOgYWGrvmiBlCnfaoWWoC4EyLNHpZpTrMkwgvswpry/4klU5iaZ+08aF/ckROuHDg9eTaJyZ7greeGynnNn8vsjX1fMJjwpgdpVuWQ1GivrRLe3I9i3hsTCUxk/rYVrf7q5w537VsBTVNWwaRW+x/+cTMVK5ICd5V3TwzgUfs04=
X-MS-TrafficTypeDiagnostic: MW2PR12MB2361:
X-Microsoft-Exchange-Diagnostics: 1;MW2PR12MB2361;20:+jkb9HJ24RmWmnF6+PfTSS5XQNRfSUBoRJQnj0JR6Mt1UosALnpWlJaZOSwhXr8KX+UAk+7JJ8E7OIFCXMy+ZNnkka4bvfgxoDKJDhd/pAhaqKiJSrt2PVvmtBUNawC1o/xn/l4MBUwbrM92pLABCtzQu/JeS+4YLNTsM8XHFU0N/Z535MwMOtbWObaafBMRForrkLXTLqSFdCoeDxDDWYNLZ71dFZJTfIyM1+yGEURffdxWBfJIz/ek35NGeAneDOT2EprDNMVjfJ0kElimZO8kzDSw18OCQ3kL/9YB6cEN15b99IdpWr9NMlOsyob1xCOP02oGVL7rOpQCHutNvW7lbYR2odmIRZMc4v6+9LrZToFkIwUwnHmr9ueuwTtOz5QNH7B3fj4z+3jIct/Eg6JXmVuWCi18UEw8+MEZUeWHtuzL1ZDVxSBWwKwmp7MbUmcHwlAfCxE/+ru/MjnAStvMcQjRZRKJTfb0XsYa8hhCGyhB5G4C1cRDTLEVOCVw;4:vi2oxWZPOdAp2nb+8zFGymP49OQJAAVPPsXVrEtP5lvYEKFQInXzaiyI1CVf4Ydon2Dnk3vzpC40gth9/LOK93uf848uJUXuiSpDrjvJuvKPCFc7Xc1px599fruq5ekO+YLKKGboVbMFkxQFttjEWPGEkA7J7kvX1Tqz/hoi8V6GBYWMMWYbS+mEY2OO78FCCmFGgQQQawtwKgtJC6EYlsPSlkjzgcrOxBcF0kqLAOv3DyKAIJbBCNrjWi78/i1Arw0fb9N0jKmq8wh2WFuHIzzcXvNjbHRkemCxxcLZkar61pc2OjT81C8FSVcC/GAF
X-Microsoft-Antispam-PRVS: <MW2PR12MB2361FC450086505B58EE80FBF8050@MW2PR12MB2361.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699050);SRVR:MW2PR12MB2361;BCL:0;PCL:0;RULEID:;SRVR:MW2PR12MB2361;
X-Forefront-PRVS: 07915F544A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(396003)(346002)(376002)(136003)(39860400002)(199004)(189003)(478600001)(72206003)(7416002)(316002)(16586007)(25786009)(305945005)(386003)(81156014)(81166006)(8676002)(39060400002)(105586002)(106356001)(4326008)(2906002)(53416004)(6666003)(1671002)(44832011)(8936002)(50226002)(47776003)(66066001)(5660300001)(54906003)(7736002)(68736007)(97736004)(109986005)(6486002)(2616005)(956004)(476003)(36756003)(26005)(6116002)(3846002)(48376002)(7696005)(86362001)(50466002)(575784001)(52116002)(51416003)(486006)(16526019)(53936002)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:MW2PR12MB2361;H:amd-chromium.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MW2PR12MB2361;23:r8a4LF9Zdbt1G15yIDG+BF//sJobTVMCcI8pOK2EK?=
 =?us-ascii?Q?PaKHAHs5c+DymkGOJWFuDy/a10wHbk8Cl/f6ZA25jwBfVj6LniLJdW+Y18i7?=
 =?us-ascii?Q?uBP7QEKmP1j0ieGCA23fENS6OfDzERdeI61pG91w7NDGxWjta3gn9VfoLqGv?=
 =?us-ascii?Q?Fx3iwUcvdjG2nEATX7D0mwmxGDLwSOVU3N3STA8JLEiPbv2O/jpXHJfM4i0i?=
 =?us-ascii?Q?RIX04BjjH8lLSXbZnAxo8c+TN9wXRBPmbRpAD1q5OoAyryeQDtXZUe5wmyyG?=
 =?us-ascii?Q?DMM5B901fESZBcbdIUJEdatlnI2Tilrm8KiWVc0xFZiUgloj/M2Ls1fc8OGH?=
 =?us-ascii?Q?/psDwqJVR64scbAX+gzmnzfpZCvxdz/6HgUsP1+Vzp2bVYy/8xJ52xLhKuzo?=
 =?us-ascii?Q?p97OtOI6hIfl8gv0va2GKylnJs8j0hwUvPGlf8W5awEkHaAJPSEh1CEAj9pb?=
 =?us-ascii?Q?20Mq/ehdpZ9nCqFT0AuK9oNBsqx2CyVVwnGj57/um3jMMualoD9m9QDWY/ed?=
 =?us-ascii?Q?uwiYH/NvkCN3xDQAXVwjQnjbNAkiw/JtKDsGhjdLXNbnOckq6sp/kFGR1cp9?=
 =?us-ascii?Q?GTrIZiqbABYdygvnFB+A7CDPFeaGgY6jjmh7wINCeETXpELUdJcqhR7I00il?=
 =?us-ascii?Q?uaG36JVNLELEjwyGbCFaWwMYf0lFcpcej9IIIGJRUXbkMK/ly8v9JLSMLNBH?=
 =?us-ascii?Q?oerySWjqOmyYJCqnmhfp+a7B2QeP6oy1BVdl7yTc17FmR5xmDcbEmSHe1VDc?=
 =?us-ascii?Q?p2x4yHXMkxuEL1jec9+IrMzpe+Ugd8TTZ3ap7mCfk10nUkQtcxo3j0/bYwx5?=
 =?us-ascii?Q?XXXJjfdk4EqMZDWMsgSJ7bLTY32lVF/tuXv4seCBtc+n+LbWerv/qhRNH8P5?=
 =?us-ascii?Q?Ipxizy6WIzkhLLjbDRDIkt3NxDd9eWsgTNkLTbBltq3TMFmauyNfYhRpeO1b?=
 =?us-ascii?Q?WL6bHLaibVBh6xIGd68qrRC+Ylxw5k51JTFn9pNMyh9O0iHMbkwEiK/3+GBy?=
 =?us-ascii?Q?p186KDGcTRLC9oMlG486yKDuZbXCNo3MtIHhxplEvntKaTULgGSJ5zRLPQxE?=
 =?us-ascii?Q?L8veUxP//R2Yd1MXArYARoUGIvN4hKe3UTtvN9dGO3u//dqIBAH6DItgNGE9?=
 =?us-ascii?Q?5JSe72pLKtsDaU/kR4bzFl8j1x0TTonDj4JqYaF6iK9aZaoF6JKmAw9zOxbz?=
 =?us-ascii?Q?mWSniH8f/aF5IN6x0N2Uv/gCyLFUlyba06EiokgxpmNBF0697kIfvfOQRqHV?=
 =?us-ascii?Q?uI5qoYwdL12OTi0m3hnic9krKiHBQX9inLmrubR?=
X-Microsoft-Antispam-Message-Info: d5/A7Yi3yV0BRHn2SX5PThBNv+JsiloXkQl070ujG8u6syS4tj1BiR+Ncndxw/MsS/jwTFQZs23q6K2UAN/DkHZeP1yvO/UGrSSvpUHmn+GiVO486QVCkL9h+3bY2HMejzFCk39Cr4PpAb9puPK+4sY5mjeG8EA5bT6uanLicKIXUnDrU+oizPcC9X6PY+DkI96ea2uRHQyI3/OTnPCpvMB+TPsgkB6XZzMCSYBL6O5BLONDrve5FINftsczve1uov3QOjUtfz3vZmXYcN4JKLAG5XbLs/KbgEgquZULkCBHL6WsSVHBMasdmuZV6rqLJbagNbO7r/5/tTVtMAfluRvrB+1VnrnkbVe1ypj5EJU=
X-Microsoft-Exchange-Diagnostics: 1;MW2PR12MB2361;6:jXGwbtDnViP0O92s7nDKl4wTEZ1WrD5XfDGtrX/fziGM2WKYSmOrcNG2FA9OrnZnpnJoz56lX+js8WnQIsSzsfOApwy7moohc7MD/vhYJepprgnne1YT7JFxd9zaxn7Q2geTAKf8f0YCNyT+yUNGk7/NsYJ/GovD9xGO4lcV6ZL9BLDCOCNOdLkc+6kRmvnQ7j1tASOJ+NlO95x8Q9xLxwToSwfW4eCadNMuZ1NXihbjyDqYGBRelHshbbqf8zp7RCxeOeVDrk9k0TC8/Qo4+Ew73P2MBJwgRBIIlR2OlUFTwO9tdmMF2zAZnmxGXMMl+NQyhZ1pp6d0KSP5ZRHTcDxXzFCTFzh+8VgsILrT0JnbTO2QN82n88cfqmXOZJn2JbzxF+5Rx55XJgjxYrEGgvPBprjVuW0Bs0x+wtXbIzbGmpAZop7cjINns6c8X0EVbuZNci2ZvQKtdyjUn+v2nw==;5:i0NJcb8dfYTtRejg64IlHzI3fHLsT/1x6+gc+sVLwV1rYwTiMF3+kRvoxEb2W3Uea5ZXe69EmdIxUOTz8xY/pPQhBehGnoFEOt4gkjeDaie23R+BgSjHw+QDMo53SqBvDBH+kU1aBeLogBZ7PMUMbdNqPF6402bqJWm1SPrKyXc=;7:jV/QlQawD6oaGKhG3oQcHXpz1dUdwb3zJxQPh3bwiLyBtDGGLXYrjkjQpJqSX3p8thP4nzRTdb9bYIl8GPAvRWaUDx1uQizvFZ79P8Re7/yMYR0Q7pe6lHjQviHt6XNLEgXxlj77WPS//3a/Gh//T7xgQqJSylL0KUZmQRCWPk2thHvJab/vieFh9vMGRj+10Mq/bs/ap0ib8S+o/YGNS2VnuewJpV/AUuyEKwUHkuO6O1flDwDviTlDWtzkqU7o
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MW2PR12MB2361;20:MVuPs6dHMDpgg3utwdZ1ADiAo39gITLh57XbbcVkbfvU0mTEeWh4wxVdxAdYS2ZgN6lKjvrnKMiIRC5AUJpiIWrooDSArDMjAPQMdsrkrMPbF2CnqAyvZzrGrOUy0hEJY1KoPAipr8ZN1zSlcI3ZnYaC626FVL8KKpKxLL3YoHp1zAlwOS3RglYQOWQdezpW+XsnoHNG1GGYUshoG3PzarbQUgOu7K0vyzOcY4MeldjGkU7istvp55ryt+s148n6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2018 17:25:30.9178 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76314b4e-b279-4e49-6d49-08d617426ea3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2361
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If capture and playback are started on different channel (I2S/BT)
there is a possibilty that channel information passed from machine driver
is overwritten before the configuration is done in dma driver.
Example:
113.597588: cz_max_startup: ---playback sets BT channel
113.597694: cz_dmic1_startup: ---capture sets I2S channel
113.597979: acp_dma_hw_params: ---configures capture for I2S channel
113.598114: acp_dma_hw_params: ---configures playback for I2S channel

This is fixed by having 2 separate instance for playback and capture.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>

---
 sound/soc/amd/acp-da7219-max98357a.c | 40 +++++++++++++++++++++++++++++-------
 sound/soc/amd/acp-pcm-dma.c          |  8 ++++++--
 sound/soc/amd/acp.h                  |  3 ++-
 3 files changed, 41 insertions(+), 10 deletions(-)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index 55d7f61..0d97d00 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -133,7 +133,7 @@ static void da7219_clk_disable(void)
 	.mask = 0,
 };
 
-static int cz_da7219_startup(struct snd_pcm_substream *substream)
+static int cz_da7219_play_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
@@ -150,7 +150,28 @@ static int cz_da7219_startup(struct snd_pcm_substream *substream)
 	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
 				   &constraints_rates);
 
-	machine->i2s_instance = I2S_SP_INSTANCE;
+	machine->play_i2s_instance = I2S_SP_INSTANCE;
+	return da7219_clk_enable(substream);
+}
+
+static int cz_da7219_cap_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_card *card = rtd->card;
+	struct acp_platform_info *machine = snd_soc_card_get_drvdata(card);
+
+	/*
+	 * On this platform for PCM device we support stereo
+	 */
+
+	runtime->hw.channels_max = DUAL_CHANNEL;
+	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
+				   &constraints_channels);
+	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
+				   &constraints_rates);
+
+	machine->cap_i2s_instance = I2S_SP_INSTANCE;
 	machine->capture_channel = CAP_CHANNEL1;
 	return da7219_clk_enable(substream);
 }
@@ -177,7 +198,7 @@ static int cz_max_startup(struct snd_pcm_substream *substream)
 	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
 				   &constraints_rates);
 
-	machine->i2s_instance = I2S_BT_INSTANCE;
+	machine->play_i2s_instance = I2S_BT_INSTANCE;
 	return da7219_clk_enable(substream);
 }
 
@@ -203,7 +224,7 @@ static int cz_dmic0_startup(struct snd_pcm_substream *substream)
 	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
 				   &constraints_rates);
 
-	machine->i2s_instance = I2S_BT_INSTANCE;
+	machine->cap_i2s_instance = I2S_BT_INSTANCE;
 	return da7219_clk_enable(substream);
 }
 
@@ -224,7 +245,7 @@ static int cz_dmic1_startup(struct snd_pcm_substream *substream)
 	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
 				   &constraints_rates);
 
-	machine->i2s_instance = I2S_SP_INSTANCE;
+	machine->cap_i2s_instance = I2S_SP_INSTANCE;
 	machine->capture_channel = CAP_CHANNEL0;
 	return da7219_clk_enable(substream);
 }
@@ -234,8 +255,13 @@ static void cz_dmic_shutdown(struct snd_pcm_substream *substream)
 	da7219_clk_disable();
 }
 
+static const struct snd_soc_ops cz_da7219_play_ops = {
+	.startup = cz_da7219_play_startup,
+	.shutdown = cz_da7219_shutdown,
+};
+
 static const struct snd_soc_ops cz_da7219_cap_ops = {
-	.startup = cz_da7219_startup,
+	.startup = cz_da7219_cap_startup,
 	.shutdown = cz_da7219_shutdown,
 };
 
@@ -266,7 +292,7 @@ static void cz_dmic_shutdown(struct snd_pcm_substream *substream)
 				| SND_SOC_DAIFMT_CBM_CFM,
 		.init = cz_da7219_init,
 		.dpcm_playback = 1,
-		.ops = &cz_da7219_cap_ops,
+		.ops = &cz_da7219_play_ops,
 	},
 	{
 		.name = "amd-da7219-cap",
diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index b43f0a1..b0e245c 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -862,8 +862,12 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 
 	if (pinfo) {
-		rtd->i2s_instance = pinfo->i2s_instance;
-		rtd->capture_channel = pinfo->capture_channel;
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+			rtd->i2s_instance = pinfo->play_i2s_instance;
+		} else {
+			rtd->i2s_instance = pinfo->cap_i2s_instance;
+			rtd->capture_channel = pinfo->capture_channel;
+		}
 	}
 	if (adata->asic_type == CHIP_STONEY) {
 		val = acp_reg_read(adata->acp_mmio,
diff --git a/sound/soc/amd/acp.h b/sound/soc/amd/acp.h
index be3963e..dbbb1a8 100644
--- a/sound/soc/amd/acp.h
+++ b/sound/soc/amd/acp.h
@@ -158,7 +158,8 @@ struct audio_drv_data {
  * and dma driver
  */
 struct acp_platform_info {
-	u16 i2s_instance;
+	u16 play_i2s_instance;
+	u16 cap_i2s_instance;
 	u16 capture_channel;
 };
 
-- 
1.9.1

