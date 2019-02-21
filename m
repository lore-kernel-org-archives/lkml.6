Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B9B6C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 01:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9AFE2086D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 01:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="NTBxFLX5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfBUB6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 20:58:46 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41016 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfBUB6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 20:58:45 -0500
Received: by mail-qk1-f195.google.com with SMTP id y15so1909474qki.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 17:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SNMyx3mvyEhumH87qacwojMOgIg98VYddiiEUf2zBNE=;
        b=NTBxFLX54Jn7ha8lCrCA3BheJXv+WNR8+OH7uJxY9EhKMfBmTmbsoe7IZmi8E6WW8F
         UT4G5hX8+DwG/9EgN0iICC+cCYpHnzbjwC3uL/Z8BH7jUZBB19cCSFNhRHW6DONg4I6S
         aS0LVN2zgZ0YozT9v4xbVmiU819eWcKd2iuaxfKYwFRzZIBAFpQ7CGsWDHIy4Z6vGjSG
         tSvqRnOzuoCVyUmJ/FH4oA2rv88o+e6xFtv9fRb/Z5HAKTqvEcuURdu77IcMBhabfQxN
         1lZDBelOExgawckUYHLW7WS/4rT5k2mOxr76RpRhgLnZDef2ehQLHZPpZsfcyTH5K2ix
         uu8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SNMyx3mvyEhumH87qacwojMOgIg98VYddiiEUf2zBNE=;
        b=b7LvmF9zDh0AVuNy9AGYxfQCoL/gEohp9XyHigYRpd0GubKYYWd7RHtNBsny5AcdjZ
         8pURut73jDhMI1i3TpSkAxLkWNhlV9y2n6mRyoLZbkFL9/QtlJMMlyjZ9689TpfrJzI+
         qPjtD+c0XsWmedmY4z1S8OYF8DqOD+VPppxSqaZjEXWTbRViIQVT13EVjfTMoVEtNxFW
         ht/zh6kAmhDcttojxoMRrHfoDSk41L+XDj33lWf+6qPdRItFCsrbs9nQJPrkTvfmHag1
         3QEIPjVUJrLEcc8UsTgsxRdPS/A0Dx63wbsvd45Yx/8J5l/3Fm4kFNwaQICpc3m97KIO
         UEWA==
X-Gm-Message-State: AHQUAuZkEt+XP1xSXS0jX2GYwEH8lXDCKhJhm2zQn/NvdioPy20cR+7T
        yS8qC6HDNzt5QYgvhqEETBnFe7if68s=
X-Google-Smtp-Source: AHgI3IaLeqr5GDP9UozyfNZgGbyilkHrQUQOpmLrsV6q4ZPweAJHmgyumamCgnJ1wwj2aQQ7o4RAaw==
X-Received: by 2002:ae9:e702:: with SMTP id m2mr18772286qka.279.1550714324094;
        Wed, 20 Feb 2019 17:58:44 -0800 (PST)
Received: from ovpn-120-150.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id s21sm14198665qki.94.2019.02.20.17.58.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 17:58:43 -0800 (PST)
Subject: Re: [PATCH -next] mm/debug: use lx% for atomic64_read() on ppc64le
To:     akpm@linux-foundation.org
Cc:     dave@stgolabs.net, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20190221010819.92039-1-cai@lca.pw>
From:   Qian Cai <cai@lca.pw>
Message-ID: <6c48d33a-083c-68bf-f94d-3d901453a198@lca.pw>
Date:   Wed, 20 Feb 2019 20:58:42 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190221010819.92039-1-cai@lca.pw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please ignore this patch.

On 2/20/19 8:08 PM, Qian Cai wrote:
> atomic64_read() on ppc64le returns "long int" while "long long" seems on
> all other arches, so deal the special case for ppc64le.
> 
> In file included from ./include/linux/printk.h:7,
>                  from ./include/linux/kernel.h:15,
>                  from mm/debug.c:9:
> mm/debug.c: In function 'dump_mm':
> ./include/linux/kern_levels.h:5:18: warning: format '%llx' expects
> argument of type 'long long unsigned int', but argument 19 has type
> 'long int' [-Wformat=]
>  #define KERN_SOH "\001"  /* ASCII Start Of Header */
>                   ^~~~~~
> ./include/linux/kern_levels.h:8:20: note: in expansion of macro
> 'KERN_SOH'
>  #define KERN_EMERG KERN_SOH "0" /* system is unusable */
>                     ^~~~~~~~
> ./include/linux/printk.h:297:9: note: in expansion of macro 'KERN_EMERG'
>   printk(KERN_EMERG pr_fmt(fmt), ##__VA_ARGS__)
>          ^~~~~~~~~~
> mm/debug.c:133:2: note: in expansion of macro 'pr_emerg'
>   pr_emerg("mm %px mmap %px seqnum %llu task_size %lu\n"
>   ^~~~~~~~
> mm/debug.c:140:17: note: format string is defined here
>    "pinned_vm %llx data_vm %lx exec_vm %lx stack_vm %lx\n"
>               ~~~^
>               %lx
> 
> Fixes: 70f8a3ca68d3 ("mm: make mm->pinned_vm an atomic64 counter")
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  mm/debug.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/debug.c b/mm/debug.c
> index c0b31b6c3877..e4ec3d68833e 100644
> --- a/mm/debug.c
> +++ b/mm/debug.c
> @@ -137,7 +137,12 @@ void dump_mm(const struct mm_struct *mm)
>  		"mmap_base %lu mmap_legacy_base %lu highest_vm_end %lu\n"
>  		"pgd %px mm_users %d mm_count %d pgtables_bytes %lu map_count %d\n"
>  		"hiwater_rss %lx hiwater_vm %lx total_vm %lx locked_vm %lx\n"
> -		"pinned_vm %llx data_vm %lx exec_vm %lx stack_vm %lx\n"
> +#ifdef __powerpc64__
> +		"pinned_vm %lx "
> +#else
> +		"pinned_vm %llx "
> +#endif
> +		"data_vm %lx exec_vm %lx stack_vm %lx\n"
>  		"start_code %lx end_code %lx start_data %lx end_data %lx\n"
>  		"start_brk %lx brk %lx start_stack %lx\n"
>  		"arg_start %lx arg_end %lx env_start %lx env_end %lx\n"
> 
