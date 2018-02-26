Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751554AbeBZX5g (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 18:57:36 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:44313 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750941AbeBZX5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 18:57:35 -0500
X-Google-Smtp-Source: AG47ELvX3Wu4cx2aHJvLq2W06C15ox4sA2+5wWW1ap10xGHQIu1uRFy7XV0aEB/xxSSKsAcUrKyK9A==
Date: Mon, 26 Feb 2018 15:57:32 -0800 (PST)
From: David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Guenter Roeck <linux@roeck-us.net>
cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH] mm: Provide consistent declaration for
 num_poisoned_pages
In-Reply-To: <1519686565-8224-1-git-send-email-linux@roeck-us.net>
Message-ID: <alpine.DEB.2.20.1802261556420.236524@chino.kir.corp.google.com>
References: <1519686565-8224-1-git-send-email-linux@roeck-us.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Feb 2018, Guenter Roeck wrote:

> clang reports the following compile warning.
> 
> In file included from mm/vmscan.c:56:
> ./include/linux/swapops.h:327:22: warning:
> 	section attribute is specified on redeclared variable [-Wsection]
> extern atomic_long_t num_poisoned_pages __read_mostly;
>                      ^
> ./include/linux/mm.h:2585:22: note: previous declaration is here
> extern atomic_long_t num_poisoned_pages;
>                      ^
> 
> Let's use __read_mostly everywhere.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> Cc: Matthias Kaehlcke <mka@chromium.org>
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

No objection to the patch, of course, but I'm wondering if it's (1) the 
only such clang compile warning for mm/, and (2) if the re-declaration in 
mm.h could be avoided by including swapops.h?
