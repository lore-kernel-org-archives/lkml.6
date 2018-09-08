Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F25C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 09:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5753A20869
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 09:59:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5753A20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbeIHOof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 10:44:35 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:37443 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbeIHOof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 10:44:35 -0400
Received: from p4fea45ac.dip0.t-ipconnect.de ([79.234.69.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fya1P-0005uL-T9; Sat, 08 Sep 2018 11:59:20 +0200
Date:   Sat, 8 Sep 2018 11:59:19 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Dou Liyang <dou_liyang@163.com>
cc:     linux-kernel@vger.kernel.org, x86@kernel.org, mingo@redhat.com,
        hpa@zytor.com, douly.fnst@cn.fujitsu.com
Subject: Re: [PATCH v2 1/2] irq/matrix: Split out the CPU finding code into
 a helper
In-Reply-To: <20180908070037.31154-1-dou_liyang@163.com>
Message-ID: <alpine.DEB.2.21.1809081155280.1402@nanos.tec.linutronix.de>
References: <20180908070037.31154-1-dou_liyang@163.com>
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

On Sat, 8 Sep 2018, Dou Liyang wrote:
> +/* Find the best CPU which has the lowest vector allocation count */
> +static int matrix_find_best_cpu(struct irq_matrix *m,
> +				const struct cpumask *msk, int *best_cpu)
> +{
> +	unsigned int cpu, maxavl = 0;
> +	struct cpumap *cm;
> +
> +	for_each_cpu(cpu, msk) {
> +		cm = per_cpu_ptr(m->maps, cpu);
> +
> +		if (!cm->online || cm->available <= maxavl)
> +			continue;
> +
> +		*best_cpu = cpu;
> +		maxavl = cm->available;
> +	}
> +
> +	return maxavl;

This return value makes no sense whatsoever. Why not doing the obvious

static unsigned int matrix_find_best_cpu(struct irq_matrix *m,
	                             	 const struct cpumask *msk)
{
	unsigned int cpu, best_cpu, maxavl = 0;

	best_cpu = UINT_MAX;
	.....
	return best_cpu;
}

and at the call site:

       cpu = matrix_find_best_cpu();
       if (cpu == UINT_MAX)
       		return -ENOSPC;

Hmm?

> +	cm = per_cpu_ptr(m->maps, best_cpu);
> +	bit = matrix_alloc_area(m, cm, 1, false);
> +	if (bit < m->alloc_end) {

So if you're removing one indentation level, then it'd be consequent to
remove this one as well while at it :)

Thanks,

	tglx
