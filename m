Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30BACC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0062620700
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="YPy7Q3OM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfBVTBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 14:01:03 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:9420 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbfBVTBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 14:01:03 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c7046eb0002>; Fri, 22 Feb 2019 11:01:00 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 22 Feb 2019 11:01:02 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 22 Feb 2019 11:01:02 -0800
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 22 Feb
 2019 19:01:01 +0000
Subject: Re: [PATCH v5 1/9] mm/mmu_notifier: helper to test if a range
 invalidation is blockable
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
        <linux-fsdevel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>
References: <20190219200430.11130-1-jglisse@redhat.com>
 <20190219200430.11130-2-jglisse@redhat.com>
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <db289f99-3b47-1af6-cbfb-a15155c382c6@nvidia.com>
Date:   Fri, 22 Feb 2019 11:01:01 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190219200430.11130-2-jglisse@redhat.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1550862060; bh=x3ep/Gi+sTbOk9gLW6cFVFGUmrcJKXma0tiO4b4QgOg=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=YPy7Q3OMR8x41jv2A+iuoBr/NEseguMVKb+xW4/BDY4vP1uynrzZVXtz7+vwpM0pz
         Z/LQ2s6yAsC0aqxH7hKB6PjUog2hYAlv4K8t1r3RbU01x874oUNH2UqLURkDAJsU7s
         B7DLZ1FeBqXJzAZTTCj0VKnGkHzhW11xY3osITv6Eb92BvzgpmCb2rltVgZb2g+XA6
         AE8qO3v6CnAX5iQGjGqzGCJU4mfd1LX4fPrNL8V+VZffI4zZg8m1uA9BlgARC/LKio
         ufrKrUUb7kcM/5Tr73O5hPzWqT1VfVbH8kLc2sf8I6ExkxpreHxsqNxyggmViUJIdD
         uMbIo5Ay2VvHQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/19/19 12:04 PM, jglisse@redhat.com wrote:
> From: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
>=20
> Simple helpers to test if range invalidation is blockable. Latter
> patches use cocinnelle to convert all direct dereference of range->
> blockable to use this function instead so that we can convert the
> blockable field to an unsigned for more flags.
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
> Cc: Andrew Morton <akpm@linux-foundation.org>
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
> Cc: linux-fsdevel@vger.kernel.org
> Cc: Arnd Bergmann <arnd@arndb.de>
> ---
>   include/linux/mmu_notifier.h | 11 +++++++++++
>   1 file changed, 11 insertions(+)
>=20
> diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
> index 4050ec1c3b45..e630def131ce 100644
> --- a/include/linux/mmu_notifier.h
> +++ b/include/linux/mmu_notifier.h
> @@ -226,6 +226,12 @@ extern void __mmu_notifier_invalidate_range_end(stru=
ct mmu_notifier_range *r,
>   extern void __mmu_notifier_invalidate_range(struct mm_struct *mm,
>   				  unsigned long start, unsigned long end);
>  =20
> +static inline bool
> +mmu_notifier_range_blockable(const struct mmu_notifier_range *range)
> +{
> +	return range->blockable;
> +}
> +
>   static inline void mmu_notifier_release(struct mm_struct *mm)
>   {
>   	if (mm_has_notifiers(mm))
> @@ -455,6 +461,11 @@ static inline void _mmu_notifier_range_init(struct m=
mu_notifier_range *range,
>   #define mmu_notifier_range_init(range, mm, start, end) \
>   	_mmu_notifier_range_init(range, start, end)
>  =20
> +static inline bool
> +mmu_notifier_range_blockable(const struct mmu_notifier_range *range)
> +{
> +	return true;
> +}
>  =20
>   static inline int mm_has_notifiers(struct mm_struct *mm)
>   {

Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>

