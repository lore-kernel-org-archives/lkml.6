Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F420AC004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 16:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 306D8205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 16:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ZYlDAXw8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 306D8205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbeJWAxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 20:53:30 -0400
Received: from mail-sn1nam02on0100.outbound.protection.outlook.com ([104.47.36.100]:15328
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728087AbeJWAxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 20:53:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dkjK92xkpoZwEeJn6aDoSJeLecgXaTlbzK2ykbOP6ts=;
 b=ZYlDAXw8jUY35ITBLX+F+2lca25Lw6pBizxN+tUz+InEHOE7HNzF9lINce5bAzGioQV6sehEl/Wiz+Q7cJH+/FLA2Fajn5ZWWwsmv65KMcut9C7UcguU1z3FHwq9eeLPMq63jP8jCrHcaZPmD0eLYMoRlSt/Qi8FMKYVZEuoy/4=
Received: from MWHPR21MB0766.namprd21.prod.outlook.com (10.173.51.20) by
 MWHPR21MB0477.namprd21.prod.outlook.com (10.172.102.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1294.3; Mon, 22 Oct 2018 16:34:13 +0000
Received: from MWHPR21MB0766.namprd21.prod.outlook.com
 ([fe80::1982:5e59:2489:88e6]) by MWHPR21MB0766.namprd21.prod.outlook.com
 ([fe80::1982:5e59:2489:88e6%14]) with mapi id 15.20.1294.001; Mon, 22 Oct
 2018 16:34:13 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        vkuznets <vkuznets@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>
CC:     Michael Kelley <mikelley@microsoft.com>
Subject: [PATCH v2 char-misc 1/1] x86/hyperv: Fix PIT shutdown quirk
Thread-Topic: [PATCH v2 char-misc 1/1] x86/hyperv: Fix PIT shutdown quirk
Thread-Index: AQHUaiUQ3a7qHQo2LESQRWPEN4INtw==
Date:   Mon, 22 Oct 2018 16:34:13 +0000
Message-ID: <1540226025-45092-1-git-send-email-mikelley@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR17CA0052.namprd17.prod.outlook.com
 (2603:10b6:300:93::14) To MWHPR21MB0766.namprd21.prod.outlook.com
 (2603:10b6:300:76::20)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [167.220.2.136]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR21MB0477;6:w0a34RcipYu6rGw3A3X/rLFsvpjcvTjq5K2lyDRp+j44TE4LdwlPs483Dr//Tbtkhoiooxd3FyV7olOkNfxdGWiKNYizA6417f/TIQjgfF5wegKGPLhJeBjix19xmOr2hOAiKTHPzT+j8a+tVQ9OL98qD31H33+BN8iteZRVJ/aTvL11Z16LB4YStW6sNNDj7qDvXSGkQ8xYCEmoOWVTsdazwKxK5pK/HM8tCbQpq8kmGkzhS6yJRxwUe24seB3xAQoBDlc2iNO+QH+3zwiUbV6PZquCjFoCFfT5/zg3Cd3ty8zP4U/tQ9UPt+hWBLLHYTMzZ8ICyW6dQvYwQyNzNdQUCZJbCj612/kmfMOBPdms6HT7ZltmUffgwcYXhFd5Lm9CenzeDpuype9NAPI7/ZzcEmYF9i1IhwH8Q45D7C2RjWXSQdeHLsPuktj705Ta9kznuXG4azjGZdFzmLd+6A==;5:Xm8n+kdQMAW6lSjqXdmieeUqLvfVho+vC04z6EZl8x82Q+jEpxrjlrFMWKi4l+pfMRCIyqZMt9Qgw97yn9rAIbiGVBzZmVlGn0VaQbFmDTsb+wMgb0t4phwXozCKc1NAx1v48mjyXB+tMZxQYEUL9OfzgmxcM/R8fuAadTh6hNI=;7:OE46UburdnOYHajJ2nswvx5to3apm021QFJfqwVvUCUH0bjEmyka5L8OgALbAzZEigtB02hmuSUj+UAsYj15CVYmAgZPS03dSsFXqizMy4skGJxgPorInrHubHpdPgPJhlylZYQkEQ8lXx65s7a+XQ==
x-ms-office365-filtering-correlation-id: 278cead9-3229-492f-5ef6-08d6383c32d5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:MWHPR21MB0477;
x-ms-traffictypediagnostic: MWHPR21MB0477:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MWHPR21MB047709918743D8F2F21CC328D7F40@MWHPR21MB0477.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(788757137089)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(8220027)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:MWHPR21MB0477;BCL:0;PCL:0;RULEID:;SRVR:MWHPR21MB0477;
x-forefront-prvs: 08331F819E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(136003)(39860400002)(366004)(346002)(189003)(199004)(8676002)(102836004)(71190400001)(2501003)(36756003)(22452003)(256004)(110136005)(86362001)(106356001)(81166006)(81156014)(6116002)(1511001)(68736007)(66066001)(6512007)(26005)(97736004)(8936002)(2616005)(316002)(14454004)(476003)(478600001)(486006)(86612001)(99286004)(2906002)(5250100002)(2201001)(10090500001)(25786009)(5660300001)(2900100001)(6506007)(52116002)(386003)(7416002)(53936002)(186003)(107886003)(305945005)(3846002)(6436002)(7736002)(4326008)(6486002)(10290500003)(6636002)(71200400001)(105586002)(14444005)(6346003)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR21MB0477;H:MWHPR21MB0766.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-microsoft-antispam-message-info: oGOHo7EwubJoHMmsm7fqvtrnpyZ1NNOIRhyFezXoPB5CDRCkuzOCyu3qIG17EKfrcLR81bJC44htdtGZqDh3Xbp4Agv5xsGnIN5zLYX+vzsX/fFPKAU9ppZ2uzQ5S1BsQcU4ak21yZip12HmpER92nf54RSSX3A00/DcHDWvHEhX9BCzVPfdh5gbdozhfgeEfOgRwaIsWvzDe+OSZgPGulD2xmicfkOgO/vMVJvL3g8J0RfE12wmebNg7eYxmmUaSJRBFi6/oCEpRJ3tmIrQr9nCDksVo3W5YZdqYenYejDHKcwK58IeEgRH/bSDCEikmIvWGt+WLC57nRqlSSnZsHRk8l/Yp1CBETzkp6UUg+Q=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 278cead9-3229-492f-5ef6-08d6383c32d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2018 16:34:13.4354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0477
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pit_shutdown() doesn't work on Hyper-V because of a quirk in the
PIT emulation. After shutdown the emulated PIT continues to interrupt
@18.2 HZ. This problem exists in all versions of Hyper-V and just
had not previously been noticed. So replace the normal PIT shutdown
function with an alternate version that works on Hyper-V.

The alternate shutdown function could go in the i8253.c module,
but it seems better to keep the hack with the Hyper-V code rather
than clutter up i8253.c with #ifdef CONFIG_HYPERV.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
Changes in v2:
* Fixed commit message and comment in the code to indicate
  that the PIT continues to interrupt @18.2 HZ, not every
  18.2 seconds. [Dexuan Cui]

---
 arch/x86/hyperv/hv_init.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 7abb09e..514fcbe 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -32,6 +32,9 @@
 #include <linux/slab.h>
 #include <linux/cpuhotplug.h>
=20
+#include <linux/io.h>
+#include <linux/i8253.h>
+
 #ifdef CONFIG_HYPERV_TSCPAGE
=20
 static struct ms_hyperv_tsc_page *tsc_pg;
@@ -97,6 +100,26 @@ static u64 read_hv_clock_msr(struct clocksource *arg)
=20
 u32 hv_max_vp_index;
=20
+#if defined(CONFIG_CLKEVT_I8253)
+/*
+ * Hyper-V emulation of the PIT has a quirk such that the
+ * normal i8253 pit_shutdown() routine doesn't stop the PIT.
+ * It keeps interrupting @18.2 HZ.  This alternate
+ * shutdown routine mirrors the normal one, but does not
+ * set the counter value to zero.
+ */
+static int hyperv_pit_shutdown(struct clock_event_device *evt)
+{
+	if (!clockevent_state_oneshot(evt) && !clockevent_state_periodic(evt))
+		return 0;
+
+	raw_spin_lock(&i8253_lock);
+	outb_p(0x30, PIT_MODE);
+	raw_spin_unlock(&i8253_lock);
+	return 0;
+}
+#endif
+
 static int hv_cpu_init(unsigned int cpu)
 {
 	u64 msr_vp_index;
@@ -325,6 +348,14 @@ void __init hyperv_init(void)
 	if (cpuhp < 0)
 		goto free_vp_assist_page;
=20
+#if defined(CONFIG_CLKEVT_I8253)
+	/*
+	 * Override the PIT shutdown routine due to a quirk in
+	 * Hyper-V emulation of the PIT.
+	 */
+	i8253_clockevent.set_state_shutdown =3D hyperv_pit_shutdown;
+#endif
+
 	/*
 	 * Setup the hypercall page and enable hypercalls.
 	 * 1. Register the guest ID
--=20
1.8.3.1

