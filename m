Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751398AbeEEOm2 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 10:42:28 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33639 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751086AbeEEOm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 10:42:27 -0400
X-Google-Smtp-Source: AB8JxZqLJZAQGd2LXjxOqycOX3O5D4f3zdtIBih7YPIrdrXGHYl2c3gDS5tKpogpB2/bcsdKiehMaw==
Subject: Re: [PATCH] percpu_ida: Use _irqsave() instead of local_irq_save() +
 spin_lock
From: Jens Axboe <axboe@kernel.dk>
To: Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Nicholas Bellinger <nab@linux-iscsi.org>, Shaohua Li <shli@fb.com>,
        Kent Overstreet <kent.overstreet@gmail.com>
References: <20180504153218.7301-1-bigeasy@linutronix.de>
 <20180504162216.ae91654b68eddafe38df7d7f@linux-foundation.org>
 <20180505035154.GB20495@bombadil.infradead.org>
 <60a88d5f-95eb-ba45-e59c-5a822a3d370b@kernel.dk>
Message-ID: <2d5aeec5-80dd-b7ee-ef40-ff3916c5ba04@kernel.dk>
Date: Sat, 5 May 2018 08:42:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <60a88d5f-95eb-ba45-e59c-5a822a3d370b@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/5/18 8:10 AM, Jens Axboe wrote:
> On 5/4/18 9:51 PM, Matthew Wilcox wrote:
>> On Fri, May 04, 2018 at 04:22:16PM -0700, Andrew Morton wrote:
>>> I'm feeling a bit hostile toward lib/percpu_ida.c in general ;) It has
>>> very few users and seems rather complicated (what's with that
>>> schedule() in percpu_ida_alloc?).  I'm suspecting and hoping that if
>>> someone can figure out what the requirements were, this could all be
>>> zapped and reimplemented using something else which we already have.
>>
>> Note that I have no code in percpu_ida ... it's quite different from
>> the regular IDA.  But I have noticed the stunning similarity between the
>> percpu_ida and the code in lib/sbitmap.c.  I have no idea which one is
>> better, but they're essentially doing the same thing.
> 
> Not sure where you see that "stunning similarity"? The sbitmap code is
> basically the blk-mq tagging sparse bitmaps, abstracted into a generally
> usable form. The percpu_ida design works fine for lower utilization, but
> it fell apart for the tagging use case where we can easily run at full
> utilization. percpu_ida has percpu caches, sbitmap gets away with just
> percpu hints. These caches are why it doesn't work well for > 50%
> utilization. sbitmap also supports shallow operations, and online
> resizing. Outside of the sharing the same basic functionality of "give
> me some free ID", I really don't see a lot of similarities. In terms of
> functionality, yes, I don't think it would be hard to get rid of
> percpu_ida and just replace it with sbitmap. Probably a worthwhile
> pursuit.

Looks like it's just the target code using it. I'll spin a patch
to convert it to sbitmap.

-- 
Jens Axboe
