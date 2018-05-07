Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752614AbeEGPvu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 11:51:50 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:50995 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751947AbeEGPvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 11:51:48 -0400
X-Google-Smtp-Source: AB8JxZqh7p9bRQtbjrqQ5U8DbpYr4cnSCp4kt1GqECCSeyXZF3vi+31UYH21EozBOm64yF81UDWqeg==
Subject: Re: [PATCH v1 4/4] iommu/tegra: gart: Optimize map/unmap
To: Joerg Roedel <joro@8bytes.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>, linux-tegra@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jonathan Hunter <jonathanh@nvidia.com>
References: <cover.1523304324.git.digetx@gmail.com>
 <f21a7b6a8f141b87f75687904a76f3728ea639a8.1523304324.git.digetx@gmail.com>
 <20180427100202.GO30388@ulmo> <716edf58-38a7-21e5-1668-b866bf392e34@arm.com>
 <6827bda3-1aa2-da60-a749-8e2dd2e595f3@gmail.com>
 <20180507080420.GB18595@8bytes.org>
From: Dmitry Osipenko <digetx@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=digetx@gmail.com; prefer-encrypt=mutual; keydata=
 xsBNBFpX5TwBCADQhg+lBnTunWSPbP5I+rM9q6EKPm5fu2RbqyVAh/W3fRvLyghdb58Yrmjm
 KpDYUhBIZvAQoFLEL1IPAgJBtmPvemO1XUGPxfYNh/3BlcDFBAgERrI3BfA/6pk7SAFn8u84
 p+J1TW4rrPYcusfs44abJrn8CH0GZKt2AZIsGbGQ79O2HHXKHr9V95ZEPWH5AR0UtL6wxg6o
 O56UNG3rIzSL5getRDQW3yCtjcqM44mz6GPhSE2sxNgqureAbnzvr4/93ndOHtQUXPzzTrYB
 z/WqLGhPdx5Ouzn0Q0kSVCQiqeExlcQ7i7aKRRrELz/5/IXbCo2O+53twlX8xOps9iMfABEB
 AAHNIkRtaXRyeSBPc2lwZW5rbyA8ZGlnZXR4QGdtYWlsLmNvbT7CwJQEEwEIAD4WIQSczHcO
 3uc4K1eb3yvTNNaPsNRzvAUCWlflPAIbAwUJA8JnAAULCQgHAgYVCgkICwIEFgIDAQIeAQIX
 gAAKCRDTNNaPsNRzvFjTCACqAh1M9/YPq73/ai5h2ExDquTgJnjegL8KL2yHL3G+XINwzN5E
 nPI7esoYm+zVWDJbv3UuRqylpookLNSRA01yyvkaMcipB/B128UnqmUiGRqezj9QE20yIauo
 uHRuwHPE2q+UkfUhRX9iuOaEyQtZDiCa0myMjmRkJ+Z8ZetclEPG8dYZu47w04phuMlu1QAt
 a0gkZOaMKvXgj21ushALS6nYnvm7HiIPQXfnEXThartatRvFdmbG4PCn0IoICkQBizwJtXrL
 HEjELIFap0M8krVJlUoZTFaZnaZkGpUDWikeFtAuie2KuIxmVBYPM4X7pM3eP3AVvIPGS7EE
 UUFuzsBNBFpX5TwBCADFNDou220thijaLLGaQsebWjzc/gPRxMixIpk856MRyRaQin+IbGD6
 YskMb5ZSD3nS88LIKNfY4MMH0LwfYztI++ICG2vdFLkbBt78E+LqEa+kZ9072l4W5KO3mWQo
 +jMfxXbpgGlc7iuEReDgl8iyZ27r51kSW665CYvvu2YJhLqgdj6QM1lN2D1UnhEhkkU+pRAj
 1rJVOxdfJaQNQS4+204p3TrURovzNGkN/brqakpNIcqGOAGQqb8F0tuwwuP7ERq/BzDNkbdr
 qJOrVC/wkHRq1jfabQczWKf8MwYOvivR3HY8d3CpSQxmUXDtdOWfg0XGm1dxYnVfqPjuJaZt
 ABEBAAHCwHwEGAEIACYWIQSczHcO3uc4K1eb3yvTNNaPsNRzvAUCWlflPAIbDAUJA8JnAAAK
 CRDTNNaPsNRzvJzuB/9d+sxcwHbO8ZDcgaLX9N+bXFqN9fIRVmBUyWa+qqTSREA4uVAtYcRT
 lfPE2OQ7aMFxaYPwo+/z5SLpu8HcEhN/FG9uIkfYwK0mdCO0vgvlfvBJm4VHe7C6vyAeEPJQ
 DKbBvdgeqFqO+PsLkk2sawF/9sontMJ5iFfjNDj4UeAo4VsdlduTBZv5hHFvIbv/p7jKH6OT
 90FsgUSVbShh7SH5OzAcgqSy4kxuS1AHizWo6P3f9vei987LZWTyhuEuhJsOfivDsjKIq7qQ
 c5eR+JJtyLEA0Jt4cQGhpzHtWB0yB3XxXzHVa4QUp00BNVWyiJ/t9JHT4S5mdyLfcKm7ddc9
Message-ID: <a6e26d17-97ac-d02e-7bf4-f009af1a25dc@gmail.com>
Date: Mon, 7 May 2018 18:51:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180507080420.GB18595@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.05.2018 11:04, Joerg Roedel wrote:
> On Mon, May 07, 2018 at 12:19:01AM +0300, Dmitry Osipenko wrote:
>> Probably the best variant would be to give an explicit control over syncing to a
>> user of the IOMMU API, like for example device driver may perform multiple
>> mappings / unmappings and then sync/flush in the end. I'm not sure that it's
>> really worth the hassle to shuffle the API right now, maybe we can implement it
>> later if needed. Joerg, do you have objections to a 'compound page' approach?
> 
> Have you measured the performance difference on both variants? The
> compound-page approach only works for cases when the physical memory you
> map contiguous and correctly aligned.

Yes, previously I actually only tested mapping of the contiguous allocations
(used for memory isolation purposes). But now I've re-tested all variants and
got somewhat interesting results.

Firstly it is not that easy to test a really sparse mapping simply because
memory allocator produces sparse allocation only when memory is _really_
fragmented. Pretty much all of the time the sparse allocations are contiguous or
they consist of a very few chunks that do not impose any noticeable performance
impact.

Secondly, the interesting part is that mapping / unmapping of a contiguous
allocation (CMA using DMA API) is slower by ~50% then doing it for a sparse
allocation (get_pages using bare IOMMU API). /I think/ it's a shortcoming of the
arch/arm/mm/dma-mapping.c, which also suffers from other inflexibilities that
Thierry faced recently. Though I haven't really tried to figure out what is the
bottleneck yet and Thierry was going to re-write ARM's dma-mapping
implementation anyway, I'll take a closer look at this issue a bit later.

I've implemented the iotlb_sync_map() and tested things with it. The end result
is the same as for the compound page approach, simply because actual allocations
are pretty much always contiguous.

> If it is really needed I would prefer a separate iotlb_sync_map()
> call-back that is just NULL when not needed. This way all users that
> don't need it only get a minimal penalty in the mapping path and you
> don't have any requirements on the physical memory you map to get good
> performance.
Summarizing, the iotlb_sync_map() is indeed better way. As you rightly noticed,
that approach is also optimal for the non-contiguous cases as we won't have to
flush on mapping of each contiguous chunk of the sparse allocation, but after
the whole mapping is done.

Thierry, Robin and Joerg - thanks for your input, I'll prepare patches
implementing the iotlb_sync_map.
