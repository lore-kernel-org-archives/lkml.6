Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D46C4161C
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88AA72147A
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Xv0OYWAl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88AA72147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728613AbeIOHIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 03:08:35 -0400
Received: from mail-sn1nam01on0101.outbound.protection.outlook.com ([104.47.32.101]:52800
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727083AbeIOGrC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:47:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xsV1TFB3VhGChEleAmwsm5VUgk5re7HC1WxoNpj3/hU=;
 b=Xv0OYWAl+5DEkSpTWQrbE16hYK291+8yPAfmiRXpGwhUmYIBb9dfg3qPYhgo+ypGYn/MVHyqEfHGLAy1JQecthGi85rj8Wgm4t4mtvwXwmbLkhzoafJ3FyDfXI6/vOvoJcdO+WDzxPr0dGgvXPHQogqvadPYWhZg1rOTSZTiYVA=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0824.namprd21.prod.outlook.com (10.173.192.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Sat, 15 Sep 2018 01:30:01 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:30:01 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Sean Wang <sean.wang@mediatek.com>, khilman <khilman@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 19/92] pinctrl: mt7622: Fix probe fail by misuse
 the selector
Thread-Topic: [PATCH AUTOSEL 4.18 19/92] pinctrl: mt7622: Fix probe fail by
 misuse the selector
Thread-Index: AQHUTJOfhO6mte8gMU6/YmwOZURQvQ==
Date:   Sat, 15 Sep 2018 01:30:01 +0000
Message-ID: <20180915012944.179481-19-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0824;6:Ll9xsNHEgWC/VbC03WZTrCDefgysLKHGs9GvKP9pIxPABeoF5XXUlYWG9XBGu8qQpHALsoZPmqSM2XAc3pmdWv+NhrKtKjZn73G29yXQKwWleXpOp42yk10dCpQnHIYHD+tqDUOMq0JeAAOZ0dPUk4EAWL9OXenO52mJyz1AY3SJjwuD6EYbRoMkSLgDOR2DAXO1pIFuwd0Xj0WOkg8hSH3d05/P4/n8eseRiIzyttxb1zRyPvLRV70M327RA/oLH5nIA8F1tXK6Omi067178od92UEZDPlJCvgm2JZ/Q4So5mBlch0beW8yhGKQsOdinvHmM1SJTaTwRvkCMGB1uM5ulMdeLNwOhizurKoXCuFyVPaP5QXYTy3SVxymLGOh+t9z3vWf2BMCf5p96BAkRwQ6IpzYcOydo+umFCm6KHyg93UOYiE7xq0dvfTUKcY87c+utOSJl3WcQRSBz9OrXg==;5:gVZSUlGTa/2g+HtzwNTe1isUnkvcHAO3IPjy/6eahGl35bzcb/SaSgnPuU0PGklJJVUP1cJL+IkRrBWbpZAFlU8C3cC1gUCLHAatM6UMH9o4OdAq4D52hOFT4xPSWD0tPEG7g/q97Qql+NAsfgRy4pKBqw+6kMR+5ZnsgNytshM=;7:CevRyoG6243Cn2065VFBUz5QZvHE66hHNg+PjGAGRJrVe/KLZLd93oaJGn6B/8D6X/IynSsD7mWEQbYPYvPSqY0SGSr1jwtKPoo4Yhb0ddEbL1izSEifY1reRTwwEoqRPrD5NAov82n6skiOuSys/nNDXyUSjM+EE5Y91gwBsaBKMK4fnb5LlzRnmFvLHr5hjVTlvEVv+LyvD6mTEj/u2AvD7sDvGcOJuEP4vmlfDW5pAmAsRhL6VtU83Kkwbvz7
x-ms-office365-filtering-correlation-id: 5af3c004-2837-4291-3744-08d61aaac1dc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0824;
x-ms-traffictypediagnostic: CY4PR21MB0824:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <CY4PR21MB08248A2099E2262A648BB061FB180@CY4PR21MB0824.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0824;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0824;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(136003)(39860400002)(376002)(346002)(366004)(396003)(189003)(199004)(6506007)(1076002)(66066001)(22452003)(99286004)(102836004)(76176011)(2501003)(5250100002)(97736004)(54906003)(6116002)(186003)(3846002)(107886003)(25786009)(11346002)(6346003)(446003)(486006)(476003)(26005)(2616005)(5660300001)(10090500001)(86612001)(86362001)(36756003)(4326008)(217873002)(316002)(68736007)(110136005)(8936002)(81156014)(8676002)(2906002)(6436002)(256004)(72206003)(7736002)(53936002)(2900100001)(478600001)(6512007)(81166006)(10290500003)(105586002)(305945005)(106356001)(6486002)(14454004)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0824;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: d/fWrLRWs58NawHv12kj0KlQun4MvYa1a3q0x3kuK6YKn9y0wcq9Nj/isUlv/rml7NtTQzYD4ks8y7Xav6Jp+Ifa+dwcrFjfnt1JC4yzq4S7A6WP9n+Xrze+cZnNlsNb3GOZS/FcEjdzppEiKwfneq8v42LBQ9q4CuP9sNsH38a+jQTrOYjdNAbk2PadKOkdT/rES+gxLI92LLne8xJd9Bn2iYCHuD9qvaNjR84JzWQzMLxbiTRRfDKGHpSemS7Y6nMxS5Gh8ODXDrnhxXvgGlOZ7fh6GPRkN/nf8PZQV8BHmKSMaywfKphQb7MAyh8gSswIC99/IHUx4epDNs5ghHh+Ue3qqF9gIbNatlM4wpk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5af3c004-2837-4291-3744-08d61aaac1dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:30:01.7451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0824
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

[ Upstream commit 238262af08a20e5f1932fcf606b8b84370ac8b77 ]

After the commit acf137951367 ("pinctrl: core: Return selector to the
pinctrl driver") and the commit 47f1242d19c3 ("pinctrl: pinmux: Return
selector to the pinctrl driver"), it's necessary to add the fixes
needed for the pin controller drivers to use the appropriate returned
selector for a negative error number returned in case of the fail at
these functions. Otherwise, the driver would have a failed probe and
that causes boot message cannot correctly output and devices fail
to acquire their own pins.

Cc: Kevin Hilman <khilman@baylibre.com>
Fixes: acf137951367 ("pinctrl: core: Return selector to the pinctrl driver"=
)
Fixes: 47f1242d19c3 ("pinctrl: pinmux: Return selector to the pinctrl drive=
r")
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/pinctrl/mediatek/pinctrl-mt7622.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mt7622.c b/drivers/pinctrl/me=
diatek/pinctrl-mt7622.c
index 4c4740ffeb9c..3ea685634b6c 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt7622.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt7622.c
@@ -1537,7 +1537,7 @@ static int mtk_build_groups(struct mtk_pinctrl *hw)
 		err =3D pinctrl_generic_add_group(hw->pctrl, group->name,
 						group->pins, group->num_pins,
 						group->data);
-		if (err) {
+		if (err < 0) {
 			dev_err(hw->dev, "Failed to register group %s\n",
 				group->name);
 			return err;
@@ -1558,7 +1558,7 @@ static int mtk_build_functions(struct mtk_pinctrl *hw=
)
 						  func->group_names,
 						  func->num_group_names,
 						  func->data);
-		if (err) {
+		if (err < 0) {
 			dev_err(hw->dev, "Failed to register function %s\n",
 				func->name);
 			return err;
--=20
2.17.1
