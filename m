Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF61AECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77B972087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="n9FRslMU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77B972087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732463AbeIXU4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:56:33 -0400
Received: from mail-eopbgr720135.outbound.protection.outlook.com ([40.107.72.135]:34196
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730562AbeIXUyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:54:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JabxhZx4zYpK9NOq523+ugIOzC+qZKM9Q5NA6kHsL/k=;
 b=n9FRslMUGUqtmzS2bwinK89UuJKfbaPBAW6mOmukaNp4ozctif+1Uf8c4wwCQ80bwypAmTXkczQxevhJwSPxtUXSNX1QcEZ40vXRI7iJe3BO5FYf4rxUqC956rQCc8imp4/EIOSlFsIZ1MOvUADQfovlglrVOfupqDMZwQ/mH9E=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0821.namprd21.prod.outlook.com (10.173.192.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:51:08 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:51:08 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 09/18] i2c: uniphier: issue STOP only for last
 message or I2C_M_STOP
Thread-Topic: [PATCH AUTOSEL 4.4 09/18] i2c: uniphier: issue STOP only for
 last message or I2C_M_STOP
Thread-Index: AQHUVBXY4XdFe6HyYEuBr3XQgbgyUA==
Date:   Mon, 24 Sep 2018 14:49:50 +0000
Message-ID: <20180924144942.164688-9-alexander.levin@microsoft.com>
References: <20180924144942.164688-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144942.164688-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0821;6:P81Xc7O83Ge3Z/Y4ey+76FiNoPSISGsH55/C4mkO1J/PqhWmSmr5TtOtmgJrJlYXsfKAgZbZxhCmVeORjshfbfJqEovTVNSov8PVpkwp2eeDxkmRMGDNXWPb2lKqS5SlYUWXg8VHdtyds7p2anKaYsUnH+kfitwBsPHWkyG/jMqdL8qisrhN6vaeYZ1AouPru/addgaQv7v0ZHPNc+gEyxAb6bejmOZTyIfYwRECofymETn+v/djrPtvJxSSMZp4TVkQqWl8slW/W9pYXx7IvlRCk1+P0pAqrXniIEOlXmUfmgJvZrPUAbAh6NuSiUzmWWJkzkHxhECeZ/b07Abv4jjbvC6BvN+wqvSnHD/wlPW3uRALZcsEMBvOuK1uza4MMq1xJm0AKLZKYPS8zm85JwAs0raTwmKMdhJr6IeT/dajCj3JZ1BstiArboHhJAfTwkx4CSjxDMP9LelbrRXJdg==;5:NtK2DA9PHy1NVcZMVVXwE19cFAEqxqYpC7h/2n7uZXeTo5OYvo3kBbENDnIaj5q0d3Ulx5IvrXVl4Yp96bBdy98S6LRMrPqBEY97vsAiCO14WNYPsJhZ3yhHkjuS/cbAiiKxfJ+0Q1Y6XKHuwwJsDhNQZ2g6cpvvzf+1706DJ84=;7:Oqf2mYY3vT03lJbTyITocb8phtVsO0jwWa0laiRDg65oDTrKmlfpW3XU9WWmQ5WWEJ4Eq0Izt5rLHdD9pX/a4soN93YNp/4kU2v/vcP8YO6W+vzhY9hXBSQaE+Mur3FXZ7d0mp3QSvZezfd/9ZJbZc1MH4uewpess3MpWiLWKC5M4sJdIIFYlzFqUUxp9xGAUceJzgLqsg2ZnUFfwm/hu0ibWg/1yOJDmOQO16cK46rUBrKqH04xBd1+hU5OpNp0
x-ms-office365-filtering-correlation-id: d8ca4ede-8faf-4501-a4b6-08d6222d29a3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0821;
x-ms-traffictypediagnostic: CY4PR21MB0821:
x-microsoft-antispam-prvs: <CY4PR21MB082139458E0ECDA2952279E5FB170@CY4PR21MB0821.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149066)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0821;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0821;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(376002)(136003)(396003)(366004)(199004)(189003)(102836004)(5660300001)(53936002)(6512007)(6436002)(256004)(217873002)(6666003)(6486002)(2501003)(15650500001)(10090500001)(2906002)(68736007)(5250100002)(97736004)(107886003)(66066001)(36756003)(4326008)(25786009)(1076002)(3846002)(6116002)(2900100001)(8936002)(81166006)(81156014)(8676002)(86612001)(86362001)(7736002)(305945005)(72206003)(186003)(26005)(10290500003)(6506007)(6346003)(478600001)(14454004)(110136005)(2616005)(446003)(11346002)(476003)(76176011)(486006)(54906003)(99286004)(105586002)(106356001)(71190400001)(71200400001)(22452003)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0821;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: +o/TF6dJWwJGfCiLVcrvgXn4F6ZtybHDMRovFeXBSpkM5/6BTp77V2LTUo9vO7m34jMQ5CEEDcwZszPfsEW/q6kU+/SvYSqUTsjtcFVfKOZXdZsN4jUMR8Mw165B0Mxg1qvFZ6AiuIH/Pqxh7ezfZYa9TCniYCUUGqzDsqKkRogWLWYAG2By0KmsxO9hrA5Ap5GKXGoeafzKyk/oWtt/pOfnMNEj8wdZ9XfA0qYjwS9nxCjHXWF+vevHY4YALq7YJDP/kxPsYfNt8lWOdrO+OeyNSCT2XZ+Z5W8tGD2AZz5nqNLAcIEU7iwFw2DyOAomHxVCaXZEASNhL76naM76yvX6jDX79eko/sJ0N1D/o7I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8ca4ede-8faf-4501-a4b6-08d6222d29a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:49:50.0979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0821
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masahiro Yamada <yamada.masahiro@socionext.com>

[ Upstream commit 38f5d8d8cbb2ffa2b54315118185332329ec891c ]

This driver currently emits a STOP if the next message is not
I2C_MD_RD.  It should not do it because it disturbs the I2C_RDWR
ioctl, where read/write transactions are combined without STOP
between.

Issue STOP only when the message is the last one _or_ flagged with
I2C_M_STOP.

Fixes: dd6fd4a32793 ("i2c: uniphier: add UniPhier FIFO-less I2C driver")
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/i2c/busses/i2c-uniphier.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-uniphier.c b/drivers/i2c/busses/i2c-uni=
phier.c
index e3c3861c3325..ad5eb8bacc6d 100644
--- a/drivers/i2c/busses/i2c-uniphier.c
+++ b/drivers/i2c/busses/i2c-uniphier.c
@@ -247,11 +247,8 @@ static int uniphier_i2c_master_xfer(struct i2c_adapter=
 *adap,
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
 		ret =3D uniphier_i2c_master_xfer_one(adap, msg, stop);
 		if (ret)
--=20
2.17.1
