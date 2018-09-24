Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10DE7C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B22E12098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="QUJUSwgD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B22E12098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733175AbeIXUvj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:51:39 -0400
Received: from mail-eopbgr690129.outbound.protection.outlook.com ([40.107.69.129]:55616
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733009AbeIXUvh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:51:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=38ePBoYt0LmN1jhM9rv26rIrhCKdt3Ibrx2fumzgZUY=;
 b=QUJUSwgD90C3Qf4znP4gqgwp0lmBiFm9g2AmCcia07GLxMbzQkur5C313wrFAPoQrXNZeDdXOqSzmw4NUw4fpE4xZylT5F6pNEumrSVj45Ah0QCt86CtECf9ffpHWAc6SKnOndgVRWwMHjo3NDT7zr8A/4V22FMxJMm9yCp4EkI=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0744.namprd21.prod.outlook.com (10.173.189.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.2; Mon, 24 Sep 2018 14:49:00 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:49:00 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 54/76] i2c: uniphier-f: issue STOP only for last
 message or I2C_M_STOP
Thread-Topic: [PATCH AUTOSEL 4.18 54/76] i2c: uniphier-f: issue STOP only for
 last message or I2C_M_STOP
Thread-Index: AQHUVBWrJYaaelVMBE6nADoYOuhtRQ==
Date:   Mon, 24 Sep 2018 14:48:34 +0000
Message-ID: <20180924144751.164410-53-alexander.levin@microsoft.com>
References: <20180924144751.164410-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144751.164410-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0744;6:M2uGOsMRJihf03R5QjzXAAeCALjs4xhVeBi3eOWX591b1BhpMAplO4gIZ/aS9hIM9inzTcJiOBSC6qt/olpAL6CpBvzOpQLKhbNki67pdxEyJEFUeGRnL5ulThpTIDSTmSga+ZoTZ9HX4p3ozz4ArD6Yv1ZE5jh+i7Gwf2iHxNI1/bVWDXGl3lQPqqnlpX8MWImDlc8w6SboLU0tMSs8tY7/QdMKrx2Asqp/mbFHf2ULDQOKyUI9c1i6YmfO9f4EeRSSdklbVYfFXBy6plLHgQjfFYzj4jOHtbAf6mHcX3gVqepVXPyHYNYWB9NplzDQ3a7x9/VzEjwzZje+dilXtr/bCH8vwU7FzbhCeTwQKjV0VYsNBOJGsKUpoCo4HZr5tKChb9uw2YSFGIaxOAcMwdWVS9lh7lcMk2aG5Z/Nrp1X/FsKOJI6kv9fwJHRaFswgOr43qOxH6pOXnQ+3zhL2Q==;5:RfMG8Cmrq1WkPJ3+X4oVn03o9/P/BEDRKoCr/YIspevtBYZOKPlKl+9ZfoAgkn6zYyef9TGLhzvdkhz+oDY3ybY+qHjMbuUEK7CIhm5ckRaqjW2SbNHeMpTPjeRRUn20q32th5leH8LiDJy9+k37O1wLvLqXb6clV3sryndCCFM=;7:sE4V9LsrPRSCNh8ol8cPVJ7uCxX3+wdkmAMkqPMtttxyz7UpSCJm1rGxQ4J8wZ/7R6cxba2tLy73abEAe1JpPNFe4NocK5dwlIe6DYyXA0EebE+opMUF+3gqUoBXKD/LWyoGOyNuz9gsEPdXgYikLaPAisnkwG84dszejyowPlN8KDv9k6mYL1xsQ/+/yd2ekP4woW59QIpE7CFNUf7j20trcV+bqG5Zjyfc6N8gc2D6se1BnogNNVwECK2qpIL4
x-ms-office365-filtering-correlation-id: ad711d66-3f7d-4fc5-59a9-08d6222cdd5f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0744;
x-ms-traffictypediagnostic: CY4PR21MB0744:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0744AC44A81BDAE14483FA92FB170@CY4PR21MB0744.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(3002001)(6055026)(149066)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0744;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0744;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(346002)(39860400002)(376002)(366004)(189003)(199004)(11346002)(446003)(476003)(86362001)(575784001)(186003)(81166006)(6506007)(8676002)(81156014)(6666003)(5660300001)(486006)(99286004)(53936002)(305945005)(6512007)(6436002)(2616005)(71200400001)(71190400001)(68736007)(6486002)(102836004)(10090500001)(7736002)(36756003)(97736004)(86612001)(316002)(3846002)(6116002)(1076002)(217873002)(256004)(54906003)(110136005)(107886003)(10290500003)(4326008)(478600001)(22452003)(15650500001)(5250100002)(26005)(8936002)(2906002)(2501003)(2900100001)(66066001)(72206003)(105586002)(14454004)(76176011)(25786009)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0744;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: NjVwxmfDgFKvlBSdp1lcG6+2KeLxTarf1WYdROoPgXgMDqOyYWFFybo2pgogvBYAPVG8EAvbmUKk6n7UlppYFOIRgV3sHRuX7c+L/EdDuS8UmPAw7dX4n3DiYHeBlpfY2K+dLHFwvf7KByv8HiamIfZDzs3c7U1Fsj0oGM9lDSxsyqttACdnNv5RynlPYRadXugpEuViBlVIV8MladTZbTN1XkTaqWeGiSjkdYzlPKEiLRIr1nlSehZ+edkNnpI3nIxr7nPDwh1ucc3b8idWYK1HbtAcCzz12id0HNMvQuZhLZIGxaj8aV1F6428YVsZiCK+xsxgQJOf0unyF+raMRU1YGv+Kg8WmQNnnAjimFU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad711d66-3f7d-4fc5-59a9-08d6222cdd5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:48:34.6017
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0744
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
index 9918bdd81619..a403e8579b65 100644
--- a/drivers/i2c/busses/i2c-uniphier-f.c
+++ b/drivers/i2c/busses/i2c-uniphier-f.c
@@ -401,11 +401,8 @@ static int uniphier_fi2c_master_xfer(struct i2c_adapte=
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
