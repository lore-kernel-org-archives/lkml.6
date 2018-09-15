Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D5CECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0616521479
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:49:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="I60jpBX6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0616521479
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728817AbeIOHG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 03:06:56 -0400
Received: from mail-cys01nam02on0090.outbound.protection.outlook.com ([104.47.37.90]:32953
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728496AbeIOGrt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:47:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KwyX0WqQEoHkiKE1Lqf+6pYKlUS0lDzP+foFssEEiQM=;
 b=I60jpBX6Ynzv7tUuCmibHaHOYgNj8NxFvcHGk/j2dTUo+KbzKUl6KAi8FKJASG46jRb8dYq4IXSYbH2/5sKdiyXm1I9VYeXl4zCEngGe1vO63whtHHq7q/qY3FbpdsjAMmdef6zMHBGQREmFHB16P2yEW1cM6NYlQ9tfJXrJl3k=
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
CC:     Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 35/92] serial: 8250: of: Correct
 of_platform_serial_setup() error handling
Thread-Topic: [PATCH AUTOSEL 4.18 35/92] serial: 8250: of: Correct
 of_platform_serial_setup() error handling
Thread-Index: AQHUTJOmI6R9mxZpIkGSNPAbEvcJEQ==
Date:   Sat, 15 Sep 2018 01:30:14 +0000
Message-ID: <20180915012944.179481-35-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0741;6:6K7qKVg6PN+IDbDeHmf7f3B02UkgelELj1YIOhLc4VJj1/5QlEmlpsFIMu5ePzRJGaWD4DyKvuUmHgDKWB3gVcJNUr5qVVV9EpUqi00gn9eZ7tVwhZqF0yle0oo8BqOjXQcmV6q6smqvXU5KbOz0e1tmsvnTMVnySiXnuW+WxkTiz7pAhgOwfxucpfqsY/qJRvM7V54uZ5QZ5lTJurz9Ojy/nQc/69bSx00Hw5fqYbEz+bM/hMK4HNOgfDuq44FLFwd1RLVqnxQUEopNwB+V7bHaQkumyFfNJZyDNTVW/JtEzQ8vSfbY3Z3rIpep9GFjGLi1YaiaYCo+QgktOymgLQVsvDTTMhcznhb3GlexNOIZrsVPnMRQV36FLWIyeCNfpLN2woz40cUKIuSo4DJr9cGhCxhMr/YVJ7gV1uv2fCEZD004G0Y0cI9ygMUgVWOrEGgjQpBzrfw56I1NPxEqOg==;5:/q+le0v+rCJ/9pUWrb5lEGcdVA11dWWMU2LjOV9XVSEIX3mgTI8XENQcWmisvMM+HGiEe2GrgUiKHRoEpHZ/UEe125zqoV+2VUY7AF0/+lFpjaT7zS7Gs8Ac/uTBDMwn7/va6oo4ETp1F3grz/5FtU7T0Rgw/mPjz/Egw0+LKwg=;7:fdyNfVM1AC65MBqU3Mjmh1rFmYXOUS2FpyOorSVLHIJLVYUdJI2ClDdb1aWZcATvxxYgjw8KjSRhf3lxwubZPj7JrD2J0+n+6v8sWGuCV3Ah8MHcRXmh0Nclcq9DdPL34hq998JIOUQMQPUITB/PvRDU767/+R2fxII/19hX6ZRGhnfygD8rybolNTJ2JRswH35hHi67ubgDFzQOf85i8o250KH+TlSqWL9PRR00eLZV/5hpbe9tX9LuWht6MtyK
x-ms-office365-filtering-correlation-id: d26ce31f-6c9d-4bf7-7cad-08d61aaadae2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0741;
x-ms-traffictypediagnostic: CY4PR21MB0741:
x-microsoft-antispam-prvs: <CY4PR21MB0741A167D5C9BC1016652DB3FB180@CY4PR21MB0741.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(82608151540597)(109105607167333)(195916259791689);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0741;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0741;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(366004)(376002)(396003)(346002)(189003)(199004)(186003)(106356001)(25786009)(6346003)(6486002)(6436002)(476003)(102836004)(11346002)(5660300001)(2616005)(26005)(217873002)(105586002)(486006)(446003)(4326008)(53936002)(5250100002)(14454004)(10090500001)(14444005)(2900100001)(256004)(6666003)(2501003)(10290500003)(6512007)(22452003)(72206003)(8676002)(478600001)(110136005)(97736004)(68736007)(66066001)(81156014)(81166006)(2906002)(99286004)(86362001)(86612001)(575784001)(6506007)(76176011)(8936002)(6116002)(3846002)(1076002)(54906003)(305945005)(36756003)(7736002)(316002)(107886003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0741;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: PkU8LMgfFWPlZaY30GmhDrO1r3pj9ntYL1KOUsKdCK6rLH/rhCk1dCovJXUxAYl7RtH6IWg0+2z9OomaNtXBRlbi6LneNIDNw6SlFX2ww2L3wk6hXetQAutDinj9norG1ZIQPSB1p/IKi92pQS919QocNCcU9G04wFSIX81GzoqxRJqCp0k+BRC9WVaoU57zqpdta7uvGUhGsFEz0BWHa5Qf2cSlxtxAbxfJm4kT4+L4/z/qo55LGSLZH7tvV2/J/bHlva3+Qnm32x+HIDnIVmntFSrZnZIrMcR0j5+bkr86cW/S6Xqe1DNuDTPB1ZH4vzpCi0nSxEWOW9VmtEosvmZDyJRk6XT8sJB3uIlBFu0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d26ce31f-6c9d-4bf7-7cad-08d61aaadae2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:30:14.4169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0741
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Sverdlin <alexander.sverdlin@nokia.com>

[ Upstream commit b29330d829042512fabb2bfa3bbfa32df1115594 ]

Don't dispose IRQ mapping before it has been created.

Fixes: aa9594740 ("serial: 8250_of: Add IO space support")
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/tty/serial/8250/8250_of.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/82=
50_of.c
index bfb37f0be22f..863e86b9a424 100644
--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -124,7 +124,7 @@ static int of_platform_serial_setup(struct platform_dev=
ice *ofdev,
 				dev_warn(&ofdev->dev, "unsupported reg-io-width (%d)\n",
 					 prop);
 				ret =3D -EINVAL;
-				goto err_dispose;
+				goto err_unprepare;
 			}
 		}
 		port->flags |=3D UPF_IOREMAP;
--=20
2.17.1
