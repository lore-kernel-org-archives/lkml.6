Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC280C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 10:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BE9F213A2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 10:40:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BE9F213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732158AbeHNN1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 09:27:11 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41318 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731485AbeHNN1L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 09:27:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B68C57A9;
        Tue, 14 Aug 2018 03:40:35 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8522C3F73C;
        Tue, 14 Aug 2018 03:40:35 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 1AA251AE015E; Tue, 14 Aug 2018 11:40:42 +0100 (BST)
Date:   Tue, 14 Aug 2018 11:40:42 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Greg Hackmann <ghackmann@android.com>
Cc:     linux-arm-kernel@lists.infradead.org, kernel-team@android.com,
        Greg Hackmann <ghackmann@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Steve Capper <steve.capper@arm.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Stefan Agner <stefan@agner.ch>,
        CHANDAN VN <chandan.vn@samsung.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: mm: check for upper PAGE_SHIFT bits in pfn_valid()
Message-ID: <20180814104041.GB28664@arm.com>
References: <20180813193013.236362-1-ghackmann@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180813193013.236362-1-ghackmann@google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Mon, Aug 13, 2018 at 12:30:11PM -0700, Greg Hackmann wrote:
> ARM64's pfn_valid() shifts away the upper PAGE_SHIFT bits of the input
> before seeing if the PFN is valid.  This leads to false positives when
> some of the upper bits are set, but the lower bits match a valid PFN.
> 
> For example, the following userspace code looks up a bogus entry in
> /proc/kpageflags:
> 
>     int pagemap = open("/proc/self/pagemap", O_RDONLY);
>     int pageflags = open("/proc/kpageflags", O_RDONLY);
>     uint64_t pfn, val;
> 
>     lseek64(pagemap, [...], SEEK_SET);
>     read(pagemap, &pfn, sizeof(pfn));
>     if (pfn & (1UL << 63)) {        /* valid PFN */
>         pfn &= ((1UL << 55) - 1);   /* clear flag bits */
>         pfn |= (1UL << 55);
>         lseek64(pageflags, pfn * sizeof(uint64_t), SEEK_SET);
>         read(pageflags, &val, sizeof(val));
>     }
> 
> On ARM64 this causes the userspace process to crash with SIGSEGV rather
> than reading (1 << KPF_NOPAGE).  kpageflags_read() treats the offset as
> valid, and stable_page_flags() will try to access an address between the
> user and kernel address ranges.
> 
> Signed-off-by: Greg Hackmann <ghackmann@google.com>
> ---
>  arch/arm64/mm/init.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Thanks, this looks like a sensible fix to me. Do you think it warrants a
CC stable?

Will

> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 9abf8a1e7b25..787e27964ab9 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -287,7 +287,11 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max)
>  #ifdef CONFIG_HAVE_ARCH_PFN_VALID
>  int pfn_valid(unsigned long pfn)
>  {
> -	return memblock_is_map_memory(pfn << PAGE_SHIFT);
> +	phys_addr_t addr = pfn << PAGE_SHIFT;
> +
> +	if ((addr >> PAGE_SHIFT) != pfn)
> +		return 0;
> +	return memblock_is_map_memory(addr);
>  }
>  EXPORT_SYMBOL(pfn_valid);
>  #endif
> -- 
> 2.18.0.597.ga71716f1ad-goog
> 
