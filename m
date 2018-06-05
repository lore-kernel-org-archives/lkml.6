Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751804AbeFELUq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 07:20:46 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:33044 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751632AbeFELUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 07:20:45 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200";
   d="scan'208";a="40758883"
Subject: Re: [patch 2/8] genirq/generic_pending: Do not lose pending affinity
 update
To: Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
CC: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Dmitry Safonov <0x7f454c46@gmail.com>,
        Tariq Toukan <tariqt@mellanox.com>, Song Liu <liu.song.a23@gmail.com>,
        Joerg Roedel <jroedel@suse.de>, Mike Travis <mike.travis@hpe.com>,
        <stable@vger.kernel.org>
References: <20180604162224.386544292@linutronix.de>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <74a8cfe1-56e4-6082-1d53-a76faf5105eb@cn.fujitsu.com>
Date: Tue, 5 Jun 2018 19:20:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180604162224.386544292@linutronix.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.106]
X-yoursite-MailScanner-ID: 561244B40410.A8475
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: douly.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

At 06/04/2018 11:33 PM, Thomas Gleixner wrote:
> The generic pending interrupt mechanism moves interrupts from the interrupt
> handler on the original target CPU to the new destination CPU. This is
> required for x86 and ia64 due to the way the interrupt delivery and
> acknowledge works if the interrupts are not remapped.
> 
> However that update can fail for various reasons. Some of them are valid
> reasons to discard the pending update, but the case, when the previous move
> has not been fully cleaned up is not a legit reason to fail.
> 
> Check the return value of irq_do_set_affinity() for -EBUSY, which indicates
> a pending cleanup, and rearm the pending move in the irq dexcriptor so it's

s/dexcriptor/descriptor

> tried again when the next interrupt arrives.
> 
> Fixes: 996c591227d9 ("x86/irq: Plug vector cleanup race")
> Signed-off-by: Thomas Gleixner<tglx@linutronix.de>
> Cc:stable@vger.kernel.org
> ---
>   kernel/irq/migration.c |   24 ++++++++++++++++++------
>   1 file changed, 18 insertions(+), 6 deletions(-)
> 
> --- a/kernel/irq/migration.c
> +++ b/kernel/irq/migration.c
> @@ -38,17 +38,18 @@ bool irq_fixup_move_pending(struct irq_d
>   void irq_move_masked_irq(struct irq_data *idata)
>   {
>   	struct irq_desc *desc = irq_data_to_desc(idata);
> -	struct irq_chip *chip = desc->irq_data.chip;
> +	struct irq_data *data = &desc->irq_data;
> +	struct irq_chip *chip = data->chip;
>   
> -	if (likely(!irqd_is_setaffinity_pending(&desc->irq_data)))
> +	if (likely(!irqd_is_setaffinity_pending(data)))
>   		return;
>   
> -	irqd_clr_move_pending(&desc->irq_data);
> +	irqd_clr_move_pending(data);
>   
>   	/*
>   	 * Paranoia: cpu-local interrupts shouldn't be calling in here anyway.
>   	 */
> -	if (irqd_is_per_cpu(&desc->irq_data)) {
> +	if (irqd_is_per_cpu(data)) {
>   		WARN_ON(1);
>   		return;
>   	}
> @@ -73,9 +74,20 @@ void irq_move_masked_irq(struct irq_data
>   	 * For correct operation this depends on the caller
>   	 * masking the irqs.
>   	 */
> -	if (cpumask_any_and(desc->pending_mask, cpu_online_mask) < nr_cpu_ids)
> -		irq_do_set_affinity(&desc->irq_data, desc->pending_mask, false);
> +	if (cpumask_any_and(desc->pending_mask, cpu_online_mask) < nr_cpu_ids) {
> +		int ret;
>   
> +		ret = irq_do_set_affinity(data, desc->pending_mask, false);
> +		/*
> +		 * If the there is a cleanup pending in the underlying

s/If the there is/If there is/

Thanks,
	dou
