Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 257BBECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 991CE21476
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Ocy9ma37"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 991CE21476
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729511AbeIOGvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:51:02 -0400
Received: from mail-sn1nam01on0098.outbound.protection.outlook.com ([104.47.32.98]:58848
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725832AbeIOGvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:51:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lu/i44cGHYd5zg10mTVdruv1g+aGHY/5XC1fol5ftTs=;
 b=Ocy9ma37Vj5D/EFHFW8sJL0xlVW2FsVHhN8lI+Xr+PgdxZgoseVsptU4SLHYS8sjiZq9PVe461dVfMkcGDZqMEpMDuzRH2cj4AAmUhPwvETNPD31dSQq+qUvdm8srJDXmsEEezxhDEGztd5QpFAeekMRvUkzjj3Nf6Zr9nTDhlU=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0855.namprd21.prod.outlook.com (10.173.192.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.5; Sat, 15 Sep 2018 01:33:27 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:33:27 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 54/57] gpiolib: Respect error code of
 ->get_direction()
Thread-Topic: [PATCH AUTOSEL 4.14 54/57] gpiolib: Respect error code of
 ->get_direction()
Thread-Index: AQHUTJQLTnsaSrxO/UCU/8DwvuYddg==
Date:   Sat, 15 Sep 2018 01:33:02 +0000
Message-ID: <20180915013223.179909-54-alexander.levin@microsoft.com>
References: <20180915013223.179909-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013223.179909-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0855;6:liN9IkhQnojQTpVeys4BUW8D8ehmnlzrhmFF19GE52hVCS9otqj6mxGcGl/3OxgNeyJymd/qWEMxKYh0qDQRYDjw0jhnnyVKFspc4rORZNrJntqhH4hcPMjKCnU2Ja8vg//g2kPgy6FizGVzxFem+9D1pUJU53DSFKqFkzfkHErXt2GD8uAoUQzSpUnZ7cvCG2hpbRTwPpXHLQVOwfiZlJmXu6GTiRUXvJ+TwM2p0b4NG0LK/5G5GXB7zFa3e75YmfWnX+rm4qr9e6561aHFyskbpyUwH5wWUxZN7n7TxaaM/wmb+cHPBRaV1dPtdSIU5agBI4NBmEH6A8PaIecVslGf0wVxM71ugzkiR5HKXwAkrv6eQyv1ArFOX5+PVPvkrBm+seuNqZmjX6mAzkx/wWYIxVxMHVdkJPf7il0F35rt9/7e/FISyK81Feovy3pPXv8ISRd7SztXV/Xd03mlrA==;5:WhOUwSzy44/L8mh/Vocdl/d7NB4aIhfkTnUdZyY+31hDD7mgTgJpgD52XlkZdLq7oSZsqZhALoXiPGiuIM0uw+T4lIB3JiIwVthPZi386prqMb+WIG+Ur9qVY5OvNH2tatSbLmCZZA2wnnEePV3wLbUJcM/SGLLfpKURPEiqkI8=;7:FUkW9zw1OZq0fVDfJYCOlNFhVwFTCOcMQtGC0QsAd3+0cxO0GHg58L9Fuqw65xduDrNIKtilfav7MoLHRsIXs8WGCDgKvb1XtDYuIxutQY5YCypQH3DxwTCza5MTYRfAZ5F0P7HVUfh/dsHDXE+d/RJozyFcjxPtwZAR5ENhenvey9nlQNnoiqvGDhUwFnkdm//STwXw1p7POVfJ3YEYnARGuNgrS/IV+NazSvpvpYhTTTLlDQyWNp4eXaPKQfEt
x-ms-office365-filtering-correlation-id: 1324752e-9600-4bc4-6dac-08d61aab3c45
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0855;
x-ms-traffictypediagnostic: CY4PR21MB0855:
x-microsoft-antispam-prvs: <CY4PR21MB08556A99B98B05EC6EB7A5CFFB180@CY4PR21MB0855.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231353)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0855;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0855;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(39860400002)(366004)(396003)(189003)(199004)(102836004)(6506007)(305945005)(7736002)(10090500001)(575784001)(86612001)(86362001)(106356001)(97736004)(107886003)(186003)(6666003)(26005)(6346003)(14444005)(5660300001)(256004)(5250100002)(6486002)(105586002)(6512007)(2501003)(2900100001)(22452003)(6436002)(99286004)(316002)(8676002)(76176011)(53936002)(54906003)(36756003)(110136005)(10290500003)(72206003)(478600001)(68736007)(66066001)(81166006)(81156014)(8936002)(486006)(1076002)(3846002)(446003)(14454004)(6116002)(476003)(11346002)(2616005)(217873002)(4326008)(2906002)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0855;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: C7KpjhxdN/yv615qmPEx5xc6mUJFgPNBhd5RSvIl7nvuDLo4mFb04qHu78Lc05Eyn67kjqq5kfSyMes6r98BvzsvUqi5BHf97YxUicRT0nNYXweA7jQ9SUK5Ja6GMiVWnypUW2oSCEnEIny5Bs0ubAWwZa5sjk+/aEEVPTPfgIirgSIAhsTbUubAshYOi4L0GpHqUIAl8Dief+puD0+5mjqNy/DmQYgL7YxAxLw7Sbm5YYY6rPGY2gskIt9Uzw6En8C8GZel376mE5tYkSf/Eh5GOBGE3M7Cp5nz6tadLzg5F71P5kAly5t1ulpXQw4NQekCqqTs8nvWl7+OtFJApPlcWxbuDjCJlq/1jBmwQ2g=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1324752e-9600-4bc4-6dac-08d61aab3c45
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:33:03.0082
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0855
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 36b312792b97933dc07abe074f50941199bd357c ]

In case we try to lock GPIO pin as IRQ when something going wrong
we print a misleading message.

Correct this by checking an error code from ->get_direction() in
gpiochip_lock_as_irq() and printing a corresponding message.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpio/gpiolib.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 7e0bfd7347f6..e5bf3e774439 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2811,6 +2811,12 @@ int gpiochip_lock_as_irq(struct gpio_chip *chip, uns=
igned int offset)
 	if (!chip->can_sleep && chip->get_direction) {
 		int dir =3D chip->get_direction(chip, offset);
=20
+		if (dir < 0) {
+			chip_err(chip, "%s: cannot get GPIO direction\n",
+				 __func__);
+			return dir;
+		}
+
 		if (dir)
 			clear_bit(FLAG_IS_OUT, &desc->flags);
 		else
--=20
2.17.1
