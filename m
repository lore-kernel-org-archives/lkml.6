Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752309AbeDDQDw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 12:03:52 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:40408 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752049AbeDDQDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 12:03:49 -0400
X-Google-Smtp-Source: AIpwx4+WdZGfj6cuORpc9k1aTN5iUMXImLu5tXorzAP4/reygyhXdpVAjBM+qQuUb9BxJPF77+VLJrhiWqfS3xKS/hA=
MIME-Version: 1.0
In-Reply-To: <20180404120002.6561a5bc@gandalf.local.home>
References: <20180404115310.6c69e7b9@gandalf.local.home> <20180404120002.6561a5bc@gandalf.local.home>
From: Joel Fernandes <joelaf@google.com>
Date: Wed, 4 Apr 2018 09:03:47 -0700
Message-ID: <CAJWu+orC-1JDYHDTQU+DFckGq5ZnXBCCq9wLG-gNK0Nc4-vo7w@mail.gmail.com>
Subject: Re: [PATCH] ring-buffer: Add set/clear_current_oom_origin() during allocations
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@kernel.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, kernel-patch-test@lists.linaro.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 4, 2018 at 9:00 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Wed, 4 Apr 2018 11:53:10 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
>> @@ -1162,35 +1163,60 @@ static int rb_check_pages(struct ring_buffer_per_cpu *cpu_buffer)
>>  static int __rb_allocate_pages(long nr_pages, struct list_head *pages, int cpu)
>>  {
>>       struct buffer_page *bpage, *tmp;
>> +     bool user_thread = current->mm != NULL;
>> +     gfp_t mflags;
>>       long i;
>>
>> -     /* Check if the available memory is there first */
>> +     /*
>> +      * Check if the available memory is there first.
>> +      * Note, si_mem_available() only gives us a rough estimate of available
>> +      * memory. It may not be accurate. But we don't care, we just want
>> +      * to prevent doing any allocation when it is obvious that it is
>> +      * not going to succeed.
>> +      */
>
> In case you are wondering how I tested this, I simply added:
>
> #if 0
>>       i = si_mem_available();
>>       if (i < nr_pages)
>>               return -ENOMEM;
> #endif
>
> for the tests. Note, without this, I tried to allocate all memory
> (bisecting it with allocations that failed and allocations that
> succeeded), and couldn't trigger an OOM :-/

I guess you need to have something *else* other than the write to
buffer_size_kb doing the GFP_KERNEL allocations but unfortunately gets
OOM killed?

Also, I agree with the new patch and its nice idea to do that.

thanks,

- Joel
