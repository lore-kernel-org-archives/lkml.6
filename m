Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1BB2C46464
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 22:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CB8520862
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 22:03:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="edwCP7IL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CB8520862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbeKHHfm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 02:35:42 -0500
Received: from mail-eopbgr730050.outbound.protection.outlook.com ([40.107.73.50]:33907
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727127AbeKHHfl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 02:35:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dEqSRyxg+X7syJAyBlpOWnQo615RYOtMty1tKH1sdqQ=;
 b=edwCP7IL9OpxlAa6QsWdT+NFEEoQV2fD6XubH2x1KFv2psgoSwDte85tLp/yftlB/tpptvztwWFE+SWgp5jEO7oGdCCg2/xHZlYO13QmCU5aPVGVGnLh4xGfus9m+CVHJ9jD1kx7RaLTuya8vO7avnAQDVlzts/aqNSL+YIwTL4=
Received: from SN6PR07MB5326.namprd07.prod.outlook.com (52.135.105.33) by
 SN6PR07MB5232.namprd07.prod.outlook.com (52.135.120.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.22; Wed, 7 Nov 2018 22:03:18 +0000
Received: from SN6PR07MB5326.namprd07.prod.outlook.com
 ([fe80::f0b9:acf9:7513:c149]) by SN6PR07MB5326.namprd07.prod.outlook.com
 ([fe80::f0b9:acf9:7513:c149%5]) with mapi id 15.20.1294.034; Wed, 7 Nov 2018
 22:03:18 +0000
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
Subject: [PATCH 03/10] irqchip/irq-gic-v3-its-pci-msi: Remove domain init
 order dependencies
Thread-Topic: [PATCH 03/10] irqchip/irq-gic-v3-its-pci-msi: Remove domain init
 order dependencies
Thread-Index: AQHUduWwz70Juxgk6EWnduSjhzzlwQ==
Date:   Wed, 7 Nov 2018 22:03:18 +0000
Message-ID: <20181107220254.6116-4-rrichter@cavium.com>
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
x-microsoft-exchange-diagnostics: 1;SN6PR07MB5232;6:xJndUGydXmU1Yum4ZIibQ1Q0U5eD+tq3f0tWeJmUeCxcl7niWzfx4g/TNbP6bq27NXGvg0lPCZIDihgrkKeRGXWFwVlPqUXlQ7TWDbkN1JVJdwegq22G47JJAYKcqfScXvZ9j8SQs3ialn/QHyKzxJzWN5PoAyNT4UO0k3YGG44zmNMcwVgdtwGT8pHIlcpbBeZplaQnBBclIdausy6BYUA2BJ5ePIkb74HHq5Uwppdh/jV3D7fc311YLMFeGomm6CVoxXx0j7H77oI7mz8b7ObhDTdUdEZlvGUIUsLkS88QGrnX4BhzzXUUvVTYyrdhpyHNyf765PCYooBcJhl0fmr3eVzmXXlScTzXkImVozj4dpzcLbCaU+46SxY1y5xdIS3Rk3nwNt8R+PjlA5G8Ab+ndxs4xSRNZOtr5bYfaPWx//D6oDJ64UF741FzdKbKERpQ4e2DiTpymUqbdVrY7g==;5:V08LRANL3BHeu7hN1Le/3hIFTs3GXGigsu08YxUNKzaTkdtSt4zuFql2NkR5gZbiMf4LnLfN7l/bpJqFicl/vxZTwPGRShj7Qust/HYxh8hVikZGp2IC10M3wNfTU60cslfFeOlRIHvZJ25A/bZKr0hcXCGx90c72CMlvbsaD7U=;7:OGYLRqZtWAqaQQseDzfGZpW3WXGj6NDaJzpk9d+H5S+KExwWRA0LxGs6Y3eJM7ZSnNCWtO0dPG9muJR56lQxi/N5GWInhoohH8Jr3ElBcboIdMyir3HfZYArZDSy5tj+y9Sly0GqaFd1Z60dCx2bpQ==
x-ms-office365-filtering-correlation-id: a60ae2b5-4f78-4d26-a2ae-08d644fcd2d4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:SN6PR07MB5232;
x-ms-traffictypediagnostic: SN6PR07MB5232:
x-microsoft-antispam-prvs: <SN6PR07MB5232F9D03D2B4C6C56D2688BF1C40@SN6PR07MB5232.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(269456686620040);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231382)(944501410)(52105095)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:SN6PR07MB5232;BCL:0;PCL:0;RULEID:;SRVR:SN6PR07MB5232;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(39860400002)(346002)(396003)(376002)(189003)(199004)(71200400001)(7736002)(71190400001)(39060400002)(6486002)(3846002)(66066001)(6436002)(186003)(36756003)(476003)(478600001)(2616005)(53936002)(256004)(14444005)(446003)(305945005)(11346002)(6512007)(54906003)(1076002)(316002)(107886003)(25786009)(110136005)(6116002)(2906002)(97736004)(4326008)(6506007)(386003)(72206003)(105586002)(99286004)(486006)(5660300001)(7416002)(8936002)(102836004)(106356001)(68736007)(8676002)(14454004)(81156014)(76176011)(81166006)(2900100001)(52116002)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB5232;H:SN6PR07MB5326.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ZairD0bqm1gD0QhykaJ9qn22Rp9/6cB26aL02qBkZ5V9b7iJuyN7grNuxVF8TekZk95NhmiVYk8Pf4IvdD2BMZqWOLcE6CPQ04rXJhTqNt7lKd9PG+4nkDOvJjjVzRue1vTtCgrCvM4ZuFKHWD8sCbGSjvZ788SgulcQdU0Q9eVqyyWxFZXxZdnYRYFmsANIY6uKY+FdAZG680GaDQSGEPfcxMuw8E9/18QlHdCNFt9eCc6ulMtLl92g1+GokVgN48//WEA/mME2Y+E4JA6Vgxw8GHySzusseAIzfCxgkkneIakH5FW60A+71BloNgA61h2dVq+McP6VyByKiiqgEkLTxJrbHywoSnFGceQxDVs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a60ae2b5-4f78-4d26-a2ae-08d644fcd2d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 22:03:18.3344
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
 drivers/irqchip/irq-gic-v3-its-pci-msi.c | 66 ++++++++++++++++++----------=
----
 1 file changed, 38 insertions(+), 28 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its-pci-msi.c b/drivers/irqchip/irq=
-gic-v3-its-pci-msi.c
index 8d6d009d1d58..7d7366d55d34 100644
--- a/drivers/irqchip/irq-gic-v3-its-pci-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
@@ -116,27 +116,50 @@ static struct of_device_id its_device_id[] =3D {
 	{},
 };
=20
-static int __init its_pci_msi_init_one(struct fwnode_handle *handle,
-				       const char *name)
+static int __init its_pci_create_irq_domain(struct irq_domain *parent,
+					void *priv)
 {
-	struct irq_domain *parent;
+	char *name =3D priv;
+	int err =3D 0;
=20
-	parent =3D irq_find_matching_fwnode(handle, DOMAIN_BUS_NEXUS);
-	if (!parent || !msi_get_domain_info(parent)) {
-		pr_err("%s: Unable to locate ITS domain\n", name);
-		return -ENXIO;
+	if (!msi_get_domain_info(parent)) {
+		err =3D -ENODEV;
+		goto out;
 	}
=20
-	if (!pci_msi_create_irq_domain(handle, &its_pci_msi_domain_info,
+	if (!pci_msi_create_irq_domain(parent->fwnode, &its_pci_msi_domain_info,
 				       parent)) {
-		pr_err("%s: Unable to create PCI domain\n", name);
-		return -ENOMEM;
+		err =3D -ENOMEM;
+		goto out;
 	}
=20
-	return 0;
+	pr_info("PCI/MSI: %s domain created\n", name);
+out:
+	if (err)
+		pr_err("PCI/MSI: Failed to create %s domain: %d\n", name, err);
+
+	kfree(name);
+	return err;
+}
+
+static int __init its_pci_msi_init_one(struct fwnode_handle *handle,
+				       const char *name)
+{
+	void *priv =3D kstrdup(name, GFP_KERNEL);
+	int err;
+
+	err =3D irq_domain_request_fwnode(handle, DOMAIN_BUS_NEXUS,
+					its_pci_create_irq_domain, name, priv);
+	if (err) {
+		pr_err("PCI/MSI: Failed to register %s domain: %d\n",
+			name, err);
+		kfree(priv);
+	}
+
+	return err;
 }
=20
-static int __init its_pci_of_msi_init(void)
+static void __init its_pci_of_msi_init(void)
 {
 	struct device_node *np;
=20
@@ -147,13 +170,8 @@ static int __init its_pci_of_msi_init(void)
 		if (!of_property_read_bool(np, "msi-controller"))
 			continue;
=20
-		if (its_pci_msi_init_one(of_node_to_fwnode(np), np->full_name))
-			continue;
-
-		pr_info("PCI/MSI: %pOF domain created\n", np);
+		its_pci_msi_init_one(of_node_to_fwnode(np), np->full_name);
 	}
-
-	return 0;
 }
=20
 #ifdef CONFIG_ACPI
@@ -177,32 +195,24 @@ its_pci_msi_parse_madt(struct acpi_subtable_header *h=
eader,
 	}
=20
 	err =3D its_pci_msi_init_one(dom_handle, node_name);
-	if (!err)
-		pr_info("PCI/MSI: %s domain created\n", node_name);
-
 out:
 	kfree(node_name);
 	return err;
 }
=20
-static int __init its_pci_acpi_msi_init(void)
+static void __init its_pci_acpi_msi_init(void)
 {
 	acpi_table_parse_madt(ACPI_MADT_TYPE_GENERIC_TRANSLATOR,
 			      its_pci_msi_parse_madt, 0);
-	return 0;
 }
 #else
-static int __init its_pci_acpi_msi_init(void)
-{
-	return 0;
-}
+static void __init its_pci_acpi_msi_init(void) { }
 #endif
=20
 static int __init its_pci_msi_init(void)
 {
 	its_pci_of_msi_init();
 	its_pci_acpi_msi_init();
-
 	return 0;
 }
 early_initcall(its_pci_msi_init);
--=20
2.11.0

