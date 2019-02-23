Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 580DCC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 08:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12F8B20684
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 08:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hr5gsab8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbfBWIsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 03:48:53 -0500
Received: from mail-eopbgr00058.outbound.protection.outlook.com ([40.107.0.58]:40992
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726043AbfBWIsw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 03:48:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bpbTdDrKo+7cESGxClZRP1FQfgMsumJO69ae+l+VN0M=;
 b=hr5gsab8+2LdmNuPVopKBoJZeYt7rOcys+tOfjvtaaNYGMN9Mv7NdBW6uapAZUbkb6nFdHwdzU8nQ4aWITVEvE8/f032rLfwKvapN/pPtH9zIq8Updk44nsOJp2tAxf6HIoH5DejKqJlkua4kK1dDXpDS5rJVjn7lbZudi2qfiM=
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com (10.172.255.18) by
 VI1PR0402MB3855.eurprd04.prod.outlook.com (52.134.16.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Sat, 23 Feb 2019 08:48:48 +0000
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::74fe:7d24:1e75:3477]) by VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::74fe:7d24:1e75:3477%5]) with mapi id 15.20.1643.019; Sat, 23 Feb 2019
 08:48:48 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     Leo Li <leoyang.li@nxp.com>
CC:     Roy Pledge <roy.pledge@nxp.com>,
        Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        "brouer@redhat.com" <brouer@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 1/3] soc: fsl: dpio: enable frame data cache stashing per
 software portal
Thread-Topic: [PATCH 1/3] soc: fsl: dpio: enable frame data cache stashing per
 software portal
