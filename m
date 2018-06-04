Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752240AbeFDJIl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 05:08:41 -0400
Received: from mail-hk2apc01on0110.outbound.protection.outlook.com ([104.47.124.110]:6711
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752126AbeFDJIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 05:08:36 -0400
From: Tianyu Lan <Tianyu.Lan@microsoft.com>
CC: Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>
Subject: [RFC Patch 2/3] KVM: Add tlb remote flush callback in kvm_x86_ops.
Thread-Topic: [RFC Patch 2/3] KVM: Add tlb remote flush callback in
 kvm_x86_ops.
Thread-Index: AQHT++OaghvAztGQfkKjrBIBb1LvJQ==
Date: Mon, 4 Jun 2018 09:08:28 +0000
Message-ID: <20180604090749.489-3-Tianyu.Lan@microsoft.com>
References: <20180604090749.489-1-Tianyu.Lan@microsoft.com>
In-Reply-To: <20180604090749.489-1-Tianyu.Lan@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tianyu.Lan@microsoft.com;
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SG2P15301MB0094;7:kl9FhTUo5/kUDulPw9SPTyJFQ2G8RNUb6n4bLwEIsEoVZucn/cWhnxEfcti/iFxrWdrjMh7933Pp/8YelVOoCHuL9gCozjmXLUUH6hxUcMe642fSstAjAVt2Nc3nvkuarHdf1IigZRSoI94W6X6Cc0C2YlSCrQKEc4JrZL7eEXfNPoWefig+Y5L3NQLMBUQDSePwF9ClkW7TJ+yMqOf6GNpbhJWxo6g4TClZ77SoKemd48RPllqdvkz1ayrqVnCI;20:nvsUf+N5PzkTG93RdOjdbSDenE/OghbBK6BjBHKoZ3tIr32bLSETNPBTktQjX1xtKe/zwQhcVWkLz3kI8jKnPwKvo4HKVlzxMGH0B6bjTV4lfLilX1Pw/ZMaXp3kR32K2J55CeA/wkTR9Zp4dJU2Cb6nLtG3x0ze2H1hIZ4eDbk=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(2017052603328)(7193020);SRVR:SG2P15301MB0094;
x-ms-traffictypediagnostic: SG2P15301MB0094:
x-microsoft-antispam-prvs: <SG2P15301MB0094F68619D70C5B9FBD6B7C92670@SG2P15301MB0094.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:SG2P15301MB0094;BCL:0;PCL:0;RULEID:;SRVR:SG2P15301MB0094;
x-forefront-prvs: 069373DFB6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(396003)(39380400002)(376002)(346002)(189003)(199004)(1076002)(5250100002)(6436002)(10290500003)(2906002)(6486002)(3846002)(53936002)(6116002)(86362001)(86612001)(36756003)(25786009)(72206003)(478600001)(6512007)(10090500001)(109986005)(76176011)(106356001)(59450400001)(99286004)(68736007)(5660300001)(81166006)(81156014)(4326008)(6506007)(26005)(8936002)(8676002)(105586002)(7736002)(446003)(2616005)(11346002)(97736004)(14454004)(305945005)(2900100001)(66066001)(3660700001)(3280700002)(486006)(476003)(1671002)(22452003)(316002)(102836004)(59246006)(54906003)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:SG2P15301MB0094;H:SG2P15301MB0062.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: UF3sYdohWzJGDCGuKQkwnAmWOSFs8pLfIFo9rX86EvJaELDsDYcbKVG9hmce2lY724yLE4tJ5PgAIMgDAa1WqQ8b8xDS3t89Z4dodRjqeoMnOYeAZCzXUj6g74g7hfkKlYnzvpF8W6+Lwi7KGGqjwMVg95/M6e6pPQi7RtHorUScHTNiH4xmGLmkAskC9Ps5
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 1f61d2cd-c07f-4a15-c575-08d5c9fabcf0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f61d2cd-c07f-4a15-c575-08d5c9fabcf0
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2018 09:08:28.7008
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2P15301MB0094
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w5499iDg032378

This patch is to provide a way for platforms to register tlb remote flush
callback and this helps to optimize operation of tlb flush among vcpus for
nested virtualization case.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/include/asm/kvm_host.h |  1 +
 virt/kvm/kvm_main.c             | 12 +++++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 0ebe659f2802..aaad43916f9d 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -973,6 +973,7 @@ struct kvm_x86_ops {
 	void (*set_rflags)(struct kvm_vcpu *vcpu, unsigned long rflags);
 
 	void (*tlb_flush)(struct kvm_vcpu *vcpu, bool invalidate_gpa);
+	int  (*tlb_remote_flush)(struct kvm *kvm);
 
 	void (*run)(struct kvm_vcpu *vcpu);
 	int (*handle_exit)(struct kvm_vcpu *vcpu);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index c5f6a552e486..31e2b54c6049 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -251,11 +251,21 @@ bool kvm_make_all_cpus_request(struct kvm *kvm, unsigned int req)
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
-	long dirty_count = smp_load_acquire(&kvm->tlbs_dirty);
+	dirty_count = smp_load_acquire(&kvm->tlbs_dirty);
 
 	/*
 	 * We want to publish modifications to the page tables before reading
-- 
2.14.3
