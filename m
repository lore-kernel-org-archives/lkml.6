Return-Path: <catalin.marinas@arm.com>
X-Google-Smtp-Source: AB8JxZrDshIY4VSYL9KnteseqiQpLawk17fz97VSZTZJ7bw7BYwv5wofVaA+hA9GXafOuIiCrrKe
ARC-Seal: i=1; a=rsa-sha256; t=1524764842; cv=none;
        d=google.com; s=arc-20160816;
        b=S7M2o4NzTvrh0xtFu5A8eklTFivSQ2z3uaMQeuQj3gspD7WpYdAqEMSNX+XZxC3oFm
         gzYNHz3Yiv3nfLR6VX+f5+8AJWlbq6IwEhmDF5q7mgMVh3t4gSMKN7aYKK6a5ryeQjwi
         9gvAvKHN8CNAkn4kbWRtNyOMhxswcdKFfBZtQTTFLXotVoDwcUSqWKppTHLB3Ww1Zui9
         knNNaVgTcJk3Og/7YXEitwjSNxcLE1/kb4S7jPOl2QVMZBWOEZFygQcJkZoY74ZvjuKQ
         pBYMrRMP3AQ4g6RMKMfAxMRm/Faq8XiCFrX/HPKvMg+EZyYrGvjT6yNIS7VsHT/QqN9a
         jaCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=kR9L8vUmJEltXXEoYK8pz4bAQkI3SyZWXTvV9RKF0TI=;
        b=V/PkGdK5sK2u+YVMujNSMqX1UZ/N6YIrL77rEVtQQjzTG/VJ6ZSD3SEZc7NeKiRjnC
         iYRQcbUXEJ0EpsFI3lyzyvgmm6DIEgo8IA23mbTpGIa/KMMCHDe5EPFZ8GrbOhrwp+NT
         nGJWkqDAGaU0xaJgIrTbHa5qsQ3OLEKe8PJ/owpgYogb4B6IKmBt8u+zDw44R/qdr6E8
         oWEo2aaxrroTS00g64ZBZ/A5WTJbCHy2LjJi1XgJuPNg6rtgaKHK3cGvOPXYENOpRYnB
         tbpxHziHFOG2T3VXcQljJPezsNz8R1f6umW+AKQk8VhZYvW2pJ5jqG6IFyTuzQ2QMv5e
         KFQQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of catalin.marinas@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=catalin.marinas@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of catalin.marinas@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=catalin.marinas@arm.com
Date: Thu, 26 Apr 2018 18:47:14 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Andrey Konovalov <andreyknvl@google.com>
Cc: Will Deacon <will.deacon@arm.com>, Jonathan Corbet <corbet@lwn.net>,
	Mark Rutland <mark.rutland@arm.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	James Morse <james.morse@arm.com>,
	Kees Cook <keescook@chromium.org>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ingo Molnar <mingo@kernel.org>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
	Zi Yan <zi.yan@cs.rutgers.edu>,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Jacob Bramley <Jacob.Bramley@arm.com>,
	Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
	Lee Smith <Lee.Smith@arm.com>, Kostya Serebryany <kcc@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
	Evgeniy Stepanov <eugenis@google.com>
Subject: Re: [PATCH 4/6] mm, arm64: untag user addresses in mm/gup.c
Message-ID: <20180426174714.4jtb72q56w3xonsa@armageddon.cambridge.arm.com>
References: <cover.1524077494.git.andreyknvl@google.com>
 <0db34d04fa16be162336106e3b4a94f3dacc0af4.1524077494.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0db34d04fa16be162336106e3b4a94f3dacc0af4.1524077494.git.andreyknvl@google.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598111199483906995?=
X-GMAIL-MSGID: =?utf-8?q?1598831819900614657?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 18, 2018 at 08:53:13PM +0200, Andrey Konovalov wrote:
> diff --git a/mm/gup.c b/mm/gup.c
> index 76af4cfeaf68..fb375de7d40d 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -386,6 +386,8 @@ struct page *follow_page_mask(struct vm_area_struct *vma,
>  	struct page *page;
>  	struct mm_struct *mm = vma->vm_mm;
>  
> +	address = untagged_addr(address);
> +
>  	*page_mask = 0;
>  
>  	/* make this handle hugepd */

Does having a tagged address here makes any difference? I couldn't hit a
failure with my simple tests (LD_PRELOAD a library that randomly adds
tags to pointers returned by malloc).

> @@ -647,6 +649,8 @@ static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
>  	if (!nr_pages)
>  		return 0;
>  
> +	start = untagged_addr(start);
> +
>  	VM_BUG_ON(!!pages != !!(gup_flags & FOLL_GET));
>  
>  	/*
> @@ -801,6 +805,8 @@ int fixup_user_fault(struct task_struct *tsk, struct mm_struct *mm,
>  	struct vm_area_struct *vma;
>  	int ret, major = 0;
>  
> +	address = untagged_addr(address);
> +
>  	if (unlocked)
>  		fault_flags |= FAULT_FLAG_ALLOW_RETRY;
>  
> @@ -854,6 +860,8 @@ static __always_inline long __get_user_pages_locked(struct task_struct *tsk,
>  	long ret, pages_done;
>  	bool lock_dropped;
>  
> +	start = untagged_addr(start);
> +
>  	if (locked) {
>  		/* if VM_FAULT_RETRY can be returned, vmas become invalid */
>  		BUG_ON(vmas);

Isn't __get_user_pages() untagging enough to cover this case as well?
Can this function not cope with tagged pointers?

> @@ -1751,6 +1759,8 @@ int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
>  	unsigned long flags;
>  	int nr = 0;
>  
> +	start = untagged_addr(start);
> +
>  	start &= PAGE_MASK;
>  	addr = start;
>  	len = (unsigned long) nr_pages << PAGE_SHIFT;
> @@ -1803,6 +1813,8 @@ int get_user_pages_fast(unsigned long start, int nr_pages, int write,
>  	unsigned long addr, len, end;
>  	int nr = 0, ret = 0;
>  
> +	start = untagged_addr(start);
> +
>  	start &= PAGE_MASK;
>  	addr = start;
>  	len = (unsigned long) nr_pages << PAGE_SHIFT;

Have you hit a problem with the fast gup functions and tagged pointers?
The page table walking macros (e.g. p*d_index()) should mask the tag out
already.

-- 
Catalin
