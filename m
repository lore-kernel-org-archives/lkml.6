Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A13D6C04EB9
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 03:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53F502146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 03:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=maximintegrated.onmicrosoft.com header.i=@maximintegrated.onmicrosoft.com header.b="EO3PFs3q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53F502146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=maximintegrated.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbeK3O3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 09:29:00 -0500
Received: from mail-eopbgr750098.outbound.protection.outlook.com ([40.107.75.98]:23584
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726161AbeK3O3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 09:29:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=maximintegrated.onmicrosoft.com; s=selector1-maximintegrated-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gokYEVVceRK0FobmiA1mudF2+sNeggSQ+uPksyDFbDU=;
 b=EO3PFs3qW+5Z1a9cDzJ60EcITzkmF/rwYzvFfbfbDYqNzaSHkE9BVeUok9d4rwoWwVW1BK44I7y/uSoNaH8KTToImWRnxWcVKgz3KKgWGIu0mXbUZ/cPGZqPb/3fWpjOjg8MhF4pfLnF9zmFWLQFyQzOAVYB4C0QT6YiTW5eE1A=
Received: from DM6PR11MB3131.namprd11.prod.outlook.com (20.177.219.96) by
 DM6PR11MB2906.namprd11.prod.outlook.com (20.177.216.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.16; Fri, 30 Nov 2018 03:21:09 +0000
Received: from DM6PR11MB3131.namprd11.prod.outlook.com
 ([fe80::2dfb:d623:d7cb:cbe1]) by DM6PR11MB3131.namprd11.prod.outlook.com
 ([fe80::2dfb:d623:d7cb:cbe1%3]) with mapi id 15.20.1361.018; Fri, 30 Nov 2018
 03:21:09 +0000
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
Subject: [V3] ASoC: max98373: Added max98373_reset for stable amp reset
Thread-Topic: [V3] ASoC: max98373: Added max98373_reset for stable amp reset
Thread-Index: AQHUiFu81b05P9Zx+kS2bptH0DgleA==
Date:   Fri, 30 Nov 2018 03:21:09 +0000
Message-ID: <20181130031831.7813-1-ryans.lee@maximintegrated.com>
Accept-Language: en-US, ko-KR
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.56.38.100]
x-clientproxiedby: YQXPR0101CA0001.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::14) To DM6PR11MB3131.namprd11.prod.outlook.com
 (2603:10b6:5:6d::32)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=RyanS.Lee@maximintegrated.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR11MB2906;6:UyKwhCLrJqvrzxE3cA608+17WcqZSc1hv/j59gMCHP3rcu6EiKQLJrSrIA9oBI/BLhdI36axChLQ/eRMh0OrvJjIxhnfJwBRvMH1UHA784CUPuTfF2PO/tptRS+cD7FOltiyb17gQaxoBEvKVysgaZuyUg7eipu7Irnss8BmxOKRXAM6uS45ZYhwROEnpR4mqHwyVatJ4jJvHbLF9OZo/uhJVjWi4KzOwPJqmU9c0u4SbfpvRrkakHdn+wJo0/zI8QFuq90g1d1MnQQ/WchVsT2gYrM76XkDTVhAcTnxpUz5s1o+9/GUgZRpMiJXvCy/psSY5ySRS31a4PZ++RE1aQ8cKe5OwRt+5U2jT9xN6iiLUKcEdbe1iJY2HxZQLlc0ZlS0qZgrCAqLraLo9yzuaJnazaT0xz2TrJF9GHHqI2nEAz7RK3nDvE/EamAAjoOrV3f4nE0x6ydg84PK6BuC5w==;5:kcnqbxRnmLPNIXe2qoA0GKBcpBIXUVSoR9By12DwyvNpxf5CaCRECCZXQOAo33rOs9ivHE+SGr1eWJi5gK23g5oXsZhKZuw4FfQ00ESZlqRFDWPsnwAGvvxF+UHkDcVIAUk6DA1kr5sb7soghN6CVy8QCDNGuZJdZ/HInBgYgRs=;7:Hrvx6tyDfXrUfKZkbpWXK8fpA56SzcOHNjORv7wlTjOOISeYKqCnUOdbOj4HaUD9OurDlpXkyo5UcWdBf/MH09bmBPcKT5okCYSzFv7+8bV3BR69QRwnQCR9xXUZ8G9a+Ld0iKwm8efEl7+7iy3gQQ==
