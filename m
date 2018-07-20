Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B515AECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 03:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5485220833
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 03:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="C+rN5Gjh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5485220833
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbeGTEo7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 00:44:59 -0400
Received: from mail-cys01nam02on0130.outbound.protection.outlook.com ([104.47.37.130]:63040
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726348AbeGTEo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 00:44:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T5/djRR6qctWyHb5zGDYkiF1KO9drU7gbDWrG2hmku0=;
 b=C+rN5GjheYxMBwBnGCzr4VF5MGjLeMltKGwNLA/rnXpEhaqalvqaXs4Zs1qOG5dDr0OxZ4y6UicpQ6ij72hIbHfG2VaNndJQW/czr26SXVENjtg1KYQ+CRYrpaTXpIYEW+bM+FgeXTUeeBHh3wdgqZJkQ18ZmMGwd6yHMpIaCKA=
Received: from MW2PR2101MB1113.namprd21.prod.outlook.com (52.132.149.30) by
 MW2PR2101MB1082.namprd21.prod.outlook.com (52.132.149.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.0; Fri, 20 Jul 2018 03:58:43 +0000
Received: from MW2PR2101MB1113.namprd21.prod.outlook.com
 ([fe80::826:2e6f:6ca7:fd53]) by MW2PR2101MB1113.namprd21.prod.outlook.com
 ([fe80::826:2e6f:6ca7:fd53%2]) with mapi id 15.20.0995.008; Fri, 20 Jul 2018
 03:58:43 +0000
From:   KY Srinivasan <kys@microsoft.com>
To:     Tianyu Lan <Tianyu.Lan@microsoft.com>
CC:     "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>
Subject: RE: [PATCH V3 0/4] KVM/x86/hyper-V: Introduce PV guest address space
 mapping flush support
Thread-Topic: [PATCH V3 0/4] KVM/x86/hyper-V: Introduce PV guest address space
 mapping flush support
Thread-Index: AQHUHzwUffUmbGD3SUGBq0C4VrI5YKSXfQNA
Date:   Fri, 20 Jul 2018 03:58:43 +0000
Message-ID: <MW2PR2101MB1113BF48AF4E3802CC29A10EA0510@MW2PR2101MB1113.namprd21.prod.outlook.com>
References: <20180719083946.121493-1-Tianyu.Lan@microsoft.com>
In-Reply-To: <20180719083946.121493-1-Tianyu.Lan@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2601:600:a280:b50:451e:741f:c366:1a11]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1082;6:RMRYg0i6zJ2+xMjjqy3JN/yIkxTQrNPIqSFUvPogO8zrvXKCxW+MPbwG/qkCM1kn9R1/E766gTa3cbGl3AeciNJAiU6N/FkfHo049YLlP0jW3ZoG2ClPD22nluELvunyGJ7HzUYNjKYEYS+A21zLiqvbrffHwRLdeBtsdjrTdqIzK34ss8CA5ZIiq9KslyyW+IcHNWag6NcBX4RpQ4JuBv4SEAXnrD1L3X03R6fiGV92/wp5h76ChNzDuTjnWz7fwmgHPnMTy/k4q+RYuBsnjGtIzVgpALa8wImfRyGuu25IUKQ0tIa+Dd8pOILOzFPmC3Q3e9BJ8eUTtkbcu1G42z05lgKZEhU3ROPBl5diH/vRq/O4ITDZp68lqs3xdOxKppeUB9OHIuPJ+rh40ciiNf6SWixJK+fI/05EvSVbhocXQ+QcjHkQHKeVmecGLt/cgH0RhvGRRvkJXhz8hJ+AZA==;5:KLHkTMIXCtxUkt4n9g86csRyEjbYpNtEOU664+uDCT8eak4TCLMreoZrMHjDtqdTYfIrtxWW4ZFek7ZtHu/YqMM4OoN+XcU4cFShNPMM0ZKSp9CaaLtnZWt6SS+yKTqdEpJS4D5P+WaumJ9uokLZZKyOYaK0zfjOAsY8rIS78FM=;7:y29eOHsj2k4hFnwzJnfx5DFLEtvxHc9Jeo6M6AUZYtIhNcW3YFti56rtN87Z4c0BaWIz/kK2PYHhqsJjNXdqdC0WYn0KEpDndzmWyfdrIU5rMdfLPM/+0siZc4SjZg8VyDzYekeDpGl8hDBYiSmibz66ElMWKY29yEVEtlc/yxN2+ky0Pgjtk8+b7/NAZojtJQd2YwXKPUMgljq5MszSTafsrX+p60KUKNGil0rOIra/T0RrMK7i6CWC76wprlvH
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 2f6721e8-9ae5-4808-fb30-08d5edf5160c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600067)(711020)(4618075)(2017052603328)(7193020);SRVR:MW2PR2101MB1082;
x-ms-traffictypediagnostic: MW2PR2101MB1082:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kys@microsoft.com; 
x-microsoft-antispam-prvs: <MW2PR2101MB1082A48FB42ED59BBCE8BAA5A0510@MW2PR2101MB1082.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:MW2PR2101MB1082;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1082;
x-forefront-prvs: 073966E86B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(346002)(366004)(39860400002)(376002)(13464003)(189003)(199004)(102836004)(486006)(446003)(476003)(46003)(97736004)(6636002)(2906002)(8990500004)(86612001)(10290500003)(478600001)(6246003)(11346002)(5250100002)(99286004)(105586002)(6506007)(2900100001)(68736007)(86362001)(1511001)(106356001)(256004)(6116002)(22452003)(10090500001)(6436002)(316002)(229853002)(76176011)(9686003)(55016002)(7696005)(14454004)(305945005)(7736002)(7416002)(33656002)(53936002)(81166006)(81156014)(74316002)(4326008)(8676002)(54906003)(5660300001)(25786009)(6862004)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1082;H:MW2PR2101MB1113.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: tUaSWSZB8AFMLRy66l99EzQjEGAH/oRKw8TBw93pYfxypMpehQGybE2bKFMR1u0mrC2UYoe6+/+MnGq4lyseiJ6UiLRxFPRHsHsxtsl8vI64wPyzQ8rJUkpDFlqps70r34HxDKbWfCl18DZhFIRZdP8MYFwDHHaSvSEvYnJ1DZZ02VQEwqWvTR6c7feTNYZsqDCeIIlfARv+B+0+wSb9W4/A0gA42liLmYoJJRkQHMUbeq1/3Ja/UAeZJu4WklK1+7awUoZbi9NLPkRNlQS7GxQymbHHlWjLsg2+ZX0uAqqIVyM4mTFcvDT1l+04lWhHJD4QkrSlM4oJS3f7lpvrEi5YqEFr7ByL+FYekbyzVhY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f6721e8-9ae5-4808-fb30-08d5edf5160c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2018 03:58:43.4419
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1082
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Tianyu Lan
> Sent: Thursday, July 19, 2018 1:40 AM
> Cc: Tianyu Lan <Tianyu.Lan@microsoft.com>; devel@linuxdriverproject.org;
> Haiyang Zhang <haiyangz@microsoft.com>; hpa@zytor.com;
> kvm@vger.kernel.org; KY Srinivasan <kys@microsoft.com>; linux-
> kernel@vger.kernel.org; mingo@redhat.com; pbonzini@redhat.com;
> rkrcmar@redhat.com; Stephen Hemminger <sthemmin@microsoft.com>;
> tglx@linutronix.de; x86@kernel.org; Michael Kelley (EOSG)
> <Michael.H.Kelley@microsoft.com>; vkuznets@redhat.com
> Subject: [PATCH V3 0/4] KVM/x86/hyper-V: Introduce PV guest address
> space mapping flush support
>=20
> Hyper-V provides a para-virtualization hypercall
> HvFlushGuestPhysicalAddressSpace
> to flush nested VM address space mapping in l1 hypervisor and it's to red=
uce
> overhead
> of flushing ept tlb among vcpus. The tradition way is to send IPIs to all
> affected
> vcpus and executes INVEPT on each vcpus. It will trigger several vmexits =
for
> IPI and
> INVEPT emulation. The pv hypercall can help to flush specified ept table =
on all
> vcpus
> via one single hypercall.
>=20
> Change since v2:
>        - Make ept_pointers_match as tristate "check", "match" and "mismat=
ch".
>        Set "check" in vmx_set_cr3(), check all ept table pointers in
> hv_remote_flush_tlb()
>        and call hypercall when all ept pointers are same.
>        - Rename kvm_arch_hv_flush_remote_tlb with
> kvm_arch_flush_remote_tlb and
>        Rename kvm_x86_ops->hv_tlb_remote_flush with kvm_x86_ops-
> >tlb_remote_flush
>        - Fix issue that ignore updating tlbs_dirty during calling
> kvm_arch_flush_remote_tlbs()
>        - Merge patch "KVM/VMX: Add identical ept table pointer check" and
>        patch "KVM/x86: Add tlb_remote_flush callback support for vmx"
>=20
> Change since v1:
>        - Fix compilation error for non-x86 platform.
>        - Use ept_pointers_match to check condition of identical ept
>             table pointer and get ept pointer from struct vcpu_vmx->ept_p=
ointer.
>        - Add hyperv_nested_flush_guest_mapping ftrace support
>=20
>=20
>=20
> Lan Tianyu (4):
>   X86/Hyper-V: Add flush HvFlushGuestPhysicalAddressSpace hypercall
>     support
>   X86/Hyper-V: Add hyperv_nested_flush_guest_mapping ftrace support
>   KVM: Add tlb remote flush callback in kvm_x86_ops.
>   KVM/x86: Add tlb_remote_flush callback support for vmx
>=20
>  arch/x86/hyperv/Makefile            |  2 +-
>  arch/x86/hyperv/nested.c            | 67
> ++++++++++++++++++++++++++++++++++
>  arch/x86/include/asm/hyperv-tlfs.h  |  8 +++++
>  arch/x86/include/asm/kvm_host.h     | 11 ++++++
>  arch/x86/include/asm/mshyperv.h     |  2 ++
>  arch/x86/include/asm/trace/hyperv.h | 14 ++++++++
>  arch/x86/kvm/vmx.c                  | 72
> ++++++++++++++++++++++++++++++++++++-
>  include/linux/kvm_host.h            |  7 ++++
>  virt/kvm/kvm_main.c                 |  3 +-
>  9 files changed, 183 insertions(+), 3 deletions(-)
>  create mode 100644 arch/x86/hyperv/nested.c

Acked-by: K. Y. Srinivasan <kys@microsoft.com>

>=20
> --
> 2.14.3
