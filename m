Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1179DC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 18:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3A6520855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 18:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=maximintegrated.onmicrosoft.com header.i=@maximintegrated.onmicrosoft.com header.b="vla/8Wz4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3A6520855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=maximintegrated.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbeK0Flt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 00:41:49 -0500
Received: from mail-eopbgr700117.outbound.protection.outlook.com ([40.107.70.117]:10816
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725723AbeK0Fls (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 00:41:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=maximintegrated.onmicrosoft.com; s=selector1-maximintegrated-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kcTxlycKuFCDkeWr/kHq8PVrZ7PCK5g577uR2bzeJ1Q=;
 b=vla/8Wz4Y3VD5235SeoK7ejf9Sn5IuQ19Nb7aUhehldc+Dia/NWD+dzBgy6U2ihcvn8SfeWZL5SZ6WzNBDymapwzgq6Vd37Bmhro3VWp1U++OM9ZbU1xhBOWHj2s9SQd3ULhVaQEnp6Rsawh9/kpiEALAjfnSCgYd0l3al3gl0o=
Received: from BL0PR11MB3122.namprd11.prod.outlook.com (20.177.205.160) by
 BL0PR11MB2945.namprd11.prod.outlook.com (20.177.147.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Mon, 26 Nov 2018 18:46:05 +0000
Received: from BL0PR11MB3122.namprd11.prod.outlook.com
 ([fe80::3945:4f07:26d5:7fe0]) by BL0PR11MB3122.namprd11.prod.outlook.com
 ([fe80::3945:4f07:26d5:7fe0%3]) with mapi id 15.20.1294.045; Mon, 26 Nov 2018
 18:46:05 +0000
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
Subject: [PATCH] ASoC: max98373: Added max98373_reset for stable amp reset
Thread-Topic: [PATCH] ASoC: max98373: Added max98373_reset for stable amp
 reset
Thread-Index: AQHUhbhJ96XSCK8z8UOo2bPiHw7S7g==
Date:   Mon, 26 Nov 2018 18:46:05 +0000
Message-ID: <20181126183942.2631-1-ryans.lee@maximintegrated.com>
Accept-Language: en-US, ko-KR
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.56.38.102]
x-clientproxiedby: BL0PR0102CA0068.prod.exchangelabs.com
 (2603:10b6:208:25::45) To BL0PR11MB3122.namprd11.prod.outlook.com
 (2603:10b6:208:7e::32)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=RyanS.Lee@maximintegrated.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR11MB2945;6:kR0uEMgeqYBBXZLzfFjYqpo8zkkUa34MIrG6LtbUnP5lhx4yxWCKs53ReUGoeiKgzRyZw+9X8Y7PW2KRnZ9CYDyJaodHQkt8q2rKAHnzx610hraFUmYnXsXzSNqfsxJfj5G3IV01zGHz4q+cptTzuD67winTIOA0oOZ+pue/bjrezH25TArKvJLRV5ZzqM8GJi1v5XZfJ00KiQp76nE5qC9z7tTGkBR6Adx4Q7FvyBD9LVbk1ktI6McTAE0PKGlaD0a7ueB+w30Bq15zwwG/7Jb98e5q4y7e6WR3Rs1UKkayIFuaxD9gZuk6hEXMkKMnskO9SmfP3avGmfiEUj4qBZ1+WeoKmEMPPZAqmyrIGdOI2jonmRf3XmlLH0OrvEp9hlsHet1QL6ns5bxJKVbXxYFZ+PvS3bU77XcDl+O4Dv+xny0w5GTNBau7jHQNQRhBNVMXIVAwftAKRxjfVtIyNg==;5:esMUCSKd/E1lcD3HG9R8h4hMGYuBPyoXS6hTBm1t/5xSDQfDhQWbX8YhTn34alGrfwjrju6HjyBRvYqw+zD7vpHW+aMNqV4C5yA8rkNi9vZg0aW+QdjSejHY9jR5AzQF0JCLtvx4PskiTfwXA1uo+Retf6aC7QWbFFHWzut+5W4=;7:vICp0ldX7DkJAtKAowRqZHKc0tDovg4vNxdSjgQTrNAuI3+RmCFcrqV+PmUb71rRTtRWaf0N6SHww+eMHqHbleqygbmw0MKQb5/aMbVws5IbtRGFZJevNpHvWZpaEldbMA9ri8Rs+461SvwVq718Gw==
x-ms-office365-filtering-correlation-id: 8a4a8598-4525-4ef8-9350-08d653cf6ba9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BL0PR11MB2945;
x-ms-traffictypediagnostic: BL0PR11MB2945:
x-microsoft-antispam-prvs: <BL0PR11MB294535D949A8E5962C401893E7D70@BL0PR11MB2945.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(108721460000369);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231443)(944501410)(52105112)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BL0PR11MB2945;BCL:0;PCL:0;RULEID:;SRVR:BL0PR11MB2945;
x-forefront-prvs: 086831DFB4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(346002)(396003)(136003)(366004)(189003)(199004)(105586002)(72206003)(36756003)(5660300001)(106356001)(7736002)(2906002)(68736007)(1857600001)(26005)(14454004)(14444005)(256004)(478600001)(305945005)(3846002)(6116002)(186003)(86362001)(2501003)(2201001)(97736004)(39060400002)(66066001)(25786009)(316002)(81156014)(102836004)(99286004)(53936002)(81166006)(386003)(6506007)(110136005)(6512007)(8936002)(2616005)(476003)(1076002)(6436002)(486006)(52116002)(8676002)(71190400001)(71200400001)(6486002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR11MB2945;H:BL0PR11MB3122.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: maximintegrated.com does not
 designate permitted sender hosts)
x-microsoft-antispam-message-info: 7MCP1TnQQfkAFvX8ssXnghOIEWF6WjGQF/f9Nf2PSF2U7DVic5ltgQQBnayULIuixuo2eMtrz72XNPBOVB4CT5wW2t1gocVjX8B70TOYGNBgn5kH7HqDIR2xTkr203tq2FP4+Yd5GLCNWSgqMBPwU+DlYNDE935bt76mHe01iqUE6CyTpWeJTgbqZZPdVuw97IE0fI4FPLt8uqr9dhjIUZZmBykKCkFwq5ZfncwDxQVbMDGfZ3uVrtJO3WcCuExC+NLPBrfCld5vhmqK1F18nwgBZiLbEAvy2E4sMPbXHT3Lcme8XuvqOgaQ8GGtvoybXNk/6n6TtAP1CwSZnu9FRqHcIVxbBnrG5WomDUJLR+o=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: maximintegrated.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a4a8598-4525-4ef8-9350-08d653cf6ba9
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2018 18:46:05.5569
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd909df-ea69-4788-a554-f24b7854ad03
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB2945
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
---
 Changes : Created max98373_reset function to minimize code duplication.
           Changed regmap_write to regmap_update_bits. Other bits except LS=
B need to be masked.
           Added reset verification step to make sure software reset is com=
pleted well. Software reset is done in 10ms in normal case.
           Revision ID is available when the amp is in the idle state which=
 means software reset is completed.
           Software reset will be performed maximum 3 times to avoid amp re=
set failure. Generally it is done in the first trial.
           sleep time after software reset is increased + 30ms for every re=
trial. Maximum possible msleep time is 100 ms (initial 10 ms + 30 ms * 3 ti=
mes).

 sound/soc/codecs/max98373.c | 41 +++++++++++++++++++++++++++++++++++------
 1 file changed, 35 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/max98373.c b/sound/soc/codecs/max98373.c
index a09d013..55af7f02 100644
--- a/sound/soc/codecs/max98373.c
+++ b/sound/soc/codecs/max98373.c
@@ -724,14 +724,45 @@ static struct snd_soc_dai_driver max98373_dai[] =3D {
 	}
 };
=20
+static void max98373_reset(struct max98373_priv *max98373, struct device *=
dev)
+{
+	int ret, reg, count, delay;
+
+	count =3D 0;
+	while (true) {
+		/* Software Reset */
+		ret =3D regmap_update_bits(max98373->regmap,
+			MAX98373_R2000_SW_RESET,
+			MAX98373_SOFT_RESET,
+			MAX98373_SOFT_RESET);
+		if (ret)
+			dev_err(dev, "Reset command failed. (ret:%d)\n", ret);
+
+		delay =3D 10000 + (count * 30000);
+		usleep_range(delay, delay + 1000);
+
+		/* Software Reset Verification */
+		ret =3D regmap_read(max98373->regmap,
+			MAX98373_R21FF_REV_ID, &reg);
+		if (!ret) {
+			dev_info(dev, "Reset completed (retry:%d)\n", count);
+			break;
+		}
+
+		if (++count > 3)	{
+			dev_err(dev, "Reset failed. (ret:%d)\n", ret);
+			break;
+		}
+		usleep_range(10000, 11000);
+	}
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
@@ -818,9 +849,7 @@ static int max98373_resume(struct device *dev)
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

