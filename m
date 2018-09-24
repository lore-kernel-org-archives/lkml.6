Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 000E2ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A23D820877
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="CE/7zaRB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A23D820877
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732682AbeIXVK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:10:27 -0400
Received: from mail-eopbgr710090.outbound.protection.outlook.com ([40.107.71.90]:26752
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733045AbeIXUvi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:51:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cI0bK3axuvvnOgYwR/Ck3M4YZv7F27Seh4mROhCYxGM=;
 b=CE/7zaRBh1XoWzUnn/lsQ1uW49jJ1Bx8m1Fjvisp2OgMVPhJ9suCCczZ4BGrpxQ/3nEbidM1AMt9xAGd5ZZ2jbHHsMfKMNLOOu0N4msKCeoTJh1vQ2UgK0R0zMBDE5hyo9SDqSnLwJqfqZnJFXodAH+e2e+XQEYyXYgFQAzeBbw=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0855.namprd21.prod.outlook.com (10.173.192.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.5; Mon, 24 Sep 2018 14:48:55 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:48:55 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 42/76] gpio: Fix crash due to registration race
Thread-Topic: [PATCH AUTOSEL 4.18 42/76] gpio: Fix crash due to registration
 race
Thread-Index: AQHUVBWnCFG94/TMmUqFFWf5BR1Meg==
Date:   Mon, 24 Sep 2018 14:48:27 +0000
Message-ID: <20180924144751.164410-41-alexander.levin@microsoft.com>
References: <20180924144751.164410-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144751.164410-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0855;6:3lAJaniqgwCDF2HPmchs3ytbfoLYehmzIls3oVfsajeLJ86RPRHqRME+pgJKePD47Nzj6uBZdXamWxNZX9aJN+ScU6MKy1fHSA1ORB97mdUZJno7cIUe5+qIAh+KhoFxBvqMdAMa9lpsQpg+i6DAlU+x4QCin+DEr04QUrCRY+B86gObeocVzvfRDIecTaH5DRcIFjghSBLJrwb4zvLlRPwc7KhnlmOW11nRZc/ZJpbSg0yecQOftCcwbeSo18N6aEet+5jDfMOhgulcNKhaoMq+5YdHaxirDa1Vz5c12UdYy/SEdNlCVemFkjZJ3Vcil9GX2T46+XwSskXfej1wcDgsIPLaSCKZhxF1ydXm//GfweSaYaAxfJcxKvsyUVoVIvt5eyzDllNwJ6gIdOcobY+Sm7M/P4YeSaNJnn+ls/Nyn5qjxg7xHqjFcHYyonprHx8kFIemLtjAex176wFWiw==;5:YsRnekB1sPCfISroPwWwekxSXAisvn8yYTYWe7TuAF7U60mwcES18IuD8m5tWWAO7VP1UV4QfkEfuPHTozhqdt2Am8NDmn6AtjcCtcUMHvgZUWfdw9/UHy4LiQKxXazvn/8kP/cWSh5n7l6EsNYij7jKIqr6FXbrrpiAcAtZ7pQ=;7:/TjwvxxPK+BdnJU/+pOuLX8sVNW2wcZQgAnvkpcLUBscriMs5B5l4atHa+O0BZpw9yDVWMPIRmGNX7eizdlYOka5NmWSObwD+WHH2eVep9WtQ57w1o6uChQ+WtbJkkK6eu4fKdl0ppZw4g+9VoTSBzZsOh26LQS/WsUZhtvlumi5ius8xVRX2QLw+zGBCsyDnEuz/aZEp5GM+1rWodBQgIafcF/GvlEXlFizXhdt61+UnZTRcghW2M3xvI8wE3AB
x-ms-office365-filtering-correlation-id: 9c2b9a63-03c1-4ce0-379b-08d6222cda14
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0855;
x-ms-traffictypediagnostic: CY4PR21MB0855:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0855624027FB2E2C68F4D231FB170@CY4PR21MB0855.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(269456686620040)(28532068793085)(89211679590171)(12401385986421);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(2280196)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149066)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0855;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0855;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(136003)(366004)(39860400002)(199004)(189003)(486006)(81166006)(6436002)(110136005)(54906003)(10290500003)(6666003)(86362001)(446003)(6486002)(68736007)(2900100001)(86612001)(476003)(6512007)(1076002)(2616005)(305945005)(81156014)(105586002)(10090500001)(14454004)(71200400001)(106356001)(316002)(7736002)(71190400001)(478600001)(11346002)(6116002)(8936002)(5660300001)(3846002)(72206003)(97736004)(8676002)(6506007)(25786009)(36756003)(66066001)(2906002)(5250100002)(76176011)(26005)(5024004)(14444005)(217873002)(107886003)(186003)(256004)(102836004)(22452003)(2501003)(99286004)(53936002)(4326008)(60540400001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0855;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: a0gl5D48C522eZkxOKjqdGHd3/mSKoVRa0uwkCN/pwV4JePL3PFMMZTa5eqOLpetFc0Zw+y/2OtlT3/ALwy1vSHBYJVyQiochE+cDU0gZxiuiCpqEMIYbhtMbn+ySVvNa8PRf1tdFNtogGj1UwUom0CxPgNVWU9F3QUU54K4yN/yJ9tugTI0/6tB/LB58hvBkvKKVxUgOnSljU04J9zOcoETEqmiHuAzVZ5Wwz7QY7AhNAhhJGqfO8NFjHUucx0SbzdLl4tXilYzZtoYel9O68dDW9eoHsVF2tLWFmnON4WHxZeYuiKlbhlpOYtbdwPCb9NN9anuS2Zca9A0u/6v7DQhWt2f9ghW5ySJ91HCfgSksJxgkQScoJskyLiZctTJFEW+4Crp6vMdBduXBvMzWzpXwrFfa+Dt7sMzcT5hUriH3Mkm3VVgaLh6WyUmNf/f68G5N/EBHEnPAb2Nk9ttPvmPyibEPtYw3XvzDe32zZv6EgUFDj00D3w892B9ED8NYa6CDplVQ0JBtfziY/IzJXDSK3UkLw4uM4AEtpHs0Tni0AgDflFI1Jak4nF8r0Bh
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c2b9a63-03c1-4ce0-379b-08d6222cda14
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:48:27.8611
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0855
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Whitchurch <vincent.whitchurch@axis.com>

[ Upstream commit d49b48f088c323dbacae44dfbe56d9c985c8a2a1 ]

gpiochip_add_data_with_key() adds the gpiochip to the gpio_devices list
before of_gpiochip_add() is called, but it's only the latter which sets
the ->of_xlate function pointer.  gpiochip_find() can be called by
someone else between these two actions, and it can find the chip and
call of_gpiochip_match_node_and_xlate() which leads to the following
crash due to a NULL ->of_xlate().

 Unhandled prefetch abort: page domain fault (0x01b) at 0x00000000
 Modules linked in: leds_gpio(+) gpio_generic(+)
 CPU: 0 PID: 830 Comm: insmod Not tainted 4.18.0+ #43
 Hardware name: ARM-Versatile Express
 PC is at   (null)
 LR is at of_gpiochip_match_node_and_xlate+0x2c/0x38
 Process insmod (pid: 830, stack limit =3D 0x(ptrval))
  (of_gpiochip_match_node_and_xlate) from  (gpiochip_find+0x48/0x84)
  (gpiochip_find) from  (of_get_named_gpiod_flags+0xa8/0x238)
  (of_get_named_gpiod_flags) from  (gpiod_get_from_of_node+0x2c/0xc8)
  (gpiod_get_from_of_node) from  (devm_fwnode_get_index_gpiod_from_child+0x=
b8/0x144)
  (devm_fwnode_get_index_gpiod_from_child) from  (gpio_led_probe+0x208/0x3c=
4 [leds_gpio])
  (gpio_led_probe [leds_gpio]) from  (platform_drv_probe+0x48/0x9c)
  (platform_drv_probe) from  (really_probe+0x1d0/0x3d4)
  (really_probe) from  (driver_probe_device+0x78/0x1c0)
  (driver_probe_device) from  (__driver_attach+0x120/0x13c)
  (__driver_attach) from  (bus_for_each_dev+0x68/0xb4)
  (bus_for_each_dev) from  (bus_add_driver+0x1a8/0x268)
  (bus_add_driver) from  (driver_register+0x78/0x10c)
  (driver_register) from  (do_one_initcall+0x54/0x1fc)
  (do_one_initcall) from  (do_init_module+0x64/0x1f4)
  (do_init_module) from  (load_module+0x2198/0x26ac)
  (load_module) from  (sys_finit_module+0xe0/0x110)
  (sys_finit_module) from  (ret_fast_syscall+0x0/0x54)

One way to fix this would be to rework the hairy registration sequence
in gpiochip_add_data_with_key(), but since I'd probably introduce a
couple of new bugs if I attempted that, simply add a check for a
non-NULL of_xlate function pointer in
of_gpiochip_match_node_and_xlate().  This works since the driver looking
for the gpio will simply fail to find the gpio and defer its probe and
be reprobed when the driver which is registering the gpiochip has fully
completed its probe.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpio/gpiolib-of.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 53a14ee8ad6d..a704d2e74421 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -31,6 +31,7 @@ static int of_gpiochip_match_node_and_xlate(struct gpio_c=
hip *chip, void *data)
 	struct of_phandle_args *gpiospec =3D data;
=20
 	return chip->gpiodev->dev.of_node =3D=3D gpiospec->np &&
+				chip->of_xlate &&
 				chip->of_xlate(chip, gpiospec, NULL) >=3D 0;
 }
=20
--=20
2.17.1
