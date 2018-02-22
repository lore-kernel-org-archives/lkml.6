Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753710AbeBVL35 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 06:29:57 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:38819 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753663AbeBVL3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 06:29:55 -0500
Date: Thu, 22 Feb 2018 12:30:04 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Yuriy Vostrikov <delamonpansie@gmail.com>
Subject: Re: [patch 3/3] x
In-Reply-To: <20180222112317.009379968@linutronix.de>
Message-ID: <alpine.DEB.2.21.1802221229350.1331@nanos.tec.linutronix.de>
References: <20180222110804.587011608@linutronix.de> <20180222112317.009379968@linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bah, scratch that. That's a different story and I missed to remove that
patch from the quilt series.....

On Thu, 22 Feb 2018, Thomas Gleixner wrote:

> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  kernel/irq/manage.c |   10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -855,10 +855,14 @@ irq_thread_check_affinity(struct irq_des
>  	 * This code is triggered unconditionally. Check the affinity
>  	 * mask pointer. For CPU_MASK_OFFSTACK=n this is optimized out.
>  	 */
> -	if (cpumask_available(desc->irq_common_data.affinity))
> -		cpumask_copy(mask, desc->irq_common_data.affinity);
> -	else
> +	if (cpumask_available(desc->irq_common_data.affinity)) {
> +		const struct cpumask *m;
> +
> +		m = irq_data_get_effective_affinity_mask(&desc->irq_data);
> +		cpumask_copy(mask, m);
> +	} else {
>  		valid = false;
> +	}
>  	raw_spin_unlock_irq(&desc->lock);
>  
>  	if (valid)
> 
> 
> 
