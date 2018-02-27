Return-Path: <mhocko@kernel.org>
X-Google-Smtp-Source: AH8x226BIyqy1lfTj6O4rKwpt9A4h/QtksOQKNkKws44kqqDXXzsh7L+zzJdawFrGgZa4dGdPtt4
ARC-Seal: i=1; a=rsa-sha256; t=1519721850; cv=none;
        d=google.com; s=arc-20160816;
        b=rTc7IPNCQXyKrrh6yinBJIeOPXxiYSvPvo5ryQnoMScdA+9ZfF7R1OpOygU1uyV/wF
         IAjuGVUO8at8oEqxzqXHKZzwVC2nBaEbd/L3xqI0aZspN2D3d8DtdgGoznS3MUk/ye0X
         +GTZz20xMQYk+ALoGuL675VQfUAZD5rCOsXiSuBiddZYb4LzhqC4JomLVn8BDMc6gsbW
         NcTiPWQ+sKVIGL5qJeCGYnUOLkpn/M7kX90ggSjYHVue3llNCtXGh7WG6CsXIBSMCoYu
         KQ5GAPvMSXH7usAi/KIwK/8ZdnfWJPqnviaKtdaePxalCWxldIV2wzH7PJL41oBWPvYq
         l6ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=2+/7LowXRF9jcurzYLnBsEzcKIvVGzAZHz7mV7zCWI0=;
        b=leBc6QLJH1zaXlN6OLHxnRNZKVtsjKpkv4Trlr/aItqFAwyHyEik5zSyel3p6KmCko
         lPyJi6q8wbcnXh0/Q1q/k3kmjXIgHmYU+ZeTBQCYA7sgjiWk2HveCEAY5TbOxJR0pkt+
         vzMIwhB+ytT9/zFfOIyrzRSjO0Wc9DEs+1R92gsNu21abvKJCHMdQGzJOc1EcP223ynP
         334vivdMm7tDf9WUSFqHYlg3FWeIncSS1mstUGVzBN4eW0NqXbtRfWylqyYpzIAslMUV
         OFhZnF17Jcumt5pyyORDhNh6ac46D1koSfKjIMice6dqZERaMm9F3OXE66/bhvqhV9n1
         QNRA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 195.135.220.15 is neither permitted nor denied by best guess record for domain of mhocko@kernel.org) smtp.mailfrom=mhocko@kernel.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 195.135.220.15 is neither permitted nor denied by best guess record for domain of mhocko@kernel.org) smtp.mailfrom=mhocko@kernel.org
Date: Tue, 27 Feb 2018 09:57:27 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Ilya Smith <blackzert@gmail.com>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
	kirill.shutemov@linux.intel.com, dsafonov@virtuozzo.com,
	hughd@google.com, gregkh@linuxfoundation.org, craigb@google.com,
	oleg@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] Take mmap_min_addr into account while choosing
 unmapped address for x86-64.
Message-ID: <20180227085726.GC15357@dhcp22.suse.cz>
References: <20180226211257.63067-1-blackzert@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180226211257.63067-1-blackzert@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593499619093217840?=
X-GMAIL-MSGID: =?utf-8?q?1593543859366419546?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue 27-02-18 00:12:57, Ilya Smith wrote:
[...]
> diff --git a/arch/x86/kernel/sys_x86_64.c b/arch/x86/kernel/sys_x86_64.c
> index 676774b9bb8d..1752fe5cb735 100644
> --- a/arch/x86/kernel/sys_x86_64.c
> +++ b/arch/x86/kernel/sys_x86_64.c
> @@ -17,6 +17,7 @@
>  #include <linux/random.h>
>  #include <linux/uaccess.h>
>  #include <linux/elf.h>
> +#include <linux/security.h>
>  
>  #include <asm/elf.h>
>  #include <asm/compat.h>
> @@ -185,7 +186,7 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
>  		return addr;
>  
>  	/* requested length too big for entire address space */
> -	if (len > TASK_SIZE)
> +	if (len > TASK_SIZE - mmap_min_addr)
>  		return -ENOMEM;
>  
>  	/* No address checking. See comment at mmap_address_hint_valid() */
> @@ -210,7 +211,7 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
>  
>  	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
>  	info.length = len;
> -	info.low_limit = PAGE_SIZE;
> +	info.low_limit = max(PAGE_SIZE, mmap_min_addr);
>  	info.high_limit = get_mmap_base(0);
>  
>  	/*

mmap_min_addr handling is a bit mess... As you say, we would return
EPERM rather than ENOMEM which can be confusing but depleting the
address space like that is quite unlikely on 64b unless I am missing.
It is good to be in sync here with the generic implementation though,
IMO.

> diff --git a/arch/x86/mm/mmap.c b/arch/x86/mm/mmap.c
> index 155ecbac9e28..b6d0c317639e 100644
> --- a/arch/x86/mm/mmap.c
> +++ b/arch/x86/mm/mmap.c
> @@ -31,6 +31,7 @@
>  #include <linux/sched/signal.h>
>  #include <linux/sched/mm.h>
>  #include <linux/compat.h>
> +#include <linux/security.h>
>  #include <asm/elf.h>
>  
>  #include "physaddr.h"
> @@ -220,6 +221,9 @@ bool mmap_address_hint_valid(unsigned long addr, unsigned long len)
>  	if (TASK_SIZE - len < addr)
>  		return false;
>  
> +	if (addr < mmap_min_addr)
> +		return false;
> +
>  	return (addr > DEFAULT_MAP_WINDOW) == (addr + len > DEFAULT_MAP_WINDOW);

But is this one necessary? We do sanitze hint address before going to
get_unmapped_address AFAIR.

-- 
Michal Hocko
SUSE Labs
