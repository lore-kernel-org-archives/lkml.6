Return-Path: <mhocko@kernel.org>
X-Google-Smtp-Source: AB8JxZqgGTvYAo0q9dlMYGyap+UqnoVRQdlBCjztVYKwsTpR2YlWdYFty2ZvZQsoh05LQoElAm96
ARC-Seal: i=1; a=rsa-sha256; t=1527014250; cv=none;
        d=google.com; s=arc-20160816;
        b=IVSBx+qNjLEVaYLnL8p919+FB5BEHict2zVAN5sQkVaZtiKEPmPvLpLnkQekiy65P4
         2NvQw4NLYdg8sLdo4N4GAh85gtITRqzouGdDtcyEIf+yPUifI6McEOh9FPdc/LTTy457
         JdaVzNXZgFBfVGOxsNN8Z8w83SlAxvWUJO3Uw4HjbmRanmAwU/7ESE9lrMAqCQSPJ1rn
         ormd0gq+zpmxSGQLxD4UgutXm+6RBGQDHxqKM1AG6HUaZ2NUGn9NUH3czFzqvgiJ4ZhM
         58Q1bXGW2KXjiT9AI/GcziZiN14DWGrpLuJ1T7EpNvVvae3NzHObIfd9xER/mEW1ZyY4
         F4CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=HZuKra0fDqwyhz+NCO52fr2dgdgcob6kAYmEjee13pk=;
        b=FPaif5E3zZP9+u7VPgT697L2Yi9RnNoHPQuanhyGFR/BxsMUPawJpXooNISHZfAA6g
         Io5RTRGMX4XX/FyJJw+Z3F82HauIO/n5mly0CzN+tDb4jxOGs/VKIL6KPBrZA7PjcIRo
         ZPY4HfdtWX0C/utsAUzMmDn7PZTLJeTwvoDYPCswUEM2rfXzPByJhvszIINUoFZVzk1l
         kv0phfV4KFAili7lwFQBQ7CPks2kOL2iqZvWrqRVdzAJtwOoYFJfJ0vSfGqqHMDVqebj
         CQJNBOVJPuOOW1Bz933sj4yGXXBjJ6jbcHidrFXjFqCZaawRhsJOBZNz0XYjcYcX9Fa1
         raOg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning mhocko@kernel.org does not designate 195.135.220.15 as permitted sender) smtp.mailfrom=mhocko@kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning mhocko@kernel.org does not designate 195.135.220.15 as permitted sender) smtp.mailfrom=mhocko@kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Date: Tue, 22 May 2018 20:37:28 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Huaisheng Ye <yehs2007@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, willy@infradead.org,
	vbabka@suse.cz, mgorman@techsingularity.net,
	kstewart@linuxfoundation.org, alexander.levin@verizon.com,
	gregkh@linuxfoundation.org, colyli@suse.de, chengnt@lenovo.com,
	hehy1@lenovo.com, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, xen-devel@lists.xenproject.org,
	linux-btrfs@vger.kernel.org, Huaisheng Ye <yehs1@lenovo.com>
