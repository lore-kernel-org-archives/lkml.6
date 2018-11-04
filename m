Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B65C6786F
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 03:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B52E2081D
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 03:49:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="l2D3rbtN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B52E2081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729083AbeKDNCZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 08:02:25 -0500
Received: from mail-dm3nam03on0116.outbound.protection.outlook.com ([104.47.41.116]:54496
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728653AbeKDNCZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 08:02:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42vYi1gvW4qXvzWInk2dl8kXbXkNZOqY0rEf4+eaf2w=;
 b=l2D3rbtN5rcEqCh78OSLKa0wwoSe4EPZ++mHUk+OBrvoivsCEQCi7rf3m3Cpiu5oUAsDf9LyMrapQF89B08I3r96dLggIdWIk98eS2PYrXmj3lkrKKLdlsXEw7PQ2u+IYhFLcpGeUo/3WkRqn+lh6pR9VNT5Y+z6/uZMK1QxOuA=
Received: from MWHPR21MB0766.namprd21.prod.outlook.com (10.173.51.20) by
 MWHPR21MB0864.namprd21.prod.outlook.com (10.173.51.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1294.3; Sun, 4 Nov 2018 03:48:57 +0000
Received: from MWHPR21MB0766.namprd21.prod.outlook.com
 ([fe80::1982:5e59:2489:88e6]) by MWHPR21MB0766.namprd21.prod.outlook.com
 ([fe80::1982:5e59:2489:88e6%14]) with mapi id 15.20.1339.000; Sun, 4 Nov 2018
 03:48:57 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "jgross@suse.com" <jgross@suse.com>,
        "akataria@vmware.com" <akataria@vmware.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        vkuznets <vkuznets@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        KY Srinivasan <kys@microsoft.com>
CC:     Michael Kelley <mikelley@microsoft.com>
Subject: [PATCH v2 2/2] x86/hyper-v: Enable PIT shutdown quirk
Thread-Topic: [PATCH v2 2/2] x86/hyper-v: Enable PIT shutdown quirk
Thread-Index: AQHUc/FQOuS/oFijukqEX+uW8LbhTQ==
Date:   Sun, 4 Nov 2018 03:48:57 +0000
Message-ID: <1541303219-11142-3-git-send-email-mikelley@microsoft.com>
References: <1541303219-11142-1-git-send-email-mikelley@microsoft.com>
In-Reply-To: <1541303219-11142-1-git-send-email-mikelley@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR21CA0041.namprd21.prod.outlook.com
 (2603:10b6:300:129::27) To MWHPR21MB0766.namprd21.prod.outlook.com
 (2603:10b6:300:76::20)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [131.107.159.136]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR21MB0864;6:TuDWvas6P04759LDsi7YaIzoOqV1pBBhAMsFV3x/3g/0aYx4XTyH1xnoYVcnF2NymlLkeHMUp1fnMIGcpasyOXglAElO+zNEefohxcSmokWOHfnYdQ3eZk4mD1pkmVSRpW0fcsp9v7JoVCcAEr5GBQAedp/73b/vyz3jW2AF84F12Cxpw3udiX+aOOdQtaLod80qhAGLVMlHsB4XoBzCOCVtTFAsIWN0J+D7IQ0cqMSZX5Qbtxww1QR+g5XrbwkWHuo0HB7LBZK6M3q6xTzeBd/LZMXB/ghu/1IgXX+StJiVczjTm8XDXqKecMxsSDF+78C34unZOKBJjQJQmKMz2OrrTW5Qmq58bI+ozuH+74K3Ky+wE88aptbwrcj0csbkyMDLeXwyFyf0FO+ODRs0rCfVS6FWmV9EjYh9zYnIUcpGeg1HpEcJkBXMUcAaEV29R55WuMFi1E5cLAfCf/pE1w==;5:D53EdZ/fCKUao1bwYjekNih65g+jog9ieDstSamCWVivAMAxlV1rqEEW2iCXMHAtcr4vOSH4CqYCwQycwpQKxJDhdblBbmJl7j6oTuddoG/5HIGKEqIXtqjjyljXqrKPra95+iQMm+NCzQ8zDOKDfZbMgwSP7pv2TJyPQgHY/gg=;7:Ssd9keR0nwaNk4zKkvVqUBv5OFGu5oU0Q9li8cwY5gJrJs0E+/JEBN2JEEy1l0Ufz9DMTO1rQFsSHRWIFU8GVhlLa1yFXO9wjSRvxMmPXESD/nepq9Iv911W+DknSKVlulUV2GRbNVaigjz1fOUfBA==
x-ms-office365-filtering-correlation-id: 8925366f-4dfb-4814-2506-08d6420872e7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:MWHPR21MB0864;
x-ms-traffictypediagnostic: MWHPR21MB0864:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-o365ent-eop-header: Message processed by -  O365_ENT: Allow from ranges
 (Engineering ONLY)
x-microsoft-antispam-prvs: <MWHPR21MB0864DA32D871B963B5AE2402D7C90@MWHPR21MB0864.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(8220035)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231382)(944501410)(52105095)(2018427008)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:MWHPR21MB0864;BCL:0;PCL:0;RULEID:;SRVR:MWHPR21MB0864;
x-forefront-prvs: 084674B2CF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(136003)(39860400002)(366004)(396003)(189003)(199004)(6512007)(107886003)(66066001)(4326008)(53936002)(86612001)(25786009)(2906002)(5660300001)(7416002)(1511001)(14454004)(6116002)(7736002)(110136005)(36756003)(305945005)(3846002)(105586002)(2501003)(106356001)(71190400001)(71200400001)(11346002)(2900100001)(102836004)(486006)(476003)(2616005)(6506007)(26005)(22452003)(10090500001)(386003)(81166006)(81156014)(446003)(8676002)(8936002)(99286004)(256004)(6486002)(478600001)(86362001)(6436002)(97736004)(10290500003)(316002)(76176011)(6636002)(52116002)(68736007)(186003)(2201001)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR21MB0864;H:MWHPR21MB0766.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Wuu1fzs6hJ38zcHb5rAWNOPmMx4cAY+6t3AoAn+PL/G9O1jEOT30B/9wMbQv/hNbaXRbLfuv9W5RrEgoI4yIosUyFEjFv4PHlD7A87k+Imc1yCLFU2tj0fRHVP8gn8hFmRW5CFy3FuJcJOkTrXwjbAjinlw2p5MJwRxUTrjVLv5BK+B/nacGgQwQvPUfdkFS0qDUHVgdfAWfRiPg2UuCSaMUrL7LwQDVSG4DZb/bqblVOApDmCcn8waLmZzA/w2x0BH+YqssjfzGvprq6Mk8guU6n/CXSA2OcNJpzXXwas2AcFlYyPbn0+Fgtt1oxqQ3m5yO1ZBMMPYXBZHSncCi3jFvdl08RA3TR70kVBqzK3U=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8925366f-4dfb-4814-2506-08d6420872e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2018 03:48:57.5832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0864
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hyper-V emulation of the PIT has a quirk such that the normal
PIT shutdown path doesn't work. Enable the PIT code that
handles this quirk.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 arch/x86/kernel/cpu/mshyperv.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.=
c
index 1c72f38..65b2f88 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -20,6 +20,7 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/kexec.h>
+#include <linux/i8253.h>
 #include <asm/processor.h>
 #include <asm/hypervisor.h>
 #include <asm/hyperv-tlfs.h>
@@ -295,6 +296,16 @@ static void __init ms_hyperv_init_platform(void)
 	if (efi_enabled(EFI_BOOT))
 		x86_platform.get_nmi_reason =3D hv_get_nmi_reason;
=20
+	/*
+	 * Hyper-V VMs have a PIT emulation quirk such that zeroing the
+	 * counter register during PIT shutdown restarts the PIT. So it
+	 * continues to interrupt @18.2 HZ. Setting i8253_clear_counter
+	 * to false tells pit_shutdown() not to zero the counter so that
+	 * the PIT really is shutdown. Generation 2 VMs don't have a PIT,
+	 * and setting this value has no effect.
+	 */
+	i8253_clear_counter =3D false;
+
 #if IS_ENABLED(CONFIG_HYPERV)
 	/*
 	 * Setup the hook to get control post apic initialization.
--=20
1.8.3.1

