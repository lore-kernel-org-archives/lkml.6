Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9ABDC10F00
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 21:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2E93206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 21:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="NHGD06wb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbfBVVZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 16:25:07 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:13110 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfBVVZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 16:25:06 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c7068b60000>; Fri, 22 Feb 2019 13:25:10 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 22 Feb 2019 13:25:04 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 22 Feb 2019 13:25:04 -0800
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 22 Feb
 2019 21:25:04 +0000
Subject: Re: [PATCH v5 5/9] mm/mmu_notifier: contextual information for event
 triggering invalidation v2
To:     <jglisse@redhat.com>, <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, Jan Kara <jack@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ross Zwisler <zwisler@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>, <kvm@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <linux-rdma@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
References: <20190219200430.11130-1-jglisse@redhat.com>
 <20190219200430.11130-6-jglisse@redhat.com>
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <ff09d22f-8eb8-ea19-0a65-7f5b38928cea@nvidia.com>
Date:   Fri, 22 Feb 2019 13:25:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190219200430.11130-6-jglisse@redhat.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1550870710; bh=9karIuIHg1vtBYYf1M4HNuL4qkqDIYWqZ2VdtX6a7DQ=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=NHGD06wbFMzk6wx9UJ7KfOSbOHtmisry4usVAC/d5jMIwrQINwkIMVLDHUje0FHQ/
         tm8t1YP0WB13tAdYQAClqrzZsDpUQH7ViUlKqfVD3GiJGu6gNyDHR/mBFkuKAymwko
         0wk/aC9Q12UAb7EjawB0lZ/OuNzYbsSbRUUgdshlbsMxrVC8hfWX4vkMsVF1MxOowJ
         ZoVAOL2P377kVPt6u8k9wu7bV8oI/w2n7e/xQ0WDTaTNna9581oyDRx3agYAWAJDeS
         lR+6lndK1PDhrfsVuhsuunw/ngZGJSEdrpBVsCzTmA7q2LG6G37DBIg+EyIs7XjAoR
         P6x4OHlTH5aoA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/19/19 12:04 PM, jglisse@redhat.com wrote:
> From: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
>=20
> CPU page table update can happens for many reasons, not only as a result
> of a syscall (munmap(), mprotect(), mremap(), madvise(), ...) but also
> as a result of kernel activities (memory compression, reclaim, migration,
> ...).
>=20
> Users of mmu notifier API track changes to the CPU page table and take
> specific action for them. While current API only provide range of virtual
> address affected by the change, not why the changes is happening.
>=20
> This patchset do the initial mechanical convertion of all the places that
> calls mmu_notifier_range_init to also provide the default MMU_NOTIFY_UNMA=
P
> event as well as the vma if it is know (most invalidation happens against
> a given vma). Passing down the vma allows the users of mmu notifier to
> inspect the new vma page protection.
>=20
> The MMU_NOTIFY_UNMAP is always the safe default as users of mmu notifier
> should assume that every for the range is going away when that event
> happens. A latter patch do convert mm call path to use a more appropriate
> events for each call.
>=20
> Changes since v1:
>      - add the flags parameter to init range flags
>=20
> This is done as 2 patches so that no call site is forgotten especialy
> as it uses this following coccinelle patch:
>=20
> %<----------------------------------------------------------------------
> @@
> identifier I1, I2, I3, I4;
> @@
> static inline void mmu_notifier_range_init(struct mmu_notifier_range *I1,
> +enum mmu_notifier_event event,
> +unsigned flags,
> +struct vm_area_struct *vma,
> struct mm_struct *I2, unsigned long I3, unsigned long I4) { ... }
>=20
> @@
> @@
> -#define mmu_notifier_range_init(range, mm, start, end)
> +#define mmu_notifier_range_init(range, event, flags, vma, mm, start, end=
)
>=20
> @@
> expression E1, E3, E4;
> identifier I1;
> @@
> <...
> mmu_notifier_range_init(E1,
> +MMU_NOTIFY_UNMAP, 0, I1,
> I1->vm_mm, E3, E4)
> ...>
>=20
> @@
> expression E1, E2, E3, E4;
> identifier FN, VMA;
> @@
> FN(..., struct vm_area_struct *VMA, ...) {
> <...
> mmu_notifier_range_init(E1,
> +MMU_NOTIFY_UNMAP, 0, VMA,
> E2, E3, E4)
> ...> }
>=20
> @@
> expression E1, E2, E3, E4;
> identifier FN, VMA;
> @@
> FN(...) {
> struct vm_area_struct *VMA;
> <...
> mmu_notifier_range_init(E1,
> +MMU_NOTIFY_UNMAP, 0, VMA,
> E2, E3, E4)
> ...> }
>=20
> @@
> expression E1, E2, E3, E4;
> identifier FN;
> @@
> FN(...) {
> <...
> mmu_notifier_range_init(E1,
> +MMU_NOTIFY_UNMAP, 0, NULL,
> E2, E3, E4)
> ...> }
> ---------------------------------------------------------------------->%
>=20
> Applied with:
> spatch --all-includes --sp-file mmu-notifier.spatch fs/proc/task_mmu.c --=
in-place
> spatch --sp-file mmu-notifier.spatch --dir kernel/events/ --in-place
> spatch --sp-file mmu-notifier.spatch --dir mm --in-place
>=20
> Signed-off-by: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Cc: Jason Gunthorpe <jgg@mellanox.com>
> Cc: Ross Zwisler <zwisler@kernel.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.com>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: Ralph Campbell <rcampbell@nvidia.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: kvm@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-rdma@vger.kernel.org
> Cc: Arnd Bergmann <arnd@arndb.de>
> ---

Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>

