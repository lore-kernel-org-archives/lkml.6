Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751323AbeCLMkp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 08:40:45 -0400
Received: from merlin.infradead.org ([205.233.59.134]:42104 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751053AbeCLMko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 08:40:44 -0400
Date: Mon, 12 Mar 2018 13:40:27 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: kirill.shutemov@linux.intel.com, gorcunov@openvz.org,
        luto@amacapital.net, keescook@chromium.org, willy@infradead.org,
        torvalds@linux-foundation.org, tglx@linutronix.de, bp@suse.de,
        andy.shevchenko@gmail.com, linux-kernel@vger.kernel.org, hpa@zytor.com,
        mingo@kernel.org, ebiederm@xmission.com, jgross@suse.com
Cc: linux-tip-commits@vger.kernel.org
Subject: Re: [tip:x86/mm] x86/boot/compressed/64: Describe the logic behind
 the LA57 check
Message-ID: <20180312124027.GG4064@hirez.programming.kicks-ass.net>
References: <20180226180451.86788-2-kirill.shutemov@linux.intel.com>
 <tip-a403d798182f4f7be5e9bab56cfa37e9828fd92a@git.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tip-a403d798182f4f7be5e9bab56cfa37e9828fd92a@git.kernel.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 02:27:58AM -0700, tip-bot for Kirill A. Shutemov wrote:
> +	/*
> +	 * Check if LA57 is desired and supported.
> +	 *
> +	 * There are two parts to the check:
> +	 *   - if the kernel supports 5-level paging: CONFIG_X86_5LEVEL=y
> +	 *   - if the machine supports 5-level paging:
> +	 *     + CPUID leaf 7 is supported
> +	 *     + the leaf has the feature bit set
> +	 *
> +	 * That's substitute for boot_cpu_has() in early boot code.
> +	 */
> +	if (IS_ENABLED(CONFIG_X86_5LEVEL) &&
> +			native_cpuid_eax(0) >= 7 &&
> +			(native_cpuid_ecx(7) & (1 << (X86_FEATURE_LA57 & 31)))) {
>  		paging_config.l5_required = 1;
> +	}

Should this not also include something like: machine actually has
suffient memory for it to make sense to use l5 ?
