Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 029C2C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A58F02087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="DCtVXD3f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A58F02087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389139AbeIXUyD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:54:03 -0400
Received: from mail-eopbgr720095.outbound.protection.outlook.com ([40.107.72.95]:35088
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731770AbeIXUyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:54:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HJ6sn+z5qvsmCfexbSg5NFMgNNTL97LyyrRlptzSmhE=;
 b=DCtVXD3f3rg88CKkZ2fZ0JYspTGinHfh/dtPQ3F7Vas5kUwqXbetkAZThBj6zSVAuZiLl8ioMPdvFv3x+E6Coomq6Rp3QX0ah0jdNsUuN/YB6c2u4VmKn7hxYXzvFD89Ld9DNEbusw3TKvpEWFI/D556ccud12iWiWs38wwckC4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0821.namprd21.prod.outlook.com (10.173.192.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:51:09 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:51:09 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 10/18] i2c: uniphier-f: issue STOP only for last
 message or I2C_M_STOP
Thread-Topic: [PATCH AUTOSEL 4.4 10/18] i2c: uniphier-f: issue STOP only for
 last message or I2C_M_STOP
Thread-Index: AQHUVBXYbA+9vef5DUC8taMx6Pnnuw==
Date:   Mon, 24 Sep 2018 14:49:50 +0000
Message-ID: <20180924144942.164688-10-alexander.levin@microsoft.com>
References: <20180924144942.164688-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144942.164688-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0821;6:hnxdpJQo7SvIR4m7TO4NrACxidsjEX4TRNmgeHynpgscAgcX+1+x6zxA4DkmSCvcA9usbIv5KBK6u6g7/pno/CJjeBRk7PmXwBaUT2wvWt2JfkFKD78KpnvIQkio0lo/d7bYBhseCBnbcdb9XEGv/bjWjvKUwm710byu6hLaCL4/xaCXqLpf9zzzdu96H1sxDEQFM91qgUhKfiaZDnOuJEA4FdwZSPQVwSeermBSyxytAnVkJjKg2oHh9FG/aOOkftdMyHyT3bo6TVisXXvVAcMnkKNr4VLZ2d/dij9VgafjucLj2OaIuRka+N5olNNsZ4aX0RZKj82TWrXUGqq+TNR1WvHVkxt0Bw+DsxEXf2HkN0Qp57BqA74KLz5FkTYLgx4u5lxC7g4jCO6yEyEHm1XmsPfLNi02772X0lGe3bDIg4OlSZzH82zygpgAQN+jOlICy7wHtn2QnDSScuhvZg==;5:Qc5nJGO+tO6BYjp7+tQNK9UG7czL1+YWyYbrgxILJtdK4ApSlh0NLiSGNjkg7kMDqGM/Q9GH2pOCV2iaxTzvcIxbESml5AY9Wteti5PjrjKJ/0Ys23TItYIsVq9C6V9/7OuO0LZ933i5EOuR1Io/0yt1LnD5qRRetylq45D6Wjg=;7:CUsyMZr84VfO+dW8QpCkipzBM1mTx9I5zNZwWuSX3XzFKmWUISQquts1snyuG/pGgerLq0oiZYvBtiu2pmpWWZ2PH+SV0ycHMRdYXmoxodLji8xO9qEGrjSkrjUnbw99Zu3FghaQNPAIRgtKlNYCdz/XpCHzynSWNagiJkJGU7lqKiPW7wmyShS2lrxfd5/I3H4zs9MPyYiIid0wcs+jj3YYghfYHyEvP+QXSE8xxtiDAaJ0SjUpz1kROWDJYaoc
x-ms-office365-filtering-correlation-id: 9e59fea6-4986-4731-509e-08d6222d29da
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0821;
x-ms-traffictypediagnostic: CY4PR21MB0821:
x-microsoft-antispam-prvs: <CY4PR21MB082187737C281ACF62CFB955FB170@CY4PR21MB0821.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149066)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0821;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0821;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(376002)(136003)(396003)(366004)(199004)(189003)(102836004)(5660300001)(53936002)(6512007)(6436002)(256004)(217873002)(6666003)(6486002)(2501003)(15650500001)(10090500001)(2906002)(68736007)(5250100002)(97736004)(107886003)(66066001)(36756003)(4326008)(25786009)(1076002)(3846002)(6116002)(2900100001)(8936002)(81166006)(81156014)(8676002)(86612001)(575784001)(86362001)(7736002)(305945005)(72206003)(186003)(26005)(10290500003)(6506007)(6346003)(478600001)(14454004)(110136005)(2616005)(446003)(11346002)(476003)(76176011)(486006)(54906003)(99286004)(105586002)(106356001)(71190400001)(71200400001)(22452003)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0821;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: jgew6Nq5wbml0TJSFwDZXb9nQDfokQ8Y9D61m1Jb8DUEmZ9FLRguW/JqDUB+ZHaM6i+SDGeeZo10NBcYbZbRq4iVOOaAhvsOwDyr0xM5TubMd/si3SyHwEZw39kp//s81cf58anwleDZvuPMFIQ4zm92+pq58HyszEy9MikSg2nGHr5yUyFU86D4A2U5G1Dar0fM+MjgGRTD7GiKA5U9kYS2V4wI7nyQB6s+uU7y7wmT58/OFR6ZXHBZThKsh0BWivSuT9Di7u5cK2mru4BRooX/faAGmz2aqUgnXQS2/CsJbUlfj3Giam0NkoRNgh71fX2NCP1fSGtpK4EY4s6o2Jh1uTan5g4L40Jj+zyablY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e59fea6-4986-4731-509e-08d6222d29da
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:49:50.5663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0821
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masahiro Yamada <yamada.masahiro@socionext.com>

[ Upstream commit 4c85609b08c4761eca0a40fd7beb06bc650f252d ]

This driver currently emits a STOP if the next message is not
I2C_MD_RD.  It should not do it because it disturbs the I2C_RDWR
ioctl, where read/write transactions are combined without STOP
between.

Issue STOP only when the message is the last one _or_ flagged with
I2C_M_STOP.

Fixes: 6a62974b667f ("i2c: uniphier_f: add UniPhier FIFO-builtin I2C driver=
")
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/i2c/busses/i2c-uniphier-f.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-uniphier-f.c b/drivers/i2c/busses/i2c-u=
niphier-f.c
index e8d03bcfe3e0..3f6b43fe4d5d 100644
--- a/drivers/i2c/busses/i2c-uniphier-f.c
+++ b/drivers/i2c/busses/i2c-uniphier-f.c
@@ -394,11 +394,8 @@ static int uniphier_fi2c_master_xfer(struct i2c_adapte=
r *adap,
 		return ret;
=20
 	for (msg =3D msgs; msg < emsg; msg++) {
-		/* If next message is read, skip the stop condition */
-		bool stop =3D !(msg + 1 < emsg && msg[1].flags & I2C_M_RD);
-		/* but, force it if I2C_M_STOP is set */
-		if (msg->flags & I2C_M_STOP)
-			stop =3D true;
+		/* Emit STOP if it is the last message or I2C_M_STOP is set. */
+		bool stop =3D (msg + 1 =3D=3D emsg) || (msg->flags & I2C_M_STOP);
=20
 		ret =3D uniphier_fi2c_master_xfer_one(adap, msg, stop);
 		if (ret)
--=20
2.17.1
