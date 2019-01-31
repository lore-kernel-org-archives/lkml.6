Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D598C282C7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2107220B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:09:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PJ6uJsN8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732240AbfAaKJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 05:09:26 -0500
Received: from mail-eopbgr50045.outbound.protection.outlook.com ([40.107.5.45]:16598
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732048AbfAaKJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 05:09:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=whcIrtpf1u2eLoEXelIOOL7D42rL5WheiHiqPGAdgSc=;
 b=PJ6uJsN8ni3LXmJuhX9BxyrEO51VbpCy29FlF0TKXLSIB23mHIrlkf7sGf9u92JjBlXnSrtGloB1Z6fZScqvhHNJdn4Au2JsRnYoD0S5rHUYPZGSgBuGQf/ZkOq4CD4KQMVFOANjbWhcUi2+xss73Jh7j/53tyy77s8by6tgsBg=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5460.eurprd04.prod.outlook.com (20.178.115.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.21; Thu, 31 Jan 2019 10:09:15 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::bd44:e001:ab8d:1c51]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::bd44:e001:ab8d:1c51%2]) with mapi id 15.20.1580.019; Thu, 31 Jan 2019
 10:09:15 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Joakim Zhang <qiangqing.zhang@nxp.com>,
        "mkl@pengutronix.de" <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
CC:     "wg@grandegger.com" <wg@grandegger.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] can: flexcan: fix timeout when set small bitrate
Thread-Topic: [PATCH] can: flexcan: fix timeout when set small bitrate
Thread-Index: AQHUuUiQ4yWIPYpxOkiOxPx7F+znnqXJJ0sw
Date:   Thu, 31 Jan 2019 10:09:15 +0000
Message-ID: <AM0PR04MB42118221E7FEC6EC2503A72B80910@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20190131093509.12613-1-qiangqing.zhang@nxp.com>
In-Reply-To: <20190131093509.12613-1-qiangqing.zhang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB5460;6:VnQRBJT4PIxgDLGRhl8DyEy0DsZ2Vr9tiPY2rOgzzYxxtsvm/W3FxsF2dY9RsdMuRRMB5dHmW74tdt6lp9P/8mA3xBGZUHNo+QDKnIY7lzjXZId0qvpcQEXPqSXZHhewWI+OnR9yze9gCBDiCqq989YN4s0eeNPvfot9yj+D0xlUS21oTSS6n5TOaBtbL9RKshSylwOwoik28QaUloBXuMstaMkL6gxHja+dL4LlLAZqWmcLjywXp1sTJiykr4xILtYykPR5CUliZQ9J7jYYqwXrJVuR/AIAUgylR2ANLB0nLe0TqXhuwkDq8/+S4ncsRP3PXbdpY0j+z02M12Ry4+P4dxWVG9Mvb+frRJ/f6zCVGzrjZS5LemkOdpe8Mwv0449H94hHPKOE+uEMh1cjA6Udxvv+/cQ4drHpdHRKc/4F0ULraMrkvlgl9v+TNt3a0iOforC3YYdPCQSomX4P4Q==;5:o4cR1mat7HoTFsdBr2m6GkIwTVs65+kqTqV2TGh5N479agodjDF9KlzROzDBH8PQeIq/wTunIk/uwg+3pODYrgybdaTXj6pKKjkTTzuAWVBaTDRifBpoH626k1aZotkn7vWILpDyCyCrBzwSfFQlI+jPQ2zyj4jq7+ck13TG0Wh/GBl+7TsdMJNsSO1aUY2HsDO38ZN9r2Drno06Sa0kaQ==;7:+2QUUiVgKeJp+DZCo0IrN7D8OGbxntWsZwGPYJV3HkApv4uUvMgRYXJ5R4vN/IOryCRMXwu7y6BjedY4ZGucoJCP/nNE+eZfuU2WPSl70oLTj97cNtR3U3E3umQXGMtLeR4v19WrFukEORyUjWcjmw==
x-ms-office365-filtering-correlation-id: 87633cb3-681d-4b6f-3224-08d687642829
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5460;
x-ms-traffictypediagnostic: AM0PR04MB5460:
x-microsoft-antispam-prvs: <AM0PR04MB5460DEA910DCB3CFCC689C7880910@AM0PR04MB5460.eurprd04.prod.outlook.com>
x-forefront-prvs: 09347618C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(366004)(136003)(376002)(346002)(189003)(199004)(45904002)(13464003)(66066001)(76176011)(97736004)(6506007)(14444005)(8676002)(110136005)(68736007)(316002)(71190400001)(54906003)(44832011)(81166006)(25786009)(74316002)(9686003)(4326008)(81156014)(8936002)(53936002)(6246003)(55016002)(2201001)(305945005)(33656002)(256004)(71200400001)(99286004)(2501003)(14454004)(3846002)(105586002)(229853002)(53546011)(2906002)(6436002)(6116002)(476003)(26005)(486006)(7696005)(446003)(11346002)(186003)(86362001)(106356001)(478600001)(102836004)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5460;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3hrdTkPx2Tl+0L5QyQIM+A52U/bbKzK5QabRmdVAfcpcpHf/pfbnIn4V8DIAUSvzGw/Kjd2Wu0JwYmxIV2pUbllUyHWw/Z7QqsYnpAR5K65hFSv8+SjriS3rHkkLpEvcvzKvEm14O/XXGxp5+FP0F2OEfixh7j6wrFFl9EZVzuLNB77vN1de8ABIW+1lmyiNx2P/4cTGoRSLZcpQ8+BlNLPK5v2/6Q1v1S6kCcg2UMolwoBmcTPF37ijyycC/PPRo8nQ83bjK7ggBhKSZeqHEAQaX/lGA/h/wnbKKN1RCguv/iA0P+AhUYB3g8F2uEDKKaq0H0DcoATjzenT196J2y/gdd/oLtHDYYy+dNupaEaUhQvS5TnVWTq5tfAE4PNz4tuOSLDz2kRI1KG4wanXnj7stomyFqngh7ljF6Xp9ds=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87633cb3-681d-4b6f-3224-08d687642829
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2019 10:09:15.8770
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5460
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Joakim Zhang
> Sent: Thursday, January 31, 2019 5:37 PM
> To: mkl@pengutronix.de; linux-can@vger.kernel.org
> Cc: wg@grandegger.com; netdev@vger.kernel.org;
> linux-kernel@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>; Joakim
> Zhang <qiangqing.zhang@nxp.com>
> Subject: [PATCH] can: flexcan: fix timeout when set small bitrate
>=20
> Current we can meet timeout issue when setting a small bitrate like 10000=
 as
> follows on i.MX6UL EVK board (ipg clock =3D 66MHZ, per clock =3D 30MHZ):
> root@imx6ul7d:~# ip link set can0 up type can bitrate 10000 A link change
> request failed with some changes committed already.
> Interface can0 may have been left with an inconsistent configuration, ple=
ase
> check.
> RTNETLINK answers: Connection timed out
>=20
> It is caused by calling of flexcan_chip_unfreeze() timeout.
>=20
> Originally the code is using usleep_range(10, 20) for unfreeze operation,=
 but
> the patch (8badd65 can: flexcan: avoid calling usleep_range from interrup=
t
> context) changed it into udelay(10) which is only a half delay of before,
> there're also some other delay changes.
>=20
> After double to FLEXCAN_TIMEOUT_US to 100 can fix the issue.
>=20
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>

Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>

Regards
Dong Aisheng
