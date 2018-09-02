Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C73CC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E4BB2077B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="KJm4bvqO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E4BB2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729023AbeIBRWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:22:51 -0400
Received: from mail-eopbgr680114.outbound.protection.outlook.com ([40.107.68.114]:16944
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727487AbeIBRWu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:22:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gqwB6XGOcGnNpMaje7n/PF+XKnd7MrjnV+t7a37U0jA=;
 b=KJm4bvqOODM2hVsPt+uimg3lI96hMn0wO7matb/W/dvt0s5M+ON+zKdyLnXXztjI5m5LIbTEJRq0A+yyp8oSuD3CeEAq+MVtSCL7XYo4Zwrg+nm3u3ylHUrPMCXhC98d496Tyv4H1BnTDyFIv4vcIcZsUGtVxvIqByBDI+fzggA=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0629.namprd21.prod.outlook.com (10.175.115.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.7; Sun, 2 Sep 2018 13:07:03 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:07:03 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Anton Vasilyev <vasilyev@ispras.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 20/89] misc: ti-st: Fix memory leak in the error
 path of probe()
Thread-Topic: [PATCH AUTOSEL 4.14 20/89] misc: ti-st: Fix memory leak in the
 error path of probe()
Thread-Index: AQHUQr3FyuTggBE3vk2AFZGnwyav+A==
Date:   Sun, 2 Sep 2018 13:06:32 +0000
Message-ID: <20180902064918.183387-20-alexander.levin@microsoft.com>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064918.183387-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0629;6:UEnrvyo3a9RUupfuHHWtHlj+CirV4lPJV0SeW/wZqAvhhSqQ47LrIXFGQ5LeH4aSN4gv9QukPDhp0FReRao5OGtHIYBuDUEyTzkeQAEoB0Y140utc8aEUi9psl/2FTK7fmWco2rms6Cotyao+r4cZ7tkRG5y0yK4t0C5Z+Dd6I+pUFhuvHDG/6GmYKoEFGSUSQGx8iXWCBaJ5IjP6eUSyUUBscagQQfFw9pOp4Mg5E6ySjQmGWDunpHzeMsqJE6rs4JkWxqb62vn3rQrbW/8JsM8YLF30F4oEPoMamWwRj7WT7aPh9hvrOByKOYvDioLUUScd3DFaLjYGJHoSnBjBpm5e344feiNydLBlQqgGifgTVOSOEgITZv7G5wPYneq+R0Mr4adyqH1A7Ta9LtnmySL8gIUpn5ktx6TgVXssc/T5LmyHzgTpvpa+djxhG1VTfqmCw2Box9B/HfjKGk95Q==;5:1wjd0fSQPxYX4wtu/Tg0HSXdrpslh+EnoBiaALWrRgOhuqqi5cMaV0Z6M+5/5O6YZbkMfIOjfG6NzMRh0K9McRByDPF5cCOhPQdHIzk7JWIu6vsvBgfJeTmBJFqK6BmAPufHIRQg8cn2tsKi7SeXceRth7C8o3NlebjkYsXwW2A=;7:ctIVTqsdXUOR0ETaazzqDjiWHlXwZvflleyKyRh9U1NagnLLlYUMCzTbOx1gTZ8HCbmZ2yhQSg5l8s7xL77Co5v8mvW5XOglpB2NBU8/0ZzlaQ4siGyRrIdCnYNI5kttkYhhmgnrM7leJ89TWpJ4XWy2b5WF82Mv+gimkevHfvSCF6rlkd1Y6XlG6O2rxpzSAdKjMYWogJ0DKbbnHoTl7E7Ncvi24sc+BDdUn56AjigYySwKzQZVgz855qyciVf8
x-ms-office365-filtering-correlation-id: 6a09f911-a5f1-4317-2fb3-08d610d4f9e6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0629;
x-ms-traffictypediagnostic: CY4PR21MB0629:
x-microsoft-antispam-prvs: <CY4PR21MB062931EA9E411F888559CDACFB0D0@CY4PR21MB0629.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0629;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0629;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(136003)(396003)(39860400002)(189003)(199004)(6486002)(8936002)(6512007)(22452003)(53936002)(6436002)(66066001)(4326008)(186003)(25786009)(86362001)(2900100001)(107886003)(76176011)(486006)(68736007)(36756003)(99286004)(2501003)(6666003)(5250100002)(110136005)(54906003)(106356001)(316002)(105586002)(10290500003)(72206003)(10090500001)(8676002)(478600001)(14454004)(5660300001)(476003)(1076002)(3846002)(305945005)(446003)(6116002)(217873002)(6346003)(11346002)(97736004)(81156014)(7736002)(81166006)(2906002)(14444005)(4477795004)(102836004)(86612001)(26005)(6506007)(256004)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0629;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: B59KxU1cPMjIclIf97IOe1BCam8iDp5mMPc+bybA6Dq5Yk3zIg7KUMWrr5SQddyAZlFreYNpgsLPZRK1oSFW8FQyRjytidPWD1VUdGqM0khEK2zfwj+XFIDXG9kAXwWvX4IlBb08oM981hgOsWnb+RlZh7Tr2uk5IRH8Wp8wbRinK7iM/XY1Y4Cvn8yi+LOihzrjsXc43TPeeJLZsVn1j0gTc8h3mbYOuFS5P2S2Iq1B5zR3WNWaWBPxMoY7CIa+fkBpaDEfGAfshGWLHmNhY//mVoSvP8LW4MbUwEa6zDfMBp/PM5NEEcia62+Kaz4NHAb4dqBE1SjYpbkRAEtYYJcp19yIq5x6Xm6mFbFkW/Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a09f911-a5f1-4317-2fb3-08d610d4f9e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:06:32.7885
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0629
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anton Vasilyev <vasilyev@ispras.ru>

[ Upstream commit 81ae962d7f180c0092859440c82996cccb254976 ]

Free resources instead of direct return of the error code if kim_probe
fails.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/misc/ti-st/st_kim.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/ti-st/st_kim.c b/drivers/misc/ti-st/st_kim.c
index b77aacafc3fc..dda3ed72d05b 100644
--- a/drivers/misc/ti-st/st_kim.c
+++ b/drivers/misc/ti-st/st_kim.c
@@ -756,14 +756,14 @@ static int kim_probe(struct platform_device *pdev)
 	err =3D gpio_request(kim_gdata->nshutdown, "kim");
 	if (unlikely(err)) {
 		pr_err(" gpio %d request failed ", kim_gdata->nshutdown);
-		return err;
+		goto err_sysfs_group;
 	}
=20
 	/* Configure nShutdown GPIO as output=3D0 */
 	err =3D gpio_direction_output(kim_gdata->nshutdown, 0);
 	if (unlikely(err)) {
 		pr_err(" unable to configure gpio %d", kim_gdata->nshutdown);
-		return err;
+		goto err_sysfs_group;
 	}
 	/* get reference of pdev for request_firmware
 	 */
--=20
2.17.1
