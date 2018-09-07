Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24143C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3AEC20844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="FiOyCVm1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3AEC20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730185AbeIGFcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:32:33 -0400
Received: from mail-eopbgr710122.outbound.protection.outlook.com ([40.107.71.122]:40960
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727346AbeIGFQ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:16:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BxReFfMqUpxm3hnSYXgMwSDxuIusSO8S7F5dbc+2lIA=;
 b=FiOyCVm1r6M6l9wvdzD76bt18WU79KN3EbAeI193ZrzMMVdtlxr72CLXdtajczXcd2rve8/a3R0YC7poGJsKGqvPQXONTnnOQSDik/TAgBU0rQcZJw+bGNwfP+/gekZtvqvPKIfwbRCvlhfhUZMolx3Ir773ERPnsO7wPobrrKU=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0839.namprd21.prod.outlook.com (10.173.192.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Fri, 7 Sep 2018 00:38:15 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:38:15 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     YueHaibing <yuehaibing@huawei.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 09/67] xfrm: fix 'passing zero to ERR_PTR()'
 warning
Thread-Topic: [PATCH AUTOSEL 4.14 09/67] xfrm: fix 'passing zero to ERR_PTR()'
 warning
Thread-Index: AQHURkLzSCGfLFIpVEWI6S28NjsPqw==
Date:   Fri, 7 Sep 2018 00:37:26 +0000
Message-ID: <20180907003716.57737-9-alexander.levin@microsoft.com>
References: <20180907003716.57737-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003716.57737-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0839;6:vws4njGKIE0NDB5coIkzW84xBDZUL1IpB0zWR/usWNdmvMn4h16sst2mqGUIauw9QELM22qo6+wrrTF1j1POuR23gicUh7vKphbxRNtEkE9Q2Yeu88Yk/zQN3ExOHjIhWC0A3N3kAvBri9XTnQsk9foaih8WrS7ipN46m0Xk/0T7sb3czbmeLiyDb5c8f3nOAvjTMkm0u86sqKrzMM4CRC/+JmCS4hTWKdyMM1bunN8crDT0GD4hkmKJ3B+nUMQwzjQ1B2hpNmP/Gwm9Dj/ZC7aRKt/BbmlJTL6JXTpORn0tSyuebCtkAq7CnexiBl1TS96c5rwozv+0CuHLDj9WclDfDDKlJDPyVVacmORAYf73loF+T+uF5+EJcHRMeLL7DALHUc45DewgD1kG0Dz3XfBIa7RaZ2vnQl4zkuNeNnRu03rsdk+wf6uP4WXbCDHQpyyR3bLOoUeXLksM1GXTDg==;5:qb906kdCK55u4auJtbD+OQ3T7m8Jdc/M9cdQHsD+wbQmO+IodxoubKDD2XqiaASRE3jELs3hra80BQudul1eZAOTMuut7cD2KCVhqlE4VJg2TiHvAM0ARXkpWyUhCHBMYBK4q93ooRb6y0Wpi7OvzJmVQODjKCMfjbgVi2JDCfQ=;7:UThf/pp1uKUHb330Uycp/7PkTOD4MQkjmnpbhtxgdB8QmXCUMldXgGiMsZE1Bnaty60q/HvO8ahN9vzNj1boC/a3VVZKxlGlu4mo+iDtVghCOxcUTmmgkxOTvmf69excVlkVoaQLdK96WoTNmH71mc4q4fFDCxfB1w2vf0iGtVddTW+BGMu/U0XzlYip+G1XUHEluFafEKv4tLu22Zd09vxAwYNhyZ1JyMf6L6ZVN5YZyglV7AEFjfBhj04OTBPt
x-ms-office365-filtering-correlation-id: ce6ce48b-63bb-4317-6aaa-08d6145a3318
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0839;
x-ms-traffictypediagnostic: CY4PR21MB0839:
x-microsoft-antispam-prvs: <CY4PR21MB08394B4EDE1EBED9B63D697AFB000@CY4PR21MB0839.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0839;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0839;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(136003)(346002)(39860400002)(189003)(199004)(10290500003)(99286004)(10090500001)(105586002)(106356001)(102836004)(76176011)(97736004)(6512007)(53936002)(2900100001)(6346003)(316002)(54906003)(110136005)(256004)(14444005)(26005)(6436002)(107886003)(2906002)(86362001)(575784001)(186003)(478600001)(5660300001)(6486002)(446003)(476003)(68736007)(7736002)(86612001)(11346002)(8936002)(1076002)(22452003)(25786009)(2501003)(36756003)(2616005)(486006)(81166006)(81156014)(66066001)(6666003)(217873002)(4326008)(6506007)(5250100002)(6116002)(3846002)(305945005)(8676002)(72206003)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0839;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: MI0o7psSJCjZmTkj9oDo+FaMxGAC6Hh9fDrH2P2MBUx6MO9ZcwbZsqFPg9A8xFnZ4S0qONLH38N7oY1xpDGjtFIpi4O9C7DwCBz2Ol2VXRLM6ox4afcOrGL0HrT6rAdo54/JUYbg9PIEX9EsZ/iV/XA/0kST6l5KczXXsIUZSfCD+yjYUqioS02uTmwC79Lc6sddWK6ItOyKg4RG7WbKPbJuLoSL/T3N36OYz/PlTK8+zfgcXdZ1c0vcyT0VYvmdA9wwd6PAu+opLEcY+muGK3tJ7TvaDAyIGQQMOFERrvvsIBLBtp53MJTYlQCZ6oIISM9ZFK9gYRd6UVqr9ks+G+guEoMp7SzJee80UIiQbeQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce6ce48b-63bb-4317-6aaa-08d6145a3318
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:37:26.4202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0839
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
index 9c57d6a5816c..4a346c7dd97c 100644
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
