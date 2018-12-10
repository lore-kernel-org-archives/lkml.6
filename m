Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7046C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AAA32082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:50:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FYS4BgjS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AAA32082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbeLJQul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 11:50:41 -0500
Received: from mail-eopbgr70059.outbound.protection.outlook.com ([40.107.7.59]:24256
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727062AbeLJQuk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 11:50:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uazf8naZk5aPwtlvmSe5ucZ8KOiXXDPWqm2M/iSonck=;
 b=FYS4BgjSEJgrxAwZfVAaB2tl5y8iXsAio/Huc5w/fWSDhXbgsonuGlyu8WvX0Bu/ApDZhKh+HxaPPY1aknM7ZaqKKU1DMvyIJmxJzeEfeGlIjWu7VeQT268MUloASAN/C1F6mwf2RZTenpe47wrd+0kA6FSwNLLdumg43P/1Qfs=
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com (10.172.255.18) by
 VI1PR0402MB2750.eurprd04.prod.outlook.com (10.175.22.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.21; Mon, 10 Dec 2018 16:50:18 +0000
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::d9a8:33a8:4241:be86]) by VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::d9a8:33a8:4241:be86%11]) with mapi id 15.20.1404.026; Mon, 10 Dec
 2018 16:50:18 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     Leo Li <leoyang.li@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
        Roy Pledge <roy.pledge@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 2/5] soc: fsl: dpio: keep a per dpio device MC portal
