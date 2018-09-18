Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7625FC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 22:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF08120C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 22:29:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="olzPr8uc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF08120C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbeISEEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 00:04:40 -0400
Received: from mail-sg2apc01on0110.outbound.protection.outlook.com ([104.47.125.110]:34624
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725821AbeISEEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 00:04:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gHF2EHJfwHgzAtPAe4NueVTLfVaFKunjK7AEgE/yfSo=;
 b=olzPr8ucPSEv7lfY3CaY6lb1xco5Dh41NosKoVkliL3C8NaaQjZblYyWUcTVSbJGcawx+OMdGwk2oZcAf+uiqAWO/+BoHt1KmYiDLBiGn8i8m/vwdiIxy3/mrmz9MvWkNPbGL9wXIL+Cx5RlERIRFY/jn9xXXIbeJJy5OhFROg0=
Received: from KU1P153MB0166.APCP153.PROD.OUTLOOK.COM (10.170.173.13) by
 KU1P153MB0102.APCP153.PROD.OUTLOOK.COM (10.170.172.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.6; Tue, 18 Sep 2018 22:29:51 +0000
Received: from KU1P153MB0166.APCP153.PROD.OUTLOOK.COM
 ([fe80::31e7:25af:c162:2b94]) by KU1P153MB0166.APCP153.PROD.OUTLOOK.COM
 ([fe80::31e7:25af:c162:2b94%3]) with mapi id 15.20.1185.006; Tue, 18 Sep 2018
 22:29:51 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'olaf@aepfle.de'" <olaf@aepfle.de>,
        "'apw@canonical.com'" <apw@canonical.com>,
        "'jasowang@redhat.com'" <jasowang@redhat.com>,
        vkuznets <vkuznets@redhat.com>,
        "'marcelo.cerri@canonical.com'" <marcelo.cerri@canonical.com>,
        Josh Poulson <jopoulso@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
Subject: [PATCH] x86/hyperv: suppress "PCI: Fatal: No config space access
 function found"
Thread-Topic: [PATCH] x86/hyperv: suppress "PCI: Fatal: No config space access
 function found"
Thread-Index: AdRPnqLjk5RKpcSXRi2tGnIAPJn6lQ==
Date:   Tue, 18 Sep 2018 22:29:50 +0000
Message-ID: <KU1P153MB0166D977DC930996C4BF538ABF1D0@KU1P153MB0166.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-09-18T22:29:47.8378282Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2001:4898:80e8:9:85b5:4343:2aff:c693]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;KU1P153MB0102;6:JOFEa/or7xYOSfCLaad0/uxhSJ1ozCgZQkE7UQr4R/m4mR7dW0IFjrhlTtW/0leEyxe1eTyATebdO5ntksNvzIKr6nLl8NrIv1Q1MJAC4iw7aP+Ht5yHIiXIR806lKCKRC1j6QZDWDrP1C1HfwRW2sWsqjwYF/CvkYs+NvjeK90ENrBhuT1jcPBE8S/s8QdqA4MyNVs8y1WML1HLziN9jL1ivuw+FkRXFWKqlUIYgs6Krg2nJ6akEzOteDMFDzSdC0198aU4l6GGd+1h4oWzlvQTJLbtBg2gDmKKGyE38i4ZNDlLn2ujv65/Gjs7DdR1n/hR1fmaAmAolNMtm/3cumZUYD9uJyCdHfwjLdTeYFJoA6BpTVuni6iDMXdzKlbsG6mTueAkdF2Bb6M9nH8RaOSixUR0PF08unhtwd4uoX7kIdNa8QiHFvpaKvAuX35OCIK8qoQbeQvr01MrHS+NsA==;5:WhMPb0BOVhS2n1H253qVhfbY9VNn8nLN0R0V3ZWG5WrLTpnxOSOboQ1hc1Z1RkG5KLRacsHpUbFaf9xoVIPZLuh9qYQ61l1ZX6HdymMees+gHf43YxoEHpaoFIs1sZY/zYvnLPN1h34twh5Sxm4XNPHf3qefIe/UvFVq8W66dYQ=;7:sZNhvHnFTYRR/2UeFvQWsKJBW9ZlkdKgF5t+GGuyyUWfOTiSuy9pCIik4NdeYB4ZgLTeA/iycAURWYmpP3nb01hUqpgAmq7gtb0W5DMMtvjDfum6HzsSpjixJq6iGe6vu7ATVOfU3XhWIMBKfj/kie/QPmno/Do/+hBnEGgT2VR+2nO6B5Zwj6ErsEnvTjrYdAHebT0RyDkDXK9p+uoNiqJr7r0LwgPpT5McP0aM/O0xboHSAne/r33pOtfZFfwp
x-ms-office365-filtering-correlation-id: 0aa77132-5f9d-43ee-3317-08d61db63fbe
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:KU1P153MB0102;
x-ms-traffictypediagnostic: KU1P153MB0102:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <KU1P153MB010211DFBE15F7BEF079646ABF1D0@KU1P153MB0102.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699050);SRVR:KU1P153MB0102;BCL:0;PCL:0;RULEID:;SRVR:KU1P153MB0102;
x-forefront-prvs: 0799B1B2D7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(376002)(136003)(346002)(396003)(199004)(189003)(55016002)(9686003)(10290500003)(6436002)(53936002)(2906002)(86612001)(256004)(14444005)(2501003)(110136005)(86362001)(22452003)(54906003)(316002)(5250100002)(2900100001)(97736004)(33656002)(105586002)(106356001)(1511001)(478600001)(1857600001)(6506007)(102836004)(14454004)(8990500004)(186003)(81156014)(4326008)(81166006)(8676002)(68736007)(107886003)(8936002)(25786009)(305945005)(10090500001)(46003)(6116002)(5660300001)(74316002)(99286004)(7416002)(7696005)(486006)(476003)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:KU1P153MB0102;H:KU1P153MB0166.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: h7ghB5NsQKAGrBJmwUqYh49FuLveRy7rp9WmLpr7JR9l+Qo/DXfRrgEvhTLWdJ5JTF6vT6plH4csN5WdNRfP37pyTKakPJPbLYxFErbq3QOFLvnpb3l8puJJJ+aEE2b4gStWG5zjCuwTkoGEGxjRon4On5E4yl8rR4x1VIWl83/YbMnd8+ViR+/QRFiokWSL20EifImwLJ/plgArn5NTdDU2dkOtq1PTzs/swB5RXl2BiPnuOtBUU/qFMaXu+iX8+CSpSHVixxhksiDIYvyyMlA9ERWzqH7DACA1U1ORkNUF9Tnr7OIhw33LLBIu4AXs6YtmZ5kMle+hyW1Y1KKpWy6ZYC3nMhbQWfhbvbRE5Lc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aa77132-5f9d-43ee-3317-08d61db63fbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2018 22:29:50.4392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU1P153MB0102
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


