Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A10C0C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6348F20881
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:03:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6348F20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbeJPWya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 18:54:30 -0400
Received: from mga14.intel.com ([192.55.52.115]:37563 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbeJPWya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 18:54:30 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2018 08:03:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,388,1534834800"; 
   d="scan'208";a="272881009"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga006.fm.intel.com with ESMTP; 16 Oct 2018 08:03:37 -0700
Received: from andy by smile with local (Exim 4.91)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1gCQsh-0000UC-Sd; Tue, 16 Oct 2018 18:03:35 +0300
Date:   Tue, 16 Oct 2018 18:03:35 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>, Joe Perches <joe@perches.com>
Subject: Re: [PATCH] lib: Fix ia64 bootloader linkage
Message-ID: <20181016150335.GZ15943@smile.fi.intel.com>
References: <201810161649.o89WBjtC%fengguang.wu@intel.com>
 <20181016111340.8046-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016111340.8046-1-alexander.shishkin@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 02:13:40PM +0300, Alexander Shishkin wrote:
> kbuild robot reports that since commit ce76d938dd98 ("lib: Add memcat_p():
> paste 2 pointer arrays together") the ia64/hp/sim/boot fails to link:
> 
> > LD      arch/ia64/hp/sim/boot/bootloader
> > lib/string.o: In function `__memcat_p':
> > string.c:(.text+0x1f22): undefined reference to `__kmalloc'
> > string.c:(.text+0x1ff2): undefined reference to `__kmalloc'
> > make[1]: *** [arch/ia64/hp/sim/boot/Makefile:37: arch/ia64/hp/sim/boot/bootloader] Error 1
> 
> The reason is, the above commit, via __memcat_p(), adds a call to
> __kmalloc to string.o, which happens to be used in the bootloader, but
> there's no kmalloc or slab or anything.
> 
> Since the linker would only pull in objects that contain referenced
> symbols, moving __memcat_p() to a different compilation unit solves the
> problem.
> 

Oh, nice catch!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Perhaps checkpatch.pl can somehow catch these...

> Fixes: ce76d938dd98 ("lib: Add memcat_p(): paste 2 pointer arrays together")
> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Reported-by: kbuild test robot <lkp@intel.com>
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Joe Perches <joe@perches.com>
> ---
>  lib/Makefile        |  2 +-
>  lib/memcat_p.c      | 34 ++++++++++++++++++++++++++++++++++
>  lib/string.c        | 30 ------------------------------
>  lib/test_memcat_p.c |  2 +-
>  4 files changed, 36 insertions(+), 32 deletions(-)
>  create mode 100644 lib/memcat_p.c
> 
> diff --git a/lib/Makefile b/lib/Makefile
> index c2588a2d7b1e..40e79f88c3cd 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -24,7 +24,7 @@ lib-y := ctype.o string.o vsprintf.o cmdline.o \
>  	 flex_proportions.o ratelimit.o show_mem.o \
>  	 is_single_threaded.o plist.o decompress.o kobject_uevent.o \
>  	 earlycpio.o seq_buf.o siphash.o dec_and_lock.o \
> -	 nmi_backtrace.o nodemask.o win_minmax.o
> +	 nmi_backtrace.o nodemask.o win_minmax.o memcat_p.o
>  
>  lib-$(CONFIG_PRINTK) += dump_stack.o
>  lib-$(CONFIG_MMU) += ioremap.o
> diff --git a/lib/memcat_p.c b/lib/memcat_p.c
> new file mode 100644
> index 000000000000..b810fbc66962
> --- /dev/null
> +++ b/lib/memcat_p.c
> @@ -0,0 +1,34 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/slab.h>
> +
> +/*
> + * Merge two NULL-terminated pointer arrays into a newly allocated
> + * array, which is also NULL-terminated. Nomenclature is inspired by
> + * memset_p() and memcat() found elsewhere in the kernel source tree.
> + */
> +void **__memcat_p(void **a, void **b)
> +{
> +	void **p = a, **new;
> +	int nr;
> +
> +	/* count the elements in both arrays */
> +	for (nr = 0, p = a; *p; nr++, p++)
> +		;
> +	for (p = b; *p; nr++, p++)
> +		;
> +	/* one for the NULL-terminator */
> +	nr++;
> +
> +	new = kmalloc_array(nr, sizeof(void *), GFP_KERNEL);
> +	if (!new)
> +		return NULL;
> +
> +	/* nr -> last index; p points to NULL in b[] */
> +	for (nr--; nr >= 0; nr--, p = p == b ? &a[nr] : p - 1)
> +		new[nr] = *p;
> +
> +	return new;
> +}
> +EXPORT_SYMBOL_GPL(__memcat_p);
> +
> diff --git a/lib/string.c b/lib/string.c
> index 453f35994eb6..38e4ca08e757 100644
> --- a/lib/string.c
> +++ b/lib/string.c
> @@ -891,36 +891,6 @@ void *memscan(void *addr, int c, size_t size)
>  EXPORT_SYMBOL(memscan);
>  #endif
>  
> -/*
> - * Merge two NULL-terminated pointer arrays into a newly allocated
> - * array, which is also NULL-terminated. Nomenclature is inspired by
> - * memset_p() and memcat() found elsewhere in the kernel source tree.
> - */
> -void **__memcat_p(void **a, void **b)
> -{
> -	void **p = a, **new;
> -	int nr;
> -
> -	/* count the elements in both arrays */
> -	for (nr = 0, p = a; *p; nr++, p++)
> -		;
> -	for (p = b; *p; nr++, p++)
> -		;
> -	/* one for the NULL-terminator */
> -	nr++;
> -
> -	new = kmalloc_array(nr, sizeof(void *), GFP_KERNEL);
> -	if (!new)
> -		return NULL;
> -
> -	/* nr -> last index; p points to NULL in b[] */
> -	for (nr--; nr >= 0; nr--, p = p == b ? &a[nr] : p - 1)
> -		new[nr] = *p;
> -
> -	return new;
> -}
> -EXPORT_SYMBOL_GPL(__memcat_p);
> -
>  #ifndef __HAVE_ARCH_STRSTR
>  /**
>   * strstr - Find the first substring in a %NUL terminated string
> diff --git a/lib/test_memcat_p.c b/lib/test_memcat_p.c
> index 2b163a749ecb..849c477d49d0 100644
> --- a/lib/test_memcat_p.c
> +++ b/lib/test_memcat_p.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * Test cases for memcat_p() in lib/string.c
> + * Test cases for memcat_p() in lib/memcat_p.c
>   */
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
> -- 
> 2.19.1
> 

-- 
With Best Regards,
Andy Shevchenko


