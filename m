Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751849AbeBUTYq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 14:24:46 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:39780 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751752AbeBUTYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 14:24:42 -0500
Subject: Re: [PATCH] mmc: dw_mmc: Fix the DTO timeout overflow calculation for
 32-bit systems
To: Evgeniy Didin <Evgeniy.Didin@synopsys.com>,
        <linux-mmc@vger.kernel.org>
CC: Ulf Hansson <ulf.hansson@linaro.org>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Douglas Anderson <dianders@chromium.org>,
        <linux-kernel@vger.kernel.org>, <linux-snps-arc@lists.infradead.org>,
        "andy.shevchenko@gmail.com >> Andy Shevchenko"
        <andy.shevchenko@gmail.com>
Newsgroups: gmane.linux.kernel.arc,gmane.linux.kernel.mmc,gmane.linux.kernel
References: <20180221175734.39114-1-Evgeniy.Didin@synopsys.com>
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Message-ID: <d5b828d8-be41-9faa-8b20-0a8ea1f33d53@synopsys.com>
Date: Wed, 21 Feb 2018 11:24:32 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180221175734.39114-1-Evgeniy.Didin@synopsys.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.10.161.84]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Evgeniy

On 02/21/2018 09:57 AM, Evgeniy Didin wrote:
> In commit 9d9491a7da2a ("mmc: dw_mmc: Fix the DTO timeout calculation") have been made
> changes which can cause multiply overflow for 32-bit systems.

Awesome, thx for quickly narrowing it down. I tried the fix and it cures my issue.

  It was caught on arc/hsdk board
> when "drto_ms" should be 671, but it was 70 and that caused a flow of stack-traces just copying
> file from mmc.

IMHO, the fragment above could be improved.

	"The broken timeout calculations caused false interrupt latency warnings
          and stacktrace splat (such as below) when accessing the SD Card."

| Running :  4M-check-reassembly-tcp-cmykw2-rotatew2.out -v0 -w1
| -  Info: Finished target initialization.
| mmcblk0: error -110 transferring data, sector 320544, nr 2048, cmd response
|  0x900, card status 0x0
| mmc_host mmc0: Bus speed (slot 0) = 50000000Hz (slot req 400000Hz, actual
| 396825HZ div = 63)
| mmc_host mmc0: Bus speed (slot 0) = 50000000Hz (slot req 25000000Hz, actual
|  25000000HZ div = 1)
| ------------[ cut here ]------------
| softirq: huh, entered softirq 6 TASKLET 6f6a9412 with preempt_count 00000101,
| exited with 00000100?
| WARNING: CPU: 2 PID: 0 at ../lib/scatterlist.c:652 sg_miter_next+0x28/0x20c
| Modules linked in:
| CPU: 2 PID: 0 Comm: swapper/2 Not tainted 4.15.0 #57
|
| Stack Trace:
|  arc_unwind_core.constprop.1+0xd0/0xf4
|  dump_stack+0x68/0x80
|  warn_slowpath_null+0x4e/0xec
|  sg_miter_next+0x28/0x20c
|  dw_mci_read_data_pio+0x44/0x190
|  dw_mmc f000a000.mmc: Unexpected interrupt latency
|   dw_mci_interrupt+0x3ee/0x530
|  __handle_irq_event_percpu+0x56/0x150
|  handle_irq_event+0x34/0x78
|  handle_level_irq+0x8e/0x120
|  generic_handle_irq+0x1c/0x2c
|  idu_cascade_isr+0x30/0x6c
|  __handle_domain_irq+0x72/0xc8
|  ret_from_exception+0x0/0x8
|---[ end trace 2a58c9af6c25fe51 ]---


> 
> Lets cast this multiply to long long int which prevents overflow.
> 
> Signed-off-by: Evgeniy Didin <Evgeniy.Didin@synopsys.com>
> CC: Alexey Brodkin <abrodkin@synopsys.com>
> CC: Douglas Anderson <dianders@chromium.org>
> CC: Ulf Hansson <ulf.hansson@linaro.org>
> CC: linux-kernel@vger.kernel.org
> CC: linux-snps-arc@lists.infradead.org

Tested-by: Vineet Gupta <vgupta@synopsys.com>
Fixes: ARC STAR 9001306872 HSDK, sdio: board crashes when copying big files

> ---
>   drivers/mmc/host/dw_mmc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 0aa39975f33b..1a0b9751c67c 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1944,7 +1944,7 @@ static void dw_mci_set_drto(struct dw_mci *host)
>   	drto_div = (mci_readl(host, CLKDIV) & 0xff) * 2;
>   	if (drto_div == 0)
>   		drto_div = 1;
> -	drto_ms = DIV_ROUND_UP(MSEC_PER_SEC * drto_clks * drto_div,
> +	drto_ms = DIV_ROUND_UP((uint64_t)MSEC_PER_SEC * drto_clks * drto_div,
>   			       host->bus_hz);
>   
>   	/* add a bit spare time */
> 
