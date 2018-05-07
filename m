Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751489AbeEGF4u convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 01:56:50 -0400
Received: from mout.gmx.net ([212.227.17.21]:40035 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750732AbeEGF4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 01:56:47 -0400
Message-ID: <1525672597.5064.3.camel@gmx.de>
Subject: Re: [PATCH BUGFIX] block, bfq: postpone rq preparation to insert or
 merge
From: Mike Galbraith <efault@gmx.de>
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, Mark Brown <broonie@kernel.org>,
        linus.walleij@linaro.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name
Date: Mon, 07 May 2018 07:56:37 +0200
In-Reply-To: <223CABEA-71E0-426F-A4AB-17BA8437C978@linaro.org>
References: <20180504171701.6876-1-paolo.valente@linaro.org>
         <1525463210.622.1.camel@gmx.de> <1525508378.5406.6.camel@gmx.de>
         <9F155F9F-F6B2-465A-BA4D-A86FF6825071@linaro.org>
         <1525532191.5406.15.camel@gmx.de>
         <223CABEA-71E0-426F-A4AB-17BA8437C978@linaro.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:b2gPUmqfIm+zZwYttxssSG5g+TN6p9kRTVQe8CBsdJtVpSRXU3x
 zZZWYnn2bvj+/jUtxP3JcY4Jvjknt4I1YiIBUXYGHbB3wuSkDyq67ZSOLT1Ay8mTnPD6761
 S35okzAmxlAVhTNAbJneeTw8mN+AdRUtttdW4f1UErwiRn3NEei2WPqnFse2VRD9yhrRneP
 l6C9ufkO1C1QgeMoJg4Bw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FtyHzbdF7/Y=:xhdWA1FMSwoGAVxwBDwsof
 q472K1Fs+ovpLMoYh4BtgkJNvrZBrDo4s0Y8/TxlVkn//AVZp9AorwxTeVmJvOBbtZQONIFvc
 LWIlqXW13e4ypzaG2NLZvTLgIcZmuA5qZ/V5ErXhEzhWJ7rM+aS75Tn4rFb4qNrJqR3osmZkn
 KZNRyPrkCMXcayiPhiGaPrSI4SQ3of07CAtQDbWdz4osKtpnkDhOUcAJFSnsmGOxXC5+vG7ZO
 0w4Iy+kV6rK73XXCHHHqJ8+BRgYdT1KMD1l/6R8HmMpUcVXEzsmz2fc++B/9c8OVrYr7J1/Sf
 bNLEUZldNNWs7dCZqMgfEeHbTeF5s5gAh4GqjsRjItGfEuW4/3kc4KqtgxQurvmie5aNnF3Ux
 2yoc/veWJFl9LuVxfawouZiM89HB+MwtbMGPmKNgFwXdP5r0m6A5e6ZBj3h2C7rsFXIrxs4AB
 U7L0L+qNi4Py0/fzCcGto3zZ/WadJZn6sjdaLL8VpygKIHanvUkfNzgzeAYuIxZ1j4LbRU+Oa
 eNYEyHRTB7gq07AoqKWH3mZzFqGvIGbnaVIlbTZIdNFHKa3h4BZT7kZ2AnmWgCvI/v6eePlgH
 NlSeCORvNnMtCA8iWDymWP/a0G8GpFXEHIJO4F1qgXh3rCI+tR9k1Uiia4T9ZV1EVVUAD9O96
 PiDu9l/tqaOXaKus+6GTU+VkdVHSZCI3B41OUza4403jJxeaY1xVKhf3hCLdX2IM3DlP1rpEK
 lqE1/g7cqT5wOg65gkw6Lf72HYWT36eeUXLyX2wlXRECk7nUGMD+HEGL1487hIHmhbNW7qRNZ
 cggKUUa
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-05-06 at 09:42 +0200, Paolo Valente wrote:
> 
> diff --git a/block/bfq-mq-iosched.c b/block/bfq-mq-iosched.c
> index 118f319af7c0..6662efe29b69 100644
> --- a/block/bfq-mq-iosched.c
> +++ b/block/bfq-mq-iosched.c
> @@ -525,8 +525,13 @@ static void bfq_limit_depth(unsigned int op, struct blk_mq_alloc_data *data)
>         if (unlikely(bfqd->sb_shift != bt->sb.shift))
>                 bfq_update_depths(bfqd, bt);
>  
> +#if 0
>         data->shallow_depth =
>                 bfqd->word_depths[!!bfqd->wr_busy_queues][op_is_sync(op)];
                                                            ^^^^^^^^^^^^^

Q: why doesn't the top of this function look like so?

---
 block/bfq-iosched.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -539,7 +539,7 @@ static void bfq_limit_depth(unsigned int
 	struct bfq_data *bfqd = data->q->elevator->elevator_data;
 	struct sbitmap_queue *bt;
 
-	if (op_is_sync(op) && !op_is_write(op))
+	if (!op_is_write(op))
 		return;
 
 	if (data->flags & BLK_MQ_REQ_RESERVED) {

It looks a bit odd that these elements exist...

+       /*
+        * no more than 75% of tags for sync writes (25% extra tags
+        * w.r.t. async I/O, to prevent async I/O from starving sync
+        * writes)
+        */
+       bfqd->word_depths[0][1] = max(((1U<<bfqd->sb_shift) * 3)>>2, 1U);

+       /* no more than ~37% of tags for sync writes (~20% extra tags) */
+       bfqd->word_depths[1][1] = max(((1U<<bfqd->sb_shift) * 6)>>4, 1U);

...yet we index via and log a guaranteed zero.

	-Mike
