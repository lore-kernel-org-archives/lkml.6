Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5788EC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9F6220673
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="bkdoyOT1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9F6220673
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932996AbeGIJDH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 05:03:07 -0400
Received: from mail-sg2apc01on0122.outbound.protection.outlook.com ([104.47.125.122]:5127
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932869AbeGIJDF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 05:03:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BIjSucO0YRi2MJkHgoEtuRSga0DjM7JJ6IpAIpZXwfU=;
 b=bkdoyOT1gMuAhhrcZVqyhd/wwpGGEQ2X0Cr5t+w82IU/jLOcQcj0Nh73yyEQmXKHr6/G6SDV1p4i4CoBWiNQ0KMmWQ8ei97rFbdfvbKi/1ZxZjY4eYofTC7X5/bgxcdnJKfXRhv6CDKtHMVnR1tn1CZ3bqp6tLUh05od4Lq7Ze0=
Received: from SG2P15301MB0093.APCP153.PROD.OUTLOOK.COM (10.170.136.145) by
 SG2P15301MB0063.APCP153.PROD.OUTLOOK.COM (10.170.136.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.15; Mon, 9 Jul 2018 09:02:59 +0000
Received: from SG2P15301MB0093.APCP153.PROD.OUTLOOK.COM
 ([fe80::f916:a637:8730:be25]) by SG2P15301MB0093.APCP153.PROD.OUTLOOK.COM
 ([fe80::f916:a637:8730:be25%4]) with mapi id 15.20.0952.013; Mon, 9 Jul 2018
 09:02:59 +0000
From:   Tianyu Lan <Tianyu.Lan@microsoft.com>
CC:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>
Subject: [PATCH V2 5/5] X86/Hyper-V: Add hyperv_nested_flush_guest_mapping
 ftrace support
Thread-Topic: [PATCH V2 5/5] X86/Hyper-V: Add
 hyperv_nested_flush_guest_mapping ftrace support
Thread-Index: AQHUF2OidJAdl1qWTEKdMFUKzUQ8SQ==
Date:   Mon, 9 Jul 2018 09:02:59 +0000
Message-ID: <20180709090218.15342-6-Tianyu.Lan@microsoft.com>
References: <20180709090218.15342-1-Tianyu.Lan@microsoft.com>
In-Reply-To: <20180709090218.15342-1-Tianyu.Lan@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SG2P15301MB0063;7:Se8mgVJXmlQ91Z/1R1zouZbE5MQ/NlXoGPt8zKdMPhYRTKMaHwVAUcNfTUaRfpALLVW35EwfH7n1Mqrn8ZnC89a/WeAxuruFcVoxpNPIsprM4N9uwD5utg7cIp6BnSwEPvo6CO3VdVvydpg+qe/wH6bShSpv0bQ8lTSTjlsRz2C4o/lbMYEh8ZSyJcF5vDnz2FXLhFEik91RAQLIxK172qSf0K5k/22B8/PgPUYY6EaLhyT1UKwCWzaVM7hQ2tq/
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 8e20362f-6517-45c4-7bd9-08d5e57ac52a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(2017052603328)(7193020);SRVR:SG2P15301MB0063;
x-ms-traffictypediagnostic: SG2P15301MB0063:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tianyu.Lan@microsoft.com; 
x-microsoft-antispam-prvs: <SG2P15301MB0063F0665A20DE847847FBE992440@SG2P15301MB0063.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:SG2P15301MB0063;BCL:0;PCL:0;RULEID:;SRVR:SG2P15301MB0063;
x-forefront-prvs: 07283408BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(396003)(366004)(39860400002)(346002)(199004)(189003)(256004)(105586002)(76176011)(86362001)(6486002)(72206003)(66066001)(59246006)(86612001)(6512007)(97736004)(6436002)(2616005)(476003)(8936002)(486006)(14454004)(446003)(11346002)(81156014)(81166006)(8676002)(4326008)(109986005)(68736007)(25786009)(2900100001)(106356001)(6116002)(3846002)(1076002)(36756003)(5660300001)(53936002)(305945005)(7736002)(1671002)(5250100002)(54906003)(99286004)(26005)(102836004)(22452003)(10090500001)(10290500003)(2906002)(478600001)(6506007)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:SG2P15301MB0063;H:SG2P15301MB0093.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: yqyi79pxDYj0Zy4Mhi38BvCNmRVPEvPvMi8FH0ABASWKWliS+0Duefi0fQCWvxI7yVf70+jzxueGcZ8/cAYesmpa/mm60jU1h0pnsM3ob3e3b4o0lgCA9EGKHvf97MNJW+fzqtNTcDKaagySiBEz8l0DVRRZTp5ZFzytbK2aN/ISrCxqLJ3BaOncn5khKNdk1LyKJ4q81fY9YJgpMSm1TtSm151nSvLQJrDjhgODC+J/kfl9qNQswcK20MqArZAFfKQ2WhTvn1gxuno8D0fCiT7Xx7Uuhwe44YMuYtAivh/j5hATImXl/D2zX5HopYzGo8IZtkQXA2OkrBd+Z5MFV8SjSw4/AT9eojXURLLmJTw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e20362f-6517-45c4-7bd9-08d5e57ac52a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2018 09:02:59.4765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2P15301MB0063
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is to add hyperv_nested_flush_guest_mapping support to trace
hvFlushGuestPhysicalAddressSpace hypercall.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/hyperv/nested.c            |  3 +++
 arch/x86/include/asm/trace/hyperv.h | 14 ++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/arch/x86/hyperv/nested.c b/arch/x86/hyperv/nested.c
index 74dd38b5221d..42a3232f2835 100644
--- a/arch/x86/hyperv/nested.c
+++ b/arch/x86/hyperv/nested.c
@@ -25,6 +25,8 @@
 #include <asm/mshyperv.h>
 #include <asm/tlbflush.h>
=20
+#include <asm/trace/hyperv.h>
+
 int hyperv_flush_guest_mapping(u64 as)
 {
 	struct hv_guest_mapping_flush **flush_pcpu;
@@ -59,6 +61,7 @@ int hyperv_flush_guest_mapping(u64 as)
 		ret =3D 0;
=20
 fault:
+	trace_hyperv_nested_flush_guest_mapping(as, ret);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(hyperv_flush_guest_mapping);
diff --git a/arch/x86/include/asm/trace/hyperv.h b/arch/x86/include/asm/tra=
ce/hyperv.h
index 4253bca99989..e1ffe61de8d6 100644
--- a/arch/x86/include/asm/trace/hyperv.h
+++ b/arch/x86/include/asm/trace/hyperv.h
@@ -28,6 +28,20 @@ TRACE_EVENT(hyperv_mmu_flush_tlb_others,
 		      __entry->addr, __entry->end)
 	);
=20
+TRACE_EVENT(hyperv_nested_flush_guest_mapping,
+	    TP_PROTO(u64 as, int ret),
+	    TP_ARGS(as, ret),
+
+	    TP_STRUCT__entry(
+		    __field(u64, as)
+		    __field(int, ret)
+		    ),
+	    TP_fast_assign(__entry->as =3D as;
+			   __entry->ret =3D ret;
+		    ),
+	    TP_printk("address space %llx ret %d", __entry->as, __entry->ret)
+	);
+
 #endif /* CONFIG_HYPERV */
=20
 #undef TRACE_INCLUDE_PATH
--=20
2.14.3
