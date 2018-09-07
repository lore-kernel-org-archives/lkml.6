Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC1EC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 12:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA72D2077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 12:47:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA72D2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729537AbeIGR2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 13:28:18 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:36204 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbeIGR2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 13:28:18 -0400
Received: from p4fea45ac.dip0.t-ipconnect.de ([79.234.69.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fyGAY-0001gW-3c; Fri, 07 Sep 2018 14:47:26 +0200
Date:   Fri, 7 Sep 2018 14:47:25 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Dou Liyang <dou_liyang@163.com>
cc:     linux-kernel@vger.kernel.org, x86@kernel.org, mingo@redhat.com,
        hpa@zytor.com, douly.fnst@cn.fujitsu.com
Subject: Re: [PATCH 2/2] irq/matrix: Spread managed interrupts on
 allocation
In-Reply-To: <20180907082509.11083-2-dou_liyang@163.com>
Message-ID: <alpine.DEB.2.21.1809071445580.1402@nanos.tec.linutronix.de>
References: <20180907082509.11083-1-dou_liyang@163.com> <20180907082509.11083-2-dou_liyang@163.com>
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

On Fri, 7 Sep 2018, Dou Liyang wrote:
> -int irq_matrix_alloc_managed(struct irq_matrix *m, unsigned int cpu)
> +int irq_matrix_alloc_managed(struct irq_matrix *m, const struct cpumask *msk,
> +				unsigned int *mapped_cpu)
>  {
> -	struct cpumap *cm = per_cpu_ptr(m->maps, cpu);
>  	unsigned int bit, end = m->alloc_end;
> +	unsigned int best_cpu = UINT_MAX;
> +	struct cpumap *cm;
>  
> -	/* Get managed bit which are not allocated */
> -	bitmap_andnot(m->scratch_map, cm->managed_map, cm->alloc_map, end);
> -	bit = find_first_bit(m->scratch_map, end);
> -	if (bit >= end)
> -		return -ENOSPC;
> -	set_bit(bit, cm->alloc_map);
> -	cm->allocated++;
> -	m->total_allocated++;
> -	trace_irq_matrix_alloc_managed(bit, cpu, m, cm);
> -	return bit;
> +	if (matrix_find_best_cpu(m, msk, &best_cpu)) {

You can avoid that churn and the extra indentation by simply doing:

	if (!matrix_find_best_cpu(m, msk, &best_cpu))
		return -ENOSPC;

Hmm?

Thanks,

	tglx
