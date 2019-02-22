Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF02C10F00
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 22:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEF632075C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 22:08:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="hYe8t4t6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbfBVWIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 17:08:07 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:10504 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfBVWIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 17:08:07 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c7072cd0000>; Fri, 22 Feb 2019 14:08:13 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 22 Feb 2019 14:08:05 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 22 Feb 2019 14:08:05 -0800
Received: from rcampbell-dev.nvidia.com (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 22 Feb
 2019 22:08:04 +0000
Subject: Re: [PATCH v5 7/9] mm/mmu_notifier: pass down vma and reasons why mmu
 notifier is happening v2
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
 <20190219200430.11130-8-jglisse@redhat.com>
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <176dfe29-e7ca-632f-5d65-551ac2ee9ec4@nvidia.com>
Date:   Fri, 22 Feb 2019 14:08:04 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190219200430.11130-8-jglisse@redhat.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1550873293; bh=c6gjUvJdtuDPbgDm3cSS4FUPb8+FP6+GXo3xKSKYPas=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=hYe8t4t6dhUmcR4NBgSyeLqKjhrdU8uR+WitbPZdxTqShufo43Th9neByTvHRG4EJ
         WtUp1XkSwH16AEt+KyGnfE3KeiQWZSi0akoZU528zh5x1c9jO/ujtv6fUMtWF+GEwS
         o3ftp/u62CzsilZNA2W0d7sAI6k0+gI9NVb2uunB9ndpK8USOxULXp0dcu0vvEpWlR
         SG5xPtuYaD74T+XM/W3rI7Mkn+3+CW3YHr57TKrQFMjytqpu3S32JBfxvYl7d5jGc3
         uKv1HEOpHOzblQOBTG2OXMEY1d3Vm5l0nZQEr8QFdz3UT28Lk82b6KBfAk9GzGlxe9
         Rg2T8U/x+l3uQ==
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
> address affected by the change, not why the changes is happening
>=20
> This patch is just passing down the new informations by adding it to the
> mmu_notifier_range structure.
>=20
> Changes since v1:
>      - Initialize flags field from mmu_notifier_range_init() arguments
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
>   include/linux/mmu_notifier.h | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
> index 62f94cd85455..0379956fff23 100644
> --- a/include/linux/mmu_notifier.h
> +++ b/include/linux/mmu_notifier.h
> @@ -58,10 +58,12 @@ struct mmu_notifier_mm {
>   #define MMU_NOTIFIER_RANGE_BLOCKABLE (1 << 0)
>  =20
>   struct mmu_notifier_range {
> +	struct vm_area_struct *vma;
>   	struct mm_struct *mm;
>   	unsigned long start;
>   	unsigned long end;
>   	unsigned flags;
> +	enum mmu_notifier_event event;
>   };
>  =20
>   struct mmu_notifier_ops {
> @@ -363,10 +365,12 @@ static inline void mmu_notifier_range_init(struct m=
mu_notifier_range *range,
>   					   unsigned long start,
>   					   unsigned long end)
>   {
> +	range->vma =3D vma;
> +	range->event =3D event;
>   	range->mm =3D mm;
>   	range->start =3D start;
>   	range->end =3D end;
> -	range->flags =3D 0;
> +	range->flags =3D flags;
>   }
>  =20
>   #define ptep_clear_flush_young_notify(__vma, __address, __ptep)		\
>=20

Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>
