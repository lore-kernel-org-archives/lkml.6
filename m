Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752480AbeCETD6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 14:03:58 -0500
Received: from mga14.intel.com ([192.55.52.115]:16961 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751838AbeCETD4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 14:03:56 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,428,1515484800";
   d="scan'208";a="32574101"
Subject: Re: [RFC, PATCH 18/22] x86/mm: Handle allocation of encrypted pages
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <20180305162610.37510-1-kirill.shutemov@linux.intel.com>
 <20180305162610.37510-19-kirill.shutemov@linux.intel.com>
Cc: Kai Huang <kai.huang@linux.intel.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <e2fed2a7-88db-96f0-56f5-b20b624eb665@intel.com>
Date: Mon, 5 Mar 2018 11:03:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180305162610.37510-19-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05/2018 08:26 AM, Kirill A. Shutemov wrote:
> -#define __alloc_zeroed_user_highpage(movableflags, vma, vaddr) \
> -	alloc_page_vma(GFP_HIGHUSER | __GFP_ZERO | movableflags, vma, vaddr)
>  #define __HAVE_ARCH_ALLOC_ZEROED_USER_HIGHPAGE
> +#define __alloc_zeroed_user_highpage(movableflags, vma, vaddr)			\
> +({										\
> +	struct page *page;							\
> +	gfp_t gfp = movableflags | GFP_HIGHUSER;				\
> +	if (vma_is_encrypted(vma))						\
> +		page = __alloc_zeroed_encrypted_user_highpage(gfp, vma, vaddr);	\
> +	else									\
> +		page = alloc_page_vma(gfp | __GFP_ZERO, vma, vaddr);		\
> +	page;									\
> +})

This is pretty darn ugly and also adds a big old branch into the hottest
path in the page allocator.

It's also really odd that you strip __GFP_ZERO and then go ahead and
zero the encrypted page unconditionally.  It really makes me wonder if
this is the right spot to be doing this.

Can we not, for instance do it inside alloc_page_vma()?
