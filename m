Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81984C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 14:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47DCD27F92
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 14:30:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47DCD27F92
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935430AbeF2Oax (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 10:30:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:37454 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935212AbeF2Oas (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 10:30:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CF078AFF9;
        Fri, 29 Jun 2018 14:30:46 +0000 (UTC)
Date:   Fri, 29 Jun 2018 16:30:44 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Greg Thelen <gthelen@google.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Peter Feiner <pfeiner@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2] kvm, mm: account shadow page tables to kmemcg
Message-ID: <20180629143044.GF5963@dhcp22.suse.cz>
References: <20180629140224.205849-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180629140224.205849-1-shakeelb@google.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 29-06-18 07:02:24, Shakeel Butt wrote:
> The size of kvm's shadow page tables corresponds to the size of the
> guest virtual machines on the system. Large VMs can spend a significant
> amount of memory as shadow page tables which can not be left as system
> memory overhead. So, account shadow page tables to the kmemcg.
> 
> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Greg Thelen <gthelen@google.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Cc: Peter Feiner <pfeiner@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: stable@vger.kernel.org

I am not familiar wtih kvm to judge but if we are going to account this
memory we will probably want to let oom_badness know how much memory
to account to a specific process. Is this something that we can do?
We will probably need a new MM_KERNEL rss_stat stat for that purpose.

Just to make it clear. I am not opposing to this patch but considering
that shadow page tables might consume a lot of memory it would be good
to know who is responsible for it from the OOM perspective. Something to
solve on top of this.

I would also love to see a note how this memory is bound to the owner
life time in the changelog. That would make the review much more easier.

> ---
> Changelog since v1:
> - replaced (GFP_KERNEL|__GFP_ACCOUNT) with GFP_KERNEL_ACCOUNT
> 
>  arch/x86/kvm/mmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
> index d594690d8b95..6b8f11521c41 100644
> --- a/arch/x86/kvm/mmu.c
> +++ b/arch/x86/kvm/mmu.c
> @@ -890,7 +890,7 @@ static int mmu_topup_memory_cache_page(struct kvm_mmu_memory_cache *cache,
>  	if (cache->nobjs >= min)
>  		return 0;
>  	while (cache->nobjs < ARRAY_SIZE(cache->objects)) {
> -		page = (void *)__get_free_page(GFP_KERNEL);
> +		page = (void *)__get_free_page(GFP_KERNEL_ACCOUNT);
>  		if (!page)
>  			return -ENOMEM;
>  		cache->objects[cache->nobjs++] = page;
> -- 
> 2.18.0.rc2.346.g013aa6912e-goog

-- 
Michal Hocko
SUSE Labs
