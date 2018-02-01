Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932149AbeBABDD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 20:03:03 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:56385 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754559AbeBABDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 20:03:00 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04452;MF=zhang.jia@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0SxSki19_1517446964;
Subject: Re: [PATCH 1/2] /proc/kcore: Fix SMAP violation when dumping vsyscall
 user page
To: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com
Cc: x86@kernel.org, linux-kernel@vger.kernel.org
References: <1517294579-117473-1-git-send-email-zhang.jia@linux.alibaba.com>
From: Jia Zhang <zhang.jia@linux.alibaba.com>
Message-ID: <2166a2cd-be40-ff3f-409d-7f32af4a7a10@linux.alibaba.com>
Date: Thu, 1 Feb 2018 09:03:11 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1517294579-117473-1-git-send-email-zhang.jia@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Are there any comments here?

Thanks,
Jia

On 2018/1/30 下午2:42, Jia Zhang wrote:
> The commit df04abfd181a
> ("fs/proc/kcore.c: Add bounce buffer for ktext data") introduces a
> bounce buffer to work around CONFIG_HARDENED_USERCOPY=y. However,
> accessing vsyscall user page will cause SMAP violation in this way.
> 
> In order to fix this issue, simply replace memcpy() with copy_from_user()
> may work, but using a common way to handle this sort of user page may be
> useful for future.
> 
> Currently, only vsyscall page requires KCORE_USER.
> 
> Signed-off-by: Jia Zhang <zhang.jia@linux.alibaba.com>
> ---
>  arch/x86/mm/init_64.c | 2 +-
>  fs/proc/kcore.c       | 4 ++++
>  include/linux/kcore.h | 1 +
>  3 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> index 4a83728..dab78f6 100644
> --- a/arch/x86/mm/init_64.c
> +++ b/arch/x86/mm/init_64.c
> @@ -1187,7 +1187,7 @@ void __init mem_init(void)
>  
>  	/* Register memory areas for /proc/kcore */
>  	kclist_add(&kcore_vsyscall, (void *)VSYSCALL_ADDR,
> -			 PAGE_SIZE, KCORE_OTHER);
> +		   PAGE_SIZE, KCORE_USER);
>  
>  	mem_init_print_info(NULL);
>  }
> diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
> index 4bc85cb..e4b0204 100644
> --- a/fs/proc/kcore.c
> +++ b/fs/proc/kcore.c
> @@ -510,6 +510,10 @@ static void elf_kcore_store_hdr(char *bufp, int nphdr, int dataoff)
>  			/* we have to zero-fill user buffer even if no read */
>  			if (copy_to_user(buffer, buf, tsz))
>  				return -EFAULT;
> +		} else if (m->type == KCORE_USER) {
> +			/* user page is handled prior to normal kernel page */
> +			if (copy_to_user(buffer, (char *)start, tsz))
> +				return -EFAULT;
>  		} else {
>  			if (kern_addr_valid(start)) {
>  				unsigned long n;
> diff --git a/include/linux/kcore.h b/include/linux/kcore.h
> index 7ff25a8..80db19d 100644
> --- a/include/linux/kcore.h
> +++ b/include/linux/kcore.h
> @@ -10,6 +10,7 @@ enum kcore_type {
>  	KCORE_VMALLOC,
>  	KCORE_RAM,
>  	KCORE_VMEMMAP,
> +	KCORE_USER,
>  	KCORE_OTHER,
>  };
>  
> 
