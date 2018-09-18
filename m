Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4208AECE561
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 03:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D88CC21473
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 03:19:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="UctbPbFr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D88CC21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729553AbeIRIuJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 04:50:09 -0400
Received: from mail-hk2apc01on0119.outbound.protection.outlook.com ([104.47.124.119]:42874
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728944AbeIRIuI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 04:50:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xrpPyWTOFNx19F9nlfwZuNyIOHBf5ufont69UPp1N8I=;
 b=UctbPbFrUb87Bj4FbPGQal4PshdmV2ciMVYN9lT9Rcqji8SRf3To/LnAJ2Qf1Xwmh6UtEQRvflE4o2qEa4mylI8vW3XAEr8Xu8EPH8Qr6Bq7Dbfn0CBgBkWh5QIMcPq6+L1pTkwO13QZjTLOxy5/4BcVYMggxzee/SAPEqmpaBE=
Received: from HK0P153MB0129.APCP153.PROD.OUTLOOK.COM (52.133.156.18) by
 HK0P153MB0115.APCP153.PROD.OUTLOOK.COM (52.133.156.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.6; Tue, 18 Sep 2018 03:19:33 +0000
Received: from HK0P153MB0129.APCP153.PROD.OUTLOOK.COM
 ([fe80::8584:ad93:130a:6267]) by HK0P153MB0129.APCP153.PROD.OUTLOOK.COM
 ([fe80::8584:ad93:130a:6267%3]) with mapi id 15.20.1185.006; Tue, 18 Sep 2018
 03:19:33 +0000
From:   Tianyu Lan <Tianyu.Lan@microsoft.com>
CC:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        vkuznets <vkuznets@redhat.com>,
        Jork Loeser <Jork.Loeser@microsoft.com>
Subject: [PATCH V2 13/13] KVM/VMX: Add hv tlb range flush support
Thread-Topic: [PATCH V2 13/13] KVM/VMX: Add hv tlb range flush support
Thread-Index: AQHUTv5rTZ29EsZcUk20exkaiWAOTQ==
Date:   Tue, 18 Sep 2018 03:19:32 +0000
Message-ID: <20180918031754.113013-14-Tianyu.Lan@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;HK0P153MB0115;6:08kZHYHKfpUG7Hxbq+1IuQP+ZfrKQsqUVS6IHEPhdGUPVIJ6pQXdRy69y9ennE9Dy1dEFPhPRXeCsIirYfbtbUH5mUC3Q3bqNnm9oZehmNvKNq8zkyd/ue8OmvVgwQLuzoLibTcrw6kAkdYEfR7U5mfNcP3eQI//+xSPP+JXH7c9mOeb9hzhc8b6mzdgUaWPFI4Nf0d0rjdI/dSC2L5iFwhMndyYmq5XKf4/3nSTGUXvASoRoWEIrzRTvAD4JGytELjwBGx4iQE/lcSL3KfpwexlakjRpVhjrtcYeqoadG/tNwLILw9bYWr8+1WGMU0o4rv+t0yXnrwxhi5eRc11TWTcCVFmDiiqV6LsYKbVHgVPfny+JsbRPYgRIEOat+JTA8P/cSRlVkzaovYb6pEA0UWuw8hiCkqkgud/BPdwReW19qeKqEK03qABtxmiTw/yGrMl+bg92O71sIivM6PyXA==;5:sUDUvMgSDr8a8fKO5TLWxrfwTdjsjzcK9CQ7nGoV3vU2jv68swXa/U++KJseAAmFdBZE5QymgDiaMxJIg46qVDut4X8tW3nSYAB1pqb4ZEBAIT5Sv//KYUFZyeS8Xpn92Yn08VyqkPI63SPP0Fi5e92TGdYK/Cwcp4qExa6lhQA=;7:/EPUXDpCRC3hUoOzUWApBBZY6fvUFAXNCwfPSalJ8MV28eFlbxjz/XoQOuuPS+Nb/T4xwxm02tBZ+QtIeXWt5OoT+0kACnY01OtgLPFX6RcTridM/Wa6EwcJpynMuHDYmfJL9A+KKjRfpssM9rYc7Fax5A+VbSTsARWzudm5JQaOsZdJvTeJxxlfdUa//enBqBR0Bf3jeiyI6UTUdIO29KcN/89nYtAvEsl1l44eipGgnhZMS9s3pKSmBX3ExQUp
x-ms-office365-filtering-correlation-id: bc5a0631-7c92-424b-226e-08d61d158df3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:HK0P153MB0115;
x-ms-traffictypediagnostic: HK0P153MB0115:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <HK0P153MB0115BAE0CBC0F05F2EAE3CB2921D0@HK0P153MB0115.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231355)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(201708071742011)(7699050);SRVR:HK0P153MB0115;BCL:0;PCL:0;RULEID:;SRVR:HK0P153MB0115;
x-forefront-prvs: 0799B1B2D7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(376002)(39860400002)(346002)(136003)(199004)(189003)(97736004)(59246006)(316002)(6436002)(22452003)(6486002)(5660300001)(2900100001)(10090500001)(2906002)(6512007)(7736002)(305945005)(5250100002)(54906003)(25786009)(99286004)(4326008)(72206003)(10290500003)(478600001)(8936002)(105586002)(106356001)(109986005)(107886003)(81156014)(81166006)(76176011)(14454004)(6506007)(66066001)(68736007)(36756003)(86612001)(1671002)(26005)(256004)(486006)(14444005)(1076002)(53936002)(8676002)(446003)(11346002)(2616005)(476003)(102836004)(86362001)(3846002)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:HK0P153MB0115;H:HK0P153MB0129.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: nOpR2/U/tS08cCZQywmZx58Y4Z2dzSLHGCIFSMO4u8UBT4mM/J3wkz8AT5fxxV3dJwDKl4/Ddzp9gBVvVm2LGR7q+FDv2LDH6d9VKuO1EQiqN489e/J6Cf5bnwzR5dY7zrsgj4BgMWv0gIXj+jbX/LMZEOhgrXaA0UBzmAJV/Rfwf9j8eN9aM4/UuhIkcQh4l9mCBNpUFBYhVSluIPpm9eAGfEEdzI2aUNK9nf5fQWIoBxYiPmVHAC4nAbLgDBoc4svmvSS//qHWqoSfYhWRdpTYsqw2QOKAfbO4YPfQ5YU2suBADgiEifbUVW4dLktDKVVFlqfhjVfOgWzmaUdLjPcEOp1ZKdFY/DxHGmf5Log=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc5a0631-7c92-424b-226e-08d61d158df3
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2018 03:19:32.7970
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0115
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is to register tlb_remote_flush_with_range callback with
hv tlb range flush interface.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
Change since v1:
       Pass flush range with new hyper-v tlb flush struct rather
than KVM tlb flush struct.
---
 arch/x86/kvm/vmx.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++---=
----
 1 file changed, 51 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 2869c3e78168..70e1f916bfc9 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -1555,7 +1555,43 @@ static void check_ept_pointer_match(struct kvm *kvm)
 	to_kvm_vmx(kvm)->ept_pointers_match =3D EPT_POINTERS_MATCH;
 }
