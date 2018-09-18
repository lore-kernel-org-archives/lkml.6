Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F99ECE563
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 03:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7B0A21473
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 03:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="hyt+p+WK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7B0A21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729245AbeIRItL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 04:49:11 -0400
Received: from mail-sg2apc01on0118.outbound.protection.outlook.com ([104.47.125.118]:35712
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729164AbeIRItL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 04:49:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kUIkP0dbvGAEkEDT+JUxkOYwN9NEOBRSAVtmOdgrT5g=;
 b=hyt+p+WK1YBxXS3hHpXDk8Q91wEudfc3N8UFp6JMYDwutuRMXrGr88xL6Eh3DyThZ3EaKIrJ81rL/MhZweksJoyWZWuTjo/RaL04tmuPyc6p5h/EqJOkpYVmLM4kcfCWI15hQFOV5ESQFT/0t3tQgAvkTaKN0LQ/iSAqffZ7d/M=
Received: from HK0P153MB0129.APCP153.PROD.OUTLOOK.COM (52.133.156.18) by
 HK0P153MB0180.APCP153.PROD.OUTLOOK.COM (52.133.212.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.5; Tue, 18 Sep 2018 03:18:36 +0000
Received: from HK0P153MB0129.APCP153.PROD.OUTLOOK.COM
 ([fe80::8584:ad93:130a:6267]) by HK0P153MB0129.APCP153.PROD.OUTLOOK.COM
 ([fe80::8584:ad93:130a:6267%3]) with mapi id 15.20.1185.006; Tue, 18 Sep 2018
 03:18:36 +0000
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
Subject: [PATCH V2 4/13] KVM/MMU: Flush tlb directly in the
 kvm_handle_hva_range()
Thread-Topic: [PATCH V2 4/13] KVM/MMU: Flush tlb directly in the
 kvm_handle_hva_range()
Thread-Index: AQHUTv5JxXHYarz6dEerAeTlEED0BA==
Date:   Tue, 18 Sep 2018 03:18:36 +0000
Message-ID: <20180918031754.113013-5-Tianyu.Lan@microsoft.com>
References: <20180918031754.113013-1-Tianyu.Lan@microsoft.com>
In-Reply-To: <20180918031754.113013-1-Tianyu.Lan@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tianyu.Lan@microsoft.com; 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HK0P153MB0180;6:iFmpc1/z0nsBBvJEsXz5A4yYtTWFKG3GWgEx+Y/U6Nvpt7QBcEiRzpDEr90fc8NcDsdCH0rrEHlR/E6EuDp6e8Ox7IgR2fiS+igftEPrV4zS2xX6nYkZSJAgdxZNXSxA+xC557ykh3POMqnn7uU8yrDIS5Lh9g+pfGQ4fcSoZbjdARb0Pyxcy4yduQe8EJh5WYXl3ObG9n10DZMVQHCK9q50+u6EyAr8l3MI6DnnDK94+weC151U0Ly1CS1lXzXapisbhcmAxWf3iovuN/q5zmdrnFF/eKhhsPnP39HXM3lbIVT0MpclzBaMP7cIhIa1az6ouGJJ2cDT6xSbF0yuv3E/k1O+Mp625cvWFOMc4v6VOkt58WuzK4Ow+O1q5gB9GjF5MR/DwA93h4z8SAthJN7dDmm495i/wNeVBmIJJR7m9lS5x59GeJUKDVe66BMqFycy7g1E1EnIstA92tWilg==;5:ymJJONL7hh+K6T8TrLxyvP1C7jESIF3xXtugRZYq/RfFJh0m9rAK6OHbyUh0fMaIRI0nyBXBODiSEvN4MfR4asNYj37maiievRvaitcPExcOVc9uNW2tiTwkGZegOjEINzbTCX/jJ/gK7JVwr6yBW994RJv68KF5dazdZVJfG6k=;7:w81luQBuyjIthjPTqPNtksppvtETAMAaLmAnoCfDWccH4AQXi/lAvtvZuEgZf2lgOHxtHsyU5IMOWTWGc0q8wVYE7TlOdQZDyAhA8vQI/bkgZfHS3BxDWPxEcsfMer3tXg3hQHV4LjOMCszv40TalfjtHIin+qz1iqFj3IMgQ5AR50UQwbTot1/WJv6+VyyVK5AzbufpvH2yt0mQxxkAio9tY+3Hj0Hf57z1jJ9qcsYY6NDsFx/DT0CgcvYdKUQV
x-ms-office365-filtering-correlation-id: f4970031-ae39-41a4-9244-08d61d156c3e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:HK0P153MB0180;
x-ms-traffictypediagnostic: HK0P153MB0180:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <HK0P153MB018095BC29FD159EC3298F94921D0@HK0P153MB0180.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699050);SRVR:HK0P153MB0180;BCL:0;PCL:0;RULEID:;SRVR:HK0P153MB0180;
x-forefront-prvs: 0799B1B2D7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(396003)(39860400002)(346002)(136003)(199004)(189003)(26005)(102836004)(2906002)(7736002)(6506007)(22452003)(59246006)(54906003)(316002)(14454004)(86362001)(86612001)(36756003)(6436002)(10090500001)(6486002)(6512007)(305945005)(7416002)(53936002)(2900100001)(5250100002)(256004)(97736004)(72206003)(478600001)(106356001)(8676002)(81156014)(81166006)(5660300001)(8936002)(6116002)(3846002)(99286004)(76176011)(10290500003)(1076002)(105586002)(476003)(2616005)(11346002)(446003)(66066001)(486006)(107886003)(25786009)(109986005)(68736007)(1671002)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:HK0P153MB0180;H:HK0P153MB0129.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 5A9DJGoIO3oK3l3aecS66G2N2uutiktN1ov2xt4lBkgvYgxqHN+BFqPkV6nrA7S9sALvz1xytjrnm1SODJzxQwa9pIuLmjrlA3+re4st31B+5msbfIoIDrxPU6zWf0QRqydZWocakePIMK6THUCnNDR4IWNrrLdRLrWFyOGzGpOwQPT87F7Q5jrFiVhwZERNPUSRF3rAQ6efC1TXaOJbJGrjBjtOz7jBPI4e+xoR0+zw47LQ1DE4galRM4Tl4HXw/1NzFKOdBHtMlKjk8Tv5ERK7nZEA1nAQ1+OsnP6vWDqy6vTyaZxSE/E4OxokzZKV6Rleq8ZYWBWIakedgbbgGr4lohVEunqkPG6aoaToxVk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4970031-ae39-41a4-9244-08d61d156c3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2018 03:18:36.2289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0180
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is to flush tlb directly in the kvm_handle_hva_range()
when range flush is available.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/kvm/mmu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index 822e170881a4..dfd2a0710417 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -1888,6 +1888,13 @@ static int kvm_handle_hva_range(struct kvm *kvm,
 						 &iterator)
 				ret |=3D handler(kvm, iterator.rmap, memslot,
 					       iterator.gfn, iterator.level, data);
+
+			if (ret && kvm_available_flush_tlb_with_range()) {
+				kvm_flush_remote_tlbs_with_address(kvm,
+						gfn_start,
+						gfn_end - gfn_start);
+				ret =3D 0;
+			}
 		}
 	}
=20
--=20
2.14.4
