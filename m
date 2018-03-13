Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752563AbeCMOpk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 10:45:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:60579 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752257AbeCMOpi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 10:45:38 -0400
Date: Tue, 13 Mar 2018 15:45:36 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Nick Desaulniers <nick.desaulniers@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Jan Kara <jack@suse.cz>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Hugh Dickins <hughd@google.com>, Matthew Wilcox <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memory-failure: fix section mismatch
Message-ID: <20180313144536.GC4811@dhcp22.suse.cz>
References: <20180304071613.16899-1-nick.desaulniers@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180304071613.16899-1-nick.desaulniers@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 03-03-18 23:16:11, Nick Desaulniers wrote:
> Clang complains when a variable is declared extern twice, but with two
> different sections. num_poisoned_pages is marked extern and __read_mostly
> in include/linux/swapops.h, but only extern in include/linux/mm.h. Some
> c source files must include both, and thus see the conflicting
> declarations.

Why do we need declarations in both places? This sounds like a mess to
me.

> Signed-off-by: Nick Desaulniers <nick.desaulniers@gmail.com>
> ---
>  include/linux/mm.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index ad06d42adb1a..bd4bd59f02c1 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2582,7 +2582,7 @@ extern int get_hwpoison_page(struct page *page);
>  extern int sysctl_memory_failure_early_kill;
>  extern int sysctl_memory_failure_recovery;
>  extern void shake_page(struct page *p, int access);
> -extern atomic_long_t num_poisoned_pages;
> +extern atomic_long_t num_poisoned_pages __read_mostly;
>  extern int soft_offline_page(struct page *page, int flags);
>  
>  
> -- 
> 2.14.1
> 

-- 
Michal Hocko
SUSE Labs
