Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755260AbeCSGDu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 02:03:50 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:45525 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755058AbeCSGDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 02:03:46 -0400
X-Google-Smtp-Source: AG47ELspE0f3lyNS+XuOb7Da1WE2Od7sM1IT0nug61fUwBx0a68KlSog3B8vF6Trj26T7hsJzO4TYw==
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH] block, bfq: keep peak_rate estimation within range
 1..2^32-1
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <152025413365.161046.7757556276366364549.stgit@buzz>
Date: Sun, 18 Mar 2018 23:03:43 -0700
Cc: linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "'Paolo Valente' via bfq-iosched"
        <bfq-iosched@googlegroups.com>
Message-Id: <FE5352B7-CAFC-466C-BA07-F1B7427AA309@linaro.org>
References: <152025413365.161046.7757556276366364549.stgit@buzz>
To: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
X-Mailer: Apple Mail (2.3445.5.20)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2J63tV7028151



> Il giorno 05 mar 2018, alle ore 04:48, Konstantin Khlebnikov <khlebnikov@yandex-team.ru> ha scritto:
> 
> Rate should never overflow or become zero because it is used as divider.
> This patch accumulates it with saturation.
> 
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> ---
> block/bfq-iosched.c |    8 +++++---
> 1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index aeca22d91101..a236c8d541b5 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -2546,7 +2546,8 @@ static void bfq_reset_rate_computation(struct bfq_data *bfqd,
> 
> static void bfq_update_rate_reset(struct bfq_data *bfqd, struct request *rq)
> {
> -	u32 rate, weight, divisor;
> +	u32 weight, divisor;
> +	u64 rate;
> 
> 	/*
> 	 * For the convergence property to hold (see comments on
> @@ -2634,9 +2635,10 @@ static void bfq_update_rate_reset(struct bfq_data *bfqd, struct request *rq)
> 	 */
> 	bfqd->peak_rate *= divisor-1;
> 	bfqd->peak_rate /= divisor;
> -	rate /= divisor; /* smoothing constant alpha = 1/divisor */
> +	do_div(rate, divisor);	/* smoothing constant alpha = 1/divisor */
> 
> -	bfqd->peak_rate += rate;
> +	/* rate should never overlow or become zero */

It is bfqd->peak_rate that is used as a divider, and bfqd->peak_rate doesn't risk to be zero even if the variable 'rate' is zero here.

So I guess the reason why you consider the possibility that bfqd->peak_rate becomes zero is because of an overflow when summing 'rate'. But, according to my calculations, this should be impossible with devices with sensible speeds.

These are the reasons why I decided I could make it with a 32-bit variable, without any additional clamping. Did I make any mistake in my evaluation?

Anyway, even if I made some mistake about the maximum possible value of the device rate, and the latter may be too high for bfqd->peak_rate to contain it, then I guess the right solution would not be to clamp the actual rate to U32_MAX, but to move bfqd->peak_rate to 64 bits. Or am I missing something else?

Thanks,
Paolo


> +	bfqd->peak_rate = clamp_t(u64, rate + bfqd->peak_rate, 1, U32_MAX);
> 	update_thr_responsiveness_params(bfqd);
> 
> reset_computation:
> 
