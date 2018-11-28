Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1AB6C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84835206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="Kl7Zi4NR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84835206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbeK2BpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 20:45:07 -0500
Received: from mail-eopbgr800078.outbound.protection.outlook.com ([40.107.80.78]:26739
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728766AbeK2BpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 20:45:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WVJPuN4UrdNuubbuIz76x9ByAl3G3stZh22pOcKjrkg=;
 b=Kl7Zi4NRSUfDJA37B7EML5v50F/c1pNiifgiZeq3zjI1H4eH74JLOd82a9jSS+S2pVFNZZb6yk1iGEtVk0u293xs06jQsel8N1sDpy1xyCCOvI21MOrfFHKB6YcWsGEIxTl5JKPm7QPFV1IYXVsm59Ilf2etpYj5FRW1SqxN4Mg=
Received: from SN6PR07MB5326.namprd07.prod.outlook.com (52.135.105.33) by
 SN6PR07MB5182.namprd07.prod.outlook.com (52.135.101.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.16; Wed, 28 Nov 2018 14:43:09 +0000
Received: from SN6PR07MB5326.namprd07.prod.outlook.com
 ([fe80::ccc7:d111:7f3d:667d]) by SN6PR07MB5326.namprd07.prod.outlook.com
 ([fe80::ccc7:d111:7f3d:667d%4]) with mapi id 15.20.1361.018; Wed, 28 Nov 2018
 14:43:09 +0000
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
Subject: [PATCH v2 02/10] irqchip/gic-v3-its-platform-msi: Remove domain init
 order dependencies
Thread-Topic: [PATCH v2 02/10] irqchip/gic-v3-its-platform-msi: Remove domain
 init order dependencies
Thread-Index: AQHUhyiuiJ/5aLda5UGC92pCn/0y1A==
Date:   Wed, 28 Nov 2018 14:43:09 +0000
Message-ID: <20181128144240.28727-3-rrichter@cavium.com>
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
x-microsoft-exchange-diagnostics: 1;SN6PR07MB5182;6:CD+F/Z8LrRHmDQEZppQv6HfugA0KR45x9OdwDk7+8mXqnGT9jqKBbyTf8eKR8GXkXGyZ6kc7T3WQRLmKrWWMtd23dJcd5nnnOwdJRz+4eEG+8jb5NZPT/WY/GPtJUn48CHKIANuRnBGFvAZO6iUKvG/Vn46xRo3nnb2OECpBi1ielOl5670gAHPKNRpmPGZJvKHrkiUrqj2Meip9Gebh8a+g0y4tFHYRl11QxwK3Vjj1zGTNH4NhKw7PBeXBA2deD/Ik9SpOsWmJsLBhTZ6JAYm7gfPh0X2tlINtwdPWsOkGIkdXg7Jnlz5zI0XRPPByYZSrW0ytli9DwheCblxKesge7HWlPcyGrV+kYRGHDyKGV28dEeM8XvBq7wkC3cL95DyS5e1+yaTV4TnYZF/xPXfcWdlfhcf+CNTpIH1YkKI2mSdZZOTORca2NSptna6pKjI+5WcN0qhawyVmsMb+Zw==;5:0RSWt+c9+qsY2WpBrJ8H+29eMJ1hP7dGTTeI2u36UGH6PUostgxYoSYwgGmmhZsU4fzvwpRqVcGe78Hj8MODsAmMaO8Qg5zz3XtbIFLYVsVDyH/V9cq4hYB9QAkRboVgkwHRPBw0uqRqqmfl+gB24guAd2EXGM/AwhDzjEK+AxQ=;7:5Hxyu+R/XOBKISdHjk0tQsHtBCXkmAHWLUx3ijdDvk3nPRaKfPTO60Ht0y3X9veJH6T2HVQZUziPZT0IpbisWuyyLvS7A+rYK6TNWacAJTuVx7I6IGAcMRjtheoa88C6GB6ethOEiiXDr3D7ICwrBw==
x-ms-office365-filtering-correlation-id: dc754748-4c3b-4590-d803-08d6553fd0c9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:SN6PR07MB5182;
x-ms-traffictypediagnostic: SN6PR07MB5182:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Robert.Richter@cavium.com; 
x-microsoft-antispam-prvs: <SN6PR07MB518201B3CD0CD8C8148C349CF1D10@SN6PR07MB5182.namprd07.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231443)(999002)(944501410)(52105112)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:SN6PR07MB5182;BCL:0;PCL:0;RULEID:;SRVR:SN6PR07MB5182;
x-forefront-prvs: 0870212862
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(39860400002)(396003)(366004)(189003)(199004)(7416002)(5660300001)(6436002)(36756003)(54906003)(39060400002)(110136005)(446003)(11346002)(6116002)(3846002)(53936002)(97736004)(52116002)(76176011)(102836004)(4326008)(476003)(316002)(14454004)(2616005)(71190400001)(71200400001)(6512007)(1076002)(6506007)(7736002)(305945005)(486006)(81156014)(81166006)(386003)(72206003)(2906002)(99286004)(68736007)(8936002)(478600001)(106356001)(186003)(105586002)(6486002)(14444005)(66066001)(26005)(25786009)(256004)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB5182;H:SN6PR07MB5326.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: imD33EJ4JFbwtSgj5tbRMCsT8UrP/UprFNF42UT88YCrxe7DW6Mqw66xPZzkTYmGaw6yooYS9uZxfkYhC0hJK4qEewVo32LEE9pnXOHvo4IBDY+uWI2/p4PhR3aofw+98Yt43hJSZ1qhRCRou5z7T0oRhS/G7YG0InnhV8Ck0wE2ecoasNYanqKTDZ2QCLX1ESJK/1pgmJbV8YPUMWMknGnfpfzMC2mp6slrwRLpHHsXgBGb3fwUQTag3b58so5TSchCRdxjlsIgUvGuVr1S9vwNYwdNp8ZfbL3KDkJCQ9486R88pUX3UsKXQ9xfLQsabKioe1q7cX6FUZbOLAp5eqJKZ3nfLUQKaA815wJJdXg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc754748-4c3b-4590-d803-08d6553fd0c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2018 14:43:09.7130
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
 drivers/irqchip/irq-gic-v3-its-platform-msi.c | 54 +++++++++++++++++++++--=
----
 1 file changed, 42 insertions(+), 12 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its-platform-msi.c b/drivers/irqchi=
p/irq-gic-v3-its-platform-msi.c
index 7b8e87b493fe..1f2849bc58c4 100644
--- a/drivers/irqchip/irq-gic-v3-its-platform-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-platform-msi.c
@@ -94,25 +94,56 @@ static const struct of_device_id its_device_id[] =3D {
 	{},
 };
=20
-static int __init its_pmsi_init_one(struct fwnode_handle *fwnode,
-				const char *name)
+static int __init its_pmsi_create_irq_domain(struct irq_domain *parent,
+					void *priv)
 {
-	struct irq_domain *parent;
+	const char *name =3D priv;
+	int err =3D 0;
=20
-	parent =3D irq_find_matching_fwnode(fwnode, DOMAIN_BUS_NEXUS);
-	if (!parent || !msi_get_domain_info(parent)) {
-		pr_err("%s: unable to locate ITS domain\n", name);
-		return -ENXIO;
+	if (!msi_get_domain_info(parent)) {
+		err =3D -ENODEV;
+		goto out;
 	}
=20
-	if (!platform_msi_create_irq_domain(fwnode, &its_pmsi_domain_info,
+	if (!platform_msi_create_irq_domain(parent->fwnode, &its_pmsi_domain_info=
,
 					    parent)) {
-		pr_err("%s: unable to create platform domain\n", name);
-		return -ENXIO;
+		err =3D -ENXIO;
+		goto out;
 	}
=20
 	pr_info("Platform MSI: %s domain created\n", name);
-	return 0;
+out:
+	if (err)
+		pr_err("Platform MSI: Failed to create %s domain\n", name);
+
+	kfree(name);
+	return err;
+}
+
+static int __init its_pmsi_init_one(struct fwnode_handle *fwnode,
+				const char *name)
+{
+	void *priv =3D kstrdup(name, GFP_KERNEL);
+	int err;
+
+	if (!name) {
+		err =3D -EINVAL;
+		goto fail;
+	}
+
+	if (!priv) {
+		err =3D -ENOMEM;
+		goto fail;
+	}
+
+	err =3D irq_domain_request_fwnode(fwnode, DOMAIN_BUS_NEXUS,
+					its_pmsi_create_irq_domain, name, priv);
+	if (!err)
+		return 0;
+fail:
+	pr_err("Platform MSI: Failed to register %s domain\n", name);
+	kfree(priv);
+	return err;
 }
=20
 #ifdef CONFIG_ACPI
@@ -135,7 +166,6 @@ its_pmsi_parse_madt(struct acpi_subtable_header *header=
,
 	}
=20
 	err =3D its_pmsi_init_one(domain_handle, node_name);
-
 out:
 	kfree(node_name);
 	return err;
--=20
2.11.0

