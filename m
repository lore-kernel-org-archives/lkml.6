Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752477AbeBBPJE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 10:09:04 -0500
Received: from mail5.windriver.com ([192.103.53.11]:57912 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752450AbeBBPI5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 10:08:57 -0500
Subject: Re: [PATCH] kdb: use memmove instead of overlapping memcpy
To: Arnd Bergmann <arnd@arndb.de>,
        Daniel Thompson <daniel.thompson@linaro.org>
CC: Nicolas Pitre <nico@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        <kgdb-bugreport@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
References: <20180202145952.285505-1-arnd@arndb.de>
From: Jason Wessel <jason.wessel@windriver.com>
Message-ID: <0304cb01-ed28-d16f-9384-1443db682b5c@windriver.com>
Date: Fri, 2 Feb 2018 09:08:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180202145952.285505-1-arnd@arndb.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/2018 08:59 AM, Arnd Bergmann wrote:
> gcc discovered that the memcpy() arguments in kdbnearsym() overlap, so
> we should really use memmove(), which is defined to handle that correctly:
> 
> In function 'memcpy',
>      inlined from 'kdbnearsym' at /git/arm-soc/kernel/debug/kdb/kdb_support.c:132:4:
> /git/arm-soc/include/linux/string.h:353:9: error: '__builtin_memcpy' accessing 792 bytes at offsets 0 and 8 overlaps 784 bytes at offset 8 [-Werror=restrict]
>    return __builtin_memcpy(p, q, size);
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   kernel/debug/kdb/kdb_support.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/debug/kdb/kdb_support.c b/kernel/debug/kdb/kdb_support.c
> index 5d8ef3a07ecd..1ad4370ccbf0 100644
> --- a/kernel/debug/kdb/kdb_support.c
> +++ b/kernel/debug/kdb/kdb_support.c
> @@ -129,13 +129,13 @@ int kdbnearsym(unsigned long addr, kdb_symtab_t *symtab)
>   		}
>   		if (i >= ARRAY_SIZE(kdb_name_table)) {
>   			debug_kfree(kdb_name_table[0]);
> -			memcpy(kdb_name_table, kdb_name_table+1,
> +			memmove(kdb_name_table, kdb_name_table+1,
>   			       sizeof(kdb_name_table[0]) *
>   			       (ARRAY_SIZE(kdb_name_table)-1));
>   		} else {
>   			debug_kfree(knt1);
>   			knt1 = kdb_name_table[i];
> -			memcpy(kdb_name_table+i, kdb_name_table+i+1,
> +			memmove(kdb_name_table+i, kdb_name_table+i+1,
>   			       sizeof(kdb_name_table[0]) *
>   			       (ARRAY_SIZE(kdb_name_table)-i-1));
>   		}
> 


That is good by me.   Many thanks!  Added to queue.

Reviewed-by: Jason Wessel <jason.wessel@windriver.com>

Jason.
