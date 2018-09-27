Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19785C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 03:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5E5721533
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 03:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="icVg3G/u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5E5721533
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbeI0KGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 06:06:14 -0400
Received: from mail-sg2apc01on0117.outbound.protection.outlook.com ([104.47.125.117]:56048
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726684AbeI0KGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 06:06:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vkM1XDOasZe08xhGjYX+1tcGXbLIMOabyyqCPCQ98DY=;
 b=icVg3G/uUwvDwNf2/byxmP1xYS0xiMAVCGdbrT/uhxL/4LoeYOvHReMgygau4HTE/iDr6c2vQa00aO0ZG5ol8Ud4GlH9OGah4LnOR6jmc49V/LY+HjwaQfug8Z6QIqsZe13IMpZsJ8gHUAdQ9O6Jy6VpvW9mGPIgo69CkCaJjOI=
Received: from HK0P153MB0129.APCP153.PROD.OUTLOOK.COM (52.133.156.18) by
 HK0P153MB0177.APCP153.PROD.OUTLOOK.COM (52.133.210.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Thu, 27 Sep 2018 03:50:01 +0000
Received: from HK0P153MB0129.APCP153.PROD.OUTLOOK.COM
 ([fe80::8584:ad93:130a:6267]) by HK0P153MB0129.APCP153.PROD.OUTLOOK.COM
 ([fe80::8584:ad93:130a:6267%3]) with mapi id 15.20.1207.011; Thu, 27 Sep 2018
 03:50:01 +0000
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
Subject: [PATCH V3 12/13] KVM/VMX: Change hv flush logic when ept tables are
 mismatched.
Thread-Topic: [PATCH V3 12/13] KVM/VMX: Change hv flush logic when ept tables
 are mismatched.
Thread-Index: AQHUVhUqMmeUDbYBlEutoL/p1B3ROQ==
Date:   Thu, 27 Sep 2018 03:50:00 +0000
Message-ID: <20180927034829.2230-13-Tianyu.Lan@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;HK0P153MB0177;6:hJMAMvhmxaK6w8U7ED785LcjjUJ/gyyZkBYi+xta1Nf/infv4JkyuY0Hwg4x7uzkEaOF9i2+x/5y+pnl+QD/JLthN0GXGGNBbiPxvfI2h9Q6w86Ha2LrOZuJ2XwOcbXKkSPFGXrE9tuxMQsejAvwUqlMLAKySly6+kwyj+E2zRu//oxZkOUpRjrvN5gnttgqXQOYa2GNltvPTyQoUjgqIl2lF0JxHOSAnpLoRzR4BF12EU2Oc737ylhxzDoIsmwpiZWDSkbeA7hReeB+SMd0v5up7TMCB6/403MoAqXKSQdGUrq3nzD0MuCzotdL2KoCwSgx34ZtOp9axHiZvQvW0O6493x4nWDc1pYe8f6Szx2GCm8wQeV8g/b8kjPeM9j5E6i7JbJHs7gmuAB+olefeSqzJYJ9ScalIrslJgsy3XX2TH+TJ04NnK1jWmiN28Icka5ZPqjfb7LeCSk6FnldnA==;5:MTGu1wfeBndk0TQNWrBRZ3dIx/I+YJu95jkIg27ZEsUF5t353SIV291XbJvU+OIzVfFcwVngYHRbr2UJIjhHQErGuo6BbAfbdA3qfkNk5Yqxe2bjlCU/OwmOvCYGlUZx2Q28m61fQXC4mhBwFs0hVd2KEJDAKxuxzTaHAX9VNB4=;7:77jF5koG6RmkY1kAcM2HzIbe+q1pT1Xt1SbES0pYhZWFhr6fBQNtSS6VQs+XF3iLCu7AwRsUv8oMIN8hD+AH8mpWOfhfObnQ8LipO0dimJFVPpBMFq8pi1G9JYSmF5jqGUWyBwF/544DStk7Cw3Fc6gL3i9WOdEYKEYytF97rPMLtku+XTTfGjXZxN8BavWi6/HJgeHXd4eXyIcAc6G9YUB9Q0Sgan+2TfeqFmxbRvbrrg65sczMPot5AbYHCCzz
x-ms-office365-filtering-correlation-id: 504c4654-0797-4d7c-f005-08d6242c4d49
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:HK0P153MB0177;
x-ms-traffictypediagnostic: HK0P153MB0177:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <HK0P153MB017746959E9364E46246A39492140@HK0P153MB0177.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051);SRVR:HK0P153MB0177;BCL:0;PCL:0;RULEID:;SRVR:HK0P153MB0177;
x-forefront-prvs: 0808323E97
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(396003)(346002)(39860400002)(366004)(199004)(189003)(105586002)(99286004)(10290500003)(486006)(478600001)(68736007)(106356001)(14454004)(72206003)(81156014)(6486002)(8676002)(6506007)(1671002)(81166006)(6512007)(2900100001)(2906002)(6436002)(76176011)(8936002)(10090500001)(3846002)(6116002)(54906003)(36756003)(316002)(59246006)(102836004)(26005)(1076002)(5660300001)(5250100002)(109986005)(107886003)(11346002)(446003)(2616005)(4326008)(25786009)(476003)(22452003)(53936002)(86612001)(86362001)(71190400001)(71200400001)(14444005)(66066001)(7736002)(256004)(305945005)(34290500001)(97736004);DIR:OUT;SFP:1102;SCL:1;SRVR:HK0P153MB0177;H:HK0P153MB0129.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: /54l+TwwTiQULb46A7DHOUEeY/G++cSQbz+Wd2gHThQbq8fsEdO7yDFzfcpNiW6ginvK4HT45bgx5Oih0yekV9Ox/k08zElDyRkoHEas8ahkoAkvH0e+dLjUhOeqLe7OcHgLaLHWg/kAAxlFPQHuSJGBXNOvC0l14PXPfjsPifVgnv3oYBc62Kkb4KXajoZ8+KzScNmKrN9NmKLjnJoL0c5XZRpKKwXR/vDc5CVX/OtKPd/KXpBYKaeSs3SGlvBER4d2F9fczcGOfxw7KU25XdmW5SA6DbPALYoVHJZnFrztTgDxSCmz5fXNXFUg3GXI1zeUsIlhaTgz1TNHi01iR9IDJALCepHkFQgp596dvmE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 504c4654-0797-4d7c-f005-08d6242c4d49
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2018 03:50:00.9423
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0177
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
