Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FCE7C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2F80206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="URrAnWxI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2F80206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbeK2BpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 20:45:17 -0500
Received: from mail-eopbgr730056.outbound.protection.outlook.com ([40.107.73.56]:23355
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728766AbeK2BpP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 20:45:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1v6kKh3w8DKI6XhxuOY3njcmMYdey+u44Omf1y5S84A=;
 b=URrAnWxI1R6Gkfq+ThN9LUbWFuVM+fFFX8FvUk1E74GjpfvCPeyQ+cX5vzCGkXl20sOQ9aQFz7WWsZuIOzy/SMK61wTmB+UzVBYCgu7ZWIjlZ0TkhA0TRVC/JKJnBzKpcSSjD+AlhPWvO6L8LgWVEyEXASEYhcSggggs1wfx6g0=
Received: from SN6PR07MB5326.namprd07.prod.outlook.com (52.135.105.33) by
 SN6PR07MB4269.namprd07.prod.outlook.com (52.135.89.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.16; Wed, 28 Nov 2018 14:43:19 +0000
Received: from SN6PR07MB5326.namprd07.prod.outlook.com
 ([fe80::ccc7:d111:7f3d:667d]) by SN6PR07MB5326.namprd07.prod.outlook.com
 ([fe80::ccc7:d111:7f3d:667d%4]) with mapi id 15.20.1361.018; Wed, 28 Nov 2018
 14:43:19 +0000
From:   Robert Richter <rrichter@cavium.com>
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        "Richter, Robert" <Robert.Richter@cavium.com>,
        Julien Thierry <julien.thierry@arm.com>
Subject: [PATCH v2 05/10] fsl-mc/dprc-driver: Remove domain init order
 dependencies
Thread-Topic: [PATCH v2 05/10] fsl-mc/dprc-driver: Remove domain init order
 dependencies
Thread-Index: AQHUhyi0qFdjTljGQU2/GluYiC9iqw==
Date:   Wed, 28 Nov 2018 14:43:19 +0000
Message-ID: <20181128144240.28727-6-rrichter@cavium.com>
References: <20181128144240.28727-1-rrichter@cavium.com>
In-Reply-To: <20181128144240.28727-1-rrichter@cavium.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P194CA0042.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:209:84::19) To SN6PR07MB5326.namprd07.prod.outlook.com
 (2603:10b6:805:73::33)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Robert.Richter@cavium.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [77.14.124.106]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR07MB4269;6:IiDzMSj3Y7nYs0NGN+hwht0rNSKcpJl4b5J4T4HgL9IczbX08AymcmIQg+HIZvVLNTpGtEIcVSGnsM/nGPgZP2bA66UQqmGzFxR3p1IBUN7TzO9dWdjvKi8Rir4zzDTFriFHcLAwLQrxfd1oOEVVfP+86j6m6eLK1zZCbsGK0yI+fGwS801BGtPuvO1WCh/7Vygmgd9m0GxtoF3dD9sNinfyuEx641qUZ2RAA/gnnCiExTTvFriYusGzMwoHS62G3+G55jd9eyKhu61BMIeveqIlpZ5m6+1Mg96lIQldi+7415uF9FSM2MOuIqh+3SEUTE+iNQx3mk1CUQfNV8Fcceq6cXgRO1GI5PpSXk4M0JcI0KJ7KrE+W7bCSJop117YAmaI/I8Ug166Xgk/whvQfh4GSn8Dm8ch+Qd+nJrLS7qIxPkTacR7uZyssBFfjxog8kWYBeafc2+ZtSkKDru0AA==;5:N5QMj/3v5kUB1Ok5f/Nz/oDbLIJGYCOgkJaN9t1cKLs5gtfZlZIA6oMlG7rRq1QQXzLZ9SrRTMvhpvCUrAxQCI5DtA989O9TOlQyS6TukIoFUWc7Vom7Mj+AnlqPST2uYE20KmIeYt1vOZcqE3Kn3opo0OGaHGsjLqIbJaca+lk=;7:hOCh7JddnjWORnrCCmoM1hULJVI4PnhmEOZOzYjWNPXXykqFJuBRwkPq5y2POQGxT69JZNnL1tJV2yCMsbn2G4hbB5igdWTQpi0t/akfLd20OJik+7B9VPCAXMe5PNr9hijVIV+cWAXMSPjKykSMpw==
x-ms-office365-filtering-correlation-id: 19a8e64c-f72a-4bb5-3d32-08d6553fd68b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:SN6PR07MB4269;
x-ms-traffictypediagnostic: SN6PR07MB4269:
x-microsoft-antispam-prvs: <SN6PR07MB4269BB7C6AB851EE6DD33894F1D10@SN6PR07MB4269.namprd07.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231443)(999002)(944501410)(52105112)(10201501046)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:SN6PR07MB4269;BCL:0;PCL:0;RULEID:;SRVR:SN6PR07MB4269;
x-forefront-prvs: 0870212862
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(39860400002)(136003)(366004)(199004)(189003)(3846002)(4326008)(97736004)(14444005)(105586002)(106356001)(110136005)(8936002)(81156014)(66066001)(54906003)(71200400001)(81166006)(256004)(71190400001)(316002)(6486002)(14454004)(8676002)(2906002)(39060400002)(186003)(76176011)(52116002)(6116002)(6506007)(68736007)(7416002)(25786009)(72206003)(478600001)(1076002)(53936002)(6512007)(99286004)(446003)(26005)(11346002)(6436002)(476003)(102836004)(7736002)(36756003)(305945005)(5660300001)(386003)(2616005)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB4269;H:SN6PR07MB5326.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: woZ1/ylx1G6aqHPdyjLJEnu9Ly6z8QBo7p1jPv5ScAlDsiBNGGj6EZglMf8Acuxz6ySido8sMMVhIR9dNOKQiSdfFW1c2rGGchGCT6y1uI1/kZqGnVpaMyqiJosGOaeX6yAH6Y8md6ccTG+QIppGlg/cpuKsyDctxYtym5bZ8Beksg4z6g7Q4bH+hismhnwEMrFoNOlx+IrEfujUNcmsdQcvLiapDdYTAHoR301j/qKXoiuPZuqJLsZi6KM66XyAHagS8jMALKx4U1RJ+GSey3vYSFQmtJPVd1vR7+fpehL2s0hqVsvbsvHq+oxXnddYIWXADPwatQfxEJ3aG2sgyHoaF0eXuUwrypWpBU2qXJc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19a8e64c-f72a-4bb5-3d32-08d6553fd68b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2018 14:43:19.5878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4269
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use new irq_domain_request_host_*() interface which allows independent
parent and child initialization using an irq domain request handler.
This makes it possible to move its initialization to a later point
during boot. All domains can be initialized in the same initcall level
then.

