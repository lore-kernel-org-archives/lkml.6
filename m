Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4419ECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D58521477
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="GcCbs30M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D58521477
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728732AbeIOGsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:48:32 -0400
Received: from mail-sn1nam02on0100.outbound.protection.outlook.com ([104.47.36.100]:36480
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728584AbeIOGsa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:48:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sxwcuhKbju/qE3cveJyQU7IY+FBZDdzpP7AdAPi2lkQ=;
 b=GcCbs30M1nt3dIPChraclj51qONamDjmVTYbxG/W+wuZPGrUHLnd3sxyvQdlfZ0ub3hTq5Hi2Z2G8uh9F1ZTIMSDpR/tULSZDnSaDyCQsiryU2xB5yKVaxDdBG9BHmgNtmhNu6b6pparuqMrvTkJ9YBD7M+1QMyirjPBaJrsYHY=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0741.namprd21.prod.outlook.com (10.173.189.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Sat, 15 Sep 2018 01:31:30 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:31:30 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 62/92] mfd: 88pm860x-i2c: switch to
 i2c_lock_bus(..., I2C_LOCK_SEGMENT)
Thread-Topic: [PATCH AUTOSEL 4.18 62/92] mfd: 88pm860x-i2c: switch to
 i2c_lock_bus(..., I2C_LOCK_SEGMENT)
Thread-Index: AQHUTJOxwUZSVuSqoEKZm23e7UkLqg==
Date:   Sat, 15 Sep 2018 01:30:32 +0000
Message-ID: <20180915012944.179481-61-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0741;6:c2MjmMnqrVo992cWSzFRKbR4b/ntLW34rEbNrWIXhQy8Z+ihTrrmf47m78BYf7a7Xv0Gd9iuwynWoD6veNLLtwI0aNgQnT4vebo5H9lwnB2BaxzEc11EW6pNoCMKmdmq56pyRwKDIB1Q5s65/hI9izFTVPlS+EdBykSZ9u8necHMcHdQeJBoG3r2MOXP+cqSOr/nqPsN8BSYK8hXWBgOSW6KKIior3zaelLypLcbOIcsNmmq5Whi5/OtT6EP5gsrRMEF/MRw+KrD8BCiPkSGyuG45sWGP3YjKTpIAbOdOSEKSJemXUbDvr8JlboHVFPIUWVk5O2jTt1aY7w6SusXch+Yb3FuLVAdbFcDTwfCHxCTLO1V3EvqSfDY8RR9O1JxqtUiC7GA0NgIOxm1npjHHgWZwUwFTocLAT1PaQzfJpzQtMbdF8Hal/0RVdhN87/0ZsOfWAL9VKKkEgfiIr/fXA==;5:KrZgqUVxRubGCpwXJcShLpAP9s13JgsnsWpYriJXQdS157yFPYk3nXP0cN4Ks2TR9yQYFfEaoe0nNC6Yf3V1K/gwL10b7q2NtYfQ+G45YsR9391lbvZbXK7AMn2RWwfms0eyQdimiQqCa0nNMrJ68uPgRT3jug+g3axgVJSdR1c=;7:npRbCzGONzgXz4o7GKA9okoHkPGBOSCMB8vQsxAUqcyfqKvUYMv3Q8FWzKu9DHYKuPi1jE+HmJunczlwh7W9Cc5v2qvOCI80BYLkTeDnRhBGFV+cudFGcOENcMGt1X7X2SZkq+fCX5MYV/PT77+4jg51dlOQqYaMHDvrnJXYxkvLGcsprNKWxrZFvizVaY/ZC0m+H2ReXi/T7XMeHHwCw8N/8ywyp7Ka2y8qUJMDvPQYrm+p8RIoLY/eP8w1YDsD
x-ms-office365-filtering-correlation-id: d0d6e8ca-740d-4336-4356-08d61aaaf6c7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0741;
x-ms-traffictypediagnostic: CY4PR21MB0741:
x-microsoft-antispam-prvs: <CY4PR21MB0741761BBA7FA5388A6A02F2FB180@CY4PR21MB0741.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0741;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0741;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(366004)(376002)(396003)(346002)(189003)(199004)(186003)(106356001)(25786009)(6346003)(6486002)(6436002)(476003)(102836004)(11346002)(5660300001)(2616005)(26005)(217873002)(105586002)(486006)(446003)(4326008)(53936002)(5250100002)(14454004)(10090500001)(14444005)(2900100001)(256004)(2501003)(10290500003)(6512007)(22452003)(72206003)(8676002)(478600001)(110136005)(97736004)(68736007)(66066001)(81156014)(81166006)(2906002)(99286004)(86362001)(86612001)(575784001)(6506007)(76176011)(8936002)(6116002)(3846002)(1076002)(54906003)(305945005)(36756003)(15760500003)(7736002)(316002)(107886003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0741;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: Z7BSq4AmE/5X6RMIoTTuSkKh9uFBdR/Fxwt4KvIIrk81aepoTTKYq8EzJ/uQ3YCmoxFGTMNMfRgdgHWAWJUUFAqofd4OwuH87RQLSQAZQ3sN1YhdCxWMiFOcLbYMXiNblPoj45ZdSen45J5XmDB5B3WIoGyNP6Bp/e+jqNEo7G5SIqm7ZyqQsAebqU+DxHxqdGkbSYhxzuXBTm+pnpfIH68Ge97yK/qJqANEuxL0fukkoTq4pv2+ZK9Wc71giC4mQnl6xu42vHN9nMHJuq2xplNhBqq+9GTfngesw/LMQBk79XGrawm5H2HK1axK2gp5Vsi4NeJGQWTmXXs6CSDh0It6y9qTvin+7MWvLrHSouM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0d6e8ca-740d-4336-4356-08d61aaaf6c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:30:32.7449
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0741
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
