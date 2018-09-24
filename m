Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF322ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5541E2087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="UO4hhhei"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5541E2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388615AbeIXUxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:53:17 -0400
Received: from mail-by2nam01on0127.outbound.protection.outlook.com ([104.47.34.127]:52378
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388626AbeIXUxE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:53:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SU83BgroXCIZi5Vfl9bHM+3mInGFtyTimpY4pnFHdFQ=;
 b=UO4hhhei1iDugjFwBytrwXdfiyEeNzSG6VWQ2W7XvOMBNKGvZ/GeVzdtR+ef+iv1JL2zYHlNJEuXYpl3KNJ+3tsUrpOuFTmXd0H9lsRiuCzgSgTJ5AIE6SkwIBNy25v6rvPUv8DNyj1+f0oW8brRWNJOR9DDdj8MSSLx/E/B2zo=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0181.namprd21.prod.outlook.com (10.173.193.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:50:27 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:50:27 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 09/23] gpio: Fix crash due to registration race
Thread-Topic: [PATCH AUTOSEL 4.9 09/23] gpio: Fix crash due to registration
 race
Thread-Index: AQHUVBXLLE+RYNofCkCM4l0n7SIMBA==
Date:   Mon, 24 Sep 2018 14:49:28 +0000
Message-ID: <20180924144919.164617-9-alexander.levin@microsoft.com>
References: <20180924144919.164617-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144919.164617-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0181;6:xKpQRHucZXCWASp2qCc6bYackBo22GWQoBU4K/2ffg0GaeJWiOuronxvwx6sJl6Y28ipG8OP+HNFfpWcuWG74+wDb6RYoFeV/dR4qr1siCNgQZQTFc47qdSosrlDGfqn6Xh8WHg2GG3fhFwVHufF5KnhyPBWe43ju5vbCWVAYh4z4lIOMFGnGJpVPyy2w0WxpFFOjqNhqypyldQCYUeL6H33QnfWbe//9MLG1ThSNMHxz+BFT0xGGgahhY/UUEzfRiX1IX/p5btQhKUhNVSioMOMfoJM8XCr3KkhQgtiGOUVXCSNkEe2KL5CJ0A60zmtK5KqQ/BWZyKh2yhRly10iwXJPn7OGh5pMUz08mOvgZQ71DBimZdkgdG1/yMmHQVTBsLX8T4Jtvtmp05KDFHgiPcbu5Iqkg66du68pjC1Z4ZAiFp63X+3OTYzjSNbWe3ZtW6/7WmeMuFRTAnypX48gw==;5:ohDWVtmjU+PVqoQ3xffOHwADrB48TdbmY9pGT55TzYsGCtghCMsr7E5xDrw4xtCwRL7cL/+RRAP1znGWlpIgpViFdINt7DCBqHpUHee8BNOstsvvlYXxQEeexK5ulNC/H58BZWmJuEg1GyLZ1BXEU0xcPz7KPIvOJFaklbuHqjg=;7:PE/QBUdIG0PwMjP38PJA2mRzsk3CFT7c2LpLR3dDzR6r1SmMyUVjdQr33VVUfEv4My6Cn4O4XBr9OKcfCkMRjchsHj3InpIWDGUaVuTPHEjKTqH9gD8l7IVOSFNGvwkYrM1cnEl8cxSIWwv+mHIL7T/AEefYniN2T+Ym6AsGwaV9EIuZaEqBfPvKNmST5x5e5bg4w9EIvgMyk0SKvAYibMQ5S1Aol2Z8npd7d5BnHoD5M2kC4AUQydpXzjdjXKOu
x-ms-office365-filtering-correlation-id: fcd953a5-a738-40fe-7bc9-08d6222d10e2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CY4PR21MB0181;
x-ms-traffictypediagnostic: CY4PR21MB0181:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB01815A0DA378BB0C6B7D382CFB170@CY4PR21MB0181.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(269456686620040)(28532068793085)(89211679590171)(12401385986421);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(2280196)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(3002001)(6055026)(149066)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0181;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0181;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39860400002)(136003)(346002)(396003)(189003)(199004)(10290500003)(6116002)(26005)(102836004)(3846002)(5660300001)(22452003)(110136005)(10090500001)(8676002)(1076002)(54906003)(105586002)(186003)(316002)(106356001)(2501003)(6436002)(97736004)(6486002)(107886003)(7736002)(36756003)(478600001)(72206003)(14454004)(71200400001)(71190400001)(305945005)(256004)(14444005)(5024004)(5250100002)(217873002)(2616005)(68736007)(53936002)(81166006)(81156014)(2900100001)(476003)(86612001)(4326008)(8936002)(486006)(99286004)(6512007)(86362001)(2906002)(25786009)(66066001)(6506007)(11346002)(446003)(76176011)(60540400001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0181;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: gYK1XclAvLfzoNYRiEsxp68wib8XYChnpFu2MYyxilKuRA91odTRlVWRguMwd/wnizwWr3IIkXeCZMRHkAsQm1F3P9LB18bLJRhmcijCLw2z4E1f6wfXPGrQTLPZwkStVbL3fAgAe6IFR1GqJWiB3b/on6u6OprArxVXsh1gWo7eVPuVP4YqsL4r4cpBDVCQUSdzunaiKLNxesQM0RD6YldPCmfWyX3JgZ832QFjsbSO1NFDJRYi/RevhpirlzI4tqUJ8sf3E080ff0VK9XxylFN1QfEsmekit7MrwYJfKCvGaEPKb9H/gm9EVZ6o3It48y+rubRtCVq/SrYkgjYxgGTwQT3s9vgS2we7/lLM0I7f3Kr6/hqScmTTz0T7y4YKAkJJ6JVllYg0QePzbFU35tQ+Yo6g3i9L84CTyYiOnLf/7vsdm8fCU3DC0zMPgEO/Fd20NOP0V3hnTf1vA21cuk96Fn9ZtUv8vQCvw4KRrXnWG87r9FtpOh0OPORpB0D8jWfJXdheGY+yXJ4jIT0+qd0Wy+jpDroFokrLPxrYwocsUKECeV9jqxG7v0TSHJj
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcd953a5-a738-40fe-7bc9-08d6222d10e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:49:28.8534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0181
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
index 193f15d50bba..aac84329c759 100644
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
