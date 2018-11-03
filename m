Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F31C0C32789
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 00:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABF0A2081B
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 00:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="HnvBPc2B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABF0A2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbeKCJYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 05:24:45 -0400
Received: from mail-eopbgr740122.outbound.protection.outlook.com ([40.107.74.122]:19124
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728425AbeKCJYo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 05:24:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4W9UD7cdopApr0UN/OFjoBfsCgpRFkb0QEJGEkm7mrQ=;
 b=HnvBPc2B5C6rpPcF+Qxia7/zkDuIExfFDpWlahTjHFws1WPcyODMUTCz9rjldqhGLtaDckK/ORKgZv8Mt1Wpc+G4lnCitwjrjPYXPrKzvvquwO9MjNkkB2PFwjDXKT/4e3m8B9KvPHeqmQhvTHTt4Nq7dIwJeocNsePPauau/Hs=
Received: from MWHPR21MB0766.namprd21.prod.outlook.com (10.173.51.20) by
 MWHPR21MB0704.namprd21.prod.outlook.com (10.175.142.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1339.2; Sat, 3 Nov 2018 00:15:22 +0000
Received: from MWHPR21MB0766.namprd21.prod.outlook.com
 ([fe80::1982:5e59:2489:88e6]) by MWHPR21MB0766.namprd21.prod.outlook.com
 ([fe80::1982:5e59:2489:88e6%14]) with mapi id 15.20.1339.000; Sat, 3 Nov 2018
 00:15:22 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "will.deacon@arm.com" <will.deacon@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        vkuznets <vkuznets@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>
CC:     Michael Kelley <mikelley@microsoft.com>
Subject: [PATCH v3 3/4] Drivers: hv: vmbus: Add hooks for per-CPU IRQ
Thread-Topic: [PATCH v3 3/4] Drivers: hv: vmbus: Add hooks for per-CPU IRQ
Thread-Index: AQHUcwpPYtVGcPtlUU6KwuL0rNVGHw==
Date:   Sat, 3 Nov 2018 00:15:22 +0000
Message-ID: <1541204037-18043-4-git-send-email-mikelley@microsoft.com>
References: <1541204037-18043-1-git-send-email-mikelley@microsoft.com>
In-Reply-To: <1541204037-18043-1-git-send-email-mikelley@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR2201CA0011.namprd22.prod.outlook.com
 (2603:10b6:301:28::24) To MWHPR21MB0766.namprd21.prod.outlook.com
 (2603:10b6:300:76::20)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [131.107.174.136]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR21MB0704;6:I7Pkze6DeEA96BW5xKrpYPm0/YajHh0FRn5MGU5OM+jJjpsbPWtcEkrAgoYB3vhPiYz/66quRIhkISOpnNPPrOscfUVFcmDHkugsdBMtPih+cumLMR14AFcaanG9SvhGrJ3f3Li3q2kC1pFZguKIT7KOBuv2zGZ3NRQuWlvfDLX6LDtPAX8t6jbIcOH70BFi3r5Tp0wxvstSjnrFj1aSdjW3si+lsgcDPVYeEwY05liQXnOQTwXBYQwCZq+lVtnmLtVzz9s6VTf1HwjBwq+TouQNGvlf8Ys70gQj6+UplOZSab5VHFycz48g/7iiu6o+RfPpTlQohLQSNIGnGEMN7iH9NKCXHvv8sJvkzQ/f9JIbfL3LhGuQN4q4t6b3BSFocklD7Qg5OkxNGRU07OQB1swqGpaQ10bsKPJKHEqEDRi8HZFSrHbULf9O+rMm8c7C/hSih0LrQ2kCjSsbfsoCUQ==;5:dyNwHUdcj44KKMpeBe81doihkouamQi46svKLj74+vu3FtvVElxOtI6NEKsfbRHTYKlDWPuLh6HcEJwnpi8OF7lx3H3w5EZD2FjBtCy+2rkpVnpYLl+b+M4BHwRIrILJkJun2z10BPxYHEcvQJHZrxwoag607xcRhPmyxGc12l4=;7:hQwTF5WiVRnVldr2YLXlc81E0UHuipDYqT/buQb2vKQz6u0CEAzfrXaPjodJHYst0BLNEM5/sm/520JlSjiLEOZXkTqX7REtsQOYcLXcIn5kaGkmDvXrYQkAsnHgWCwc32rTmFbIP0KkRM3fe+IpuA==
x-ms-office365-filtering-correlation-id: 6f6cdf60-56ef-4f34-55ec-08d641217208
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MWHPR21MB0704;
x-ms-traffictypediagnostic: MWHPR21MB0704:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-o365eop-header: O365_EOP: Allow for Unauthenticated Relay
x-o365ent-eop-header: Message processed by -  O365_ENT: Allow from ranges
 (Engineering ONLY)
x-microsoft-antispam-prvs: <MWHPR21MB0704A9F978845B2E63933288D7C80@MWHPR21MB0704.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(8220035)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231382)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:MWHPR21MB0704;BCL:0;PCL:0;RULEID:;SRVR:MWHPR21MB0704;
x-forefront-prvs: 08457955C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(346002)(136003)(396003)(366004)(189003)(199004)(14454004)(81156014)(81166006)(8676002)(8936002)(7416002)(305945005)(86612001)(7736002)(5660300001)(6116002)(105586002)(86362001)(2906002)(2201001)(3846002)(106356001)(97736004)(71190400001)(71200400001)(10290500003)(2900100001)(256004)(508600001)(4326008)(68736007)(25786009)(102836004)(66066001)(6486002)(6506007)(386003)(26005)(1511001)(99286004)(186003)(36756003)(22452003)(52116002)(76176011)(446003)(476003)(2616005)(110136005)(53936002)(6636002)(316002)(11346002)(10090500001)(6436002)(486006)(6512007)(2501003)(107886003)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR21MB0704;H:MWHPR21MB0766.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Zi5a4xUS0hPS2+AyC3JiWcL2qzVUt8+OlqajOTVLNhlXMSk0/KDsostDCpljhVm/ilVGw+YAB8XkzwNPYmj+SD0IuUyv2zXwwknAIimtpURePX3Lh/q5xivK+C3yxMfQvudCMW6sCLxVMYZpA29A2dmwARIo7LOm/RmkStizJsBb4M1aiE1rLovWrrUnmKw+ej+TNEf6QjUv6Mv+tvbbWwmaTC9Lrj6cRdn60LORr5E4tyxmnHN7b4AOQo69betTnIVx6gmLrbJNbx6uo5DedOiPM5M0u+rWBmsU8HO+gr2L+14pKuuClv3u4YkhwJnq75AGjPf6W8tvYwkAlwBHJ35T3Fg1eoSZNnDrAUpVMBE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f6cdf60-56ef-4f34-55ec-08d641217208
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2018 00:15:22.3941
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0704
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add hooks to enable/disable a per-CPU IRQ for VMbus. These hooks
are in the architecture independent setup and shutdown paths for
Hyper-V, and are needed by Linux guests on Hyper-V on ARM64.  The
x86/x64 implementation is null because VMbus interrupts on x86/x64
don't use an IRQ.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 arch/x86/include/asm/mshyperv.h | 4 ++++
 drivers/hv/hv.c                 | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyper=
v.h
index 0d6271c..8d97bd3 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -109,6 +109,10 @@ static inline void vmbus_signal_eom(struct hv_message =
*msg, u32 old_msg_type)
 void hv_setup_vmbus_irq(void (*handler)(void));
 void hv_remove_vmbus_irq(void);
=20
+/* On x86/x64, there isn't a real IRQ to be enabled/disable */
+static inline void hv_enable_vmbus_irq(void) {}
+static inline void hv_disable_vmbus_irq(void) {}
+
 void hv_setup_kexec_handler(void (*handler)(void));
 void hv_remove_kexec_handler(void);
 void hv_setup_crash_handler(void (*handler)(struct pt_regs *regs));
diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 332d7c3..5857208 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -309,6 +309,7 @@ int hv_synic_init(unsigned int cpu)
 	hv_set_siefp(siefp.as_uint64);
=20
 	/* Setup the shared SINT. */
+	hv_enable_vmbus_irq();
 	hv_get_synint_state(VMBUS_MESSAGE_SINT, shared_sint.as_uint64);
=20
 	shared_sint.vector =3D HYPERVISOR_CALLBACK_VECTOR;
@@ -438,6 +439,7 @@ int hv_synic_cleanup(unsigned int cpu)
 	hv_get_synic_state(sctrl.as_uint64);
 	sctrl.enable =3D 0;
 	hv_set_synic_state(sctrl.as_uint64);
+	hv_disable_vmbus_irq();
=20
 	return 0;
 }
--=20
1.8.3.1

