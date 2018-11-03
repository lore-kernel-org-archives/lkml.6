Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E82C0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 17:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D89E20833
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 17:16:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D89E20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbeKDC1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 22:27:51 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:60296 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbeKDC1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 22:27:51 -0400
Received: from p5492fe24.dip0.t-ipconnect.de ([84.146.254.36] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gIzWf-0006Vv-Tx; Sat, 03 Nov 2018 18:15:58 +0100
Date:   Sat, 3 Nov 2018 18:15:57 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Long Li <longli@microsoft.com>
cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] genirq/matrix: Choose CPU for managed IRQs based on
 how many of them are allocated
In-Reply-To: <alpine.DEB.2.21.1811031604540.3160@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1811031815080.3160@nanos.tec.linutronix.de>
References: <20181102003412.28229-1-longli@linuxonhyperv.com> <alpine.DEB.2.21.1811031604540.3160@nanos.tec.linutronix.de>
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

On Sat, 3 Nov 2018, Thomas Gleixner wrote:
> On Fri, 2 Nov 2018, Long Li wrote:
> >  /**
> >   * irq_matrix_assign_system - Assign system wide entry in the matrix
> >   * @m:		Matrix pointer
> > @@ -269,7 +291,7 @@ int irq_matrix_alloc_managed(struct irq_matrix *m, const struct cpumask *msk,
> >  	if (cpumask_empty(msk))
> >  		return -EINVAL;
> >  
> > -	cpu = matrix_find_best_cpu(m, msk);
> > +	cpu = matrix_find_best_cpu_managed(m, msk);
> >  	if (cpu == UINT_MAX)
> >  		return -ENOSPC;
> >  
> > @@ -282,6 +304,7 @@ int irq_matrix_alloc_managed(struct irq_matrix *m, const struct cpumask *msk,
> >  		return -ENOSPC;
> >  	set_bit(bit, cm->alloc_map);
> >  	cm->allocated++;
> > +	cm->managed_allocated++;
> >  	m->total_allocated++;
> >  	*mapped_cpu = cpu;
> >  	trace_irq_matrix_alloc_managed(bit, cpu, m, cm);
> 
> so far so good. But what exactly decrements managed_allocated ?

Another thing. If we add that counter, then it would be good to expose it
in the debugfs files as well.

Thanks,

	tglx
