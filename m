Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F01BEC43143
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0BAC2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="agfkI2Gk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0BAC2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730846AbeIGFWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:22:07 -0400
Received: from mail-by2nam01on0091.outbound.protection.outlook.com ([104.47.34.91]:29984
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731239AbeIGFU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:20:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7sWCjeFtrA6FkZ8xRXCmytpzKxa6MYdGSY5wf2nOOdY=;
 b=agfkI2Gkjf+IdLNRYUqtI6Q59BfbB/KwvyeASdvmPPkqKDoU5RZKFiQh8xB4mQAT+4XSv061J/9AGNtDR44PMg41mmlogjTA6wtODzOAuJDl1cXHi4igDebJp+mcWJXq2IL4PfxIwnG/vctsy+AMCZPYFfEw/SJf2AqpK75BMyY=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0822.namprd21.prod.outlook.com (10.173.192.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Fri, 7 Sep 2018 00:42:09 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:42:09 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     YueHaibing <yuehaibing@huawei.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 3.18 03/19] xfrm: fix 'passing zero to ERR_PTR()'
 warning
Thread-Topic: [PATCH AUTOSEL 3.18 03/19] xfrm: fix 'passing zero to ERR_PTR()'
 warning
Thread-Index: AQHURkM7elfwoAoydE+cxIeqfyadIA==
Date:   Fri, 7 Sep 2018 00:39:28 +0000
Message-ID: <20180907003923.58019-3-alexander.levin@microsoft.com>
References: <20180907003923.58019-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003923.58019-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0822;6:Hgn2oMVV9+9xYJbDW7CMb81o4O8w7xLPIG6aE5A0CSNl4iUa7+xP09SQI261Dtkh+MlrmjrHlT/JCIk7kfbgdEXudSUAs0oiEwSxEBMTfhKKnLERcTfsRBcip5ZIScj5iFOlSbso12S8NVWMRLNqA24l8bbQOOHBRHyCERtEWKRSdLNGo4FdRtzE7Mdt2sdwWQfH094srWsqVDuGXGJoxEamdR6mfkycs0YzNVMv4Uch4T8YN5Ef7zKd1EtoNKH2oqSr8IKaaqGcgpZPlB3ymw0iY7jDpAvPJNroU1nLvhleO5O5582trwZpfbFbQoOT3TepomK343sRhrUYNayd7zuIKwFDYPHqnM51+Qeah3Dyq8AbFAXfLRdaknQNcQKKxrWNTn/pRfgE2x6h3vQ/4sqLskUZtVIRYsyfFTGFl1Synl8p/BTXubjEbioaAgX4i5JfxcIcGhlAJV42o7xgRw==;5:F7Or3HIbC9a9lwrlD6wofwTsU9Xjym6ujA2hFi0Qw3D6DPAdCqBAS36V1JQY+qFzodQTXb7l4JpkjnhCNuQdz17VVk4940aN4sGCKxGvaooFSO+b5u0MmVOkb8jPvglq8Ianm3dxpPYHhNT7QRjujGnILRAVV7CuLar62Jnx0Rw=;7:u1tYcp4KdL2Ohe3er5/ZqdBcLVF87gOZWDNWQYTNcGa7ttjV6FCunfZDWIbSxkwB/rJ4UXAhfX621bgn4vHSu4XAExkf7+b2mjKLGsDT0OFSUarbJwskgCdKjJ+Q3uTkW+sX5hu1YLuE5BGAvBVDg9Chl5JPoRqUXILQ4fhM22m/oHC7vY38vd3aCzgHnVPdebJ6fcUOKqbDCqv/JVa0iToG9dMBPX4M+62GRtB6Du0Kgl0Av3bShnArRLUJUiD1
x-ms-office365-filtering-correlation-id: eec93b9a-8b2c-4913-56d1-08d6145abeb7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0822;
x-ms-traffictypediagnostic: CY4PR21MB0822:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB08227D826FA808E974D1AAA9FB000@CY4PR21MB0822.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231344)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0822;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0822;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(396003)(136003)(366004)(199004)(189003)(6506007)(10290500003)(478600001)(102836004)(81166006)(14454004)(22452003)(6486002)(26005)(53936002)(186003)(6436002)(72206003)(2501003)(5250100002)(110136005)(6666003)(54906003)(3846002)(316002)(6512007)(36756003)(1076002)(97736004)(8676002)(81156014)(6116002)(5660300001)(10090500001)(76176011)(14444005)(2906002)(256004)(8936002)(2900100001)(99286004)(66066001)(305945005)(7736002)(486006)(217873002)(68736007)(4326008)(25786009)(476003)(106356001)(11346002)(107886003)(575784001)(446003)(105586002)(86362001)(86612001)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0822;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: SRvLzPpzf+EfQS5wdAngPcDR5UX5fIR0LV6rRE+ASfwow+bq6DAG9hn4qDGOx6cBpWuzNxqmvRZOIthtCRQMmOkre6BESCFX8fAWCWnrOz6TC32pwvavNA+2zzNfevXZtfChQe6j/rmPNNnkMhhZr516g6XcCAcLXIZZALsbAsJMLT+BdUmUE7GL6j5ewLb8RK0FsgtTzFY2qz8bgytu8D/G7g05OIfesTSi8CnOm82eOquJZp2ZNZ1+WJ56+emLQPgH5/L7hVBmeQ9+tMsu4K/u0p57KFNTs6bSBwC4JVjPulI5S/r3EFdufQGz8ghhlgrefQn3QO+i27hW3DvRb9kX5fc7u/mB9J67P1aKfXk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eec93b9a-8b2c-4913-56d1-08d6145abeb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:39:28.4083
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0822
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
index d81f27046582..84c4228fbbe7 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -1809,7 +1809,10 @@ xfrm_resolve_and_create_bundle(struct xfrm_policy **=
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
