Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C88ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 699F220866
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Id5pLM46"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 699F220866
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729663AbeIOG7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:59:11 -0400
Received: from mail-eopbgr730120.outbound.protection.outlook.com ([40.107.73.120]:32793
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729394AbeIOGu2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:50:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e83qNGfcsxfAnmro5FF3azodNmYHcqwrtzKFYEGcqi4=;
 b=Id5pLM46aTXNf0SC0wNiupdwQYS/Oi+144XoSKwa5xN2OW4prA7uNeMR6NGcV180WWWVVIAKbjvPrE85TsChbNroP1yLSb3SK/4hlz1/QyKbOf2V/rJS2rb9/GayfQt1NG9NirIgAxSWkcy4yDnEDyb6NpkQZo2xawNXht5fK3E=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0471.namprd21.prod.outlook.com (10.172.121.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Sat, 15 Sep 2018 01:33:22 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:33:22 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 41/57] input: rohm_bu21023: switch to
 i2c_lock_bus(..., I2C_LOCK_SEGMENT)
Thread-Topic: [PATCH AUTOSEL 4.14 41/57] input: rohm_bu21023: switch to
 i2c_lock_bus(..., I2C_LOCK_SEGMENT)
Thread-Index: AQHUTJQGrPtuo7bw40SjSmEVC02R0Q==
Date:   Sat, 15 Sep 2018 01:32:55 +0000
Message-ID: <20180915013223.179909-41-alexander.levin@microsoft.com>
References: <20180915013223.179909-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013223.179909-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0471;6:KW891xz57ou7wOG3gAUGDOxZl0dYkPQ46LDuzck+iFsoXF+qjh22LTTjpou/FTz3GRtJWZA0CN+iALFcQxXuUHq8EfuoAw2vlNUG42YGr21wTEPSuG9rdvFZi5TQVCwGcktKSOJvES8clyGacvmnOcWAoLyoDbPGPh+zjYjbcnoFJ9snS0MD9H8jY3y/zSiDzEf2cLuyVlxdBypSAa4QZlNz8AqyTmX8QHDI3XgwQhFdPxlGY8+5I626kUwaELFg8Z26attpva8PgRenM0f8Z8HjKpi10MC2lsHaN+BFUjOG9OJyUGqdUIl51p13DnuHInVHTejZ39ldgdEGI4YCqmL8q/2gpgGBYTbKxAqF+byWqvxXZedZvmAGle0VVQHqLEryt+vakrDHJzZrJauQQ2beSTve5MNpOfuj2LZIOKlOOr25QqU1TyCwzIHLLIiyBmPV6p9PqrEBPFx2JtGl8Q==;5:kKUyaZA51YdIhHGTPBy61StkSlsPuVa6G+Su6ByUMO7jYxr1GOKJ7ONPD3k9/lsSkPKzzx8PbwMkk7rsQUWMnPrAxVD44lFwTJDg6fsiqE8HcOi0pCRW13+BwFZa5+2SqNjK8jJnr0PQcvIWDf30DovWcpyR7pRgLuJp7zQv6K8=;7:UO/Km+g7k96wwtswZpO9SHAEeufADfT+opZx7UZjYEnvgwtulzh0/zsHV209n2wQ3zCsdxG+XZxfEwVS+fi3q/7jXgqT3JsJ9/36HnphhJWNntBwd8W58Xd1GSFoh6A7xNGhc0jZqAxeobQM0Cnns+NOSLQQxoJNMtSGKCmiQwhRk7yA1oTiatDoqHnaHyKZd58tm+Mc+1SLOUdFdHxifewP8yITP163CBKKAIVr0/1trQwOQA4lBDjzKQrH2gub
x-ms-office365-filtering-correlation-id: 1ff804cd-03c3-479e-5a52-08d61aab3981
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0471;
x-ms-traffictypediagnostic: CY4PR21MB0471:
x-microsoft-antispam-prvs: <CY4PR21MB0471452DA0998598FEDD5472FB180@CY4PR21MB0471.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0471;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0471;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(366004)(396003)(39860400002)(346002)(199004)(189003)(7736002)(8936002)(81156014)(305945005)(81166006)(8676002)(66066001)(316002)(110136005)(106356001)(5660300001)(6666003)(54906003)(86362001)(575784001)(102836004)(86612001)(22452003)(53936002)(6506007)(36756003)(107886003)(97736004)(76176011)(2906002)(476003)(99286004)(486006)(26005)(1076002)(217873002)(6512007)(186003)(72206003)(10290500003)(6346003)(478600001)(256004)(6436002)(11346002)(10090500001)(5250100002)(446003)(6486002)(2900100001)(14454004)(6116002)(4326008)(68736007)(3846002)(105586002)(25786009)(2501003)(14444005)(2616005)(15760500003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0471;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: ti1C+ZzzVTUwjDuNzuJ//vbfCpj6bheSppDoU0S13fxAxmNl8lkgZSjjI8iPQ5FKwQqAmyHwd+xZBPKmhlk5eEEEvFy/yRzweSPZSiDIqLGNcoPdHlcxvI8KQoyLRwaMa42jVZmcFogsY+IALZYIc65yg5bw9QD1I/3jOas6neFGEKNnJW1Sk0Eeeiy9uTE0yHkGZ27KNqC3sNVWNcrhZqIXNjsMd8mGOyArlRj3GZAmUGQLc/pmUUizuabtfri01eUVL17crFLCYUVp2LSjRCP3G0dCK84GwzX4ZA5WIn7UgRwmnzwl0qQsmzpLNKQ6PBoX+nYxkLNu30CrkJtmzcQFW/TqroKthQecyRGK3G8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ff804cd-03c3-479e-5a52-08d61aab3981
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:32:55.4304
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0471
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Rosin <peda@axentia.se>

[ Upstream commit 193c2a07cfaacb9249ab0e3d34bce32490879355 ]

Locking the root adapter for __i2c_transfer will deadlock if the
device sits behind a mux-locked I2C mux. Switch to the finer-grained
i2c_lock_bus with the I2C_LOCK_SEGMENT flag. If the device does not
sit behind a mux-locked mux, the two locking variants are equivalent.

Signed-off-by: Peter Rosin <peda@axentia.se>
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/input/touchscreen/rohm_bu21023.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/rohm_bu21023.c b/drivers/input/touch=
screen/rohm_bu21023.c
index eeaf6ff03597..fc54e044fece 100644
--- a/drivers/input/touchscreen/rohm_bu21023.c
+++ b/drivers/input/touchscreen/rohm_bu21023.c
@@ -304,7 +304,7 @@ static int rohm_i2c_burst_read(struct i2c_client *clien=
t, u8 start, void *buf,
 	msg[1].len =3D len;
 	msg[1].buf =3D buf;
=20
-	i2c_lock_adapter(adap);
+	i2c_lock_bus(adap, I2C_LOCK_SEGMENT);
=20
 	for (i =3D 0; i < 2; i++) {
 		if (__i2c_transfer(adap, &msg[i], 1) < 0) {
@@ -313,7 +313,7 @@ static int rohm_i2c_burst_read(struct i2c_client *clien=
t, u8 start, void *buf,
 		}
 	}
=20
-	i2c_unlock_adapter(adap);
+	i2c_unlock_bus(adap, I2C_LOCK_SEGMENT);
=20
 	return ret;
 }
--=20
2.17.1
