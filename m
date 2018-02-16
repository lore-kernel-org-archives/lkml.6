Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751383AbeBPS0G (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 13:26:06 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:40237 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750947AbeBPS0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 13:26:03 -0500
X-Google-Smtp-Source: AH8x227tcL/Nkvc3fxvm/QBE47VOuQLoShAJzXBcbs3Co7F9n0ATHYIVRnW1yP2G7aWHcKCyAW2d/g==
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 2/3] x86/mm: introduce __PAGE_KERNEL_GLOBAL
From: Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <a3dd1676-a2dc-aa02-77ad-51cd3b7a78d5@linux.intel.com>
Date: Fri, 16 Feb 2018 10:25:59 -0800
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, luto@kernel.org,
        torvalds@linux-foundation.org, keescook@google.com, hughd@google.com,
        jgross@suse.com, x86@kernel.org
Message-Id: <DF43D1DD-42EE-4545-9F54-4BC2395D66EA@gmail.com>
References: <20180215132053.6C9B48C8@viggo.jf.intel.com>
 <20180215132055.F341C31E@viggo.jf.intel.com>
 <E0AB2852-C4E0-43D3-ABA7-34117A5516C1@gmail.com>
 <a3dd1676-a2dc-aa02-77ad-51cd3b7a78d5@linux.intel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1GIQKBA019040

Dave Hansen <dave.hansen@linux.intel.com> wrote:

> On 02/16/2018 09:47 AM, Nadav Amit wrote:
>>> But, this also means that we now get *no* opportunity to use
>>> global pages with PTI, even for data which is shared such as the
>>> cpu_entry_area and entry/exit text.
>> 
>> Doesn’t this patch change the kernel behavior when the “nopti”
>> parameter is used?
> 
> I don't think so.  It takes the "nopti" behavior and effectively makes
> it apply everywhere.  So it changes the PTI behavior, not the "nopti"
> behavior.
> 
> Maybe it would help to quote the code that you think does this instead
> of the description. :)

Sorry, I thought it is obvious - so I must be missing something.

> +#ifdef CONFIG_PAGE_TABLE_ISOLATION
> +#define __PAGE_KERNEL_GLOBAL		0
> +#else
> +#define __PAGE_KERNEL_GLOBAL		_PAGE_GLOBAL
> +#endif
...
> --- a/arch/x86/mm/pageattr.c~kpti-no-global-for-kernel-mappings	2018-02-13 15:17:56.148210060 -0800
> +++ b/arch/x86/mm/pageattr.c	2018-02-13 15:17:56.153210060 -0800
> @@ -593,7 +593,8 @@ try_preserve_large_page(pte_t *kpte, uns
> 	 * different bit positions in the two formats.
> 	 */
> 	req_prot = pgprot_4k_2_large(req_prot);
> -	req_prot = pgprot_set_on_present(req_prot, _PAGE_GLOBAL | _PAGE_PSE);
> +	req_prot = pgprot_set_on_present(req_prot,
> +			__PAGE_KERNEL_GLOBAL | _PAGE_PSE);
> 	req_prot = canon_pgprot(req_prot);

>From these chunks, it seems to me as req_prot will not have the global bit
on when “nopti” parameter is provided. What am I missing?
 
