Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 112A7C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 22:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C17AA21019
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 22:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="Ay9Ietxh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C17AA21019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbeKHHgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 02:36:16 -0500
Received: from mail-eopbgr730056.outbound.protection.outlook.com ([40.107.73.56]:17664
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727945AbeKHHgP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 02:36:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=63O86WtqYE4lfiBL34hoKJ5lQTXr+NwWTlJyCQ0B74g=;
 b=Ay9IetxhVLAOYiSsf9xRrWxuxzj5IlPoq6vpB7tAYgooCa/0NKZvdEbpR8ZO6w43H3fXP98FuZ1D2F7AHwyShWaNY8q7vcrfEd27g/FhMJfY2P9Mv9aTch8spKqlzIzqK9ZQYHji3qhCrSzL4bIhH7fyK7XTTvwHSFoHtK9zdNE=
Received: from SN6PR07MB5326.namprd07.prod.outlook.com (52.135.105.33) by
 SN6PR07MB5232.namprd07.prod.outlook.com (52.135.120.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.22; Wed, 7 Nov 2018 22:03:39 +0000
Received: from SN6PR07MB5326.namprd07.prod.outlook.com
 ([fe80::f0b9:acf9:7513:c149]) by SN6PR07MB5326.namprd07.prod.outlook.com
 ([fe80::f0b9:acf9:7513:c149%5]) with mapi id 15.20.1294.034; Wed, 7 Nov 2018
 22:03:39 +0000
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
Subject: [PATCH 09/10] irqchip/gic-v3-its: Initialize its nodes later
Thread-Topic: [PATCH 09/10] irqchip/gic-v3-its: Initialize its nodes later
Thread-Index: AQHUduW9H28TYQeuq0q3ZPDCnEjlYA==
Date:   Wed, 7 Nov 2018 22:03:39 +0000
Message-ID: <20181107220254.6116-10-rrichter@cavium.com>
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
x-microsoft-exchange-diagnostics: 1;SN6PR07MB5232;6:9zlO7XmWud2q5ElCgSTc6H7QS8QdKOvz+uGCp77+G5Moainp3GRPr8nGi+lXq/ri8euXahRqv2YQSZ6Zu5jm9yB6jYlsRhMouebfgd7en/e0SPOZBkKByYWEuwDO+PAlnUXvnUoXTWBudaP7bhCR5UVG6ASosTsZwkMtBKFQN1hRFjoeaOVadx+f4n+qyowMSm96S8lbZrknMdCYHms9X3ftVXXISVDpmNUzEV8GExMEjUahlNy0/AdHnGaQHwYBxwcXJHlTDDxJ+EP+gG5+iEK3HVKCsmf0KhTvYIDIsMiGjc1il13I4+fNh4CAba5lT/9anlP4P01sDlmsTzrJ1H/E4NksA3grgB+s0w0fMzQ2qqI2KJzrXzOdBgjDBYkp/8ZwpmEBlVWi4ljis0Ad1eNJUfgZCSeilFaQBJpESyEtemqm9EXa4osQ4yOITTTCVz1CM78IYIVlPDmReAexrA==;5:DqPYdv7jcxdsbzjQAVph0LeyxPcyRcJqaHp8KcfyKl/IDU7O6u95yJdEw8cRqeHuselJUQQ7/GumFqtWU6PEP3qgTCJq6F/Vr359kovEVjrNxJWvb6115luwmXvwLC7AKFcRf8Y9Ph8TxNO8lJCQccU9OmdlU0Z43p9At1ZncrQ=;7:HfPdnLNqGqtpXIstLU/zBHk7O9NjIBMJ5Jb9+f5b0r20Q+0BGnTtuh+p2W4jCId7AEO26zhLKCnx5kW5gdBGeJnGqt6ntUpsuuV+Abv0Q2XOrQwWXkOJ1KBRTQsrUQ/AHUiS8YVo58KfJa+pjtdfFw==
x-ms-office365-filtering-correlation-id: cf6f5872-ad7c-442c-2299-08d644fcdf55
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:SN6PR07MB5232;
x-ms-traffictypediagnostic: SN6PR07MB5232:
x-microsoft-antispam-prvs: <SN6PR07MB5232110758F906D6D1A55E48F1C40@SN6PR07MB5232.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231382)(944501410)(52105095)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:SN6PR07MB5232;BCL:0;PCL:0;RULEID:;SRVR:SN6PR07MB5232;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(39860400002)(346002)(396003)(376002)(189003)(199004)(71200400001)(7736002)(71190400001)(39060400002)(6486002)(3846002)(66066001)(6436002)(186003)(36756003)(476003)(478600001)(2616005)(53936002)(256004)(446003)(305945005)(11346002)(6512007)(54906003)(1076002)(316002)(107886003)(25786009)(110136005)(6116002)(2906002)(97736004)(4326008)(6506007)(386003)(72206003)(105586002)(99286004)(486006)(5660300001)(7416002)(8936002)(102836004)(106356001)(68736007)(8676002)(14454004)(81156014)(76176011)(81166006)(2900100001)(52116002)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB5232;H:SN6PR07MB5326.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: xDtJIv0UvoPpExeWnibemLaKr2Z27KZbicYjlqJq1VzrSfjiU2DPUHvz2h1blSKXUxJNjlq208DIXyziSwLoVPyo89doChO2PiTHhHBmZXK2yi7N02mLmfYKDRmLmXIijmpAF0jp41XP5hWkTbZhSL2aexjkXq+QT85Fn1X/nypS8N0JUEWqyRG/ivK6BFaXwuGwuqiTtj/UFbl8MrFi2m75xJy0IsFUPuvH48sTSE4Ph0Osf7m1lcN7bVMcB0FmTkA5qKCCdZDEFhIYY084KarXMMw08w08CkA4E9pwQi1NWM0QUtycWoEZNhBP+ukMNVqavsFF8kokY/iDydfl4qZFEcT7LIntmig1AkKZlHA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf6f5872-ad7c-442c-2299-08d644fcdf55
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 22:03:39.4784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB5232
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

