Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B73CC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 03:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 553A22081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 03:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=maximintegrated.onmicrosoft.com header.i=@maximintegrated.onmicrosoft.com header.b="wc7CmXfB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 553A22081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=maximintegrated.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbeK1OUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 09:20:22 -0500
Received: from mail-eopbgr800112.outbound.protection.outlook.com ([40.107.80.112]:33024
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726847AbeK1OUW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 09:20:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=maximintegrated.onmicrosoft.com; s=selector1-maximintegrated-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2TtQX2X3L06Hw/2ZPG+boevegpk+Wd7SSOL3/3goqU=;
 b=wc7CmXfBbGF5X/zZihaw8/Y4W3JydNXRzWHhRRYR1APCaXUSkXKf9EyiLX6hRGZah+upQypyMf8HKC83XklZkTEBjQ+HhWoL0YuQMAevCKUsKnDxC2lJeit/vGYZRqAAXEdvPD+iUc6dNV35NSZv8kFSjHE0QvS6nG73pbrOPuk=
Received: from DM6PR11MB3131.namprd11.prod.outlook.com (20.177.219.96) by
 DM6PR11MB2860.namprd11.prod.outlook.com (20.176.100.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.16; Wed, 28 Nov 2018 03:20:17 +0000
Received: from DM6PR11MB3131.namprd11.prod.outlook.com
 ([fe80::2dfb:d623:d7cb:cbe1]) by DM6PR11MB3131.namprd11.prod.outlook.com
 ([fe80::2dfb:d623:d7cb:cbe1%3]) with mapi id 15.20.1361.018; Wed, 28 Nov 2018
 03:20:17 +0000
From:   Ryan Lee <RyanS.Lee@maximintegrated.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ryan Lee <RyanS.Lee@maximintegrated.com>,
        Grant Grundler <grundler@chromium.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Benson Leung <bleung@chromium.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "ryan.lee.maxim@gmail.com" <ryan.lee.maxim@gmail.com>
Subject: [PATCH V2] ASoC: max98373: Added max98373_reset for stable amp reset
Thread-Topic: [PATCH V2] ASoC: max98373: Added max98373_reset for stable amp
 reset
Thread-Index: AQHUhslIRSLmSIj6XkCUBOoX3Wedtw==
Date:   Wed, 28 Nov 2018 03:20:16 +0000
Message-ID: <20181128031926.7157-1-ryans.lee@maximintegrated.com>
Accept-Language: en-US, ko-KR
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.56.38.197]
x-clientproxiedby: DM5PR07CA0040.namprd07.prod.outlook.com
 (2603:10b6:3:16::26) To DM6PR11MB3131.namprd11.prod.outlook.com
 (2603:10b6:5:6d::32)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=RyanS.Lee@maximintegrated.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR11MB2860;6:8wgs7K5EkCpm5EHt8jqWdKyZCZyGyAIPas9K4X+RMLvpMRyld5sWxzsBFVVDILeZC6EMmiyM9ZXQ2VynySAbeGq308rUXGam+48Yi6EKC4+LzDT7CpHevnrkswwP6Ym4YOnbcxyguoEuapiu7Du5BC7LOKbs3WdB8oqjvQD17EelbglSs8+kvRfD/qq/3VbcHkK/Uecdkyy7LXTIddH1gv5Y8t4k9kT1UCSjKNVq0DmVq7kh4QrRH9wBnXUbxyI8WZucDhPMCWu/yUq9hHi5GLqFKXZhP2vPX387cJv0fS+caSiwirsYQ3A4ceg1BJeQBLA/NfxojXC8lTYtw/U0We0DjFtVpMANUive2M8DmWfArutPmdGEigsD5G0Rd6/eF7iQ2qHpXg7GPcrm4vJ59JzUU3iDKk8L+UZJhDR4J8/qpLEudNZnjWlW026pC1KCqby5HyYrDb8H/FGh4KGVGQ==;5:X68bDSd6392mhBiiG2QcjpkuRkFyJU42n3cjj+6y+oU8Ddyc+mBUZq0qWQRFFFU5ZsNU0kHM5I9Bkxf45qMDPwFkT3Qepys/DXUVAWF4ty/iHUUaS6QVwEhwBQLSzFj+R+Z9ZHPF8SB90tYk9SzgJugVsIAKWZFkrOnlKR0yTXk=;7:E0FBAbP8wRrnS6tsI1HYRJzf/IuA4vjYAFbiFRdHuTrdMG0PPKnW7OZA+KW3ECxqVsXV0dr/te5R5B1y0Q5yz9Ys9XHh48f5wAWLTQFggMLmTNmOVwm73PYmp/NOH3hIfwYKyeA0zP8a4ez7lWUaHw==
x-ms-office365-filtering-correlation-id: cf3bdd5d-e0fb-4cbd-9ed7-08d654e06b2a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR11MB2860;
x-ms-traffictypediagnostic: DM6PR11MB2860:
x-microsoft-antispam-prvs: <DM6PR11MB2860BA5FF6EDA15FEE166E85E7D10@DM6PR11MB2860.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231443)(944501410)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DM6PR11MB2860;BCL:0;PCL:0;RULEID:;SRVR:DM6PR11MB2860;
x-forefront-prvs: 0870212862
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(39860400002)(366004)(376002)(346002)(189003)(199004)(36756003)(8676002)(106356001)(3846002)(81166006)(81156014)(105586002)(4326008)(6116002)(478600001)(52116002)(7416002)(66066001)(2906002)(14454004)(8936002)(39060400002)(97736004)(68736007)(1076002)(6486002)(2501003)(53936002)(316002)(6436002)(7736002)(6512007)(110136005)(305945005)(72206003)(2201001)(86362001)(102836004)(186003)(5660300001)(26005)(99286004)(2616005)(386003)(476003)(6506007)(14444005)(25786009)(256004)(486006)(71190400001)(71200400001)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR11MB2860;H:DM6PR11MB3131.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: maximintegrated.com does not
 designate permitted sender hosts)
