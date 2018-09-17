Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6D5ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BE29214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:00:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="fq8fK5dT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BE29214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728564AbeIQIZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:25:42 -0400
Received: from mail-by2nam03on0137.outbound.protection.outlook.com ([104.47.42.137]:35861
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728479AbeIQIZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:25:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VxyESElLxsc9AxndEui+87mKOr3ebLhC/h5LeDWye00=;
 b=fq8fK5dT/lGD0BaOQExsSsZ+q8DjFrCJK+/dronv8GZI7klNFX4t3XZHWF1Aiodv0xvz5xeOAFnzYd5ubhMIAl9JTTDW+zk82znFz5lmBA5JLRYfjD8GQjUBK950EJmzgR9gtpt0Dv7MZwmQLEa9XvM0SbX1xvQfjJJqXPd3BY8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0277.namprd21.prod.outlook.com (10.173.193.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Mon, 17 Sep 2018 03:00:23 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:00:23 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Hans de Goede <hdegoede@redhat.com>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 013/136] power: supply: axp288_charger: Fix
 initial constant_charge_current value
Thread-Topic: [PATCH AUTOSEL 4.18 013/136] power: supply: axp288_charger: Fix
 initial constant_charge_current value
Thread-Index: AQHUTjKRiku5gS1BaU2nA3qteKYkbQ==
Date:   Mon, 17 Sep 2018 03:00:19 +0000
Message-ID: <20180917030006.245495-13-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0277;6:rZP0z1Qd+f5WaXhw6Bc1YcEoyoeh0T+IlwoiFLcr024JP0c/gSBbGXe9KciY75oDoTcH71jKKbfApmz+VAuA9QSn5pRZOgpNZi9oImCHi7MOycEgsalrUWWERC01tmGZ5K2eGrLL7dZ0DW8rsXL0EIP3N0R4gcJKHpBA+fPCUWeWEXC0wJZ+1VyayIHeVpOFjUpDIRfIlcfpaGl7LzXijmoqJgL7NUOTNFT0K3e3RsMKgSkDvfPMmhvMCQYMfjGA3Q29Yk5fdX6g2Zh0BBEvmSV5ZwE/pJhZHHh8UqxUEHecwIxigpvkUsxJoHiKCJmwOUvQhS8U1iv7P5ifhrAFQC0q/iPA7CK+UB37LrKnWkGzibtRQkF+v910+HkCToQgmjoj5hJFtVddzvnbTMLPTRioietdrDkYYtYib7iDmpJqgYxKL+7u4ftxCwOOmceayQq/72rStvqtZw4S4xJzBQ==;5:hJ/C1s58B/3mkEcucR/eoOuCAvsOkJy4g9UZLy/3H44r9EnTTXrBLR3wn+Omr6przwzj3O4mSFKLEg43v4Xw+4bFh8/H5ISx3ktCOTfb5AMCiLpsWsLi+s2VbSt1JI9O/zJjftszyncI83NG5khcOuEr5pz06jQE9KrEMXIVlp0=;7:Zn7nbtFw+fPv0lllGZWWiNkofug9Soqs+JSZ5S45rZE5nKqYYWOz4z5KRirY+OZiSBlInqR94f+vx6lYxHBnZ2/R466+MyfeNxdJzfnzJOLK68HQCzrGpLJKdszm1yOs60SeF4o0cyf9/NRjuSN2kpqdduULoW5+1jPhuKZVyWyVAJ2AJjLIM0ZKIJ1TDRbHEn/HEIfuXY6cCV91+wJz2d/Lw6OeqbeavA4efQIewC6GeGgFTbRpYRviSt96c+ZS
x-ms-office365-filtering-correlation-id: 5426157b-0ed1-445f-7adc-08d61c49b61d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0277;
x-ms-traffictypediagnostic: CY4PR21MB0277:
x-microsoft-antispam-prvs: <CY4PR21MB0277757CC00A1E72370188BFFB1E0@CY4PR21MB0277.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0277;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0277;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(376002)(136003)(39860400002)(199004)(189003)(446003)(4326008)(2616005)(53936002)(107886003)(11346002)(22452003)(68736007)(486006)(316002)(14454004)(106356001)(476003)(217873002)(25786009)(105586002)(10290500003)(14444005)(97736004)(66066001)(6486002)(6436002)(5660300001)(256004)(5250100002)(6512007)(6666003)(2906002)(2501003)(6346003)(99286004)(72206003)(2900100001)(26005)(6116002)(186003)(1076002)(36756003)(81166006)(6506007)(10090500001)(81156014)(86612001)(102836004)(575784001)(86362001)(8676002)(54906003)(8936002)(110136005)(305945005)(76176011)(478600001)(7736002)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0277;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: eVHPjiPfW4CgWlUk51gGmaZRh0dDxYWR5df9waGJOPp62sQMD2SHoC41haDphYYGZR2rqlPSIDK033yZgdMh2SlV75u8A0m3waR8NkpbToSRnLH+WfIqrWE5/N9yCrASe9muMF5N4543SsTzkvn0m8zqaIDan76s7LzNNEyCQRVT/I2tPs2tbXeKbC2ZrLbKbXmM89PoW6Tyz1niKoMacVwP0/EZb1ZRX6pa47nxg4aPEnPXPBDShn83CagSK1Tfbq+MIdRlEpjappMFzWxiSo30GTQ/5AGZtRyXNTtGfwytzsdWLo7zc0f0oOHiRuXNtXIuzIyiXjrhohADpb9//C+Nby0ts6EfUQdAwOWl8+g=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5426157b-0ed1-445f-7adc-08d61c49b61d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:00:19.2454
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0277
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit f2a42595f0865886a2d40524b0e9d15600848670 ]

We should look at val which contains the value read from the register,
not ret which is always 0 on a successful read.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Fixes: eac53b3664f59 ("power: supply: axp288_charger: Drop platform_data de=
pendency")
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/power/supply/axp288_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply/a=
xp288_charger.c
index 6e1bc14c3304..735658ee1c60 100644
--- a/drivers/power/supply/axp288_charger.c
+++ b/drivers/power/supply/axp288_charger.c
@@ -718,7 +718,7 @@ static int charger_init_hw_regs(struct axp288_chrg_info=
 *info)
 	}
=20
 	/* Determine charge current limit */
-	cc =3D (ret & CHRG_CCCV_CC_MASK) >> CHRG_CCCV_CC_BIT_POS;
+	cc =3D (val & CHRG_CCCV_CC_MASK) >> CHRG_CCCV_CC_BIT_POS;
 	cc =3D (cc * CHRG_CCCV_CC_LSB_RES) + CHRG_CCCV_CC_OFFSET;
 	info->cc =3D cc;
=20
--=20
2.17.1
