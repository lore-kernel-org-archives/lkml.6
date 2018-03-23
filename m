Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751858AbeCWP1O (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 11:27:14 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52236 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751504AbeCWP1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 11:27:13 -0400
Subject: Re: [PATCH v2] KVM: arm/arm64 : add lpi info in vgic-debug
To: Peng Hao <peng.hao2@zte.com.cn>, Christoffer Dall <cdall@kernel.org>
Cc: linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org
References: <1521846074-66914-1-git-send-email-peng.hao2@zte.com.cn>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <a1148944-ef9c-7ef5-640b-2f20ce0efffd@arm.com>
Date: Fri, 23 Mar 2018 15:27:09 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1521846074-66914-1-git-send-email-peng.hao2@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/03/18 23:01, Peng Hao wrote:
> Add lpi debug info to vgic-stat.
> the printed info like this:
>     SPI  287      0 000001        0        0   0 160      -1
>     LPI 8192      2 000100        0        0   0 160      -1
> 
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---
>  virt/kvm/arm/vgic/vgic-debug.c | 56 ++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 51 insertions(+), 5 deletions(-)
> 
> diff --git a/virt/kvm/arm/vgic/vgic-debug.c b/virt/kvm/arm/vgic/vgic-debug.c
> index 10b3817..cb85550 100644
> --- a/virt/kvm/arm/vgic/vgic-debug.c
> +++ b/virt/kvm/arm/vgic/vgic-debug.c
> @@ -36,9 +36,12 @@
>  struct vgic_state_iter {
>  	int nr_cpus;
>  	int nr_spis;
> +	int nr_lpis;
>  	int dist_id;
>  	int vcpu_id;
>  	int intid;
> +	int lpi_print_count;
> +	struct vgic_irq **lpi_irqs;
>  };
>  
>  static void iter_next(struct vgic_state_iter *iter)
> @@ -52,6 +55,35 @@ static void iter_next(struct vgic_state_iter *iter)
>  	if (iter->intid == VGIC_NR_PRIVATE_IRQS &&
>  	    ++iter->vcpu_id < iter->nr_cpus)
>  		iter->intid = 0;
> +
> +	if (iter->intid >= VGIC_NR_PRIVATE_IRQS + iter->nr_spis) {
> +		if (iter->lpi_print_count < iter->nr_lpis)
> +			iter->intid = iter->lpi_irqs[iter->lpi_print_count]->intid;
> +		iter->lpi_print_count++;
> +	}
> +}
> +
> +static void vgic_debug_get_lpis(struct kvm *kvm, struct vgic_state_iter *iter)
> +{
> +	struct vgic_dist *dist = &kvm->arch.vgic;
> +	int i = 0;
> +	struct vgic_irq *irq = NULL, **lpi_irqs;
> +
> +	iter->nr_lpis = dist->lpi_list_count;
> +	lpi_irqs = kmalloc_array(iter->nr_lpis, sizeof(irq), GFP_KERNEL);
> +	if (!lpi_irqs) {
> +		iter->nr_lpis = 0;
> +		return;
> +	}
> +	spin_lock(&dist->lpi_list_lock);
> +	list_for_each_entry(irq, &dist->lpi_list_head, lpi_list) {
> +		vgic_get_irq_kref(irq);
> +		if (i < iter->nr_lpis)
> +			lpi_irqs[i++] = irq;
> +	}
> +	iter->nr_lpis = i;
> +	spin_unlock(&dist->lpi_list_lock);
> +	iter->lpi_irqs = lpi_irqs;

I've already explained why I didn't like this construct.

I still don't like it.

	M.
-- 
Jazz is not dead. It just smells funny...
