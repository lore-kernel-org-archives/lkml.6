Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A0F9C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 21:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F4DC2098B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 21:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="dr4dv+lo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F4DC2098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732330AbeGJVa0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 17:30:26 -0400
Received: from mail-sn1nam01on0136.outbound.protection.outlook.com ([104.47.32.136]:6335
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732205AbeGJVaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 17:30:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WCJ86jhwZIRLWdKAKP2+FtBjwZ73KEvkW500y/8VAXE=;
 b=dr4dv+lofQQdq6kf7rtDtKvvCR+Nggj/3NDQ7scGzmLwaHoI0G/M1pGITNQQN0SBEzjZ8lhJ04SHVP/u4mK4Z5ec+7TLCCg7oVRZBskbzEft/sAJd+q+mosgHLOBnR2L0lhiLRyumVirtriGuCv3LDzknhh//knOOVrnxpZNB54=
Received: from SN6PR2101MB1120.namprd21.prod.outlook.com (52.132.117.161) by
 SN6PR2101MB1117.namprd21.prod.outlook.com (52.132.115.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.4; Tue, 10 Jul 2018 21:29:25 +0000
Received: from SN6PR2101MB1120.namprd21.prod.outlook.com
 ([fe80::35a3:57b:9c0:9732]) by SN6PR2101MB1120.namprd21.prod.outlook.com
 ([fe80::35a3:57b:9c0:9732%4]) with mapi id 15.20.0952.017; Tue, 10 Jul 2018
 21:29:25 +0000
From:   "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
To:     Tianyu Lan <Tianyu.Lan@microsoft.com>
CC:     KY Srinivasan <kys@microsoft.com>,
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
        "vkuznets@redhat.com" <vkuznets@redhat.com>
Subject: RE: [PATCH V2 1/5] X86/Hyper-V: Add flush
 HvFlushGuestPhysicalAddressSpace hypercall support
Thread-Topic: [PATCH V2 1/5] X86/Hyper-V: Add flush
 HvFlushGuestPhysicalAddressSpace hypercall support
Thread-Index: AQHUF2OW3A0tXIhuKkm+Yu7a5XgAgaSI9u1w
Date:   Tue, 10 Jul 2018 21:29:24 +0000
Message-ID: <SN6PR2101MB11202EAE0D5C623EC0CF8273DC5B0@SN6PR2101MB1120.namprd21.prod.outlook.com>
References: <20180709090218.15342-1-Tianyu.Lan@microsoft.com>
 <20180709090218.15342-2-Tianyu.Lan@microsoft.com>
In-Reply-To: <20180709090218.15342-2-Tianyu.Lan@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-07-10T21:29:23.4929566Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR2101MB1117;7:n6euiNz20uavz+uIlPDW4jA2qbUcoOmcMlSpt1OomVcDBLIYDZb0+gI6OPEODDkHXpLwaQK7V1yzs3iRXMU0EtMwBGNXCbHAlUMphTFC4xdkb3kQ+LsqIeE4KvgQ1C9cmjKvrX2ikK93Z/zMECAefP5b3cZJdhzWeDQZ+bqW6pZSryR/Naqsf09WvcrWvoPLcDkNSyKVD1jhSy6pawBSrpwYvuS2/dbFuyURYYsyvvZGB28RP2hhKf8HmWpi9rdM
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 2356b246-c077-4132-2391-08d5e6ac35a8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(2017052603328)(7193020);SRVR:SN6PR2101MB1117;
x-ms-traffictypediagnostic: SN6PR2101MB1117:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michael.H.Kelley@microsoft.com; 
x-microsoft-antispam-prvs: <SN6PR2101MB1117A8BE59FF0B472926E62DDC5B0@SN6PR2101MB1117.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(2018427008)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:SN6PR2101MB1117;BCL:0;PCL:0;RULEID:;SRVR:SN6PR2101MB1117;
x-forefront-prvs: 0729050452
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6029001)(396003)(366004)(136003)(346002)(39860400002)(376002)(199004)(189003)(478600001)(99286004)(72206003)(68736007)(3846002)(10290500003)(6116002)(86612001)(7696005)(76176011)(5660300001)(8936002)(7736002)(26005)(305945005)(74316002)(14444005)(256004)(2906002)(446003)(7416002)(5250100002)(14454004)(22452003)(8676002)(54906003)(6506007)(86362001)(102836004)(81156014)(81166006)(486006)(316002)(476003)(11346002)(9686003)(25786009)(6436002)(105586002)(55016002)(66066001)(97736004)(4326008)(10090500001)(6862004)(2900100001)(33656002)(229853002)(6246003)(6636002)(53936002)(8990500004)(106356001)(1511001)(49343001)(213903007);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1117;H:SN6PR2101MB1120.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: SXJgXRRY5DmTM24yz21+7N26183y3f6vL7HxMrph+vj6HCu3AA62NS/FlivK0XklfVyFBcMCbgBhbac43P+wY538aBYSWsJkLAwpmlHeoY04kyVszQMuh3+Orr8FLMaTXhXWgcpBJItuuguOLJOgQEgpkhvO2HUzQAiYsiBMSa8irIaQYLBHjfCN217sIHw3a2swKr3o5S3uyGgFo42r/e6y6CHWz7hw1fmj+vHSOmEsMKxKSKTRqt9Q6bEQ3lvgaGK7UbZze7+u4XhFwsNpm49uSd7Sn3/H31HTQqGW/Hh4Aqau7uxffEWNN7jehdu+uR2KtMEZ55jdleUDey0wkMH5SR20eDGKSRz1isGPWLw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2356b246-c077-4132-2391-08d5e6ac35a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2018 21:29:24.9946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1117
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com> Monday, July 9, 2018 2:03 AM
> Hyper-V supports a pv hypercall HvFlushGuestPhysicalAddressSpace to
> flush nested VM address space mapping in l1 hypervisor and it's to
> reduce overhead of flushing ept tlb among vcpus. This patch is to
> implement it.
>=20
> Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
> ---
>  arch/x86/hyperv/Makefile           |  2 +-
>  arch/x86/hyperv/nested.c           | 64 ++++++++++++++++++++++++++++++++=
++++++
>  arch/x86/include/asm/hyperv-tlfs.h |  8 +++++
>  arch/x86/include/asm/mshyperv.h    |  2 ++
>  4 files changed, 75 insertions(+), 1 deletion(-)
>  create mode 100644 arch/x86/hyperv/nested.c
> +#include <linux/types.h>
> +#include <asm/hyperv-tlfs.h>
> +#include <asm/mshyperv.h>
> +#include <asm/tlbflush.h>
> +
> +int hyperv_flush_guest_mapping(u64 as)
> +{
> +	struct hv_guest_mapping_flush **flush_pcpu;
> +	struct hv_guest_mapping_flush *flush;
> +	u64 status;
> +	unsigned long flags;
> +	int ret =3D -EFAULT;
> +
> +	if (!hv_hypercall_pg)
> +		goto fault;
> +
> +	local_irq_save(flags);
> +
> +	flush_pcpu =3D (struct hv_guest_mapping_flush **)
> +		this_cpu_ptr(hyperv_pcpu_input_arg);
> +
> +	flush =3D *flush_pcpu;
> +
> +	if (unlikely(!flush)) {
> +		local_irq_restore(flags);
> +		goto fault;
> +	}
> +
> +	flush->address_space =3D as;
> +	flush->flags =3D 0;
> +
> +	status =3D hv_do_hypercall(HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE,
> +				 flush, NULL);

Did you consider using a "fast" hypercall?  Unless there's some reason I'm
not aware of, a "fast" hypercall would be perfect here as there are 16 byte=
s
of input and no output. Vitaly recently added hv_do_fast_hypercall16()
in the linux-next tree. See __send_ipi_mask() in hv_apic.c in linux-next
for an example of usage.  With a fast hypercall, you don't need the code fo=
r
getting the per-cpu input arg or the code for local irq save/restore, so th=
e
code that is left is a lot faster and simpler.

Michael

> +	local_irq_restore(flags);
> +
> +	if (!(status & HV_HYPERCALL_RESULT_MASK))
> +		ret =3D 0;
> +
> +fault:
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(hyperv_flush_guest_mapping);
