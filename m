Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43797C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E76822077B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="aJKdh59/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E76822077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbeIBRUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:20:49 -0400
Received: from mail-eopbgr700093.outbound.protection.outlook.com ([40.107.70.93]:58944
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727495AbeIBRUr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:20:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J6DYLF6UWwzDdKs9+RSjEq7q1Uv9aTqX9FJ5tFPPlnU=;
 b=aJKdh59/Pmq44dMkOEcHzXwi+H153cRB2MSHj3zp1oYt9KE81fTPUAH305AY+o0DW1ITMOMlLQwtBtH2fH/S3Kas4loYDqG4Yh5B9Ia97L7UTkY7cPcSlrHg1CQmhmD+RNjEoNoyPIveo8i45SbwTN6/56aEgm64d9dNOrtWV/o=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0120.namprd21.prod.outlook.com (10.173.189.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:04:49 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:04:49 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Calum Mackay <calum.mackay@oracle.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 063/131] nfs: Referrals not inheriting proto
 setting from parent
Thread-Topic: [PATCH AUTOSEL 4.18 063/131] nfs: Referrals not inheriting proto
 setting from parent
Thread-Index: AQHUQr12NzP4tAHU9kenUmQJsdcBmg==
Date:   Sun, 2 Sep 2018 13:04:21 +0000
Message-ID: <20180902064601.183036-63-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0120;6:tvxlBSbj2O2Yfe2up8O62cWD2UGYQB6lSn80kwKQnqe3nEJjWgNbBI+hEjdcg27XDOEwWU3CrM9fL9fleey6nqVGqRwF5bozIcjCuFrwHgoI9X9xgufymkehNYXENhD8s0DwDkQzPIca1PKAHUtEzub4OpoRzNSahjDLrpvbrWDAYApY37DDWYXdVliksj/ROnsUs/Y0ptHFYPH9OIAlGZ8p2PyQrmg4AzQqcMytS0BkzWNrnbyTTA2Sw6gp9Xa4JnKGVfJ1hQ7KaJ2+3oxyfYVlJDGC/fkS+BTdttrDXsi9ERTEM67mqw6pRRIO/vBJ2zqDi5mOzfGW/DjCnmOAwn1Bk1G7xgH+cuzxw0LMSkZ+J/jTFle2rkrcF4drVVGuGOD2N0lcA4Q0NvSHgEFz3ndoWkhJK3ITAyQ05YVMmpQrO4uFV7lCq2ClrnD4z8aoVRwysqiQ2SSbA/Uja7se2Q==;5:8rJ5gHp3L8pp8dwsQBj0Jcj4oQUBZd7XJR2nW4/OCCEtJ7o77ldRZjCFklnmJN5z4YBkK2qMAVf7qqyXrHgtnysT2A7VkYF5Ana5cRKUm0FNLqCAjuOmULt8daLu/RBu+YwCmtBJUDcokpqbJySlovxHbowTBq+KHy1OlfRSpOI=;7:LurgJULbUS2Eu1CRC9iGWIxr2hknDSX421lPAifZUVRsf8dMqGT2h+cDeGqjZEkEJ0XdQYYVGJ3bu0hdY04GuO+NHi/snlnSVyj9jTdaAkDIb1O/sOtw8P/hZJtTfp++I1SC4fkEAXWkmOKtzMb8J5DhbizJ8WhlrfGNh15ibXdkyMkYsMNpZklFAqk5Bg1qiYrGaHZGI7D8DKtR88hPoioaGBSFUBf15thJjq8oZABbSj0JmpSd2uUqbrSz9J6N
x-ms-office365-filtering-correlation-id: b8abb831-0819-4e07-fb7a-08d610d4aa81
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0120;
x-ms-traffictypediagnostic: CY4PR21MB0120:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB012081C27450276B0E7FE3CAFB0D0@CY4PR21MB0120.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(150554046322364)(146099531331640);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0120;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0120;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(376002)(366004)(346002)(39860400002)(199004)(189003)(110136005)(5660300001)(107886003)(26005)(6506007)(6666003)(2900100001)(8936002)(68736007)(66066001)(99286004)(76176011)(217873002)(2906002)(1076002)(316002)(3846002)(6116002)(86612001)(54906003)(6436002)(305945005)(7736002)(256004)(575784001)(86362001)(6486002)(25786009)(10290500003)(478600001)(14454004)(476003)(22452003)(5250100002)(97736004)(106356001)(72206003)(53936002)(2501003)(2616005)(446003)(11346002)(6512007)(10090500001)(4326008)(36756003)(105586002)(102836004)(8676002)(81156014)(81166006)(186003)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0120;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 5ktrRhDRak2EGv+eAPff+JRLZsbpkp6EkFHboX63Yn3LtSIs0k5RNl6sCIG1xPEUVgRkMX31JiEiB1116LfZg28Cma7tYqLEJk8yPAmXYvMub1Jspe38Pt3cXG+8N/xdfYC0yIaPeOYOOKfuWWPUEa9BGp6bByu5K7TgzOZotgQWjTvpq2bUfFDFkTWnF0B8jrRZ5zYWEcl2fok5Ex2VDHJK3qGxrTWfOMtvnECOV/vQoPFIroKIhG+AD8Xddm7QVj1a9ZhzDEIpFSk+XMPUWJpBRWPZP8i2V9sCR1YKG8GSLYhiHLVJ3gDqVvycqTecvQyfgYVW05Mj5n33e7GlZHf5F/9Z5Iwp4bl8rmExkyA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8abb831-0819-4e07-fb7a-08d610d4aa81
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:04:21.0201
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Calum Mackay <calum.mackay@oracle.com>

[ Upstream commit 23a88ade7131aa259c532ab17685c76de562242b ]

Commit 530ea4219231 ("nfs: Referrals should use the same proto setting
as their parent") encloses the fix with #ifdef CONFIG_SUNRPC_XPRT_RDMA.

CONFIG_SUNRPC_XPRT_RDMA is a tristate option, so it should be tested
with #if IS_ENABLED().

Fixes: 530ea4219231 ("nfs: Referrals should use the same proto setting as t=
heir parent")
Reported-by: Helen Chao <helen.chao@oracle.com>
Tested-by: Helen Chao <helen.chao@oracle.com>
Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: Bill Baker <bill.baker@oracle.com>
Signed-off-by: Calum Mackay <calum.mackay@oracle.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/nfs/nfs4client.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index 979631411a0e..d7124fb12041 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -1127,7 +1127,7 @@ struct nfs_server *nfs4_create_referral_server(struct=
 nfs_clone_mount *data,
 	nfs_server_copy_userdata(server, parent_server);
=20
 	/* Get a client representation */
-#ifdef CONFIG_SUNRPC_XPRT_RDMA
+#if IS_ENABLED(CONFIG_SUNRPC_XPRT_RDMA)
 	rpc_set_port(data->addr, NFS_RDMA_PORT);
 	error =3D nfs4_set_client(server, data->hostname,
 				data->addr,
@@ -1139,7 +1139,7 @@ struct nfs_server *nfs4_create_referral_server(struct=
 nfs_clone_mount *data,
 				parent_client->cl_net);
 	if (!error)
 		goto init_server;
-#endif	/* CONFIG_SUNRPC_XPRT_RDMA */
+#endif	/* IS_ENABLED(CONFIG_SUNRPC_XPRT_RDMA) */
=20
 	rpc_set_port(data->addr, NFS_PORT);
 	error =3D nfs4_set_client(server, data->hostname,
@@ -1153,7 +1153,7 @@ struct nfs_server *nfs4_create_referral_server(struct=
 nfs_clone_mount *data,
 	if (error < 0)
 		goto error;
=20
-#ifdef CONFIG_SUNRPC_XPRT_RDMA
+#if IS_ENABLED(CONFIG_SUNRPC_XPRT_RDMA)
 init_server:
 #endif
 	error =3D nfs_init_server_rpcclient(server, parent_server->client->cl_tim=
eout, data->authflavor);
--=20
2.17.1
