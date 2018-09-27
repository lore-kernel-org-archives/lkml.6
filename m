Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DFE1C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 03:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F227214FE
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 03:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="WdpcmXXA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F227214FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbeI0KGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 06:06:18 -0400
Received: from mail-pu1apc01on0125.outbound.protection.outlook.com ([104.47.126.125]:47168
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726684AbeI0KGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 06:06:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xrpPyWTOFNx19F9nlfwZuNyIOHBf5ufont69UPp1N8I=;
 b=WdpcmXXAYhCHc9UcaND/hC//s6qxwrUXfT25X6asnEkP9vDBbRxhqbv+oRK6flznjkJtA4x/xTDTgFpQU5Y2tAYt1+ZM8yuFNzBHxTH1STv8+oOZjxWz1tsX2BwPIenOjlMQVAM53lfOLcI9UGEshjwRCOYMGajdTqj+YFg3QV8=
Received: from HK0P153MB0129.APCP153.PROD.OUTLOOK.COM (52.133.156.18) by
 HK0P153MB0177.APCP153.PROD.OUTLOOK.COM (52.133.210.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Thu, 27 Sep 2018 03:50:06 +0000
Received: from HK0P153MB0129.APCP153.PROD.OUTLOOK.COM
 ([fe80::8584:ad93:130a:6267]) by HK0P153MB0129.APCP153.PROD.OUTLOOK.COM
 ([fe80::8584:ad93:130a:6267%3]) with mapi id 15.20.1207.011; Thu, 27 Sep 2018
 03:50:06 +0000
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
Subject: [PATCH V3 13/13] KVM/VMX: Add hv tlb range flush support
Thread-Topic: [PATCH V3 13/13] KVM/VMX: Add hv tlb range flush support
Thread-Index: AQHUVhUtzbG9wJFcUUe6aCZsyDBR8w==
Date:   Thu, 27 Sep 2018 03:50:06 +0000
Message-ID: <20180927034829.2230-14-Tianyu.Lan@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;HK0P153MB0177;6:FADiDioKkgCrQt8rJJDm5oO2IXm/W6JU0nZCW/wEYJRaXHE4tBik2s6Ne8VNQBjyiVJRH8M0GKtBtWNeF3Woibm4DpSPrkPInD1ruKfndvFcAMcmRkZhsXesPWnHEsJbHEUOf/B7ydC/g5WUdIOOHV+AXNnc5hoZKLCFHBZJSz9sGcs9/efXbG3A+vPN2Y2T1QmfYF2qHf8i7GIRijGYDpye/+zlDnERaJM4h+hU3TFlgsHWpVnIyyyuWiENDNazXj1Ebbh65nuStROzmK44/laReaj8hfccESDjIUppVQpuou5SxrKVAi0hKPkThsuj3A6VAmxD3i6p9wnEdXtpH5zWKMTpHQlLo6YP0gtRvBOj/3JtMcPNPn0QkSULuoQnOd0tcMDTQActzTDPn+zo+JiNDWzPVgjvNUKuyCUbNOHNsK9KyThZGbC7hzGA2SVG7AospwUm1ort7G+StiAStQ==;5:UTAzQryKBF+eH5N5EQ/qfiWeDnt9pi0bR9Mi7YItC7JmeO11imGHU78TNnACbiFAgtgMQfTY7HGLivKSHsAmQZ409vCwjS41rZW8VljqhYN9w287FsF5vvHc6IChmcVEDC1lYjq9JAjbf1AXe3prvWan3tp3jmzsUJ/MhICw0Qw=;7:xuoxMdrAOLAKwg/cO3gVi3FIXHfgP79IIHI1qfOzXxgVQAVcjEQZOm6kuclcrIFNuOi+Jx6ImZhQqPEqEyIyJ/D9eTkTb74CqjtVerj5zobiaS3iHMs4BE+vGjWsRpHzW5jhaAXemW3A8ocRK2q2lU8VB+VzShv+Rom6jvoW9Adogw93ywFUiRGqf0wh48Ka3qRhjiLYf7kNRKivCrccPab3YTK1N0PXutHvqE5NOHg+EeLwgciP6fgc+KxMLQ5T
x-ms-office365-filtering-correlation-id: f9147291-3298-4047-2a8d-08d6242c509a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:HK0P153MB0177;
x-ms-traffictypediagnostic: HK0P153MB0177:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <HK0P153MB017731BA3A39EB8B7C99D02B92140@HK0P153MB0177.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051);SRVR:HK0P153MB0177;BCL:0;PCL:0;RULEID:;SRVR:HK0P153MB0177;
x-forefront-prvs: 0808323E97
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(1496009)(376002)(136003)(396003)(346002)(39860400002)(366004)(199004)(189003)(105586002)(99286004)(10290500003)(486006)(478600001)(68736007)(106356001)(14454004)(72206003)(81156014)(6486002)(8676002)(6506007)(1671002)(81166006)(6512007)(2900100001)(2906002)(6436002)(76176011)(8936002)(10090500001)(3846002)(6116002)(54906003)(36756003)(316002)(59246006)(102836004)(26005)(1076002)(5660300001)(5250100002)(109986005)(107886003)(11346002)(446003)(2616005)(4326008)(25786009)(476003)(22452003)(53936002)(86612001)(86362001)(71190400001)(71200400001)(14444005)(66066001)(7736002)(256004)(305945005)(34290500001)(97736004);DIR:OUT;SFP:1102;SCL:1;SRVR:HK0P153MB0177;H:HK0P153MB0129.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ym2damrzQ+kbSS+eeKH0IUSMQ1BgOAA6ghmtlW+/MwIBpihGZ9q1O9J2Qbl9oam9HhrIz9rx8UnRbJulUjZgnsMsjPk6ZtbjCINlx9NrQX42ZCC+OM0wAWpn/QB9ulaCtCDDpym5clTMoPLExF+9NbmT0F3OUSJNOf/97QlzJS9k084RDqW7ngzTUFg8Z5x6JJF+DYZUK0uHWZtw6UvSFcpUxANm6SzMo4K5DqBV5wkcAPmAiDJkE5l0iFF3eEX2WDbobddmP5p2MDbEc8gbD0xKkDABSGYsQ89syIjAJELijRDrZ6HmHVr50zwAAXjQJywbQAsZ+MZJL1SUx1nmgnlGT9GyZTu+Bor2beY3mNc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9147291-3298-4047-2a8d-08d6242c509a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2018 03:50:06.4602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0177
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
