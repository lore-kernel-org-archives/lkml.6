Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F23ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44654214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:15:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="F577HH8j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44654214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731131AbeIQIlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:41:11 -0400
Received: from mail-by2nam01on0102.outbound.protection.outlook.com ([104.47.34.102]:24891
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729080AbeIQIbo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:31:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qLh1GgT8xUI0UtcYBANkNVq6ya08BMz4yZj6cSTPDUY=;
 b=F577HH8j7ajqfvQYZgPCSLj67dsdFwVV8cY8oKmbsqkPzN9mGzPSu+qoU1ZTHT2kCX7kRty6SnJzp6dEqvYCwbfQJUswO8cf1UFNXdGmW/QY/qCGGWaLZsxYsyOMB5k/0NSNnHm1T9+1+uir3sD6eRq3KQdvoa4HZx8QoJKZ2DA=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0757.namprd21.prod.outlook.com (10.173.192.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1164.6; Mon, 17 Sep 2018 03:06:20 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:06:20 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Brandon Maier <brandon.maier@rockwellcollins.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 39/57] net: phy: xgmiitorgmii: Check read_status
 results
Thread-Topic: [PATCH AUTOSEL 4.9 39/57] net: phy: xgmiitorgmii: Check
 read_status results
Thread-Index: AQHUTjMZxsYuULxl70qqbMdqVF58Eg==
Date:   Mon, 17 Sep 2018 03:04:07 +0000
Message-ID: <20180917030340.378-39-alexander.levin@microsoft.com>
References: <20180917030340.378-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030340.378-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0757;6:fHCP9mr3KzqLoY4NcIa1Hw3ZPP5dqHpiAhFn/uIFDNIle+XQ47om2+y6IS+Y4ntNhT8DDxytc50wk7nnjSt0DP8BPlgsDp2hE0YOhb3T4WPxmddzEQO7rIdZWCxDxfsRe21zQs9t4ItElvJ1b40bVQpSBB1Gbw0ZDNjeavidF1VREbe77udr8HDN0KATm876VwLaeH0o+lu3Rob4Uw52arD3Po1JwjUXb0mQkVYtE2649v1cmLEgiPa9pA+G1eYJpjy8lcR3IF5+gAUdH949IhE3yybUOerE1/60TZYuPhnwtsvEdWqBEYLFsd2XCxOp5yVta7+5hjLfGMdn6CsLWSN3gGPx6gi8FvCjtnQyynLirP3jidDTXGd+FGTP/5CQUYPImvdO/rMoQ2QgdOXZU3mPRrG5FCBMweTNdrU9uVDHS4RDA+1e8GhOSiJamlnX9kNpwrV9o3rj4n3yOuXC2A==;5:zvNekUkgx3pirZMPfY3NTpXM+cI7ZHLDoTlsJGr8+jP4wIJG4B3s+YS3kiiXLvY80zVLfRBJ+0g3+aofIeI6b59/aA9yT/jx66obNQKYa33KO29J89O/ympCg+2Zn8WiGXzel4zRlrhWB4A9cldxmLSEv6ff+Zc898nVIYzCiGg=;7:lyXu3c/ThqbAmdbm2ohPJ3KrF58b7pLXMtHaara60oyAt3Fc+skOMg6uKWJbNYkiArrQdBJqkq6huH72UyH4eZJMX2Vti7n70L9mz2wS3IC5Dg4j4Mn+TQ3iKI1JrNnIIM9CYM9XOGhyeTTM06/s7xVHNE8Rxq6xmUTCGDXVqHoW7bAgmJbVcEYyKlfGLZjRSisdrSyYgQRI8PWsUz6z/UmE8BxAD/+SDHw+ZhwlmbWyqCO1vx+4W4BZ4H8Yvh6z
x-ms-office365-filtering-correlation-id: efe9c817-79b3-4549-bbbf-08d61c4a8b06
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0757;
x-ms-traffictypediagnostic: CY4PR21MB0757:
x-microsoft-antispam-prvs: <CY4PR21MB0757859B59021E1D899822B7FB1E0@CY4PR21MB0757.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0757;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0757;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(366004)(346002)(376002)(396003)(189003)(199004)(8936002)(68736007)(476003)(575784001)(10290500003)(446003)(53936002)(11346002)(6512007)(486006)(86612001)(6436002)(1076002)(256004)(6486002)(2616005)(14444005)(81156014)(81166006)(7736002)(8676002)(217873002)(478600001)(305945005)(3846002)(6116002)(86362001)(5024004)(4326008)(106356001)(66066001)(186003)(36756003)(99286004)(76176011)(102836004)(107886003)(26005)(2906002)(5660300001)(110136005)(54906003)(10090500001)(22452003)(72206003)(2900100001)(316002)(14454004)(97736004)(105586002)(6506007)(25786009)(6346003)(6666003)(5250100002)(2501003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0757;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: nFGPpukrwcLpzhkoAnKv93gIazLlFaC/mVjcn1f2ZVSbX1iEwEHFPOKJy2L7wi6g6YyvG6Hc3MNu/lj1FE2932X1t788ZoQQntQApCBxt8K9ZJCt4geefKe+EIihwVXSYbCwEAEDcGkfF4TD9rVCc4gIUrYzFfpdCYfy2Rjrl+gTNJ5RLLgiisttJWppe6lYwrFx+1SBfjw12Rxq+XjifLjcx0VylvKaVZr4jIuCu5uS4KQFVrUkPJmJmrMd6b4O3S0Yma/xshdS2IiidItPg53ohx7mN1SsI1ZjpXBCLBJX8TyFFk+1DI8SPDz66RiWUvSt8Vm/S2/zn8gowU9Kx+G+a+kfqEh36r0+f4+UsPY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efe9c817-79b3-4549-bbbf-08d61c4a8b06
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:04:07.3208
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0757
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brandon Maier <brandon.maier@rockwellcollins.com>

[ Upstream commit 8d0752d11312be830c33e84dfd1016e6a47c2938 ]

We're ignoring the result of the attached phy device's read_status().
Return it so we can detect errors.

Signed-off-by: Brandon Maier <brandon.maier@rockwellcollins.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/phy/xilinx_gmii2rgmii.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/xilinx_gmii2rgmii.c b/drivers/net/phy/xilinx_g=
mii2rgmii.c
index 2e5150b0b8d5..449b31319010 100644
--- a/drivers/net/phy/xilinx_gmii2rgmii.c
+++ b/drivers/net/phy/xilinx_gmii2rgmii.c
@@ -40,8 +40,11 @@ static int xgmiitorgmii_read_status(struct phy_device *p=
hydev)
 {
 	struct gmii2rgmii *priv =3D phydev->priv;
 	u16 val =3D 0;
+	int err;
=20
-	priv->phy_drv->read_status(phydev);
+	err =3D priv->phy_drv->read_status(phydev);
+	if (err < 0)
+		return err;
=20
 	val =3D mdiobus_read(phydev->mdio.bus, priv->addr, XILINX_GMII2RGMII_REG)=
;
 	val &=3D ~XILINX_GMII2RGMII_SPEED_MASK;
--=20
2.17.1
