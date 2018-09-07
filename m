Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A96C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F11092083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="HzovTus6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F11092083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731029AbeIGFTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:19:38 -0400
Received: from mail-cys01nam02on0119.outbound.protection.outlook.com ([104.47.37.119]:49833
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730969AbeIGFTi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:19:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SwsZDRUIzUQV3+aW4fXscf5vo9d1k4FoRwcRSDuyKEU=;
 b=HzovTus6Vw+WcpjoKXH+x/riV/UsDNRrlFjfjzOa1v9pZVWj8LVkrx5Pxr4i3SOIknatMsxw03Tm+PY38W2OkNkflU9w1khnhNDNwNi27CtMwl+nohhLyd3k4gnebf9EvFlM0ArnNjREnY1V2+CuxjLJmL7XivovAleWQaySLaY=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0853.namprd21.prod.outlook.com (10.173.192.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:41:26 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:41:26 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     YueHaibing <yuehaibing@huawei.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 05/30] xfrm: fix 'passing zero to ERR_PTR()'
 warning
Thread-Topic: [PATCH AUTOSEL 4.4 05/30] xfrm: fix 'passing zero to ERR_PTR()'
 warning
Thread-Index: AQHURkMqUcTBcHwxpUOJhMJfJZzIoA==
Date:   Fri, 7 Sep 2018 00:38:59 +0000
Message-ID: <20180907003853.57942-5-alexander.levin@microsoft.com>
References: <20180907003853.57942-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003853.57942-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0853;6:uVti1Fu2NPdcCSomCC/D+8JgJNFhXgZkmWIqHrWGia8yk/K4HwBlIPVm+TcTHyXIMtVQSRCPOx0ovRmioyObvuAiV/6q+imzILYLUmqNnSToia+l5CiZfVdsIPN/mi9TrTWU7MsvdedH427BS0q6P/i5enGmwVoPaCk8UgOrB6dlIgbTRBe18gyAic4BajDFU3WjFEaNaT683osfKXbkwBwMqYlckZQmlIFDTnWBX0bIE2M42o0DbybNyNkD9wCXVcdjPLwP+xxMNxiOkj+kJeYryolxvdpzFbG/FCjGiz1WUUEn+r/Cr1AijRL59wxwF5YWfSDTWVl/kYV3VW2j5mWwZOXpzUvJaAv72MXtFZbuq+B23/4muabMVUNyVJdh4Jt6WxKls8+EIts4o6W1YVrJQjQTDAAI0QmWFAeHotedfmSpk7qtgrBkplLEXUP+ddzrdyUYvkPX52cwb9ImkA==;5:CzLmgjmBnHDT1jgnCOtiqmoRItpsHQ8dPZqLYMmvmCItTCuf3a+f8Xw6lj1TWQLw5T76+FVoiBMZZn4Z6XEEA9SdxD+86VTww+gP8BnPGMryG3j6VO89MWLLDB5jULbTgW55eUbva/0kdqXcYx/FVWLxV3dNmJ6fStCOJCeXELU=;7:vKCyrZJnOwl+EW7xIVx6iDo1lF4DrMVWa4ZLD9b+kKXhnJF9rWLdaQ17gBkGrFlmSVg2S22GZuxSxtzjY7NWaTkC7YopGKmiUjNz4VM502jn70qgE5GUkGpRrRoCBhewnSLko8sptrnGT73rr+DrXhDYDxGALUK2pPBbXChcAFydkvXNapyUbVEJc/b01oxGHB8cg4jkGQNffouuOyqWefrMzPHtNDahSZi+4/jkQ1pA9FjFXNrBcz3kojWvATAu
x-ms-office365-filtering-correlation-id: 20c4193c-4a0a-4e9f-343b-08d6145aa514
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0853;
x-ms-traffictypediagnostic: CY4PR21MB0853:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0853CE823CB4D675C920E201FB000@CY4PR21MB0853.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0853;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0853;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(366004)(39860400002)(136003)(199004)(189003)(217873002)(105586002)(106356001)(14444005)(256004)(1076002)(66066001)(3846002)(6116002)(4326008)(25786009)(107886003)(486006)(6436002)(6512007)(6666003)(53936002)(5660300001)(68736007)(102836004)(10290500003)(186003)(2906002)(2616005)(11346002)(476003)(2501003)(5250100002)(6506007)(446003)(110136005)(8936002)(36756003)(54906003)(76176011)(99286004)(26005)(2900100001)(81166006)(7736002)(81156014)(8676002)(14454004)(305945005)(6486002)(97736004)(72206003)(478600001)(86362001)(10090500001)(316002)(22452003)(575784001)(86612001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0853;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: zQmGlAPrFCDpYxC8VRIO+LXZOqnbSdjcAOn6qbvCmQ7MPjXl82zQCkujJUgjXEM3SsK45if4NQwQ0Iic1/iMObk9YZ+rgVzRsXcs+hsvoV1gsw+B6G8KfZ+sFriE2/HsS6X2vFE8mwnhoUafYLEPI21RrpSFjxMR+pdnYDfvTCCo99H6vJuMvYdaye3pj3+EQN+KQAb4DL+I10BLmYYKYzHK3CzViPAtrAMHOO6k74ewzExmiNFwl9Ya/X0Auxqbgo5S6+XRoDZjlKCUDp0QjpVAXcoZSCTyTBsHc9Dt7uRZzhVSfKYPGc/LaUbhkebL1dRU/nZGGwICJDHzc1oGBaNJioSdd3GGx1AZDw/b5uo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20c4193c-4a0a-4e9f-343b-08d6145aa514
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:38:59.5826
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0853
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
index f9a13b67df5e..ca690d7ebde9 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -1845,7 +1845,10 @@ xfrm_resolve_and_create_bundle(struct xfrm_policy **=
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
