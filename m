Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0BC3C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EC4220847
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:57:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EC4220847
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbeHWMZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:25:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:38050 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726966AbeHWMZ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:25:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 38C8EAED6;
        Thu, 23 Aug 2018 08:57:15 +0000 (UTC)
Date:   Thu, 23 Aug 2018 10:57:14 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH] mm: respect arch_dup_mmap() return value
Message-ID: <20180823085714.GY29735@dhcp22.suse.cz>
References: <20180823051229.211856-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180823051229.211856-1-namit@vmware.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 22-08-18 22:12:29, Nadav Amit wrote:
> Commit d70f2a14b72a4 ("include/linux/sched/mm.h: uninline
> mmdrop_async(), etc") ignored the return value of arch_dup_mmap(). As a
> result, on x86, a failure to duplicate the LDT (e.g., due to memory
> allocation error), would leave the duplicated memory mapping in an
> inconsistent state.
> 
> Fix by regarding the return value, as it was before the change.

Ohh, well spotted! I have a vague recollection I didn't really like the
patch. For other reasons. I didn't get to review it properly back then
because I didn't have much time and I didn't have a high motivation
because I simple disagreed with the patch.

> Fixes: d70f2a14b72a4 ("include/linux/sched/mm.h: uninline mmdrop_async(), etc")
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Nadav Amit <namit@vmware.com>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
>  kernel/fork.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 1b27babc4c78..4527d1d331de 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -549,8 +549,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>  			goto out;
>  	}
>  	/* a new mm has just been created */
> -	arch_dup_mmap(oldmm, mm);
> -	retval = 0;
> +	retval = arch_dup_mmap(oldmm, mm);
>  out:
>  	up_write(&mm->mmap_sem);
>  	flush_tlb_mm(oldmm);
> -- 
> 2.17.1
> 

-- 
Michal Hocko
SUSE Labs
