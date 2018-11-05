Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77013ECDE44
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CFA220869
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:30:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VKVk/eve"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CFA220869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbeKESt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 13:49:29 -0500
Received: from mail-eopbgr50058.outbound.protection.outlook.com ([40.107.5.58]:44208
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727290AbeKESt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 13:49:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HzVdlfoRLPrTB5mz0OWyxOshhqCiPDYW2WwLAQWJzFg=;
 b=VKVk/eveIBlAg7GIz/9lu4z5YruKof8mkl5ECqislNQdNfRHTEP8npv9WcY+KsuOnXJo4KS+gUrDtM3N9Nfpl2m3ZVX7+wCFVJFB1SRMk9kSM27o5WaTU99pO/t25aHaUb6F/auQNCXW5vsO0xOhq8OQsV+XusHeThKqPlW5NKA=
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
Subject: [PATCH 2/2] soc: fsl: dpio: use a cpumask to identify which cpus are
 unused
Thread-Topic: [PATCH 2/2] soc: fsl: dpio: use a cpumask to identify which cpus
 are unused
Thread-Index: AQHUdOozdrDXEgXDnkqgugAphJD21g==
Date:   Mon, 5 Nov 2018 09:30:33 +0000
Message-ID: <1541410219-9943-3-git-send-email-ioana.ciornei@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB3421;6:fZ/wHwPSKc1zH8tmic9CYLJm2PX7YtQFZVdDjB4w0c0ioVDh7JZ15RVece2SF3kR+WY95Rv8H4I0p0n7qraitvd0cr6zy+BQYHQnWHOhK78xnUSkMUzzohZGJjHLoizKfTjN9WR4KwvX1OtfayaJMpYKNSIqvzO1cTxX+wsRlXa/OITUEQWGTm1NnrFNMpBYoGQ9dratCPLasGrpvzRCPpvXs/n5lZWsEGWxztz2/FUZ+vF8WkDdXOpoOb3L1oJZEX/FmCg/gvkZQ9sS6lmglReRfzCavkeqPCJVwDcPRhvG2VIZYKhB+n2ZskB9qBHJiegcP1F5G+y1wpOr3mz2WgZ6VeF5FZgWEwLpIddwiN2ojfqEXF6hk5FzrK+qRWwjh3n9IGA1pVy5iNidHDB1K9uOOd5ZaSHt/mT1B3mlDXXItWukUKUW3reNwJqCUnJkL4eqVO33yUxL0Hl3GrQ2IA==;5:gfKv0wAAnzoENwr5RjDL3C76hfqsgmRkLGylFO/G3Iq90WCJKOmsnpxGjyCaLKKF6U8sgFHuEmnQWEmKGo/obdeYme6uepR8rZCFqRTX/k5mVogDcB7liM0jDuy8Ywg1Pd9uQjVdr68YemJQiQ2CCLKIgP78zl2uO62dbql6JVY=;7:/+Vnx4ZQpz5rXjfRj5WegCXX16Ag1N/bCi2HYgb+dQ1QMtbFZU9GA5sf2S0n1LLDjKqfZWN2qsV5hFi7Cju322yvGMai/qB2e1CmP5VUzMcCYdL3N/fRjxh0OqleghznSnks65sna74qwPEMeovMCA==
x-ms-office365-filtering-correlation-id: 4a83a017-2f5c-4be7-8195-08d6430155bd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3421;
x-ms-traffictypediagnostic: VI1PR0402MB3421:
x-microsoft-antispam-prvs: <VI1PR0402MB34218B9187E3CB0E1D098CAFE0CA0@VI1PR0402MB3421.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(275809806118684)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:VI1PR0402MB3421;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0402MB3421;
x-forefront-prvs: 08476BC6EF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(396003)(136003)(39860400002)(189003)(199004)(66066001)(106356001)(25786009)(446003)(97736004)(11346002)(256004)(14454004)(2501003)(105586002)(68736007)(6512007)(53936002)(14444005)(2900100001)(2906002)(3846002)(6116002)(6506007)(386003)(52116002)(99286004)(36756003)(7736002)(305945005)(6486002)(316002)(6436002)(110136005)(54906003)(186003)(4326008)(102836004)(86362001)(71190400001)(71200400001)(81166006)(81156014)(486006)(8676002)(2201001)(478600001)(5660300001)(476003)(2616005)(8936002)(76176011)(44832011)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3421;H:VI1PR0402MB2800.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Ry1D+npGun5+qISRIYkHWZSimgGBwP4EWm2fJmb28AxbnNw/nBjKxhjq+vUXA38Uhfxh8wbu2JzTDc2Cmlu9TCgXcraCSRImGosNX1zAqLZjFTVSPfox952Uq3ahwJqKrV4gYm+wVDfcRhGWntk3JFMpz7QTk6CuZaqgJbuvNIfaKwQc+2dp9m/89H9CIYJ9kh5vthjeJ3v24u1jGjj2gaCF9fSrBWWo58zI9kX8gSD2QyIrjBbCadszic6pTzOst0/CfZNgYEGITeYBn9E9siXsM4aiO1gN2HCotd5j95+yFu4tvsVikdEKbeT1M39GK+SOkejG7hGX868Dwc6xzdu7R+vRWbDHyyf547zxwA8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a83a017-2f5c-4be7-8195-08d6430155bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2018 09:30:33.4977
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3421
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current implementation of the dpio driver uses a static next_cpu
variable to keep track of the index of the next cpu available. This
approach does not handle well unbinding and binding dpio devices in a
random order. For example, unbinding a dpio and then binding it again
with the driver, will generate the below error:

$ echo dpio.5 > /sys/bus/fsl-mc/drivers/fsl_mc_dpio/unbind
$ echo dpio.5 > /sys/bus/fsl-mc/drivers/fsl_mc_dpio/bind
[  103.946380] fsl_mc_dpio dpio.5: probe failed. Number of DPIOs exceeds
NR_CPUS.
[  103.955157] fsl_mc_dpio dpio.5: fsl_mc_driver_probe failed: -34
-bash: echo: write error: No such device

Fix this error by keeping a global cpumask of unused cpus that will be
updated at every dpaa2_dpio_[probe,remove].

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/soc/fsl/dpio/dpio-driver.c  | 25 ++++++++++++++++---------
 drivers/soc/fsl/dpio/dpio-service.c |  6 ++++++
 include/soc/fsl/dpaa2-io.h          |  2 ++
 3 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/soc/fsl/dpio/dpio-driver.c b/drivers/soc/fsl/dpio/dpio=
-driver.c
index e58fcc9..832175c 100644
--- a/drivers/soc/fsl/dpio/dpio-driver.c
+++ b/drivers/soc/fsl/dpio/dpio-driver.c
@@ -30,6 +30,8 @@ struct dpio_priv {
 	struct dpaa2_io *io;
 };
=20
+static cpumask_var_t cpus_unused_mask;
+
 static irqreturn_t dpio_irq_handler(int irq_num, void *arg)
 {
 	struct device *dev =3D (struct device *)arg;
@@ -86,7 +88,7 @@ static int dpaa2_dpio_probe(struct fsl_mc_device *dpio_de=
v)
 	struct dpio_priv *priv;
 	int err =3D -ENOMEM;
 	struct device *dev =3D &dpio_dev->dev;
-	static int next_cpu =3D -1;
+	int possible_next_cpu;
=20
 	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -128,17 +130,14 @@ static int dpaa2_dpio_probe(struct fsl_mc_device *dpi=
o_dev)
 	desc.dpio_id =3D dpio_dev->obj_desc.id;
=20
 	/* get the cpu to use for the affinity hint */
-	if (next_cpu =3D=3D -1)
-		next_cpu =3D cpumask_first(cpu_online_mask);
-	else
-		next_cpu =3D cpumask_next(next_cpu, cpu_online_mask);
-
-	if (!cpu_possible(next_cpu)) {
+	possible_next_cpu =3D cpumask_first(cpus_unused_mask);
+	if (possible_next_cpu >=3D nr_cpu_ids) {
 		dev_err(dev, "probe failed. Number of DPIOs exceeds NR_CPUS.\n");
 		err =3D -ERANGE;
 		goto err_allocate_irqs;
 	}
-	desc.cpu =3D next_cpu;
+	desc.cpu =3D possible_next_cpu;
+	cpumask_clear_cpu(possible_next_cpu, cpus_unused_mask);
=20
 	/*
 	 * Set the CENA regs to be the cache inhibited area of the portal to
@@ -211,7 +210,7 @@ static int dpaa2_dpio_remove(struct fsl_mc_device *dpio=
_dev)
 {
 	struct device *dev;
 	struct dpio_priv *priv;
-	int err;
+	int err =3D 0, cpu;
=20
 	dev =3D &dpio_dev->dev;
 	priv =3D dev_get_drvdata(dev);
@@ -220,6 +219,9 @@ static int dpaa2_dpio_remove(struct fsl_mc_device *dpio=
_dev)
=20
 	dpio_teardown_irqs(dpio_dev);
=20
+	cpu =3D dpaa2_io_get_cpu(priv->io);
+	cpumask_set_cpu(cpu, cpus_unused_mask);
+
 	err =3D fsl_mc_portal_allocate(dpio_dev, 0, &dpio_dev->mc_io);
 	if (err) {
 		dev_err(dev, "MC portal allocation failed\n");
@@ -267,11 +269,16 @@ static int dpaa2_dpio_remove(struct fsl_mc_device *dp=
io_dev)
=20
 static int dpio_driver_init(void)
 {
+	if (!zalloc_cpumask_var(&cpus_unused_mask, GFP_KERNEL))
+		return -ENOMEM;
+	cpumask_copy(cpus_unused_mask, cpu_online_mask);
+
 	return fsl_mc_driver_register(&dpaa2_dpio_driver);
 }
=20
 static void dpio_driver_exit(void)
 {
+	free_cpumask_var(cpus_unused_mask);
 	fsl_mc_driver_unregister(&dpaa2_dpio_driver);
 }
 module_init(dpio_driver_init);
diff --git a/drivers/soc/fsl/dpio/dpio-service.c b/drivers/soc/fsl/dpio/dpi=
o-service.c
index 21c3e32..3198265 100644
--- a/drivers/soc/fsl/dpio/dpio-service.c
+++ b/drivers/soc/fsl/dpio/dpio-service.c
@@ -214,6 +214,12 @@ irqreturn_t dpaa2_io_irq(struct dpaa2_io *obj)
 	return IRQ_HANDLED;
 }
=20
+int dpaa2_io_get_cpu(struct dpaa2_io *d)
+{
+	return d->dpio_desc.cpu;
+}
+EXPORT_SYMBOL(dpaa2_io_get_cpu);
+
 /**
  * dpaa2_io_service_register() - Prepare for servicing of FQDAN or CDAN
  *                               notifications on the given DPIO service.
diff --git a/include/soc/fsl/dpaa2-io.h b/include/soc/fsl/dpaa2-io.h
index ab51e40..1c1764f 100644
--- a/include/soc/fsl/dpaa2-io.h
+++ b/include/soc/fsl/dpaa2-io.h
@@ -90,6 +90,8 @@ struct dpaa2_io_notification_ctx {
 	void *dpio_private;
 };
=20
+int dpaa2_io_get_cpu(struct dpaa2_io *d);
+
 int dpaa2_io_service_register(struct dpaa2_io *service,
 			      struct dpaa2_io_notification_ctx *ctx);
 void dpaa2_io_service_deregister(struct dpaa2_io *service,
--=20
1.9.1

