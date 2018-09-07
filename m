Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A1BC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 01:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB2932075B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 01:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="JObYrlBE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB2932075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729408AbeIGFjw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:39:52 -0400
Received: from mail-eopbgr690135.outbound.protection.outlook.com ([40.107.69.135]:4506
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728593AbeIGFOT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:14:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EPKSWYCJ9Xf5JSKE6UJeoRIpiRfy5/kKzZ2OEoyVxrA=;
 b=JObYrlBEXBPkveDVoe/bXun86IL9nNYQDr5DdbnARPIgcW5JTWHrSIA/ALpaatseEdKXwYOqyom6eMMURUgCtCFh/BUtZ9+8PNpw5vaa05rPGVG4mP55pymRbqs/jl0Dhup2+ah4wmWpHtP/7y/BHbX5cUOj1obpgMxgXec0pxA=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:36:01 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:36:01 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     YueHaibing <yuehaibing@huawei.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 11/88] xfrm: fix 'passing zero to ERR_PTR()'
 warning
Thread-Topic: [PATCH AUTOSEL 4.18 11/88] xfrm: fix 'passing zero to ERR_PTR()'
 warning
Thread-Index: AQHURkLAL4okT70r8k+vBhK1/qTBhQ==
Date:   Fri, 7 Sep 2018 00:36:00 +0000
Message-ID: <20180907003547.57567-11-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0773;6:7nqFDCy6KkG4pLkkcRiTY5XcHw/n03jO5PfwIss6HkaCUZpCIP2bOk60kk2n4TEzUeDyjLdchr4qVpm9w4a0SoqNzopEGTMgnKc5Oz2SVfuSv3WyHjBh8RBd8znbHkn9DPd/4t+n5laToC+Tbav0KPqr92H5FQQuHna5v4gkZgaq1Jk0bIWvReqJJofc4ct0SevoYQ+UDoDvEMWImXq45uEBJdkS7HHDlIYsgNNgvty6CBPBfiasYEwSAn+BJD2s4xZlK7Zw5cI7aoQCmsY1G+vkXfP8UdU9Qt3yDPHqgIqCsqmN7eTtYVPiwEhREWWycgzmSNg/XO8F4H92GOglDYEPIE5+FoNIVC0hMm/6QRPLw6WD5+A5dr59dJXHyDES23bwNiHXZi9hMDktAHieCpQp+jZKtaUDR7OqHGFjrVYaoPhvLnxZHVidIr9nt7rigQvQD1QwABpFG03UDgZPwA==;5:YOHS8wPjgyFlL/L4z9NlEREzvx1Xsi1Osddk058JCokTlDt0Sg7m3+BR2g4RGHEnD6ub5vp+zKA3F+sSMi1RM9wddKyLzAgouBLAHUheH5ChpM/TB2k7n8mXRn1sNXThF7WmEmtxA0Qj6Aygcl0SpGzIbnhy0ITtsBv52z2aPcE=;7:fThabv2pGuo6hahWMSSxuct9mVG2eGBa/mtq8tGsyYineFH86Y+8ZCn+AaSiiqvTlcEP/dApNcwoX6flsr8DezXwwGIrMSnl9hgI2OeDsCOoui5jdTNAuIYpBtI16yyBQo/X5T/JenMeNZUFQvsZ+3Z4Hk6DdBdPU35G1OMGneJBWoShe9TTJvuRgMwuVLg7RnvWXVb0SCYAnvIFms7IdWmqMhExNm5zwelVWKBS3izLc8UPGccGpwov2arbDi/l
x-ms-office365-filtering-correlation-id: b53bbf59-3ed0-48fa-d907-08d61459e2df
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0773;
x-ms-traffictypediagnostic: CY4PR21MB0773:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB077397F640A71B3BC4C31497FB000@CY4PR21MB0773.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0773;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0773;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39860400002)(346002)(376002)(396003)(189003)(199004)(8676002)(5660300001)(106356001)(6436002)(25786009)(110136005)(54906003)(6506007)(105586002)(2906002)(486006)(53936002)(446003)(2616005)(476003)(4326008)(11346002)(5250100002)(107886003)(2501003)(86612001)(97736004)(6512007)(478600001)(3846002)(72206003)(6116002)(10290500003)(76176011)(68736007)(14454004)(1076002)(66066001)(26005)(575784001)(6486002)(99286004)(8936002)(36756003)(81166006)(86362001)(14444005)(256004)(102836004)(81156014)(305945005)(186003)(22452003)(2900100001)(7736002)(10090500001)(316002)(217873002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0773;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 9q7yotvsNvzxsnauHiz/sZRZ+VpulHt7N6Xp0B8pf/HAVoEJvndU5p99jKIbzhKlRM45DgkKBOGaaP0+zlZrpDCARfKjCCapSHIGqEzHlFZvKIuei/HJfYmfNAuUgV0EUTtahGzO0qvPrBQICWzFCpDQdOREA6jMZPi79cS/kId/nU/5o07vi0GzYqLEUYnEhuBeyX1x3rNC5wRbfAAdqCdGRbOrQ84xzGtdN7YkSP+cpKoK5XsvZ2l48R9VGQ9jzECwQDl4jGw7OuBsh3u5WXXyUhV2dfOPT+cj8sJCcDulDoXlLrVwyJVYiah9EDVJQaOkVxUZPaVecvOwyXFVFLu8SvbMyV3STSUDU3CTqjo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b53bbf59-3ed0-48fa-d907-08d61459e2df
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:36:00.9028
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0773
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
index 7c5e8978aeaa..a94983e03a8b 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -1831,7 +1831,10 @@ xfrm_resolve_and_create_bundle(struct xfrm_policy **=
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