Subject: Re: [RFC PATCH v2 00/12] get rid of GFP_ZONE_TABLE/BAD
Message-ID: <20180522183728.GB20441@dhcp22.suse.cz>
References: <1526916033-4877-1-git-send-email-yehs2007@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526916033-4877-1-git-send-email-yehs2007@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601087516393165793?=
X-GMAIL-MSGID: =?utf-8?q?1601190494888927815?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon 21-05-18 23:20:21, Huaisheng Ye wrote:
> From: Huaisheng Ye <yehs1@lenovo.com>
> 
> Replace GFP_ZONE_TABLE and GFP_ZONE_BAD with encoded zone number.
> 
> Delete ___GFP_DMA, ___GFP_HIGHMEM and ___GFP_DMA32 from GFP bitmasks,
> the bottom three bits of GFP mask is reserved for storing encoded
> zone number.
> 
> The encoding method is XOR. Get zone number from enum zone_type,
> then encode the number with ZONE_NORMAL by XOR operation.
> The goal is to make sure ZONE_NORMAL can be encoded to zero. So,
> the compatibility can be guaranteed, such as GFP_KERNEL and GFP_ATOMIC
> can be used as before.
> 
> Reserve __GFP_MOVABLE in bit 3, so that it can continue to be used as
> a flag. Same as before, __GFP_MOVABLE respresents movable migrate type
> for ZONE_DMA, ZONE_DMA32, and ZONE_NORMAL. But when it is enabled with
> __GFP_HIGHMEM, ZONE_MOVABLE shall be returned instead of ZONE_HIGHMEM.
> __GFP_ZONE_MOVABLE is created to realize it.
> 
> With this patch, just enabling __GFP_MOVABLE and __GFP_HIGHMEM is not
> enough to get ZONE_MOVABLE from gfp_zone. All callers should use
> GFP_HIGHUSER_MOVABLE or __GFP_ZONE_MOVABLE directly to achieve that.
> 
> Decode zone number directly from bottom three bits of flags in gfp_zone.
> The theory of encoding and decoding is,
>         A ^ B ^ B = A

So why is this any better than the current code. Sure I am not a great
fan of GFP_ZONE_TABLE because of how it is incomprehensible but this
doesn't look too much better, yet we are losing a check for incompatible
gfp flags. The diffstat looks really sound but then you just look and
see that the large part is the comment that at least explained the gfp
zone modifiers somehow and the debugging code. So what is the selling
point?

> Changes since v1,
> 
> v2: Add __GFP_ZONE_MOVABLE and modify GFP_HIGHUSER_MOVABLE to help
> callers to get ZONE_MOVABLE. Add __GFP_ZONE_MASK to mask lowest 3
> bits of GFP bitmasks.
> Modify some callers' gfp flag to update usage of address zone
> modifiers.
> Modify inline function gfp_zone to get better performance according
> to Matthew's suggestion.
> 
> Link: https://marc.info/?l=linux-mm&m=152596791931266&w=2
> 
> Huaisheng Ye (12):
>   include/linux/gfp.h: get rid of GFP_ZONE_TABLE/BAD
>   arch/x86/kernel/amd_gart_64: update usage of address zone modifiers
>   arch/x86/kernel/pci-calgary_64: update usage of address zone modifiers
>   drivers/iommu/amd_iommu: update usage of address zone modifiers
>   include/linux/dma-mapping: update usage of address zone modifiers
>   drivers/xen/swiotlb-xen: update usage of address zone modifiers
>   fs/btrfs/extent_io: update usage of address zone modifiers
>   drivers/block/zram/zram_drv: update usage of address zone modifiers
>   mm/vmpressure: update usage of address zone modifiers
>   mm/zsmalloc: update usage of address zone modifiers
>   include/linux/highmem: update usage of movableflags
>   arch/x86/include/asm/page.h: update usage of movableflags
> 
>  arch/x86/include/asm/page.h      |  3 +-
>  arch/x86/kernel/amd_gart_64.c    |  2 +-
>  arch/x86/kernel/pci-calgary_64.c |  2 +-
>  drivers/block/zram/zram_drv.c    |  6 +--
>  drivers/iommu/amd_iommu.c        |  2 +-
>  drivers/xen/swiotlb-xen.c        |  2 +-
>  fs/btrfs/extent_io.c             |  2 +-
>  include/linux/dma-mapping.h      |  2 +-
>  include/linux/gfp.h              | 98 +++++-----------------------------------
>  include/linux/highmem.h          |  4 +-
>  mm/vmpressure.c                  |  2 +-
>  mm/zsmalloc.c                    |  4 +-
>  12 files changed, 26 insertions(+), 103 deletions(-)
> 
> -- 
> 1.8.3.1
> 

-- 
Michal Hocko
SUSE Labs
