Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751860AbeEFK1B (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 06:27:01 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:47497 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751692AbeEFK05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 06:26:57 -0400
Date: Sun, 6 May 2018 12:26:54 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
cc: linux-kernel@vger.kernel.org,
        Mike Galbraith <umgwanakikbuti@gmail.com>, x86@kernel.org,
        Mike Galbraith <mgalbraith@suse.de>
Subject: Re: [PATCH] x86: UV: raw_spinlock conversion
In-Reply-To: <20180504111459.24825-2-bigeasy@linutronix.de>
Message-ID: <alpine.DEB.2.21.1805061225550.1685@nanos.tec.linutronix.de>
References: <20180504111459.24825-1-bigeasy@linutronix.de> <20180504111459.24825-2-bigeasy@linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 May 2018, Sebastian Andrzej Siewior wrote:

> From: Mike Galbraith <umgwanakikbuti@gmail.com>
> 
> Shrug.  Lots of hobbyists have a beast in their basement, right?

This hardly qualifies as a proper changelog ...

>  }
> @@ -299,13 +299,17 @@ static int uv_rtc_unset_timer(int cpu, i
>  static u64 uv_read_rtc(struct clocksource *cs)
>  {
>  	unsigned long offset;
> +	u64 cycles;
>  
> +	preempt_disable();
>  	if (uv_get_min_hub_revision_id() == 1)
>  		offset = 0;
>  	else
>  		offset = (uv_blade_processor_id() * L1_CACHE_BYTES) % PAGE_SIZE;
>  
> -	return (u64)uv_read_local_mmr(UVH_RTC | offset);
> +	cycles = (u64)uv_read_local_mmr(UVH_RTC | offset);
> +	preempt_enable();
> +	return cycles;

And how exaclty is this hunk related?

Thanks,

	tglx
