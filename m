Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8FBFC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D5B82536D
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="KF2R0o0A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D5B82536D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752466AbeGBORx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 10:17:53 -0400
Received: from mail-hk2apc01on0135.outbound.protection.outlook.com ([104.47.124.135]:45083
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752339AbeGBORm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 10:17:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMBZv9HHsnAjwF4JH+V+cOcxB1m5QnjYBLSldhcPHt8=;
 b=KF2R0o0AP+xZ7ehomRFjiASD2WnogIvpK02KXQMWJgfffIvSXOxruKTW+y2xx5MJB5+3zeV4q+cU+W97CUlvVjooOvqw9zmjvbh28fZtMnGfbFwOWkx3SdY7YeL080OtFDnLWvLtXsHYdAGSufe7D0SbndtmvCu8FnzCUjLtjlE=
Received: from KU1P153MB0150.APCP153.PROD.OUTLOOK.COM (10.170.172.151) by
 KU1P153MB0133.APCP153.PROD.OUTLOOK.COM (10.170.172.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.4; Mon, 2 Jul 2018 14:17:35 +0000
Received: from KU1P153MB0150.APCP153.PROD.OUTLOOK.COM
 ([fe80::3117:172e:121:d0e]) by KU1P153MB0150.APCP153.PROD.OUTLOOK.COM
 ([fe80::3117:172e:121:d0e%5]) with mapi id 15.20.0952.005; Mon, 2 Jul 2018
 14:17:35 +0000
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
        "vkuznets@redhat.com" <vkuznets@redhat.com>
Subject: [PATCH 4/4] KVM/x86: Add tlb_remote_flush callback support for vmcs
Thread-Topic: [PATCH 4/4] KVM/x86: Add tlb_remote_flush callback support for
 vmcs
Thread-Index: AQHUEg9s2V1n5OInc0ep56nEV4cmEQ==
Date:   Mon, 2 Jul 2018 14:17:35 +0000
Message-ID: <20180702141653.88936-5-Tianyu.Lan@microsoft.com>
References: <20180702141653.88936-1-Tianyu.Lan@microsoft.com>
In-Reply-To: <20180702141653.88936-1-Tianyu.Lan@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tianyu.Lan@microsoft.com; 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;KU1P153MB0133;7:vcD4A7rxM4HH6s8nE6DHOEPSBIPZWpr9tGOoj4iuc8NxXWx9lt44zFvg8LNdp2beMx247BAOxVqs0+0LyWUOJ48UIY4GutNh5eItW7LVzZYSnESYmGaRoWtZdDaF7v1I57Noov5OOkCZ+pLJX0w2/0XAmdQgnFtS1L2mAedVSCNwYPiLAAM7Qt1qo+PEeqlZBg/UuKB9mfrNHHcskAZSLhwMqI6/4e+p7xDjXtv8kS4qX6PHgBHO8sfYDbVylmVp
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 2dd2c3c5-d4d4-4536-c5b2-08d5e0268f31
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(2017052603328)(7193020);SRVR:KU1P153MB0133;
x-ms-traffictypediagnostic: KU1P153MB0133:
x-microsoft-antispam-prvs: <KU1P153MB013305479D6E32080252CABF92430@KU1P153MB0133.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:KU1P153MB0133;BCL:0;PCL:0;RULEID:;SRVR:KU1P153MB0133;
x-forefront-prvs: 07215D0470
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(136003)(39860400002)(346002)(376002)(199004)(189003)(1671002)(54906003)(476003)(446003)(486006)(59246006)(36756003)(26005)(102836004)(22452003)(11346002)(2616005)(316002)(97736004)(2900100001)(14454004)(6486002)(109986005)(86362001)(86612001)(68736007)(6512007)(4326008)(25786009)(6436002)(10090500001)(53936002)(66066001)(5660300001)(105586002)(106356001)(8936002)(2906002)(305945005)(7736002)(99286004)(256004)(14444005)(72206003)(6506007)(10290500003)(76176011)(3846002)(8676002)(1076002)(81166006)(81156014)(478600001)(5250100002)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:KU1P153MB0133;H:KU1P153MB0150.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: oCo4pDEwOK3IIXe1sPMF3TZpkgc97H/L6Q9GcnmaiTkt1I4S6/pXtLedHh8L5Cmc+n7RvzQfo4dXPISIAMYmiwi3PbUdmQvIvf+jSsxNdB0fyCuuB4HWSJGLDNAatVVWMoHuoVCBQH0CuVrAORmRURE3LUkVyGvvAJaUdbUI7rY2g+zs7J13OvvS3yn4jDkvV4R6VrEZvphrXTkqfmF+nWdzhI8qWCmJEU8ohCAhmrbJ9w1AtqoIBMXkS8l7GH9fkwh+AN8WjXQyKU44X6SiELQUAfwwNeVlN3nL92wx7V9mKidh8tzGYOjMO4NlszktTV7F62bjfV4z6IHGh0wbLQ0dSQNLOErqGvPuRpFjolA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dd2c3c5-d4d4-4536-c5b2-08d5e0268f31
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2018 14:17:35.3576
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU1P153MB0133
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register tlb_remote_flush callback for vmcs when hyperv capability of
nested guest mapping flush is detected. The interface can help to
reduce overhead when flush ept table among vcpus for nested VM. The
tradition way is to send IPIs to all affected vcpus and executes
INVEPT on each vcpus. It will trigger several vmexits for IPI
and INVEPT emulation. Hyper-V provides such hypercall to do
flush for all vcpus.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/kvm/vmx.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 0b1e4e9fef2b..e42ed4833983 100644
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
+	if (!VALID_PAGE(to_kvm_vmx(kvm)->identical_ept_pointer)) {
+		ret =3D -EFAULT;
+		goto out;
+	}
+
+	ret =3D hyperv_flush_guest_mapping(
+			to_kvm_vmx(kvm)->identical_ept_pointer);
+
+out:
+	spin_unlock(&to_kvm_vmx(kvm)->ept_pointer_lock);
+	return ret;
+}
+
 static void vmx_flush_tlb(struct kvm_vcpu *vcpu, bool invalidate_gpa)
 {
 	__vmx_flush_tlb(vcpu, to_vmx(vcpu)->vpid, invalidate_gpa);
@@ -7567,6 +7586,12 @@ static __init int hardware_setup(void)
 	if (enable_ept && !cpu_has_vmx_ept_2m_page())
 		kvm_disable_largepages();
=20
+#if IS_ENABLED(CONFIG_HYPERV)
+	if (ms_hyperv.nested_features & HV_X64_NESTED_GUEST_MAPPING_FLUSH
+	    && enable_ept)
+		kvm_x86_ops->tlb_remote_flush =3D hv_remote_flush_tlb;
+#endif
+
 	if (!cpu_has_vmx_ple()) {
 		ple_gap =3D 0;
 		ple_window =3D 0;
--=20
2.14.3
