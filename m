Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD35DC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EFF82077B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ZQ6cHIYA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EFF82077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbeIBRrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:47:51 -0400
Received: from mail-eopbgr680109.outbound.protection.outlook.com ([40.107.68.109]:62112
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728338AbeIBRUw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:20:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHBt9x17oBRrvbN47Z5BjhAaRNnswYEzHWR5o7Qxiio=;
 b=ZQ6cHIYA9I96BCUwF+EhNeXEPL5lG+MDAUM35k96jkM3wr8oqvK/ST9KfFDjlNIQ0jSIZJ8+51jgdpQyd6v+Tdr+8Vlar2M0qGc8JdhHudoZjzKKS/xLEMWhwJHtWo0iVVP5iGUKywaXTUQaeU0CawrznjR/Fpf3vGzju+41rNY=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0741.namprd21.prod.outlook.com (10.173.189.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:04:58 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:04:58 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 084/131] tpm_tis_spi: Pass the SPI IRQ down to
 the driver
Thread-Topic: [PATCH AUTOSEL 4.18 084/131] tpm_tis_spi: Pass the SPI IRQ down
 to the driver
Thread-Index: AQHUQr2IhILDvwAsdE2smrUPalRh3Q==
Date:   Sun, 2 Sep 2018 13:04:50 +0000
Message-ID: <20180902064601.183036-84-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0741;6:VareT7CWq99loQnMbN/Zq05YV8RWLAXp6u7SZ/LPbnAl/qGjNUW0ZewcwO+Q+B0xIZjq+jNgmbp+mBdLFy6mr/TeftFbcvtI4hTTHmr8yw3xfdq6aYrLu9Eb8ZVlOAsDWvy8u4gyB47V/pm7o/hFqWcJlI7u9sLdc4imE8wYsZTBhLRqgKXBJs+92nlA6NdTfEw4eUepuRijgH8wfBKJ25tvnJ0dg11DTJhK2Lm50CEWtuJlDTr781lX3K9Gl+YAGFs8Rk0Yc4nCeqnlwuVljS/m8HKtnO5IqK+D94A/tBtwhzlu2m9lVVdM6kTlAmnt1++yLal1Q8mHayt5UBgjdEUEYYx6R+nHju20fcYhTA5fXbIMzgbz0+DZj5ZJ6tn4MGU8GM/QkhbQnUd7K4HG8PH8deqZ8gFKSTNs0u3kL6sO6GUDsN5SPSKnpH0V2hMW7j7vGbnRYfEfSebnD6pfOw==;5:HORlnWAZMzS8F4xsgMGV2OVWU59iuOwS7zDNaz5VIaF5/ZwlEaf1EQ8h+jGBY+PRgqIIp3Xkw20il132ZF1Y58Fj5jmaZtYpY1xO6tHvnq+PZu1xje5X5WPf6AUu3iT6JSUCxPWeK17RuMe7Gcqg0/hEUEhawei7rpkKRuhEBG4=;7:zzpg5xD7VYUxiswTsetW/JmvQKoZ+x5V/kobB+ol9Vu2G8QWTSOzXYRsvSplxtE86Shtbi4rsuwT+WwSlEpJz+uuPdmnlftXNLyieylhLNn/4kF2xHmvCXwz9v5a1ukilpd5WcOOQNlaOE93PX/Nsyd+MjBJu2OqvboF9tIXVYLQTJETOsubFKv+vvI+nztOwsxTVL196jP4p5X30t5bd0TPHhD4vWJqM2/f5QcTFrQxPOlczy/F4vv97nSJAEMc
x-ms-office365-filtering-correlation-id: 00e0ad7f-022f-416d-5787-08d610d4af63
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0741;
x-ms-traffictypediagnostic: CY4PR21MB0741:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB074149BE337DD90A6012BC34FB0D0@CY4PR21MB0741.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0741;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0741;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(136003)(346002)(396003)(376002)(199004)(189003)(97736004)(2906002)(186003)(26005)(256004)(14444005)(102836004)(11346002)(25786009)(476003)(486006)(2616005)(446003)(305945005)(66066001)(5250100002)(2501003)(7736002)(6506007)(8676002)(68736007)(76176011)(6666003)(99286004)(6486002)(105586002)(81156014)(81166006)(53936002)(5660300001)(22452003)(478600001)(6436002)(86362001)(14454004)(54906003)(36756003)(106356001)(110136005)(6512007)(4326008)(107886003)(217873002)(3846002)(2900100001)(316002)(8936002)(1076002)(10090500001)(6116002)(72206003)(86612001)(10290500003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0741;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: pGnVhHlgRu0/70YarIdJDReYbifTGCpQFIchx0bH+wm/CtdwJR90QsbjRECTS6OuieXEW/mh0UYpZhd5YT/HcCGWdTx5w61Um9ie59RCwHBV9kN4juzSEvjLh0w3xCUwrM6/3gpzdxcNLeE8Vt1x09AqrjJ+8cUFDvz3n9sQ8UENcWIO1HL9lv7n+xkRZ8J8S4OVVoYUhsGSFMigknICQibx1b8DJoW17QoB7tu5gfjAhlfXlcUBB+Ys4VZRTZxawLsPB+lrvcU6v1OoXsPFDG1y74toj9Q/oQDwZjPy5L6d+Lp4m8D/JMiuFXOrkZRcEkrS9aYWJObYAeT5CLiue1hA2xFvzKOF9xdtt8se9fM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00e0ad7f-022f-416d-5787-08d610d4af63
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:04:50.0331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0741
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Walleij <linus.walleij@linaro.org>

[ Upstream commit 1a339b658d9dbe1471f67b78237cf8fa08bbbeb5 ]

An SPI TPM device managed directly on an embedded board using
the SPI bus and some GPIO or similar line as IRQ handler will
pass the IRQn from the TPM device associated with the SPI
device. This is already handled by the SPI core, so make sure
to pass this down to the core as well.

(The TPM core habit of using -1 to signal no IRQ is dubious
(as IRQ 0 is NO_IRQ) but I do not want to mess with that
semantic in this patch.)

Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/char/tpm/tpm_tis_spi.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_tis_spi.c b/drivers/char/tpm/tpm_tis_spi.=
c
index 424ff2fde1f2..9914f6973463 100644
--- a/drivers/char/tpm/tpm_tis_spi.c
+++ b/drivers/char/tpm/tpm_tis_spi.c
@@ -199,6 +199,7 @@ static const struct tpm_tis_phy_ops tpm_spi_phy_ops =3D=
 {
 static int tpm_tis_spi_probe(struct spi_device *dev)
 {
 	struct tpm_tis_spi_phy *phy;
+	int irq;
=20
 	phy =3D devm_kzalloc(&dev->dev, sizeof(struct tpm_tis_spi_phy),
 			   GFP_KERNEL);
@@ -211,7 +212,13 @@ static int tpm_tis_spi_probe(struct spi_device *dev)
 	if (!phy->iobuf)
 		return -ENOMEM;
=20
-	return tpm_tis_core_init(&dev->dev, &phy->priv, -1, &tpm_spi_phy_ops,
+	/* If the SPI device has an IRQ then use that */
+	if (dev->irq > 0)
+		irq =3D dev->irq;
+	else
+		irq =3D -1;
+
+	return tpm_tis_core_init(&dev->dev, &phy->priv, irq, &tpm_spi_phy_ops,
 				 NULL);
 }
=20
--=20
2.17.1
