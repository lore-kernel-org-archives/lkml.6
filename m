Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933014AbeBMAsK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 19:48:10 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:53812 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932779AbeBMAsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 19:48:08 -0500
Date: Tue, 13 Feb 2018 11:48:11 +1100 (AEDT)
From: Finn Thain <fthain@telegraphics.com.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: linux-m68k@vger.kernel.org, Greg Ungerer <gerg@linux-m68k.org>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] m68k/mm: Stop printing the virtual memory layout
In-Reply-To: <1518425633-19803-1-git-send-email-geert@linux-m68k.org>
Message-ID: <alpine.LNX.2.21.1802131143320.8@nippy.intranet>
References: <1518425633-19803-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Feb 2018, Geert Uytterhoeven wrote:

> Since commit ad67b74d2469d9b8 ("printk: hash addresses printed with
> %p"), the virtual memory layout printed during boot up contains "ptrval"
> instead of actual addresses:
> 
>     Memory: 268040K/276480K available (2979K kernel code, 310K rwdata, 784K rodata, 144K init, 172K bss, 8440K reserved, 0K cma-reserved)
>     Virtual kernel memory layout:
> 	vector  : 0x003d2e74 - 0x003d3274   (   1 KiB)
> 	kmap    : 0xd0000000 - 0xf0000000   ( 512 MiB)
> 	vmalloc : 0x11800000 - 0xd0000000   (3048 MiB)
> 	lowmem  : 0x00000000 - 0x11000000   ( 272 MiB)
> 	  .init : 0x(ptrval) - 0x(ptrval)   ( 144 KiB)
> 	  .text : 0x(ptrval) - 0x(ptrval)   (2980 KiB)
> 	  .data : 0x(ptrval) - 0x(ptrval)   (1095 KiB)
> 	  .bss  : 0x(ptrval) - 0x(ptrval)   ( 173 KiB)
> 
> Instead of changing the printing to "%px", and leaking virtual memory
> layout information again,
> 
> just remove the printing completely, cfr. e.g.
> commit 071929dbdd865f77 ("arm64: Stop printing the virtual memory
> layout").
> 
> All interesting information (actual section sizes) is already printed by
> mem_init_print_info() just above anyway.
> 

Or maybe revert to %lx with pr_debug instead of pr_notice. Just a thought; 
I don't have any preference.

-- 

> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  arch/m68k/mm/init.c | 27 ---------------------------
>  1 file changed, 27 deletions(-)
> 
> diff --git a/arch/m68k/mm/init.c b/arch/m68k/mm/init.c
> index e85acd131fa8fe76..8827b7f914025595 100644
> --- a/arch/m68k/mm/init.c
> +++ b/arch/m68k/mm/init.c
> @@ -120,32 +120,6 @@ void free_initmem(void)
>  #define VECTORS	_ramvec
>  #endif
>  
> -void __init print_memmap(void)
> -{
> -#define UL(x) ((unsigned long) (x))
> -#define MLK(b, t) UL(b), UL(t), (UL(t) - UL(b)) >> 10
> -#define MLM(b, t) UL(b), UL(t), (UL(t) - UL(b)) >> 20
> -#define MLK_ROUNDUP(b, t) b, t, DIV_ROUND_UP(((t) - (b)), 1024)
> -
> -	pr_notice("Virtual kernel memory layout:\n"
> -		"    vector  : 0x%08lx - 0x%08lx   (%4ld KiB)\n"
> -		"    kmap    : 0x%08lx - 0x%08lx   (%4ld MiB)\n"
> -		"    vmalloc : 0x%08lx - 0x%08lx   (%4ld MiB)\n"
> -		"    lowmem  : 0x%08lx - 0x%08lx   (%4ld MiB)\n"
> -		"      .init : 0x%p" " - 0x%p" "   (%4d KiB)\n"
> -		"      .text : 0x%p" " - 0x%p" "   (%4d KiB)\n"
> -		"      .data : 0x%p" " - 0x%p" "   (%4d KiB)\n"
> -		"      .bss  : 0x%p" " - 0x%p" "   (%4d KiB)\n",
> -		MLK(VECTORS, VECTORS + 256),
> -		MLM(KMAP_START, KMAP_END),
> -		MLM(VMALLOC_START, VMALLOC_END),
> -		MLM(PAGE_OFFSET, (unsigned long)high_memory),
> -		MLK_ROUNDUP(__init_begin, __init_end),
> -		MLK_ROUNDUP(_stext, _etext),
> -		MLK_ROUNDUP(_sdata, _edata),
> -		MLK_ROUNDUP(__bss_start, __bss_stop));
> -}
> -
>  static inline void init_pointer_tables(void)
>  {
>  #if defined(CONFIG_MMU) && !defined(CONFIG_SUN3) && !defined(CONFIG_COLDFIRE)
> @@ -170,7 +144,6 @@ void __init mem_init(void)
>  	free_all_bootmem();
>  	init_pointer_tables();
>  	mem_init_print_info(NULL);
> -	print_memmap();
>  }
>  
>  #ifdef CONFIG_BLK_DEV_INITRD
> 
