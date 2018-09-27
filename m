Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20698C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF68C21722
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="cwq8XVvy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF68C21722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbeI1FUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 01:20:03 -0400
Received: from mail-bn3nam01on0093.outbound.protection.outlook.com ([104.47.33.93]:5024
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725972AbeI1FUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 01:20:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fnOMOKRasNv44N+M70tldNxfHldKjIIjV1wYWR9sWDQ=;
 b=cwq8XVvyp4GGR9e29hSqVccAD4W8lStrzK8+NBF38NA5pp+yhHOTiTbFeX47pdWmvHpJRZB8LslScywlCWJJ803OgnpI2jeSkhD/G5x6mwn9lDE2GzyZ5ZcZqMEBlrx/q+kI2etE0Z0EW2V8LGdCNGVnfM/I+zz4KLLDifernbs=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1328.namprd22.prod.outlook.com (10.174.162.143) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.17; Thu, 27 Sep 2018 22:59:18 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::1886:62b2:fbe4:9627]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::1886:62b2:fbe4:9627%9]) with mapi id 15.20.1164.024; Thu, 27 Sep 2018
 22:59:18 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Paul Burton <pburton@wavecomp.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Jaedon Shin <jaedon.shin@gmail.com>,
        Mathieu Malaterre <malat@debian.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH v2] MIPS: Fix CONFIG_CMDLINE handling
Thread-Topic: [PATCH v2] MIPS: Fix CONFIG_CMDLINE handling
Thread-Index: AQHUVrW4h/CAVBNItkqG0pCfstNkpQ==
Date:   Thu, 27 Sep 2018 22:59:18 +0000
Message-ID: <20180927225829.6612-1-paul.burton@mips.com>
References: <CAL_JsqKZYiDpH8900Mw+ADiUx--GbqF7j1MYoqbcJYCmbjvY4g@mail.gmail.com>
In-Reply-To: <CAL_JsqKZYiDpH8900Mw+ADiUx--GbqF7j1MYoqbcJYCmbjvY4g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DM5PR2001CA0022.namprd20.prod.outlook.com
 (2603:10b6:4:16::32) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1328;6:LQZgraagkibstBD0Itd8NnGICk7AlEU2i3IV2e5homzsoRq/SX2xtN4RbX+hq4AwpMDCWEmWpoBP0OWwT1RxgZT/0vqilf46A9sXNwV9DphR63T1RRjsq2JmBKbZFc6ZEijj2qCAnDHveBma/RthwZCXCT9lRljfBaLwVdzKGybHLP1XPP8upyY+q8qwmRVe+TKOrhbns4Gx/HTxSCUM772QtWTyrhgBxUR2dn8usEs4QpRrSdUw+nfd0vfRMFYUuLp7emt8rG/EMYzauS9N2yK58a/AmwAYvB2zyCBYjG1CCuTefl1pxTqAc/nujArEdXV7go68vyr8ua09WSMxwaymjukB5ffg4YQExGctj7KBsKlw+lWySpOvuZtAxWNEFjcSwKvvp98fIgTP+bHqGhwL8uKTrUBhZdAF5KOoGg7lxmU4AWEpjpZOUgZe9Q3+a9rAmMH/Iii724Rxs6W6TQ==;5:Ry9VnYp3sjLoz09qtb0OF5Dq+/Me2OA0wZgqyZP+YfPiVQIG6tyEMBNXdB7RfYfLEdHMw0xK7CA8cRck3gzIKp7xAvBA+D9CZXVU4zMxSyxQosdNrRtreTWYsR2weFLcUq+gEeEvOddS/P22dpHTc4K63H7/RUINBNx9LT0QsT8=;7:paxYavzmk04iqH0FNX9eWmXiXXC99bLIt4XyeUsZyY7Wvl1lm3J8fIdKON+wnxiBd1BnestYqDN90p+t5jG1fhjcxpjuzoIPsWQv7oTpVMUFigXsmVgvb1HIbbRgFlwH7vqEjstlhazOJKl9wCh30KwuoVkDt2UXrst2tvtoNCHS4a46Wmfp3j6nRdxeKyjmsN13xqMpPh8eElGDzq/ijqT4A9gbD7g6vJYqx3HDQrcQQHGwYGTkC5zICIMzRNKo
