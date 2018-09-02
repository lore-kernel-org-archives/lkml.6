Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A92C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1017D20652
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="X6VQN7Li"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1017D20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730448AbeIBRdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:33:02 -0400
Received: from mail-sn1nam01on0111.outbound.protection.outlook.com ([104.47.32.111]:9515
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727573AbeIBRdB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:33:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+1JmzkJEoz1jKNDkJkOX30fyI+2FPizz/FM797k4mCQ=;
 b=X6VQN7LiDmbmaLn1IjC09XSy4tmqsb2tzUF/BOp1Y4vlyfYSIKFed79c8sO3SmX8AprZzW2vZ0M3UC9p/LVO8XYVnQ6yyvx4rmE+ZOONRrknRL/DBYtX8HT6kSg9E9r5ORBcmli5M8TcfOYr6jPZJc/EniQ8eQ/fsExfu3ShccI=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0167.namprd21.prod.outlook.com (10.173.192.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:17:03 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:17:03 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Parav Pandit <parav@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 46/47] RDMA/cma: Do not ignore net namespace for
 unbound cm_id
Thread-Topic: [PATCH AUTOSEL 4.4 46/47] RDMA/cma: Do not ignore net namespace
 for unbound cm_id
Thread-Index: AQHUQr8rHVxjNvYz9EOB8pCGAqDRZA==
Date:   Sun, 2 Sep 2018 13:16:33 +0000
Message-ID: <20180902131533.184092-46-alexander.levin@microsoft.com>
References: <20180902131533.184092-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131533.184092-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0167;6:WzDGei6SQ51pbuccBZmQpbplKwdvCEPunD8PPzAANjxpogLXWHdxBDHvnsCeDituk2f/m7Y6B8jR+yKatByDL6Fwds9Jsc7HfFYJJdEI1NN5lhUAXTi9rn4TiBcEynql2R3o4XjhAa5uTVrApOXZb8bzkRJjYP77lB0I4PK7rf5Be7YxfyYvEiOqxP140moQ6iPhPyFBSxX8Vphiz9KUrDujPajxhlRRPP+x20XImeyW9y0/Ie3wcdUDqkszsPSCiJOL1/JEy23KpevGc39ahBVUaUrMPx0jIHId9T6V1tiFKEd2ECaLf1D6DB49B+gvP5f1Po0dQhR8cTiDqC1qCV56jrqWzYK2IroUZSjCN0VdEfW3H3fQ0iPcmSIQNNiw62p8iDyux5zK8WwwlNSWmeI8Luhivkbj3jRmMT6m7ld1HsQZA9KqlD6RhJ/FM3DhP+1QAb0NjQH95vvpnA4+lA==;5:JPlYKOh+H2mM3Sl2grOPzs6b6pNlAI8JZFltXHJks1H+G55Y/31BCeh9fGk5QVynI89YsqW1lclL69qMjzvRq3aNM/VPweZwKXB+Fg4AVBzYd47GiLu38AfISL28v9FV0YGxCE+cTzffjsAZujEQJrxPMc5Jhv46YgxRsXyv7/w=;7:WSyltnymBjmFqXN21pzTDe7xH4MzQg1p8OfquJ1PO2yr/N4HkArczW79/8bl9zXYgc6F6QES60SYnjylzEjym1e8MLZ2j2mgYGHmUm8s2+rzK+y1vp0gjnZruaohk2RiRAEiA+VVJvKonmsIeDJcqZZFXHZ/waTLJecqsDo2Bjd6OUkcioZEY2j7NgPhW2KYrUvAqFsyMpgqfoemjIxfQ2KZARm1L5oUTGjLxfZTxrjMIre/klD3i/KEbVCFlfu/
x-ms-office365-filtering-correlation-id: f652c688-5936-47b1-8dc3-08d610d66004
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0167;
x-ms-traffictypediagnostic: CY4PR21MB0167:
x-microsoft-antispam-prvs: <CY4PR21MB01673F15514D9CDA08A6EA7EFB0D0@CY4PR21MB0167.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0167;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0167;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(376002)(346002)(366004)(396003)(199004)(189003)(305945005)(6436002)(7736002)(6486002)(106356001)(105586002)(6512007)(53936002)(8676002)(36756003)(6666003)(6346003)(186003)(476003)(486006)(26005)(2616005)(11346002)(446003)(5660300001)(2501003)(5250100002)(10090500001)(102836004)(97736004)(6506007)(2900100001)(81156014)(316002)(81166006)(66066001)(22452003)(217873002)(2906002)(99286004)(54906003)(1076002)(8936002)(76176011)(68736007)(110136005)(3846002)(10290500003)(4326008)(25786009)(478600001)(6116002)(86612001)(86362001)(107886003)(72206003)(14454004)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0167;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: YPP2mzJUKoU3+Y+UA4+3H/xs4vap3OmFc69K6LvJCvW2w7nZCbHTlmmfpGi8hDXOpZDIBnAuYQiS8TnV3MuIE48laPuRgSn4PMikqdF4GATHCsaqgVc+9Yon3YVN58AEwDtMDM4XthPTTSZgGiPYooBjCz0rFuzBRp0sOxHr2weImkfd6HW/lLcCfb8bx9AeRynvS0+BNzhsmnseVQ4JhUNEwGgbi7KJb/4nz+078tRmFnIIMNxtIZNUPn2IUVRl6VunlnGChlag8EVaaW+q9h+ixuV9n98mECzZs0p9dsL1glumRc18lzZJuegCZbcxwsRhFHS85F6DTCW4bdctM2gH32325hKW2soVpy6edjY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f652c688-5936-47b1-8dc3-08d610d66004
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:16:33.4619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0167
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
index d57a78ec7425..0f42411d6a79 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -1280,9 +1280,16 @@ static bool cma_match_net_dev(const struct rdma_cm_i=
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
