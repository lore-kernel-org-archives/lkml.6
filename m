Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2160A13F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 11:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D589520881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 11:03:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D589520881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbeG3Mht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 08:37:49 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55762 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbeG3Mhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 08:37:48 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fk5xM-0006ps-Fu; Mon, 30 Jul 2018 13:03:16 +0200
Date:   Mon, 30 Jul 2018 13:03:16 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Xu YiPing <xuyiping@hisilicon.com>
cc:     john.stultz@linaro.org, sboyd@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] timers: fix offset calculation when the expires align
 with LVL_GRAN
In-Reply-To: <1532669610-103892-1-git-send-email-xuyiping@hisilicon.com>
Message-ID: <alpine.DEB.2.21.1807301234310.2518@nanos.tec.linutronix.de>
References: <1532669610-103892-1-git-send-email-xuyiping@hisilicon.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Jul 2018, Xu YiPing wrote:

> when the expires of timer is align with LVL_GRAN(n), it will be trigged
> in 'expires + LVL_GRAN(n)'.
> 
> Some drivers like power runtime use the timer to start a power down
> of device, it could saves power if the timer is triggerd in time,
> especially when LEVEL=0 with low expires.

From the above I have no idea what you are trying to 'fix', but see below.

> Signed-off-by: Xu YiPing <xuyiping@hisilicon.com>
> ---
>  kernel/time/timer.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/time/timer.c b/kernel/time/timer.c
> index cc2d23e..76655e2 100644
> --- a/kernel/time/timer.c
> +++ b/kernel/time/timer.c
> @@ -487,7 +487,8 @@ static inline void timer_set_idx(struct timer_list *timer, unsigned int idx)
>   */
>  static inline unsigned calc_index(unsigned expires, unsigned lvl)
>  {
> -	expires = (expires + LVL_GRAN(lvl)) >> LVL_SHIFT(lvl);
> +	expires = (expires + LVL_GRAN(lvl) - 1) >> LVL_SHIFT(lvl);
> +
>  	return LVL_OFFS(lvl) + (expires & LVL_MASK);

This is fundamentally wrong.

Assume the following scenario:

    base->clk = 1;
    timer->expires = 1;

__internal_add_timer(base, timer)
{  
   idx = calc_wheel_index(timer->expires, base->clk)
       {
           delta = expires - clk;

           if (delta < LVL_START(1))
               idx = calc_index(expires, 0)
                    {
                        expires = (expires + LVL_GRAN(0) - 1) >> LVL_SHIFT(0);
			return LVL_OFFS(0) + (expires & LVL_MASK);

Now lets use real numbers:

__internal_add_timer(base, timer)
{  
   idx = calc_wheel_index(1, 1)
       {
           delta = 1 - 1;	<-   0

           if (0 < LVL_START(1))
               idx = calc_index(1, 0)
                    {
                        expires = (1 + LVL_GRAN(0) - 1) >> LVL_SHIFT(0);
			----> expires = 0
			return LVL_OFFS(0) + (0 & LVL_MASK);
			----> 0

So the returned index is 0, which means that the timer will expire in
LVL_SIZE - 1 == 63 ticks.

The above example is the worst case, but you broke other assumptions as
well. The timer wheel guarantees that a timer armed with:

      mod_timer(timer, jiffies + 1)

will not fire before aty least one jiffy has elapsed. Let's look at the
time line:

   |-------------------|-------------------|----------------|
  tick               tick                tick
 jiffies	   jiffies + 1        jiffies + 2

   |                   |
   |  Any timer armed  |                   ^
   |  here must be     |                   |
   |  queued here -------------------------|

in order to guarantee that. Timer wheel timers are not accurate and never
can be.

Thanks,

	tglx
