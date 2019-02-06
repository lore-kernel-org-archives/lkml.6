Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE9FC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6B882184E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YhcQQQy5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730156AbfBFLwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 06:52:08 -0500
Received: from mail-eopbgr10069.outbound.protection.outlook.com ([40.107.1.69]:62276
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730106AbfBFLwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 06:52:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N33QUDi0974u+wxLPYuMDGKkMmUEgPI+56hCJXBHMB4=;
 b=YhcQQQy5InX9kvtMvkhzwoQU3l0OtaMOjSdzFHvIJWFuWtWd0Pb37H5bo/JwyUDQzBkJ9Z4hM+OxMZHp5mrpIQydSY4N5ZmGuzraDouMQyKFPo+2aeTbL+sZ+z+bZxIgRpmBleVtQVBefCCvti9idHeJriCvym3XVl2Tn9CqTt4=
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com (10.172.255.18) by
 VI1PR0402MB3743.eurprd04.prod.outlook.com (52.134.15.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.22; Wed, 6 Feb 2019 11:52:00 +0000
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::74fe:7d24:1e75:3477]) by VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::74fe:7d24:1e75:3477%4]) with mapi id 15.20.1580.019; Wed, 6 Feb 2019
 11:52:00 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 1/7] staging: fsl-dpaa2/ethsw: Fix setting port
 learning/flooding flags
Thread-Topic: [PATCH 1/7] staging: fsl-dpaa2/ethsw: Fix setting port
 learning/flooding flags
Thread-Index: AQHUvhJe4kO963Dy/kK4+t+oe164Ew==
Date:   Wed, 6 Feb 2019 11:51:59 +0000
Message-ID: <1549453888-24593-2-git-send-email-ioana.ciornei@nxp.com>
References: <1549453888-24593-1-git-send-email-ioana.ciornei@nxp.com>
In-Reply-To: <1549453888-24593-1-git-send-email-ioana.ciornei@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0259.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::32) To VI1PR0402MB2800.eurprd04.prod.outlook.com
 (2603:10a6:800:ad::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.9.1
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB3743;6:D70YIUuJcKrx00uHDoF3XvJMTpEhpbIvtoyhny+Qp1G9n2nNT7Tkhja4fJCGTnEPuO1MkZ70YqVXkD7L/WsRZa1E0I1D+Ito41hRnyJNXd+4+Cxb0X4pTm5+ga9kYoMuYDKgO7KOEoAKSJlXdGrUiWApnT3NISuyGxOjsf2ENZq8ExmULt6FAUJzK9VzZ55x6OyfqEq2uCfNoVVLwGxYDoqWb65YWpEYFNp1QuHxcjRxtjc1vJJhzHfj+1qydaA8PlP+sg5Ka3ZPfY3RQbz/oHvfBAlw4TKeGR6PVkb+dDTvDpfyXigTSMk/lRLfzfXQ79k3ddWfavAM/PgDBh4Hv5ERuaFBnwApzfuDua6pAlL80mpvv0idKQgOVgeng0HEsu02rHH3LqA6owctffV+HOa6hIYOJ/zVLkqJFLkleQ9W6qXfRhVqnnP6WP7jZ0grScajglhQpgzILjyyS3liVQ==;5:WGQ2FE1LnF69Z7MFsUC5FSQazTrLynqMLUwL2Z+LaJYFcaZg80W12D775eAZPgM/VK1+BrjFYzdZUtmk+kDj9ymIO9ih3G85urd7i/zhOH8cXxijd67Ts6iNgo4jqfinpR4ruoUIBvdfIZsUVE0zDpKQJKoxwTqqPk81RWIghMf/YDIifcog9SqMpZ92krQBWxjdPWaVFjvqlA9+SnNf3Q==;7:SaLHy+P82BJ9n3fI3BW7w1BG5hYQlaoajZSeVXrF9fDLfOp7MLoJZ/GYGnD7lQ6MxOj3lW7rCvkuUhuYePlTiq6ufP8cmItUlsPvpXdw5soJ80/unVp06uTnhvwzY25ndMTU9BymJjpZZ3MPSC8w7w==
x-ms-office365-filtering-correlation-id: 597a786f-fd25-4900-113a-08d68c298063
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3743;
x-ms-traffictypediagnostic: VI1PR0402MB3743:
x-microsoft-antispam-prvs: <VI1PR0402MB3743E9E05FD8D57E0A7786E3E06F0@VI1PR0402MB3743.eurprd04.prod.outlook.com>
x-forefront-prvs: 0940A19703
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(136003)(376002)(346002)(396003)(189003)(199004)(256004)(6486002)(386003)(6506007)(486006)(53936002)(68736007)(102836004)(478600001)(86362001)(2351001)(14454004)(105586002)(71190400001)(71200400001)(2616005)(11346002)(106356001)(6436002)(446003)(26005)(476003)(4326008)(305945005)(186003)(76176011)(7736002)(81156014)(97736004)(4744005)(99286004)(44832011)(5640700003)(54906003)(8676002)(6512007)(36756003)(1730700003)(81166006)(316002)(3846002)(2501003)(6916009)(6116002)(25786009)(50226002)(52116002)(2906002)(66066001)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3743;H:VI1PR0402MB2800.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DUk9S2Q0QML9stav2wgBpHTYv5O9NDaNgWKaokkf/VX2hhQGGEMRidQUAm/FpWNiZXhAv8agnrHVh65KVHH2uXQrhOIV7W6OwyMx7BSL4spKbJXHpvQZ4j935rd/YozVYJFzH/rwYQb6DARwArDYeq9gi/ZVVJlhLHj9vnidnivBQH283TPs8L8JgNnhdsg2j/B4bDVeUOIe4vC0hyv4YCRN0/Va/gZUI7wDQZjpbwdMR7WhceqaDvQJ8y1gIvxSI5nRaIVzVJWf8xw5nRST65aLl4rXidhIT1BPJgTz0TkrW1KZqmg2x0JQ132aVhLDm+dVJ4tzPXvMnHF/fTeVguIbBXxN8B31f/9Lu+XzON1KMbZCraxofVoD/CLkk9ebIBos6p123PaIKS4n3D+BzniJe8MMI9rVbgKDwnRaWHk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 597a786f-fd25-4900-113a-08d68c298063
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2019 11:51:59.3886
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3743
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Razvan Stefanescu <razvan.stefanescu@nxp.com>

ethsw_set_learning()/ethsw_set_flood() use flags parameter as an
enable/disable (1/0) indicator. Previous usage sent incorrect values.

Signed-off-by: Razvan Stefanescu <razvan.stefanescu@nxp.com>
Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-=
dpaa2/ethsw/ethsw.c
index daabace..9463e05 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -676,11 +676,12 @@ static int port_attr_br_flags_set(struct net_device *=
netdev,
 		return 0;
=20
 	/* Learning is enabled per switch */
-	err =3D ethsw_set_learning(port_priv->ethsw_data, flags & BR_LEARNING);
+	err =3D ethsw_set_learning(port_priv->ethsw_data,
+				 !!(flags & BR_LEARNING));
 	if (err)
 		goto exit;
=20
-	err =3D ethsw_port_set_flood(port_priv, flags & BR_FLOOD);
+	err =3D ethsw_port_set_flood(port_priv, !!(flags & BR_FLOOD));
=20
 exit:
 	return err;
--=20
1.9.1

