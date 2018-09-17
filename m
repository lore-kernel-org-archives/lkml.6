Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CCFECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80680214C3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="OzNNppfx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80680214C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730116AbeIQIua (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:50:30 -0400
Received: from mail-cys01nam02on0116.outbound.protection.outlook.com ([104.47.37.116]:31712
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729937AbeIQI26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:28:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iTXY44Ri0xiPNRzuW7lQb7ENx3qssX0Wgf3iHaZjpBk=;
 b=OzNNppfxbWU78A+8h1CYDVSYPjcazbA6HEhM0gIshXdqNUVnfD06rzgIAKsoUEQpmyLRgsKGex6/SXHV4GTy0vUALr1Ls8ESGUB3WjTddFcE7PXY/skGa+oTgB8iuGglTmDyOUpROBx90jQX0zuXTcxARZKUYRlguE8yCDByBKQ=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0118.namprd21.prod.outlook.com (10.173.189.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Mon, 17 Sep 2018 03:03:22 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:03:22 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 130/136] iio: 104-quad-8: Fix off-by-one error in
 register selection
Thread-Topic: [PATCH AUTOSEL 4.18 130/136] iio: 104-quad-8: Fix off-by-one
 error in register selection
Thread-Index: AQHUTjK9SON0V30ZHEOqvFc3ckAl4w==
Date:   Mon, 17 Sep 2018 03:01:33 +0000
Message-ID: <20180917030006.245495-130-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0118;6:qT5dE2geXnLsKues/otKLSIo/YPwyhr41SSsWlkQt3RKx8hSwvFC5Ccv+3qdc78rBh1n3VHbAwJZPVYmjrvoS6nO93VkxHS9b80YSyfZoFJd9ctEN5dkm/vK6IY1GtdoouXw+/vz0Gv83txI703Vd9SOQjOgEwXuKIRKVTli2E0Wgq+NVddn7XJ9I86tMwRjZP6Q/fUU8Luh7x1VYiHCn9HX0vGqfTbNJJp/QmSm+4FuCqPztfIdVNe3ya/dZCVCWG6TbVH3ezFdfe2YaiQm/BbIOVncqv9da0fQl82Chv1YSJ2/41pfrAX7EGT+iqXF90n6u3GGdS8+wszw3uSgqr27Wt1/dMopKVNn+usE5RWP7PazNxYJoJlkzLhgfAMi+rWP9TNizlqH5WQWxmEjVIX0jOrvqJf8Wsz3QXn+55DeARg4d6ILddWIdCMIvij9M1APirHHTqcHdck8oh6xRA==;5:9gF+wR/6SXt4NBITE1lw5/KTKO//fWoxVvFbWyuhJh9TDLP/B+cbMtNZLaAWaRXksWT47fxAG4UOOfp1eK0/CwxJBlate0hP870fA8EPOeF1Rm9oGkun5MgjBA50MLNZgB9VXXKxhDoKBPG57MjoygoOoYXsy7GXOAgjMe/U/04=;7:nprcT+2MfcZIJQBWldLQoHJrbOtoR38+Tw3kUXyEQifjci5iuQFrL8NX0eQWNlWVkRh/2LCzyPlqWpKKbh8eifbwHsb0uFviith5vXJCXgILtpZfSyU4zvZuQRfK33XkOr+c7Mr2FaOc0xv6CMiPffYTCYbcwta5faqXt1pM9ZPYJ8nGji8+jtGQoyGEyRyKdE70Z+SQjKYPu7YDss9MkJhPi8v98kzW/yetPUIvMCZw1Wjl8DeZeBO2lJohYMoI
x-ms-office365-filtering-correlation-id: 5251f0b0-7331-4358-22d4-08d61c4a2130
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0118;
x-ms-traffictypediagnostic: CY4PR21MB0118:
x-microsoft-antispam-prvs: <CY4PR21MB0118C785172183C47B3C6E48FB1E0@CY4PR21MB0118.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(50582790962513)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0118;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0118;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(396003)(39860400002)(376002)(366004)(199004)(189003)(2616005)(186003)(8936002)(10290500003)(66066001)(97736004)(102836004)(36756003)(5250100002)(256004)(3846002)(6116002)(2900100001)(476003)(2501003)(14454004)(54906003)(446003)(217873002)(110136005)(486006)(11346002)(6346003)(8676002)(575784001)(86362001)(26005)(72206003)(81166006)(81156014)(86612001)(14444005)(478600001)(25786009)(105586002)(2906002)(99286004)(68736007)(6666003)(39060400002)(6486002)(305945005)(7736002)(76176011)(6506007)(6512007)(53936002)(22452003)(1076002)(4326008)(6436002)(316002)(107886003)(10090500001)(106356001)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0118;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: zkLSvxgpE5oirfd+6QJxuMhiIqx3im16bxmvKAmcn4Lob/1wE7PWYyUxL+g28DkSSAlzt4JdiyBb39Y/opn8S6LF3Gcp3+tRnyQ0498U1jaJm6CFUM7g1bNAWeLAVS2VCrzgIFpZBB5E6tA5lJCWEUuP7FynxPOg8hbO4zMLCrLMYycYalIhHh+9XZnw+yGctQz97hJW20fYw2RHD+aOa+e8ABHayZPC2UvnTeB9mVF/1Ej0jGcJxX6j6N4TwP2h+Rn2sbOkMrfiP4Q9ih/AKCcSuKtUHNncdk2t28Qo2AOKdlfd9IYVn9nJ9r6grzkSaIF/QZ+YQrzaFnh3zGokIt36KAadyIymtCEVAB/bxww=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5251f0b0-7331-4358-22d4-08d61c4a2130
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:01:33.6508
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0118
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: William Breathitt Gray <vilhelm.gray@gmail.com>

[ Upstream commit 2873c3f0e2bd12a7612e905c920c058855f4072a ]

The reset flags operation is selected by bit 2 in the "Reset and Load
Signals Decoders" register, not bit 1.

Fixes: 28e5d3bb0325 ("iio: 104-quad-8: Add IIO support for the ACCES 104-QU=
AD-8")
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/iio/counter/104-quad-8.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/counter/104-quad-8.c b/drivers/iio/counter/104-qua=
d-8.c
index b56985078d8c..4be85ec54af4 100644
--- a/drivers/iio/counter/104-quad-8.c
+++ b/drivers/iio/counter/104-quad-8.c
@@ -138,7 +138,7 @@ static int quad8_write_raw(struct iio_dev *indio_dev,
 			outb(val >> (8 * i), base_offset);
=20
 		/* Reset Borrow, Carry, Compare, and Sign flags */
-		outb(0x02, base_offset + 1);
+		outb(0x04, base_offset + 1);
 		/* Reset Error flag */
 		outb(0x06, base_offset + 1);
=20
--=20
2.17.1
