Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86AF4ECE561
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 03:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32A8E21471
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 03:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ftYx5Jxz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32A8E21471
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729390AbeIRItd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 04:49:33 -0400
Received: from mail-sg2apc01on0104.outbound.protection.outlook.com ([104.47.125.104]:35137
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729295AbeIRIta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 04:49:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K2CGbHgZQz9Q5WJeNWx/Rhg/k0ckXE/QkwWnYN4LLgU=;
 b=ftYx5JxzEB0LZfm8OQXS1q6GECkggBNkmXYCp5X3n33t/6c4srLSN45YRixMadi0t4ulyZQkV2b2332+EfU/j+/zl1tE20zirgTFca5X05niAKBFI47mueR6bMYGGejqGO33rbHlkzrvmoDQNRNpvu5JzVAjHe6RbXTfh3EWQlw=
Received: from HK0P153MB0129.APCP153.PROD.OUTLOOK.COM (52.133.156.18) by
 HK0P153MB0180.APCP153.PROD.OUTLOOK.COM (52.133.212.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.5; Tue, 18 Sep 2018 03:18:56 +0000
Received: from HK0P153MB0129.APCP153.PROD.OUTLOOK.COM
 ([fe80::8584:ad93:130a:6267]) by HK0P153MB0129.APCP153.PROD.OUTLOOK.COM
 ([fe80::8584:ad93:130a:6267%3]) with mapi id 15.20.1185.006; Tue, 18 Sep 2018
 03:18:56 +0000
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
Subject: [PATCH V2 7/13] KVM: Add flush_link and parent_pte in the struct
 kvm_mmu_page
Thread-Topic: [PATCH V2 7/13] KVM: Add flush_link and parent_pte in the struct
 kvm_mmu_page
Thread-Index: AQHUTv5VCQI1tpqiNk6i3QFgEFo38g==
Date:   Tue, 18 Sep 2018 03:18:55 +0000
Message-ID: <20180918031754.113013-8-Tianyu.Lan@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;HK0P153MB0180;6:6g+0T+14b9Kmafh0hdqGAbHwnkN5a1+V6KY93Jh0cc0MP2lgsxUcUffhTugOy1TNQKBDiBrYybuwPsFMJ09IudP9e6GIMMpYC32PJjjv+V6vPeLJbc64R38vzONZYwEuWiQavTj8SVnlPuq0Vd8A1c3F2kPm8gjNewQXDbBr+ScqxiNlPDAQdp4U45T67DRs7dkBYuVapngIz5ZlpHQOozKfwaPAhmBVNgQHLCqMbWmniXv5wFwSux5dHndn6tbp9BbrUK+9I/aPFJJxz/XiqmkXq/phuZNXA+jSJVsE6qD05pZ9YxCHxTmERoNhMGzuXPGN6YkFAspvPF/evnWM44AAcbcazAa2com0P6elE1IdUKm+FryXbB2OkLt4s5OKEWcM9okqFnYoAIl88IKeDRQPSBc4FEhgeIAt+c66XrLrf6m1PmwCRaUjDbQr5iW9xdNOy6YCLKyJh/AwCAEnHg==;5:oATPxDavMjGrjJNLWX6/MvG9TlbQdc5EtT3lyy8DTyfqdt9XLSc+qhnTzS86WMWnF7Sy6C50+tdqIjC7X/lhB+n69uje4gVrI1MrRM3A7CrtMtkwklnFpyeEBZdipkpBs4vMLfXwk0HzJ+TEhpSOYkvNnu/K3R7gylE3bhXjF5E=;7:HJ2qEswUfZ7FaYsdiFOp251ryLj1UBrtlMS0S+5GLc1LEf0dMDeeEH35xqYQ+EBveSyt2kZIs+74yfZ3wuje360VVQ/4tXn3EQYcwJH753HcFNeGnxvfUs7yRQVJK8mUaiGqSK+Cr4v15IJI/4wJnMLf890k+LghvMqSG1GStITNwR4u4/5DnQdGLdd7DUIv3jJI2pKXZSc7fKgNMYUtubkAGpui9SN6SJ1E217IEQHjO+7pkRuBXMKuaErf+o0x
x-ms-office365-filtering-correlation-id: 1115b55b-4bad-44aa-dcd7-08d61d1577f1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:HK0P153MB0180;
x-ms-traffictypediagnostic: HK0P153MB0180:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <HK0P153MB0180EEF786F1C47320D15F9A921D0@HK0P153MB0180.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699050);SRVR:HK0P153MB0180;BCL:0;PCL:0;RULEID:;SRVR:HK0P153MB0180;
x-forefront-prvs: 0799B1B2D7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(396003)(39860400002)(346002)(136003)(199004)(189003)(26005)(102836004)(2906002)(7736002)(6506007)(22452003)(59246006)(54906003)(316002)(14454004)(86362001)(86612001)(36756003)(6436002)(10090500001)(6486002)(6512007)(305945005)(7416002)(53936002)(2900100001)(5250100002)(256004)(97736004)(72206003)(478600001)(106356001)(8676002)(81156014)(81166006)(5660300001)(8936002)(6116002)(3846002)(99286004)(76176011)(10290500003)(1076002)(105586002)(476003)(2616005)(11346002)(446003)(66066001)(486006)(107886003)(25786009)(109986005)(68736007)(1671002)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:HK0P153MB0180;H:HK0P153MB0129.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: vHW5JGupMkNxJosri9rgZ/7iQ2v/np+1smbSvx1rzCjug+gdXD7gS6f32cJHu1aFgu1MZZ5UrBX14R2gciDPvN2cqK2i38TDAD4I+ma1pOe2wCAJgqPcYFTsUc7HjWZKfU18Ap/9dT+BK+6+ViznfrflYiHO7AvpKBy3CiuxZ2g8ekB3fWV6OOlK75haNb4uxab4Mb1wUtpTCpzm5LXTeQnPg31BLXk7fZ88sFsVDR1RBcY6YGK+r8oNh2TE9rc334zHcabhLTOeYcOuChAbLCBPieX9+Mrr3CGE68cY3dUugr33U1dil1v1Trre5dSTAidj772XjzSCfstSArpBdzmvarqe6C+dgIRW9av7Pq0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1115b55b-4bad-44aa-dcd7-08d61d1577f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2018 03:18:55.8188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0180
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
