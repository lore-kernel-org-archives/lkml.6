Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B72ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 21:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D41FF2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 21:54:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D41FF2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727694AbeJZG3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 02:29:10 -0400
Received: from mga18.intel.com ([134.134.136.126]:54492 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbeJZG3K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 02:29:10 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2018 14:54:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,425,1534834800"; 
   d="scan'208";a="268837411"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga005.jf.intel.com with ESMTP; 25 Oct 2018 14:54:44 -0700
Date:   Thu, 25 Oct 2018 15:52:13 -0600
From:   Keith Busch <keith.busch@intel.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/14] irq: add support for allocating (and affinitizing)
 sets of IRQs
Message-ID: <20181025215213.GA8141@localhost.localdomain>
References: <20181025211626.12692-1-axboe@kernel.dk>
 <20181025211626.12692-12-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181025211626.12692-12-axboe@kernel.dk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 03:16:23PM -0600, Jens Axboe wrote:
> A driver may have a need to allocate multiple sets of MSI/MSI-X
> interrupts, and have them appropriately affinitized. Add support for
> defining a number of sets in the irq_affinity structure, of varying
> sizes, and get each set affinitized correctly across the machine.

<>

> @@ -258,13 +272,18 @@ int irq_calc_affinity_vectors(int minvec, int maxvec, const struct irq_affinity
>  {
>  	int resv = affd->pre_vectors + affd->post_vectors;
>  	int vecs = maxvec - resv;
> +	int i, set_vecs;
>  	int ret;
>  
>  	if (resv > minvec)
>  		return 0;
>  
>  	get_online_cpus();
> -	ret = min_t(int, cpumask_weight(cpu_possible_mask), vecs) + resv;
> +	ret = min_t(int, cpumask_weight(cpu_possible_mask), vecs);
>  	put_online_cpus();
> -	return ret;
> +
> +	for (i = 0, set_vecs = 0;  i < affd->nr_sets; i++)
> +		set_vecs += affd->sets[i];
> +
> +	return resv + max(ret, set_vecs);
>  }

This is looking pretty good, but we may risk getting into an infinite
loop in __pci_enable_msix_range() if we're requesting too many vectors
in a set: the above code may continue returning set_vecs, overriding
the reduced nvec that pci requested, and pci msix initialization will
continue to fail because it is repeatedly requesting to activate the
same vector count that failed before.
