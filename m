Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752704AbeCPXEy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 19:04:54 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:38990 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750915AbeCPXEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 19:04:50 -0400
X-Google-Smtp-Source: AG47ELsvY3wXVvrhty9mEDdl9/jR0a+R8ul3XeMJzQST2tTZRbNpCA3oinn35YTenPLKIVSPOhWrTQ==
Date: Fri, 16 Mar 2018 16:04:49 -0700
From: Matthias Kaehlcke <mka@chromium.org>
To: Nick Desaulniers <nick.desaulniers@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Jan Kara <jack@suse.cz>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Hugh Dickins <hughd@google.com>, Matthew Wilcox <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memory-failure: fix section mismatch
Message-ID: <20180316230448.GA37438@google.com>
References: <20180304071613.16899-1-nick.desaulniers@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180304071613.16899-1-nick.desaulniers@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

El Sat, Mar 03, 2018 at 11:16:11PM -0800 Nick Desaulniers ha dit:

> Clang complains when a variable is declared extern twice, but with two
> different sections. num_poisoned_pages is marked extern and __read_mostly
> in include/linux/swapops.h, but only extern in include/linux/mm.h. Some
> c source files must include both, and thus see the conflicting
> declarations.
> 
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

An equivalent patch was posted by Guenter Roeck and has been picked up
by Andrew: https://patchwork.kernel.org/patch/10243919/
