Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B515FC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 15:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 652D420870
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 15:13:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="odDaJ+BF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 652D420870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbeJ3ACV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 20:02:21 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:19037 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726991AbeJ3ACV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 20:02:21 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bd7238a0000>; Mon, 29 Oct 2018 23:13:14 +0800
Received: from HKMAIL101.nvidia.com ([10.18.16.10])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Mon, 29 Oct 2018 08:13:13 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Mon, 29 Oct 2018 08:13:13 -0700
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 29 Oct
 2018 15:13:12 +0000
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (216.32.180.84)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Mon, 29 Oct 2018 15:13:12 +0000
Received: from BN7PR12MB2708.namprd12.prod.outlook.com (20.176.176.142) by
 BN7PR12MB2787.namprd12.prod.outlook.com (20.176.178.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.25; Mon, 29 Oct 2018 15:13:09 +0000
Received: from BN7PR12MB2708.namprd12.prod.outlook.com
 ([fe80::51c3:23f7:adb6:a183]) by BN7PR12MB2708.namprd12.prod.outlook.com
 ([fe80::51c3:23f7:adb6:a183%6]) with mapi id 15.20.1273.027; Mon, 29 Oct 2018
 15:13:08 +0000
From:   Alexander Van Brunt <avanbrunt@nvidia.com>
To:     Will Deacon <will.deacon@arm.com>,
        Ashish Mhetre <amhetre@nvidia.com>
CC:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Sachin Nikam <Snikam@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V3] arm64: Don't flush tlb while clearing the accessed bit
Thread-Topic: [PATCH V3] arm64: Don't flush tlb while clearing the accessed
 bit