Thread-Index: AQHUy1SXrb9aUlm5bU2xUZ+TgixJJQ==
Date:   Sat, 23 Feb 2019 08:48:48 +0000
Message-ID: <20190223084816.28985-2-ioana.ciornei@nxp.com>
References: <20190223084816.28985-1-ioana.ciornei@nxp.com>
In-Reply-To: <20190223084816.28985-1-ioana.ciornei@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR04CA0061.namprd04.prod.outlook.com
 (2603:10b6:805:2a::38) To VI1PR0402MB2800.eurprd04.prod.outlook.com
 (2603:10a6:800:ad::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.8.3
x-originating-ip: [64.157.242.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bbd4196e-42c2-4509-1f5e-08d6996bba25
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3855;
x-ms-traffictypediagnostic: VI1PR0402MB3855:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;VI1PR0402MB3855;23:Pp7gxlE+n7Laq4Wy0zA3HIsj/3P7cAk7C6Miu?=
 =?iso-8859-1?Q?B18YeyL8/dK8ktAwbN4pRz9DfqEdh8powezBdIS3rIMUu5M8gyIAou6EN+?=
 =?iso-8859-1?Q?b3GZ5vDzXyW56HCBwt65I9RndhtUGlrL19sMQeaC3qpJELiCzotvm+E/W7?=
 =?iso-8859-1?Q?Aq+gCMRccSTVCRfoaOWL/4PchaH56GJKWIuOHTOLOXV8+VRea+TKlUQB0K?=
 =?iso-8859-1?Q?tgkzKxh/McySKkYREmQgKR+T4pgmQJHwWMXVFrFj+yxHt+SiwGUuqr53ww?=
 =?iso-8859-1?Q?Zinu8kFfdqAUv4v4+kczYLDeu7hHAnQ+WkwVM77Y/82Z3eZNAvoVDWkXTp?=
 =?iso-8859-1?Q?Nvpi9vLoQ+Hl2HKZUNZb+3Dkf4kFtiUsPSJ99Yy67Og/05DQUPWw/KkTvA?=
 =?iso-8859-1?Q?3cabUdOuYenDSNFJsolS0qnyYwU6ES5GWQ6GjrfAvWVFVn+5lx5ldVWJZG?=
 =?iso-8859-1?Q?RiyFrpU3EC26HwgD10jMGjApVaPno3Ybaz5NKFLX7PECW0AMcIlPQREsnv?=
 =?iso-8859-1?Q?cEw8RtqQhw54ND/gDgrXCc/ItQiQhJjEoeLRGaPWSQfTDtC7PbvQ6E0Swf?=
 =?iso-8859-1?Q?7rX9RCrruT7B3D1yQv2UpGkFyiGwz6DFg9/puiSIqz/GRvNhASB599Tu/+?=
 =?iso-8859-1?Q?WEZpNj3uNr2HVT3HUJH0GejCXPWswLggo/qWm34xKR4ZftqyRn8+O8mcSc?=
 =?iso-8859-1?Q?iMbKLZjzm7GcryQ8cGc6Nb5j7Jts1+vMkMfYyvXVNhLxarCJx4Y2MHSVyp?=
 =?iso-8859-1?Q?/nP9p+U8laYjmAkU6jRwjMOGJLpYF5ynmSUQ7xZ4r89Lr0xGkLNokigkEX?=
 =?iso-8859-1?Q?1DikiQ2D7m1X5172eBvbBV7XrdFkkuLvT/y0UjaTeymtE5TGGh+PSsQ2Vw?=
 =?iso-8859-1?Q?db/HbWNOnOUFqpCLkfJ6JvQT3fD7ZrLlmQ6PFiet8KP8uaHy7Qj/3piJhG?=
 =?iso-8859-1?Q?6CVGcYpyoYuqtqthhIXBqy8KV+LrWlHHKea5NJg84bg3rNucP08fGPjwJ1?=
 =?iso-8859-1?Q?7sRrXc33uxvuN8/LLVTKvoCveZyYvSsNYsWxE5eLEeIeDhU4kCOqCTOdj/?=
 =?iso-8859-1?Q?QWC9DVIC7C1SHbiuVuyyBEmhAMAY2JJe+vZEeQRPwZ+2DKknxb7TMGn3Nr?=
 =?iso-8859-1?Q?muO5LQ1B2coW54gV5M+RjljXukdQYNRPz8x2fuHQFzhuCtqyz5DhFiwWLR?=
 =?iso-8859-1?Q?3ug8h/6aEUPH3JTfAuDUhtoB7xebFTHCua1gw61YZZEme7yR8Mm2fwZ0sS?=
 =?iso-8859-1?Q?zxZHBT4XxFo8gxWD6sQ5Yb0Ayez0sD+tpfDNZ9Y5pwF36EKin89LzmQsr2?=
 =?iso-8859-1?Q?nn/FGmjQidBcuGzsYSmP6UbdHooOvkhy3ZI70sL6U3oqOhQ=3D=3D?=
x-microsoft-antispam-prvs: <VI1PR0402MB3855A838407FE02C8E8A7EF5E0780@VI1PR0402MB3855.eurprd04.prod.outlook.com>
x-forefront-prvs: 0957AD37A0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(376002)(396003)(346002)(189003)(199004)(486006)(14454004)(50226002)(71190400001)(26005)(11346002)(44832011)(186003)(2616005)(478600001)(71200400001)(99286004)(52116002)(68736007)(4326008)(102836004)(2906002)(25786009)(446003)(476003)(76176011)(6636002)(6862004)(105586002)(6506007)(6436002)(54906003)(386003)(8936002)(3846002)(305945005)(8676002)(37006003)(6486002)(86362001)(5660300002)(106356001)(53936002)(256004)(7736002)(97736004)(14444005)(6512007)(66066001)(36756003)(316002)(81166006)(6116002)(1076003)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3855;H:VI1PR0402MB2800.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lfAuYioYByAEKR8MPQyoFz0s8e2EVqoT0XoF7EcjjHHWzIVRwsXwurB/aaeAWODC472sKY3r8Nk7V3hofgRhEI/AJ6HYDwQ6oxUbFX00mnvD2Sa2ByFRL5/Tm3U5sFtGJbKy0AkTfKobCxm/C8BLppGoVtlwfqH10Otj5mUUmDfZ+0QL2Rpc+5g9GxK4HvPxrR/IySbj109RsFKom2ejHptUyrHuu8uSdHo6EP8VS9dc3EldqrnFxdxfevBgGsKLTgj1NjpC4TcaMVapMKvUQoexaZdQtifnbA4/N0YTqYZO/5S8BimZJk9RjYTPXZl2gOu5BQVZVXndVdVIOsAMs8lSp6TixE7PE9Hs2QJIM/dAzIDiDyG9sEYC4oeMuwY8RX+PT2l3E2fMwoEJ0rdrQ//fhT4xfypxjdwRmoh69zU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbd4196e-42c2-4509-1f5e-08d6996bba25
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2019 08:48:46.7596
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3855
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable cache stashing on the frame data dequeued using this software
portal. Also, enable dropping a stash request transaction when the
target request queue is almost full.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/soc/fsl/dpio/qbman-portal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/fsl/dpio/qbman-portal.c b/drivers/soc/fsl/dpio/qbm=
an-portal.c
index 5a73397..d020135 100644
--- a/drivers/soc/fsl/dpio/qbman-portal.c
+++ b/drivers/soc/fsl/dpio/qbman-portal.c
@@ -169,9 +169,9 @@ struct qbman_swp *qbman_swp_init(const struct qbman_swp=
_desc *d)
 				3, /* RPM: Valid bit mode, RCR in array mode */
 				2, /* DCM: Discrete consumption ack mode */
 				3, /* EPM: Valid bit mode, EQCR in array mode */
-				0, /* mem stashing drop enable =3D=3D FALSE */
+				1, /* mem stashing drop enable =3D=3D TRUE */
 				1, /* mem stashing priority =3D=3D TRUE */
-				0, /* mem stashing enable =3D=3D FALSE */
+				1, /* mem stashing enable =3D=3D TRUE */
 				1, /* dequeue stashing priority =3D=3D TRUE */
 				0, /* dequeue stashing enable =3D=3D FALSE */
 				0); /* EQCR_CI stashing priority =3D=3D FALSE */
--=20
1.9.1

