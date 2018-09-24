Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD15C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56D7D214FF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Eus/aO7L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56D7D214FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388955AbeIXUxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:53:49 -0400
Received: from mail-by2nam03on0094.outbound.protection.outlook.com ([104.47.42.94]:22973
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388790AbeIXUxs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:53:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yUu70jNJEhWhEeJ3iwIIxbBDfI9adUJRG+xb4PSLYwE=;
 b=Eus/aO7Lk/1cVjbm0gW34AuiW6g2JmJn1Zy3KYR+5+oZfXR4AY++5sZ56dTguCRai1ZkWc5rL/+r9B2lKd1+eJ/JKNQcMvSHLi2eA2bjPzLxpH8GzYnZuKiGKtG8E/h+rIhW8ANqY4eibwgNd2qM76C0HvnJxE8gOiYp/W+Ynu8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0181.namprd21.prod.outlook.com (10.173.193.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:51:00 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:51:00 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 14/23] i2c: uniphier-f: issue STOP only for last
 message or I2C_M_STOP
Thread-Topic: [PATCH AUTOSEL 4.9 14/23] i2c: uniphier-f: issue STOP only for
 last message or I2C_M_STOP
Thread-Index: AQHUVBXNsuOXFxGVi06eWb2lP0qCnA==
Date:   Mon, 24 Sep 2018 14:49:31 +0000
Message-ID: <20180924144919.164617-14-alexander.levin@microsoft.com>
References: <20180924144919.164617-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144919.164617-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0181;6:aT4zBPPMtftBDEUiwVclEKGaPOPFelsgllcDXXzqBv5K1okJCzj3jiNU6dFq0gqRJ4f7BrliA2gcvX9QJHLtRvvjaA3sEu/HHguPpHE7Vu/YAGnGJD+V4TrNENW0OIoGxTpdD7RTNpk6M3nPqDzX7m45hKUo8pMUwXaGPJTG/Ib0RKiYWRs+OlAP7V00dLMe7gp2WnWNSOLDkIZIzXO3T1N43HpV1yAmW1jLAN2RGabiybNQi4N8KIKX832KdAcVhM+mmUneiOCFo85LZuZFvyWBUm3b+c/YE4lKhvITc1FjJoGuFaEDE3Bvl8O5ezlQFtcqdRG+FDm6041QxldIGe5lcvWcxNuh2RwWYfLj9buS9y8OL0reGIW0Kbdp0TVWyf6nDBnXTpk6zfZI6hV6yNzK3dn51IUu5I5UhaTzk5bUpejnf8qfLd3W56/6U48K+sweV4+0T+C3h9kkjZI7zw==;5:BHLhVAmLPuM5kORVDwnPsyl8YiYy/pWUwFGzQchHTg5GR2TxSzS6ez/yT16Mon2gBZXqGIw3YlTFiNg+gMCLEAskCJrQk9rajXrnVMVxKdb5HpGBkp99eWpiiR//TyZiVNX5iNIn6QUzPilFa/1WKytWCRMKOuWE3XKehNwm3K4=;7:qre7gIHP8CX7G/D4WqD6EkbTJSHYUx/GQk3rSBpAMSuaaxHyzLOV4cLXPpf4D9N8svQWDR+pHI7anf46ZsMdJzik73wraDuc0Xnn9OCMSha54br54WwXNMCmCMzJs4WH6sCPo49X4vdy9fgJrqwNtWIqWlaNAqdegCXgyNoqDwCeGHJBMwJU7VSAGVEI0TL2T77ZxpWEbgqCZQ026V6N5qEX7kYSBc90GoojBrJdkyrtKHiQTJtlXNWEGTRWuM+9
x-ms-office365-filtering-correlation-id: 9553365f-e2e1-4634-52ea-08d6222d24fc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CY4PR21MB0181;
x-ms-traffictypediagnostic: CY4PR21MB0181:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB018134ADE06E88DAD4FD8E41FB170@CY4PR21MB0181.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(3002001)(6055026)(149066)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0181;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0181;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(366004)(376002)(39860400002)(136003)(346002)(396003)(189003)(199004)(575784001)(10290500003)(6116002)(26005)(102836004)(3846002)(5660300001)(22452003)(110136005)(10090500001)(8676002)(15650500001)(1076002)(54906003)(105586002)(186003)(316002)(106356001)(2501003)(6436002)(97736004)(6486002)(107886003)(7736002)(36756003)(478600001)(72206003)(14454004)(71200400001)(71190400001)(305945005)(256004)(5250100002)(217873002)(6666003)(2616005)(68736007)(53936002)(81166006)(81156014)(2900100001)(476003)(86612001)(4326008)(8936002)(486006)(99286004)(6512007)(86362001)(2906002)(25786009)(66066001)(6506007)(11346002)(446003)(76176011)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0181;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: prdSeWAYiD1qpj8Mp66u8OBP/8lb434kUoUCkb/j3rihs8XQi5NZed6YZUQHSRCzTfIYTC2B00wjZAFavVp0EEEjmO4y5zyoTCRbryQWyaE0Ytmt/8SWp13aoninK7QTOuQU8XmyftD092zxKdQBhVwJLMogauEV9kZoKuZk2t+s86dSJUcGtmW8qV6FP+vo8iUjkkQ235X+zrVsy2W9kuuv42Eb6YXziPPTCpvA1xXt0gx4XmSylui3R+dN/hnjKNHOBJK6JkI/kZ7ib/T8SA0sUZGhFeJqISM8eOp8CWcTZeo1Kn5qh0RqpEv6kR36lhgFJrK0jRsz1JqwzvcFnTQceeMBmBQ0m60Kfj9AytE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9553365f-e2e1-4634-52ea-08d6222d24fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:49:31.6337
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0181
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
index db9105e52c79..0da4991dd356 100644
--- a/drivers/i2c/busses/i2c-uniphier-f.c
+++ b/drivers/i2c/busses/i2c-uniphier-f.c
@@ -400,11 +400,8 @@ static int uniphier_fi2c_master_xfer(struct i2c_adapte=
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
