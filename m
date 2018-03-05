Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751881AbeCEPAd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 10:00:33 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50313 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751294AbeCEPAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 10:00:30 -0500
X-Google-Smtp-Source: AG47ELtv/WSk+ZtakbM/6mcw+GJRKZ8y15qklO6vJA4Jwls6/mORKnGaNezrdkuf9zW6q2pOpl5zrQ==
Message-ID: <1520262026.2743.4.camel@arista.com>
Subject: Re: [PATCHv3] iommu/intel: Ratelimit each dmar fault printing
From: Dmitry Safonov <dima@arista.com>
To: linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>
Cc: 0x7f454c46@gmail.com, Alex Williamson <alex.williamson@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux-foundation.org
Date: Mon, 05 Mar 2018 15:00:26 +0000
In-Reply-To: <20180215191729.15777-1-dima@arista.com>
References: <20180215191729.15777-1-dima@arista.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

What do you think about v3?
It looks like, I can solve my softlookups with just a bit more proper
ratelimiting..

On Thu, 2018-02-15 at 19:17 +0000, Dmitry Safonov wrote:
> There is a ratelimit for printing, but it's incremented each time the
> cpu recives dmar fault interrupt. While one interrupt may signal
> about
> *many* faults.
> So, measuring the impact it turns out that reading/clearing one fault
> takes < 1 usec, and printing info about the fault takes ~170 msec.
> 
> Having in mind that maximum number of fault recording registers per
> remapping hardware unit is 256.. IRQ handler may run for (170*256)
> msec.
> And as fault-serving loop runs without a time limit, during servicing
> new faults may occur..
> 
> Ratelimit each fault printing rather than each irq printing.
> 
> Fixes: commit c43fce4eebae ("iommu/vt-d: Ratelimit fault handler")
> 
> BUG: spinlock lockup suspected on CPU#0, CliShell/9903
>  lock: 0xffffffff81a47440, .magic: dead4ead, .owner:
> kworker/u16:2/8915, .owner_cpu: 6
> CPU: 0 PID: 9903 Comm: CliShell
> Call Trace:$\n'
> [..] dump_stack+0x65/0x83$\n'
> [..] spin_dump+0x8f/0x94$\n'
> [..] do_raw_spin_lock+0x123/0x170$\n'
> [..] _raw_spin_lock_irqsave+0x32/0x3a$\n'
> [..] uart_chars_in_buffer+0x20/0x4d$\n'
> [..] tty_chars_in_buffer+0x18/0x1d$\n'
> [..] n_tty_poll+0x1cb/0x1f2$\n'
> [..] tty_poll+0x5e/0x76$\n'
> [..] do_select+0x363/0x629$\n'
> [..] compat_core_sys_select+0x19e/0x239$\n'
> [..] compat_SyS_select+0x98/0xc0$\n'
> [..] sysenter_dispatch+0x7/0x25$\n'
> [..]
> NMI backtrace for cpu 6
> CPU: 6 PID: 8915 Comm: kworker/u16:2
> Workqueue: dmar_fault dmar_fault_work
> Call Trace:$\n'
> [..] wait_for_xmitr+0x26/0x8f$\n'
> [..] serial8250_console_putchar+0x1c/0x2c$\n'
> [..] uart_console_write+0x40/0x4b$\n'
> [..] serial8250_console_write+0xe6/0x13f$\n'
> [..] call_console_drivers.constprop.13+0xce/0x103$\n'
> [..] console_unlock+0x1f8/0x39b$\n'
> [..] vprintk_emit+0x39e/0x3e6$\n'
> [..] printk+0x4d/0x4f$\n'
> [..] dmar_fault+0x1a8/0x1fc$\n'
> [..] dmar_fault_work+0x15/0x17$\n'
> [..] process_one_work+0x1e8/0x3a9$\n'
> [..] worker_thread+0x25d/0x345$\n'
> [..] kthread+0xea/0xf2$\n'
> [..] ret_from_fork+0x58/0x90$\n'
> 
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> Cc: iommu@lists.linux-foundation.org
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> ---
> Maybe it's worth to limit while(1) cycle.
> If IOMMU generates faults with equal speed as irq handler cleans
> them, it may turn into long-irq-disabled region again.
> Not sure if it can happen anyway.
> 
>  drivers/iommu/dmar.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
> index accf58388bdb..6c4ea32ee6a9 100644
> --- a/drivers/iommu/dmar.c
> +++ b/drivers/iommu/dmar.c
> @@ -1618,17 +1618,13 @@ irqreturn_t dmar_fault(int irq, void *dev_id)
>  	int reg, fault_index;
>  	u32 fault_status;
>  	unsigned long flag;
> -	bool ratelimited;
>  	static DEFINE_RATELIMIT_STATE(rs,
>  				      DEFAULT_RATELIMIT_INTERVAL,
>  				      DEFAULT_RATELIMIT_BURST);
>  
> -	/* Disable printing, simply clear the fault when ratelimited
> */
> -	ratelimited = !__ratelimit(&rs);
> -
>  	raw_spin_lock_irqsave(&iommu->register_lock, flag);
>  	fault_status = readl(iommu->reg + DMAR_FSTS_REG);
> -	if (fault_status && !ratelimited)
> +	if (fault_status && __ratelimit(&rs))
>  		pr_err("DRHD: handling fault status reg %x\n",
> fault_status);
>  
>  	/* TBD: ignore advanced fault log currently */
> @@ -1638,6 +1634,8 @@ irqreturn_t dmar_fault(int irq, void *dev_id)
>  	fault_index = dma_fsts_fault_record_index(fault_status);
>  	reg = cap_fault_reg_offset(iommu->cap);
>  	while (1) {
> +		/* Disable printing, simply clear the fault when
> ratelimited */
> +		bool ratelimited = !__ratelimit(&rs);
>  		u8 fault_reason;
>  		u16 source_id;
>  		u64 guest_addr;