Signed-off-by: Robert Richter <rrichter@cavium.com>
---
 drivers/bus/fsl-mc/dprc-driver.c | 41 ++++++++++++++++++++++++++++++++++++=
++++
 drivers/bus/fsl-mc/fsl-mc-msi.c  |  6 +-----
 2 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/drivers/bus/fsl-mc/dprc-driver.c b/drivers/bus/fsl-mc/dprc-dri=
ver.c
index 52c7e15143d6..2f41886c8e00 100644
--- a/drivers/bus/fsl-mc/dprc-driver.c
+++ b/drivers/bus/fsl-mc/dprc-driver.c
@@ -10,7 +10,9 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
+#include <linux/irqdomain.h>
 #include <linux/msi.h>
+#include <linux/of.h>
 #include <linux/fsl/mc.h>
=20
 #include "fsl-mc-private.h"
@@ -575,6 +577,40 @@ static int dprc_setup_irq(struct fsl_mc_device *mc_dev=
)
 	return error;
 }
=20
+static int dprc_probe(struct fsl_mc_device *mc_dev);
+
+static int dprc_probe_late(struct irq_domain *parent, void *priv)
+{
+	struct fsl_mc_device *mc_dev =3D priv;
+
+	of_node_put(mc_dev->dev.parent->of_node);
+	of_node_put(irq_domain_get_of_node(parent));
+
+	return dprc_probe(mc_dev);
+}
+
+static int dprc_register_msi_domain(struct fsl_mc_device *mc_dev)
+{
+	struct device_node *mc_of_node, *msi_np;
+	int err =3D -EINVAL;
+
+	mc_of_node =3D of_node_get(mc_dev->dev.parent->of_node);
+
+	msi_np =3D of_parse_phandle(mc_of_node, "msi-parent", 0);
+	if (msi_np && !of_property_read_bool(msi_np, "#msi-cells"))
+		err =3D irq_domain_request_host(msi_np, DOMAIN_BUS_FSL_MC_MSI,
+			dprc_probe_late, mc_dev);
+
+	if (err) {
+		pr_err("Unable to find fsl-mc MSI domain for %pOF\n",
+			mc_of_node);
+		of_node_put(msi_np);
+		of_node_put(mc_of_node);
+	}
+
+	return err;
+}
+
 /**
  * dprc_probe - callback invoked when a DPRC is being bound to this driver
  *
@@ -641,6 +677,11 @@ static int dprc_probe(struct fsl_mc_device *mc_dev)
=20
 		error =3D fsl_mc_find_msi_domain(parent_dev,
 					       &mc_msi_domain);
+
+		if (error =3D=3D -ENOENT)
+			/* initialize later */
+			return dprc_register_msi_domain(mc_dev);
+
 		if (error < 0) {
 			dev_warn(&mc_dev->dev,
 				 "WARNING: MC bus without interrupt support\n");
diff --git a/drivers/bus/fsl-mc/fsl-mc-msi.c b/drivers/bus/fsl-mc/fsl-mc-ms=
i.c
index 8b9c66d7c4ff..550d2ed07f69 100644
--- a/drivers/bus/fsl-mc/fsl-mc-msi.c
+++ b/drivers/bus/fsl-mc/fsl-mc-msi.c
@@ -185,12 +185,8 @@ int fsl_mc_find_msi_domain(struct device *mc_platform_=
dev,
=20
 	msi_domain =3D of_msi_get_domain(mc_platform_dev, mc_of_node,
 				       DOMAIN_BUS_FSL_MC_MSI);
-	if (!msi_domain) {
-		pr_err("Unable to find fsl-mc MSI domain for %pOF\n",
-		       mc_of_node);
-
+	if (!msi_domain)
 		return -ENOENT;
-	}
=20
 	*mc_msi_domain =3D msi_domain;
 	return 0;
--=20
2.11.0

