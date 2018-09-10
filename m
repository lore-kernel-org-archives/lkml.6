Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 664B4C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 133E52086B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="DO0Us8j7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 133E52086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbeIJNcn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 09:32:43 -0400
Received: from mail-pu1apc01on0093.outbound.protection.outlook.com ([104.47.126.93]:58144
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728270AbeIJNcm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 09:32:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fPuyd2egQYZrW7Py5IBhckWnW7YkETZF0szXIFmGcoM=;
 b=DO0Us8j7OWDwc7guLViyCkxKLNIb7lCWL1KA+DHr6ilE9vkTNBviA2lR4YdCXAXqV5hu44B0c5u0qrfjYmquoko9mPwtltlo+D2nXqrjUoa8LU1cSKcxG3EJ1lH5Q73FX17emaDzxicZ4i6ONVNvyGsqj6Y8mbYHmyLnYNs48mY=
Received: from HK0P153MB0129.APCP153.PROD.OUTLOOK.COM (52.133.156.18) by
 HK0P153MB0178.APCP153.PROD.OUTLOOK.COM (52.133.212.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.6; Mon, 10 Sep 2018 08:39:40 +0000
Received: from HK0P153MB0129.APCP153.PROD.OUTLOOK.COM
 ([fe80::194c:c2f9:171:1890]) by HK0P153MB0129.APCP153.PROD.OUTLOOK.COM
 ([fe80::194c:c2f9:171:1890%5]) with mapi id 15.20.1143.010; Mon, 10 Sep 2018
 08:39:40 +0000
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
Subject: [PATCH 12/13] KVM/VMX: Change hv flush logic when ept tables are
 mismatched.
Thread-Topic: [PATCH 12/13] KVM/VMX: Change hv flush logic when ept tables are
 mismatched.
Thread-Index: AQHUSOHQmms3tZ5sWk6SwXc3sY6QqA==
Date:   Mon, 10 Sep 2018 08:39:40 +0000
Message-ID: <20180910083806.65177-13-Tianyu.Lan@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;HK0P153MB0178;6:5E0QxBoeNLzGkQ3R6Lcw/nAe2H56hwEBxHKgut3Y/zo409BCsAfzpBN8Gg6puRLq5VwlVFHjL95NOybNRC8p2+MJdRpMvbn1rdeh673ILssAiEwOS1oR+8qZ5H5wesU8oTtTPFVUpiwJo6+FHFchRFqPC9d0d7x/MqjvtMKgGPpY5+3IGKa7CJo2eQWoLcMVlMUmkIRXuqYBREgEMtoOgsAYVEziAACB1vzykaG1l7ACzTsQ1ihk3sl+UP5rtp9vD+C51GSa3/4mqEtTUSO7TWGvy2v8qd1V9pU5jn8Q1hv5isXKAojpDus2aeoSl1Cy2I/pt7E/fdevXWeR41nUSSApmgnwYa7Y1i18qXIRVIeKogWM1WM9od8+o/qes2Og+lktw6jXwClu1SbIZwIs4i7wGu3C3YXenK7lTFzagVqUnJnFP+YpeDfZiKFTSX7qWYb4x5PPGjJKFGYBTg5xUg==;5:ZlDUVBpFcAB/St4/SxIAnY/xx9LAN2vrxosCQPY8oxP2Zg2XVST9hKGmYHTrj7dsJKyjTsAuWKhuwN12L5kFlZps4KlTIp4tuzt8x1b9XD2Ll50+H510W5MYi/ZOjg7hv+/F77t0FZoBOWNuMAHr0FdYPuypaKukFOuuz1VQ7iE=;7:+tdTG20dZp2oM3gcDWqyFpALOvDFZk84fM2EbTdQQ4EiLoFD1oSpE6Y+09TTfpNINLnm+9AIdjVgvepTH9/JeQY+GzLc91DSH4ixMjHzC7ObfMGfwYKbtNYvRUXKkDncyrQAvnNhTMwMVBIMWw4cB+oRZYo1RhPOFipJqyhB1QiQmJOhl44kOzPTwgfH9WpAcR8z4MEA//3U4Ds+EFJmBdmDMkIQufcL2psNHxOSEB1UvugRDgeO1QCf2W6brGKW
x-ms-office365-filtering-correlation-id: 450082d2-7937-46a0-f0ac-08d616f8f330
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:HK0P153MB0178;
x-ms-traffictypediagnostic: HK0P153MB0178:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <HK0P153MB0178C2D15E21FA80FA035E5D92050@HK0P153MB0178.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699050);SRVR:HK0P153MB0178;BCL:0;PCL:0;RULEID:;SRVR:HK0P153MB0178;
x-forefront-prvs: 07915F544A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39850400004)(136003)(366004)(346002)(396003)(189003)(199004)(7736002)(14454004)(478600001)(105586002)(36756003)(97736004)(305945005)(4326008)(10090500001)(486006)(53936002)(99286004)(5660300001)(10290500003)(6116002)(6436002)(72206003)(446003)(76176011)(11346002)(1671002)(2906002)(2616005)(6486002)(59246006)(476003)(66066001)(107886003)(109986005)(68736007)(8676002)(14444005)(54906003)(81156014)(81166006)(5250100002)(256004)(1076002)(6506007)(316002)(22452003)(26005)(25786009)(8936002)(6512007)(102836004)(86612001)(106356001)(3846002)(2900100001)(575784001)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:HK0P153MB0178;H:HK0P153MB0129.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 47y46UE/SAHsxfMjloIO0UJTxCN7Onhqd/4cKUbQdZ/eb+GbhEc2li/0cT5CoXj2ywBZvN4sdPU+V+sqEeZFg9l/9C+RVObyDF19bmt1qF8awUpyPcxZaTslM40CS6o7hGcVCwdHeCfTmAdzS0uny3XF2Qtula+wSLh6VqsoqZLOGg6Y6uUI505pxALCxQRkUeEGFTPEeO9ZfbKQSDvsw6OwxopGZ9l6s5jWXHjZaqbMdt/b6aYYZVMJyxW8gMd4DPNTMi4sTKSSbOMA0Pvj8wQbuj84fdt6NRqRgBdedKJdzPU00qOsa7t4VTlwwdCBW5UVuuVr1v61aSFYkqKL6G7n4ofQRucfBV303hV9+SE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 450082d2-7937-46a0-f0ac-08d616f8f330
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2018 08:39:40.3482
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0178
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
index f910d33858d9..3f9ccbafd0d8 100644
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
