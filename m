Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D40C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 14:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49AFD2081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 14:37:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49AFD2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbeKBXoh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 19:44:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43611 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727808AbeKBXoh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 19:44:37 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4C35958E3E;
        Fri,  2 Nov 2018 14:37:18 +0000 (UTC)
Received: from ming.t460p (ovpn-8-27.pek2.redhat.com [10.72.8.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1DC185D9C9;
        Fri,  2 Nov 2018 14:37:11 +0000 (UTC)
Date:   Fri, 2 Nov 2018 22:37:07 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 13/16] irq: add support for allocating (and affinitizing)
 sets of IRQs
Message-ID: <20181102143707.GA31121@ming.t460p>
References: <20181030183252.17857-1-axboe@kernel.dk>
 <20181030183252.17857-14-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181030183252.17857-14-axboe@kernel.dk>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Fri, 02 Nov 2018 14:37:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 12:32:49PM -0600, Jens Axboe wrote:
> A driver may have a need to allocate multiple sets of MSI/MSI-X
> interrupts, and have them appropriately affinitized. Add support for
> defining a number of sets in the irq_affinity structure, of varying
> sizes, and get each set affinitized correctly across the machine.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-kernel@vger.kernel.org
> Reviewed-by: Hannes Reinecke <hare@suse.com>
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  drivers/pci/msi.c         | 14 ++++++++++++++
>  include/linux/interrupt.h |  4 ++++
>  kernel/irq/affinity.c     | 40 ++++++++++++++++++++++++++++++---------
>  3 files changed, 49 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index af24ed50a245..e6c6e10b9ceb 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -1036,6 +1036,13 @@ static int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
>  	if (maxvec < minvec)
>  		return -ERANGE;
>  
> +	/*
> +	 * If the caller is passing in sets, we can't support a range of
> +	 * vectors. The caller needs to handle that.
> +	 */
> +	if (affd->nr_sets && minvec != maxvec)
> +		return -EINVAL;
> +
>  	if (WARN_ON_ONCE(dev->msi_enabled))
>  		return -EINVAL;
>  
> @@ -1087,6 +1094,13 @@ static int __pci_enable_msix_range(struct pci_dev *dev,
>  	if (maxvec < minvec)
>  		return -ERANGE;
>  
> +	/*
> +	 * If the caller is passing in sets, we can't support a range of
> +	 * supported vectors. The caller needs to handle that.
> +	 */
> +	if (affd->nr_sets && minvec != maxvec)
> +		return -EINVAL;
> +
>  	if (WARN_ON_ONCE(dev->msix_enabled))
>  		return -EINVAL;
>  
> diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
> index 1d6711c28271..ca397ff40836 100644
> --- a/include/linux/interrupt.h
> +++ b/include/linux/interrupt.h
> @@ -247,10 +247,14 @@ struct irq_affinity_notify {
>   *			the MSI(-X) vector space
>   * @post_vectors:	Don't apply affinity to @post_vectors at end of
>   *			the MSI(-X) vector space
> + * @nr_sets:		Length of passed in *sets array
> + * @sets:		Number of affinitized sets
>   */
>  struct irq_affinity {
>  	int	pre_vectors;
>  	int	post_vectors;
> +	int	nr_sets;
> +	int	*sets;
>  };
>  
>  #if defined(CONFIG_SMP)
> diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
> index f4f29b9d90ee..2046a0f0f0f1 100644
> --- a/kernel/irq/affinity.c
> +++ b/kernel/irq/affinity.c
> @@ -180,6 +180,7 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
>  	int curvec, usedvecs;
>  	cpumask_var_t nmsk, npresmsk, *node_to_cpumask;
>  	struct cpumask *masks = NULL;
> +	int i, nr_sets;
>  
>  	/*
>  	 * If there aren't any vectors left after applying the pre/post
> @@ -210,10 +211,23 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
>  	get_online_cpus();
>  	build_node_to_cpumask(node_to_cpumask);
>  
> -	/* Spread on present CPUs starting from affd->pre_vectors */
> -	usedvecs = irq_build_affinity_masks(affd, curvec, affvecs,
> -					    node_to_cpumask, cpu_present_mask,
> -					    nmsk, masks);
> +	/*
> +	 * Spread on present CPUs starting from affd->pre_vectors. If we
> +	 * have multiple sets, build each sets affinity mask separately.
> +	 */
> +	nr_sets = affd->nr_sets;
> +	if (!nr_sets)
> +		nr_sets = 1;
> +
> +	for (i = 0, usedvecs = 0; i < nr_sets; i++) {
> +		int this_vecs = affd->sets ? affd->sets[i] : affvecs;
> +		int nr;
> +
> +		nr = irq_build_affinity_masks(affd, curvec, this_vecs,
> +					      node_to_cpumask, cpu_present_mask,
> +					      nmsk, masks + usedvecs);

The last parameter of the above function should have been 'masks',
because irq_build_affinity_masks() always treats 'masks' as the base
address of the array.

> +		usedvecs += nr;
> +	}

Thinking of further, one big problem in this patch is that each set of
IRQs should have been spread on all possible CPUs, which is done via
2-stages spread now.

However, this patch only spreads each set of IRQs on present CPUs, this
way may not work in case of physical CPU hotplug.

Thanks,
Ming
