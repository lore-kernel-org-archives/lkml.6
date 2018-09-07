Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4064C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80F652083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ng0qEkhe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80F652083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730684AbeIGFSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:18:53 -0400
Received: from mail-bn3nam01on0093.outbound.protection.outlook.com ([104.47.33.93]:60384
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730641AbeIGFSw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:18:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ETxQjfqUdzO/sf9TlUNkwDki0ibL41sgAtQPO4pcFl0=;
 b=ng0qEkheJZe0eL41w4kwze3A5aZib2o7wnZIhJpnDMEvswEroc4ktkof4DA4dX6tvWqOXxSHRh09vOHe6PDQO8gIPXkgIVnG2LDeJn5zMa3Mu/fgIl7ItuXUraZNKpoErrFUVWjx73E/TW5/U2Q5OIp0SkxRce6IOfLpyupoCFw=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0855.namprd21.prod.outlook.com (10.173.192.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:40:38 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:40:38 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     YueHaibing <yuehaibing@huawei.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 05/43] xfrm: fix 'passing zero to ERR_PTR()'
 warning
Thread-Topic: [PATCH AUTOSEL 4.9 05/43] xfrm: fix 'passing zero to ERR_PTR()'
 warning
Thread-Index: AQHURkMUx6HVWbzcRkuP+Ae/ETQw2g==
Date:   Fri, 7 Sep 2018 00:38:22 +0000
Message-ID: <20180907003816.57852-5-alexander.levin@microsoft.com>
References: <20180907003816.57852-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003816.57852-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0855;6:c4gL1wWan1X7lith7VHHYRbVeruiT5iTHF1O890kDHy6yuUQe6A5CTcVqnx9Md8UzSWcin2mFOhNeTm/zOy0BRU4mUz7eqMMH0r0h855ShhnDevrZ1Mv55GdPICQSOe+InBBXHm4JjupURrxTvl3cq031s4K043W+lwpzeSKkNcHapJ2H7izXrqc3V6oqKtrYqoHFF8FDv4PtXZiOYszi5tcu+IhAVbCVRbc0Wj9Dkv8sJhLqCDB+7lIW4WW9QF3W9YlcO/CyOjxItV4NROsqVurptv4YrAFSbAQB5oDIjc16Yt5Ugq0wU5DCVJGCaNOZe0O+xp1pMGc6rMzSTo9BHEkqtZZIoUAY6gRvXjwyf5NonJxEfTT1IQYEH32hLk7efiqQG7Q9HX1FyfJtg829S9WPFmcykmwD5H7rSaytSDs4gDW9jdw33g374Yj2R6RKs8Tb/1NZpwpKEgfZ6ngHQ==;5:aMeid82w1UfGB+sLpeZqXAzERv8yYvdqnLC2CndLUutrpZUK0Hsc9pdtraT0f4Uq30FawXfGkcVl+Tsp1nRsHSz8OqdNI0CPFHGCKwm4uYa5/IFp+D1GBXCzdkzseOuuLyE0sLKU2Qvhk4xRCmHnZFJ348fcJNJUHruidY/Xn5w=;7:DKr0coobcM7jrB6pc7yuGXD072wLAcVXRnD9J3FrcCavnHWG9DxNDegD+pLt822mE5tswwubeiFmXnkUWWBqzLJUWTPmd2Ew9aRP1D1R4CzUT8jkHG2VcCANWuyjsvWgNRsaAsIY+ecTF1cIcC5Z5oUV9RTG488U27JdVUNX3gVYaBJcUDoatJdGoKgHW3fiIZFkOo28/ghYhiWML7hoqAoPkP0FW4Xx+C0kaohkoI7I0kUEMhxmcyIPwW/h6Sx5
x-ms-office365-filtering-correlation-id: 1e72f70d-beb2-49f5-3b81-08d6145a884b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0855;
x-ms-traffictypediagnostic: CY4PR21MB0855:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0855B0FE1552FAD51330897DFB000@CY4PR21MB0855.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0855;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0855;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(396003)(366004)(376002)(39860400002)(189003)(199004)(53936002)(316002)(97736004)(2900100001)(86612001)(25786009)(86362001)(575784001)(2906002)(6512007)(54906003)(107886003)(68736007)(110136005)(4326008)(81156014)(10290500003)(14454004)(8936002)(66066001)(81166006)(8676002)(3846002)(6116002)(478600001)(72206003)(7736002)(305945005)(1076002)(106356001)(105586002)(6506007)(76176011)(10090500001)(6486002)(99286004)(256004)(36756003)(2501003)(26005)(186003)(6666003)(5250100002)(14444005)(6436002)(5660300001)(102836004)(217873002)(476003)(2616005)(486006)(22452003)(11346002)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0855;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ATvEOVlxQ+v3xPqRXOlXeGU11ixoari7WzoJzDemHH/y7JXrSwhGSMQVjzGSGIodTBIMeZPnkC01IpQHcyB2KCpoVK/0pG0uGowZSSC5ruC1zR7x1rmuoA3DicLTbP7fPjmx59755tHu3mztYk++0WmaxGOFmpUqiz/y/Y/SMzLDEth9mf9cWyJm607kkS2YVfWfSLTRONcB+3uZQwFMpx8Bnv9XMZp0GAGqqjlE+6BVIi48+rSrKUsSL4FHztriOCaFajVVGCjsLBuMFBfhT6xA1JFtOYiMor9Om6tBXVKvqt68i8t7lU5OA3nrZBiB/v0EfzibXzughI7OBpV8UvEo8CH7gdNd8xR6hkcZkng=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e72f70d-beb2-49f5-3b81-08d6145a884b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:38:22.4947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0855
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit 934ffce1343f22ed5e2d0bd6da4440f4848074de ]

Fix a static code checker warning:

  net/xfrm/xfrm_policy.c:1836 xfrm_resolve_and_create_bundle() warn: passin=
g zero to 'ERR_PTR'

xfrm_tmpl_resolve return 0 just means no xdst found, return NULL
instead of passing zero to ERR_PTR.

Fixes: d809ec895505 ("xfrm: do not assume that template resolving always re=
turns xfrms")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/xfrm/xfrm_policy.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 5b8fa6832687..f02fc03dc964 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -1873,7 +1873,10 @@ xfrm_resolve_and_create_bundle(struct xfrm_policy **=
pols, int num_pols,
 	/* Try to instantiate a bundle */
 	err =3D xfrm_tmpl_resolve(pols, num_pols, fl, xfrm, family);
 	if (err <=3D 0) {
-		if (err !=3D 0 && err !=3D -EAGAIN)
+		if (err =3D=3D 0)
+			return NULL;
+
+		if (err !=3D -EAGAIN)
 			XFRM_INC_STATS(net, LINUX_MIB_XFRMOUTPOLERROR);
 		return ERR_PTR(err);
 	}
--=20
2.17.1
