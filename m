Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33A2C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 14:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60D9B205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 14:28:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60D9B205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbeJ3XWG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 19:22:06 -0400
Received: from mga07.intel.com ([134.134.136.100]:51282 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728117AbeJ3XWF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 19:22:05 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2018 07:28:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,444,1534834800"; 
   d="scan'208";a="103790212"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga001.fm.intel.com with ESMTP; 30 Oct 2018 07:28:22 -0700
Date:   Tue, 30 Oct 2018 08:26:01 -0600
From:   Keith Busch <keith.busch@intel.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 11/14] irq: add support for allocating (and affinitizing)
 sets of IRQs
Message-ID: <20181030142601.GA18906@localhost.localdomain>
References: <20181029163738.10172-1-axboe@kernel.dk>
 <20181029163738.10172-12-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181029163738.10172-12-axboe@kernel.dk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 10:37:35AM -0600, Jens Axboe wrote:
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
> +		usedvecs += nr;
> +	}


While the code below returns the appropriate number of possible vectors
when a set requested too many, the above code is still using the value
from the set, which may exceed 'nvecs' used to kcalloc 'masks', so
'masks + usedvecs' may go out of bounds.

  
>  	/*
>  	 * Spread on non present CPUs starting from the next vector to be
> @@ -258,13 +272,21 @@ int irq_calc_affinity_vectors(int minvec, int maxvec, const struct irq_affinity
>  {
>  	int resv = affd->pre_vectors + affd->post_vectors;
>  	int vecs = maxvec - resv;
> -	int ret;
> +	int set_vecs;
>  
>  	if (resv > minvec)
>  		return 0;
>  
> -	get_online_cpus();
> -	ret = min_t(int, cpumask_weight(cpu_possible_mask), vecs) + resv;
> -	put_online_cpus();
> -	return ret;
> +	if (affd->nr_sets) {
> +		int i;
> +
> +		for (i = 0, set_vecs = 0;  i < affd->nr_sets; i++)
> +			set_vecs += affd->sets[i];
> +	} else {
> +		get_online_cpus();
> +		set_vecs = cpumask_weight(cpu_possible_mask);
> +		put_online_cpus();
> +	}
> +
> +	return resv + min(set_vecs, vecs);
>  }


