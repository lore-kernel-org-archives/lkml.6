Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF60ECDE44
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 03:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03C062085A
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 03:49:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="NszAA49Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03C062085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729061AbeKDNCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 08:02:23 -0500
Received: from mail-dm3nam03on0116.outbound.protection.outlook.com ([104.47.41.116]:54496
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728653AbeKDNCX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 08:02:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RiDcCoPaxEV/T9OzM7HPh/VVITlVijpvG7KpNc4/Dfc=;
 b=NszAA49YTabvM6egrgOIrftKKXGiupc2aKFP8xl1w9SSb/ozFCrxAV9dXz8wXDhg+ZlRubGzmv5seaKRw2isdOFJcf+RpDCvG/bU3ExSruqKdYqiMCvJxbaFx0D0onhVqL5CLhQZs+XeTTxn6rgItXPtlCIuLngVM5ocNM0yrD8=
Received: from MWHPR21MB0766.namprd21.prod.outlook.com (10.173.51.20) by
 MWHPR21MB0864.namprd21.prod.outlook.com (10.173.51.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1294.3; Sun, 4 Nov 2018 03:48:54 +0000
Received: from MWHPR21MB0766.namprd21.prod.outlook.com
 ([fe80::1982:5e59:2489:88e6]) by MWHPR21MB0766.namprd21.prod.outlook.com
 ([fe80::1982:5e59:2489:88e6%14]) with mapi id 15.20.1339.000; Sun, 4 Nov 2018
 03:48:54 +0000
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
Subject: [PATCH v2 1/2] i8253: Add support for PIT shutdown quirk
Thread-Topic: [PATCH v2 1/2] i8253: Add support for PIT shutdown quirk
Thread-Index: AQHUc/FO73UJe7M61EmTMTTaOftmVw==
Date:   Sun, 4 Nov 2018 03:48:54 +0000
Message-ID: <1541303219-11142-2-git-send-email-mikelley@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;MWHPR21MB0864;6:WlkLtmsDMp3E7OZAhHLoNX4iqGTWflzUnTogIlRhE++ULonhCTEZOSrOeG4f706yedI7NHB+2KMfN6nnjl5BptJLZ2nRcYnFjkI73hW0SjvOSwzjJ+8ny6W89LqV6kllZHbSy3G1kmKcXMlqPr9PEh5sS8dZwIrJzh3+Y7Lvn2V7kLrPwnC068velvDIJu18rr+ZMMT/2VRKbGpsuw9EhfttvXRhru5rn8yov6pBdkH1YUqqhGWFcVSIQZkiA+IioApool3hJO+FkAIvsW9YDI9ZcmSsZQ3Jqpf5OVVcgdW8OQZguX9UUavNcOuX9OQL61Rzzoe7UBd4VhmDo8IxhObZjRrS/nBC4lHEdDfl6+zYyT8kvzavJ7r3zY7BkquDwm5sTAW3MVjIcttex382PSHjMvc6EPHpE93ENhC4dta/UtJ8RLmLfzmdJ1MWp2SzqI9JGumvDcCW+M1oTcA4PQ==;5:S71zQEaa1HsyN6kja1I/1pcxhJpdG7Ql7Wm1g+znRtOBce5BLg3FRc/rC+NTM/f/mcBx99akHuWh49aPoIyMi4YmxECTeO50wbeCMYXYOVk2uopcj9bPNl9vnY7xd7oUAzfuyuMsE/UxfmhG8BwMzDIT+h3TPxCJd4SHpS24swo=;7:TRjq97KHgqbF7BXadBmEKzRYEYeopzrzHD2Y0gS5PQuSjg1EpJ0uiUxC0Uyq/Fw+VcDWRE16STpb1T53FHv4YunzywOFATc8aPBIEBUvEwY2a/jAkhU5CrqRa3Clw5X9I2b3CSp3Lo3wb6sjZJfqNg==
x-ms-office365-filtering-correlation-id: 5fc5dd8c-5daf-473b-d171-08d642087132
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:MWHPR21MB0864;
x-ms-traffictypediagnostic: MWHPR21MB0864:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-o365ent-eop-header: Message processed by -  O365_ENT: Allow from ranges
 (Engineering ONLY)
x-microsoft-antispam-prvs: <MWHPR21MB08647FAB012B220CA2BD6524D7C90@MWHPR21MB0864.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(8220035)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231382)(944501410)(52105095)(2018427008)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:MWHPR21MB0864;BCL:0;PCL:0;RULEID:;SRVR:MWHPR21MB0864;
x-forefront-prvs: 084674B2CF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(136003)(39860400002)(366004)(396003)(189003)(199004)(6512007)(107886003)(66066001)(4326008)(53936002)(86612001)(25786009)(2906002)(5660300001)(7416002)(14444005)(1511001)(14454004)(6116002)(7736002)(110136005)(36756003)(305945005)(3846002)(105586002)(2501003)(106356001)(71190400001)(71200400001)(11346002)(2900100001)(102836004)(486006)(476003)(2616005)(6506007)(26005)(22452003)(10090500001)(386003)(81166006)(81156014)(446003)(8676002)(8936002)(99286004)(256004)(6486002)(478600001)(86362001)(6436002)(97736004)(10290500003)(316002)(76176011)(6636002)(52116002)(68736007)(186003)(2201001)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR21MB0864;H:MWHPR21MB0766.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: tKiooOVEqZqWHDlN1MUHS9HzB5syqo+v/FqOTwOSsCSVXolHKcc542nnoZ4Kn84ft/ZginFKtzqMBDygQvs6H1BobersOFu0VwOuZK/Fk8Ko9G8xrPsGAoet143JtBOkg3+HcjsPXbeBKYtNJjWs8m1pTl1o6rYhV7bRdbKnx7RKjSXxAWRNh6nZqjbMxqnWGWNX/LHTORgiy0f+dHWMQdQDvsiMgl/rEvgL3W/Z95igOfIErskmLObS8tw89A53BcMVQp7Nbkk56zyoO1FJGWk7STqrUOzJMhbJ6tBQA3dbE/zirPMjFkU3Awf0WwQs1uYB6EQpdBd+dW+crZgIyjTA05wXdiqiPzFDMqrt/rc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fc5dd8c-5daf-473b-d171-08d642087132
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2018 03:48:54.7862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0864
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for platforms where pit_shutdown() doesn't work because
of a quirk in the PIT emulation. On these platforms setting the
counter register to zero causes the PIT to start running again,
negating the shutdown. Provide a global variable that controls
whether the counter register is zero'ed, which platform specific
code can override.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/clocksource/i8253.c | 14 ++++++++++++--
 include/linux/i8253.h       |  1 +
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/i8253.c b/drivers/clocksource/i8253.c
index 9c38895..2a4202a 100644
--- a/drivers/clocksource/i8253.c
+++ b/drivers/clocksource/i8253.c
@@ -20,6 +20,13 @@
 DEFINE_RAW_SPINLOCK(i8253_lock);
 EXPORT_SYMBOL(i8253_lock);
=20
+/*
+ * Handle PIT quirk in pit_shutdown() where zeroing the counter register
+ * restarts the PIT, negating the shutdown. On platforms with the quirk,
+ * platform specific code can set this to false.
+ */
+bool i8253_clear_counter __ro_after_init =3D true;
+
 #ifdef CONFIG_CLKSRC_I8253
 /*
  * Since the PIT overflows every tick, its not very useful
@@ -109,8 +116,11 @@ static int pit_shutdown(struct clock_event_device *evt=
)
 	raw_spin_lock(&i8253_lock);
=20
 	outb_p(0x30, PIT_MODE);
-	outb_p(0, PIT_CH0);
-	outb_p(0, PIT_CH0);
+
+	if (i8253_clear_counter) {
+		outb_p(0, PIT_CH0);
+		outb_p(0, PIT_CH0);
+	}
=20
 	raw_spin_unlock(&i8253_lock);
 	return 0;
diff --git a/include/linux/i8253.h b/include/linux/i8253.h
index e6bb36a..31c4be5 100644
--- a/include/linux/i8253.h
+++ b/include/linux/i8253.h
@@ -21,6 +21,7 @@
 #define PIT_LATCH	((PIT_TICK_RATE + HZ/2) / HZ)
=20
 extern raw_spinlock_t i8253_lock;
+extern bool i8253_clear_counter;
 extern struct clock_event_device i8253_clockevent;
 extern void clockevent_i8253_init(bool oneshot);
=20
--=20
1.8.3.1

