Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752457AbeEGQjS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 12:39:18 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:50563 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751953AbeEGQjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 12:39:16 -0400
X-Google-Smtp-Source: AB8JxZpRBI1eG7DVoPj0W7ksyvb0Gl/qdA4RcjIS3lN/3JRqenXe5gyA2Rw+Es0rx5HqD0pqEYjrRw==
Subject: Re: bug in tag handling in blk-mq?
To: Paolo Valente <paolo.valente@linaro.org>,
        Mike Galbraith <efault@gmx.de>, Christoph Hellwig <hch@lst.de>
Cc: linux-block <linux-block@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>
References: <999DF2B3-4EE8-4BDF-89C5-EB0C2D8BF69E@linaro.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <7760d23b-7a4c-a645-1c7a-da7569bb44dc@kernel.dk>
Date: Mon, 7 May 2018 10:39:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <999DF2B3-4EE8-4BDF-89C5-EB0C2D8BF69E@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/7/18 8:03 AM, Paolo Valente wrote:
> Hi Jens, Christoph, all,
> Mike Galbraith has been experiencing hangs, on blk_mq_get_tag, only
> with bfq [1].  Symptoms seem to clearly point to a problem in I/O-tag
> handling, triggered by bfq because it limits the number of tags for
> async and sync write requests (in bfq_limit_depth).
> 
> Fortunately, I just happened to find a way to apparently confirm it.
> With the following one-liner for block/bfq-iosched.c:
> 
> @@ -554,8 +554,7 @@ static void bfq_limit_depth(unsigned int op, struct blk_mq_alloc_data *data)
>         if (unlikely(bfqd->sb_shift != bt->sb.shift))
>                 bfq_update_depths(bfqd, bt);
>  
> -       data->shallow_depth =
> -               bfqd->word_depths[!!bfqd->wr_busy_queues][op_is_sync(op)];
> +       data->shallow_depth = 1;
>  
>         bfq_log(bfqd, "[%s] wr_busy %d sync %d depth %u",
>                         __func__, bfqd->wr_busy_queues, op_is_sync(op),
> 
> Mike's machine now crashes soon and systematically, while nothing bad
> happens on my machines, even with heavy workloads (apart from an
> expected throughput drop).
> 
> This change simply reduces to 1 the maximum possible value for the sum
> of the number of async requests and of sync write requests.
> 
> This email is basically a request for help to knowledgeable people.  To
> start, here are my first doubts/questions:
> 1) Just to be certain, I guess it is not normal that blk-mq hangs if
> async requests and sync write requests can be at most one, right?
> 2) Do you have any hint to where I could look for, to chase this bug?
> Of course, the bug may be in bfq, i.e, it may be a somehow unrelated
> bfq bug that causes this hang in blk-mq, indirectly.  But it is hard
> for me to understand how.

CC Omar, since he implemented the shallow part. But we'll need some
traces to show where we are hung, probably also the value of the
/sys/debug/kernel/block/<dev>/ directory. For the crash mentioned, a
trace as well. Otherwise we'll be wasting a lot of time on this.

Is there a reproducer?

-- 
Jens Axboe
