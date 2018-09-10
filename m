Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0629BC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA0A3204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="dkcbCj+z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA0A3204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728319AbeIJNct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 09:32:49 -0400
Received: from mail-pu1apc01on0097.outbound.protection.outlook.com ([104.47.126.97]:53983
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728270AbeIJNcs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 09:32:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZ77rHmmr8dwZkCptTrN4TDwEE3oDwF3WQ2dGBbc7RQ=;
 b=dkcbCj+zp+E8FqmHYn7YZ1k1MthXXGuK7HunA+g8npwC+d/sMR3s5lZ6lUEi3gB/99BsKSOc3u0pnXkElZPk3oldUul355DNS1nI13+c9MWx2Cmmcl9dQvAkgZV00tuqsrXO0mRaEe4A/hvXgTVJgS8KPT5QZQiuLsdbCJiBoHo=
Received: from HK0P153MB0129.APCP153.PROD.OUTLOOK.COM (52.133.156.18) by
 HK0P153MB0178.APCP153.PROD.OUTLOOK.COM (52.133.212.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.6; Mon, 10 Sep 2018 08:39:46 +0000
Received: from HK0P153MB0129.APCP153.PROD.OUTLOOK.COM
 ([fe80::194c:c2f9:171:1890]) by HK0P153MB0129.APCP153.PROD.OUTLOOK.COM
 ([fe80::194c:c2f9:171:1890%5]) with mapi id 15.20.1143.010; Mon, 10 Sep 2018
 08:39:46 +0000
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
Subject: [PATCH 13/13] KVM/VMX: Add hv tlb range flush support
Thread-Topic: [PATCH 13/13] KVM/VMX: Add hv tlb range flush support
Thread-Index: AQHUSOHTS14VH65P4UKiDgDXAw0MjQ==
Date:   Mon, 10 Sep 2018 08:39:46 +0000
Message-ID: <20180910083806.65177-14-Tianyu.Lan@microsoft.com>
References: <20180910083806.65177-1-Tianyu.Lan@microsoft.com>
In-Reply-To: <20180910083806.65177-1-Tianyu.Lan@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tianyu.Lan@microsoft.com; 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HK0P153MB0178;6:0SZYynJGEfcwTzXmIAYY+R50lONwonxNW1HWuqbF9CZrjASquPCMbuBQG6LOv0vm8fgNB4TbZRX2jDVOW5eUWa7OxoQGWHsv2rajxN5jJ8e4nC+7TfvwTDnfMAq6nCn+sJd8MHmucu/IerqOGbh/qNO95LCWfweU0+fzDC71qMBnrt5gv4/26UBCBah5lTkngh97u3+0WaXizNiSXfHpZ++09bn9QSDP5Fyrusj36bBj1YqXGSMghd3ac7o2qDyULyzVERgf8dzej+JSLPT3fvmMwTb9TQgm8NfC3zF9NmqfYdpNtu877MJHt6TeVwg60YZtgQIawdaOF4LdgtE0NyYbupQOublHn2XNRwZmaM3Z5LRNGab4yFf45MDkkRjiPcgFoTCTrSqODqTvNa1aj0RA3TC49PAyFZQJuZjwgDSvTMn968DMdFccEpjer/EjEjqnSR0uRNCfKaTq0vk6Eg==;5:gY6KaXApMm0zr3hxhVK2P9fCHXpP64GHkRmOf15s4byZht6Yg6Nkn5y2WXEkq7k8Ncde1Sv1+IlKfymT0ej+xjHBq6g89vGlfX2wxBjqpeohMEgs4D1ZAWgeM7Z5ElnyZr6uvy5Xri5vQPU+b06AKntVvQesONj96Ss1DS/ICxw=;7:bDIIEFdDoUGqlB+AiIO5eyswZZ8gFe+GjveVXuKZloY11ocjLzqBS5uNqK4oDd2orVq6GeY2q4Db1bFtb30206T63/Et0shQcXkNNS4Z9Pd10kG5V3OCGJ6BAP+ECXHK//NjDZifFzsU+qNfgvz26e/kCzbafcc/vsnhQHycusRoT5miGKvSMrEhQey/Vxoayc0ZCMfdhyJ6qcCzuSGf6EzNZQOd5gvtbmovYCEIcVsjg4uAcdgnpMvUeOW2T+KY
x-ms-office365-filtering-correlation-id: 3fb6ad75-f196-4263-7772-08d616f8f6a0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:HK0P153MB0178;
x-ms-traffictypediagnostic: HK0P153MB0178:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <HK0P153MB017895448D628A6F2D5E5CD792050@HK0P153MB0178.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699050);SRVR:HK0P153MB0178;BCL:0;PCL:0;RULEID:;SRVR:HK0P153MB0178;
x-forefront-prvs: 07915F544A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39850400004)(136003)(366004)(346002)(396003)(189003)(199004)(7736002)(14454004)(478600001)(105586002)(36756003)(97736004)(305945005)(4326008)(10090500001)(486006)(53936002)(99286004)(5660300001)(10290500003)(6116002)(6436002)(72206003)(446003)(76176011)(11346002)(1671002)(2906002)(2616005)(6486002)(59246006)(476003)(66066001)(107886003)(109986005)(68736007)(8676002)(14444005)(54906003)(81156014)(81166006)(5250100002)(256004)(1076002)(6506007)(316002)(22452003)(26005)(25786009)(8936002)(6512007)(102836004)(86612001)(106356001)(3846002)(2900100001)(575784001)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:HK0P153MB0178;H:HK0P153MB0129.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: X7XbMEV5dFJwBibOjkHL8V6CKXXWW2D5+vRerJ1H/+1YPCu+4j8RFqNcNRP6Bo0sWvE66RIU2+SyTNh4RbHD3eUXzdIQ3Fz0d1krmzyHQ3wU+j4JBHZ7F+w6if6+NbAkUW1aQhrjBTtDuRZhOoWyYPHpJKLh29/6rqT/TStL099E+AnoMBCzY+YaGrkAUjSip48PGDT+RCFq5FkquAFrsi8paIjGDr7eIL30wXhxdiEN4x9ftroCqv5E9KfMzgwZbtFFW3TzSPdfZQmbtERe9JR2v5pyvkyGo6ns9TgwEQy4FVwGOd/EClsbPrtyW4iQ6V5TJJzLMIopYcJODzTE5R5WaehVWffnCkaQN9qtEfc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fb6ad75-f196-4263-7772-08d616f8f6a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2018 08:39:46.0973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0178
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is to register tlb_remote_flush_with_range callback with
hv tlb range flush interface.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/kvm/vmx.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 3f9ccbafd0d8..ae904693b14f 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -1555,7 +1555,19 @@ static void check_ept_pointer_match(struct kvm *kvm)
 	to_kvm_vmx(kvm)->ept_pointers_match =3D EPT_POINTERS_MATCH;
 }
=20
-static int vmx_hv_remote_flush_tlb(struct kvm *kvm)
+static inline int __hv_remote_flush_tlb_with_range(struct kvm *kvm,
+		struct kvm_vcpu *vcpu, struct kvm_tlb_range *range)
+{
+	u64 ept_pointer =3D to_vmx(vcpu)->ept_pointer;
+
+	if (range)
+		return hyperv_flush_guest_mapping_range(ept_pointer, range);
+	else
+		return hyperv_flush_guest_mapping(ept_pointer);
+}
+
+static int hv_remote_flush_tlb_with_range(struct kvm *kvm,
+		struct kvm_tlb_range *range)
 {
 	struct kvm_vcpu *vcpu;
 	int ret =3D -ENOTSUPP, i;
@@ -1567,16 +1579,21 @@ static int vmx_hv_remote_flush_tlb(struct kvm *kvm)
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
@@ -7918,8 +7935,11 @@ static __init int hardware_setup(void)
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
