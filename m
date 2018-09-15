Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 326A5ECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C08B821476
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="EXUz8GaW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C08B821476
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbeIOGru (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:47:50 -0400
Received: from mail-cys01nam02on0090.outbound.protection.outlook.com ([104.47.37.90]:32953
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728330AbeIOGrs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:47:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dqc2V20NK99AawjGUn7Jotz0uEfnzAZnQ8D/PPN9es8=;
 b=EXUz8GaW5j5vRBWZKFmmLm9bYQ+WRB0IcnHHjzAxjwIxk5BKYDWEFWwmH9xkkLo1x96XWWMuxRc3024M1076u1dXCSKdj6KJd2ftQbzjlY03bFslBaozIZUhdJM9WXyZPUH/RyP9AR/IiRbiWeqNRd5CXnO9YWlSGlG62GPXTmw=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0741.namprd21.prod.outlook.com (10.173.189.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Sat, 15 Sep 2018 01:30:43 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:30:43 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 34/92] gpiolib: don't allow userspace to set
 values of input lines
Thread-Topic: [PATCH AUTOSEL 4.18 34/92] gpiolib: don't allow userspace to set
 values of input lines
Thread-Index: AQHUTJOm2+uojIJ3YkmweheIHddG9g==
Date:   Sat, 15 Sep 2018 01:30:13 +0000
Message-ID: <20180915012944.179481-34-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0741;6:KjoFVWsl9/3E1x0UPn0snCy8LkNg570F6/bc+Piy8jMlBw0nHb1ZCNV2KYxVhL75s7wLRzXUtB7bXVVdRhQPAeZ8T/YNodxgzuBbhZC7//mx1yp5MEyhKetswFIYR1WWLiQ7Czy8ik515wcam8ubThYBVn+hDOdDyro1ZiDH2CSr/zEsdqTbQ+LoKxuO6rb0pw5BMlUju3JqbTYJM1Bloa1VhjltAlM6BDZcHQJyFUxRBoqC7/XgIvrbf5jIuhMfYWAQjlWdEhPOsu/V27HXRxcgF0QNkFgE9MDy7+DCf1nbOAtS+L9xbKtlhEHIPqLCwSxY3HrnXEDaCQFEKarHCp7LUF7xlgFOpLX4P21xqHp64AMEJi9IXOBj4Lo0vNkZwStfSa1p1w/zVLNFWedJpz+8/t0cvex5kWyeWijUHX4B2MxgALfRbNrI2KELrFv3THYWdR/H/aKf565oU82IBw==;5:CrDOZaeqATskScSf250pSzEJQWK9yLXYjTzTUM2c27mtE9ooQyUyQ+VNTiSkNzvMo9ldRTd9HyFWiTFGuOhWJwqx7UTd5ArwkOL8K2rVHdv8m33mb2XIwQcKrdV8mpWJdumAW6Gsrf0huVbDSWn1mYuYvcD34ypTsQ3LvNox9d8=;7:YeJVfSuHDWQOc5qeJaVoFMjozaETWNkvB4pO37mBVj+D9rkQQ3XUMrjM9y06IPNcPdMEIWoUisq8CDeR6EfTLBD3gTi+xOhPZwSYNp612RBc1uIoVt3lrswOPKYNOelgXz1sTaPKxALZimlK7oGckWw8lDLHuDXsDrYrTL8cfavHpFF5zOzAw023qjNpdgGX4ty2ktW3TKQuK+Q6li9VGX3KZ92eQqm9a8JV3vbP0ZXWD3lkzKCv4QJ1SIVpbo47
x-ms-office365-filtering-correlation-id: fd35637b-29c5-4953-4457-08d61aaadaa9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0741;
x-ms-traffictypediagnostic: CY4PR21MB0741:
x-microsoft-antispam-prvs: <CY4PR21MB074164FFC922A794FFAEBD7CFB180@CY4PR21MB0741.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0741;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0741;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(366004)(376002)(396003)(346002)(189003)(199004)(186003)(106356001)(25786009)(6346003)(6486002)(6436002)(476003)(102836004)(11346002)(5660300001)(2616005)(26005)(217873002)(105586002)(486006)(446003)(4326008)(53936002)(5250100002)(14454004)(10090500001)(14444005)(2900100001)(256004)(6666003)(2501003)(10290500003)(6512007)(22452003)(72206003)(8676002)(478600001)(110136005)(97736004)(68736007)(66066001)(81156014)(81166006)(2906002)(99286004)(86362001)(86612001)(6506007)(76176011)(8936002)(6116002)(3846002)(1076002)(54906003)(305945005)(36756003)(7736002)(316002)(107886003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0741;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: krgAacYO3kVYtB3h4ao7/pJB1AhNhPosOmKBztV+4GNdUgWbjyL6FFaRonOMWHDtkrvHr/wkkyy/KE4lxSalubtd9xmY1aGlPY3FcFjy/eCZNgaJboJoH7lj0IpYkMP11dbNqoIjFDfhIH86MMicX7uXingYmsrj4kjY5+6yuj7F8VxhTkJ7UqsVY5n0nw36eRx5Z5q724tIcUmGnWXoo1EAMFe59JMqUjGm0pdXhCi1EZQr96opAPlc89Xq8YMSJl2mQtuICd4uChAucz8Uk3mGpVOrlHq1B8kvdvKnp1GxQgSNy/5nLVoyQXG/Un8m/DYlJFXfPAH1XJs9Tl56JeIe8G/qHlP33PFf3N376os=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd35637b-29c5-4953-4457-08d61aaadaa9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:30:13.8700
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0741
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <brgl@bgdev.pl>

[ Upstream commit e5332d5437764f775cf4e3b8ca3bf592af063a02 ]

User space can currently both read and set values of input lines using
the character device. This was not allowed by the old sysfs interface
nor is it a correct behavior.

Check the first descriptor in the set for the OUT flag when asked to
set values and return -EPERM if the line is input.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpio/gpiolib.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index e11a3bb03820..57973524360d 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -449,7 +449,13 @@ static long linehandle_ioctl(struct file *filep, unsig=
ned int cmd,
=20
 		return 0;
 	} else if (cmd =3D=3D GPIOHANDLE_SET_LINE_VALUES_IOCTL) {
-		/* TODO: check if descriptors are really output */
+		/*
+		 * All line descriptors were created at once with the same
+		 * flags so just check if the first one is really output.
+		 */
+		if (!test_bit(FLAG_IS_OUT, &lh->descs[0]->flags))
+			return -EPERM;
+
 		if (copy_from_user(&ghd, ip, sizeof(ghd)))
 			return -EFAULT;
=20
--=20
2.17.1
