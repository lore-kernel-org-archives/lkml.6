Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73344ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22E912147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="f3xC7Fbr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22E912147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729752AbeIQI5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:57:08 -0400
Received: from mail-bn3nam01on0109.outbound.protection.outlook.com ([104.47.33.109]:29664
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729283AbeIQI1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:27:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oXNyDZPXxOp+eO3Sbo7LuWKtU1UM0YCKHO5cOxnq+3A=;
 b=f3xC7FbrCe7rTaBTTXkZvIwv3Rm2sJDYYVXBvDIpbWpBJEzVhm1zukE7T9AxMQsu8eJUjJKa6LDrqoEaTLCnxzvYYH5M41hK4bdSpCJeBFqdyjG4Sk1SN9VFJelnxlJuUEa6/n9JmZRbIdLvR29wROJrn3v0Rtf+88+8qN7s4K4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0502.namprd21.prod.outlook.com (10.172.122.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.7; Mon, 17 Sep 2018 03:01:58 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:01:58 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Akinobu Mita <akinobu.mita@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 074/136] media: ov772x: add checks for register
 read errors
Thread-Topic: [PATCH AUTOSEL 4.18 074/136] media: ov772x: add checks for
 register read errors
Thread-Index: AQHUTjKoYJOGgba8U0qS8toVWsu13g==
Date:   Mon, 17 Sep 2018 03:00:58 +0000
Message-ID: <20180917030006.245495-74-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0502;6:6UTkDlgw0POcD52qNqVzNfWNbihPvVq9o7C5xI+VjLtonVYaV98URYke/pO+VLEXZNpkQOA03VWIlgzos2VvJyPfmc7c+x0+IC8OsvMjccT5qXSldH+Znl00/NRi7yftOboHZZ4c7BSyo7xIgw+BypVPHeKY8lWXiStJSOaNb6+LMlCIKbF1q0fwqVh2WfEMQXCewK7w7ZmtHJsxhP7fgIy2Ct5OR4mjrDLTkco7zaKinBgJnByAwVEdEy0/yR8luwiVLXxbTfwsmd3385J9HNNzRrwkQ9vl3rVPsCYhFngbI6gohXKxCOjjjnPYnAoV1UUWYsUw6fH62HSPeKxlOFCFVmaJFN06DTLSjk+NnS48XIe5cldq2GponctStxhWunYAK7qzFIh97cyhJWw2evfzWOqrkxcyNCOBLfkwkG/fD/DzhalerqMNWrNFYPBYW3FYGC6TEAY9ewci2SmzFA==;5:1mrQ/334J9UOgkCP4oLQQ+hWo53ThShwXcGfGeD6rYSNebD6wjmpOfmDHAzB4gLYrNl67S7cfz4c/nIC3RoZb/v6lpYEUMyqXhp6kF9Iv31TBuj204ej2ZVUysAPdx2kkTfCWiq5ZnszHt39nEc7ZLKb7Nh8d80eI/MqkFmlRh4=;7:pr694qilFrT071h++2qLFfSsPuS6+4nVYPVohMGqCfN+kE/SB9PVTqrrDO+j0spaGZo9xeiDdsbAARaBXjrD5m/ssAE91dI1agmoGjcpCsa9WcrvHPs8p6s2qrPrcUtEFqEghFIkmGHGg1UV4YXSdOq811v5XE+BI6KpjiY76x5o/oW8t0UF3q3bNMict7Kr3B4T5HWjNtPJ7g3G0IgBsDkJhjGuMoWmBcZba2sYdeH/+x0V+aF7MCkC6xOYpN8S
x-ms-office365-filtering-correlation-id: bd8cb8fe-dc5b-48f7-2980-08d61c49ee9e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0502;
x-ms-traffictypediagnostic: CY4PR21MB0502:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB05021366611D29AF25E3899DFB1E0@CY4PR21MB0502.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(95692535739014)(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(2017102700009)(2017102701064)(6040522)(2401047)(5005006)(8121501046)(2017102702064)(20171027021009)(20171027022009)(20171027023009)(20171027024009)(20171027025009)(20171027026009)(2017102703076)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0502;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0502;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(346002)(136003)(366004)(376002)(189003)(199004)(86362001)(2616005)(99286004)(5660300001)(1076002)(6116002)(3846002)(10290500003)(39060400002)(2900100001)(72206003)(68736007)(8676002)(22452003)(26005)(217873002)(86612001)(486006)(76176011)(66066001)(102836004)(2906002)(476003)(186003)(256004)(6506007)(446003)(11346002)(36756003)(316002)(5250100002)(6512007)(97736004)(2501003)(107886003)(110136005)(54906003)(6486002)(8936002)(53936002)(81156014)(81166006)(10090500001)(25786009)(305945005)(7736002)(105586002)(106356001)(478600001)(4326008)(14454004)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0502;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: vjzYbSLf6ksm3WGaYMrIpPrJjUKdB6LcojuUlq8rVNJKGEDcqpcbFSFab1v/+7PFTwhACVvecXeN6hOP0rk1I8hevxR8qUQk8ETnGEsfJXKzHtSbxSnhoU8WBW07rS1X7f0gMycNhIx9+n7wjb6AGs0Hn5KtnthsYr75P/USCpB0eZ+3EJpr3++QU5mxubhIiQFt/cKMRUK4uTtfZ0mP13Qv+SUdi5xstgSr3eMt3m0hfXhvPYBwkNt6g618fQATdw4tnVeb/AxVej7S4rZwxTvPCl6mYNqpEMrPVLRDR4RGUYYFDM66VFEPtUwV0Tb+Z7Qv+qXsIRLrhZ8ZmB1vyZaXmZ5BeHA9NvYHj+n7G54=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd8cb8fe-dc5b-48f7-2980-08d61c49ee9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:00:58.4637
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0502
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Akinobu Mita <akinobu.mita@gmail.com>

[ Upstream commit 30f3b17eaf4913e9e56be15915ce57aae69db701 ]

This change adds checks for register read errors and returns correct
error code.

Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Hans Verkuil <hans.verkuil@cisco.com>
Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/media/i2c/ov772x.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/media/i2c/ov772x.c b/drivers/media/i2c/ov772x.c
index e2550708abc8..ef6581e56753 100644
--- a/drivers/media/i2c/ov772x.c
+++ b/drivers/media/i2c/ov772x.c
@@ -1136,7 +1136,7 @@ static int ov772x_set_fmt(struct v4l2_subdev *sd,
 static int ov772x_video_probe(struct ov772x_priv *priv)
 {
 	struct i2c_client  *client =3D v4l2_get_subdevdata(&priv->subdev);
-	u8                  pid, ver;
+	int		    pid, ver, midh, midl;
 	const char         *devname;
 	int		    ret;
=20
@@ -1146,7 +1146,11 @@ static int ov772x_video_probe(struct ov772x_priv *pr=
iv)
=20
 	/* Check and show product ID and manufacturer ID. */
 	pid =3D ov772x_read(client, PID);
+	if (pid < 0)
+		return pid;
 	ver =3D ov772x_read(client, VER);
+	if (ver < 0)
+		return ver;
=20
 	switch (VERSION(pid, ver)) {
 	case OV7720:
@@ -1162,13 +1166,17 @@ static int ov772x_video_probe(struct ov772x_priv *p=
riv)
 		goto done;
 	}
=20
+	midh =3D ov772x_read(client, MIDH);
+	if (midh < 0)
+		return midh;
+	midl =3D ov772x_read(client, MIDL);
+	if (midl < 0)
+		return midl;
+
 	dev_info(&client->dev,
 		 "%s Product ID %0x:%0x Manufacturer ID %x:%x\n",
-		 devname,
-		 pid,
-		 ver,
-		 ov772x_read(client, MIDH),
-		 ov772x_read(client, MIDL));
+		 devname, pid, ver, midh, midl);
+
 	ret =3D v4l2_ctrl_handler_setup(&priv->hdl);
=20
 done:
--=20
2.17.1