=20
-static int vmx_hv_remote_flush_tlb(struct kvm *kvm)
+int kvm_parse_flush_list_func(union hv_gpa_page_range gpa_list[],
+		int offset, struct list_head *flush_list,
+		int (*fill_flush_list)(union hv_gpa_page_range gpa_list[],
+		int offset, u64 start_gfn, u64 end_gfn))
+{
+	struct kvm_mmu_page *sp;
+
+	list_for_each_entry(sp, flush_list,
+			flush_link) {
+		offset =3D fill_flush_list(gpa_list, offset,
+				sp->gfn, KVM_PAGES_PER_HPAGE(sp->role.level));
+	}
+
+	return offset;
+}
+
+static inline int __hv_remote_flush_tlb_with_range(struct kvm *kvm,
+		struct kvm_vcpu *vcpu, struct kvm_tlb_range *range)
+{
+	u64 ept_pointer =3D to_vmx(vcpu)->ept_pointer;
+	struct hyperv_tlb_range flush_range;
+
+	if (range) {
+		flush_range.start_gfn =3D range->start_gfn;
+		flush_range.pages =3D range->pages;
+		flush_range.flush_list =3D range->flush_list;
+		flush_range.parse_flush_list_func =3D kvm_parse_flush_list_func;
+
+		return hyperv_flush_guest_mapping_range(ept_pointer,
+				&flush_range);
+	} else {
+		return hyperv_flush_guest_mapping(ept_pointer);
+	}
+}
+
+static int hv_remote_flush_tlb_with_range(struct kvm *kvm,
+		struct kvm_tlb_range *range)
 {
 	struct kvm_vcpu *vcpu;
 	int ret =3D -ENOTSUPP, i;
@@ -1567,16 +1603,21 @@ static int vmx_hv_remote_flush_tlb(struct kvm *kvm)
=20
 	if (to_kvm_vmx(kvm)->ept_pointers_match !=3D EPT_POINTERS_MATCH) {
 		kvm_for_each_vcpu(i, vcpu, kvm)
-			ret |=3D hyperv_flush_guest_mapping(
-				to_vmx(kvm_get_vcpu(kvm, i))->ept_pointer);
+			ret |=3D __hv_remote_flush_tlb_with_range(
+					kvm, vcpu, range);
 	} else {
-		ret =3D hyperv_flush_guest_mapping(
-				to_vmx(kvm_get_vcpu(kvm, 0))->ept_pointer);
+		ret =3D __hv_remote_flush_tlb_with_range(kvm,
+				kvm_get_vcpu(kvm, 0), range);
 	}
=20
 	spin_unlock(&to_kvm_vmx(kvm)->ept_pointer_lock);
 	return ret;
 }
+
+static int hv_remote_flush_tlb(struct kvm *kvm)
+{
+	return hv_remote_flush_tlb_with_range(kvm, NULL);
+}
 #else /* !IS_ENABLED(CONFIG_HYPERV) */
 static inline void evmcs_write64(unsigned long field, u64 value) {}
 static inline void evmcs_write32(unsigned long field, u32 value) {}
@@ -7918,8 +7959,11 @@ static __init int hardware_setup(void)
=20
 #if IS_ENABLED(CONFIG_HYPERV)
 	if (ms_hyperv.nested_features & HV_X64_NESTED_GUEST_MAPPING_FLUSH
-	    && enable_ept)
-		kvm_x86_ops->tlb_remote_flush =3D vmx_hv_remote_flush_tlb;
+	    && enable_ept) {
+		kvm_x86_ops->tlb_remote_flush =3D hv_remote_flush_tlb;
+		kvm_x86_ops->tlb_remote_flush_with_range =3D
+				hv_remote_flush_tlb_with_range;
+	}
 #endif
=20
 	if (!cpu_has_vmx_ple()) {
--=20
2.14.4
