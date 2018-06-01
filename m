Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751247AbeFABMp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 21:12:45 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:38055 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750776AbeFABMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 21:12:42 -0400
X-Google-Smtp-Source: ADUXVKIYv7GkBwIAYtDs6sOVO3TRN/LTHl9WmZ/LU6LfoVb4sSvJSush1q6Lqh3CCqVhf+9/GglwRA==
Subject: Re: Can kfree() sleep at runtime?
To: Matthew Wilcox <willy@infradead.org>
Cc: cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <30ecafd7-ed61-907b-f924-77fc37dcc753@gmail.com>
 <20180531140808.GA30221@bombadil.infradead.org>
From: Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <4e3c8b44-67cc-29ca-7d59-daf542d2fcf2@gmail.com>
Date: Fri, 1 Jun 2018 09:12:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180531140808.GA30221@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/5/31 22:08, Matthew Wilcox wrote:
> On Thu, May 31, 2018 at 09:10:07PM +0800, Jia-Ju Bai wrote:
>> I write a static analysis tool (DSAC), and it finds that kfree() can sleep.
>>
>> Here is the call path for kfree().
>> Please look at it *from the bottom up*.
>>
>> [FUNC] alloc_pages(GFP_KERNEL)
>> arch/x86/mm/pageattr.c, 756: alloc_pages in split_large_page
>> arch/x86/mm/pageattr.c, 1283: split_large_page in __change_page_attr
> Here's your bug.  Coming from kfree(), we can't end up in the
> split_large_page() path.  __change_page_attr may be called in several
> different circumstances in which it would have to split a large page,
> but the path from kfree() is not one of them.
>
> I think the path from kfree() will lead to the 'level == PG_LEVEL_4K'
> path, but I'm not really familiar with this x86 code.

Thanks for reply :)
But from the code in my call path, I cannot find why kfree() will only lead to the 'level == PG_LEVEL_4K' path.
Could you please explain it in more detail?


Best wishes,
Jia-Ju Bai
  
