Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0DB0C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63FBB250A3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="H1pfr0rf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63FBB250A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752335AbeGBORk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 10:17:40 -0400
Received: from mail-eopbgr1280124.outbound.protection.outlook.com ([40.107.128.124]:34826
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751581AbeGBORb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 10:17:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xKbf65I1ThxP/ArFlW5FhOfkjU5+ZVQh375FuEE/sdE=;
 b=H1pfr0rfIr3GKQn6sExku27E2Z44x9B1B7byGR9Tb1M/0cCE+TfiFYqDnTqxhO8G3yjnhMpdronMRJdIaHRUdRmTw6TwqgNkg0OvKjYl/Li4PAop8zdsQiGSqIbP5i9pjw326E9oqheZSxjO1xb5pJLHhc+0mO9VuwQXZu1WaYk=
Received: from KU1P153MB0150.APCP153.PROD.OUTLOOK.COM (10.170.172.151) by
 KU1P153MB0133.APCP153.PROD.OUTLOOK.COM (10.170.172.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.4; Mon, 2 Jul 2018 14:17:25 +0000
Received: from KU1P153MB0150.APCP153.PROD.OUTLOOK.COM
 ([fe80::3117:172e:121:d0e]) by KU1P153MB0150.APCP153.PROD.OUTLOOK.COM
 ([fe80::3117:172e:121:d0e%5]) with mapi id 15.20.0952.005; Mon, 2 Jul 2018
 14:17:25 +0000
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
Subject: [PATCH 2/4] KVM: Add tlb remote flush callback in kvm_x86_ops.
Thread-Topic: [PATCH 2/4] KVM: Add tlb remote flush callback in kvm_x86_ops.
Thread-Index: AQHUEg9m5H/WiURYK0O2BmjxbRNbxA==
Date:   Mon, 2 Jul 2018 14:17:24 +0000
Message-ID: <20180702141653.88936-3-Tianyu.Lan@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;KU1P153MB0133;7:et6FLCeEV2ZEOZp+QIRtqHPL4dMCXCQWVpODnnPlzLPUWu4Eve/S6jLTWE5bS6Txt5KD+UdylIcf8iBhWWEucMCJMkSeZsRzk2InFFH6tb4ZmantY3b3fzO6mNfDYzgven2wgEBb8JXo4rTxrzeggZYs4i4FFn7iXAg5A9iOuxvfVr0M0WVoPfCPOH8901x5MpBTmLvb7p5XjbpRyIUn0UYzlL1v4P0Ee7t3ZTz90mWYLYX3bslVsOx0/ztnkP9C
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 0270ebf8-492f-435f-70d3-08d5e02688c9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(2017052603328)(7193020);SRVR:KU1P153MB0133;
x-ms-traffictypediagnostic: KU1P153MB0133:
x-microsoft-antispam-prvs: <KU1P153MB01332C68BA792C2BDC6BF63B92430@KU1P153MB0133.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:KU1P153MB0133;BCL:0;PCL:0;RULEID:;SRVR:KU1P153MB0133;
x-forefront-prvs: 07215D0470
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(136003)(39860400002)(346002)(376002)(199004)(189003)(1671002)(54906003)(476003)(446003)(486006)(59246006)(36756003)(26005)(102836004)(22452003)(11346002)(2616005)(316002)(97736004)(2900100001)(14454004)(6486002)(109986005)(86362001)(86612001)(68736007)(6512007)(4326008)(25786009)(6436002)(10090500001)(53936002)(66066001)(5660300001)(105586002)(106356001)(8936002)(2906002)(305945005)(7736002)(99286004)(256004)(14444005)(72206003)(6506007)(10290500003)(76176011)(3846002)(8676002)(1076002)(81166006)(81156014)(478600001)(5250100002)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:KU1P153MB0133;H:KU1P153MB0150.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: XPl1ddUO5ONQliZNfbJCjo9FOeG6AJc2NV9tgsTQ77Laxl8/dxJPc9ARwrC2UU9B/wlkBPaImxsA2opeFA5fqtx4DvoQTCVXaZuH1FVtbSAgByGFa4VAg8spJGQ7euRD6tMwU9ppYdxvyIGWWLgjR5CDe4dnfh3gEcztZrRnbqQUql6sAR5/Fr38B4sP4bJp+Jrtcxihl439dlxA/b5yELpSw/YKTtoM01QZJ2ZPtXGNzCVWWYV6x3LY5ntK/S9zMirVkR4zKNtvamFb/lVZI/WGyhCODohvBb9nX5Dvq+ISu187AXBw+cPpLpF8BlEevD1GSQhTPQhAwHTAlbYLEItcw+N9bA9w0f9bQVzYa3E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0270ebf8-492f-435f-70d3-08d5e02688c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2018 14:17:24.6231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU1P153MB0133
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is to provide a way for platforms to register tlb remote
flush callback and this helps to optimize operation of tlb flush
among vcpus for nested virtualization case.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/include/asm/kvm_host.h |  1 +
 virt/kvm/kvm_main.c             | 12 +++++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_hos=
t.h
index c13cd28d9d1b..94d7437d84cb 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -973,6 +973,7 @@ struct kvm_x86_ops {
 	void (*set_rflags)(struct kvm_vcpu *vcpu, unsigned long rflags);
=20
 	void (*tlb_flush)(struct kvm_vcpu *vcpu, bool invalidate_gpa);
+	int  (*tlb_remote_flush)(struct kvm *kvm);
=20
 	void (*run)(struct kvm_vcpu *vcpu);
 	int (*handle_exit)(struct kvm_vcpu *vcpu);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 8b47507faab5..580bed127dd0 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -256,11 +256,21 @@ bool kvm_make_all_cpus_request(struct kvm *kvm, unsig=
ned int req)
 #ifndef CONFIG_HAVE_KVM_ARCH_TLB_FLUSH_ALL
 void kvm_flush_remote_tlbs(struct kvm *kvm)
 {
+	long dirty_count;
+
+	/*
+	 * Call tlb_remote_flush first and go back old way when
+	 * return failure.
+	 */
+	if (kvm_x86_ops->tlb_remote_flush &&
+	    !kvm_x86_ops->tlb_remote_flush(kvm))
+		return;
+
 	/*
 	 * Read tlbs_dirty before setting KVM_REQ_TLB_FLUSH in
 	 * kvm_make_all_cpus_request.
 	 */
-	long dirty_count =3D smp_load_acquire(&kvm->tlbs_dirty);
+	dirty_count =3D smp_load_acquire(&kvm->tlbs_dirty);
=20
 	/*
 	 * We want to publish modifications to the page tables before reading
--=20
2.14.3
