Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A5BECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 896C82150E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:57:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 896C82150E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390713AbeIUWrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 18:47:18 -0400
Received: from mga11.intel.com ([192.55.52.93]:26264 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728313AbeIUWrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 18:47:18 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Sep 2018 09:57:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,285,1534834800"; 
   d="scan'208";a="259214233"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga005.jf.intel.com with ESMTP; 21 Sep 2018 09:56:33 -0700
Received: from andy by smile with local (Exim 4.91)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1g3OjI-0008RS-32; Fri, 21 Sep 2018 19:56:32 +0300
Date:   Fri, 21 Sep 2018 19:56:32 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [QUEUED v20180920 15/16] lib: Add memcat_p(): paste 2 pointer
 arrays together
Message-ID: <20180921165632.GA15943@smile.fi.intel.com>
References: <20180920124553.56978-1-alexander.shishkin@linux.intel.com>
 <20180920124553.56978-16-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180920124553.56978-16-alexander.shishkin@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 03:45:52PM +0300, Alexander Shishkin wrote:
> This adds a helper to paste 2 pointer arrays together, useful for merging
> various types of attribute arrays. There are a few places in the kernel
> tree where this is open coded, and I just added one more in the STM class.
> 
> The naming is inspired by memset_p() and memcat(), and partial credit for
> it goes to Andy Shevchenko.
> 
> This patch adds the function wrapped in a type-enforcing macro and a test
> module.
> 
> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/linux/string.h |   7 +++
>  lib/Kconfig.debug      |   8 +++
>  lib/Makefile           |   1 +
>  lib/string.c           |  31 +++++++++++
>  lib/test_memcat_p.c    | 115 +++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 162 insertions(+)
>  create mode 100644 lib/test_memcat_p.c
> 
> diff --git a/include/linux/string.h b/include/linux/string.h
> index 4a5a0eb7df51..27d0482e5e05 100644
> --- a/include/linux/string.h
> +++ b/include/linux/string.h
> @@ -131,6 +131,13 @@ static inline void *memset_p(void **p, void *v, __kernel_size_t n)
>  		return memset64((uint64_t *)p, (uintptr_t)v, n);
>  }
>  
> +extern void **__memcat_p(void **a, void **b);
> +#define memcat_p(a, b) ({					\
> +	BUILD_BUG_ON_MSG(!__same_type(*(a), *(b)),		\
> +			 "type mismatch in memcat_p()");	\
> +	(typeof(*a) *)__memcat_p((void **)(a), (void **)(b));	\
> +})
> +
>  #ifndef __HAVE_ARCH_MEMCPY
>  extern void * memcpy(void *,const void *,__kernel_size_t);
>  #endif
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 613316724c6a..177e21006359 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1965,6 +1965,14 @@ config TEST_DEBUG_VIRTUAL
>  
>  	  If unsure, say N.
>  
> +config TEST_MEMCAT_P
> +	tristate "Test memcat_p() helper function"
> +	help
> +	  Test the memcat_p() helper for correctly merging two
> +	  pointer arrays together.
> +
> +	  If unsure, say N.
> +
>  endif # RUNTIME_TESTING_MENU
>  
>  config MEMTEST
> diff --git a/lib/Makefile b/lib/Makefile
> index ca3f7ebb900d..c2588a2d7b1e 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -71,6 +71,7 @@ obj-$(CONFIG_TEST_UUID) += test_uuid.o
>  obj-$(CONFIG_TEST_PARMAN) += test_parman.o
>  obj-$(CONFIG_TEST_KMOD) += test_kmod.o
>  obj-$(CONFIG_TEST_DEBUG_VIRTUAL) += test_debug_virtual.o
> +obj-$(CONFIG_TEST_MEMCAT_P) += test_memcat_p.o
>  
>  ifeq ($(CONFIG_DEBUG_KOBJECT),y)
>  CFLAGS_kobject.o += -DDEBUG
> diff --git a/lib/string.c b/lib/string.c
> index 2c0900a5d51a..453f35994eb6 100644
> --- a/lib/string.c
> +++ b/lib/string.c
> @@ -27,6 +27,7 @@
>  #include <linux/export.h>
>  #include <linux/bug.h>
>  #include <linux/errno.h>
> +#include <linux/slab.h>
>  
>  #include <asm/byteorder.h>
>  #include <asm/word-at-a-time.h>
> @@ -890,6 +891,36 @@ void *memscan(void *addr, int c, size_t size)
>  EXPORT_SYMBOL(memscan);
>  #endif
>  
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

As far as I understand the logic behind this initially we have:
	n elements + NULL + m elements + NULL,
	nr equals n + m + NULL,
