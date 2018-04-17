Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754108AbeDQQ6v (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 12:58:51 -0400
Received: from smtprelay.synopsys.com ([198.182.47.9]:52224 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753392AbeDQQ6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 12:58:49 -0400
Subject: Re: [PATCH] clocksource: arc_timer: add comments about locking while
 read GFRC
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org"
        <linux-snps-arc@lists.infradead.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alexey Brodkin" <Alexey.Brodkin@synopsys.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20180417155232.4989-1-Eugeniy.Paltsev@synopsys.com>
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Message-ID: <a87ce229-2142-f393-aabf-2b0750f19ae5@synopsys.com>
Date: Tue, 17 Apr 2018 09:58:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180417155232.4989-1-Eugeniy.Paltsev@synopsys.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.10.161.84]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/17/2018 08:52 AM, Eugeniy Paltsev wrote:
> This came to light in some internal discussions and it is nice to have
> this documented rather than digging up the PRM (Prog Ref Manual) again.
>
> Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>

Minor nits below, otherwise LGTM !
Acked-by: Vineet Gupta <vgupta@synopsys.com>

> ---
>   drivers/clocksource/arc_timer.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
>
> diff --git a/drivers/clocksource/arc_timer.c b/drivers/clocksource/arc_timer.c
> index 4927355f9cbe..b594c373debc 100644
> --- a/drivers/clocksource/arc_timer.c
> +++ b/drivers/clocksource/arc_timer.c
> @@ -61,6 +61,19 @@ static u64 arc_read_gfrc(struct clocksource *cs)
>   	unsigned long flags;
>   	u32 l, h;
>   
> +	/*
> +	 * MCIP_CMD/MCIP_READBACK registers are allocated

 From a programming model pov, there seems to be just one instance of 
MCIP_CMD/MCIP_READBACK however micro-architecturally there's an instance PER ARC 
CORE.....
> +	 * PER ARC CORE (not per cluster), and there are dedicated hardware
> +	 * decode logic (per core) inside ARConnect to handle simultaneous
> +	 * read/write accesses from cores via those two registers.
> +	 * So several concurrent commands to ARConnect are OK if they are
> +	 * trying to access two different sub-components (like GFRC,
> +	 * inter-core interrupt, etc...). HW also support simultaneously

s/support/supports/

> +	 * accessing GFRC by multiple cores.
> +	 * That's why it is safe to disable hard interrupts on the local CPU
> +	 * before access to GFRC instead of taking global MCIP spinlock
> +	 * defined in arch/arc/kernel/mcip.c
> +	 */
>   	local_irq_save(flags);
>   
>   	__mcip_cmd(CMD_GFRC_READ_LO, 0);