Thread-Index: AQHUb2mK2jioXCSBXUOglXMUWPpsLKU2DOwAgABGE2g=
Date:   Mon, 29 Oct 2018 15:13:08 +0000
Message-ID: <BN7PR12MB2708B742FD3448589AD0F259CFF30@BN7PR12MB2708.namprd12.prod.outlook.com>
References: <1540805158-618-1-git-send-email-amhetre@nvidia.com>,<20181029105515.GD14127@arm.com>
In-Reply-To: <20181029105515.GD14127@arm.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=avanbrunt@nvidia.com; 
x-originating-ip: [216.228.112.22]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN7PR12MB2787;6:1ofK+8bxLaC21i+vL55wvqJEGmaq1eiluH7kJv78zKhJNKO2RMsA9R+Y/z/82dEYzpzO55oy0a9w7eJimdeD9hKW/a3eZb38S4G+qrAhQUl4LuJCcx6eOoM70Rnzzm9cD4IN5c2dtfTLTje6R8Rmxt1xyKfb9pwsKSQBivLKjYJ4ThVHfoCWwGvcJd0XbzqATHrNn99UiYKEi2bxst6NhPqvG/xMEVms8XxmVTyqrZQtqGTgWlLqJODKpaHxgDVzN9ETpxA2V/QKnrtlzq0oLFhGX4uKxbu6Cdu8iJiCo8VvqDLqwEcuSUcfC215WuWILxtZQZNOy0/FfWapcLzYqPy/9avlNAmT/eWDmsI8TbP27bw32MbMW48sA7iZFHT3Or9/ux6qKqmH/nztbPcXiybg/fdiFLT1dcLZdHDUBvN9lzOmDCnGkhhLT+jJTfne6yMGn9HLAn6USYu3cNKRGw==;5:0919Vi7ZfRAF8K8NNcdmJHnTHVdgtyxPCP/WyNURVk9LSvLiyPjpHqQehe4d1214BrMnYao5FYto5aVcz+2mzSRals2omJI3k2cyvsO8rUa/bKIK7tLtsi+vmjS8F240tnaLHCaGC5Uy0sVh5iFBYKaexlFCAO/noKMevj8d2HQ=;7:B2N3mj3DPi0f7Mfr/Ff8f7sbjCxikEAjYhGLfFBfh//QhorjyULtHkHltU3zV1sF2Sc7UOTEmgWyh74CRQq3C7yRtVADOOp7j388bEnzphrxml65latUW9+7luBI25yDSlzs2ChwzebCC6GykGEOgg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(346002)(39860400002)(366004)(136003)(376002)(396003)(199004)(189003)(81156014)(68736007)(97736004)(106356001)(6636002)(7696005)(102836004)(9686003)(76176011)(110136005)(105586002)(4326008)(81166006)(316002)(25786009)(6436002)(7736002)(11346002)(33656002)(66066001)(14454004)(486006)(55016002)(446003)(476003)(5250100002)(6506007)(305945005)(99286004)(8936002)(229853002)(53546011)(74316002)(5660300001)(26005)(3846002)(6116002)(8676002)(71190400001)(186003)(86362001)(6246003)(2906002)(71200400001)(54906003)(14444005)(256004)(53936002)(2900100001)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR12MB2787;H:BN7PR12MB2708.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 7725b8c8-aa73-4935-b55b-08d63db108d3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN7PR12MB2787;
x-ms-traffictypediagnostic: BN7PR12MB2787:
x-microsoft-antispam-prvs: <BN7PR12MB2787DD324DFB84FF0E496C87CFF30@BN7PR12MB2787.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(258649278758335)(9452136761055)(18589796830644);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231382)(944501410)(52105095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BN7PR12MB2787;BCL:0;PCL:0;RULEID:;SRVR:BN7PR12MB2787;
x-forefront-prvs: 084080FC15
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: xN1rUJy8X0oCFzScLERr5Du0ik9eTnIq+9ua6dkP81YHoEDB6QeoDNtRk48m3v62vZ4X8lRpDAX8rIm9/1blQHiW6V+7wIzrkkLBcdLqWEQ0eRwFO29AN5xzPzz0GRzRVWsUeWKXuHU6fEicZJOmeQaFnyAJLIHFZpLWXhQjSW+Cuq6jwVFiEJxu3DR4rpYy26Qz/xpM0izCOjLF+7dkCgJ5m4M/Nz/JXTjBxHl4CWkm8cZ8v/KAAdYyuziRMI+R3QJk2r9X6AW04yam6pGtcqdtMTAfRC6jiSKPgrF3qk0W1dISEB/t1VWg8gE2jncIp6BQRaPauwKujLe9ORENgMXocPH4jdianCOM9FTQZMA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7725b8c8-aa73-4935-b55b-08d63db108d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2018 15:13:08.5021
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2787
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1540825994; bh=dWn1mdBnKTAg611Hx+yPebJ2hZjWHxfrGtq+D3o6Jrk=;
        h=X-PGP-Universal:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
         Message-ID:References:In-Reply-To:Accept-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
         x-ms-publictraffictype:x-microsoft-exchange-diagnostics:
         x-ms-exchange-antispam-srfa-diagnostics:
         x-forefront-antispam-report:
         x-ms-office365-filtering-correlation-id:x-microsoft-antispam:
         x-ms-traffictypediagnostic:x-microsoft-antispam-prvs:
         x-exchange-antispam-report-test:x-ms-exchange-senderadcheck:
         x-exchange-antispam-report-cfa-test:x-forefront-prvs:received-spf:
         x-microsoft-antispam-message-info:spamdiagnosticoutput:
         spamdiagnosticmetadata:MIME-Version:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=odDaJ+BF6/3D3JlJ63SRgeteO0abUQxLUC1Yp5pVY5dHlkTMJK+27ycl42lryvylQ
         P7hXmt8Tf0LDFSPNukOb+vgY+QxkOw+SNDqKltsG5YgAUhYwHIt4DjudHFUfraqk95
         3mOX9O3dO7yD2/zyD+LOIXcqCRl148h2vIiNZtuNfJBKU/KHMsTOgHLcbb/IHJBRmW
         zzAgF3njabvPCJoBKXTXie/xWZfoaYpZd75WHHy/Pik9mDbQlzKgMUfWYv2nupNK/g
         tbjAyjHQ+ST+x41F1F0lzTFbLQ22FQ4YVLRmjmxPLDizMYYxD6P79Vix8RsL0Om7lW
         somf67zswUg8Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=A0If we roll a TLB invalidation routine without the trailing DSB, what so=
rt of
>=A0performance does that get you?

We have been doing our testing on our Carmel CPUs. Carmel will effectively
ignore a TLB invalidate that doesn't have a DSB (until the invalidate buffe=
r
overflows). So, I expect the performance to be the same as with no TLB
invalidate, but not represent the performance of other ARMv8 CPUs


