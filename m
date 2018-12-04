Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4022DC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F086420851
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="xOG4rOJj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F086420851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbeLDLUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:20:34 -0500
Received: from mail-eopbgr140077.outbound.protection.outlook.com ([40.107.14.77]:35392
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727500AbeLDLUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:20:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C//f1D3o1dL+LfUWYDxHCTE0zlBtF8PdB8CzLA+OZmw=;
 b=xOG4rOJjscLJAuqaxfPMw+c+shcxgIE1T0GDrsl78vIAteCfZRFbp+iZXy7PqGN6T6fBAmViVNjg5oDeg6aC1MFk5sGlvds56D56N5zG/nX1iommy8AOYFOQD6fN8T3tCuoyB7w72RJNCE21n/l79FD+RLOrH/BrLevMvLmFKqc=
Received: from AM5PR0402MB2785.eurprd04.prod.outlook.com (10.175.41.15) by
 AM5PR0402MB2721.eurprd04.prod.outlook.com (10.175.40.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Tue, 4 Dec 2018 11:20:27 +0000
Received: from AM5PR0402MB2785.eurprd04.prod.outlook.com
 ([fe80::9d72:48b9:59c6:6dfa]) by AM5PR0402MB2785.eurprd04.prod.outlook.com
 ([fe80::9d72:48b9:59c6:6dfa%4]) with mapi id 15.20.1382.020; Tue, 4 Dec 2018
 11:20:27 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     Roy Pledge <roy.pledge@nxp.com>,
        Youri Querry <youri.querry_1@nxp.com>,
        Leo Li <leoyang.li@nxp.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH v2 1/2] soc: fsl: dpio: cleanup the cpu array on dpaa2_io_down
Thread-Topic: [PATCH v2 1/2] soc: fsl: dpio: cleanup the cpu array on
 dpaa2_io_down
Thread-Index: AQHUi8Nbn0LN8JlywkCvWZZgd9z2gQ==
Date:   Tue, 4 Dec 2018 11:20:27 +0000
Message-ID: <1543922408-22950-2-git-send-email-ioana.ciornei@nxp.com>
References: <1543922408-22950-1-git-send-email-ioana.ciornei@nxp.com>
In-Reply-To: <1543922408-22950-1-git-send-email-ioana.ciornei@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0135.eurprd07.prod.outlook.com
 (2603:10a6:802:16::22) To AM5PR0402MB2785.eurprd04.prod.outlook.com
 (2603:10a6:203:98::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM5PR0402MB2721;6:gQnFlwlR1ZD5lAxGzS/4GL/aTe+7I/xxrCICCaS006gfE20xwykow8lwJwO0fhCONfvRNnNXPgwFZMw1YfnDbxVyGSmUpsrJzvZQVY0RP8weyBWP55gNjQRXR1Enr2ohbULQFZY3nBTa9LqoKlEiMpio8AekqhcCVSxr0khKIoVyfq+YyMUd7qEsKc+Z2aS2efD0MdJu5u8DVYv2kZ48hWYqEyocZJNgAO118qYI60GNAAS0j+aAT5sKVTlUkxcFtABLoB86oWnOe7quPkIfjKQCvuQy5F4No32KETr6QLFyZFRRkvarsCjiIDgjWt5MkeVoSTmut8PocdaYeLs/CTlsmfYOYp7h08R3LZyXZvQy1A937z0O/05FMjeHpg3elfrYj+j8S1b5TBJqfTs5KmeP8XD5neIGrB8sVUX7lCGTTmBGZimg8fLh1aojS5HDwTGQe2Y4oqBHGn2ll3WxnA==;5:TpKAIff/X4idRNKGGhDkYCtTk505FRSRRulA0wT+wUIAySKmD8szaOIatpQ57Mo7QN4HPcn3wLhBF3DxNGLHFszskw3Al4TXBUl35fnOIrOve3UkotZlQc4KHaFhOveRft9P9ncPGzR+TeSruNqVfqoD09vcLCXBMIwm6fdEG5I=;7:0nvkvoGiXa8jZh4Oa3o8WuBy3nwNnC2seyLrT/p1OvBelvaA7leakmgkqk46N+ygmS7FaYqxVL4Wp/frgtJeA4d5muXiExnG3qd3PAOB5yTRZXuKm51oI+MSL4tVjLGLazY22yaGWEg7sSO59s8kdQ==
x-ms-office365-filtering-correlation-id: 68e73f5d-6b57-4906-7fc7-08d659da7e3d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0402MB2721;
x-ms-traffictypediagnostic: AM5PR0402MB2721:
x-microsoft-antispam-prvs: <AM5PR0402MB27213CC4DF159C6343650783E0AF0@AM5PR0402MB2721.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231455)(999002)(944501493)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:AM5PR0402MB2721;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0402MB2721;
x-forefront-prvs: 0876988AF0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(39860400002)(136003)(396003)(199004)(189003)(476003)(5660300001)(71190400001)(14444005)(102836004)(25786009)(6436002)(52116002)(71200400001)(66066001)(76176011)(386003)(26005)(7736002)(186003)(68736007)(256004)(6636002)(6486002)(305945005)(99286004)(14454004)(6506007)(110136005)(54906003)(106356001)(105586002)(97736004)(11346002)(486006)(53936002)(478600001)(44832011)(6512007)(6116002)(2616005)(36756003)(4326008)(8676002)(81156014)(3846002)(8936002)(316002)(81166006)(86362001)(446003)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0402MB2721;H:AM5PR0402MB2785.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: kXbcibHjLCee59VhUtd6CZPzm82Fn+sDuGti5iAPc3GgXu2KgyhDxvN/XRB5+hjayyqIyhlq1ctK+Aaq+kvnZfgckroNgvk3atqFFci4yfc59X+3ZmzgEVhT9RxY+n47Cj5xddiKQwEwKocigfjZPiW1Z92DZ2wAGX6hOI2eYe9kcYL+Kr5GB8BEUjvC8RHX+j52LDv5Uuf3Kdk+HhRzNxkz8WY9oTd0BnwM5ipKzBdy9pn0HCPo6DaZp3IxyCTxXNo6pSg2nMBPcFxb9b1dSWNIsImb0G5z7i1QLLOjVrZrsPmOxbIPoAJaEnFyxW7Xj03PaAkAh+JTAd4GxUuopC2iGQyE5nn1xHuCRw+Iee8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68e73f5d-6b57-4906-7fc7-08d659da7e3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2018 11:20:27.8258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2721
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dpio_by_cpu array should not contain a reference to a freed dpaa2_io
object. This patch adds the necessary cleanup in dpaa2_io_down.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v2:
  - none

 drivers/soc/fsl/dpio/dpio-service.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/soc/fsl/dpio/dpio-service.c b/drivers/soc/fsl/dpio/dpi=
o-service.c
index 9b17f72..21c3e32 100644
--- a/drivers/soc/fsl/dpio/dpio-service.c
+++ b/drivers/soc/fsl/dpio/dpio-service.c
@@ -160,6 +160,11 @@ struct dpaa2_io *dpaa2_io_create(const struct dpaa2_io=
_desc *desc)
  */
 void dpaa2_io_down(struct dpaa2_io *d)
 {
+	spin_lock(&dpio_list_lock);
+	dpio_by_cpu[d->dpio_desc.cpu] =3D NULL;
+	list_del(&d->node);
+	spin_unlock(&dpio_list_lock);
+
 	kfree(d);
 }
=20
--=20
1.9.1

