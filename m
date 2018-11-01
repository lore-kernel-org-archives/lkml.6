Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 807B0C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 17:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40EBF20820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 17:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="TtzClpct"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40EBF20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbeKBCgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 22:36:03 -0400
Received: from mail-eopbgr690134.outbound.protection.outlook.com ([40.107.69.134]:5222
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727567AbeKBCgD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 22:36:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2RktdxFMANvR2hQr7ojv3TnHh5Dbz4m+lkaRCzk/9NI=;
 b=TtzClpct+9/SustnHajjYrUda5MGTqi9GkOctql/yiGItIHNU/JY+Mzrm3CvDQxH0VCd9uMFVj8RTL/QoR7kQ9tDVqRvMLo9X4EDarWsQmBeVH3znEsQUZOyAx+xD+4PFZD3wGHyB47A2d3weJExrBb8aL9FiyXMOre9LdS+f4k=
Received: from MWHPR21MB0766.namprd21.prod.outlook.com (10.173.51.20) by
 MWHPR21MB0174.namprd21.prod.outlook.com (10.173.52.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1294.25; Thu, 1 Nov 2018 17:32:04 +0000
Received: from MWHPR21MB0766.namprd21.prod.outlook.com
 ([fe80::1982:5e59:2489:88e6]) by MWHPR21MB0766.namprd21.prod.outlook.com
 ([fe80::1982:5e59:2489:88e6%14]) with mapi id 15.20.1294.009; Thu, 1 Nov 2018
 17:32:04 +0000
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
Subject: [PATCH 1/2] include/linux/hypervisor.h: Add test for running on
 Hyper-V
Thread-Topic: [PATCH 1/2] include/linux/hypervisor.h: Add test for running on
 Hyper-V
Thread-Index: AQHUcgjOFb6Xv4uDfkaZ4DMM7HwqKg==
Date:   Thu, 1 Nov 2018 17:32:04 +0000
Message-ID: <1541093480-10539-1-git-send-email-mikelley@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CY4PR04CA0080.namprd04.prod.outlook.com
 (2603:10b6:910:4f::45) To MWHPR21MB0766.namprd21.prod.outlook.com
 (2603:10b6:300:76::20)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [167.220.2.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR21MB0174;6:x0kH02XM5fFxKMENCy8Y3pMLhFbgKdJ7FVGgnIr/HJw90AdHCojCSXPuGgdX6OED8Sas5i78ij3x7F+61CI1hZXSIaikDsznt2RkUQv7UiY0fv10Cpt7ikLW8onntR9wu2eQA6zp/Z8+G19QN/NRcjjI/9K8B4ZkySaiqvKKE/GtCpVabOSpoxeUpVo2Sr95qMxRs/Utuhh2wkzEbLx63MkNXtxiuGo1po7hfke2qLN6JaSDih/vObTJNZTo21DC9pCqcoPR354mwDx/H3ZUUPxTYIqE+jJfDbBwbhPrI4CBn162nUd66IWuT9u7ad8aF9DtgG7NlT4aixVqesT+am5O1XFdN5lwFHBdNPVwwDyTUsE7K1ihhBj8dakIo1OPQXZRrScItRJkPEeeadR/L7Dhf2mn1tBuxb+7pDQihc5LJclO0/j+M/11J9MLKICa3NK/XQHF2nslCNE5vlNaNg==;5:r6BlB8KJvID8XX1pS7K+ynIhQt67Upo1rL6BThQqpcIJQx6FFNHuSTSpdeS4MlcFeoKxH0PKVE6ZHvvVplrg5DrlZnXgJ7D4kL+5XkhtPcbrqZSPLd3Ec9gOtYWyCTuoZN4DfPao9QvJ6u2F/XYBs/2sQ7Yx1fWoJAoliS1Srls=;7:DzC0D+SeW5lQLZxxF7S6l/juNX19853pqJWk2p8NTjk2crJBzcX8U6zHDh3TnB6K8C1eydRaLmaqyiXcyL2JxBmcMYiVMgCGY4aETkVuWrt4isNoAxP7swrHyeN70TPIaLF57yGHn0lBhiLX8oXXJw==
x-ms-office365-filtering-correlation-id: 99c61829-974a-4cd1-3291-08d6401ff07e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:MWHPR21MB0174;
x-ms-traffictypediagnostic: MWHPR21MB0174:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MWHPR21MB0174755C4BB210F495AF96C2D7CE0@MWHPR21MB0174.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(8220035)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231382)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:MWHPR21MB0174;BCL:0;PCL:0;RULEID:;SRVR:MWHPR21MB0174;
x-forefront-prvs: 0843C17679
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(136003)(396003)(39860400002)(189003)(199004)(476003)(8676002)(6636002)(5250100002)(486006)(6436002)(22452003)(53936002)(6512007)(316002)(25786009)(186003)(14454004)(26005)(68736007)(4326008)(2616005)(6486002)(256004)(71200400001)(81166006)(81156014)(10090500001)(8936002)(2501003)(107886003)(36756003)(10290500003)(110136005)(478600001)(71190400001)(2900100001)(86612001)(2201001)(6116002)(106356001)(3846002)(52116002)(99286004)(97736004)(5660300001)(86362001)(66066001)(386003)(6506007)(102836004)(2906002)(1511001)(7416002)(7736002)(105586002)(305945005)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR21MB0174;H:MWHPR21MB0766.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: NurzLVemKdLBucH/6GVAuu8AhHgbj6uZ/mpjF0F1ESfKLrM2jfpDBsRhrlA8+4lRK/UhrR5SndLOS1Z3Tpa2j14CtdYJl9In+LTx8tkqiG2OMWWWagJYYIx8zv2VY5UltV1pGSh6Za2Ud1yF/MlPWdyZKnsjVdEIsLu0i68KGTouH/aDX5AX/wALDcAonjzMjV/K5QmmUEvzOkAgIkt5horG9f/2zemKNg2DWRfAdO2atDctwQt91NUce+HvsoIztj4fVt2EMej4SGpkbh3nbgI+SM/y+Vy8RX19FUXx3UrDM3fMszYnk3Oq+z1hpPGlAGsGNO2muS/WNWWXtBQuKfz+u9DCEwxoAiaJM91BizA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99c61829-974a-4cd1-3291-08d6401ff07e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2018 17:32:04.5438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0174
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a test for running on Hyper-V on x86/x64.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 include/linux/hypervisor.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/hypervisor.h b/include/linux/hypervisor.h
index fc08b43..1281f62 100644
--- a/include/linux/hypervisor.h
+++ b/include/linux/hypervisor.h
@@ -9,6 +9,7 @@
=20
 #ifdef CONFIG_X86
=20
+#include <asm/hypervisor.h>
 #include <asm/jailhouse_para.h>
 #include <asm/x86_init.h>
=20
@@ -17,6 +18,11 @@ static inline void hypervisor_pin_vcpu(int cpu)
 	x86_platform.hyper.pin_vcpu(cpu);
 }
=20
+static inline bool hypervisor_is_mshyperv(void)
+{
+	return hypervisor_is_type(X86_HYPER_MS_HYPERV);
+}
+
 #else /* !CONFIG_X86 */
=20
 #include <linux/of.h>
@@ -30,6 +36,11 @@ static inline bool jailhouse_paravirt(void)
 	return of_find_compatible_node(NULL, NULL, "jailhouse,cell");
 }
=20
+static inline bool hypervisor_is_mshyperv(void)
+{
+	return false;
+}
+
 #endif /* !CONFIG_X86 */
=20
 #endif /* __LINUX_HYPEVISOR_H */
--=20
1.8.3.1

