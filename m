Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5FE1ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 17:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB15720684
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 17:53:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB15720684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbeKID3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 22:29:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:58352 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726801AbeKID3k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 22:29:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BFA67AD5C;
        Thu,  8 Nov 2018 17:53:03 +0000 (UTC)
Date:   Thu, 8 Nov 2018 18:53:01 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     akpm@linux-foundation.org, rientjes@google.com,
        dan.j.williams@intel.com, linux@dominikbrodowski.net,
        dave.hansen@linux.intel.com, dwmw@amazon.co.uk, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: mmap: remove verify_mm_writelocked()
Message-ID: <20181108175301.GC18390@dhcp22.suse.cz>
References: <20181108174856.10811-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181108174856.10811-1-tiny.windzz@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 08-11-18 12:48:56, Yangtao Li wrote:
> We should get rid of this function. It no longer serves its purpose.This
> is a historical artifact from 2005 where do_brk was called outside of
> the core mm.We do have a proper abstraction in vm_brk_flags and that one
> does the locking properly.So there is no need to use this function.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/mmap.c | 16 ----------------
>  1 file changed, 16 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index f7cd9cb966c0..1cee506494d2 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2910,16 +2910,6 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
>  	return ret;
>  }
>  
> -static inline void verify_mm_writelocked(struct mm_struct *mm)
> -{
> -#ifdef CONFIG_DEBUG_VM
> -	if (unlikely(down_read_trylock(&mm->mmap_sem))) {
> -		WARN_ON(1);
> -		up_read(&mm->mmap_sem);
> -	}
> -#endif
> -}
> -
>  /*
>   *  this is really a simplified "do_mmap".  it only handles
>   *  anonymous maps.  eventually we may be able to do some
> @@ -2946,12 +2936,6 @@ static int do_brk_flags(unsigned long addr, unsigned long len, unsigned long fla
>  	if (error)
>  		return error;
>  
> -	/*
> -	 * mm->mmap_sem is required to protect against another thread
> -	 * changing the mappings in case we sleep.
> -	 */
> -	verify_mm_writelocked(mm);
> -
>  	/*
>  	 * Clear old maps.  this also does some error checking for us
>  	 */
> -- 
> 2.17.0
> 

-- 
Michal Hocko
SUSE Labs
