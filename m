Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44AF4C10F07
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 23:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 130CC20880
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 23:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="dmqbfBMw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfBTX6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 18:58:53 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:3883 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfBTX6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 18:58:52 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c6de9c20000>; Wed, 20 Feb 2019 15:58:58 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 20 Feb 2019 15:58:52 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 20 Feb 2019 15:58:52 -0800
Received: from [10.2.169.124] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 20 Feb
 2019 23:58:51 +0000
Subject: Re: [PATCH 02/10] mm/hmm: do not erase snapshot when a range is
 invalidated
To:     <jglisse@redhat.com>, <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ralph Campbell <rcampbell@nvidia.com>
References: <20190129165428.3931-1-jglisse@redhat.com>
 <20190129165428.3931-3-jglisse@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <ca5e182d-6b99-0e5d-91ab-175ddc6acd45@nvidia.com>
Date:   Wed, 20 Feb 2019 15:58:40 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190129165428.3931-3-jglisse@redhat.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1550707138; bh=jP+wiat2XSsdStfjMflPAPZ0y6VSuTquKiZkpsPA0wk=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=dmqbfBMwvjaiDm4+ShTJ/pUB6RmCQ/z4LdRkHsxmLjQ13SeSj75L5H16XUZNvEgI5
         KEuJ9clung0YkN8Juhf52xYrG7rcjUYdiVcxmOWAgxJXFACrSuhAy3Dh+RZRJAWjGl
         v5f2fKZFcdS75UivGyHgoA0Agrlufs+52Go8uJmzob84TdtuO7FpQIoizsu33g8cET
         EAAQoIID1RfvmJ6mYYiR/7gFk0CgqV+Ytoxt5dYrpbJtgk1CTKd68Z6eSYBuHR0DzG
         5+b6jYldNox+246RO7rJN2dpYw6rxa07YhZVJ0rWzaR8cMYihE2hggXo2yOumsXtc2
         QhGMT+ce258jA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/29/19 8:54 AM, jglisse@redhat.com wrote:
> From: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
>=20
> Users of HMM might be using the snapshot information to do
> preparatory step like dma mapping pages to a device before
> checking for invalidation through hmm_vma_range_done() so
> do not erase that information and assume users will do the
> right thing.
>=20
> Signed-off-by: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Ralph Campbell <rcampbell@nvidia.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> ---
>   mm/hmm.c | 6 ------
>   1 file changed, 6 deletions(-)
>=20
> diff --git a/mm/hmm.c b/mm/hmm.c
> index b9f384ea15e9..74d69812d6be 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -170,16 +170,10 @@ static int hmm_invalidate_range(struct hmm *hmm, bo=
ol device,
>  =20
>   	spin_lock(&hmm->lock);
>   	list_for_each_entry(range, &hmm->ranges, list) {
> -		unsigned long addr, idx, npages;
> -
>   		if (update->end < range->start || update->start >=3D range->end)
>   			continue;
>  =20
>   		range->valid =3D false;
> -		addr =3D max(update->start, range->start);
> -		idx =3D (addr - range->start) >> PAGE_SHIFT;
> -		npages =3D (min(range->end, update->end) - addr) >> PAGE_SHIFT;
> -		memset(&range->pfns[idx], 0, sizeof(*range->pfns) * npages);
>   	}
>   	spin_unlock(&hmm->lock);
>  =20
>=20

Seems harmless to me. I really cannot see how this could cause a problem,
so you can add:

	Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
--=20
John Hubbard
NVIDIA
