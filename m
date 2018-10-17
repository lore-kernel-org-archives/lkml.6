Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23952ECDE39
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 16:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA5C22145D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 16:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="eI4D1xUJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA5C22145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbeJRAwc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 20:52:32 -0400
Received: from mail-sn1nam01on0110.outbound.protection.outlook.com ([104.47.32.110]:21906
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727053AbeJRAwc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 20:52:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LcwMSzhpZu2DRsKxAgOLvnru2XqPRfuJfdhesGQQKAg=;
 b=eI4D1xUJpqSEbqXii+Rzu68/Da4mGJP5RyOrrWZVbVH+AlsYdYdeTMQNzXbaH1F36J3UVckWuoIZ6TTp5NQsF8BnkduJ1+fDXJ36HISMbPSeFq7W+JiVnkSqhVjXBhHGHnEU/CN1a8J4o3A6NU5C591N3Tzv/sBglXs52omyzWM=
Received: from MWHPR21MB0766.namprd21.prod.outlook.com (10.173.51.20) by
 MWHPR21MB0864.namprd21.prod.outlook.com (10.173.51.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1273.2; Wed, 17 Oct 2018 16:55:16 +0000
Received: from MWHPR21MB0766.namprd21.prod.outlook.com
 ([fe80::1982:5e59:2489:88e6]) by MWHPR21MB0766.namprd21.prod.outlook.com
 ([fe80::1982:5e59:2489:88e6%14]) with mapi id 15.20.1273.008; Wed, 17 Oct
 2018 16:55:16 +0000
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
Subject: [PATCH char-misc 1/1] x86/hyperv: Fix PIT shutdown quirk
Thread-Topic: [PATCH char-misc 1/1] x86/hyperv: Fix PIT shutdown quirk
Thread-Index: AQHUZjot/0c0fZteAkGdKEI9fZzBDg==
Date:   Wed, 17 Oct 2018 16:55:16 +0000
Message-ID: <1539795298-11804-1-git-send-email-mikelley@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR22CA0046.namprd22.prod.outlook.com
 (2603:10b6:300:69::32) To MWHPR21MB0766.namprd21.prod.outlook.com
 (2603:10b6:300:76::20)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [131.107.159.136]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR21MB0864;6:at8W7JuyHbHP78eS0qzVU61doHbS5aFBHnn+gS5zoaP9BjUUmfKR75rZnjsxrvFATRZRsBqhuZuM1cqRw0nIiblw7sPL9ghQfsLk/pGQCi0Kc2jNoa2aEG9ZeGEjIoqBj2+ysZ0XCu6zI527Jw7dMmcxtCKs/qNazkgL0BmNLZevkpEpTBpfB0dqCgLm5on42TpH+sAEDqameIEwq4Qxk/9dSY+AMZmWp1uyZDzfZyRMs7szX9qG+RXUhxdJrV5g6ZnmjuGKwE67g5sMhnsEDP427Z85rVqYK9r+HKCQ/A8+GE0Z1wsQTptk+Nb5lzmdk9gYfRq0XbdWEF3W1a6kfrMrG4+XrYj7r8daA9/k74W83MqGed9lkatY0ViUdPBrEvMAWesslCSp2c1dhLCUYjmMKmN1SPZku8NJz+4W4AH2BuYLm5zwg1uTns+tpBH+x/GUYwYBr4zHNqS5IqT9Bw==;5:7U3lcDeghBnx9R+xHZ9SoxChGsJyMvv7YT9wWFTX/Y18/5TnfYcuPspTJP9O8RxPvBC8px5xrpNp1EnBzbwjXMsxEKHrK4khD/QwLfcske60Vf2JL6Ho7NlEKQJFay3P1jaxCKrPDCV0WFlZAg1Y/9JbP4vKtukFZzo6Tv1Bxk4=;7:mSl6DS0u5IR6WzzGh6iTldavFOVgPkylLF+4LcXTQxLQUWb/c+9HOnP5PhEZ1NEe5R9pOJ6IG0aXH2Uj57nFhVhdDCMEtTjCYG/EWymotTyGEUHtovJ6rOGsew6VlsUEBdOE6sLvHQ0//ylbIQvwiQ==
x-ms-office365-filtering-correlation-id: 4c118daf-2e1d-4e1b-4142-08d63451500d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MWHPR21MB0864;
x-ms-traffictypediagnostic: MWHPR21MB0864:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-o365ent-eop-header: Message processed by -  O365_ENT: Allow from ranges
 (Engineering ONLY)
x-microsoft-antispam-prvs: <MWHPR21MB0864DECF0531B70A2C80139BD7FF0@MWHPR21MB0864.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(788757137089)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:MWHPR21MB0864;BCL:0;PCL:0;RULEID:;SRVR:MWHPR21MB0864;
x-forefront-prvs: 08286A0BE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39860400002)(396003)(136003)(376002)(199004)(189003)(6512007)(110136005)(52116002)(86362001)(97736004)(6436002)(10090500001)(36756003)(2201001)(99286004)(86612001)(53936002)(66066001)(5660300001)(1511001)(2906002)(3846002)(6116002)(478600001)(10290500003)(14454004)(4326008)(107886003)(6636002)(5250100002)(25786009)(2501003)(7736002)(305945005)(256004)(7416002)(8676002)(14444005)(71200400001)(81156014)(2900100001)(71190400001)(81166006)(68736007)(22452003)(316002)(8936002)(2616005)(186003)(476003)(106356001)(6346003)(26005)(486006)(386003)(105586002)(6486002)(6506007)(102836004)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR21MB0864;H:MWHPR21MB0766.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-microsoft-antispam-message-info: wW6xv7l+cXw8cqGLfaldTkGHjZm4Xy1gSVorcrfWNxEyIxbnKRQUWaz9yG8KkuaTs1QVmJThjHFD25at7iml3K4GhOJrVWZ5UawBv1DWi7m+uLG9Mk0KL0fU5wbTdk34yUUfRqQIM/KrkJeWEHkvFvRcNtzaHHlghiR1TasAMYR6qoa0FzoEg2/JZuqogd2yeFzdVKYokWyXEh9GoSEmJp0/tJ5+m6ut9HEKgZ56uBRm/W9pHOJTvjARtcw7F2LaR2zfcn62z1H7yZD0FAlO2hZYpEmOZvrFZE53ngwoiaV2Hiwyn77duz80/59dM+oa5ze8qAtJjr/HbNyxxFoj3Jie6ZqVuUD3snbn/7LoeaU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c118daf-2e1d-4e1b-4142-08d63451500d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2018 16:55:16.1107
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0864
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pit_shutdown() doesn't work on Hyper-V because of a quirk in the
PIT emulation. After shutdown the emulated PIT continues to interrupt
every 18.2 seconds. This problem exists in all versions of Hyper-V
and just had not previously been noticed. So replace the normal PIT
shutdown function with an alternate version that works on Hyper-V.

The alternate shutdown function could go in the i8253.c module,
but it seems better to keep the hack with the Hyper-V code rather
than clutter up i8253.c with #ifdef CONFIG_HYPERV.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 arch/x86/hyperv/hv_init.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 7abb09e..54326af 100644
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
+ * It keeps interrupting every 18.2 seconds.  This alternate
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