From: Will Deacon <will.deacon@arm.com>
Sent: Monday, October 29, 2018 3:55 AM
To: Ashish Mhetre
Cc: mark.rutland@arm.com; linux-arm-kernel@lists.infradead.org; linux-tegra=
@vger.kernel.org; Alexander Van Brunt; Sachin Nikam; linux-kernel@vger.kern=
el.org
Subject: Re: [PATCH V3] arm64: Don't flush tlb while clearing the accessed =
bit
=A0=20

On Mon, Oct 29, 2018 at 02:55:58PM +0530, Ashish Mhetre wrote:
> From: Alex Van Brunt <avanbrunt@nvidia.com>
>=20
> Accessed bit is used to age a page and in generic implementation there is
> flush_tlb while clearing the accessed bit.
> Flushing a TLB is overhead on ARM64 as access flag faults don't get
> translation table entries cached into TLB's. Flushing TLB is not necessar=
y
> for this. Clearing the accessed bit without flushing TLB doesn't cause da=
ta
> corruption on ARM64.
> In our case with this patch, speed of reading from fast NVMe/SSD through
> PCIe got improved by 10% ~ 15% and writing got improved by 20% ~ 40%.
> So for performance optimisation don't flush TLB when clearing the accesse=
d
> bit on ARM64.
> x86 made the same optimization even though their TLB invalidate is much
> faster as it doesn't broadcast to other CPUs.

Ok, but they may end up using IPIs so lets avoid these vague performance
claims in the log unless they're backed up with numbers.

> Please refer to:
> 'commit b13b1d2d8692 ("x86/mm: In the PTE swapout page reclaim case clear
> the accessed bit instead of flushing the TLB")'
>=20
> Signed-off-by: Alex Van Brunt <avanbrunt@nvidia.com>
> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
> ---
>=A0 arch/arm64/include/asm/pgtable.h | 20 ++++++++++++++++++++
>=A0 1 file changed, 20 insertions(+)
>=20
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pg=
table.h
> index 2ab2031..080d842 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -652,6 +652,26 @@ static inline int ptep_test_and_clear_young(struct v=
m_area_struct *vma,
>=A0=A0=A0=A0=A0=A0=A0 return __ptep_test_and_clear_young(ptep);
>=A0 }
>=A0=20
> +#define __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
> +static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 unsigned long address, pte_t *ptep)
> +{
> +=A0=A0=A0=A0 /*
> +=A0=A0=A0=A0=A0 * On ARM64 CPUs, clearing the accessed bit without a TLB=
 flush
> +=A0=A0=A0=A0=A0 * doesn't cause data corruption. [ It could cause incorr=
ect
> +=A0=A0=A0=A0=A0 * page aging and the (mistaken) reclaim of hot pages, bu=
t the
> +=A0=A0=A0=A0=A0 * chance of that should be relatively low. ]
> +=A0=A0=A0=A0=A0 *
> +=A0=A0=A0=A0=A0 * So as a performance optimization don't flush the TLB w=
hen
> +=A0=A0=A0=A0=A0 * clearing the accessed bit, it will eventually be flush=
ed by
> +=A0=A0=A0=A0=A0 * a context switch or a VM operation anyway. [ In the ra=
re
> +=A0=A0=A0=A0=A0 * event of it not getting flushed for a long time the de=
lay
> +=A0=A0=A0=A0=A0 * shouldn't really matter because there's no real memory
> +=A0=A0=A0=A0=A0 * pressure for swapout to react to. ]

This is blindly copied from x86 and isn't true for us: we don't invalidate
the TLB on context switch. That means our window for keeping the stale
entries around is potentially much bigger and might not be a great idea.

If we roll a TLB invalidation routine without the trailing DSB, what sort o=
f
performance does that get you?

Will
    =
