Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1CBC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9D6D206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="AA6ETgT0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9D6D206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbeK2BpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 20:45:13 -0500
Received: from mail-eopbgr690089.outbound.protection.outlook.com ([40.107.69.89]:49833
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728867AbeK2BpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 20:45:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cb2JuV/VRNxx02cKKRzEH34nqnmavH+4S6QRZ7rDHdA=;
 b=AA6ETgT0VfCIgxlhlAOylsnK3J2+1op3TC5jTtqTrfWvKyShKmloH4Q8QQRNOdVQTUWTpiYi0zrAFPFMvbrKoWVgyyHxXMcTQ46oUCSUFmLgRPJbR48tQs8qSU10OWpP19m6NYZoThI4zr8XTZDtGiRMR9YLZjIj6hrkir1J/6c=
Received: from SN6PR07MB5326.namprd07.prod.outlook.com (52.135.105.33) by
 SN6PR07MB4269.namprd07.prod.outlook.com (52.135.89.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.16; Wed, 28 Nov 2018 14:43:16 +0000
Received: from SN6PR07MB5326.namprd07.prod.outlook.com
 ([fe80::ccc7:d111:7f3d:667d]) by SN6PR07MB5326.namprd07.prod.outlook.com
 ([fe80::ccc7:d111:7f3d:667d%4]) with mapi id 15.20.1361.018; Wed, 28 Nov 2018
 14:43:16 +0000
From:   Robert Richter <rrichter@cavium.com>
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        "Richter, Robert" <Robert.Richter@cavium.com>,
        Julien Thierry <julien.thierry@arm.com>
Subject: [PATCH v2 04/10] irqchip/irq-gic-v3-its-fsl-mc-msi: Remove domain
 init order dependencies
Thread-Topic: [PATCH v2 04/10] irqchip/irq-gic-v3-its-fsl-mc-msi: Remove
 domain init order dependencies
Thread-Index: AQHUhyiyrS1HlGLxGEyUcM/gwdB22Q==
Date:   Wed, 28 Nov 2018 14:43:15 +0000
Message-ID: <20181128144240.28727-5-rrichter@cavium.com>
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
x-microsoft-exchange-diagnostics: 1;SN6PR07MB4269;6:dnTBPcmv5dtw/+Mz0sNZ/AMXbB6zV0s8XrXxwPH8q6DYrDuoMwchfubW/F+Su8Ni0J2Q0nA6j0/6/2xaInax6RKGJ9aqXl+ti8F2glpNOkUoyz6q1ARMM6td2VTspsdY3+f+Es89QvWITs00bTSTi7mEfiZE5CRkG7RHveWe0PoqZrNyKGI6nVVByxREkOCutLBjwtGuQysiBlmg8aePC+C2BnLIDQDuJGVFEasUXm+09VOWuEbvu2Q2CO2ohW9dUPR6ieftct/8KDKgn8FVqyMYglbH62u4bg74wVeqc4PoZO02B48aDG2OjUtVI27zW0sVnQ2nsIjQ8U7bn50TwZO1en2m+c5weY0Jr2jOMHNP2SKmV22WqJOV9myRmV1whjndJaEc3Hl/ie07WrRPjt2YoZs63yRi49X+PhB7vKxPR3zFdESJXudnWE8Of4WIklt1DloeeUPrt/tSZyVoXA==;5:yNGhf6sAyZOFz8ZZTsKqXLM3b93DhoTMA7oBSd3jwHH7/FH1p7nIOoaA8jyNhgrya9oWuPFFEloVbdaXKzosUzGCV5491IlaImyu25ehQMgHMIxZXHaOlRFdrE+5Q5wjxsIX2nBl/Q+AVlMFJMD6PI44/K1BsrkJzWekx+30N9k=;7:5jn441jzCOimzAK6f+VcSxwmTdnmeLwBheN1gsLqeJPR/sx4au/tHBn/SdF66xjl5z0ziKYLrv4YYbhZdkNuLVKSvYH/xbAyftDTUMC5kDi+X8JvkNCNbpgB+g9f9Qp1hMfXvy9ag9QBxfsex00gpQ==
x-ms-office365-filtering-correlation-id: 92e29052-05f7-4c3d-084a-08d6553fd48d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:SN6PR07MB4269;
x-ms-traffictypediagnostic: SN6PR07MB4269:
x-microsoft-antispam-prvs: <SN6PR07MB42695A4759FEC5538179C028F1D10@SN6PR07MB4269.namprd07.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231443)(999002)(944501410)(52105112)(10201501046)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:SN6PR07MB4269;BCL:0;PCL:0;RULEID:;SRVR:SN6PR07MB4269;
x-forefront-prvs: 0870212862
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(39860400002)(136003)(366004)(199004)(189003)(3846002)(4326008)(97736004)(14444005)(105586002)(106356001)(110136005)(8936002)(81156014)(66066001)(54906003)(71200400001)(81166006)(256004)(71190400001)(316002)(6486002)(14454004)(8676002)(2906002)(39060400002)(186003)(76176011)(52116002)(6116002)(6506007)(68736007)(7416002)(25786009)(72206003)(478600001)(1076002)(53936002)(6512007)(99286004)(446003)(26005)(11346002)(6436002)(476003)(102836004)(7736002)(36756003)(305945005)(5660300001)(386003)(2616005)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB4269;H:SN6PR07MB5326.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: M+807HLNzTxBYUsnRkPdEYhlGBAz43KIyWuouKq/kR1VaXBgruEh1yPgDZAoUSYmhyy6FpX57ZaKSAj0BZygiEz5ulaLbre4Psq026LpqfP5n3J5VW28bz+/iwdD+3IFK61cMgzIhwkOpKNF7doFWstsoBmYgWiJw101FyNk39xdGLA78dZPZQ7y7CCqidKnsD4vMjvVnNXcR2WhRephiZbEktX6sFM7HHbIhs2XeKrHVTmX5Y4Qdctw+MucxrHab0eAJ/Y/WhdzFoFyVb9NB3iu1/pqaeuOunyJdc+SXgRPBnPC6IF97lsxAwBu/wXoY1oSzKPiFIv8Nf20ZLTTAM6mNWQZK4aPOKOpfSIbTzI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92e29052-05f7-4c3d-084a-08d6553fd48d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2018 14:43:16.0566
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
 drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c | 47 ++++++++++++++++++-------=
----
 1 file changed, 29 insertions(+), 18 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c b/drivers/irqchip/=
irq-gic-v3-its-fsl-mc-msi.c
index 606efa64adff..81dfc534ded8 100644
--- a/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c
@@ -66,11 +66,34 @@ static const struct of_device_id its_device_id[] =3D {
 	{},
 };
=20
+static int __init its_fsl_create_irq_domain(struct irq_domain *parent,
+					void *priv)
+{
+	struct device_node *np =3D irq_domain_get_of_node(parent);
+	struct irq_domain *mc_msi_domain;
+
+	if (!msi_get_domain_info(parent)) {
+		pr_err("%pOF: unable to locate ITS domain\n", np);
+		return -ENXIO;
+	}
+
+	mc_msi_domain =3D fsl_mc_msi_create_irq_domain(parent->fwnode,
+						&its_fsl_mc_msi_domain_info,
+						parent);
+	if (!mc_msi_domain) {
+		pr_err("%pOF: unable to create fsl-mc domain\n", np);
+		return -ENOMEM;
+	}
+
+	pr_info("fsl-mc MSI: %pOF domain created\n", np);
+
+	return 0;
+}
+
 static int __init its_fsl_mc_msi_init(void)
 {
 	struct device_node *np;
-	struct irq_domain *parent;
-	struct irq_domain *mc_msi_domain;
+	int ret =3D 0;
=20
 	for (np =3D of_find_matching_node(NULL, its_device_id); np;
 	     np =3D of_find_matching_node(np, its_device_id)) {
@@ -79,22 +102,10 @@ static int __init its_fsl_mc_msi_init(void)
 		if (!of_property_read_bool(np, "msi-controller"))
 			continue;
=20
-		parent =3D irq_find_matching_host(np, DOMAIN_BUS_NEXUS);
-		if (!parent || !msi_get_domain_info(parent)) {
-			pr_err("%pOF: unable to locate ITS domain\n", np);
-			continue;
-		}
-
-		mc_msi_domain =3D fsl_mc_msi_create_irq_domain(
-						 of_node_to_fwnode(np),
-						 &its_fsl_mc_msi_domain_info,
-						 parent);
-		if (!mc_msi_domain) {
-			pr_err("%pOF: unable to create fsl-mc domain\n", np);
-			continue;
-		}
-
-		pr_info("fsl-mc MSI: %pOF domain created\n", np);
+		ret =3D irq_domain_request_host(np, DOMAIN_BUS_NEXUS,
+					its_fsl_create_irq_domain, NULL);
+		if (ret)
+			pr_err("%pOF: unable to register ITS domain\n", np);
 	}
=20
 	return 0;
--=20
2.11.0

