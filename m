Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78ED9C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28C69204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="diXpUzpZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28C69204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729038AbeIBRWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:22:51 -0400
Received: from mail-by2nam03on0097.outbound.protection.outlook.com ([104.47.42.97]:54080
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727712AbeIBRWu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:22:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EYxQ4OPMS6X3es3lBXf45tD6hy3kV6htJwXZAgdYFxQ=;
 b=diXpUzpZ3+gqawutc9pghHHk/YNs6DwBf5hVqPvi2NQXhrPhDez5FJiWm+g/VZYPehfFSl3uf9aJUfYxgTBKwhYO+UnjpXS5Nz2btqO/2K85xn/GTQKiIpVb2+cehinIrVKQE6TCqZyxHj2lL2Jh9Hf4QXKmXOogAgitiDzaqIg=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0856.namprd21.prod.outlook.com (10.173.192.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Sun, 2 Sep 2018 13:07:03 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:07:03 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Dan Carpenter <dan.carpenter@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 21/89] uio: potential double frees if
 __uio_register_device() fails
Thread-Topic: [PATCH AUTOSEL 4.14 21/89] uio: potential double frees if
 __uio_register_device() fails
Thread-Index: AQHUQr3F54PmiUNsPUykDxNs1zUWIw==
Date:   Sun, 2 Sep 2018 13:06:33 +0000
Message-ID: <20180902064918.183387-21-alexander.levin@microsoft.com>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064918.183387-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0856;6:lvyX373c7SxHdJluoYS3e8ROvTEVQNGgTkeIPMFNo+/lJsbeP71E8vP2n0RVvJ1c+gHoW5EeMmLPEQlCRFeJTVBV0uLBJxvpoHaUktRDBMZcQal4igAi0JfBOW/UKuWd8pG+ty4b+XNYTqjc3dGZllFvWkndx85sxZxFjSn+OW/7pf8ghJQQM7gjoGOfIYtSgXvz9FPdsAKD1YEh1UGjBdCTqhkhGVzSt3Dcgbt3juqeZH6AR5u2EPU/C5UX9pKsgc2/xSerf2xSi5NLl+zqJ7qo4ZyRyl6xZjAW9l+BLyceKniVZbO/zDimQ/Yb+W/LWvvB/e9tmyRB3MEFTmhDlCIUWxZNpV2n93QSq/JXzdumLN9Oe3TwQHbMr54OJ7BC1yDXbAc6vCLDs67JkO8PJw1B5xbejddp5wBkM3zPkYsmjJyE2kycy6/yQ3KHtpHpFhUT5BwQVz5dkfPRHvL7lQ==;5:up8W2MSo3fFy62QdtI9soMeAUmDGIlmfF2rK646l8Y1OZZIiMRS7UgyY1m7Z4hzQwJlsaZ8Xn3yqj6IYk8mvCcLthjEqlo5XbSbbpfX+Qc33GG9LCzlf/aJ8kbhXp+yQsvLXoVU3Xg2BdHs/TsbDjIJNW9RWKvhFD9Ek690mC3s=;7:1Vn3jbkIRtUKhiEwHV6ib6+yeZJ4kxzJsE3mQetWMZ3jBsgCupGxXwSNyzLKfzFqrJkn0GyodwGPGLIIXE+KGRst3lKEJg83dLGVacqmEhE9m/TfEDCs1JgqWYuFz+MKXSta63ymijyrkiew+tFgrl+5wKoxCbe48c/427UxlOlTiwDEYZlZhZ/wb4ycroUsx8YuF5sfyKajmr8wB9Vm2c1dFrPjciSFBxNH7fLrAWMojMWhRJS4o2eseuTr8fK5
x-ms-office365-filtering-correlation-id: 90d48782-c05b-4833-baf3-08d610d4fa23
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0856;
x-ms-traffictypediagnostic: CY4PR21MB0856:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB08560293B090F873B781520BFB0D0@CY4PR21MB0856.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0856;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0856;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(346002)(376002)(39860400002)(366004)(189003)(199004)(53936002)(81166006)(11346002)(81156014)(446003)(476003)(4326008)(5660300001)(25786009)(86612001)(8936002)(26005)(6506007)(6486002)(102836004)(2616005)(86362001)(8676002)(6512007)(14444005)(6436002)(107886003)(66066001)(256004)(10090500001)(217873002)(14454004)(3846002)(478600001)(1076002)(72206003)(6116002)(99286004)(305945005)(7736002)(22452003)(36756003)(76176011)(105586002)(486006)(106356001)(2900100001)(186003)(97736004)(68736007)(6666003)(316002)(10290500003)(2501003)(110136005)(54906003)(2906002)(5250100002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0856;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: DS7CV8A+kU7w9ANckz0Vx9/ScJAP3EiSpjMb5JsZVVpdYgOGKgPb/46Vjzc/SmGGEFjwGtvOS9f4IhlnrnYFFsRgiiX7F5GvRo5l2cTxLSwnOXOOQVyG34a9msnk7E0NeKlnsK8zCFb2ybXqMPFgr9bSrT97ZCUIBSTncaGbW938uu3fx8HI05rlaI4bajSQx7OjyXsAgwVLrUaSha3UcKdu6H8vRlubUZWJ89sFuRQWwto2oTY6WnLXpRnDg1hS2xUjFwzvsznqhkQu8Q0fU/Mn+KcRybgAnsTSEm/s4lOrq5JShEw5Ls6WNa7mQwmylaYpA0TqmLW5SYVk1ZF/c73ziMxUe0Hh/+zIpf+Zw9A=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90d48782-c05b-4833-baf3-08d610d4fa23
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:06:33.8233
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0856
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit f019f07ecf6a6b8bd6d7853bce70925d90af02d1 ]

The uio_unregister_device() function assumes that if "info->uio_dev" is
non-NULL that means "info" is fully allocated.  Setting info->uio_de
has to be the last thing in the function.

In the current code, if request_threaded_irq() fails then we return with
info->uio_dev set to non-NULL but info is not fully allocated and it can
lead to double frees.

Fixes: beafc54c4e2f ("UIO: Add the User IO core code")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/uio/uio.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
index ff04b7f8549f..41784798c789 100644
--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -841,8 +841,6 @@ int __uio_register_device(struct module *owner,
 	if (ret)
 		goto err_uio_dev_add_attributes;
=20
-	info->uio_dev =3D idev;
-
 	if (info->irq && (info->irq !=3D UIO_IRQ_CUSTOM)) {
 		/*
 		 * Note that we deliberately don't use devm_request_irq
@@ -858,6 +856,7 @@ int __uio_register_device(struct module *owner,
 			goto err_request_irq;
 	}
=20
+	info->uio_dev =3D idev;
 	return 0;
=20
 err_request_irq:
--=20
2.17.1