A Generatin-2 Linux VM on Hyper-V doesn't have the legacy PCI bus, and
users always see the scary warning, which is actually harmless. The patch
is made to suppress the warning.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Cc: K. Y. Srinivasan <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
---
 arch/x86/hyperv/hv_init.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 20c876c..7abb09e 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -17,6 +17,7 @@
  *
  */
=20
+#include <linux/efi.h>
 #include <linux/types.h>
 #include <asm/apic.h>
 #include <asm/desc.h>
@@ -253,6 +254,22 @@ static int hv_cpu_die(unsigned int cpu)
 	return 0;
 }
=20
+static int __init hv_pci_init(void)
+{
+	int gen2vm =3D efi_enabled(EFI_BOOT);
+
+	/*
+	 * For Generation-2 VM, we exit from pci_arch_init() by returning 0.
+	 * The purpose is to suppress the harmless warning:
+	 * "PCI: Fatal: No config space access function found"
+	 */
+	if (gen2vm)
+		return 0;
+
+	/* For Generation-1 VM, we'll proceed in pci_arch_init().  */
+	return 1;
+}
+
 /*
  * This function is to be invoked early in the boot sequence after the
  * hypervisor has been detected.
@@ -329,6 +346,8 @@ void __init hyperv_init(void)
=20
 	hv_apic_init();
=20
+	x86_init.pci.arch_init =3D hv_pci_init;
+
 	/*
 	 * Register Hyper-V specific clocksource.
 	 */
--=20
2.7.4

