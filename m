Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E461EECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8832A204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="BQeLY7m1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8832A204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733210AbeIXVNR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:13:17 -0400
Received: from mail-eopbgr720093.outbound.protection.outlook.com ([40.107.72.93]:21257
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731121AbeIXUuv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:50:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JWgM28euJsU774ZA7F+Tztdujt/r631JH5+5xebm+X0=;
 b=BQeLY7m14WtIXnObbia9AW02bDYETpgVwOZDOUmOLoVbJo+AQB2fIrRuHfE8WoYB+HLX32oVxUqROnG1YwGlr7OroD07vsD6TNfCPQYi9uQGQ9y2pZeyhNYft1+Ig0wEkvJd0TWadJnuNet2tlkI6i7d9m/HL+ZTmD7KDDIFWFI=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0821.namprd21.prod.outlook.com (10.173.192.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:48:15 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:48:15 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 24/76] gpiolib: acpi: Switch to cansleep version
 of GPIO library call
Thread-Topic: [PATCH AUTOSEL 4.18 24/76] gpiolib: acpi: Switch to cansleep
 version of GPIO library call
Thread-Index: AQHUVBWglkbRp7G+vkmQHrTIUWoMnQ==
Date:   Mon, 24 Sep 2018 14:48:15 +0000
Message-ID: <20180924144751.164410-24-alexander.levin@microsoft.com>
References: <20180924144751.164410-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144751.164410-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0821;6:FHWqAyqQ3SnCpbKmXyaDD7sZle5fni6bMj3dLcSLlDsZS2ma7R14D8IXYxg1d6G2+WT2+4D7yMrY0wWCdSIUhCO8RkRYj+pWYtwGkoUyhuT/SXuYl4JGW4ispjYByk5/UDUIRobo+LBJtmKMKk2wyRuZRDB9aNBCVoAkyGu9VmPLJMGVW1XnjTfmraVki0qWwuZrqlqBlh1YH3JdhOu5VFDZn17pJfb8076oL+QlI5VuXUfNVtCKWaBF889LdaZchVsv2PmoOPuTKiMTGaovD3L1FsZv/v1gqTMPBojs3Mt0Xr5B1+2hbTGFt8I4PHJFIkhuzoxwwShnbx/GydYhbO4vv0qb+nTSOv/WqkEsJ9aMyV2eLwpSs52c7P09XVQGMBMJxJQDBCLIhpmV6J1UTsas1GheDVS/J5BCqNapaM0W0JtfqLdKgnPzQNbYQOF7gyHMy6vRHsg8VyDtXgiwOw==;5:2/rKNbP5MDzmMdkABQVmdpQwLCzFrDqDLICitfQ46bS1fiikdfHw3cNUyYv0A3wjLtmI3iWu52BvVXlyJFCRFhDACOZ/reYPDhnZilLShVEVU3aGRGwUbcNIvWhuRmRObhjVp0QC/uZOec2DPqOybYdwojNcK5ixZ++/7iaObwo=;7:rhuDk3LyrNxLG66ccH2L0RNBim/2mmMBZgS+IqqklP4l8Osj9RazZM0lt7sg/dOw9qQIGxGaqIQ9ZHvD8Dl2KsEYiPKa/MBrX6IeMOerC1iA0XRDu55jiLok0Sl1CBIoPJyz1p8ll6/DrxCJ1LgH6+E4viYeg5zyq4X5MOyZJB9Dp7u2orc7IZPj/Ujli3R+G783folQ9jcXMc8CXNhZq9dLkbTllXQCwgQOndEOuC/jdfZD1/pPp4YxiS0d4rsB
x-ms-office365-filtering-correlation-id: 6d9d9fdd-608b-4047-dac6-08d6222cc290
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0821;
x-ms-traffictypediagnostic: CY4PR21MB0821:
x-microsoft-antispam-prvs: <CY4PR21MB0821CA2AFBA57796DD8618FDFB170@CY4PR21MB0821.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(28532068793085)(89211679590171)(12401385986421);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231355)(2280196)(944501410)(52105095)(2018427008)(6055026)(149066)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0821;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0821;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(136003)(376002)(346002)(39860400002)(189003)(199004)(2900100001)(86612001)(81166006)(81156014)(8676002)(8936002)(1076002)(4326008)(25786009)(3846002)(6116002)(86362001)(99286004)(486006)(76176011)(54906003)(71190400001)(71200400001)(22452003)(316002)(106356001)(105586002)(6346003)(478600001)(10290500003)(6506007)(26005)(7736002)(305945005)(72206003)(186003)(476003)(446003)(11346002)(14454004)(2616005)(110136005)(217873002)(6486002)(53936002)(102836004)(5660300001)(14444005)(256004)(6512007)(6436002)(107886003)(66066001)(97736004)(36756003)(10090500001)(2501003)(68736007)(5250100002)(2906002)(60540400001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0821;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: T6TAHZji1CLwM0kPjpKOPU7Ri18hFj2EMO1qq79Nm3NHbUSjaxmhoPfQEimUMeXd75ybwgF8gCm9kba3Yv9+1hIVlYg2TIBYyrHo8Zv0DKZ8hneMmuwXY1AcEIuNuJ4lSZ/I1kQcj1dk2UiWhHvfn2IMo0a5xcqsQp/UPO2jtmflKGMTi2UuOErAz2HoMjnS/hY2H/arY6HRV4QjROTX0LEi1G0c+rzahdnrlHCP0FD1LaoIlWq6RjBubG+5P06ZN1/4NVwCtbVk0PoiobXu8pMYSkb3JRNQJhYZ9do05RWHJQ0eIpXJhwWMXRcIBdsEPZpqikbNVe3Qe4lVWvNsgbNl57oNl34EemOHFkh/HQACea5tOjPDCum63qXaCgTOX8DViDfqXzMhhFTbBFHuRptV2q7z8BHDbkJsmV67CQT+Kcm0SAMv9fzouxnu7Ofwl9cObm0bd0xZg2nO4sozuvz5h+R+ohx/OqfAwRHKi0aA/5Q3UvhwAVs1Ov973zwNARZtRkQ3mhec98lpZPNFHZBr00qsjWUuSlTV6IwuZhLul/c0G6gVc/cxH+DJkS00
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d9d9fdd-608b-4047-dac6-08d6222cc290
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:48:15.6561
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0821
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 993b9bc5c47fda86f8ab4e53d68c6fea5ff2764a ]

The commit ca876c7483b6

  ("gpiolib-acpi: make sure we trigger edge events at least once on boot")

added a initial value check for pin which is about to be locked as IRQ.
Unfortunately, not all GPIO drivers can do that atomically. Thus,
switch to cansleep version of the call. Otherwise we have a warning:

...
  WARNING: CPU: 2 PID: 1408 at drivers/gpio/gpiolib.c:2883 gpiod_get_value+=
0x46/0x50
...
  RIP: 0010:gpiod_get_value+0x46/0x50
...

The change tested on Intel Broxton with Whiskey Cove PMIC GPIO controller.

Fixes: ca876c7483b6 ("gpiolib-acpi: make sure we trigger edge events at lea=
st once on boot")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpio/gpiolib-acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index addd9fecc198..7da51b5186c0 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -186,7 +186,7 @@ static acpi_status acpi_gpiochip_request_interrupt(stru=
ct acpi_resource *ares,
=20
 	gpiod_direction_input(desc);
=20
-	value =3D gpiod_get_value(desc);
+	value =3D gpiod_get_value_cansleep(desc);
=20
 	ret =3D gpiochip_lock_as_irq(chip, pin);
 	if (ret) {
--=20
2.17.1
