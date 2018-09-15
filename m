Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB49DECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E2AB21477
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="EwGZOyOz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E2AB21477
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728830AbeIOHEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 03:04:22 -0400
Received: from mail-cys01nam02on0113.outbound.protection.outlook.com ([104.47.37.113]:35712
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728795AbeIOGsm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:48:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ikGquOw69dUu59qHvF0NScGWeCaZQKItnaVxnPNjgqM=;
 b=EwGZOyOzxZuBYe4ed2ukQsKoHW8rBuLZDHtxvREpKm55XLUeU5nmO458SCxIp+e90nP9DBfXbnRhSTfeBRLh2Zx34nz+ioxTpNzJauBvRGyp3aYWpwBMQz8/tll6FEg1bSdEi/3ExGTTZ0Pq7RLUu9O+4b/8A5su3xnhAx7bnPQ=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0117.namprd21.prod.outlook.com (10.173.189.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.8; Sat, 15 Sep 2018 01:31:41 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:31:41 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jann Horn <jannh@google.com>, Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 86/92] IB/mlx5: fix uaccess beyond "count" in
 debugfs read/write handlers
Thread-Topic: [PATCH AUTOSEL 4.18 86/92] IB/mlx5: fix uaccess beyond "count"
 in debugfs read/write handlers
Thread-Index: AQHUTJO9vdJulMWo2E+Nhod6Lno/ug==
Date:   Sat, 15 Sep 2018 01:30:52 +0000
Message-ID: <20180915012944.179481-85-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0117;6:nn+mOzNSIcFhV8mgBCFlnrlQChDDcXbj4eVH+FOuqxWg3OE82/a8+QyL7Kjr+bvoKlTdZLGkAjvL4AUeUHegA4v0bTsVeFlrN7AOJJToAcUyZ03gmHNFKzA+UftBTh28+xLJo0DifAhHnFmrz6mCkgx3Yb+UOriNIWjse4Xt1iw2MqA5r4SWbJrwhWyRCQHgOpbaTZDtxR6WtEcd/b6fjXxP1q+nnlsYGR3WNs3axBH6rGxhcyAogA3P07sG4O4z4VrUYjP6oV+4irk/06GGF1ISNdQkn/NOJ5IsuHBLdiKRjrOXhQU8W3gHx87BsyoxMpz3A9yswJshtQPbAioh5bxYf3RO/4WErD21V3hye68wK5tlbqgV3nGAGH/GTfnR12cXeeUVX1unZAcYKRsMEJPxaXMrdESa3pCaSZHb9YnROB4+PQByAiYndMKS5su0QSEvDnP50qPNnCJITjRKqQ==;5:aTyxgf7IZaGXhTLPWsEwUGZrZkXtltAaN5PxNpqJOQ4TznUOOVgIkO6IN+QqMIKkd/XFFJSVhDtEkt/oyLJhQkFlZiBkaMbdyjNedASYlOa8eU6tDA3c0Hz96PVEBsDIEdOaGVe4i9DQYqFZAGID/q2y28gysqLHVgjrAR/fPYw=;7:8508lDy6B7xSqqzU+ISnUVGMeNMsRP9d3aGKM+2zmzw9oQLn2fzbLdWerQkWwNJnQ2EGiOZ5BoaURm2TxtWPOQfHVgQ/smniIew4Pp3YaiZJgiH1k2dzr63BTIZHyXgM9Z9a+DDr4BdAX+yB1Q5II80vQ9bI6FvNLYgxiiXg5/AR0mCt3cfGpvKjDuM2ZThVSDtqFI2gbYKmVhlkOxFOaGZjP0JHAWZgAXzmpyi2fpikyMoit29BrEV0FltXeI37
x-ms-office365-filtering-correlation-id: fdf3997d-a309-4ee2-9450-08d61aaafd10
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0117;
x-ms-traffictypediagnostic: CY4PR21MB0117:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0117E828319F4F5CD8166082FB180@CY4PR21MB0117.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(192374486261705)(211936372134217)(153496737603132)(17755550239193);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0117;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0117;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(136003)(396003)(39860400002)(199004)(189003)(36756003)(316002)(2900100001)(110136005)(54906003)(8676002)(478600001)(5250100002)(2501003)(66066001)(72206003)(10090500001)(446003)(86612001)(476003)(2616005)(8936002)(102836004)(11346002)(486006)(14444005)(86362001)(256004)(575784001)(186003)(6506007)(22452003)(68736007)(26005)(217873002)(305945005)(6666003)(2906002)(6116002)(3846002)(1076002)(106356001)(7736002)(5660300001)(105586002)(53936002)(14454004)(6436002)(81156014)(81166006)(6486002)(10290500003)(6512007)(99286004)(107886003)(76176011)(97736004)(4326008)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0117;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: wJhEWi8uRneZpwsW+CRQAIh6ITZmpyZgmzybLw/3AmwRbdKl4fB9ZPqLRWA5wM3FEb/ErkSZl1Vvko+5Ty9q/tFlX+cXScW3ZRRxZ+b85B98cP2nWkQ6JRFb4QHk7p5dL1j54IvjOZ2G34/nSWLQF1ckR6VGc0TidFfhTZBBzXQniQ8elnj/k06L3hv7zFCfhI8BKTR51xcf+sax51lroz1GzM3UMI0y0nTJfnqFIwFVDEWg7vubA4wwZ8EV2eEjcHZP1ELGbzgW0SQsdX3tRe0b5TPljyg7je9qHPbrW8a/l3pRwbqKiwdR8NaK278d8vUvjzArmIxz+OJ0kkED/iqmycn9+mh8GdNOW7wl6IE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdf3997d-a309-4ee2-9450-08d61aaafd10
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:30:52.0104
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0117
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jann Horn <jannh@google.com>

[ Upstream commit 60e6627f12a78203a093ca05b7bca15627747d81 ]

In general, accessing userspace memory beyond the length of the supplied
buffer in VFS read/write handlers can lead to both kernel memory corruption
(via kernel_read()/kernel_write(), which can e.g. be triggered via
sys_splice()) and privilege escalation inside userspace.

In this case, the affected files are in debugfs (and should therefore only
be accessible to root), and the read handlers check that *pos is zero
(meaning that at least sys_splice() can't trigger kernel memory
corruption). Because of the root requirement, this is not a security fix,
but rather a cleanup.

For the read handlers, fix it by using simple_read_from_buffer() instead
of custom logic. Add min() calls to the write handlers.

Fixes: 4a2da0b8c078 ("IB/mlx5: Add debug control parameters for congestion =
control")
Fixes: e126ba97dba9 ("mlx5: Add driver for Mellanox Connect-IB adapters")
Signed-off-by: Jann Horn <jannh@google.com>
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/hw/mlx5/cong.c |  9 +--------
 drivers/infiniband/hw/mlx5/mr.c   | 32 ++++++++-----------------------
 2 files changed, 9 insertions(+), 32 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/cong.c b/drivers/infiniband/hw/mlx5=
/cong.c
index 985fa2637390..7e4e358a4fd8 100644
--- a/drivers/infiniband/hw/mlx5/cong.c
+++ b/drivers/infiniband/hw/mlx5/cong.c
@@ -359,9 +359,6 @@ static ssize_t get_param(struct file *filp, char __user=
 *buf, size_t count,
 	int ret;
 	char lbuf[11];
=20
-	if (*pos)
-		return 0;
-
 	ret =3D mlx5_ib_get_cc_params(param->dev, param->port_num, offset, &var);
 	if (ret)
 		return ret;
@@ -370,11 +367,7 @@ static ssize_t get_param(struct file *filp, char __use=
r *buf, size_t count,
 	if (ret < 0)
 		return ret;
=20
-	if (copy_to_user(buf, lbuf, ret))
-		return -EFAULT;
-
-	*pos +=3D ret;
-	return ret;
+	return simple_read_from_buffer(buf, count, pos, lbuf, ret);
 }
=20
 static const struct file_operations dbg_cc_fops =3D {
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/m=
r.c
index 90a9c461cedc..308456d28afb 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -271,16 +271,16 @@ static ssize_t size_write(struct file *filp, const ch=
ar __user *buf,
 {
 	struct mlx5_cache_ent *ent =3D filp->private_data;
 	struct mlx5_ib_dev *dev =3D ent->dev;
-	char lbuf[20];
+	char lbuf[20] =3D {0};
 	u32 var;
 	int err;
 	int c;
=20
-	if (copy_from_user(lbuf, buf, sizeof(lbuf)))
+	count =3D min(count, sizeof(lbuf) - 1);
+	if (copy_from_user(lbuf, buf, count))
 		return -EFAULT;
=20
 	c =3D order2idx(dev, ent->order);
-	lbuf[sizeof(lbuf) - 1] =3D 0;
=20
 	if (sscanf(lbuf, "%u", &var) !=3D 1)
 		return -EINVAL;
@@ -310,19 +310,11 @@ static ssize_t size_read(struct file *filp, char __us=
er *buf, size_t count,
 	char lbuf[20];
 	int err;
=20
-	if (*pos)
-		return 0;
-
 	err =3D snprintf(lbuf, sizeof(lbuf), "%d\n", ent->size);
 	if (err < 0)
 		return err;
=20
-	if (copy_to_user(buf, lbuf, err))
-		return -EFAULT;
-
-	*pos +=3D err;
-
-	return err;
+	return simple_read_from_buffer(buf, count, pos, lbuf, err);
 }
=20
 static const struct file_operations size_fops =3D {
@@ -337,16 +329,16 @@ static ssize_t limit_write(struct file *filp, const c=
har __user *buf,
 {
 	struct mlx5_cache_ent *ent =3D filp->private_data;
 	struct mlx5_ib_dev *dev =3D ent->dev;
-	char lbuf[20];
+	char lbuf[20] =3D {0};
 	u32 var;
 	int err;
 	int c;
=20
-	if (copy_from_user(lbuf, buf, sizeof(lbuf)))
+	count =3D min(count, sizeof(lbuf) - 1);
+	if (copy_from_user(lbuf, buf, count))
 		return -EFAULT;
=20
 	c =3D order2idx(dev, ent->order);
-	lbuf[sizeof(lbuf) - 1] =3D 0;
=20
 	if (sscanf(lbuf, "%u", &var) !=3D 1)
 		return -EINVAL;
@@ -372,19 +364,11 @@ static ssize_t limit_read(struct file *filp, char __u=
ser *buf, size_t count,
 	char lbuf[20];
 	int err;
=20
-	if (*pos)
-		return 0;
-
 	err =3D snprintf(lbuf, sizeof(lbuf), "%d\n", ent->limit);
 	if (err < 0)
 		return err;
=20
-	if (copy_to_user(buf, lbuf, err))
-		return -EFAULT;
-
-	*pos +=3D err;
-
-	return err;
+	return simple_read_from_buffer(buf, count, pos, lbuf, err);
 }
=20
 static const struct file_operations limit_fops =3D {
--=20
2.17.1
