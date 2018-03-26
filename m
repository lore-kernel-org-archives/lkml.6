Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751981AbeCZIRk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 04:17:40 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37760 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750923AbeCZIRj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 04:17:39 -0400
Subject: Re: [PATCH 2/3] drivers/irqchip: update supports_deactivate static
 key to modern api
To: Davidlohr Bueso <dave@stgolabs.net>, peterz@infradead.org,
        akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>, Davidlohr Bueso <dbueso@suse.de>
References: <20180325191056.24598-1-dave@stgolabs.net>
 <20180325191056.24598-3-dave@stgolabs.net>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <671202a1-4080-0104-abd8-4718c53dd61e@arm.com>
Date: Mon, 26 Mar 2018 09:17:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180325191056.24598-3-dave@stgolabs.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Davidlohr,

On 25/03/18 20:10, Davidlohr Bueso wrote:
> Minor changes in semantics -- key init is true; replace
> 
> static_key_slow_dec       with   static_branch_disable
> static_key_true           with   static_branch_likely
> 
> The first is because we never actually do any couterpart incs,
> thus there is really no reference counting semantics going on.
> Use the more proper static_branch_disable() construct.
> 
> Also added a '_key' suffix to supports_deactivate, for better
> self documentation.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
> ---
>  drivers/irqchip/irq-gic-v3.c | 20 ++++++++++----------
>  drivers/irqchip/irq-gic.c    | 22 +++++++++++-----------
>  2 files changed, 21 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index 56c8de84a72b..f32b1814278b 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -61,7 +61,7 @@ struct gic_chip_data {
>  };
>  
>  static struct gic_chip_data gic_data __read_mostly;
> -static struct static_key supports_deactivate = STATIC_KEY_INIT_TRUE;
> +DEFINE_STATIC_KEY_TRUE(supports_deactivate_key);

When you combine this...

[...]

> diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
> index ac2e62d613d1..9b7630cee56c 100644
> --- a/drivers/irqchip/irq-gic.c
> +++ b/drivers/irqchip/irq-gic.c
> @@ -121,7 +121,7 @@ static DEFINE_RAW_SPINLOCK(cpu_map_lock);
>  #define NR_GIC_CPU_IF 8
>  static u8 gic_cpu_map[NR_GIC_CPU_IF] __read_mostly;
>  
> -static struct static_key supports_deactivate = STATIC_KEY_INIT_TRUE;
> +DEFINE_STATIC_KEY_TRUE(supports_deactivate_key);

...with that, bad things happen:

drivers/irqchip/irq-gic-v3.o:(.data+0x278): multiple definition of `supports_deactivate_key'
drivers/irqchip/irq-gic.o:(.data+0x18): first defined here
Makefile:1032: recipe for target 'vmlinux' failed
make: *** [vmlinux] Error 1

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
