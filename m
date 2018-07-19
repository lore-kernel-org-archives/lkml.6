Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E3E9ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1869720671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="WW+gaRZ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1869720671
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731190AbeGSJWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 05:22:25 -0400
Received: from mail-hk2apc01on0120.outbound.protection.outlook.com ([104.47.124.120]:56685
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727335AbeGSJWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 05:22:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BIjSucO0YRi2MJkHgoEtuRSga0DjM7JJ6IpAIpZXwfU=;
 b=WW+gaRZ6dwTa8uNcqbuoBcL8FEK0BKtwwFUJiK1IoYmwhJpBmK6/D+U7htc8fxvHoyczukAVzvErC2IqTf0fxwNPVF7+LQGaMUX9dZxUQfNUba2ejn2WQtE+q/vwIkzfeSKxJvSxdZYxSVhgy+aYh5MtfNyUm1DWBSa7GMkAHaw=
Received: from SG2P15301MB0093.APCP153.PROD.OUTLOOK.COM (10.170.136.145) by
 SG2P15301MB0095.APCP153.PROD.OUTLOOK.COM (10.170.136.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.10; Thu, 19 Jul 2018 08:40:12 +0000
Received: from SG2P15301MB0093.APCP153.PROD.OUTLOOK.COM
 ([fe80::f916:a637:8730:be25]) by SG2P15301MB0093.APCP153.PROD.OUTLOOK.COM
 ([fe80::f916:a637:8730:be25%4]) with mapi id 15.20.0995.008; Thu, 19 Jul 2018
 08:40:12 +0000
From:   Tianyu Lan <Tianyu.Lan@microsoft.com>
CC:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>
Subject: [PATCH V3 2/4] X86/Hyper-V: Add hyperv_nested_flush_guest_mapping
 ftrace support
Thread-Topic: [PATCH V3 2/4] X86/Hyper-V: Add
 hyperv_nested_flush_guest_mapping ftrace support
Thread-Index: AQHUHzwbbSSlNpGjb0y3hSCPkT74tg==
Date:   Thu, 19 Jul 2018 08:40:12 +0000
Message-ID: <20180719083946.121493-3-Tianyu.Lan@microsoft.com>
References: <20180719083946.121493-1-Tianyu.Lan@microsoft.com>
In-Reply-To: <20180719083946.121493-1-Tianyu.Lan@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tianyu.Lan@microsoft.com; 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SG2P15301MB0095;6:uVb8aG0NJMEj1qm/G7H3Yvhrc0GxVOP4Gz2qgFSdokT2p6svU/ZGVG/bOUuia8OTm50ViuviNP9xKpbmZmCz4lKA14xJ1xVab+J9bpo3REexkNXknHUJZ/eP+GEMyPjfC7s+YmMrSB6vbOdvgzg1OfBycMN8bbWJYR9XRJUSXWFBPB9TEdSDLo/ldolo6IhaFSgWK2fF2VeT+1Npu61jPSvriAW6JHhqhXwrNxMZI5yGHerVkBDDa2+fLz0VkfITQqw8Kd2o7D0FRAeWIjvd1Ag00zazxJQLEmJLFt+jCvwtF0XduSFJFw9Vde22RUsUvak+To28w+0sCpBBFVG46p79UjT5Ytyktn0O8yI8GHZqll7j0Ckfl14Mi7g43PkcA4WoyyIauJACZxH2Z1n/TUcr+W7LTL1azTzOA/G0Uv/fiugPgpXUDxOcg1jq4GZtpmQHn7vX2FVMy2AmGxa0Xw==;5:czWm4OQTe2V8qefOB2CCaMZoL8SEvpjELsesm09sw4BO23zowPQfIN5b5oqkmhFZCQD2Dwf73vxL3cqD6ijtvgNoGP2uXnLXLtzn854eONM7MMotngIBlO90UCkA69wqCLI+RPayNEY1HPGI7ErIrlpFV98E+K6aMeJp3j5+lWM=;7:ycyCsVMdxKTVVkkunQRSixk2lNQ7iBJpICoLiRQ4Cu4+6IZwvD2UtrXyvz2iKSBDE8PlnUVo9gFnzWDPj6M65b3IFDlWeiSmMDvzx180/bzynSc1OY/AQMk50v7yYJgJbE3qxET1rQrG7wGh+vMqfKUA8P2/ko7NlIOaau2AjBbMsclB4uqXrrA3627LKG6hgyE0b4VpU5H69Q1SwI62ub7yE0xx63vLlihsNpbfuHzaWjLxiPFYxxA3yZDQS8z8
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 2bcd496a-1f73-4306-3614-08d5ed533e80
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(2017052603328)(7193020);SRVR:SG2P15301MB0095;
x-ms-traffictypediagnostic: SG2P15301MB0095:
x-microsoft-antispam-prvs: <SG2P15301MB0095695E0F184FD744FFFFFE92520@SG2P15301MB0095.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:SG2P15301MB0095;BCL:0;PCL:0;RULEID:;SRVR:SG2P15301MB0095;
x-forefront-prvs: 0738AF4208
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(396003)(136003)(376002)(346002)(189003)(199004)(99286004)(22452003)(2900100001)(86612001)(66066001)(316002)(86362001)(72206003)(2906002)(68736007)(478600001)(486006)(97736004)(109986005)(2616005)(10290500003)(53936002)(1076002)(446003)(11346002)(476003)(36756003)(10090500001)(1671002)(256004)(106356001)(6436002)(105586002)(6486002)(102836004)(5250100002)(6506007)(3846002)(7416002)(5660300001)(6116002)(59246006)(4326008)(305945005)(54906003)(7736002)(8936002)(81166006)(81156014)(8676002)(6512007)(76176011)(26005)(14454004)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:SG2P15301MB0095;H:SG2P15301MB0093.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 9JZQgSP6ly5RVWbNPqcG3VAIpVA6tVVl/GhvbpjriOyAbmzGtzdcQ+6EeJlSPOumdrIPKNChmnOyM2KAkNCrzsGjz6jVmktNFT24QnSGqlY3iMOdrf+EacImv81swYsaiC9vLzR3pp8QQopZ7pGC0F8glbddi+YTF3sRfOnmYv56RoKb/NKkbkzA+DhjzYQCmPGylJBtakGqDcA6fkhFmyrSN30QciJ8EG5KWEAOR9Yciv0Wtom+QUiGzw+iX94GGy3cjSayPbhiImb/9V0tcKDOHbsX39DE3jpT+KVIk+iJpp/ePxo6p3ZtQsi1uGBQF0OXfj/CUWC0XIGftqxUA8icCuOSWSjdZzrcmVqClcs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bcd496a-1f73-4306-3614-08d5ed533e80
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2018 08:40:12.4277
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2P15301MB0095
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
