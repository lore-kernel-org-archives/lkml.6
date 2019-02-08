Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6817DC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 18:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3683B2081B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 18:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbfBHSrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 13:47:55 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:45306 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbfBHSrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 13:47:55 -0500
Received: from p5492e0d8.dip0.t-ipconnect.de ([84.146.224.216] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gsBBm-0001HT-Gb; Fri, 08 Feb 2019 19:47:50 +0100
Date:   Fri, 8 Feb 2019 19:47:43 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Kan Liang <kan.liang@linux.intel.com>
cc:     peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, eranian@google.com, jolsa@redhat.com,
        namhyung@kernel.org, ak@linux.intel.com, luto@amacapital.net,
        vbabka@suse.cz, will.deacon@arm.com, kirill@shutemov.name
Subject: Re: [PATCH V5 02/14] perf/x86: Add perf_get_page_size support
In-Reply-To: <1549648509-12704-2-git-send-email-kan.liang@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1902081940050.1662@nanos.tec.linutronix.de>
References: <1549648509-12704-1-git-send-email-kan.liang@linux.intel.com> <1549648509-12704-2-git-send-email-kan.liang@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Feb 2019, kan.liang@linux.intel.com wrote:
> +u64 perf_get_page_size(u64 virt)
> +{
> +	unsigned long flags;
> +	unsigned int level;
> +	pte_t *pte;
> +
> +	if (!virt)
> +		return 0;
> +
> +	/*
> +	 * Interrupts are disabled, so it prevents any tear down
> +	 * of the page tables.
> +	 * See the comment near struct mmu_table_batch.
> +	 */
> +	local_irq_save(flags);
> +	if (virt >= TASK_SIZE)
> +		pte = lookup_address(virt, &level);
> +	else {
> +		if (current->mm) {
> +			pte = lookup_address_in_pgd(pgd_offset(current->mm, virt),
> +						    virt, &level);
> +		} else
> +			level = PG_LEVEL_NUM;
> +	}

This still lacks quite some curly brackets and aside of that you can write
that so it becomes readable:

	if (virt >= TASK_SIZE)
		pte = lookup_address(virt, &level);
	} else if (current->mm) {
  		pte = lookup_address_in_pgd(pgd_offset(current->mm, virt),
						       virt, &level);
	} else
		level = PG_LEVEL_NUM;
	}


> +	local_irq_restore(flags);
> +	if (level >= PG_LEVEL_NUM)
> +		return 0;
> +
> +	return (u64)page_level_size(level);
> +}
> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> index e9acf1d..720dc9e 100644
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c
> @@ -1274,7 +1274,8 @@ static void setup_pebs_sample_data(struct perf_event *event,
>  	}
>  
>  
> -	if ((sample_type & (PERF_SAMPLE_ADDR | PERF_SAMPLE_PHYS_ADDR)) &&
> +	if ((sample_type & (PERF_SAMPLE_ADDR | PERF_SAMPLE_PHYS_ADDR
> +			    | PERF_SAMPLE_DATA_PAGE_SIZE)) &&
>  	    x86_pmu.intel_cap.pebs_format >= 1)

Can you please define a mask from those constants and use that instead of
adding this ugly line break.

Thanks,

	tglx
