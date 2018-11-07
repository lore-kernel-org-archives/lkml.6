Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A369EC46464
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 22:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C92520862
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 22:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="R+hfw3+y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C92520862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbeKHHgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 02:36:35 -0500
Received: from mail-eopbgr730056.outbound.protection.outlook.com ([40.107.73.56]:17664
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728056AbeKHHg3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 02:36:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SDuDUaJXIBkDhEMjnXeu92GzrTHmkYt7IHsgl3ZQBzk=;
 b=R+hfw3+yNjBvYeTXdNFEmIo1rubI02xNO1k9HIuRxMWW8j4d7Y6mDO3yxks+AFJlfDIVbUT1nORU1O2WugdykqoLo5WiVjLZlOPwAvgz2VnqBYuAMEPfGDR9+thWyXU39UtMjfgWMpGgpuwLQy777WLFgyFoxtVt0xysCxM1+nE=
Received: from SN6PR07MB5326.namprd07.prod.outlook.com (52.135.105.33) by
 SN6PR07MB5232.namprd07.prod.outlook.com (52.135.120.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.22; Wed, 7 Nov 2018 22:03:43 +0000
Received: from SN6PR07MB5326.namprd07.prod.outlook.com
 ([fe80::f0b9:acf9:7513:c149]) by SN6PR07MB5326.namprd07.prod.outlook.com
 ([fe80::f0b9:acf9:7513:c149%5]) with mapi id 15.20.1294.034; Wed, 7 Nov 2018
 22:03:43 +0000
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
Subject: [PATCH 10/10] irqchip/gic-v3-its: Initialize MSIs with
 subsys_initcalls
Thread-Topic: [PATCH 10/10] irqchip/gic-v3-its: Initialize MSIs with
 subsys_initcalls
Thread-Index: AQHUduW/5AZAzs1nm0y385/013eVbg==
Date:   Wed, 7 Nov 2018 22:03:42 +0000
Message-ID: <20181107220254.6116-11-rrichter@cavium.com>
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
x-microsoft-exchange-diagnostics: 1;SN6PR07MB5232;6:2IqIAbNxz7VogIM1NxuGMz675CCTuNPCz2yGlAnvZBmxdFGIImtgopl/xavtsbaS4YbjXU7FVrbOH9SKP6hxkfImx5Wo9hkr/9/QWWxMGaqyCzt3TvRruC3iCiocrsDEQVFHhoCHzDjb+Qv/T7vO8teymZDThJNblwgc7MWi0dhTFgSs2iVoLfFoeqg3H+vntfkGSqMvQMaCCkla3k23NTU9zVo2VQF7dTFOFQvDJvatHZcCUjcxDaM65TvkkHby6cG+LLlOBHM5hgwoY3EuzaOUO87ChefA2exO7O+IUeFNs5CcIBWthVwuqKto3Ld/xRrl0RilojGGFmPurCtGjIX1cdWm4wAJBdrRAM5X5BTY7sljY42xUU0DvFfCzMidt4SleZQUmIH/XIA1UXzEQcOuA2LLA8z+CByEhatWePynMdyxD4YA+06TM4I4jHrE1n4Mtf/VpMNvuN5FJUU0TA==;5:f0rNUN+uwi8TnDuG1b3gJrPW/zBjHvUvPZ0sJvVMVe2mmPOCWbEfUU+O3X+8Z+rZtUkdhnq6dZy1gh4lZ3NyPhD7bpxEplgyK82bLG4v0dGK0SzSnubYMXdbZVqtn+/HozwH2BufhpCPfn3yCApowWMrUfkMHW8nLwPyjjIMmUI=;7:iIDvmxSeDZk4gsqLbym9GhLyENQV811rZTyH16pioZH4cfety8awfuub3XHRwMBUcasAmNHp8azYfjsZawnFVNKNJh0kHPdrTrXGJf3QllOo/AI5+Qgzr7aMu0K8RbzEBKhUbuXrG3gqWY3yOLVRNQ==
x-ms-office365-filtering-correlation-id: 157f63f4-b375-451e-8fbc-08d644fce195
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:SN6PR07MB5232;
x-ms-traffictypediagnostic: SN6PR07MB5232:
x-microsoft-antispam-prvs: <SN6PR07MB5232BE7E4196FF8A005BB38CF1C40@SN6PR07MB5232.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231382)(944501410)(52105095)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:SN6PR07MB5232;BCL:0;PCL:0;RULEID:;SRVR:SN6PR07MB5232;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(39860400002)(346002)(396003)(376002)(189003)(199004)(71200400001)(7736002)(71190400001)(39060400002)(6486002)(3846002)(66066001)(6436002)(186003)(36756003)(476003)(478600001)(2616005)(53936002)(256004)(14444005)(446003)(305945005)(11346002)(6512007)(54906003)(1076002)(316002)(107886003)(25786009)(110136005)(6116002)(2906002)(97736004)(4326008)(6506007)(386003)(72206003)(105586002)(99286004)(486006)(5660300001)(7416002)(8936002)(102836004)(106356001)(68736007)(8676002)(14454004)(81156014)(76176011)(81166006)(575784001)(2900100001)(52116002)(26005)(48284002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB5232;H:SN6PR07MB5326.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 5ZOJOUQ4DvXdPhObawpzKun6uCls3wABbhkrs3JTxUkbrXs29WhfO8vAcfNGZn7LGbj0BybBbXz+gpFn2YuHWSbqS3lf7J2Y7wVXKMPW5YaKfMM8RP1v1SSc9qLGcN7l7mOgqYeR674Iv3fOeSjTGbla4FuOqW5oUMB7DaXCtSs+mwkjMVJptYkS5iLrFqY8JtWB0JnHo74POQvO0raBYhfAJ/juMPYjAjw2qWQt5DUTKGxGzr0s4koAXMo/pr09TyCW+W4wa6wjggxfT/OLcbyNSrN50yzTTFid4I/INgsoXqGMRtRbmdWpHtUZphBwyFJsQdIw9/pHQWV4RkNDxV7Wl0CcGmuCKaevA/4vA7s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 157f63f4-b375-451e-8fbc-08d644fce195
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 22:03:42.9788
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB5232
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since ITS is initialized with with the subsys_initcall now, we don't
need to enable ITS children earlier. Due to the use of irq_domain_
request_host_*() there are no order dependencies when initializing irq
domains.

Signed-off-by: Robert Richter <rrichter@cavium.com>
---
 drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c   | 2 +-
 drivers/irqchip/irq-gic-v3-its-pci-msi.c      | 2 +-
 drivers/irqchip/irq-gic-v3-its-platform-msi.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c b/drivers/irqchip/=
irq-gic-v3-its-fsl-mc-msi.c
index 0e9b31f13618..74d63fdff411 100644
--- a/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c
@@ -111,4 +111,4 @@ static int __init its_fsl_mc_msi_init(void)
 	return 0;
 }
=20
-early_initcall(its_fsl_mc_msi_init);
+subsys_initcall(its_fsl_mc_msi_init);
diff --git a/drivers/irqchip/irq-gic-v3-its-pci-msi.c b/drivers/irqchip/irq=
-gic-v3-its-pci-msi.c
index 7d7366d55d34..9c4a0ebdab0b 100644
--- a/drivers/irqchip/irq-gic-v3-its-pci-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
@@ -215,4 +215,4 @@ static int __init its_pci_msi_init(void)
 	its_pci_acpi_msi_init();
 	return 0;
 }
-early_initcall(its_pci_msi_init);
+subsys_initcall(its_pci_msi_init);
diff --git a/drivers/irqchip/irq-gic-v3-its-platform-msi.c b/drivers/irqchi=
p/irq-gic-v3-its-platform-msi.c
index 1f2849bc58c4..76f8a2e85375 100644
--- a/drivers/irqchip/irq-gic-v3-its-platform-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-platform-msi.c
@@ -201,4 +201,4 @@ static int __init its_pmsi_init(void)
 	its_pmsi_acpi_init();
 	return 0;
 }
-early_initcall(its_pmsi_init);
+subsys_initcall(its_pmsi_init);
--=20
2.11.0

