Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22422C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A419920652
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:15:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="GkA9r7hp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A419920652
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730125AbeIBRbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:31:39 -0400
Received: from mail-cys01nam02on0106.outbound.protection.outlook.com ([104.47.37.106]:54352
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729427AbeIBRbi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:31:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0Af4QUb5dj5OrPxNLd3FVoJBVa0WCrSHv3G87D/ghQ=;
 b=GkA9r7hp3okmXJwTR1PV7Vy39AVdfG+3gaoAi89uzUCg/ivJnMdtib5oKCwI+M8toyydMeGZxjtOs3XPmH0jPzIJwT/Xp+jEB+Lgw0x1NuETBiIN5V1M9S7p4RRw1tQtfM7dBiqD43foZCq+EFwCfjGrEsUye2d6x5BSNWrroOs=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0184.namprd21.prod.outlook.com (10.173.193.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:15:34 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:15:34 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Parav Pandit <parav@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 61/62] RDMA/cma: Do not ignore net namespace for
 unbound cm_id
Thread-Topic: [PATCH AUTOSEL 4.9 61/62] RDMA/cma: Do not ignore net namespace
 for unbound cm_id
Thread-Index: AQHUQr79d9v5jKXHVUOwrUnR9Y1XIw==
Date:   Sun, 2 Sep 2018 13:15:16 +0000
Message-ID: <20180902131411.183978-51-alexander.levin@microsoft.com>
References: <20180902131411.183978-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131411.183978-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0184;6:QIT9rn5uYKCpmriSIUVZiatGu4eOrBKyj9lhdIxy0ivkI+gIgUTkH1Fh0dnqCidrh1fq6IwyhzjaqKh6BiIP1iyLWvDPpgDGnBScuMWp9P/tvTpHm0lT0EUggbHA01eKlVt3hZY0wb2sgzhwXY+t0w36E1On35APzfqye64INn8SCUQL6hafXkkDcKxWgLc55AR+DKJQpT47viP7mYnpCDlebUsAkSDBRyBmfTU7d8yGqhskuynARibOR1XIZocnUKXsToxstui9rJbOQrd+v6S93w5HAOio5M+xDiYpRCXke6xzggfJJpy5LL+qaNltdLjZaDf54zOpaiyRNA/0bZW1gMyS1GAEJLdYpDanNzxha5MwTNArWIU7UiTKoVAT2sYSJU+XUt2/0dnOxnMUQOgz5SywVo0z/BscVfS4zVE0tjHYcfvlBXdTdZOQYudbPqNT/ntyyD7gTHlfhGxJaw==;5:7dlHIk4md5yh2nz/Nfv6KMH/wj5AGwzTJqsDCabakgbtQdK8SRH7W5VeAIFbPCpuTldT8B6slFR7amB+gztv1tMc2juxEiEJGmKQ++PIlcP/3cPeLPRxSgH2JxNClvSzMUvdoayz0OAYNJjCspD5wAQBMAwi8Wm6JqDCJHDjsbw=;7:BjbmHC+V4SMqfIECZjS0G59Vc0ZZGX9XJ9f9hMt5p98XaNI3D3eKOsXzd8vCaWhtwt6hAiz4WUxCARlCyIkOSevKX+/6/xJq+4YzRa9OA2k6Ts5/IFMn1U+YbV2bflCckGS6/SAxXbja0b1Yas4wfqqsjwlVwWce7OQtBBG2qlf/LqE65ACnp3mwST2OUWg6h48mxWmVIaJfGtGSRjtN+5+yUqYbLODMnVkPDZMcYy33Ixd2LzAxdz2cGLMz/CxS
x-ms-office365-filtering-correlation-id: ddb31872-6f6e-4f09-f081-08d610d62ae4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0184;
x-ms-traffictypediagnostic: CY4PR21MB0184:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0184FBA2B1DF39560F31CBDEFB0D0@CY4PR21MB0184.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0184;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0184;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(366004)(136003)(39860400002)(199004)(189003)(2616005)(10290500003)(68736007)(476003)(81166006)(11346002)(2906002)(8936002)(76176011)(3846002)(6506007)(5660300001)(81156014)(1076002)(8676002)(99286004)(102836004)(14454004)(446003)(2900100001)(86612001)(478600001)(186003)(305945005)(7736002)(72206003)(217873002)(86362001)(486006)(6666003)(4326008)(97736004)(6436002)(6512007)(53936002)(107886003)(22452003)(25786009)(105586002)(106356001)(36756003)(66066001)(5250100002)(316002)(10090500001)(256004)(6116002)(26005)(2501003)(6486002)(54906003)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0184;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: M18DnIy1bhcZPh2uQp6kz5BsyVxD0CIztxH7/c5R6xJpO6KMdc4OLa6gzp/7TQCTO04h+8keUAb1cq0G78AAzO0K/ugyKQCF0Ytqlt5I9sLYZrAJQW29AU5f2wHwAPl5jM05RMlS8acZPSRsIqkGSF8L+JkWek70zkqBMmpPzSagSYQahDT6A7aP4hSUIWuvu+Bku9DB87J2Rrb8fOI9GRtlUKXXLjNnaexscRusLhjFrIt8Z0tX3bDqjhOiR87ZFF3HXSgxUuBYvTOPpGKlyZl7pFCyfUvTEDSw/hM442C9G/tBDddsT5pcRPY5V4lxhLOfVMMBDd4B8jjg+bPKvv9oTNMVsxG85gBUMO8WEfo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddb31872-6f6e-4f09-f081-08d610d62ae4
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:15:16.5956
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0184
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
index cbe5324c4331..575afba1056a 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -1409,9 +1409,16 @@ static bool cma_match_net_dev(const struct rdma_cm_i=
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