x-microsoft-antispam-message-info: mMU5+4QkqUPz7xEEWyMebDVh9hXgOOv6URlfO5vetyi12fozv/VVKUvtWxKeTatSvrUsS8nQVjBRKpPvS0E2qImvLn7eqYIBvGdFeFaMs5NNPq9ezCzueWjdeC0PioekesdUoFDUU6xJT6mqNAdu8p21mU2B2LGLgbHvZh32ITd2P5IDfzSVEO8nnfMdhSFv9zxxoVS51vtBUdVp84dJNAzkk5MjEz7wSBWPHr23MQt2Z15bDwLRTFp7+ig6la8mswgiOe5fMC1gwQFWYnAG83K3jBgIzNhm4/5EdZyT4eB/BC4Ee41+oEAQ0CaB4rIsAi07uHVlNwDtUJz9mPQ/qeWDIoJbFa/PXCugtnVC6kg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: maximintegrated.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf3bdd5d-e0fb-4cbd-9ed7-08d654e06b2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2018 03:20:17.0147
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd909df-ea69-4788-a554-f24b7854ad03
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2860
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
---
Changes since v1 : Removed unusual repeat for amp software reset and verifi=
cation.
                   Amp software reset will be performed once and it repeats=
 verification maximum 3 times if it is failed.
                   Wait 10ms before every verification trial. Maximum 30ms =
delay will be applied to wait AMP idle state.

Changes : Created max98373_reset function to minimize code duplication.
          Changed regmap_write to regmap_update_bits. Other bits except LSB=
 need to be masked.
          Added reset verification step to make sure software reset is comp=
leted well. Software reset is done in 10ms in normal case.
          Revision ID is available when the amp is in the idle state which =
means software reset is completed.
          Software reset will be performed maximum 3 times to avoid amp res=
et failure. Generally it is done in the first trial.
          sleep time after software reset is increased + 30ms for every ret=
rial. Maximum possible msleep time is 100 ms (initial 10 ms + 30 ms * 3 tim=
es).

 sound/soc/codecs/max98373.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/max98373.c b/sound/soc/codecs/max98373.c
index a09d013..9c8616a 100644
--- a/sound/soc/codecs/max98373.c
+++ b/sound/soc/codecs/max98373.c
@@ -724,14 +724,39 @@ static struct snd_soc_dai_driver max98373_dai[] =3D {
 	}
 };
=20
+static void max98373_reset(struct max98373_priv *max98373, struct device *=
dev)
+{
+	int ret, reg, count;
+
+	/* Software Reset */
+	ret =3D regmap_update_bits(max98373->regmap,
+		MAX98373_R2000_SW_RESET,
+		MAX98373_SOFT_RESET,
+		MAX98373_SOFT_RESET);
+	if (ret)
+		dev_err(dev, "Reset command failed. (ret:%d)\n", ret);
+
+	count =3D 0;
+	while (count < 3) {
+		usleep_range(10000, 11000);
+		/* Software Reset Verification */
+		ret =3D regmap_read(max98373->regmap,
+			MAX98373_R21FF_REV_ID, &reg);
+		if (!ret) {
+			dev_info(dev, "Reset completed (retry:%d)\n", count);
+			return;
+		}
+		count++;
+	}
+	dev_err(dev, "Reset failed. (ret:%d)\n", ret);
+}
+
 static int max98373_probe(struct snd_soc_component *component)
 {
 	struct max98373_priv *max98373 =3D snd_soc_component_get_drvdata(componen=
t);
=20
 	/* Software Reset */
-	regmap_write(max98373->regmap,
-		MAX98373_R2000_SW_RESET, MAX98373_SOFT_RESET);
-	usleep_range(10000, 11000);
+	max98373_reset(max98373, component->dev);
=20
 	/* IV default slot configuration */
 	regmap_write(max98373->regmap,
@@ -818,9 +843,7 @@ static int max98373_resume(struct device *dev)
 {
 	struct max98373_priv *max98373 =3D dev_get_drvdata(dev);
=20
-	regmap_write(max98373->regmap,
-		MAX98373_R2000_SW_RESET, MAX98373_SOFT_RESET);
-	usleep_range(10000, 11000);
+	max98373_reset(max98373, dev);
 	regcache_cache_only(max98373->regmap, false);
 	regcache_sync(max98373->regmap);
 	return 0;
--=20
2.7.4

