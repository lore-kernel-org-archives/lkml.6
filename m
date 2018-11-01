Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6583AC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 17:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13610205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 17:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="CMKfpgqh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13610205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbeKBCg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 22:36:29 -0400
Received: from mail-eopbgr690117.outbound.protection.outlook.com ([40.107.69.117]:11227
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727564AbeKBCg3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 22:36:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pOooNRGXziLT7uj/g7LFOhKS8zy+iyTDPBngi7PkCGU=;
 b=CMKfpgqhKJayjZ2GP6AF00ct8zyI7bU87P9Mdn22cq1bBTnCsQaSuVntegrhmSiiprl7ukdQQc76IgJNXFGntHKc2qOG03NV03cNcauTTsXtFswTy/VdaPrChPBztND8DUiNp7ZSWYhNQc2qdt7iulzvVMZy1sEVIaZ8YlMnN3I=
Received: from MWHPR21MB0766.namprd21.prod.outlook.com (10.173.51.20) by
 MWHPR21MB0174.namprd21.prod.outlook.com (10.173.52.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1294.25; Thu, 1 Nov 2018 17:32:33 +0000
Received: from MWHPR21MB0766.namprd21.prod.outlook.com
 ([fe80::1982:5e59:2489:88e6]) by MWHPR21MB0766.namprd21.prod.outlook.com
 ([fe80::1982:5e59:2489:88e6%14]) with mapi id 15.20.1294.009; Thu, 1 Nov 2018
 17:32:32 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "jgross@suse.com" <jgross@suse.com>,
        "akataria@vmware.com" <akataria@vmware.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        vkuznets <vkuznets@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        KY Srinivasan <kys@microsoft.com>
CC:     Michael Kelley <mikelley@microsoft.com>
Subject: [PATCH 2/2] i8253: Fix PIT shutdown quirk on Hyper-V
Thread-Topic: [PATCH 2/2] i8253: Fix PIT shutdown quirk on Hyper-V
Thread-Index: AQHUcgjfA60j6IBiX0OFt2M1khyPxA==
Date:   Thu, 1 Nov 2018 17:32:32 +0000
Message-ID: <1541093509-10576-1-git-send-email-mikelley@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MW2PR2101CA0023.namprd21.prod.outlook.com
 (2603:10b6:302:1::36) To MWHPR21MB0766.namprd21.prod.outlook.com
 (2603:10b6:300:76::20)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [131.107.147.136]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR21MB0174;6:3E/zV8giyDLvWUC5F7cJD/lUTlsxyha2rCVdQb6LNhFXEb/33NqygFtAQ0sdEujYoeLqqp6JmZG9Kmy0xzMC1e+p98ybsiTqsCRXVBwR1WCahIdrv+DUuIszvifzxGq3H60JS5zS7kFMslOp7LKIftvRXFLHRQrWNOqq/U/fHt7DRgc9x/AFtynzR0w0AwUbU6daGi9fzuYC2poSTbmuTgyLd/OT2yctsNTYYQGu3Em8AstovEOJU52aLxe6ODMFRuDuRog0EIOa/tygjZeiCXZmnSNDJnYrINUXfnAsJoYwrYxNrhzc0osQfY0HiiyNGHprahudJljrucO2opt1fbRH5d3yqLh4dj0ZPgiydzVfInx4LGLmYeTw6BSoaAMOCu8SrvZXPOdwZMm6dx5gEECkJF/T+QRMR65/loPI0/ZuyLYrqL2ZRkfyEtE9n3cDMxdXenOmqbmfjJsdkSWa6g==;5:mqGQq8OuOmx1ER/W9ncKscI0hbBPKIxBTMpH+xkkn0ZoFA/JjRAYu6VlPB/s4ld0uT+y+oOlfRLn4/EzAk6ICgMQTqQRlp7mhVAuA5xvDDKmm9hXctxfD3YhqXx3hIY3654oyzv6Dy1aiETeKeC5aLDZZa4l4BCT4qWhG4IwXYY=;7:sk8HbSmxbMsEaY9VsHkGSeBxTcOnxJxrJXidteOMEHWme+93qEWxO9gGFRBAdstVbsrLPa9IV7xgqEg6uEhBpX8kviXv4+K/10uEjyCCUvhqQreifcdexWkuKJVr14kYQmFTObgkEzPve3ET6Urznw==
x-ms-office365-filtering-correlation-id: 70d1710a-7f6e-44c8-c7a4-08d640200160
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:MWHPR21MB0174;
x-ms-traffictypediagnostic: MWHPR21MB0174:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-o365eop-header: O365_EOP: Allow for Unauthenticated Relay
x-o365ent-eop-header: Message processed by -  O365_ENT: Allow from ranges
 (Engineering ONLY)
x-microsoft-antispam-prvs: <MWHPR21MB017471C29EFCD78E1D8AFA0CD7CE0@MWHPR21MB0174.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(8220035)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231382)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:MWHPR21MB0174;BCL:0;PCL:0;RULEID:;SRVR:MWHPR21MB0174;
x-forefront-prvs: 0843C17679
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(136003)(396003)(39860400002)(189003)(199004)(476003)(8676002)(6636002)(5250100002)(486006)(6436002)(22452003)(53936002)(6512007)(316002)(25786009)(186003)(14454004)(26005)(68736007)(4326008)(14444005)(2616005)(6486002)(256004)(71200400001)(81166006)(81156014)(10090500001)(8936002)(2501003)(107886003)(36756003)(10290500003)(110136005)(478600001)(71190400001)(2900100001)(86612001)(2201001)(6116002)(106356001)(3846002)(52116002)(99286004)(97736004)(5660300001)(86362001)(66066001)(386003)(6506007)(102836004)(2906002)(1511001)(7416002)(7736002)(105586002)(305945005)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR21MB0174;H:MWHPR21MB0766.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 4UEM+lSuKDkdJUyh2rVdwDKSku4MiXuqeyUvG9WoM3Q9wL48Lu9TfEGpEL/70+ukI2+F7d7MmFZjw/r9sdngO6ymaNCiOyH9qWEs8hv8EvVHNmp/0XnWYGSt9CmplYLB5k1KSbcWEsXakPanem9QupUb7jRHN13nQkSSu9AYWh+cKU2xvUDGLEw7yfNZdUaUlkB9g5F1V1AV6lZ8j9qiy4bqMjR4C0x5JuEHqPoK9MXBC4LkhWGZPCknGKK5/Mzt6bqUMCUDKKBcw54XOdtsv2CxSHRo/25aZPGbIXOo38mvM4SfOGYmwR1zU8x4pp43u2vRgJ52VepgVtJB/CQHD2AD9zvvpqMRKYRHx7+kXnI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70d1710a-7f6e-44c8-c7a4-08d640200160
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2018 17:32:32.8098
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0174
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pit_shutdown() doesn't work on Hyper-V because of a quirk in the
PIT emulation. This problem exists in all versions of Hyper-V and
had not been noticed previously. When the counter register is set
to zero, the emulated PIT continues to interrupt @18.2 HZ. So
skip setting the counter register when running on Hyper-V.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/clocksource/i8253.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/i8253.c b/drivers/clocksource/i8253.c
index 9c38895..62025c8 100644
--- a/drivers/clocksource/i8253.c
+++ b/drivers/clocksource/i8253.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/i8253.h>
 #include <linux/smp.h>
+#include <linux/hypervisor.h>
=20
 /*
  * Protects access to I/O ports
@@ -109,8 +110,17 @@ static int pit_shutdown(struct clock_event_device *evt=
)
 	raw_spin_lock(&i8253_lock);
=20
 	outb_p(0x30, PIT_MODE);
-	outb_p(0, PIT_CH0);
-	outb_p(0, PIT_CH0);
+
+	/*
+	 * A quirk in Hyper-V's emulation of the PIT causes the PIT
+	 * to continue to run and interrupt @18.2 Hz when the counter
+	 * register is set to zero. So skip setting the counter
+	 * register when running as a guest on Hyper-V.
+	 */
+	if (!hypervisor_is_mshyperv()) {
+		outb_p(0, PIT_CH0);
+		outb_p(0, PIT_CH0);
+	}
=20
 	raw_spin_unlock(&i8253_lock);
 	return 0;
--=20
1.8.3.1