x-ms-office365-filtering-correlation-id: 55d31cfc-89cb-453e-2168-08d624ccda45
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989299)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1328;
x-ms-traffictypediagnostic: MWHPR2201MB1328:
x-microsoft-antispam-prvs: <MWHPR2201MB132877DF16AC173BE7A99810C1140@MWHPR2201MB1328.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(10201501046)(93006095)(3002001)(149066)(150057)(6041310)(20161123558120)(2016111802025)(20161123562045)(20161123560045)(20161123564045)(6043046)(201708071742011)(7699051);SRVR:MWHPR2201MB1328;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1328;
x-forefront-prvs: 0808323E97
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(346002)(396003)(39850400004)(376002)(199004)(189003)(55674003)(106356001)(14444005)(105586002)(4326008)(1076002)(5660300001)(316002)(508600001)(66066001)(966005)(2900100001)(6116002)(54906003)(110136005)(3846002)(6306002)(305945005)(34290500001)(39060400002)(8676002)(25786009)(6512007)(53936002)(7736002)(6436002)(6486002)(52116002)(42882007)(81156014)(11346002)(99286004)(97736004)(68736007)(36756003)(14454004)(486006)(2906002)(26005)(81166006)(256004)(102836004)(386003)(5250100002)(476003)(6506007)(2501003)(76176011)(2616005)(44832011)(186003)(446003)(71190400001)(8936002)(71200400001)(6606295002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1328;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: QQFslohzYYQZ7Cq/xrQzxs0QU1r9bArUF1WxcDClpey3nACnKzxZg47KUDarcoFzrGTCtSk9qy4GPQRjefNqK/7tBqbD/GDBYYt07Im4hGWuMqaJjZYuBxwCatqnFl/BFUxB0r+wyv8FQ+gcE9DizpaKDuez8S/8e2nqQ1tG//fm1rUt6JSXt7sevWJtgTPyEZoNsPd3YfslDA6ChVT8ybBv+eAKCccOCU5uBiA6v4RkeOWM9NlC5yFdre0Qua9InyS3lJtYjUKLA6hWpCcsQqDA7asTkhnfpGnTh7nrnM7M/2GcgANrmZN2fzDoROt0ZtaoR048W6GN1fsjkZQMuvtvODKLiUhVpBkcCY/efU8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55d31cfc-89cb-453e-2168-08d624ccda45
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2018 22:59:18.2773
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1328
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 8ce355cf2e38 ("MIPS: Setup boot_command_line before
plat_mem_setup") fixed a problem for systems which have
CONFIG_CMDLINE_BOOL=3Dy & use a DT with a chosen node that has either no
bootargs property or an empty one. In this configuration
early_init_dt_scan_chosen() copies CONFIG_CMDLINE into
boot_command_line, but the MIPS code doesn't know this so it appends
CONFIG_CMDLINE (via builtin_cmdline) to boot_command_line again. The
result is that boot_command_line contains the arguments from
CONFIG_CMDLINE twice.

That commit took the approach of simply setting up boot_command_line
from the MIPS code before early_init_dt_scan_chosen() runs, causing it
not to copy CONFIG_CMDLINE to boot_command_line if a chosen node with no
bootargs property is found.

Unfortunately this is problematic for systems which do have a non-empty
bootargs property & CONFIG_CMDLINE_BOOL=3Dy. There
early_init_dt_scan_chosen() will overwrite boot_command_line with the
arguments from DT, which means we lose those from CONFIG_CMDLINE
entirely. This breaks CONFIG_MIPS_CMDLINE_DTB_EXTEND. If we have
CONFIG_MIPS_CMDLINE_FROM_BOOTLOADER or
CONFIG_MIPS_CMDLINE_BUILTIN_EXTEND selected and the DT has a bootargs
property which we should ignore, it will instead be honoured breaking
those configurations too.

Fix this by reverting commit 8ce355cf2e38 ("MIPS: Setup
boot_command_line before plat_mem_setup") to restore the former
behaviour, and fixing the CONFIG_CMDLINE duplication issue by
initializing boot_command_line to a non-empty string that
early_init_dt_scan_chosen() will not overwrite with CONFIG_CMDLINE.

This is a little ugly, but cleanup in this area is on its way. In the
meantime this is at least easy to backport & contains the ugliness
within arch/mips/.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Fixes: 8ce355cf2e38 ("MIPS: Setup boot_command_line before plat_mem_setup")
References: https://patchwork.linux-mips.org/patch/18804/
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: Jaedon Shin <jaedon.shin@gmail.com>
Cc: Mathieu Malaterre <malat@debian.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: stable@vger.kernel.org # v4.16+
---
This isn't pretty, but further cleanup is underway [1] and this fixes
the regression in an easily backportable manner without adding another
per-architecture function like v1.

[1] https://www.spinics.net/lists/kernel/msg2918275.html

Changes in v2:
 - Drop the arch-specific function & just initialize boot_command_line
   such that early_init_dt_scan_chosen() won't overwrite it with
   CONFIG_CMDLINE.

v1: https://marc.info/?l=3Dlinux-mips&m=3D153634652318477&w=3D2
    https://marc.info/?l=3Dlinux-mips&m=3D153634653718485&w=3D2
---
 arch/mips/kernel/setup.c | 48 +++++++++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 20 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index c71d1eb7da59..8aaaa42f91ed 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -846,6 +846,34 @@ static void __init arch_mem_init(char **cmdline_p)
 	struct memblock_region *reg;
 	extern void plat_mem_setup(void);
=20
+	/*
+	 * Initialize boot_command_line to an innocuous but non-empty string in
+	 * order to prevent early_init_dt_scan_chosen() from copying
+	 * CONFIG_CMDLINE into it without our knowledge. We handle
+	 * CONFIG_CMDLINE ourselves below & don't want to duplicate its
+	 * content because repeating arguments can be problematic.
+	 */
+	strlcpy(boot_command_line, " ", COMMAND_LINE_SIZE);
+
+	/* call board setup routine */
+	plat_mem_setup();
+
+	/*
+	 * Make sure all kernel memory is in the maps.  The "UP" and
+	 * "DOWN" are opposite for initdata since if it crosses over
+	 * into another memory section you don't want that to be
+	 * freed when the initdata is freed.
+	 */
+	arch_mem_addpart(PFN_DOWN(__pa_symbol(&_text)) << PAGE_SHIFT,
+			 PFN_UP(__pa_symbol(&_edata)) << PAGE_SHIFT,
+			 BOOT_MEM_RAM);
+	arch_mem_addpart(PFN_UP(__pa_symbol(&__init_begin)) << PAGE_SHIFT,
+			 PFN_DOWN(__pa_symbol(&__init_end)) << PAGE_SHIFT,
+			 BOOT_MEM_INIT_RAM);
+
+	pr_info("Determined physical RAM map:\n");
+	print_memory_map();
+
 #if defined(CONFIG_CMDLINE_BOOL) && defined(CONFIG_CMDLINE_OVERRIDE)
 	strlcpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
 #else
@@ -873,26 +901,6 @@ static void __init arch_mem_init(char **cmdline_p)
 	}
 #endif
 #endif
-
-	/* call board setup routine */
-	plat_mem_setup();
-
-	/*
-	 * Make sure all kernel memory is in the maps.  The "UP" and
-	 * "DOWN" are opposite for initdata since if it crosses over
-	 * into another memory section you don't want that to be
-	 * freed when the initdata is freed.
-	 */
-	arch_mem_addpart(PFN_DOWN(__pa_symbol(&_text)) << PAGE_SHIFT,
-			 PFN_UP(__pa_symbol(&_edata)) << PAGE_SHIFT,
-			 BOOT_MEM_RAM);
-	arch_mem_addpart(PFN_UP(__pa_symbol(&__init_begin)) << PAGE_SHIFT,
-			 PFN_DOWN(__pa_symbol(&__init_end)) << PAGE_SHIFT,
-			 BOOT_MEM_INIT_RAM);
-
-	pr_info("Determined physical RAM map:\n");
-	print_memory_map();
-
 	strlcpy(command_line, boot_command_line, COMMAND_LINE_SIZE);
=20
 	*cmdline_p =3D command_line;
--=20
2.19.0

