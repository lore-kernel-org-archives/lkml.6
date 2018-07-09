Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA1DFC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7410420673
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="h2htL27f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7410420673
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932699AbeGIJCi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 05:02:38 -0400
Received: from mail-sg2apc01on0127.outbound.protection.outlook.com ([104.47.125.127]:32416
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754398AbeGIJCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 05:02:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IlPBDu7bxJdu3Eig+KRPR5gScMsOEQ2e2iKT2V3Y988=;
 b=h2htL27fCmC0JiPvI2FwjVaMsfFFaJ3gRnynShqfbJaHQ19Ra5Id6zLebsOJ37q/KvuhyeHVxLPvawSZNZzqILlN8di0fD9Nk2nO2h0qChbPeFM6P95RWh9x46HbbQOLNyeGlO0uyCPc2agD8IdFGmZTOuJXXFhIPYbdWAScXeo=
Received: from SG2P15301MB0093.APCP153.PROD.OUTLOOK.COM (10.170.136.145) by
 SG2P15301MB0063.APCP153.PROD.OUTLOOK.COM (10.170.136.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.15; Mon, 9 Jul 2018 09:02:29 +0000
Received: from SG2P15301MB0093.APCP153.PROD.OUTLOOK.COM
 ([fe80::f916:a637:8730:be25]) by SG2P15301MB0093.APCP153.PROD.OUTLOOK.COM
 ([fe80::f916:a637:8730:be25%4]) with mapi id 15.20.0952.013; Mon, 9 Jul 2018
 09:02:29 +0000
From:   Tianyu Lan <Tianyu.Lan@microsoft.com>
CC:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>
Subject: [PATCH V2 0/5] KVM/x86/hyper-V: Introduce PV guest address space
 mapping flush support
Thread-Topic: [PATCH V2 0/5] KVM/x86/hyper-V: Introduce PV guest address space
 mapping flush support
Thread-Index: AQHUF2OPc6l/VDQYCUCP6LQoqrm/2w==
Date:   Mon, 9 Jul 2018 09:02:28 +0000
Message-ID: <20180709090218.15342-1-Tianyu.Lan@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SG2P15301MB0063;7:SwgFGpw5IJ1rRO0PRi8zs0IC6X3xwjgSBklCITNoJBH5nrLzuj+kk2Q1CgCgUgmE+9RqLRFS4ybCpTMFGLxxb18xGUMbQEmvyMPcBmT6PrD+a9qC4ATdjwNOpdFBuB4oH4gA2uD1qma6e5rOqTn+sfTf+WGjoPeZ6quefzy28JTtk3681kFY4xLrWUXwGePEMhfux7gVVvgodpve95DXcbX6uyKJlHqH8zgLyWqZeYswzcBkvz060nv65yoWa+Vm
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 8c0f876f-1a53-4611-bb8e-08d5e57ab2cd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(2017052603328)(7193020);SRVR:SG2P15301MB0063;
x-ms-traffictypediagnostic: SG2P15301MB0063:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tianyu.Lan@microsoft.com; 
x-microsoft-antispam-prvs: <SG2P15301MB006343616D2EB60A7545FC8E92440@SG2P15301MB0063.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:SG2P15301MB0063;BCL:0;PCL:0;RULEID:;SRVR:SG2P15301MB0063;
x-forefront-prvs: 07283408BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(396003)(366004)(39860400002)(346002)(199004)(189003)(256004)(105586002)(86362001)(6486002)(72206003)(66066001)(59246006)(86612001)(6512007)(97736004)(6436002)(2616005)(476003)(8936002)(486006)(14454004)(7416002)(81156014)(81166006)(8676002)(4326008)(109986005)(68736007)(25786009)(2900100001)(106356001)(6116002)(3846002)(1076002)(36756003)(5660300001)(53936002)(305945005)(7736002)(1671002)(5250100002)(54906003)(99286004)(26005)(102836004)(22452003)(10090500001)(10290500003)(2906002)(478600001)(6506007)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:SG2P15301MB0063;H:SG2P15301MB0093.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: X0zPcJ3BRbu+7p0m7u181Q6hKGMdFqI+OcANva44dCCW+bBttIDQAsrK8qbktPZtWeB+1RJAq2Ta4bIv+Pl3x5EwXfwUlipwIvO9Kp7RUcHYaEqakmnwHj/rbTQajZPmR1M1h0XvQYm8cVJgisneyfgyuJ0wtFuiy3CH19IXoMToZ8sVTRhy4mvRBUf2FNi6wZxnD0MmoZWcvmUxTFzse/kyFaisRifB9xHx8JxcGRfG2Qfn8pqC9OULNlOnhy3IKb/iZgwnKmwx4ochRDN786ngom9KmBwfw+OU1zDAlHa2NDBydR5HyhB0NKpiYDkrRvtHwHdrSrEnsqE4LWnnamG5Lnb3y4mYWP8R2exXuNA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c0f876f-1a53-4611-bb8e-08d5e57ab2cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2018 09:02:28.6287
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2P15301MB0063
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hyper-V provides a para-virtualization hypercall HvFlushGuestPhysicalAddres=
sSpace
to flush nested VM address space mapping in l1 hypervisor and it's to reduc=
e overhead
of flushing ept tlb among vcpus. The tradition way is to send IPIs to all a=
ffected
vcpus and executes INVEPT on each vcpus. It will trigger several vmexits fo=
r IPI and
INVEPT emulation. The pv hypercall can help to flush specified ept table on=
 all vcpus
via one single hypercall.

Change since v1:
       - Fix compilation error for non-x86 platform.
       - Use ept_pointers_match to check condition of identical ept
table pointer and get ept pointer from struct vcpu_vmx->ept_pointer.
       - Add hyperv_nested_flush_guest_mapping ftrace support

Lan Tianyu (5):
  X86/Hyper-V: Add flush HvFlushGuestPhysicalAddressSpace hypercall
    support
  KVM: Add tlb remote flush callback in kvm_x86_ops.
  KVM/VMX: Add identical ept table pointer check
  KVM/x86: Add tlb_remote_flush callback support for vmx
  X86/Hyper-V: Add hyperv_nested_flush_guest_mapping ftrace support

 arch/x86/hyperv/Makefile            |  2 +-
 arch/x86/hyperv/nested.c            | 67 +++++++++++++++++++++++++++++++++=
++++
 arch/x86/include/asm/hyperv-tlfs.h  |  8 +++++
 arch/x86/include/asm/kvm_host.h     | 11 ++++++
 arch/x86/include/asm/mshyperv.h     |  2 ++
 arch/x86/include/asm/trace/hyperv.h | 14 ++++++++
 arch/x86/kvm/vmx.c                  | 59 ++++++++++++++++++++++++++++++++
 include/linux/kvm_host.h            |  7 ++++
 virt/kvm/kvm_main.c                 | 11 +++++-
 9 files changed, 179 insertions(+), 2 deletions(-)
 create mode 100644 arch/x86/hyperv/nested.c

--=20
2.14.3
