Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6025FECE563
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 03:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D787214C2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 03:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Alr1psU/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D787214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729531AbeIRIuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 04:50:03 -0400
Received: from mail-hk2apc01on0106.outbound.protection.outlook.com ([104.47.124.106]:53890
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728944AbeIRIuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 04:50:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vkM1XDOasZe08xhGjYX+1tcGXbLIMOabyyqCPCQ98DY=;
 b=Alr1psU/56krQQ/mxuG52UYd6U7QdCmiov+7RmK34m8Kao4/e+9gJgCELEM922mTxFg7m6ufku6WKTV9aSjoJ7Y/fbJ1c0MKdu60K8wFFs8s7PLvB2IArxeOh3C4PwY5miZsRNmmTbhdbZKK8jYLCIC9LTepep/K68KIZ1FEMYg=
Received: from HK0P153MB0129.APCP153.PROD.OUTLOOK.COM (52.133.156.18) by
 HK0P153MB0115.APCP153.PROD.OUTLOOK.COM (52.133.156.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.6; Tue, 18 Sep 2018 03:19:27 +0000
Received: from HK0P153MB0129.APCP153.PROD.OUTLOOK.COM
 ([fe80::8584:ad93:130a:6267]) by HK0P153MB0129.APCP153.PROD.OUTLOOK.COM
 ([fe80::8584:ad93:130a:6267%3]) with mapi id 15.20.1185.006; Tue, 18 Sep 2018
 03:19:27 +0000
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
Subject: [PATCH V2 12/13] KVM/VMX: Change hv flush logic when ept tables are
 mismatched.
Thread-Topic: [PATCH V2 12/13] KVM/VMX: Change hv flush logic when ept tables
 are mismatched.
Thread-Index: AQHUTv5nZuQOhoZncE6SlYYnklW2+w==
Date:   Tue, 18 Sep 2018 03:19:27 +0000
Message-ID: <20180918031754.113013-13-Tianyu.Lan@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;HK0P153MB0115;6:l1fLj0YGB/F5BUTqVz7QxitxqO8jsnzLbHYrKGd7uMKnT9gIK5CG/cgLHnUpB49rlgg8ZaBjY/V6OZFm4bTOHjid9aes8wEOnCup61nHaHqmbFccXAMsvBKHbEeicENx74iDqGzV+QnrYJJ7iwCtRNhxNjITy1M1pAj1iBw4ENouWic0LA3Sy3JlMFwqj1bws7woAAWtY85uuI4jkKMzkUK0LHStkBZSsHTnjj73ltKh5PQfAjaCwjhonEv1TMCjx7rRq29uwVz71l3rndOi2NJuan6V5EGi1KPy3Iz/sGcuq77W+u6jpKRuLQ1kPh6seOM/TdZtDQVrPOcYquUdysoIP/Otb0c8R55F4zbzsLtQnsAcOLCE98JLvaszq5ZXPuTIuQFmBdRBg5CpvRcTLf1yEX1JW7rZT2ubLTldVduDT3s4PK+TqHgu40NWp7HczP6WaFKpgjPXkDF9nBNZ6Q==;5:FbWW8CEu7iM4o1k2dDMMSOLfFCMTCtb6oxkTxvDBChBbW9KRR3yMMqALVkRc/MNgBOEETQXGsyvz0FbeArcAiHTae7wB48Y6pHDzP7aN++eWCgCWfAqDVNYKnY6hvc7WKynlkmXzhxy0x33jAWLzmTfYsqVcSB9nlh5ZaGpaU5c=;7:FlUUcfcYjew815MpjPGB+J9QFUVJvvqSJUF2tj3ilwNnkjQ21UhjMWIBDdn/L4bhkF/CWWcNRlIFoC6pV82XMuTsPgWUXBGJlEzLxd9fT2XrYiNOmfVnr2SFpMKfg8HnSHzXOuSko7XomRGBnhMY6969L7fmFFgnxWu2X2d/LgA4cVWx/7Myaj1EjxFc7DwBhQ1ncASqd9IGGzXFgYc6BIVcvoNbFb7C4Di29fRre5QFsJLcCq7FxrZEyvOKvs0q
x-ms-office365-filtering-correlation-id: 26724774-7440-4894-643e-08d61d158a8b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:HK0P153MB0115;
x-ms-traffictypediagnostic: HK0P153MB0115:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <HK0P153MB01154AF9BF198ACB11EBCDA0921D0@HK0P153MB0115.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231355)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(201708071742011)(7699050);SRVR:HK0P153MB0115;BCL:0;PCL:0;RULEID:;SRVR:HK0P153MB0115;
x-forefront-prvs: 0799B1B2D7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(376002)(39860400002)(346002)(136003)(199004)(189003)(97736004)(59246006)(316002)(6436002)(22452003)(6486002)(5660300001)(2900100001)(10090500001)(2906002)(6512007)(7736002)(305945005)(5250100002)(54906003)(25786009)(99286004)(4326008)(72206003)(10290500003)(478600001)(8936002)(105586002)(106356001)(109986005)(107886003)(81156014)(81166006)(76176011)(14454004)(6506007)(66066001)(68736007)(36756003)(86612001)(1671002)(26005)(256004)(486006)(14444005)(1076002)(53936002)(8676002)(446003)(11346002)(2616005)(476003)(102836004)(86362001)(3846002)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:HK0P153MB0115;H:HK0P153MB0129.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: j6K/FpT3vvxK645q/Kh4V16ABUPGKZvZhFAFFRnRQoGH1EKzgyu0lduuXSN5naAMQE/Ij7dINyDXl2eArC20z2FKCHeZWIK3ShcE8qn7/WplxDW1LbDmZWhPyMxIWCX8k5x4RTUPdcDaJVHd4Bl6F7Q7+H4Yo2Njpw0HkU9q7n1wk80alzY6Ei+PKmTY2CITgCdn0nSD7B0c+0iCCxZ/qrqB9TppHxsC0BgDPYE2dvmy3esYX3jvw7m047u/mX24CYRpB5/DbImb40aB2Fcjw8/NybNqqt2AOfUoN7XaVwfNDgrbWs/rBxfTIQnST5SK1qXhERug6NORYFPowyLgy/MtUKaB/RFvWQNSAC+3lHQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26724774-7440-4894-643e-08d61d158a8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2018 03:19:27.1140
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0115
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If ept table pointers are mismatched, flushing tlb for each vcpus via
hv flush interface still helps to reduce vmexits which are triggered
by IPI and INEPT emulation.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/kvm/vmx.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 533a327372c8..2869c3e78168 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -1557,7 +1557,8 @@ static void check_ept_pointer_match(struct kvm *kvm)
=20
 static int vmx_hv_remote_flush_tlb(struct kvm *kvm)
 {
-	int ret;
+	struct kvm_vcpu *vcpu;
+	int ret =3D -ENOTSUPP, i;
=20
 	spin_lock(&to_kvm_vmx(kvm)->ept_pointer_lock);
=20
@@ -1565,14 +1566,14 @@ static int vmx_hv_remote_flush_tlb(struct kvm *kvm)
 		check_ept_pointer_match(kvm);
=20
 	if (to_kvm_vmx(kvm)->ept_pointers_match !=3D EPT_POINTERS_MATCH) {
-		ret =3D -ENOTSUPP;
-		goto out;
+		kvm_for_each_vcpu(i, vcpu, kvm)
+			ret |=3D hyperv_flush_guest_mapping(
+				to_vmx(kvm_get_vcpu(kvm, i))->ept_pointer);
+	} else {
+		ret =3D hyperv_flush_guest_mapping(
+				to_vmx(kvm_get_vcpu(kvm, 0))->ept_pointer);
 	}
=20
-	ret =3D hyperv_flush_guest_mapping(
-			to_vmx(kvm_get_vcpu(kvm, 0))->ept_pointer);
-
-out:
 	spin_unlock(&to_kvm_vmx(kvm)->ept_pointer_lock);
 	return ret;
 }
--=20
2.14.4
