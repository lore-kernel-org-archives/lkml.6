Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751402AbeCTDAU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 23:00:20 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:40408 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751022AbeCTDAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 23:00:17 -0400
X-Google-Smtp-Source: AG47ELt49S4xHvh84pIqS+HpI0FuDPXUQ2tu6LUDtdFaIcXwImNYP07c8zm9w0SN8BpceIDj/7a4hg==
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH] block, bfq: keep peak_rate estimation within range
 1..2^32-1
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <ff761610-4a37-f239-a491-cf2a04c44574@yandex-team.ru>
Date: Tue, 20 Mar 2018 11:00:11 +0800
Cc: linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "'Paolo Valente' via bfq-iosched"
        <bfq-iosched@googlegroups.com>,
        Mark Brown <broonie@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Message-Id: <E9AC28A6-848D-420F-8DAB-8B1FC709BA38@linaro.org>
References: <152025413365.161046.7757556276366364549.stgit@buzz>
 <FE5352B7-CAFC-466C-BA07-F1B7427AA309@linaro.org>
 <ff761610-4a37-f239-a491-cf2a04c44574@yandex-team.ru>
To: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
X-Mailer: Apple Mail (2.3445.5.20)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2K30T2G029046



> Il giorno 19 mar 2018, alle ore 14:28, Konstantin Khlebnikov <khlebnikov@yandex-team.ru> ha scritto:
> 
> On 19.03.2018 09:03, Paolo Valente wrote:
>>> Il giorno 05 mar 2018, alle ore 04:48, Konstantin Khlebnikov <khlebnikov@yandex-team.ru> ha scritto:
>>> 
>>> Rate should never overflow or become zero because it is used as divider.
>>> This patch accumulates it with saturation.
>>> 
>>> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
>>> ---
>>> block/bfq-iosched.c |    8 +++++---
>>> 1 file changed, 5 insertions(+), 3 deletions(-)
>>> 
>>> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
>>> index aeca22d91101..a236c8d541b5 100644
>>> --- a/block/bfq-iosched.c
>>> +++ b/block/bfq-iosched.c
>>> @@ -2546,7 +2546,8 @@ static void bfq_reset_rate_computation(struct bfq_data *bfqd,
>>> 
>>> static void bfq_update_rate_reset(struct bfq_data *bfqd, struct request *rq)
>>> {
>>> -	u32 rate, weight, divisor;
>>> +	u32 weight, divisor;
>>> +	u64 rate;
>>> 
>>> 	/*
>>> 	 * For the convergence property to hold (see comments on
>>> @@ -2634,9 +2635,10 @@ static void bfq_update_rate_reset(struct bfq_data *bfqd, struct request *rq)
>>> 	 */
>>> 	bfqd->peak_rate *= divisor-1;
>>> 	bfqd->peak_rate /= divisor;
>>> -	rate /= divisor; /* smoothing constant alpha = 1/divisor */
>>> +	do_div(rate, divisor);	/* smoothing constant alpha = 1/divisor */
>>> 
>>> -	bfqd->peak_rate += rate;
>>> +	/* rate should never overlow or become zero */
>> It is bfqd->peak_rate that is used as a divider, and bfqd->peak_rate doesn't risk to be zero even if the variable 'rate' is zero here.
>> So I guess the reason why you consider the possibility that bfqd->peak_rate becomes zero is because of an overflow when summing 'rate'. But, according to my calculations, this should be impossible with devices with sensible speeds.
>> These are the reasons why I decided I could make it with a 32-bit variable, without any additional clamping. Did I make any mistake in my evaluation?
> 
> According to Murphy's law this is inevitable..
> 

Yep.  Actually Murphy has been even clement this time, by making the
failure occur to a kernel expert :)

> I've seen couple division by zero crashes in bfq_wr_duration.
> Unfortunately logs weren't recorded.
> 
>> Anyway, even if I made some mistake about the maximum possible value of the device rate, and the latter may be too high for bfqd->peak_rate to contain it, then I guess the right solution would not be to clamp the actual rate to U32_MAX, but to move bfqd->peak_rate to 64 bits. Or am I missing something else?
> >>> +	bfqd->peak_rate = clamp_t(u64, rate + bfqd->peak_rate, 1, U32_MAX);
> 
> 32-bit should be enough and better for division.
> My patch makes sure it never overflows/underflows.
> That's cheaper than full 64-bit/64-bit division.
> Anyway 64-bit speed could overflow too. =)
> 

I see your point.  Still, if the mistake is not in sizing, then you
bumped into some odd bug.  In this respect, I don't like much the idea
of sweeping the dust under the carpet.  So, let me ask you for a
little bit more help.  With your patch applied, and thus with no risk
of crashes, what about adding, right before your clamp_t, something
like:

if (!bfqd->peak_rate)
	pr_crit(<dump of all the variables involved in updating bfqd->peak_rate>);

Once the failure shows up (Murphy permitting), we might have hints to
the bug causing it.

Apart from that, I have no problem with patches that make bfq more
robust, even in a sort of black-box way.

Thanks a lot,
Paolo

> 
>>> 	update_thr_responsiveness_params(bfqd);
>>> 
>>> reset_computation:
