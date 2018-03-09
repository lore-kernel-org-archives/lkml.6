Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752009AbeCIIpS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 03:45:18 -0500
Received: from mail-sg2apc01on0115.outbound.protection.outlook.com ([104.47.125.115]:52679
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750930AbeCIIpP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 03:45:15 -0500
From: Tianyu Lan <Tianyu.Lan@microsoft.com>
CC: Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] KVM/x86: Move X86_CR4_OSXSAVE check into kvm_valid_sregs()
Thread-Topic: [PATCH] KVM/x86: Move X86_CR4_OSXSAVE check into
 kvm_valid_sregs()
Thread-Index: AQHTt4Lshqp3S23dx0Gj2UMBy27zOw==
Date: Fri, 9 Mar 2018 08:45:06 +0000
Message-ID: <1520585095-3812-1-git-send-email-Tianyu.Lan@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tianyu.Lan@microsoft.com;
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HK2P15301MB0065;7:ZGVlLtUWo9jcAJVvrwvlfB2jJs8s2so0ueHeaUFRoXpW8E18QKatra/vpMemmys0FQABdE5KU2Z7T22B/hh2+sDua8ZMYi8e5TcpU9AnpqxAljAqaD/ud3baD2pfc9VDPcHWHAsfekv1m9SWpv7+Z3n+81gNKuL77Lk52B5UWTpRs3jamblkpgF9E7qW/MqpZlYXfh5ykQzHLR21isoNj4TfwAdDpOIp71EMNTcd/bS8fLbfzBAOkQ7hQPs6iBiy;20:8p6UXB2/QiSojDYSSIFY7t4Pj6bENcY+Acb8gqvQJJG6RJCpzNX9DnsxydffVFybQhYkGk8X7PS93BGXagQltAo6FWVbWldqAuWvzaT5FgeGAkOLF4JGsI32ifNR+oUMk4k0EOAOLygXK92NWjSt9VjRY4fEG5Xg8hsT/70Ebt0=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8ed4ab42-7d3a-40f2-c0c8-08d5859a0f7d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(2017052603328)(7193020);SRVR:HK2P15301MB0065;
x-ms-traffictypediagnostic: HK2P15301MB0065:
x-microsoft-antispam-prvs: <HK2P15301MB00656F229099032D74B7438192DE0@HK2P15301MB0065.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231220)(944501244)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:HK2P15301MB0065;BCL:0;PCL:0;RULEID:;SRVR:HK2P15301MB0065;
x-forefront-prvs: 0606BBEB39
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39380400002)(366004)(39860400002)(189003)(199004)(316002)(6436002)(6512007)(54906003)(26005)(22452003)(53936002)(7736002)(66066001)(2900100001)(1857600001)(10090500001)(10290500003)(6506007)(3660700001)(478600001)(8936002)(5250100002)(86362001)(109986005)(8676002)(68736007)(102836004)(6486002)(81166006)(81156014)(25786009)(14454004)(105586002)(5660300001)(106356001)(4326008)(59246006)(99286004)(6116002)(3846002)(305945005)(86612001)(3280700002)(1671002)(72206003)(97736004)(36756003)(2906002)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:HK2P15301MB0065;H:HK2P15301MB0065.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: sGjFTLHohnoa1Y2I5LyAt+otKfoVeacayJBkvPBA+lVj0dgTT9vbibCjn/EhNF26jDq5bmt6XO8weri05FsDm/yn6MlpvNCi/H1VZM21WN9l42QhaGXu/W735wOMs/2PnAm3Kq+lWGS2JyxRzePdemSaNdUht4uQ8a09W2Y8S/XLDTmyQfM/px4uwmPMNysZNlcSa5Xl0bw92OqKKVGipgp0m0yBlu6OCJCU1F37iBaC94xnhXQEuhhXcZsQmmF0tzAX/Z53FjXg0qSm9tUAH+WsYY1wiivFSCKTSTZFI59igHJ5llxoNlaZxSa2KomYISjkDcE/WwYdpmmqNc+ijQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ed4ab42-7d3a-40f2-c0c8-08d5859a0f7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2018 08:45:07.0869
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2P15301MB0065
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w298mnE5016584

X86_CR4_OSXSAVE check belongs to sregs check and so move into kvm_valid_sregs().

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/kvm/x86.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 6c81df9..82845cb 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7812,6 +7812,10 @@ EXPORT_SYMBOL_GPL(kvm_task_switch);
 
 int kvm_valid_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
 {
+	if (!guest_cpuid_has(vcpu, X86_FEATURE_XSAVE) &&
+			(sregs->cr4 & X86_CR4_OSXSAVE))
+		return -EINVAL;
+
 	if ((sregs->efer & EFER_LME) && (sregs->cr0 & X86_CR0_PG)) {
 		/*
 		 * When EFER.LME and CR0.PG are set, the processor is in
@@ -7841,10 +7845,6 @@ static int __set_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
 	struct desc_ptr dt;
 	int ret = -EINVAL;
 
-	if (!guest_cpuid_has(vcpu, X86_FEATURE_XSAVE) &&
-			(sregs->cr4 & X86_CR4_OSXSAVE))
-		goto out;
-
 	if (kvm_valid_sregs(vcpu, sregs))
 		goto out;
 
-- 
2.7.4
