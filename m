Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751772AbeDFQw6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 12:52:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58296 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751389AbeDFQw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 12:52:57 -0400
Subject: Re: [PATCH] swap: divide-by-zero when zero length swap file on ssd
To: Tom Abraham <tabraham@suse.com>, linux-kernel@vger.kernel.org
References: <5AC747C1020000A7001FA82C@prv-mh.provo.novell.com>
Cc: Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <fdca1f72-8e51-7727-d1a0-4ccd60e80bd0@infradead.org>
Date: Fri, 6 Apr 2018 09:52:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <5AC747C1020000A7001FA82C@prv-mh.provo.novell.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[adding linux-mm and akpm]

On 04/06/2018 07:11 AM, Tom Abraham wrote:
>                                                                                 
> Calling swapon() on a zero length swap file on SSD can lead to a                
> divide-by-zero.                                                                 
>                                                                                 
> Although creating such files isn't possible with mkswap and they woud be        
> considered invalid, it would be better for the swapon code to be more robust    
> and handle this condition gracefully (return -EINVAL). Especially since the fix 
> is small and straight-forward.                                                  
>                                                                                 
> To help with wear leveling on SSD, the swapon syscall calculates a random       
> position in the swap file using modulo p->highest_bit, which is set to          
> maxpages - 1 in read_swap_header.                                               
>                                                                                 
> If the swap file is zero length, read_swap_header sets maxpages=1 and           
> last_page=0, resulting in p->highest_bit=0 and we divide-by-zero when we modulo 
> p->highest_bit in swapon syscall.                                               
>                                                                                 
> This can be prevented by having read_swap_header return zero if last_page is    
> zero.                                                                           
>                                                                                 
> diff --git a/mm/swapfile.c b/mm/swapfile.c                                      
> index c7a33717d079..d6b7bd9f365d 100644                                         
> --- a/mm/swapfile.c                                                             
> +++ b/mm/swapfile.c                                                             
> @@ -2961,6 +2961,10 @@ static unsigned long read_swap_header(struct swap_info_struct *p,
>         maxpages = swp_offset(pte_to_swp_entry(                                 
>                         swp_entry_to_pte(swp_entry(0, ~0UL)))) + 1;             
>         last_page = swap_header->info.last_page;                                
> +       if(!last_page) {                                                        
> +               pr_warn("Empty swap-file\n");                                   
> +               return 0;                                                       
> +       }                                                                       
>         if (last_page > maxpages) {                                             
>                 pr_warn("Truncating oversized swap area, only using %luk out of %luk\n",
>                         maxpages << (PAGE_SHIFT - 10),
> 


-- 
~Randy
