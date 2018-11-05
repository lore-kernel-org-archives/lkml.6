Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D40C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 06:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56FCA2081D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 06:51:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56FCA2081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729403AbeKEQJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 11:09:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:34302 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728955AbeKEQJS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 11:09:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 56B7CB002;
        Mon,  5 Nov 2018 06:51:07 +0000 (UTC)
Date:   Mon, 5 Nov 2018 07:51:05 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        vbabka@suse.cz, yang.shi@linux.alibaba.com, rientjes@google.com,
        linux@dominikbrodowski.net, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: mmap: remove unnecessary unlikely()
Message-ID: <20181105065037.GA4361@dhcp22.suse.cz>
References: <20181104124456.3424-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181104124456.3424-1-tiny.windzz@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 04-11-18 07:44:56, Yangtao Li wrote:
> WARN_ON() already contains an unlikely(), so it's not necessary to use
> unlikely.

We should just get rid of this ugliness altogether. It no longer serves
its purpose.  This is a historical artifact from 2005 where do_brk
was called outside of the core mm. We do have a proper abstraction in
vm_brk_flags and that one does the locking properly.

> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  mm/mmap.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 6c04292e16a7..2077008ade0c 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2965,10 +2965,8 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
>  static inline void verify_mm_writelocked(struct mm_struct *mm)
>  {
>  #ifdef CONFIG_DEBUG_VM
> -	if (unlikely(down_read_trylock(&mm->mmap_sem))) {
> -		WARN_ON(1);
> +	if (WARN_ON(down_read_trylock(&mm->mmap_sem)))
>  		up_read(&mm->mmap_sem);
> -	}
>  #endif
>  }
>  
> -- 
> 2.17.0
> 

-- 
Michal Hocko
SUSE Labs
