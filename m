Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754438AbeDYNmv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 09:42:51 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:39683 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754390AbeDYNmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 09:42:47 -0400
X-Google-Smtp-Source: AIpwx49t8KgifNEHjYF9mDdz9Gpp9/gpoxEG8Z+Sv3Q9N8IW9r8/rS+oBoEqpLOZViqlhA1ZG2DWDw==
Subject: Re: [PATCH net-next 1/2] tcp: add TCP_ZEROCOPY_RECEIVE support for
 zerocopy receive
To: Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>
Cc: netdev <netdev@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>
References: <20180425052722.73022-1-edumazet@google.com>
 <20180425052722.73022-2-edumazet@google.com>
From: Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <111ba92b-ea48-93a8-a86c-0c7ca54eabaa@gmail.com>
Date: Wed, 25 Apr 2018 06:42:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180425052722.73022-2-edumazet@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/24/2018 10:27 PM, Eric Dumazet wrote:
> When adding tcp mmap() implementation, I forgot that socket lock
> had to be taken before current->mm->mmap_sem. syzbot eventually caught
> the bug.
> +

...

  

> +	down_read(&current->mm->mmap_sem);
> +
> +	ret = -EINVAL;
> +	vma = find_vma(current->mm, address);
> +	if (!vma || vma->vm_start > address || vma->vm_ops != &tcp_vm_ops)
>  		goto out;
> -	}
> +	zc->length = min_t(unsigned long, zc->length, vma->vm_end - address);
> +
>  	tp = tcp_sk(sk);
>  	seq = tp->copied_seq;
> -	/* Abort if urgent data is in the area */
> -	if (unlikely(tp->urg_data)) {
> -		u32 urg_offset = tp->urg_seq - seq;
> +	zc->length = min_t(u32, zc->length, tcp_inq(sk));
>  
>

I might have to make sure zc->length is page aligned before calling zap_page_range() ?

zc->length &= ~(PAGE_SIZE - 1);

 +	zap_page_range(vma, address, zc->length);
