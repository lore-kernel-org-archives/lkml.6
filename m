Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC9F9C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1705206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="XNmmkBvb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1705206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbeK2BpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 20:45:09 -0500
Received: from mail-eopbgr820078.outbound.protection.outlook.com ([40.107.82.78]:43552
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728832AbeK2BpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 20:45:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dEqSRyxg+X7syJAyBlpOWnQo615RYOtMty1tKH1sdqQ=;
 b=XNmmkBvbAEYpLw/WfJ1l3rOTy00+0OLhGK5Vwf64f06bbWnRiBV7vVjvVzh+7AXTDMA+PrVg8hjOCsjbAUBJS/ROKFgQJn4ezBCWCrtzcP4mc40vY1nqtQYHOMDiN1+vaGKZL8OYredOdoQBR6wKwgZ7NydEY9SekEi5XNoZF4A=
Received: from SN6PR07MB5326.namprd07.prod.outlook.com (52.135.105.33) by
 SN6PR07MB5182.namprd07.prod.outlook.com (52.135.101.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.16; Wed, 28 Nov 2018 14:43:13 +0000
Received: from SN6PR07MB5326.namprd07.prod.outlook.com
 ([fe80::ccc7:d111:7f3d:667d]) by SN6PR07MB5326.namprd07.prod.outlook.com
 ([fe80::ccc7:d111:7f3d:667d%4]) with mapi id 15.20.1361.018; Wed, 28 Nov 2018
 14:43:12 +0000
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
Subject: [PATCH v2 03/10] irqchip/irq-gic-v3-its-pci-msi: Remove domain init
 order dependencies
Thread-Topic: [PATCH v2 03/10] irqchip/irq-gic-v3-its-pci-msi: Remove domain
 init order dependencies
Thread-Index: AQHUhyiwGzOi7c6W9ku3mSyUcOuuSg==
Date:   Wed, 28 Nov 2018 14:43:12 +0000
Message-ID: <20181128144240.28727-4-rrichter@cavium.com>
References: <20181128144240.28727-1-rrichter@cavium.com>
In-Reply-To: <20181128144240.28727-1-rrichter@cavium.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P194CA0042.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:209:84::19) To SN6PR07MB5326.namprd07.prod.outlook.com
 (2603:10b6:805:73::33)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [77.14.124.106]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR07MB5182;6:mz8j1i6f6buHO8ty//2s2vgVnCd5rfJsbv36x5DfZiXM6SYh1c6JyjT+BBZC1b2N9CM8tEwJnyW2aQyJesIL999VgAn8MOLvksWyrAgFEdlHmv3MzVba8Nocb4xSD1n9SfXck7HQNJxkMrE/ztqhFf/SuzWXYrq6dcMCrGj2JQWhgUMl45TSwigOLL7Nu7JO0XhZlNwD8NDkLUGseuOY14TRhT/Ccbx/BmC2Fj7LZ4obWY3w/5XgIyZanr2y8gM13Kz+Wgylad8vfIm6YOv5B+AGR16hX36zbcWaYc1CUDwWbL8OLSrAKz4XrqkG/L/VemZNskVcjz1l/qT+uLe8WCyYRD//vcLZJpzRk/No1OqAFcl2JTArp+Ms7I0tSjp7L/641AeN4k3eD/1BQspp3cXTf2gzM3cUyG0EX9E/9K1caHOo9gnCdmGiy1+0Wn725Qs91QNrVhbYEZbKeHKccg==;5:ca8k7rPCBWPRh0EO7m79U5/nhqd6MRgx60bdwkK67Ll7EOb9OyEdAbmvZPuUovhXlEtdiL085TK0IWa8V6VP9JbPlqZFRZp8DSfpZlneB2fUzW8TXy93Ot4bC+qok8BXT6eEbt2AacsxmWDyW2qLC7QqPWl1LA71VVsBWK8oOWQ=;7:6FYOfy/9sMoEDsg6kdMjk1sdC0R10R3AC1yvrap6CTf5p4eQeaI2yoT9B7U2Dq2N//g56WGEDd9A1Gr92sXB14nKzE/UASiaxEkoZzQIAhRYgaZo3uCL0RuVclyXWK1brQ9R3F/GMlO+xAGC1FEmXA==
x-ms-office365-filtering-correlation-id: c74032bc-a110-424e-d257-08d6553fd2ad
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:SN6PR07MB5182;
x-ms-traffictypediagnostic: SN6PR07MB5182:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Robert.Richter@cavium.com; 
x-microsoft-antispam-prvs: <SN6PR07MB518268C60FF4FBE16455CAA3F1D10@SN6PR07MB5182.namprd07.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231443)(999002)(944501410)(52105112)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:SN6PR07MB5182;BCL:0;PCL:0;RULEID:;SRVR:SN6PR07MB5182;
x-forefront-prvs: 0870212862
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(39860400002)(396003)(366004)(189003)(199004)(7416002)(5660300001)(6436002)(36756003)(54906003)(39060400002)(110136005)(446003)(11346002)(6116002)(3846002)(53936002)(97736004)(52116002)(76176011)(102836004)(4326008)(476003)(316002)(14454004)(2616005)(71190400001)(71200400001)(6512007)(1076002)(6506007)(7736002)(305945005)(486006)(81156014)(81166006)(386003)(72206003)(2906002)(99286004)(68736007)(8936002)(478600001)(106356001)(186003)(105586002)(6486002)(14444005)(66066001)(26005)(25786009)(256004)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB5182;H:SN6PR07MB5326.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: p63nP/zFaj7qrlp35Y9/e5SZcYi7Yurj0FP1Lkaw9nfj5csQuJs3Yy87xAcAU7SofC250QPS78VuXcXk5XsMcEkEM+eVdbiSEDurqAwljiunUv2ALsv1dU7mBt9KRs0Tozq+HNoPo+yL5m4IyYMdST3vfVmIBLPmUVBp9RWSUftkfsQ0LhOWyM4puLEQhHBtYdFBfKh1noHTAKwPsDuU+ILWBfH0HyWBiweM4bFUY7xv+swpmzce6wX/A9Khxx7i2oUknwVndIHTdHQN9G0RPP5THiSVDOL5qpGFf7lx1gfLZolrxWjQLmNrqNVQLpUMe64PqvWOgJKjOYG9TI6umtgmNn7OLeq4aUcwLTYG2wo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c74032bc-a110-424e-d257-08d6553fd2ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2018 14:43:12.8692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB5182
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

