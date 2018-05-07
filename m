Return-Path: <rdunlap@infradead.org>
X-Google-Smtp-Source: AB8JxZraJ2+Ko2sUXhYmggwvlQfQNZ8sb+SSwwf6+++ZahwkEadDhjn39YgM/7y1IkNrWfO4w5LZ
ARC-Seal: i=1; a=rsa-sha256; t=1525711680; cv=none;
        d=google.com; s=arc-20160816;
        b=m/LCGRNMjhbldd15WVZkNYVAc/UzFKxV1eoI25Ouw76drVAzwusDXpcdyjvP2H+PKh
         YtxRsTQFBEJfh6ZM0Nh9bw61utOCkVExHAO1LRfyVNurnIsvvyvsXrz/BEHl1Q3IsJsm
         /oXpTYVnKSmeXQafEhWjZIdJcip4mi7BO86OqswuUUtlt8KC8hR5krisr74VmNWjNIIG
         azM0seZJJa9jWpn7BF20FHx/YItZm6pj1cn+ZbASqM/MM34NsUZMfi1/c6/XqX8mEdN0
         HOYEwVe5QXu9S6wjRtForrobjR86V079si52NaFEckSRI8W/B2EKZAiV0tkxuWckTYEX
         S9yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:subject:from
         :dkim-signature:arc-authentication-results;
        bh=z0JCt6cXKNg3toirhEzAuwu6xoejvbYzxDqYNIzqox4=;
        b=Ew8GPOFQbNHCpIFMkKhQiXO//64f2CH+Lrl68jzCV10hg9czW6pG8qCiVDu7+wJKiM
         G/C1O1ZVefl5DEWnWNQLvv1a3N2HeNQJ/5c79jb/tGWHRAYWRMkSrIGUHraaZBQx796t
         zAJHdOtkojFNKgjRlwt/UTUBW4lwEyrpkNtREXytJTl1b7zmLOvG8g8kusoIyJVV8rlh
         BXoc2e41lylgrpYP6nvQ9QSrhaduCjrAzmB2ATlnwBM8p9iPYYoIr7xDAd4RprDfbxTR
         sY8frb/KOCKvpio1uRGhYcfQNcCdHh43caoGQvIC5PxpeaSlvqfR2E9n0EOWC2TYADdY
         NblA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=msBBMT42;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2001:8b0:10b:1231::1 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=msBBMT42;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2001:8b0:10b:1231::1 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
From: Randy Dunlap <rdunlap@infradead.org>
Subject: linux-next: build warning after merge of the akpm-current tree
To: Minchan Kim <minchan@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linux-Next Mailing List <linux-next@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
References: <20180504141756.670dc3f3@canb.auug.org.au>
 <4fb39549-8902-950d-3076-82a11b1c5102@infradead.org>
 <20180507141039.GA1934@rodete-desktop-imager.corp.google.com>
Message-ID: <f7c0ebfe-1986-6ce5-8641-5503ea6a05fb@infradead.org>
Date: Mon, 7 May 2018 09:47:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180507141039.GA1934@rodete-desktop-imager.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599505695773381278?=
X-GMAIL-MSGID: =?utf-8?q?1599824651322702578?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/07/2018 07:10 AM, Minchan Kim wrote:
> On Fri, May 04, 2018 at 08:39:43AM -0700, Randy Dunlap wrote:
>> On 05/03/2018 09:17 PM, Stephen Rothwell wrote:
>>> Hi Andrew,
>>>
>>> After merging the akpm-current tree, today's linux-next build
>>> (x86_64_allmodconfig) produced this warning:
>>>
>>> drivers/block/zram/zram_drv.c: In function 'read_block_state':
>>> drivers/block/zram/zram_drv.c:674:16: warning: format '%llu' expects argument of type 'long long unsigned int', but argument 5 has type '__kernel_time_t {aka long int}' [-Wformat=]
>>>     "%12lu %12llu.%06lu %c%c%c\n",
>>>            ~~~~~^
>>>            %12lu
>>>     (unsigned long)index, ts.tv_sec,
>>>                           ~~~~~~~~~
>>>
>>> Introduced by commit
>>>
>>>   827c7dbda8eb ("zram-introduce-zram-memory-tracking-update-fix-fix")
>>>
>>
>> typedef __s64 time64_t;
>>
>> struct timespec64 {
>> 	time64_t	tv_sec;			/* seconds */
>> 	long		tv_nsec;		/* nanoseconds */
>> };
>>
>> time64_t is signed. Also, %lu on i386 et al is for 32-bit longs.
>> I guess that "we" will need to cast ts.tv_sec to (s64) and use %lld to print it
>> in order to satisfy other $arch.
>>
>> Andrew, want to add a fix-fix-fix patch?
> 
> Thanks for the fix during I am absent, Andrew and Randy.
> Here goes fix.
> Andrew please fold this patchset.
> 
> From 16569c7abb641930b4e4ec66b4dc2005e6c87be8 Mon Sep 17 00:00:00 2001
> From: Minchan Kim <minchan@kernel.org>
> Date: Mon, 7 May 2018 23:00:16 +0900
> Subject: [PATCH] zram-introduce-zram-memory-tracking-update-fix-fix-fix
> 
> fix compile warning
> 
> drivers/block/zram/zram_drv.c: In function 'read_block_state':
> drivers/block/zram/zram_drv.c:674:16: warning: format '%llu' expects argument of type 'long long unsigned int', but argument 5 has type '__kernel_time_t {aka long int}' [-Wformat=]
>     "%12lu %12llu.%06lu %c%c%c\n",
>            ~~~~~^
>            %12lu
>     (unsigned long)index, ts.tv_sec,
>                           ~~~~~~~~~
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Minchan Kim <minchan@kernel.org>
> ---
>  drivers/block/zram/zram_drv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index f2f3104b2b48..635307e3238b 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -671,8 +671,8 @@ static ssize_t read_block_state(struct file *file, char __user *buf,
>  
>  		ts = ktime_to_timespec64(zram->table[index].ac_time);
>  		copied = snprintf(kbuf + written, count,
> -			"%12lu %12llu.%06lu %c%c%c\n",
> -			(unsigned long)index, ts.tv_sec,
> +			"%12lu %12lld.%06ld %c%c%c\n",
> +			(unsigned long)index, (s64)ts.tv_sec,
>  			ts.tv_nsec / NSEC_PER_USEC,
>  			zram_test_flag(zram, index, ZRAM_SAME) ? 's' : '.',
>  			zram_test_flag(zram, index, ZRAM_WB) ? 'w' : '.',
> 

	ssize_t index,

	so why not print it with %zd (or %12zd) and skip the cast?

-- 
~Randy
