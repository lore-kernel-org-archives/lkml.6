Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA3A4C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 03:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87B6C2157C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 03:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="V3ZGxbOV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87B6C2157C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbeI0KFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 06:05:52 -0400
Received: from mail-pu1apc01on0101.outbound.protection.outlook.com ([104.47.126.101]:1824
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727197AbeI0KFu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 06:05:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=in+bxlhLEsEw5PpjrQuSOUz3RGnk29ihij3nOYzDzkY=;
 b=V3ZGxbOVckhWBojfGzd8wBKYVG12NYWNhZ0oGl70AfFFe3ZQB79q+EkX5ngXDbyfNCVWnnzz/Qy5jVYbeTuD5AMBk4uWJI80Pgw5uci9HcR5TCqOL/CggntZUdUxDg4aw7LXif4ctHE8YUQFDhYuixr8kzZtGOX9dbxeOjdN7SE=
Received: from HK0P153MB0129.APCP153.PROD.OUTLOOK.COM (52.133.156.18) by
 HK0P153MB0177.APCP153.PROD.OUTLOOK.COM (52.133.210.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Thu, 27 Sep 2018 03:49:23 +0000
Received: from HK0P153MB0129.APCP153.PROD.OUTLOOK.COM
 ([fe80::8584:ad93:130a:6267]) by HK0P153MB0129.APCP153.PROD.OUTLOOK.COM
 ([fe80::8584:ad93:130a:6267%3]) with mapi id 15.20.1207.011; Thu, 27 Sep 2018
 03:49:23 +0000
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
Subject: [PATCH V3 6/13] KVM/MMU: Flush tlb directly in
 kvm_mmu_zap_collapsible_spte()
Thread-Topic: [PATCH V3 6/13] KVM/MMU: Flush tlb directly in
 kvm_mmu_zap_collapsible_spte()
Thread-Index: AQHUVhUUlLu4KAfoC0Gs5wN3t5xGhA==
Date:   Thu, 27 Sep 2018 03:49:23 +0000
Message-ID: <20180927034829.2230-7-Tianyu.Lan@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;HK0P153MB0177;6:eIHJjB5OOmEVf24TE4gsoRD9PNCUbnqXDmGSt4ZS7FuJvtWHZiLxhUgcYZiG/mi3m13zmr49DlTq6t5ES7kkBqfQ9MigKosRf+efcYk713DcEwNscH/0QpT0+URRGXoeSz14fkjW/4UozTzr2/2y1I8yUBGrZyaydwA9AysM/djx3cdFQBBAQrm9Y7TPZCjO9zxp9WtwpztdpCFmU46S2fKuSlz9kLfZCqOy8Tw49Ds41w/6evFFLKtVLZ0KYL7je+Yq9yDzLXM66cGoCu0tD28PCFOFKfTKSFAFuC9o5sCXDvJheS3E9tU9zCfFTJc02lvtZn807ArTN8suXAf+lH80HA4XTp2dJBo/9F5lVNPvgT66XJnTE7tn7Plarl5azW3zSM8G6NHKOdhbL/akV47BhlF2a36gu34H3UFG0isVty1tsNvD/JqLJN9kqDSnr+HnyIqtYjNRjatk2lsSjg==;5:mjZdkj/YZbH3YQmDqUkrdLpaZksMk6A50AoKsRsX0lKLG5/peb9n1Pox3mup9IeyhYe6CgNjedaO73SF4gQ0HDU3xz40DKSDNxhEu8S/XXkcrjaTgSj9ZW90D3WFySvO6WmjrRy6+A5NPVhh/NIKeg0fXUQ84avzBeurENOArkA=;7:m24kkOCQN3/dmOLEAwOCyOA/OmYgKraBM76+w6iyGfSBgeAaoTaEfJWzcP8OxgInK0OztDduSYW7Tps/kAEBf2IIwH0ZBaAmvGKVfTiANhXqdPXxAtrWwCyEDQ8SjjbK/f1qdRJp6X/Wx4iJSygMYui8kAqNwVLPC/7FaTWnIM2zMp88Xd2sE7f4m5mRzIIa8CQndsJJQC0M/NOrluCplnmXmcatF1meesp8d8/7cINLBO+EYpUydiwNtR46B00E
x-ms-office365-filtering-correlation-id: 360271cd-4d25-45d1-46f9-08d6242c3700
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:HK0P153MB0177;
x-ms-traffictypediagnostic: HK0P153MB0177:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <HK0P153MB017708E5B23F881B24A0073092140@HK0P153MB0177.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051);SRVR:HK0P153MB0177;BCL:0;PCL:0;RULEID:;SRVR:HK0P153MB0177;
x-forefront-prvs: 0808323E97
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(396003)(346002)(39860400002)(366004)(199004)(189003)(105586002)(99286004)(10290500003)(486006)(478600001)(68736007)(106356001)(14454004)(72206003)(81156014)(6486002)(8676002)(6506007)(1671002)(81166006)(6512007)(2900100001)(2906002)(6436002)(76176011)(8936002)(10090500001)(3846002)(6116002)(54906003)(36756003)(316002)(59246006)(102836004)(26005)(1076002)(5660300001)(5250100002)(109986005)(107886003)(11346002)(446003)(2616005)(4326008)(25786009)(476003)(22452003)(7416002)(53936002)(86612001)(86362001)(71190400001)(71200400001)(14444005)(66066001)(7736002)(256004)(305945005)(34290500001)(97736004);DIR:OUT;SFP:1102;SCL:1;SRVR:HK0P153MB0177;H:HK0P153MB0129.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: SNsoLOwNAnTNNysIfv/d12BGCK6ZxINeOymGiIVgwcUs1YbCrvGhOb0iwmQ/iiO6KQFJ1Ed7ZLlIFM+r4TE/IeZfapO8yEpVHUue/bg7E0DddVIYesw0O15QzvKGcn5wnf/qA3quKrz1gd/73ITg9fZjvnezakWTONScHz2YrZ8e9RGBkFG1sCMM91S9/sdDN8Pi9GaP2HyWi8pSo4U+tUZHbLgjjfqxmGnTF/dmtLp1j7RyXGzyieMz2fCcyOnuKKOpLfGN3MvwVewEWrO4VuEtm1Lxh2fEF0dMSaNfXPjq86pKYp0BEhb4AclHoLyF4tacOCPCL3anCIzkM/sbMHFkv/CHXaixGExVgDefBrU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 360271cd-4d25-45d1-46f9-08d6242c3700
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2018 03:49:23.5186
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0177
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
index f24101ef763e..7c508c4bd204 100644
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
