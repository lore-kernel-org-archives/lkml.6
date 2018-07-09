Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC4E0C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EBE020673
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="iiaxaKGm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EBE020673
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932949AbeGIJDG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 05:03:06 -0400
Received: from mail-hk2apc01on0118.outbound.protection.outlook.com ([104.47.124.118]:48160
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932411AbeGIJDC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 05:03:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dgZ+ZinvDB1rDfjSBaLFsuHZjr4VPDJm7OoPb6r9jCY=;
 b=iiaxaKGm6T/XQw0gBH7KSH6gyvBKgdl7KXX9lGWIcxMUdSDRHTPESXbnCT4OmSylAer43DLHVqdvgIGNOULEJEigNIxAmv/+wq/+M1/f0kByagNRsVpS5AcNtECRSF5vgMIZ18wkXh2JuvNzltxGsnW2pWY6Gss4T7Q2mFZV/qU=
Received: from SG2P15301MB0093.APCP153.PROD.OUTLOOK.COM (10.170.136.145) by
 SG2P15301MB0063.APCP153.PROD.OUTLOOK.COM (10.170.136.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.15; Mon, 9 Jul 2018 09:02:54 +0000
Received: from SG2P15301MB0093.APCP153.PROD.OUTLOOK.COM
 ([fe80::f916:a637:8730:be25]) by SG2P15301MB0093.APCP153.PROD.OUTLOOK.COM
 ([fe80::f916:a637:8730:be25%4]) with mapi id 15.20.0952.013; Mon, 9 Jul 2018
 09:02:54 +0000
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
Subject: [PATCH V2 4/5] KVM/x86: Add tlb_remote_flush callback support for vmx
Thread-Topic: [PATCH V2 4/5] KVM/x86: Add tlb_remote_flush callback support
 for vmx
Thread-Index: AQHUF2OfaKVoUgkJpEydmi6qoCdREQ==
Date:   Mon, 9 Jul 2018 09:02:54 +0000
Message-ID: <20180709090218.15342-5-Tianyu.Lan@microsoft.com>
References: <20180709090218.15342-1-Tianyu.Lan@microsoft.com>
In-Reply-To: <20180709090218.15342-1-Tianyu.Lan@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SG2P15301MB0063;7:sB49xBENYPxuORcE8DCfyDFr7jSY9QVUfrKmDN3nXnNjJuNgsD/SWJXObEzK2MM6QMh2DDV8vKMTP6osYtSTCTXA8AU8NNLEYu2BMiQknPaJ90wWhhMNIp3Hsi/SzlOXVhM2QTIu07+ch2hvu/g6UICHt/H/r1ppGwp01HkVwl9kweBiSY/IoFm4yokMLL/r1CUJCeHyTe88RiZtghC4BdEV1Tqlc/zE/F+nPcKIzevQ2zgVGzhpDN3l9d5gKUpJ
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 576bb9ad-99aa-448d-e6bd-08d5e57ac1f0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(2017052603328)(7193020);SRVR:SG2P15301MB0063;
x-ms-traffictypediagnostic: SG2P15301MB0063:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tianyu.Lan@microsoft.com; 
x-microsoft-antispam-prvs: <SG2P15301MB00635E53B9293441AC48587E92440@SG2P15301MB0063.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:SG2P15301MB0063;BCL:0;PCL:0;RULEID:;SRVR:SG2P15301MB0063;
x-forefront-prvs: 07283408BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(396003)(366004)(39860400002)(346002)(199004)(189003)(256004)(14444005)(105586002)(76176011)(86362001)(6486002)(72206003)(66066001)(59246006)(86612001)(6512007)(97736004)(6436002)(2616005)(476003)(8936002)(486006)(14454004)(446003)(11346002)(7416002)(81156014)(81166006)(8676002)(4326008)(109986005)(68736007)(25786009)(2900100001)(106356001)(6116002)(3846002)(1076002)(36756003)(5660300001)(53936002)(305945005)(7736002)(1671002)(5250100002)(54906003)(99286004)(26005)(102836004)(22452003)(10090500001)(10290500003)(2906002)(478600001)(6506007)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:SG2P15301MB0063;H:SG2P15301MB0093.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: rxCmXGly/qMIa35bBN8Pbi+KXD/vh3E945g2+dPp79mxIT82eJZCSibHNy20LiXbkQz7ZZr/eaTzNqdHt/gX7UH0SzRzsVVBNBgA6g7GcY2Ti6Um2r1WRDYgmlnfkrWxuY8+Y77mNPswtWZDV4gazrGMh0X+nKcVbv8I/1ioga1XGzmV+KEtHazmHzqu06cl6hfiKFhcTnQElwnP203uY6W+7/V42E/wwBwSJifH50qjsyRzJmQO5ytFOxzqBm2MWiZ0wBtCZP8h/5BXl3WwXBzJC9DH2KVhPPKvT19ONb+8ayRecRKQ5SJ7DLMEXvCkK/DzabYWutqLCulPGWWoxD9iA4BVjAHPBmpROF4HC0g=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 576bb9ad-99aa-448d-e6bd-08d5e57ac1f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2018 09:02:54.0580
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2P15301MB0063
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register tlb_remote_flush callback for vmx when hyperv capability of
nested guest mapping flush is detected. The interface can help to
reduce overhead when flush ept table among vcpus for nested VM. The
tradition way is to send IPIs to all affected vcpus and executes
INVEPT on each vcpus. It will trigger several vmexits for IPI
and INVEPT emulation. Hyper-V provides such hypercall to do
flush for all vcpus.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
Change since v1:
       Use ept_pointers_match to check condition of identical ept
table pointer and get ept pointer from struct vcpu_vmx->ept_pointer.
---
 arch/x86/kvm/vmx.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 8142b2da430a..55fe14d1d4d4 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -4778,6 +4778,25 @@ static inline void __vmx_flush_tlb(struct kvm_vcpu *=
vcpu, int vpid,
 	}
 }
=20
+static int hv_remote_flush_tlb(struct kvm *kvm)
+{
+	int ret;
+
+	spin_lock(&to_kvm_vmx(kvm)->ept_pointer_lock);
+
+	if (!to_kvm_vmx(kvm)->ept_pointers_match) {
+		ret =3D -EFAULT;
+		goto out;
+	}
+
+	ret =3D hyperv_flush_guest_mapping(
+			to_vmx(kvm_get_vcpu(kvm, 0))->ept_pointer);
+
+out:
+	spin_unlock(&to_kvm_vmx(kvm)->ept_pointer_lock);
+	return ret;
+}
+
 static void vmx_flush_tlb(struct kvm_vcpu *vcpu, bool invalidate_gpa)
 {
 	__vmx_flush_tlb(vcpu, to_vmx(vcpu)->vpid, invalidate_gpa);
@@ -4968,7 +4987,7 @@ static void check_ept_pointer(struct kvm_vcpu *vcpu, =
u64 eptp)
 	u64 tmp_eptp =3D INVALID_PAGE;
 	int i;
=20
-	if (!kvm_x86_ops->tlb_remote_flush)
+	if (!kvm_x86_ops->hv_tlb_remote_flush)
 		return;
=20
 	spin_lock(&to_kvm_vmx(kvm)->ept_pointer_lock);
@@ -7570,6 +7589,12 @@ static __init int hardware_setup(void)
 	if (enable_ept && !cpu_has_vmx_ept_2m_page())
 		kvm_disable_largepages();
=20
+#if IS_ENABLED(CONFIG_HYPERV)
+	if (ms_hyperv.nested_features & HV_X64_NESTED_GUEST_MAPPING_FLUSH
+	    && enable_ept)
+		kvm_x86_ops->hv_tlb_remote_flush =3D hv_remote_flush_tlb;
+#endif
+
 	if (!cpu_has_vmx_ple()) {
 		ple_gap =3D 0;
 		ple_window =3D 0;
--=20
2.14.3