x-ms-office365-filtering-correlation-id: 576a52f0-b643-4d83-58db-08d65672defc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM6PR11MB2906;
x-ms-traffictypediagnostic: DM6PR11MB2906:
x-microsoft-antispam-prvs: <DM6PR11MB2906529CB67389FED24969E6E7D30@DM6PR11MB2906.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231453)(999002)(944501410)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DM6PR11MB2906;BCL:0;PCL:0;RULEID:;SRVR:DM6PR11MB2906;
x-forefront-prvs: 087223B4DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(136003)(39860400002)(376002)(396003)(199004)(189003)(81166006)(105586002)(81156014)(2906002)(14444005)(7736002)(386003)(305945005)(6506007)(6436002)(5660300001)(7416002)(86362001)(52116002)(99286004)(2201001)(71200400001)(6512007)(39060400002)(53936002)(476003)(4326008)(97736004)(256004)(2616005)(36756003)(2501003)(486006)(110136005)(8936002)(478600001)(316002)(14454004)(68736007)(1076002)(66066001)(72206003)(6116002)(8676002)(102836004)(106356001)(26005)(186003)(25786009)(71190400001)(6486002)(3846002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR11MB2906;H:DM6PR11MB3131.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: maximintegrated.com does not
 designate permitted sender hosts)
x-microsoft-antispam-message-info: Z9rZ7UQkrfzqDMyeXoCGS+EbrCeQB/2dkAawu83xz7rWQJ5M0FXnOfMlFGsXqe9K2W91Jehe101zhSeusH83FMUzv04MEBlrP2OGTv6/9ZcVECakShoemtlaSB1xwCb/5IjU/aULXVULsGcnnJzAqUAgrQHRIxkAqKLI2Tb1hFKWlgMSFK0tE9TqXZaUxS0Yrz3f2IToLkBGmoXlZTxymj1VqY1hqgBVGFdL4g05VQZJ6a61zqhlYCEtHeu4St0eIgR3AYPN5nC24hZnYoMrbXZcIpxAp0jCJJwux3uvNCAu9+TjDZnQim4tbiBO2fhLxswlBCgZtF7qx/Ws9HNpdLapS+7d/ClVfpaCXUeyM6M=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: maximintegrated.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 576a52f0-b643-4d83-58db-08d65672defc
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2018 03:21:09.1219
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd909df-ea69-4788-a554-f24b7854ad03
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2906
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch added max98373_reset function to avoid amp software reset failur=
e and code duplication.
Reset verification step has been added for stable amp reset and it repeats =
verification maximum 3 times when it is failed.
Chip revision ID is available when the amp is in the idle state which means=
 software reset is completed well.
Additional 10ms delay was added for every retrial and maximum 30ms delay ca=
n be applied.

Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
---

Changes since v2:
- Added commit message.
Changes since v1:
- Removed unusual repeat for amp software reset and verification.
- Amp software reset will be performed once and it repeats verification max=
imum 3 times if it is failed.
- Wait 10ms before every verification trial. Maximum 30ms delay will be app=
lied to wait AMP idle state.
Changes:
- Created max98373_reset function to minimize code duplication.
- Changed regmap_write to regmap_update_bits. Other bits except LSB need to=
 be masked.
- Added reset verification step to make sure software reset is completed we=
ll. Software reset is done in 10ms in normal case.
- Revision ID is available when the amp is in the idle state which means so=
ftware reset is completed.
- Software reset will be performed maximum 3 times to avoid amp reset failu=
re. Generally it is done in the first trial.
- sleep time after software reset is increased + 30ms for every retrial. Ma=
ximum possible msleep time is 100 ms (initial 10 ms + 30 ms * 3 times).

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

