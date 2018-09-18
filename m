Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F2FECE561
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 03:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8A7621471
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 03:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Nk7+VaA2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8A7621471
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729327AbeIRItY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 04:49:24 -0400
Received: from mail-sg2apc01on0120.outbound.protection.outlook.com ([104.47.125.120]:31264
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729295AbeIRItY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 04:49:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SDwoascmo2Fss6i5JqYmFXnB+jAGFa+93djY0ltVWRo=;
 b=Nk7+VaA2prJC+fG01kdy2emJKLlkM7OuAW7hXGPkPwFcSvIJd1ZST8vFe4+AkCm7cOigUnkcUPbKO4VdCzoFdH+NaNJxl4JmTy8VRLZYLHvnUDIARNuz9rWjfGjBx0s8liFQ9RP5SGF86vwfNEQ63dKz9pn/fVtjwBGcst6+ZDw=
Received: from HK0P153MB0129.APCP153.PROD.OUTLOOK.COM (52.133.156.18) by
 HK0P153MB0180.APCP153.PROD.OUTLOOK.COM (52.133.212.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.5; Tue, 18 Sep 2018 03:18:49 +0000
Received: from HK0P153MB0129.APCP153.PROD.OUTLOOK.COM
 ([fe80::8584:ad93:130a:6267]) by HK0P153MB0129.APCP153.PROD.OUTLOOK.COM
 ([fe80::8584:ad93:130a:6267%3]) with mapi id 15.20.1185.006; Tue, 18 Sep 2018
 03:18:49 +0000
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
Subject: [PATCH V2 6/13] KVM/MMU: Flush tlb directly in
 kvm_mmu_zap_collapsible_spte()
Thread-Topic: [PATCH V2 6/13] KVM/MMU: Flush tlb directly in
 kvm_mmu_zap_collapsible_spte()
Thread-Index: AQHUTv5RfX4mHpJcVUO/sHh/EVOEwQ==
Date:   Tue, 18 Sep 2018 03:18:49 +0000
Message-ID: <20180918031754.113013-7-Tianyu.Lan@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;HK0P153MB0180;6:9sfHHTglLtFTWF7OOrFZWiViCWoQ8RMweHDDlGBWl1HjLFJlvNVBPgmGUPnQMfNDdP1A5q7ZXCtwYem1xRovMNBKCetZQ+Jy8EQWk54OjWfIourU2QETVkT5PHk7Fz4gu+dIcPV3zY6H0815aIq123cDnTfPYAx0+D24PR1jVc1UmIlLZ3yO591kU0Byvn8c2mrC1UUsmX6kOcFrmU7XfPKxwOwnBAx7c4vw6Hrl5FY2uHdxQj9eDaAKjhgcmF4iwyGP25t64WhhjKsxRNvEMxUQn6E7rGOYqnd2sY0NX1eWACZMO5PKIL5sOJi3xkzv4Orn6gXvPpA2ftQdxAfYOAMalQhKseY5RUNzA3YMuyRqRPk+L1CVZbQZovlthcywUKiEFIusue1RUhcsXujAhDnsqCzZ1+GxvIBMODL+4Q2hYr4L12xpw9+8CfM25K/knGMFi9iA0rbDefAWV4uDRw==;5:58E0UvuzRf2YRLtBdAKTw6t8bvNMH019K7HvfCmqO9w4zy0tnKuUWl3Dw17iLlW2Zd07GMm53GUy3v26BXhAUZ6zrwRkcNJCyNX5A9LVbtF6SiBOZGHhHZsL6emaqfYZ5299IFYKzAp7Rsaui5XiViIv8WWjk7jK37JBgGM8Vv8=;7:swTIQ00URVGWC5NyjWW6PPj0kVyB6IV9XtEXo9h0cDdGcnENrj3pUBivtp5slakDB2Gv4W/KLyDeE5620aCnOrA36xvqoCbNhcGYueWRnBVxn674gTLNBl/Dl2NVTLdo7u9P5OA6yST5dBfwovHSERfKpwhAR+sj2WCRu9SddW5CUD08YpPEnpxC7mUd3G6kqT6+1GLXEHJ6yLHOGLRDslyIDN9Fj1TxxKifLNPAXOeMQZzsk393axNx90uVo5od
x-ms-office365-filtering-correlation-id: 400a0ea3-2183-40d1-f7e8-08d61d157404
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:HK0P153MB0180;
x-ms-traffictypediagnostic: HK0P153MB0180:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <HK0P153MB018011617525A8F59D07D466921D0@HK0P153MB0180.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699050);SRVR:HK0P153MB0180;BCL:0;PCL:0;RULEID:;SRVR:HK0P153MB0180;
x-forefront-prvs: 0799B1B2D7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(396003)(39860400002)(346002)(136003)(199004)(189003)(26005)(102836004)(2906002)(7736002)(6506007)(22452003)(59246006)(54906003)(316002)(14454004)(86362001)(86612001)(36756003)(575784001)(6436002)(10090500001)(6486002)(6512007)(305945005)(7416002)(53936002)(2900100001)(5250100002)(14444005)(256004)(97736004)(72206003)(478600001)(106356001)(8676002)(81156014)(81166006)(5660300001)(8936002)(6116002)(3846002)(99286004)(76176011)(10290500003)(1076002)(105586002)(476003)(2616005)(11346002)(446003)(66066001)(486006)(107886003)(25786009)(109986005)(68736007)(1671002)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:HK0P153MB0180;H:HK0P153MB0129.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: adOcX8L24KMbRXXDUAurMgOMh7fuBMXzYZNhEMsV6xnSpLPJhvIrqk9zv6Uz69NPbXL6Ohs06UjFlL7kFQUFhHBjJZF2bjaWjFEgWUlV3Fs1UHsyjHXWg1137byKZV3/r0iXKX5gR+NedA5KNeP5qOANdvnWsMlsCn3wr3f8yQwnF3hp0JinbphNbRAT2cYqT2uddYs2u37oAuEA5zcZuFZeLZC/+SLOc5mQLQCNlENVuo4tW3ekh0jsjZ4LTLZxvrjngJwtauTgliFm2uld9SqkSjEA6oRUQ991J/xqEQF8DxukMrlitzuGO0TB87A+CsInZMCN556uqdUjA5TdxNhAlQ2cvObXis3fICuA3iI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 400a0ea3-2183-40d1-f7e8-08d61d157404
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2018 03:18:49.2801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0180
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kvm_mmu_zap_collapsible_spte() returns flush request to the
slot_handle_leaf() and the latter does flush on demand. When
range flush is available, make kvm_mmu_zap_collapsible_spte()
to flush tlb with range directly to avoid returning range back
to slot_handle_leaf().

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/kvm/mmu.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index 56538fa6c017..85a81a62e0a7 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -5674,7 +5674,13 @@ static bool kvm_mmu_zap_collapsible_spte(struct kvm =
*kvm,
 			!kvm_is_reserved_pfn(pfn) &&
 			PageTransCompoundMap(pfn_to_page(pfn))) {
 			drop_spte(kvm, sptep);
-			need_tlb_flush =3D 1;
+
+			if (kvm_available_flush_tlb_with_range())
+				kvm_flush_remote_tlbs_with_address(kvm, sp->gfn,
+					KVM_PAGES_PER_HPAGE(sp->role.level));
+			else
+				need_tlb_flush =3D 1;
+
 			goto restart;
 		}
 	}
--=20
2.14.4