Thread-Topic: [PATCH 2/5] soc: fsl: dpio: keep a per dpio device MC portal
Thread-Index: AQHUkKhuMhaQRRe3ZUGzxuFMu3rz6g==
Date:   Mon, 10 Dec 2018 16:50:17 +0000
Message-ID: <1544460591-14888-3-git-send-email-ioana.ciornei@nxp.com>
References: <1544460591-14888-1-git-send-email-ioana.ciornei@nxp.com>
In-Reply-To: <1544460591-14888-1-git-send-email-ioana.ciornei@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0145.eurprd08.prod.outlook.com
 (2603:10a6:800:d5::23) To VI1PR0402MB2800.eurprd04.prod.outlook.com
 (2603:10a6:800:ad::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB2750;6:lgmrMLo2/fj4pnEwyE+EV2/oo5L6Lp/60xPpud2kFXlABuGoIXnHPvcu7Ulg2IY6onq2dO+9idFoq0vGUnvxzcohfy4huZru7gv33m6v0PtVrdB5LqV1YYzk+16XrwDP9O65PjnN7wxzT2PZIVQdo40IGAlDHtmcSFhif2Lzyt2ia2SFhmck4S4ycALoKFb3mIhARurVnxKjZpFOAGoJn6P9BkexGNrq5wsvre1V57oHIayoe+hiEwjz1q/JA90rH+u4XpxUyp49m5XzbOd+3qo1+1iN4IaZju9mFi8Um0vqPollo4ByHKouJsHWib6YvmAPC5QVVQYVpjq8/QpRPaPR0vpi3YzKNP5QLqEN7B4ha/3pepJAJmfJTbeR4+z2D8ReAF6nVNW4EfUOZ9gd67+BEYn85WEeMPb5a+z5rQuUwCluJB0xnaZMxroDQLmd/gtdGjsbiCLqGMmGUsYyJg==;5:sveKB59Vo9q0lagXDJedocv8TCaV/pBNiqmH79TiLvzPfRlT4ZmRwKDVhnDLkS3L4x5PIkHxFVatrdl6Tr56P9D1IgYG+JLeRxPyRYE2f/kDSV8Qr5xhSXDWWtQlzQY31CeKPrJJFnx2Pd/Wjc4ZbvuLnVOJ+L+n3abBlgWuMnM=;7:bRxOWLp2b6sktUr+32/fUhvY80fdRNuErn7ManTFfZDQvge6W/nH8PHibZNGulkeF28pDPyk5wxNQC0e6lcY6PS4gsxdD6xa0ZStXV/nzCxKFOSLAcfyPXibAmaXoVnbLFuPfWV82OdK5VItr8YYcg==
x-ms-office365-filtering-correlation-id: 9208904b-6254-4d63-cccc-08d65ebf909a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB2750;
x-ms-traffictypediagnostic: VI1PR0402MB2750:
x-microsoft-antispam-prvs: <VI1PR0402MB2750FAEBD40F9DE87E723622E0A50@VI1PR0402MB2750.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:VI1PR0402MB2750;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0402MB2750;
x-forefront-prvs: 08828D20BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(366004)(136003)(376002)(346002)(199004)(189003)(186003)(2501003)(11346002)(44832011)(53936002)(2616005)(71190400001)(476003)(2201001)(3846002)(6116002)(71200400001)(66066001)(486006)(305945005)(7736002)(86362001)(68736007)(36756003)(6436002)(81156014)(14444005)(316002)(110136005)(8936002)(14454004)(81166006)(478600001)(446003)(256004)(54906003)(25786009)(8676002)(6486002)(99286004)(76176011)(102836004)(106356001)(26005)(105586002)(386003)(2906002)(97736004)(5660300001)(6506007)(52116002)(6512007)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB2750;H:VI1PR0402MB2800.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: DFfIfij0DMBdQFJSFIRKAW90F0wWM7KUelLGoNLVqO52OdcZtTR45NL9j/NM6T8kOYWiHD5cJdxQCCR2K/+mYPq9fVMRLAs1zYf0dQyzNq2aFQqPB55Zx5fjHccFBQ/SkxbF1Hw0THAhCtHlp52PG5BFcaQO4//mfvk0NbLr2N1alBWftIjnvyUeEnOZsfa5TTPTQ1HU+bnO3rhaWRFBggXIRTF4Y18Aq6lzpRwvK+oyCdrSVtVTzhmVdIcVj9Uaa6FZ/N/gRZyP/CfE/sZ5iubyeRLroX3WWcv7i1Y8w6NWNsSMTRzPssBZjXnl62q0
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9208904b-6254-4d63-cccc-08d65ebf909a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2018 16:50:18.0014
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2750
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the moment, the dpio-driver allocates an MC portal at probe time and
frees it right after usage. The same thing happens on the remove path.
This behavior could lead to scenarios where an MC portal is available
for use at probing but not longer free on the remove path which could
lead to unproper unbind of resources.

Change the driver's behavior in such a way that an MC portal is
allocated at probe and kept until the DPIO device is removed. This will
ensure that at any time after a DPIO device was successfully probed, all
its dependencies will be met.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/soc/fsl/dpio/dpio-driver.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/soc/fsl/dpio/dpio-driver.c b/drivers/soc/fsl/dpio/dpio=
-driver.c
index 38ee9db..5286723 100644
--- a/drivers/soc/fsl/dpio/dpio-driver.c
+++ b/drivers/soc/fsl/dpio/dpio-driver.c
@@ -187,7 +187,6 @@ static int dpaa2_dpio_probe(struct fsl_mc_device *dpio_=
dev)
 	dev_dbg(dev, "   receives_notifications =3D %d\n",
 		desc.receives_notifications);
 	dpio_close(dpio_dev->mc_io, 0, dpio_dev->mc_handle);
-	fsl_mc_portal_free(dpio_dev->mc_io);
=20
 	return 0;
=20
@@ -229,12 +228,6 @@ static int dpaa2_dpio_remove(struct fsl_mc_device *dpi=
o_dev)
 	cpu =3D dpaa2_io_get_cpu(priv->io);
 	cpumask_set_cpu(cpu, cpus_unused_mask);
=20
-	err =3D fsl_mc_portal_allocate(dpio_dev, 0, &dpio_dev->mc_io);
-	if (err) {
-		dev_err(dev, "MC portal allocation failed\n");
-		goto err_mcportal;
-	}
-
 	err =3D dpio_open(dpio_dev->mc_io, 0, dpio_dev->obj_desc.id,
 			&dpio_dev->mc_handle);
 	if (err) {
@@ -252,7 +245,7 @@ static int dpaa2_dpio_remove(struct fsl_mc_device *dpio=
_dev)
=20
 err_open:
 	fsl_mc_portal_free(dpio_dev->mc_io);
-err_mcportal:
+
 	return err;
 }
=20
--=20
1.9.1

