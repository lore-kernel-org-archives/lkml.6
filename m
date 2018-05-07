Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752138AbeEGJ1d (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 05:27:33 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:41397 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751830AbeEGJ13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 05:27:29 -0400
X-Google-Smtp-Source: AB8JxZpaGtyjywLRzI6v/v6xGENQH9NMHFm42LJqBjcbcP8denQYcD7wu1s8ZYlKz+33zRUlYxGXkQ==
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH BUGFIX] block, bfq: postpone rq preparation to insert or
 merge
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <1525672597.5064.3.camel@gmx.de>
Date: Mon, 7 May 2018 11:27:25 +0200
Cc: Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, Mark Brown <broonie@kernel.org>,
        linus.walleij@linaro.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name
Message-Id: <1723D46D-579A-4C5A-BCC1-6ABAA6E7C3FB@linaro.org>
References: <20180504171701.6876-1-paolo.valente@linaro.org>
 <1525463210.622.1.camel@gmx.de> <1525508378.5406.6.camel@gmx.de>
 <9F155F9F-F6B2-465A-BA4D-A86FF6825071@linaro.org>
 <1525532191.5406.15.camel@gmx.de>
 <223CABEA-71E0-426F-A4AB-17BA8437C978@linaro.org>
 <1525672597.5064.3.camel@gmx.de>
To: Mike Galbraith <efault@gmx.de>
X-Mailer: Apple Mail (2.3445.6.18)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w479RaZJ008990



> Il giorno 07 mag 2018, alle ore 07:56, Mike Galbraith <efault@gmx.de> ha scritto:
> 
> On Sun, 2018-05-06 at 09:42 +0200, Paolo Valente wrote:
>> 
>> diff --git a/block/bfq-mq-iosched.c b/block/bfq-mq-iosched.c
>> index 118f319af7c0..6662efe29b69 100644
>> --- a/block/bfq-mq-iosched.c
>> +++ b/block/bfq-mq-iosched.c
>> @@ -525,8 +525,13 @@ static void bfq_limit_depth(unsigned int op, struct blk_mq_alloc_data *data)
>>        if (unlikely(bfqd->sb_shift != bt->sb.shift))
>>                bfq_update_depths(bfqd, bt);
>> 
>> +#if 0
>>        data->shallow_depth =
>>                bfqd->word_depths[!!bfqd->wr_busy_queues][op_is_sync(op)];
>                                                            ^^^^^^^^^^^^^
> 
> Q: why doesn't the top of this function look like so?
> 
> ---
> block/bfq-iosched.c |    2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -539,7 +539,7 @@ static void bfq_limit_depth(unsigned int
> 	struct bfq_data *bfqd = data->q->elevator->elevator_data;
> 	struct sbitmap_queue *bt;
> 
> -	if (op_is_sync(op) && !op_is_write(op))
> +	if (!op_is_write(op))
> 		return;
> 
> 	if (data->flags & BLK_MQ_REQ_RESERVED) {
> 
> It looks a bit odd that these elements exist...
> 
> +       /*
> +        * no more than 75% of tags for sync writes (25% extra tags
> +        * w.r.t. async I/O, to prevent async I/O from starving sync
> +        * writes)
> +        */
> +       bfqd->word_depths[0][1] = max(((1U<<bfqd->sb_shift) * 3)>>2, 1U);
> 
> +       /* no more than ~37% of tags for sync writes (~20% extra tags) */
> +       bfqd->word_depths[1][1] = max(((1U<<bfqd->sb_shift) * 6)>>4, 1U);
> 
> ...yet we index via and log a guaranteed zero.
> 

I'm not sure I got your point, so, to help you help me quickly, I'll
repeat what I expect the code you highlight to do:

- sync reads must have no limitation, and the lines
if (op_is_sync(op) && !op_is_write(op))
	return;
make sure they don't

- sync writes must be limited, and the code you pasted above computes
those limits

- for sync writes, for which op_is_sync(op) is true (but the condition
"op_is_sync(op) && !op_is_write(op)" is false), the line:
	bfqd->word_depths[!!bfqd->wr_busy_queues][op_is_sync(op)];
becomes
	bfqd->word_depths[!!bfqd->wr_busy_queues][1];
e yields the right limit for sync writes, depending on bfqd->wr_busy_queues.

Where is the bug?

Thanks,
Paolo


> 	-Mike
> 
> 
