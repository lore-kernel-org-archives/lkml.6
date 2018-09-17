Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2171AECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C37F5214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="PBsl9OXv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C37F5214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729408AbeIQI10 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:27:26 -0400
Received: from mail-by2nam03on0112.outbound.protection.outlook.com ([104.47.42.112]:14944
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729324AbeIQI10 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:27:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJEIm6bMBXSgim5O2mbfO/sABcY6cBxbdEYZ3JFL1q4=;
 b=PBsl9OXv0R7ZtZ8Lv9Xev+ULKDDyuF1GewECUGhlo+mpolDd+q8vgLROzhAKXVmYfL1aPZwvTPfo4/hU3RK/ZZsowIrRTmmH/EqkRNxManMi0AJ9RLyZLB+xdmN2t2MF67iy628w5fNZLySztoS7CkoOoyagxUFCGwSEH/moq/w=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0502.namprd21.prod.outlook.com (10.172.122.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.7; Mon, 17 Sep 2018 03:02:00 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:02:00 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 080/136] serial: pxa: Fix an error handling path
 in 'serial_pxa_probe()'
Thread-Topic: [PATCH AUTOSEL 4.18 080/136] serial: pxa: Fix an error handling
 path in 'serial_pxa_probe()'
Thread-Index: AQHUTjKqRNtpzg58w0GakeKnnErtgg==
Date:   Mon, 17 Sep 2018 03:01:02 +0000
Message-ID: <20180917030006.245495-80-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0502;6:okZQyQlK9gcRwHD0IHpaH41ghC1iQi3IDSe4ru37qUJfSUNRFmBLdX3vn0uoZdwaUmqJZ2O1bK8omBiGwen4WWqtypPQ/qmZeImZnxtJZGJIGpnTZ0miJAbTzmKUw74xkAlT/vd3UOymoE96XwWWKwo9N40+2KTHxtS2h/J/X5eSmoM4/FMYCUW51dHZgTl2QyX+CHFeF3C0ZfcVazDvz9CJV6Wdy0KL9D0EQRGAWV58p83oGo5N7JvOhLISwUz0SHrl2rT7BjCJo51WABPtceEhoBVkn+fsmJoJpEQ0C0L7DgS04jPWcOeCIPVwkGJsBoalsbGL6W6MBkdxm2ZKAp0GcUKVSoCqPknAq1tG3+dVicC973CjmmOvq+yAIIE1sJpYJy7DU9DAmyK8NNXH3eYuAVwe/20pYB1rgMpiuTK8rLoLqRVGdnjy0QNZ1b2eysE4FbafHDj/Z/cOV4YcGA==;5:ddXjH1doudxqUYwN0AY/LC0z2IrHLSGb4Y+0dp6XeMT744wWlflaomA5L054v9wQlhx++9NdfhEK1AenKIkxsBbT6EWSEG7XdNlOrbZ41CDzLgU0otkPIx/GSoRC0VX0Yj4PO8uq+pX1iwJvg/kUT+JRBu5ZFw2oL7L8LbGC2Vk=;7:KyH7YXob+DWH2MDDl+/vLwsReE2J+viWc2hxWRgMeillwvCUrY55HzYgGnggym8w4lrxNyO26aX8p1fri28ZfVYPnsW8U6kmZnQg3/cBSjr04CuNlEdSHeC1ULYRvpIufiQGLC311z0Kpts0d2P9TvOEOC5jG+R/QR5XBcccHwEEp26nhch+tufRifgt47WoHlMuZ3IjJ+kLnf0A75CPzuqMwsOwsmx6lxMNSWpIXQ7UJYeJmMWxhkLEzlbji6gz
x-ms-office365-filtering-correlation-id: 4d3325a9-875c-4147-cc2c-08d61c49efc5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0502;
x-ms-traffictypediagnostic: CY4PR21MB0502:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0502AB2D81B961D98E10E6D5FB1E0@CY4PR21MB0502.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(155761271638844)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(2017102700009)(2017102701064)(6040522)(2401047)(5005006)(8121501046)(2017102702064)(20171027021009)(20171027022009)(20171027023009)(20171027024009)(20171027025009)(20171027026009)(2017102703076)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0502;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0502;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(346002)(136003)(366004)(376002)(189003)(199004)(86362001)(2616005)(99286004)(5660300001)(575784001)(1076002)(6116002)(3846002)(10290500003)(2900100001)(72206003)(68736007)(8676002)(22452003)(26005)(217873002)(86612001)(486006)(76176011)(66066001)(102836004)(2906002)(476003)(14444005)(186003)(256004)(6506007)(446003)(11346002)(36756003)(316002)(5250100002)(6512007)(97736004)(2501003)(107886003)(110136005)(54906003)(6486002)(8936002)(53936002)(81156014)(81166006)(10090500001)(25786009)(305945005)(7736002)(105586002)(106356001)(478600001)(4326008)(14454004)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0502;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: dJR7knsDVDqkdTg5w3tK6OmmtAfw7EvK7HiIgQ0NKmHBWEb3mBIkNoqWQQEWRD9ipM1amgtdA8ylQKIBtMJ0WTzNn4SIb3gzJtNwZa05HE/uqcFZiRu8fpUdnbZ0NACdo7+b21BCQtjoM/QJEVIqaJh3ckq7TJOXKGb+FskD3IL+9Q/z33whoC5OnDx9N6/A1l5WiW/TSfVVRoBbWXO/AdK4PjKcfWH0GCMB9mwBs0ujIVrFOJtCs0BWwBpZkcifaJj9p2e6UZec/Dw51jY7LvEMhCLC72BHVmBBhiYVa23jGxYpZkyBWZrop6rt+CkjvZVK9mcGcapUxFZQkoit7T5qvz0/fpTFYdTXXtHWaQQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d3325a9-875c-4147-cc2c-08d61c49efc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:01:02.1668
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0502
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 95a0e656580fab3128c7bee5f660c50784f53651 ]

If port.line is out of range, we still need to release some resources, or
we will leak them.

Fixes: afc7851fab83 ("serial: pxa: Fix out-of-bounds access through serial =
port index")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/tty/serial/pxa.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
index eda3c7710d6a..4932b674f7ef 100644
--- a/drivers/tty/serial/pxa.c
+++ b/drivers/tty/serial/pxa.c
@@ -887,7 +887,8 @@ static int serial_pxa_probe(struct platform_device *dev=
)
 		goto err_clk;
 	if (sport->port.line >=3D ARRAY_SIZE(serial_pxa_ports)) {
 		dev_err(&dev->dev, "serial%d out of range\n", sport->port.line);
-		return -EINVAL;
+		ret =3D -EINVAL;
+		goto err_clk;
 	}
 	snprintf(sport->name, PXA_NAME_LEN - 1, "UART%d", sport->port.line + 1);
=20
--=20
2.17.1
