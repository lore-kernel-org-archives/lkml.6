Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7FCC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7944C20652
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:16:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="mBxCk5Om"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7944C20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729228AbeIBRb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:31:59 -0400
Received: from mail-cys01nam02on0104.outbound.protection.outlook.com ([104.47.37.104]:45376
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730142AbeIBRbo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:31:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nbnttG/PRVHtQEgfO4gYuGGd4LCFlB8eXQaZBk8dGwo=;
 b=mBxCk5OmRzBCEIkmO5rHpH3Grd0G+caKcaaml34iD2dzCJM4okH7TyNorY4x8V8DQUZIRil3VN6CBS4IgRDxi12fCCHuQa/CTJBLrGRwKFEOrMEO6ksPA7qCtTrnbvx6sQtyrvL5QogU3sPljFpbiWq1iF1ej0IrFGfTakMAnho=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0184.namprd21.prod.outlook.com (10.173.193.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:15:46 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:15:46 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Anton Vasilyev <vasilyev@ispras.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 08/47] misc: ti-st: Fix memory leak in the error
 path of probe()
Thread-Topic: [PATCH AUTOSEL 4.4 08/47] misc: ti-st: Fix memory leak in the
 error path of probe()
Thread-Index: AQHUQr8PLG3prom0N0aM+rPQk6W8Zg==
Date:   Sun, 2 Sep 2018 13:15:46 +0000
Message-ID: <20180902131533.184092-8-alexander.levin@microsoft.com>
References: <20180902131533.184092-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131533.184092-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0184;6:N6gjxi0QiMxRK4Xdh9PV2MwuHKjxC4gZZL4GFa7hRf9mB/c3PhxQg2eLlWP4lNhY+T4h7YT0EhjHC5XtmzZCQbpP6GY0JnKxrekf7MCbbcfxIykPtXuB/AErnuVMNEIWgsWkpvLIgTEelWdUkLtGsrbH8FHMuz9B0gBwU71AVU/lmlkSEoUmZxJB+noP3fF9V+8vQzVwpYm8FyEmsnLkbS8nbAEdj9gcVMWglcZfGnaSYdnFuxL40+HCdMQXd3pa4ZccL0ZCEJrZn+sdQrVjSkbnqdFYJ2HVYeP0JXWFsXWjq31Spd+Nh5FTsdaAqYc4KN40WLyk9xMzQ3Q+EbP1S2DMhvSz1bjCY3vArLmqr13Y9rzg5qIjx11v7n70ZvJoJtgVoA7txGgbVPEymbEjlp0M9DbmiH/DgZnVat8i18Ojqv08OjRIrZ148DD/jb/IxKWd82wjZYqAoAfW49EsOQ==;5:DJUxY+RScwFHlnHnOj8fKnwZyyW7QHqgV6aVy49XLaFXsoJJpJQbZ2KDPY9hi6twzhbYZFp6TE9ZBA/drMtZ8PHuQBTuhxBfq3vpY9QxrFtgLTanL5sNdUK5et9rDHwM+f2uxusgrR5YeUkOXSAUpkx9nTgx+FdZsyDf4BDVWr0=;7:KGLf8B3tarIEJKGmLOVmZMUNOZxC53upAz10jWt+yc2Jx0E4xOlXvtqY3/FDB8l2HlTlJe8EQdCMV+zYx1RRW4+YP+W9CWsC5OVjRzIy/0OMTQZ/RAEf7RTJn+zZVEbVa8jhj4GZvHqMRcDlEECJYo/k2TFIf2LOxcvmsZi1DiznMw3L0fLMVve5F/1Mv1CcS9AtbKltONXM7S+UNqBoxA/UvNBmCvAXgr9Nh+jEmJYCzCb7fzHqq+BUNl+nHgN5
x-ms-office365-filtering-correlation-id: cca7420a-1c62-44a0-5478-08d610d631dc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0184;
x-ms-traffictypediagnostic: CY4PR21MB0184:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB01845A1CCB1F3AD7D40DCBB3FB0D0@CY4PR21MB0184.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0184;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0184;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(366004)(136003)(39860400002)(199004)(189003)(2616005)(10290500003)(68736007)(476003)(81166006)(11346002)(2906002)(8936002)(76176011)(3846002)(6506007)(5660300001)(81156014)(1076002)(8676002)(99286004)(102836004)(14454004)(446003)(2900100001)(86612001)(478600001)(186003)(305945005)(7736002)(72206003)(217873002)(86362001)(486006)(4326008)(97736004)(6436002)(6512007)(53936002)(107886003)(22452003)(25786009)(105586002)(106356001)(36756003)(66066001)(14444005)(5250100002)(316002)(10090500001)(256004)(6116002)(26005)(2501003)(6486002)(4477795004)(54906003)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0184;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: USyb0+l+pxkD7W7BNKAnf1B4R8PMS5jWtv2QapNoWi800Cj3sHHi4G9/nNDphFi8JgMFEiEgR9WlwtDlnbMXx+Hh2z0aKlChw5mpJWR1raublABnp++/NdQ8V2R+LJ/CKbQMlUBBUwc4875CSnupwJPfyRTcin4EEoX6RuPdylr2Bb4EmS8Aj2JkdLd1kB/qUj89qv3dbr0KriBgOIP2vY0XVE7OBq0O/aguuruZc9+HbKZkyPJEACZIIZ8F17v/HqqvczaznylCIfqeBB5154EnSc0fjnmSDKMYiMDaLwVi4D47x8XjryBCXAfQpp5SnQkLHlk05lhTl94RUJfWk1cmPN/Z3N2KySNkqMy3Grw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cca7420a-1c62-44a0-5478-08d610d631dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:15:46.3701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0184
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
index 71b64550b591..a1bca836e506 100644
--- a/drivers/misc/ti-st/st_kim.c
+++ b/drivers/misc/ti-st/st_kim.c
@@ -757,14 +757,14 @@ static int kim_probe(struct platform_device *pdev)
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
