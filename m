Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752630AbeCETHS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 14:07:18 -0500
Received: from mga14.intel.com ([192.55.52.115]:17179 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751462AbeCETHR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 14:07:17 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,428,1515484800";
   d="scan'208";a="32575151"
Subject: Re: [RFC, PATCH 19/22] x86/mm: Implement free_encrypt_page()
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <20180305162610.37510-1-kirill.shutemov@linux.intel.com>
 <20180305162610.37510-20-kirill.shutemov@linux.intel.com>
Cc: Kai Huang <kai.huang@linux.intel.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <a692b2ff-b590-b731-ad14-18238f471a1c@intel.com>
Date: Mon, 5 Mar 2018 11:07:16 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180305162610.37510-20-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05/2018 08:26 AM, Kirill A. Shutemov wrote:
> +void free_encrypt_page(struct page *page, int keyid, unsigned int order)
> +{
> +	int i;
> +	void *v;
> +
> +	for (i = 0; i < (1 << order); i++) {
> +		v = kmap_atomic_keyid(page, keyid + i);
> +		/* See comment in prep_encrypt_page() */
> +		clflush_cache_range(v, PAGE_SIZE);
> +		kunmap_atomic(v);
> +	}
> +}

Have you measured how slow this is?

It's an optimization, but can we find a way to only do this dance when
we *actually* change the keyid?  Right now, we're doing mapping at alloc
and free, clflushing at free and zeroing at alloc.  Let's say somebody does:

	ptr = malloc(PAGE_SIZE);
	*ptr = foo;
	free(ptr);

	ptr = malloc(PAGE_SIZE);
	*ptr = bar;
	free(ptr);

And let's say ptr is in encrypted memory and that we actually munmap()
at free().  We can theoretically skip the clflush, right?
