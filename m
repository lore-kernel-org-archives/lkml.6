Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 180C0ECDE46
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D26F720869
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NGQuGa4l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D26F720869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbeKESt1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 13:49:27 -0500
Received: from mail-eopbgr50058.outbound.protection.outlook.com ([40.107.5.58]:44208
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726125AbeKESt0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 13:49:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/fw02AuTWlU+fCEl4KtjnTRKR1UE6IdokVcRBnTHVEQ=;
 b=NGQuGa4l/CYYpRKDddI+fcPZSU0h1tlsW4ZbY4EIaXmy9zxuU8iL/kX2xeNKxocVwomKjU1DTkx9+lAkbRgsiJ4YMRzCrJKP3t6YPMUg81ctwg2NjRom75hDy5nBpbBWu6jVesMUtC4wgIPqVBrfBpiyxAhy3j3Ru/rx3lYrhbg=
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com (10.172.255.18) by
 VI1PR0402MB3421.eurprd04.prod.outlook.com (52.134.3.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.27; Mon, 5 Nov 2018 09:30:33 +0000
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::78a4:e54f:f26:36d9]) by VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::78a4:e54f:f26:36d9%7]) with mapi id 15.20.1294.032; Mon, 5 Nov 2018
 09:30:33 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     Roy Pledge <roy.pledge@nxp.com>,
        Youri Querry <youri.querry_1@nxp.com>,
        Leo Li <leoyang.li@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 1/2] soc: fsl: dpio: cleanup the cpu array on dpaa2_io_down
Thread-Topic: [PATCH 1/2] soc: fsl: dpio: cleanup the cpu array on
 dpaa2_io_down
Thread-Index: AQHUdOozp5KcL/cst0eTurdFiXghBw==
Date:   Mon, 5 Nov 2018 09:30:32 +0000
Message-ID: <1541410219-9943-2-git-send-email-ioana.ciornei@nxp.com>
References: <1541410219-9943-1-git-send-email-ioana.ciornei@nxp.com>
In-Reply-To: <1541410219-9943-1-git-send-email-ioana.ciornei@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0167.eurprd07.prod.outlook.com
 (2603:10a6:802:3e::15) To VI1PR0402MB2800.eurprd04.prod.outlook.com
 (2603:10a6:800:ad::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB3421;6:ItjzkvnvAJ7pbciclM6WRj0SZc8Q3L/oGyvWiZ43lZPnne/6kIevMGehzQnpoaVbWR8+8kYfRpyZle4jAbGXcIfI0QteXoyzGQqXt7gS2LnD3EZMXONJ/D5c29vvQjbfz0tJghgrcw9+PQvZ3uCXFSiE9vRt6HW/7F6HdoSzaJd8wNGwRkIBk6hhh1OJUWJvqriZMePZ9MCkN0A2UBlghrnkw/DYGzEJVkdU905Ap6VTKWh75nDaLLrZ1uhYEtfWapMbcTVCYev4jEKsfhgvE3eTIwYGtfQFNn6aKhgzkYTG4AgvgwSV/haxy/gW4iZsQwtIaxU1cvaS8BpXzvqxH5cbIYOWynUrMpl7fue9jgNuLqs/nU22J8gQVkd7u9Fbd2zcWrsBTUZ3UFyGte7w66aniyZLg+95o7HlQEMA6w0KlT5Axm+tnK2zZVyTzgVn5KpHMRURxZxrgMPJ1YZlsw==;5:6xTFvpcr5nl4JTCjVyVkewuGzl9LaDoUnbNb9jweMZkCHWR2PM+zxQtaaj6qGE/59bxS6ITFq6RYNMzMBI7VB2O8U0m/2Z09ed9T2ewRJzc0qLJZHbWBwZgH0alz96MXo675JDxzCtJB9cnpHZ7BtEAj8FaMYW1ZKfwVRcPULKE=;7:Di+I+ISI1Qe4R4pV6JCWzu13rr7pYBXmDXts2huumsAeV0nqKO0dpLXADdom6vSrqAM7rgfj7VLZ2jkluLwCE7nauyqWpy7EBWoBJmcFZGLTKvkpsB1/W3n172MOTKKHUjPjecOUGRM7PNXz0bBetQ==
x-ms-office365-filtering-correlation-id: 03eaf20e-9337-47c6-6261-08d643015570
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3421;
x-ms-traffictypediagnostic: VI1PR0402MB3421:
x-microsoft-antispam-prvs: <VI1PR0402MB3421426D64CC0B4340C8FE00E0CA0@VI1PR0402MB3421.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:VI1PR0402MB3421;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0402MB3421;
x-forefront-prvs: 08476BC6EF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(396003)(136003)(39860400002)(189003)(199004)(66066001)(106356001)(25786009)(446003)(97736004)(11346002)(256004)(14454004)(2501003)(105586002)(68736007)(6512007)(53936002)(14444005)(2900100001)(2906002)(3846002)(6116002)(6506007)(386003)(52116002)(99286004)(36756003)(7736002)(305945005)(6486002)(316002)(6436002)(110136005)(54906003)(186003)(4326008)(102836004)(86362001)(71190400001)(71200400001)(81166006)(81156014)(486006)(8676002)(2201001)(478600001)(5660300001)(476003)(2616005)(8936002)(76176011)(44832011)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3421;H:VI1PR0402MB2800.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: BQ54DSn4kEMbXSUIi29NgnzOytOKUs4bIYbwy0geOCKi1Ya+o452xx24uzrahWEUxob3VH54uitrRQLiDRve5CUwGlpeovg9C6rlltssrwFDofh5+RYmuRoKWKWmojQ5AiWh5B38lI1xjEAknvnXLn/8o5dXC01TSi5RZQzbelxVuU6rGGX0AKtCY4Hymd9Ryl4DgGtlruQLCslWdCeoZirPjdyooxax5yHr3RcrGUo7SjsmeVkbBIoJHwcxqKnfsdwY+/yVV90AvqEIelyX64I4w7P1vkFraNc+Wc7bI0ovkbZY9e4FmolDeDpun+siWdcP4lpoVClGXmkMs2Bg6pbBOXvYxS4QynCT0qldiP8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03eaf20e-9337-47c6-6261-08d643015570
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2018 09:30:32.9743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3421
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dpio_by_cpu array should not contain a reference to a freed dpaa2_io
object. This patch adds the necessary cleanup in dpaa2_io_down.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
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

