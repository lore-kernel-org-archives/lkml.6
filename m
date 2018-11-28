Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E66BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06A8D206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="frkELlAF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06A8D206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729097AbeK2Bpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 20:45:35 -0500
Received: from mail-eopbgr790049.outbound.protection.outlook.com ([40.107.79.49]:37533
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728565AbeK2Bpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 20:45:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YlYB4LQjCe9nG5/ORED0SvHXl0itwPxkPPFjc465E+U=;
 b=frkELlAFKM88lE423vnJnU1EGi72ckukaIPajrxsvBg5fbR4/Y6UVqhJcUWsKTUWADCopGWa/SQMLLBaADXcplnh+wDQkjIVywwxXvsqNBNWNCW4Iv3QwbuXg+W92c2HwsvtNu55eYgX3DMUoXacpagAogGSGlmBAJImm2njxvM=
Received: from SN6PR07MB5326.namprd07.prod.outlook.com (52.135.105.33) by
 SN6PR07MB4399.namprd07.prod.outlook.com (52.135.91.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.18; Wed, 28 Nov 2018 14:43:37 +0000
Received: from SN6PR07MB5326.namprd07.prod.outlook.com
 ([fe80::ccc7:d111:7f3d:667d]) by SN6PR07MB5326.namprd07.prod.outlook.com
 ([fe80::ccc7:d111:7f3d:667d%4]) with mapi id 15.20.1361.018; Wed, 28 Nov 2018
 14:43:37 +0000
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
Subject: [PATCH v2 10/10] irqchip/gic-v3-its: Initialize MSIs with
 subsys_initcalls
Thread-Topic: [PATCH v2 10/10] irqchip/gic-v3-its: Initialize MSIs with
 subsys_initcalls
Thread-Index: AQHUhyi/VHkw8fQ4rEK/I3OXWgLFsQ==
Date:   Wed, 28 Nov 2018 14:43:37 +0000
Message-ID: <20181128144240.28727-11-rrichter@cavium.com>
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
x-microsoft-exchange-diagnostics: 1;SN6PR07MB4399;6:Ud14OQNqkNx7p88hYLIkNJn3V++mGhBQNeukiiPTA/U6E1KARENCYOoRNxyCbp0myauMzroDicbL1VLAXOrd/D63q3kJYHQhXXBuH8JbIrG6D9a69pdcRxVAr5paBLKvY7CBqnyxpaGalAhnyIinyYlAmkMVY/LwFAzVcn66/uOg1PKxrG1IptjLN8/XnffwaYtBp9KFRz/jGEVr/SSt5858Aseg2NBr5ue06emOy+GTRhViwepjz7XjmtJ8i7HZp/PZDjZA36Em76zGd47Ly2SG/npEWQyDhXaTNauUUIJ28zVTote5M1wZQTxMiGyJlV8hB1yY9UzC5pw2S9dYoyPStKyMPQGYyCkvUunGkCV9qWIXbnd3NqINwqA4JPqWizz+u6t5OnfyZY7yYQ3DQiNykTLHcn059BsA6lIRaZY8GIoj7l6+tWyapfGRMz5YpNzOyVgI24j9cTT98HxRqQ==;5:ZVuo/JWb7nlB5xgln1SBMrPI5I34IwCaG3FWTO0nm7NHjYQBTyaaycMZCesrQtiL8dxDZLvqfoiNmKWKWZqzt2KIjqP0dCNNOaOwD36IbeF6eFdnQjhMZRh313zJnjEAi/tx3pc92p5W56jgEKQzu0gG/ah85yGmCF52AtIf6Eo=;7:KhAxfenpa2zsZKjshVGoX4To8yvQ7vcUMpPVCsw9IZDjq1GMnMUliGShi229bS2DED6phmk2P7t9hTkjFHhQOo5kGn6zxRKYxrDJT48Ius9k++JZzZ/B5ecT2OM64CNu94YUe9Oapr6u9EzFjXn2gA==
x-ms-office365-filtering-correlation-id: b702a889-2a02-41c2-e982-08d6553fe18a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:SN6PR07MB4399;
x-ms-traffictypediagnostic: SN6PR07MB4399:
x-microsoft-antispam-prvs: <SN6PR07MB43993F2A0E5DF7C09F0111D7F1D10@SN6PR07MB4399.namprd07.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231443)(999002)(944501410)(52105112)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:SN6PR07MB4399;BCL:0;PCL:0;RULEID:;SRVR:SN6PR07MB4399;
x-forefront-prvs: 0870212862
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(366004)(39860400002)(136003)(199004)(189003)(97736004)(14444005)(256004)(105586002)(4326008)(106356001)(81156014)(8936002)(66066001)(2906002)(54906003)(110136005)(71190400001)(81166006)(6486002)(316002)(14454004)(8676002)(39060400002)(36756003)(76176011)(52116002)(68736007)(186003)(6116002)(7416002)(25786009)(71200400001)(53936002)(478600001)(99286004)(6512007)(446003)(11346002)(6436002)(26005)(305945005)(486006)(575784001)(7736002)(102836004)(72206003)(3846002)(2616005)(6506007)(5660300001)(386003)(476003)(1076002)(48284002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB4399;H:SN6PR07MB5326.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 15W3rr9wDrkw9azFn9zAcsFvXsX3te500vUhJRYOMlMYshMI/3OJ5Ihd7+pEZDuTWpezs2TBRhfiHfj59SaTqp7UWqBl9III9avWL8riedlGq+Owydft5st97PnjaOOHP3Yckr8iCLfVuSlJSStHmCMdz5I0o3tSYrjvne/NaL5VlMzV4m3TYE/IUhbjoxUti2SVlYYZjyXvIB7XuPsUcqJl84SA0Gk3DqWqnYaoa34c7R0SfFUzwIbMJ7W4/EPvguoC1RHGSENsV9JW3JatbQcSsGvwANdjpH15UaU52W/KYjhu6aaD3b2CIrouUxDkf8buNbmgNYHHaFwED1ZgO5MsL5hKUKhB21nNr7P7Qcc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b702a889-2a02-41c2-e982-08d6553fe18a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2018 14:43:37.7438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4399
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
index 81dfc534ded8..f6df5ea16aef 100644
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

