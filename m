Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66639C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15DC72087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ISkRfJ7M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15DC72087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732837AbeIXVAk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:00:40 -0400
Received: from mail-sn1nam01on0093.outbound.protection.outlook.com ([104.47.32.93]:29512
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731114AbeIXUwu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:52:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bm30qdP4l7xKWmksZFCf5TUY9zvyDNc/o5tGffN4Lso=;
 b=ISkRfJ7Mk7LO/61hiGrdLwQN6lrm/Q8jOLWBf7OA1j2BPkWzPNl1GGLFNxrFbZYiInkoYqqOGw9MmEN+Sdl+hLNx2w8hu5Bs03bnSTZrRl/0OrsDT6BSOJulN9RTG7tvab3NsWqBthLz4PHfBWVsuuJarmz0+cOYcY/JejbWyVo=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0470.namprd21.prod.outlook.com (10.172.121.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:50:16 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:50:16 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 20/36] gpio: Fix crash due to registration race
Thread-Topic: [PATCH AUTOSEL 4.14 20/36] gpio: Fix crash due to registration
 race
Thread-Index: AQHUVBW9Dbxqvgmxk0S95+wiAxH2qw==
Date:   Mon, 24 Sep 2018 14:49:05 +0000
Message-ID: <20180924144851.164533-20-alexander.levin@microsoft.com>
References: <20180924144851.164533-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144851.164533-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0470;6:viPich8MzA+WxMClcZHCn3nzw+JslmzmTWDDnyIpj74SSr4YTxsCV51hewsejGzpXd+Rv/zz29G62OLV7A4l7leosErylZB8dVZhTUGXwxSW81FzNu7gV5Zbb8VY9R6U3sVF5As16nhkvdwv8Ik/T7SwSMazPQ3nbcPv6/awRbzKvA0NDl19sksHXDqCb5KmKIw5tP3btxO784FS+698Qw7k52edNI03dJC4mMa+uHc0pz3NZ1/PpE+sgilQEW2leHQGiIE/H1JJvwKqMNEVyvDesky3rkOnOHHTtPeK5ops+wvrcuM82yeU3pUO5xJhsXnX5eMG+Yorzl8xB4MQbyFHqguos87DIQnbkBdSBNW9idGnn8ErcTSQPBSLK08vziTMn9UY9ypSOAVvl/NHtq0mGmFtDz5FN1RJAJaTsyUxhOIqsry9q/5qcNt8PS/Ipx15KXUhbqDvTcCjRvpRSw==;5:HnK6+Lj8z/SZbuN4/GOy5UGiqfy7mD77F9ncNokc3JGc3X/O6zDSVNRrd3Q/XaAtSfWjq8OajUVygfYmuINKktWoa1Aulu4kZFaPSscoQAfiGIsjPqaRQztPyysBBdfGFQx1TDHnCIwVhQ2RgncFuZa+gVPyqD2QytOsvo+OD68=;7:3Z1PuJoznvPaanKYt9/AkQva7+5PbCELOTCzc77J7C3jmeDmuY+fuTVSrGKtAdcDKTM/oELZBdNp6sM41IXiYhadYa02rCaiO+E42g2XHV1yPPvajh4MhSgyCMc5Dg/wsWpvxyOqYJAw5REgKL0jTaQaD726BI8vxLpxN/VhN7dTm4SBC2m+E8rtsIuPmm1E0bvAdGYdmupO0pN7LeFgrrI5NdnGDDobAJUKvAeRKbm5w8elYw7VkUpTcGILCsKh
x-ms-office365-filtering-correlation-id: 4def5ea0-12cc-40ad-3977-08d6222d0a7f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0470;
x-ms-traffictypediagnostic: CY4PR21MB0470:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0470D193820B590873CCA851FB170@CY4PR21MB0470.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(269456686620040)(28532068793085)(89211679590171)(12401385986421);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231355)(2280196)(944501410)(52105095)(2018427008)(6055026)(149066)(150027)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0470;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0470;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(346002)(366004)(136003)(189003)(199004)(26005)(97736004)(5024004)(53936002)(14444005)(25786009)(1076002)(76176011)(99286004)(102836004)(186003)(6666003)(4326008)(3846002)(110136005)(107886003)(86362001)(5660300001)(6116002)(72206003)(54906003)(478600001)(8676002)(217873002)(86612001)(256004)(14454004)(10290500003)(316002)(6486002)(6436002)(106356001)(486006)(105586002)(446003)(6506007)(11346002)(476003)(10090500001)(2616005)(2501003)(5250100002)(71190400001)(68736007)(66066001)(81156014)(71200400001)(22452003)(7736002)(305945005)(2900100001)(8936002)(6512007)(81166006)(36756003)(2906002)(60540400001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0470;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: byUyp5082YOekyGvqOOWpko/iHiIbvyBKXumPe44mtfL9F1yw9uN6zgNAsSExMVYHBAfA9AG34dxA04lW4c3peQwkV1jOeSJIg1iIBQ7pLeuHwbsRGAA+pfmlsyfqhghJ/1UKU36BtCyrt82ECBwi2W58j9f5FWuZhm/KEslkl7NbmAOpa0ik8EKDAE+LNir9w0rlgjsLEspGmmfZ2M2PzcBgWIxcqjj5ORJqeMtAND0tgqD4+nN8ZTHFLNoZ6E6UmQtlBi3pLkx+407i+AAa0NJOUlTZbWKFxocc0bND8IANd6mMOfexhBMJ88YIYtp0u8lE5g3MTNVjOpFysE9H6QUNOmsqUWr8ImpkCTGABRiqdf9eYbeOZv3Ija2xCylNUi0oQC6WQmKZX2uHbLfpGIe4zTwPTLuBux6tcysp479A+HT/kwDepIBRMomR62mt49EAdJwcMTT2cNPzcIY87Q2u7oqsCAlLhPZZIfcthsR3se0QYc6/ezNTjIINoEUv2qpT/X36b/2WusPAu1exwmEnJmB6Wsr3tYeq4FkvMyBXB9oOULGX59sFXzqIPbM
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4def5ea0-12cc-40ad-3977-08d6222d0a7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:49:05.3330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0470
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
index ba38f530e403..ee8c046cab62 100644
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
