Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F06CFC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 03:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D412214FE
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 03:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="In9/OXyH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D412214FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbeI0KFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 06:05:52 -0400
Received: from mail-pu1apc01on0133.outbound.protection.outlook.com ([104.47.126.133]:32445
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727239AbeI0KFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 06:05:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K2CGbHgZQz9Q5WJeNWx/Rhg/k0ckXE/QkwWnYN4LLgU=;
 b=In9/OXyH57MS4wSg0p8fZOdFciCBSkrKxW+qwL6zbGIwBOv4uUIJ5PXKuLxFkT3WG6eiOm/JlY+7C0hblWsaxzW+9a3R2hzAuPZXspG0QcuO+7kkZVre5XlQxzvcBHIKwk7/wEOwOQXZt80cLYGO+P+M8br38WwOvkQEj2MAIC4=
Received: from HK0P153MB0129.APCP153.PROD.OUTLOOK.COM (52.133.156.18) by
 HK0P153MB0177.APCP153.PROD.OUTLOOK.COM (52.133.210.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Thu, 27 Sep 2018 03:49:30 +0000
Received: from HK0P153MB0129.APCP153.PROD.OUTLOOK.COM
 ([fe80::8584:ad93:130a:6267]) by HK0P153MB0129.APCP153.PROD.OUTLOOK.COM
 ([fe80::8584:ad93:130a:6267%3]) with mapi id 15.20.1207.011; Thu, 27 Sep 2018
 03:49:30 +0000
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
        vkuznets <vkuznets@redhat.com>,
        Jork Loeser <Jork.Loeser@microsoft.com>
Subject: [PATCH V3 7/13] KVM: Add flush_link and parent_pte in the struct
 kvm_mmu_page
Thread-Topic: [PATCH V3 7/13] KVM: Add flush_link and parent_pte in the struct
 kvm_mmu_page
Thread-Index: AQHUVhUYMpyLpDusNUO5O6sPkAmOSQ==
Date:   Thu, 27 Sep 2018 03:49:29 +0000
Message-ID: <20180927034829.2230-8-Tianyu.Lan@microsoft.com>
References: <20180927034829.2230-1-Tianyu.Lan@microsoft.com>
In-Reply-To: <20180927034829.2230-1-Tianyu.Lan@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tianyu.Lan@microsoft.com; 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HK0P153MB0177;6:4uzo3AI+dbJz6xJUBbr8pBKba0cqv8l2g9ojgf1fJiPSjUcQvtThyWiJ3us6S/xpLXIYKJnKPWDJQRgyjUiokpdrGKLE0DQ9v2hV8WxTRIDZdORYFnESf5p0l0WB8pUPT+GhlrVdU/C8qy3iqYhUBgsNIBsTsucfTHTKMG4UVIGvWVaqc59GOu/DyhFrE12dOQgKpUh45JgBJe5vGWc3XljQTiXY5DGGbENYhfnR3pHrC7PAv/CUXW3Qh8Xhph+WQWHHZSGs65AfbE9Sh+tAqFMY9I83WOiS4EaKlenA/A/4Xqwr+gKpLAfZMlmGB/p3FlvY/kH8yOlt7y90EjXcG5s/ywbDOqJhLCpbO3f0vzhQcap/4P6+uHuQVveJmyh2B+gfbUWdngm2UCrLyx+DNOHcwhxKUcYGmpChkvE4X2Q7yOdj3GWbrimKO5swoCjtW3rxUsGVjiE5AWEsAcfxjA==;5:j13Npsv+ffAJ+1GKxe2ZsD+1QZCrTr3FWrtg1C7xI9Aq1+BFDtT4DmE9iy9xtPKiibb5xuJkvjr4BaHaxQwpWi8/XHhuAap5OHFdcxrP3U1IWVINIPr4pO78jOsxVO5zIbygTcE1unV1+72l1olbVaWUDI9ICGxzhjXdvtnIX7E=;7:hsbkNMIsc/xukr4zhrE1g3BPWASLf/MZTZybmLt0SIWnsk37LyDCDioh+CbMbgMvo2W3ze1nCts+39YeWPspGfJhOfyDpNMQV0h3xPMzTT8AgcWISjmx08MQxtlf7uI74xObbhBVm92uYekbhkXcmDgxjDV/BJ6P5W/IkAS1ZkWx7AKSucmKWGFdZNV+WE9/PpRAzr4DigXrDzuh96UfSVZwFvqb0h91/5OpvFXAFV58Ty8LwaB9zDUPZ8OJ8TAu
x-ms-office365-filtering-correlation-id: 24768fb3-5f73-49fb-6a1f-08d6242c3ad6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:HK0P153MB0177;
x-ms-traffictypediagnostic: HK0P153MB0177:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <HK0P153MB0177FF6EA75518A218253E3D92140@HK0P153MB0177.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051);SRVR:HK0P153MB0177;BCL:0;PCL:0;RULEID:;SRVR:HK0P153MB0177;
x-forefront-prvs: 0808323E97
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(396003)(346002)(39860400002)(366004)(199004)(189003)(105586002)(99286004)(10290500003)(486006)(478600001)(68736007)(106356001)(14454004)(72206003)(81156014)(6486002)(8676002)(6506007)(1671002)(81166006)(6512007)(2900100001)(2906002)(6436002)(76176011)(8936002)(10090500001)(3846002)(6116002)(54906003)(36756003)(316002)(59246006)(102836004)(26005)(1076002)(5660300001)(5250100002)(109986005)(107886003)(11346002)(446003)(2616005)(4326008)(25786009)(476003)(22452003)(7416002)(53936002)(86612001)(86362001)(71190400001)(71200400001)(66066001)(7736002)(256004)(305945005)(34290500001)(97736004);DIR:OUT;SFP:1102;SCL:1;SRVR:HK0P153MB0177;H:HK0P153MB0129.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 8KFuSHqoWuUDN3T3l9SRAMEVcv5mzRgVheXvPExhiH7q5zuFWMg1TunUZwXVMce4GePULWr4pH/G/+cRQdsYZJvjrlQQyg7E5aKOJ4CuAlaJMPqdo+p7+ZS5A0xxjyKyFNu0zpCpj1NMJFAJMSLUp/yHUNT24SDbgBIub/CQpTDir+Iq3ccvEgjMTAMzRIEQBi0aLILlGeIWqrcH0xfvf/wJGKJ9sMLDfR2cfQebHtQYUVHHMwbvfV/69rwYo0An/Ilrf4tYloJ4Q7R/dg3t6zhGHN0VHB3eb5jxy8BAm0FPMx5NxLP16QEi8PHgY3r29Q/tvjLr1EELpdnnpn981g5/2+arx7CYj3SG+zucpfI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24768fb3-5f73-49fb-6a1f-08d6242c3ad6
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2018 03:49:29.9752
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0177
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PV EPT tlb flush function will accept a list of flush ranges and
use struct kvm_mmu_page as the list entry.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/include/asm/kvm_host.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_hos=
t.h
index a6b77978502e..c96bc4cbe4b7 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -279,6 +279,7 @@ struct kvm_rmap_head {
=20
 struct kvm_mmu_page {
 	struct list_head link;
+	struct list_head flush_link;
 	struct hlist_node hash_link;
=20
 	/*
--=20
2.14.4
