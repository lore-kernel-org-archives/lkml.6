Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08AA0C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A988421473
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="ch5I9NfN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A988421473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbeK2Bpb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 20:45:31 -0500
Received: from mail-eopbgr790051.outbound.protection.outlook.com ([40.107.79.51]:31264
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728565AbeK2Bpa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 20:45:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=63O86WtqYE4lfiBL34hoKJ5lQTXr+NwWTlJyCQ0B74g=;
 b=ch5I9NfNI4Qp6EqHN3eu4WExmWnDSfLr7+Mm1m/ECUo+Z7MNtcrA/UA2JLkEy4JBrXnef0wXqo+AnJz5miXDoEUdqUzT51/8tBDt0wt2QHfPQNVUAjMZQVNkNkPX5+J5o4/W8SCYTMaELLmj5wZb+5GvFEVLMTu+/kUKgDOTL/g=
Received: from SN6PR07MB5326.namprd07.prod.outlook.com (52.135.105.33) by
 SN6PR07MB4399.namprd07.prod.outlook.com (52.135.91.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.18; Wed, 28 Nov 2018 14:43:34 +0000
Received: from SN6PR07MB5326.namprd07.prod.outlook.com
 ([fe80::ccc7:d111:7f3d:667d]) by SN6PR07MB5326.namprd07.prod.outlook.com
 ([fe80::ccc7:d111:7f3d:667d%4]) with mapi id 15.20.1361.018; Wed, 28 Nov 2018
 14:43:34 +0000
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
Subject: [PATCH v2 09/10] irqchip/gic-v3-its: Initialize its nodes later
Thread-Topic: [PATCH v2 09/10] irqchip/gic-v3-its: Initialize its nodes later
Thread-Index: AQHUhyi9TwLQwwjV3kulXsTCwl2DVQ==
Date:   Wed, 28 Nov 2018 14:43:34 +0000
Message-ID: <20181128144240.28727-10-rrichter@cavium.com>
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
x-microsoft-exchange-diagnostics: 1;SN6PR07MB4399;6:LEjV5XVjaLHgXXI7h/WpMFJYTIbQwyboHHQFvWN/0NqgxdgJ/VdFM8DZ3fiFJUqokRHOi9B5yj1PDyx74SYCjTgK5fbeg8ABTXEV/N7Jv44gkjW1czJVMtLQDa4uy1uQB0zYguD3vUbdI7KDDbSlgRIuI8vWLmS3Yi4IxYPpL37b8oa8p+vxAwurlFj+HOD1FH8gcM5ZWGz2WKxlYrXXBypF16hx/KnzkUoxMm4JkXVVbGsn8ld24O9rrI4IubHCgArcf4djupAVyc0aQWVIQskElNokaNaZE1e6kCpiSnFpRLjiaMw6LEKpY0GwEAxP0VjAgi9qnI83rxqthALV2I5MGjqLwSoUl5kBXAuK3WPHkpXKjxr6uGY/aCE/jWQp/m1DKi5xD/ciV17RfOMz/zseKzNcHGFtTe6BacHSPPaqZjbqpUPI4tFxJYRjq4fqEHrZW/rFVRkge+9bamFAeg==;5:s1Z9Jl9I63O9PmoERAMq8udJ3xZXMJ5f4ZgSNB4MUOC1y/yK8DJ0R2um48DbeVU4bWQG1HcBJjfMX6d0D+YSVDCOjCD8+HlL6nyDOnugN9ggBcSGzVPM2uvl7RkXgBdEULVD+zLe3rdqdfXrqNI077wIprtwCVL3U3rpIe3Lruc=;7:tYGW8zJUgcFzNjcz/G+JGF/VH5c6UyYI5FOxMF3nMBzFUBiz+UgXJt4OY8FzpVkymegD6ydjNW13FoFxFH++bITC9W3d2ZaWpWWJWy7tBPw/WxcpLiMUBcUp2jLkS5i9L15/6/fz+hvBKa1dPXvkpQ==
x-ms-office365-filtering-correlation-id: 37d52c40-3946-477e-3f8b-08d6553fdf77
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:SN6PR07MB4399;
x-ms-traffictypediagnostic: SN6PR07MB4399:
x-microsoft-antispam-prvs: <SN6PR07MB439957B0E51F50B29A585E23F1D10@SN6PR07MB4399.namprd07.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231443)(999002)(944501410)(52105112)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:SN6PR07MB4399;BCL:0;PCL:0;RULEID:;SRVR:SN6PR07MB4399;
x-forefront-prvs: 0870212862
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(366004)(39860400002)(136003)(199004)(189003)(97736004)(256004)(105586002)(4326008)(106356001)(81156014)(8936002)(66066001)(2906002)(54906003)(110136005)(71190400001)(81166006)(6486002)(316002)(14454004)(8676002)(39060400002)(36756003)(76176011)(52116002)(68736007)(186003)(6116002)(7416002)(25786009)(71200400001)(53936002)(478600001)(99286004)(6512007)(446003)(11346002)(6436002)(26005)(305945005)(486006)(7736002)(102836004)(72206003)(3846002)(2616005)(6506007)(5660300001)(386003)(476003)(1076002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB4399;H:SN6PR07MB5326.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: BfkcZ4HF3C1nxX9OgM6MjGORyeb462OfezeBAlfuGwAPZQ/IW2HkgSiqnGsTUrsAkK8xdkLRuXy4OOva2H/rsZmqCQAfqjK1x7thvkjRpDcDzJWCWS5dX34VKyfga6aCKEbMGnooPC+wLLYgmEZd0Zk6R6vLH6CZj3+aF5MXDQjaWrkW4Ry6aKCGfp0m93f7YDfX9mQlIEmICcCN1WUU8qbb6WsXhdgUrV9WShOAryQPwDkZ6LLI6g11rbbQOnhQ38QkB2kIchF0qjao6FnUeiCia1F/aZiCAdFnsSEvFG58t0rD+16UE2eqMFJsHstk3WoJ176G/dYfrEnaqtHC9YBpTPM7GPpJKkNe8KZ7njw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37d52c40-3946-477e-3f8b-08d6553fdf77
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2018 14:43:34.3219
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4399
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use an initcall to initialize its. This allows us to use the device
framework during initialization that is up at this point. We use
subsys_initcall() here since we need the arch to be initialized
first. It is before pci and platform device probe where devices are
bound to msi interrupts.

Signed-off-by: Robert Richter <rrichter@cavium.com>
---
 drivers/irqchip/irq-gic-v3-its.c   | 3 ++-
 drivers/irqchip/irq-gic-v3.c       | 4 ----
 include/linux/irqchip/arm-gic-v3.h | 1 -
 3 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-=
its.c
index fd8561fcfdf3..13cf56c66483 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -3920,7 +3920,7 @@ int __init its_probe(struct fwnode_handle *handle, st=
ruct rdists *rdists,
 	return 0;
 }
=20
-int __init its_init(void)
+static int __init its_init(void)
 {
 	struct its_node *its;
 	bool has_v4 =3D false;
@@ -3982,3 +3982,4 @@ int __init its_init(void)
=20
 	return 0;
 }
+subsys_initcall(its_init);
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index d2942efdb6d5..01538876ad15 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1323,8 +1323,6 @@ static int __init gic_of_init(struct device_node *nod=
e, struct device_node *pare
 	if (static_branch_likely(&supports_deactivate_key))
 		gic_of_setup_kvm_info(node);
=20
-	its_init();
-
 	return 0;
=20
 out_unmap_rdist:
@@ -1628,8 +1626,6 @@ gic_acpi_init(struct acpi_subtable_header *header, co=
nst unsigned long end)
 	if (static_branch_likely(&supports_deactivate_key))
 		gic_acpi_setup_kvm_info();
=20
-	its_init();
-
 	return 0;
=20
 out_fwhandle_free:
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm=
-gic-v3.h
index f4348fa4260a..885d5a4e239a 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -604,7 +604,6 @@ struct irq_domain;
 struct fwnode_handle;
 int its_probe(struct fwnode_handle *handle, struct rdists *rdists,
 	      struct irq_domain *domain);
-int its_init(void);
 int mbi_init(struct fwnode_handle *fwnode, struct irq_domain *parent);
=20
 static inline bool gic_enable_sre(void)
--=20
2.11.0

