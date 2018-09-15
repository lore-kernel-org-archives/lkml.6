Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF0E2ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9527521477
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:34:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="DQ4MICoA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9527521477
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729745AbeIOGvo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:51:44 -0400
Received: from mail-by2nam01on0130.outbound.protection.outlook.com ([104.47.34.130]:13056
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729633AbeIOGvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:51:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sxwcuhKbju/qE3cveJyQU7IY+FBZDdzpP7AdAPi2lkQ=;
 b=DQ4MICoA8YFSDvQPpXd8aUsixdUJK9lv3oJDbiWjdHBwMTVE6zINZCUv+6hVcQGm5y6HDq097QEqBnh25nMd7njsmx7h8FnR84ks7bbx1mt8TqQq1KmIIb8N1G3yyf7Vlh5JhWoXSzr70XECCokqecBL/Eg+kkV5h9Xn/V+41zg=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0823.namprd21.prod.outlook.com (10.173.192.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.9; Sat, 15 Sep 2018 01:34:39 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:34:39 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 22/34] mfd: 88pm860x-i2c: switch to
 i2c_lock_bus(..., I2C_LOCK_SEGMENT)
Thread-Topic: [PATCH AUTOSEL 4.9 22/34] mfd: 88pm860x-i2c: switch to
 i2c_lock_bus(..., I2C_LOCK_SEGMENT)
Thread-Index: AQHUTJRECDFHl9G4oEC0VB33305uNQ==
Date:   Sat, 15 Sep 2018 01:34:39 +0000
Message-ID: <20180915013422.180023-22-alexander.levin@microsoft.com>
References: <20180915013422.180023-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013422.180023-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0823;6:kAZksC9q9i7twakn5B5endwG0VSp+v31ppLGZqBNX3+hbpskbgJpqHVuqQ3Me026HR8YLbl01bg7eLe7kRVmq5rGmZeZTMHESZ/XagDJhlvPmPD301j2NI0AP5iE4ZCgN84+mXkBujcDqq0Qtkcsfbbql2+W5xrXHL/zGlujofBwBsVfHCRxjibjaiKewuCGlyPxSsg77b+lTjWQmLuLDlLtpv1fj5usnOhbT9T7USBejKTWgtqShDpgR8hb7SJA+qQ5RIFeM4dwH5WtOyyoEtxepVPtbe9R35kD0NvPrihBUu2ymEgVAn7AY72QU9OVovdLpMU9aN5b+bUvxpMlpbRkLH7Rurn2xj/J0sFYnyOws7WPzeLEvorAuGajD4e8KaNNXOmxwlYvSSLRtqT1oyxaVLZfo4368D5wMMLT/VUKrmuTTxk/UVLszwiuX1Rb9rBI1dv3TpoGtfyF8KyxOw==;5:Dj2izVAgoI9lJPVDbg9MrHkzVYJAEFu/ZuQNWF+KGoZb2VxcKthDO9C7y0g0XIuU1vZTGDEEOEwHS47LfnjMiqrKiwOWPcyRCgFjmkyLT0DAjUxLB1fUvVJfZ3+V1OuMDM5dr7+HrmFX8SE+FFzV0UhrCixXuzFu4aCJuU4yEBc=;7:YFMbwL/pAvJQzSTxZyj7hBDXon8wpkWIFrIJS4bjKVCXeTXTcpeQrExoTcPyizRO3Q3alplc/QmIGK6QE2pexvzYd2NpPAaQYYU0Idg5m7z+iN1LUmKCCxI7tdCSNsor6fBfQ4FBpFxkUwmfzqkncNo48l2hwGjLnU74Rc6CZklExW1pvufAyGQRh5y2sQn6ujr9DnJFCtctfMAhLJ6jzy97FpMn3DEQ7tPZuZpWHdlsndSOLcDzA0U0DV7tY63E
x-ms-office365-filtering-correlation-id: e5f303d2-d153-4086-4f2d-08d61aab675a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0823;
x-ms-traffictypediagnostic: CY4PR21MB0823:
x-microsoft-antispam-prvs: <CY4PR21MB08236B3211DAC405D170ECD6FB180@CY4PR21MB0823.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0823;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0823;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(136003)(39860400002)(366004)(189003)(199004)(53936002)(14454004)(2900100001)(3846002)(6116002)(14444005)(256004)(10290500003)(15760500003)(81166006)(81156014)(217873002)(76176011)(72206003)(478600001)(8936002)(25786009)(8676002)(86362001)(66066001)(6512007)(86612001)(575784001)(7736002)(305945005)(97736004)(11346002)(5660300001)(5250100002)(102836004)(54906003)(2616005)(446003)(6436002)(6506007)(476003)(186003)(110136005)(2501003)(2906002)(105586002)(22452003)(10090500001)(36756003)(4326008)(68736007)(26005)(107886003)(6486002)(486006)(106356001)(1076002)(6346003)(316002)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0823;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 443Ujpgw2bRQrIWJHcqjYtGkZT0K7XtnudOEgbf4mMnQbMt1WvwtjWPrS5nFl9e7W+wTF4S0maNPml5WBRLiYg9sOeVgK7xwNQxtkyOv9OUnq5BDg2bNhlk8EH3c6Wt0EXN6aZ3e10r/qjFk+XXnQVBqBo2ymcHoxROEgckqg/b1NsQMc5EAKWNGnJ+Oc4471tFVxuE0smBTLwHyZjaOq9HjfkVAYI5tOLdIEdI5LjnD/Zfm1pay3kFgkwlVmMVMi1JBx67aIEdn21v4e29SJ7dFNV4cLXmKxI1zxzf63YzCOk+A/IfqHuFruDeVv2cOzbIZ+ABtmTgVsUT1KCLaxKQMlEbPE6Bdf1QXie2iJnQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5f303d2-d153-4086-4f2d-08d61aab675a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:34:39.4267
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0823
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Rosin <peda@axentia.se>

[ Upstream commit 8c8f74f327a76604a499fad8c54c15e1c0ee8051 ]

Locking the root adapter for __i2c_transfer will deadlock if the
device sits behind a mux-locked I2C mux. Switch to the finer-grained
i2c_lock_bus with the I2C_LOCK_SEGMENT flag. If the device does not
sit behind a mux-locked mux, the two locking variants are equivalent.

Signed-off-by: Peter Rosin <peda@axentia.se>
Acked-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/mfd/88pm860x-i2c.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/88pm860x-i2c.c b/drivers/mfd/88pm860x-i2c.c
index 84e313107233..7b9052ea7413 100644
--- a/drivers/mfd/88pm860x-i2c.c
+++ b/drivers/mfd/88pm860x-i2c.c
@@ -146,14 +146,14 @@ int pm860x_page_reg_write(struct i2c_client *i2c, int=
 reg,
 	unsigned char zero;
 	int ret;
=20
-	i2c_lock_adapter(i2c->adapter);
+	i2c_lock_bus(i2c->adapter, I2C_LOCK_SEGMENT);
 	read_device(i2c, 0xFA, 0, &zero);
 	read_device(i2c, 0xFB, 0, &zero);
 	read_device(i2c, 0xFF, 0, &zero);
 	ret =3D write_device(i2c, reg, 1, &data);
 	read_device(i2c, 0xFE, 0, &zero);
 	read_device(i2c, 0xFC, 0, &zero);
-	i2c_unlock_adapter(i2c->adapter);
+	i2c_unlock_bus(i2c->adapter, I2C_LOCK_SEGMENT);
 	return ret;
 }
 EXPORT_SYMBOL(pm860x_page_reg_write);
@@ -164,14 +164,14 @@ int pm860x_page_bulk_read(struct i2c_client *i2c, int=
 reg,
 	unsigned char zero =3D 0;
 	int ret;
=20
-	i2c_lock_adapter(i2c->adapter);
+	i2c_lock_bus(i2c->adapter, I2C_LOCK_SEGMENT);
 	read_device(i2c, 0xfa, 0, &zero);
 	read_device(i2c, 0xfb, 0, &zero);
 	read_device(i2c, 0xff, 0, &zero);
 	ret =3D read_device(i2c, reg, count, buf);
 	read_device(i2c, 0xFE, 0, &zero);
 	read_device(i2c, 0xFC, 0, &zero);
-	i2c_unlock_adapter(i2c->adapter);
+	i2c_unlock_bus(i2c->adapter, I2C_LOCK_SEGMENT);
 	return ret;
 }
 EXPORT_SYMBOL(pm860x_page_bulk_read);
--=20
2.17.1
