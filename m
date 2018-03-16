Return-Path: <kirill@shutemov.name>
ARC-Seal: i=1; a=rsa-sha256; t=1521233792; cv=none;
        d=google.com; s=arc-20160816;
        b=uUkhE5nT1Ee8qns6A3ytKK12Q4y/1sI0NvM4GPUhnKRKgJDzuPNJ+klZzY2NYhdwnS
         YGykE4SzNntePd05JP6rvI/+5qdgs/LRS49ruk8LYN/cmVKHygdxICvNVVHOa6RFmu4z
         0p1H99crYSFAor60gTFQ5JhhoFV2nVaURu4yQ0FZPM87c8ib9yPTtF65MaKmg+J/FbqM
         kHP9gYtg0kGWdM0j4/JZy1SOo6VQ1Fasut9lPVOsRNTXD67ptlBk5WoKd3yXNnqF2aNR
         VNp45wotpr36UbHGpaXu/Ky8HC3bQXWV/kvDERK5J7dBRy4u9JSKklw/JMPVOZovvQhL
         8fzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=kZN1OcTiGzDg0YRqf5GTAF73sQvedJqp5QzR3L2aViw=;
        b=0NBK9wX3vq6eg/msgmFUe1VCyXJFCXzHhrJI/kPEHi0wZXEsa2bFrgtC3kGmjcX2lk
         o42mfp4ACF/Ynxt+mKRqXHW0swNXxeTJwEFlp4H1sTD9DO2vyEOthGfH59aHnim7ujtz
         EgOMQypgayBg5dUYaLnbjTGlIKPV0jBRNP0CGsnOy2b+U1qg5F9KzjecMm1aXgII9NIY
         Wt286yeDfopIGVkT5bA20tSFcrzCrzxEy2AhILa0/FFebsY0j7uKwArgrhJyUW2jVg6X
         pqwpHLvvAPQe73hpQeu2fkXeAP8BHz3YjB47nEgkuvk4mIxrZdMOsBCo+ct0PKowprI0
         6e2w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@shutemov-name.20150623.gappssmtp.com header.s=20150623 header.b=DkK7LhrC;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of kirill@shutemov.name) smtp.mailfrom=kirill@shutemov.name
Authentication-Results: mx.google.com;
       dkim=pass header.i=@shutemov-name.20150623.gappssmtp.com header.s=20150623 header.b=DkK7LhrC;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of kirill@shutemov.name) smtp.mailfrom=kirill@shutemov.name
X-Google-Smtp-Source: AG47ELsicSMUOiVylVhtMdAypb8ywUKlA75M+NC6Re9tSpP7yc/tuD2okzBSKX05QXfFc+sfgQUhAA==
Date: Fri, 16 Mar 2018 23:56:07 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Wei Wang <wvw@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: gregkh@linuxfoundation.org, toddpoynor@google.com,
	wei.vince.wang@gmail.com, Andrew Morton <akpm@linux-foundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Michal Hocko <mhocko@suse.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Jan Kara <jack@suse.cz>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	Matthew Wilcox <willy@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Sherry Cheung <SCheung@nvidia.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Andrey Ryabinin <aryabinin@virtuozzo.com>,
	Huang Ying <ying.huang@intel.com>, Dennis Zhou <dennisz@fb.com>,
	Pavel Tatashin <pasha.tatashin@oracle.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: add config for readahead window
Message-ID: <20180316205607.lr6nmrkkzzbw2tqh@node.shutemov.name>
References: <20180316182512.118361-1-wvw@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180316182512.118361-1-wvw@google.com>
User-Agent: NeoMutt/20180223
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595119752476729321?=
X-GMAIL-MSGID: =?utf-8?q?1595129245576083732?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 16, 2018 at 11:25:08AM -0700, Wei Wang wrote:
> From: Wei Wang <wvw@google.com>
> 
> Change VM_MAX_READAHEAD value from the default 128KB to a configurable
> value. This will allow the readahead window to grow to a maximum size
> bigger than 128KB during boot, which could benefit to sequential read
> throughput and thus boot performance.

Increase of readahead window was proposed several times. And rejected.
IIRC, Linus was against it.

What is different this time?

> Signed-off-by: Wei Wang <wvw@google.com>
> ---
>  include/linux/mm.h | 2 +-
>  mm/Kconfig         | 8 ++++++++
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index ad06d42adb1a..d7dc6125833e 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2291,7 +2291,7 @@ int __must_check write_one_page(struct page *page);
>  void task_dirty_inc(struct task_struct *tsk);
>  
>  /* readahead.c */
> -#define VM_MAX_READAHEAD	128	/* kbytes */
> +#define VM_MAX_READAHEAD	CONFIG_VM_MAX_READAHEAD_KB
>  #define VM_MIN_READAHEAD	16	/* kbytes (includes current page) */
>  
>  int force_page_cache_readahead(struct address_space *mapping, struct file *filp,
> diff --git a/mm/Kconfig b/mm/Kconfig
> index c782e8fb7235..da9ff543bdb9 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -760,3 +760,11 @@ config GUP_BENCHMARK
>  	  performance of get_user_pages_fast().
>  
>  	  See tools/testing/selftests/vm/gup_benchmark.c
> +
> +config VM_MAX_READAHEAD_KB
> +	int "Default max readahead window size in Kilobytes"
> +	default 128
> +	help
> +	  This sets the VM_MAX_READAHEAD value to allow the readahead window
> +	  to grow to a maximum size of configured. Increasing this value will
> +	  benefit sequential read throughput.
> -- 
> 2.16.2.804.g6dcf76e118-goog
> 

-- 
 Kirill A. Shutemov
