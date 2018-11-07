Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C1C1C46464
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 22:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C81A320882
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 22:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="Fyend2PW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C81A320882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbeKHHgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 02:36:24 -0500
Received: from mail-eopbgr730083.outbound.protection.outlook.com ([40.107.73.83]:4145
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727127AbeKHHgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 02:36:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RxY00ErQKJ4xpBYOSdrd55Qxk0rjbsXTA/h9LTaUtgE=;
 b=Fyend2PWO6LFXydAxQ2vuvf+FzOrOzdeJBN+d1gHlglQKyi3HfrTGajsRf6GapZJiv5CyquUq5IT4Ql84IlM26vM+JA+npOcDPm9omF5e/pQalO1RFxZkpJrzjNkZ/Dee10Q/TXYDNnMztws6861TQYAW5GBTzMTDJ9ayS2gxUA=
Received: from SN6PR07MB5326.namprd07.prod.outlook.com (52.135.105.33) by
 SN6PR07MB5232.namprd07.prod.outlook.com (52.135.120.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.22; Wed, 7 Nov 2018 22:03:21 +0000
Received: from SN6PR07MB5326.namprd07.prod.outlook.com
 ([fe80::f0b9:acf9:7513:c149]) by SN6PR07MB5326.namprd07.prod.outlook.com
 ([fe80::f0b9:acf9:7513:c149%5]) with mapi id 15.20.1294.034; Wed, 7 Nov 2018
 22:03:21 +0000
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
        "Richter, Robert" <Robert.Richter@cavium.com>
Subject: [PATCH 04/10] irqchip/irq-gic-v3-its-fsl-mc-msi: Remove domain init
 order dependencies
Thread-Topic: [PATCH 04/10] irqchip/irq-gic-v3-its-fsl-mc-msi: Remove domain
 init order dependencies
Thread-Index: AQHUduWymEhPeOVkDkWPP01/DQYsAA==
Date:   Wed, 7 Nov 2018 22:03:21 +0000
Message-ID: <20181107220254.6116-5-rrichter@cavium.com>
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
x-microsoft-exchange-diagnostics: 1;SN6PR07MB5232;6:wFSW8HfanECKc5HLIPPee6iJ/WUR9CT6aL5AnQkGCSQdNvV090ZDUWewj3YeZ0njOkT+HS4eZffkQyHmQhnS/eSnl1eV0zevzIRTOX4h3bJZYZY/vzPheYRBWnAJvtEVS+aejSLYadLYj9HRgn0R+cDJKOeuuRAwukbYd8azx7pTSCWfe65Cg7w+7rlIqxfrzdKkkg4a2F5aC0iEColufGTUXydD4l/d/cpuU/wqY8ErT/Rb80dhEJ4liGtO67wMcbFkzBwz6uEOG4ClLYbsSsYbtmyYTUudP/eF66CcK53/7fIW9lYwQdNUCQiccKPIamuUiHR55ZYngOmq7WmhsuG5yso4rOnbL0eVMud/iuB9F2j1d3ckUFNcxB5yNbPqAZYapgQTFaf5eK5wJnMKE0GUcEWi2Cs86FwufOkLebV+mQqi/1xHiJpJbhcYN1H/Hd8faQCUHWFyLQAusRl0uA==;5:4wNOWLNuXdPkiyGD8fGtW5nqquj3WvBMnebM/C/W3gWyHndMI9c4lyjLQtkq15JKy9blWQYeiQdIFRlGDGLxL7Q6jaIOib893DY7m53w3SjcDB34oSph5wV/qwfQV4iIf11zzWCpktZNSMCbPV/KUN+/4aHyhy1vowJ02jeLeQY=;7:PgK/IAeUE09EyGmwIBL8XCZOPGgS442tsbST+xBjyAzAdf+r54ncuWONEIvZELmXQn4JmOIFKnijYvdtaobfevl3BolwJIeJ0ETSK9xl7bETHy1LkCUpXuDjv6ypDaniWB0bctXXihC91kjn4b1hzg==
x-ms-office365-filtering-correlation-id: bd3a7037-4484-4eb8-04e3-08d644fcd4c9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:SN6PR07MB5232;
x-ms-traffictypediagnostic: SN6PR07MB5232:
x-microsoft-antispam-prvs: <SN6PR07MB52328170C692FAFCE1D348ADF1C40@SN6PR07MB5232.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(269456686620040);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231382)(944501410)(52105095)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:SN6PR07MB5232;BCL:0;PCL:0;RULEID:;SRVR:SN6PR07MB5232;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(39860400002)(346002)(396003)(376002)(189003)(199004)(71200400001)(7736002)(71190400001)(39060400002)(6486002)(3846002)(66066001)(6436002)(186003)(36756003)(476003)(478600001)(2616005)(53936002)(256004)(14444005)(446003)(305945005)(11346002)(6512007)(54906003)(1076002)(316002)(107886003)(25786009)(110136005)(6116002)(2906002)(97736004)(4326008)(6506007)(386003)(72206003)(105586002)(99286004)(486006)(5660300001)(7416002)(8936002)(102836004)(106356001)(68736007)(8676002)(14454004)(81156014)(76176011)(81166006)(2900100001)(52116002)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB5232;H:SN6PR07MB5326.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: f7MaG4JQJsZUfwtsMygYeGKPmGdmLnerGNKPzGt05iV/0B9Phf1J8sKp9x2Q2gvbQ5D4Gjs8rbxmaVzZbTXdQfjVFX3Vkx07DitaJIKRh2eguYae0WkEFglKr9i+OfaXUdil3WZ1JDrnHRYIwxuRxH3SaFV4Uq3VQnInoXcdVfwrVYCGse5xuJTCVJdV+g43pHFAeNZwSMYLzGqAXT3vVX/UtxvOTnuzLKkhwYtL2dsxHyJySu3IQ9dXzwGHKPk32UNtNo4YiBN/MM10O+FEfJ1fHWXiipeVHNSG4vjGd3viA4dhRaD8DSwJZgUFVEW9apVMItF0yhp8fWOnnlA57nlGT7I4xAjSUK92B8fYLMs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd3a7037-4484-4eb8-04e3-08d644fcd4c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 22:03:21.4797
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
 drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c | 47 ++++++++++++++++++-------=
----
 1 file changed, 29 insertions(+), 18 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c b/drivers/irqchip/=
irq-gic-v3-its-fsl-mc-msi.c
index 606efa64adff..0e9b31f13618 100644
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
+						its_fsl_create_irq_domain, NULL);
+		if (ret)
+			pr_err("%pOF: unable to register ITS domain\n", np);
 	}
=20
 	return 0;
--=20
2.11.0

