Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3926AC46464
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 22:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E224920882
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 22:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="VQNE2jsA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E224920882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbeKHHgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 02:36:06 -0500
Received: from mail-eopbgr730056.outbound.protection.outlook.com ([40.107.73.56]:17664
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727945AbeKHHgF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 02:36:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1v6kKh3w8DKI6XhxuOY3njcmMYdey+u44Omf1y5S84A=;
 b=VQNE2jsAYCp0xeaQG0FbbxhTi2bUzEtob1cptOScM+lAeYJQgoeQuLwiBlw1erunu1Qe26mXpewVUij0VKR3N9djhrkIIQDzzaV88Ug9kYfd+E7VynBL/HOuX8Cck3/YbapmQrR+BFiks+CZIh1dQ2e2YR3dv+2gBTCKa6Wr+aI=
Received: from SN6PR07MB5326.namprd07.prod.outlook.com (52.135.105.33) by
 SN6PR07MB5232.namprd07.prod.outlook.com (52.135.120.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.22; Wed, 7 Nov 2018 22:03:24 +0000
Received: from SN6PR07MB5326.namprd07.prod.outlook.com
 ([fe80::f0b9:acf9:7513:c149]) by SN6PR07MB5326.namprd07.prod.outlook.com
 ([fe80::f0b9:acf9:7513:c149%5]) with mapi id 15.20.1294.034; Wed, 7 Nov 2018
 22:03:24 +0000
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
        "Richter, Robert" <Robert.Richter@cavium.com>
Subject: [PATCH 05/10] fsl-mc/dprc-driver: Remove domain init order
 dependencies
Thread-Topic: [PATCH 05/10] fsl-mc/dprc-driver: Remove domain init order
 dependencies
Thread-Index: AQHUduW0VN1jp84mL0GDuCXIDaS+Ow==
Date:   Wed, 7 Nov 2018 22:03:24 +0000
Message-ID: <20181107220254.6116-6-rrichter@cavium.com>
References: <20181107220254.6116-1-rrichter@cavium.com>
In-Reply-To: <20181107220254.6116-1-rrichter@cavium.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR03CA0033.eurprd03.prod.outlook.com (2603:10a6:20b::46)
 To SN6PR07MB5326.namprd07.prod.outlook.com (2603:10b6:805:73::33)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Robert.Richter@cavium.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [77.180.181.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR07MB5232;6:X8PZ1s7uxwnfYUgTzSFV8x2smH6NSVypUyCUihKNNgVZ85PXprk9AT7HBfeRh7dcI7jeSBYlU8k0a/SWI/MgHH/5h5bvDQ2RvmJdZiSCb6ynasSLnQrQmMCwQwZxXWihaRQxYsJGD992L+EBIanTSGb4vhTtuljz9157ViSnSWHFhvimsnI9FHKjescH1Z6Dnzn4f0rQUCcbQ9/c0SgnMnGYnMiji499SjZ49RQ26XVi0gxSNJf8zVvRVnoLr5QVJdQ08ynyT43O5wRP/Z8ViHf6RNBueeH0TEatobQo4f4fkvrGOIFeTKTEkttU2xgHJAPsmmj3c/WCHJG5VjhfWlMIxiZ5jboYmZqyMNJ7DUYfPPwVgn/ddDVvLLZHZ8XvG0KceI47L0JWW/vzT3Dq2ZlAqubNffvjqHoulQRB2fUL2+CFJ1DKtI4ipFFUiNqnhhX7jhOgWBypRADLN5A4VA==;5:NofFWQ5rt9XOisBnEmsWRWTOi9rwTDgxhchD7DtYe3K78I21vf6j375qVTsj9vrGr6QP2oqftI3Id05juSXt7+xPb5FwhI5kRw5tH/I7PST/R1l3IWFAWEJNGv0Wj2TL0AOnx4fGd1GiPwqVY8MiKywpFqb9mgJ248aMLQ2clkE=;7:NKw+3gpYkLSXndST180P/5ITbWkDvj9A9q30v9OD4LU3dYO5i2dpHyj5P59ERIalFMG8e73rPE3qdj5sc34RkSyiNL/bjBCFsTEmjM/24rG5oLXn19jpCkRYpoq0VOGoCcgYt8yjxhTDhUKn4fLazw==
x-ms-office365-filtering-correlation-id: 10ac5363-bb9e-4b35-634d-08d644fcd6bf
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:SN6PR07MB5232;
x-ms-traffictypediagnostic: SN6PR07MB5232:
x-microsoft-antispam-prvs: <SN6PR07MB52321691285D20200CA6F19CF1C40@SN6PR07MB5232.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(269456686620040);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231382)(944501410)(52105095)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:SN6PR07MB5232;BCL:0;PCL:0;RULEID:;SRVR:SN6PR07MB5232;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(39860400002)(346002)(396003)(376002)(189003)(199004)(71200400001)(7736002)(71190400001)(39060400002)(6486002)(3846002)(66066001)(6436002)(186003)(36756003)(476003)(478600001)(2616005)(53936002)(256004)(14444005)(446003)(305945005)(11346002)(6512007)(54906003)(1076002)(316002)(107886003)(25786009)(110136005)(6116002)(2906002)(97736004)(4326008)(6506007)(386003)(72206003)(105586002)(99286004)(486006)(5660300001)(7416002)(8936002)(102836004)(106356001)(68736007)(8676002)(14454004)(81156014)(76176011)(81166006)(2900100001)(52116002)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB5232;H:SN6PR07MB5326.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: csI32IRMuSOrQkbLos+TufEyBEE4nRBxHKYyOBz5p0SdOVaCb7Wx3iOV0zqS+Pm29tsn1FJip0PqXOrRjigRp8EdBjcYka7brLveVLTXr459YJ2SDhRDUaFvEQcAifsTeuaucBuyqryevUgYueLcWCm8uNAdWe2QfmfFBmy9mMYTp8iC8E60HKNF5PajJ2B9zlqMGGE/1u/L/grrgQTkuPOC+USQ7O+X/WdRYmJleNrSKyUkn+/GmwSUvX5e2gyawzcRghXKR0Jp1jJiRdF8HKqdK0MK+vfFaSzn0mcMKQhqoVSdIleLxIKOw0XLVhUgjAYZkKuDWXIc3fQRXGyg4MtYnuVXdodgokb+G3JuzXU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10ac5363-bb9e-4b35-634d-08d644fcd6bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 22:03:24.8410
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB5232
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