nr - 1 points to the last element in the new array at the beginning of the
loop. Since we are operating on arrays, p at some point becomes 'b' at which
time we switch to the 'a' array. It might be rewritten slightly more
straightforward (like in two loops, but on the other hand it would require to
track number of elements in each of the arrays separately).

So, I don't see any off-by-one issues here.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> +
> +	return new;
> +}
> +EXPORT_SYMBOL_GPL(__memcat_p);
> +
>  #ifndef __HAVE_ARCH_STRSTR
>  /**
>   * strstr - Find the first substring in a %NUL terminated string
> diff --git a/lib/test_memcat_p.c b/lib/test_memcat_p.c
> new file mode 100644
> index 000000000000..2b163a749ecb
> --- /dev/null
> +++ b/lib/test_memcat_p.c
> @@ -0,0 +1,115 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Test cases for memcat_p() in lib/string.c
> + */
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/string.h>
> +#include <linux/slab.h>
> +#include <linux/module.h>
> +
> +struct test_struct {
> +	int		num;
> +	unsigned int	magic;
> +};
> +
> +#define MAGIC		0xf00ff00f
> +/* Size of each of the NULL-terminated input arrays */
> +#define INPUT_MAX	128
> +/* Expected number of non-NULL elements in the output array */
> +#define EXPECT		(INPUT_MAX * 2 - 2)
> +
> +static int __init test_memcat_p_init(void)
> +{
> +	struct test_struct **in0, **in1, **out, **p;
> +	int err = -ENOMEM, i, r, total = 0;
> +
> +	in0 = kcalloc(INPUT_MAX, sizeof(*in0), GFP_KERNEL);
> +	if (!in0)
> +		return err;
> +
> +	in1 = kcalloc(INPUT_MAX, sizeof(*in1), GFP_KERNEL);
> +	if (!in1)
> +		goto err_free_in0;
> +
> +	for (i = 0, r = 1; i < INPUT_MAX - 1; i++) {
> +		in0[i] = kmalloc(sizeof(**in0), GFP_KERNEL);
> +		if (!in0[i])
> +			goto err_free_elements;
> +
> +		in1[i] = kmalloc(sizeof(**in1), GFP_KERNEL);
> +		if (!in1[i]) {
> +			kfree(in0[i]);
> +			goto err_free_elements;
> +		}
> +
> +		/* lifted from test_sort.c */
> +		r = (r * 725861) % 6599;
> +		in0[i]->num = r;
> +		in1[i]->num = -r;
> +		in0[i]->magic = MAGIC;
> +		in1[i]->magic = MAGIC;
> +	}
> +
> +	in0[i] = in1[i] = NULL;
> +
> +	out = memcat_p(in0, in1);
> +	if (!out)
> +		goto err_free_all_elements;
> +
> +	err = -EINVAL;
> +	for (i = 0, p = out; *p && (i < INPUT_MAX * 2 - 1); p++, i++) {
> +		total += (*p)->num;
> +
> +		if ((*p)->magic != MAGIC) {
> +			pr_err("test failed: wrong magic at %d: %u\n", i,
> +			       (*p)->magic);
> +			goto err_free_out;
> +		}
> +	}
> +
> +	if (total) {
> +		pr_err("test failed: expected zero total, got %d\n", total);
> +		goto err_free_out;
> +	}
> +
> +	if (i != EXPECT) {
> +		pr_err("test failed: expected output size %d, got %d\n",
> +		       EXPECT, i);
> +		goto err_free_out;
> +	}
> +
> +	for (i = 0; i < INPUT_MAX - 1; i++)
> +		if (out[i] != in0[i] || out[i + INPUT_MAX - 1] != in1[i]) {
> +			pr_err("test failed: wrong element order at %d\n", i);
> +			goto err_free_out;
> +		}
> +
> +	err = 0;
> +	pr_info("test passed\n");
> +
> +err_free_out:
> +	kfree(out);
> +err_free_all_elements:
> +	i = INPUT_MAX;
> +err_free_elements:
> +	for (i--; i >= 0; i--) {
> +		kfree(in1[i]);
> +		kfree(in0[i]);
> +	}
> +
> +	kfree(in1);
> +err_free_in0:
> +	kfree(in0);
> +
> +	return err;
> +}
> +
> +static void __exit test_memcat_p_exit(void)
> +{
> +}
> +
> +module_init(test_memcat_p_init);
> +module_exit(test_memcat_p_exit);
> +
> +MODULE_LICENSE("GPL");
> -- 
> 2.18.0
> 

-- 
With Best Regards,
Andy Shevchenko


