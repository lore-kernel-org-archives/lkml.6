Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86F2C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83543205F4
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="La7R3MLV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83543205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729548AbeIBR0A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:26:00 -0400
Received: from mail-bn3nam01on0116.outbound.protection.outlook.com ([104.47.33.116]:32952
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729697AbeIBRYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:24:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YiPikg5n5IKdFSsPmIdA3jlA6XOyFg0TrOdKsWcL3QU=;
 b=La7R3MLVTzrAbHNh9beKDYksxcgOdr0sJjIcvWvS6WmeLrQlmIcCBPDZ+e/5xW7mCx4jnltFEsdv5P2oM20pHUEBbch5iKQq4Ob9sEDlKc/cgC5Lpm1Nsj3wj0+AX6JQgYvElY5Zq4pAJ+bXaz7bohIjTHVm6xvsisxVdAfYugU=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0469.namprd21.prod.outlook.com (10.172.121.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:08:52 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:08:52 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Parav Pandit <parav@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 88/89] RDMA/cma: Do not ignore net namespace for
 unbound cm_id
Thread-Topic: [PATCH AUTOSEL 4.14 88/89] RDMA/cma: Do not ignore net namespace
 for unbound cm_id
Thread-Index: AQHUQr3/X3PJRAkXUEiC1KovHStSqA==
Date:   Sun, 2 Sep 2018 13:08:09 +0000
Message-ID: <20180902064918.183387-88-alexander.levin@microsoft.com>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064918.183387-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0469;6:/Wu+KmI4xmc/btBTNmm+yMZ+2kv8+lsaN3H7XVQpzctIIk/DQ2h1KFDMFlvWT45pZalnixTV78a3GknDJmsqG+2kq5q63yI8kTJK1mMXa97vd1JPC13nXqJfSqSJHfaHGVpZD9qESLmTpQI+5WOAXGmqiV52Ldi0fRLyFqY6fIXmB9gDeXnIWTlHTqdQitGfSIKnI491N36yRS4/4SqNR5fJNw8uOjChACPTs5Ubvp9e7jEzh1xh5VtAOjmkCoutysewAAPBf4HCPNrS5CBMvk0NGoPDp9BMqK2CavB20Ct0nuTfoyggID4oxz9Yf7ruFl87S/kccUrwZr7uPvFbY8hfCaQNxPz187/aZjLxnkj6lCi9wUHojUQo4Gr5a3Bjndi4wgjpoKTZGINKdOhn24HccT8ryNx3qyoiptHl3EDxIwtoEGxYMEr0HVtdKw8ObTf+eD6CMuD/5YQ2ouUn6Q==;5:WSimN1edGIcSqkoWBiPjysnixb7D3NgukQSwKzZJI4Q8uiA4dZLBoSln5yOw+NLhQVLVSYNEOR6HC9avDfq6xXembnL962gX+EW2joZ1VDyAnn5EYTQzM0We7xuthqa0tWrlASBX6V09h4pmrs330TafTenUo4gibrhsVyxaICg=;7:lFpvFEYL3DV1equGeVPyOp6rYTWBH2Vv7gMh+h1Ob296SQzNF1JKY8vP4GSVbQYLhpi3FlfRBOdCTpfpW7Wq8avxuGNCmbfKK31JOsSm5ufr4ZSM9hIeWvyw+qMA1igLExhfXktGu3sxUtkY41aVIsOcGA2HUGsJcdbY3gCH85690GCXNAww9ieD4XyeDLACdE2EvfJPzIEYATtkV5UAQrE3RCAXMXH54SvGiY14ZiRUuZW2YbjGaHN+53oCrQS0
x-ms-office365-filtering-correlation-id: 092b43f0-818f-414a-feeb-08d610d53b0f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0469;
x-ms-traffictypediagnostic: CY4PR21MB0469:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB046909E5BC500CB8AE80BD9FFB0D0@CY4PR21MB0469.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231340)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0469;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0469;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39860400002)(136003)(366004)(346002)(199004)(189003)(110136005)(68736007)(36756003)(316002)(72206003)(54906003)(2501003)(81166006)(81156014)(8936002)(14454004)(97736004)(10090500001)(25786009)(106356001)(7736002)(2900100001)(4326008)(2906002)(8676002)(105586002)(305945005)(5660300001)(53936002)(1076002)(6116002)(478600001)(5250100002)(6666003)(3846002)(107886003)(10290500003)(76176011)(11346002)(99286004)(6486002)(6512007)(6436002)(2616005)(66066001)(6506007)(22452003)(446003)(26005)(186003)(86362001)(217873002)(476003)(486006)(256004)(102836004)(86612001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0469;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: O/mbY6lVNp5eLW4dobY2KaC9Zm2cwWN7lJlJN/cwnL4R4VqbfDr7WO0yRV1kDUyV0rmSsbLfVxBPWXcteU/ImsCWzK6IiSGuRHeiZjkCgYGNmN72u5FRhP5d75QTPCPBjDThNHXNp5HnBgtotCSBv0Ro0pt8WP6zZaFr34ZIboLfBzZ7bBZHi7lrNMVICU9z90WUqssA7jZqHG2yg5GVmyiFLfSskvjFIDyQSHpfoyie28xfkJey5bj5p7wbTPqsD/Y3BYOL6nf4Lb0wsBDpwXyleTMyjWzEkCyOAJbffDOERB6q83Jv5YRHSK+EOMllQlMbR8e9SD5XC7VIAFTQCi/lSDAhvN739CwwAddzm/U=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 092b43f0-818f-414a-feeb-08d610d53b0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:08:09.6955
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0469
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Parav Pandit <parav@mellanox.com>

[ Upstream commit 643d213a9a034fa04f5575a40dfc8548e33ce04f ]

Currently if the cm_id is not bound to any netdevice, than for such cm_id,
net namespace is ignored; which is incorrect.

Regardless of cm_id bound to a netdevice or not, net namespace must
match. When a cm_id is bound to a netdevice, in such case net namespace
and netdevice both must match.

Fixes: 4c21b5bcef73 ("IB/cma: Add net_dev and private data checks to RDMA C=
M")
Signed-off-by: Parav Pandit <parav@mellanox.com>
Reviewed-by: Daniel Jurgens <danielj@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/core/cma.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 79843a3ca9dc..752dbc388c27 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -1459,9 +1459,16 @@ static bool cma_match_net_dev(const struct rdma_cm_i=
d *id,
 		       (addr->src_addr.ss_family =3D=3D AF_IB ||
 			cma_protocol_roce_dev_port(id->device, port_num));
=20
-	return !addr->dev_addr.bound_dev_if ||
-	       (net_eq(dev_net(net_dev), addr->dev_addr.net) &&
-		addr->dev_addr.bound_dev_if =3D=3D net_dev->ifindex);
+	/*
+	 * Net namespaces must match, and if the listner is listening
+	 * on a specific netdevice than netdevice must match as well.
+	 */
+	if (net_eq(dev_net(net_dev), addr->dev_addr.net) &&
+	    (!!addr->dev_addr.bound_dev_if =3D=3D
+	     (addr->dev_addr.bound_dev_if =3D=3D net_dev->ifindex)))
+		return true;
+	else
+		return false;
 }
=20
 static struct rdma_id_private *cma_find_listener(
--=20
2.17.1
