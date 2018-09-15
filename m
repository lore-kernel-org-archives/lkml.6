Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FAB5ECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DABC821476
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="GyklZ8mC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DABC821476
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729342AbeIOGwS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:52:18 -0400
Received: from mail-dm3nam03on0128.outbound.protection.outlook.com ([104.47.41.128]:36672
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728970AbeIOGwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:52:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJSpFT/TgF+3JxPREojnIfaqJsiK8pVvDljANOZpgwE=;
 b=GyklZ8mCkEhJ4p1L0cklHSdm+lQAXJX/3kUC1GeitwbeGNTIzcnR0YDKI8x4ecua49PTdncrxo9fAgeNMOFZzgR8yOiQyMfHNwYQ1CQCtC0WQVXjKcSEPgv49GrU7cJWRUW59MHSvmYfpPU8o8JCgAzgR4HFuGFwpXG43SjjRV8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0181.namprd21.prod.outlook.com (10.173.193.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Sat, 15 Sep 2018 01:35:16 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:35:16 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 33/34] gpiolib: Respect error code of
 ->get_direction()
Thread-Topic: [PATCH AUTOSEL 4.9 33/34] gpiolib: Respect error code of
 ->get_direction()
Thread-Index: AQHUTJRJR1rBMn3MjkGXQkltDs/Z6g==
Date:   Sat, 15 Sep 2018 01:34:47 +0000
Message-ID: <20180915013422.180023-33-alexander.levin@microsoft.com>
References: <20180915013422.180023-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013422.180023-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0181;6:RWsPChlfBZtkXmEvxIYbfGwm3wZSkhDsRx7zNmj75SW+6juIK4bfCaBm6IssJAfmoX4DGIm2KINBeIzfzqHp+zrcXxRPws627O1bkePXr/gJzHP7cmt4kIupzywTIaReQL3sqz+bH/waktjkRBhrvJ1OfQL8lR+Pcs7tUuuRjAPHPNgOmq1kFfdPAOSxlRl3BZh+yxwA5cNLn4BMgnvLkMl4zZYxLvaSH+xvOO64qpUTCXv2224bGYXv/zHgXCLR/aO6TF3i6s2oZcbO0x4A4odLUsLIdTkpqYEo0Qx8ahVwd1O/xaNdsvIl0xFYA7x7Vo+MqWJoK94xbiHp4FXJ2MD/rdsBs0VjL1U5qIjGUhel3bmN/bV8+5fulPegVcbfXV3c1AFFsF//iB8nqAM1wwZJTPzvnWSPSR/V5Gi8mJDq92ulivKdz51GMuPggwHAgKAoihgDp1ylP9aRfBKIyg==;5:sIssM9xeEzCy49+inX5aRGRp1qUqD3K5XnDfClca7EhEuAU+pORs5uORSX4tKzuXexrPdx++XXRb0H7FNR0NhDQSabwu+7iJBJ/Z122hQRqM+tHngqCyX0Y9oEYRXsWo0i5oJcEp4DiXD3/DeeYKbmPetBy8Z9CaFD05AbcQxTg=;7:5DmC3ElmbYKQ0iDj6iBdcUn8PZvgWFri6PTugrKMir93cA45fN2h12g/ZkZ8N4sTUXZ/Dj/I1SM8kxBa3vYBaOzhiFde+SYDAoFu5YfbdPvW5Fv92Pa+OsrijPQnq39cC0rOMKWytbAJ1tmjDXEkIJQH89qI+GVxKsCEnLM1byem1G7r0uwXpz0v77zvQCEa/b2bzqYcLh4yR0RF/DFTo2w/Wstt3JdAhEqxi+j3z6qAtAabajIr+xlpvtZPORix
x-ms-office365-filtering-correlation-id: 8242e52e-ee5e-415c-c2cd-08d61aab7d60
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0181;
x-ms-traffictypediagnostic: CY4PR21MB0181:
x-microsoft-antispam-prvs: <CY4PR21MB0181724EBA9964D863C825CAFB180@CY4PR21MB0181.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231354)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0181;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0181;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(136003)(376002)(396003)(189003)(199004)(66066001)(68736007)(6346003)(186003)(3846002)(26005)(1076002)(6116002)(25786009)(97736004)(110136005)(54906003)(6666003)(2906002)(72206003)(316002)(10290500003)(217873002)(476003)(102836004)(478600001)(22452003)(2900100001)(36756003)(256004)(14444005)(10090500001)(4326008)(2616005)(76176011)(14454004)(81166006)(11346002)(2501003)(81156014)(305945005)(5250100002)(6506007)(446003)(106356001)(105586002)(5660300001)(486006)(99286004)(7736002)(8936002)(6486002)(86612001)(6436002)(6512007)(53936002)(107886003)(8676002)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0181;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: plWEVl3rpcvIFPToIi58v0MvR21ZMuPkDdwP/0Zv46CcTrZMZh7tCudu/IEBGw72btJ/RTRInt7LwhBjXRcE5cn9Ww8P1lNoCRuDrE4e4TTyQDVExpyIGKaEw+BCr/pcPrVyVN/D8+VbK1m7IwxxM8MizSV1URYpEYgmxCX5I2FXdDlgFZrvkxx2tv6UPxAi14TUH2DT/FR70KaSzI1g+buORvvNtkLkmPljpTMVy8sMpvTXqT0MljHjNKnwB4tMvgRLuMZKMCSDZnMDh1+sawTlUt6HLa9DDU/esxOXNLk4yK2iWAyGxQz82+5M6hfszNStb1Z2WK1tERFR937o7HdHi+QyUzbrLFiK6nZrr1Q=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8242e52e-ee5e-415c-c2cd-08d61aab7d60
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:34:47.0203
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0181
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
index dd0076497463..f9b3f95253d1 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2749,6 +2749,12 @@ int gpiochip_lock_as_irq(struct gpio_chip *chip, uns=
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
