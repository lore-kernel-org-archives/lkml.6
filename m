Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78425C43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F5A12083A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="JdlEqENt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F5A12083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932430AbeFTRzo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 13:55:44 -0400
Received: from mail-eopbgr690094.outbound.protection.outlook.com ([40.107.69.94]:10545
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932099AbeFTRzn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 13:55:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aaIJ0VsDGQGUSY1O50GhdIZ8tfLE8qDFKswUUbemko0=;
 b=JdlEqENtWfOFK7yfvvKh853QYiYbcIIzMJHE66AsQKLBuWK2GtLAUZP3sQhql+GgrIKUzsD5GNlVWsQ/Jx0U0vxtu3ZkuhCXiADDQ9F7ZFcuBJDTp10IPxmvAtAlrAZ0JbFBxolbJSxYB7CX+ey8uMuWMNPfia94hvU1Pydo3Jo=
Received: from MW2PR2101MB1113.namprd21.prod.outlook.com (52.132.149.30) by
 MW2PR2101MB0939.namprd21.prod.outlook.com (52.132.146.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.8; Wed, 20 Jun 2018 17:55:41 +0000
Received: from MW2PR2101MB1113.namprd21.prod.outlook.com
 ([fe80::948d:3fab:e048:bb9b]) by MW2PR2101MB1113.namprd21.prod.outlook.com
 ([fe80::948d:3fab:e048:bb9b%2]) with mapi id 15.20.0906.010; Wed, 20 Jun 2018
 17:55:41 +0000
From:   KY Srinivasan <kys@microsoft.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>
Subject: RE: [PATCH] x86/hyper-v: use cheaper
 HVCALL_FLUSH_VIRTUAL_ADDRESS_{LIST,SPACE} hypercalls when possible
Thread-Topic: [PATCH] x86/hyper-v: use cheaper
 HVCALL_FLUSH_VIRTUAL_ADDRESS_{LIST,SPACE} hypercalls when possible
Thread-Index: AQHUBMYlSJQ3WMa140uivtTO6PwhI6Rn5ECAgADygfiAAJ8AEA==
Date:   Wed, 20 Jun 2018 17:55:40 +0000
Message-ID: <MW2PR2101MB111318C0735C2C7D6CD93ADBA0770@MW2PR2101MB1113.namprd21.prod.outlook.com>
References: <20180615163010.20381-1-vkuznets@redhat.com>
        <SN6PR2101MB11209236A3C18C7CA01F4061DC700@SN6PR2101MB1120.namprd21.prod.outlook.com>
 <87tvpxkgr5.fsf@vitty.brq.redhat.com>
In-Reply-To: <87tvpxkgr5.fsf@vitty.brq.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2601:600:a280:b50:250a:b2e0:47d2:70d4]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0939;7:FYgX3jg7GLbeyLEjQSjdHa8y9alppZtx8CXDIb47yoYu0SYdoblMXO+KxA7e4L2iTcQb/bWMrIDHFdgMamSQV2dMH/nZAz0M4NWpp/NTtTs5+n5mMemLiLzKHFpbUPo8d0Koeu7CmMdOqaavp2KrMcGWE7DbsM4jqT2HAjrH05GFPtsw8+HRFP1dQ19YAt6OOkdgYW5MT9cyCIOzjYo345esfAyc/svL15E1yTfK5qGXa67fTkM9Mdx8wIvLYAbI
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: b695d383-bcb0-42b8-da77-08d5d6d7099c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(48565401081)(2017052603328)(7193020);SRVR:MW2PR2101MB0939;
x-ms-traffictypediagnostic: MW2PR2101MB0939:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kys@microsoft.com; 
x-microsoft-antispam-prvs: <MW2PR2101MB0939C4280D491584AC2640DAA0770@MW2PR2101MB0939.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231254)(2018427008)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:MW2PR2101MB0939;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0939;
x-forefront-prvs: 070912876F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(376002)(346002)(39380400002)(396003)(13464003)(199004)(189003)(51914003)(6636002)(7736002)(305945005)(76176011)(10090500001)(105586002)(74316002)(8936002)(446003)(81156014)(6116002)(8676002)(81166006)(486006)(106356001)(99286004)(476003)(7696005)(86612001)(46003)(9686003)(1511001)(110136005)(5250100002)(186003)(22452003)(6436002)(86362001)(55016002)(316002)(25786009)(53546011)(54906003)(6506007)(14454004)(4326008)(229853002)(68736007)(8990500004)(59450400001)(478600001)(6246003)(107886003)(10290500003)(2900100001)(2906002)(5660300001)(3280700002)(3660700001)(53936002)(11346002)(33656002)(102836004)(97736004)(12043001)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0939;H:MW2PR2101MB1113.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: QTCZBWdgpS1QyP7QQB9iEak2XDTNfGVq52GuWRDnLIQXLccR6jAzxvccTj2mbNo/c5XVHIvDvYXsX2mQpM/vYq7zYE9wE5xL6Jws5G8eXnSLpYEFDE15iSSw6zpGrt7DtJhsgElRxwgr8AMwwpKKB6XSfZ0YJOwYN7TKi7yQC9E0bR89jOjgMe8mu4F6knjs1W13MxgDxGPuRpVSwR7bm59R3XJgzQQYtgvCf0qHlrZ05FGI5Sjb2cYAb/8PthJw8O9PxpClKZvNCWXn7Wne8rebuEE0vcry7MkbezTI0/5cQWjvCwSThDKW+oAit/kb9yzdH8Lr/TlIK/JLuvy0Tw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b695d383-bcb0-42b8-da77-08d5d6d7099c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2018 17:55:40.9469
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0939
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Vitaly Kuznetsov <vkuznets@redhat.com>
> Sent: Wednesday, June 20, 2018 1:24 AM
> To: Michael Kelley (EOSG) <Michael.H.Kelley@microsoft.com>
> Cc: x86@kernel.org; devel@linuxdriverproject.org; linux-
> kernel@vger.kernel.org; KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; Stephen Hemminger
> <sthemmin@microsoft.com>; Thomas Gleixner <tglx@linutronix.de>; Ingo
> Molnar <mingo@redhat.com>; H. Peter Anvin <hpa@zytor.com>; Tianyu Lan
> <Tianyu.Lan@microsoft.com>
> Subject: Re: [PATCH] x86/hyper-v: use cheaper
> HVCALL_FLUSH_VIRTUAL_ADDRESS_{LIST,SPACE} hypercalls when possible
>=20
> "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com> writes:
>=20
> >> -----Original Message-----
> >> From: linux-kernel-owner@vger.kernel.org <linux-kernel-
> owner@vger.kernel.org> On Behalf
> >> Of Vitaly Kuznetsov
> >> Sent: Friday, June 15, 2018 9:30 AM
> >> To: x86@kernel.org
> >> Cc: devel@linuxdriverproject.org; linux-kernel@vger.kernel.org; KY
> Srinivasan
> >> <kys@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>;
> Stephen Hemminger
> >> <sthemmin@microsoft.com>; Thomas Gleixner <tglx@linutronix.de>;
> Ingo Molnar
> >> <mingo@redhat.com>; H. Peter Anvin <hpa@zytor.com>; Tianyu Lan
> >> <Tianyu.Lan@microsoft.com>
> >> Subject: [PATCH] x86/hyper-v: use cheaper
> HVCALL_FLUSH_VIRTUAL_ADDRESS_{LIST,SPACE}
> >> hypercalls when possible
> >>
> >> While working on Hyper-V style PV TLB flush support in KVM I noticed t=
hat
> >> real Windows guests use TLB flush hypercall in a somewhat smarter way:
> when
> >> the flush needs to be performed on a subset of first 64 vCPUs or on al=
l
> >> present vCPUs Windows avoids more expensive hypercalls which support
> >> sparse CPU sets and uses their 'cheap' counterparts. This means that
> >> HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED name is actually a
> misnomer: EX
> >> hypercalls (which support sparse CPU sets) are "available", not
> >> "recommended". This makes sense as they are actually harder to parse.
> >>
> >> Nothing stops us from being equally 'smart' in Linux too. Switch to
> >> doing cheaper hypercalls whenever possible.
> >>
> >> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> >> ---
> >
> > This is a good idea.  We should probably do the same with the hypercall=
s for
> sending
> > IPIs -- try the simpler version first and move to the more complex _EX
> version only
> > if necessary.
> >
> > A complication:  We've recently found a problem with the code for doing
> IPI
> > hypercalls, and the bug affects the TLB flush code as well.  As seconda=
ry
> CPUs
> > are started, there's a window of time where the hv_vp_index entry for a
> > secondary CPU is uninitialized.  We are seeing IPIs happening in that
> window, and
> > the IPI hypercall code uses the uninitialized hv_vp_index entry.   Same
> thing could
> > happen with the TLB flush hypercall code.  I didn't actually see any
> occurrences of
> > the TLB case in my tracing, but we should fix it anyway in case a TLB f=
lush
> gets
> > added at some point in the future.
> >
> > KY has a patch coming.  In the patch, hv_cpu_number_to_vp_number()
> > and cpumask_to_vpset() can both return U32_MAX if they encounter an
> > uninitialized hv_vp_index entry, and the code needs to be able to bail =
out
> to
> > the native functions for that particular IPI or TLB flush operation.  O=
nce the
> > initialization of secondary CPUs is complete, the uninitialized situati=
on
> won't
> > happen again, and the hypercall path will always be used.
>=20
> Sure,

I am surprised that we have not seen this issue in tlb flush enlightenments=
.

K. Y
>=20
> with TLB flush we can always fall back to doing it natively (by sending
> IPIs).
>=20
> >
> > We'll need to coordinate on these patches.  Be aware that the IPI flavo=
r of
> the
> > bug is currently causing random failures when booting 4.18 RC1 on Hyper=
-V
> VMs
> > with large vCPU counts.
>=20
> Thanks for the heads up! This particular patch is just an optimization
> so there's no rush, IPI fix is definitely more important.
>=20
> >
> > Reviewed-by:  Michael Kelley <mikelley@microsoft.com>
>=20
> Thanks!
>=20
> --
>   Vitaly
