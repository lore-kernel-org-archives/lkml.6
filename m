Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49FC513F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 09:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E909820881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 09:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jzzhH8B2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E909820881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbeG3LBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 07:01:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60614 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbeG3LBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 07:01:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HYDSQN4mAQ3H4EsrgJB32bDXDJ9yCou2uSFG0BVCPiE=; b=jzzhH8B20gDxADtWKDwNLjHGP
        unG/+NC2xkiqAMNnEZaAv/w1XvK3MELmllV7hrVX/ets+zJ+EgsruWr8cv631wykuVQpkWJ6oPBUI
        TpRn99gnqgRLZvC0Ufn0pLffRzwBtBUVsGgDseKgKt+OeAff6s0GnpKBYWu1vVF8ycGctROU9gD5Q
        FjqZuPQGTvRKNcRQU1pXRm+DjKBqgJZDeE8UngRWya3vtaBoTfCxUNgHCcs7C51Bq8gfvKULwOXd7
        l8r9eJPJBLeYc+2/b/XkOJtzMGW4N8KeKvs17Qg4gxB2fqRilRfc5f1YVDGBlzHjyJtA622RqFVhH
        IbUmscRpA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fk4Sg-0000tI-EN; Mon, 30 Jul 2018 09:27:30 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E7D6420268325; Mon, 30 Jul 2018 11:27:28 +0200 (CEST)
Date:   Mon, 30 Jul 2018 11:27:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mike Galbraith <efault@gmx.de>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [rt-patch 3/3] arm, KVM: convert vgic_irq.irq_lock to
 raw_spinlock_t
Message-ID: <20180730092728.GE2494@hirez.programming.kicks-ass.net>
References: <20180727215710.zq6gkoqzlb4ca7qv@linutronix.de>
 <1532764179.9882.14.camel@gmx.de>
 <1532768853.9882.73.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532768853.9882.73.camel@gmx.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 28, 2018 at 11:07:33AM +0200, Mike Galbraith wrote:
> 
> b103cc3f10c0 ("KVM: arm/arm64: Avoid timer save/restore in vcpu entry/exit")
> requires vgic_irq.irq_lock be converted to raw_spinlock_t.
> 
> Problem: kvm_preempt_ops.sched_in = kvm_sched_in;
>    kvm_sched_in()
>       kvm_arch_vcpu_load()
>          kvm_timer_vcpu_load() <- b103cc3f10c0 addition
>             kvm_timer_vcpu_load_gic()
>                kvm_vgic_map_is_active()
>                   spin_lock_irqsave(&irq->irq_lock, flags);
> 
> Quoting virt/kvm/arm/vgic/vgic.c, locking order is...
> 
>   kvm->lock (mutex)
>     its->cmd_lock (mutex)
>       its->its_lock (mutex)
>         vgic_cpu->ap_list_lock         must be taken with IRQs disabled
>           kvm->lpi_list_lock           must be taken with IRQs disabled
>             vgic_irq->irq_lock         must be taken with IRQs disabled
> 
> ...meaning vgic_dist.lpi_list_lock and vgic_cpu.ap_list_lock must be
> converted as well.

The thing missing from the Changelog is the analysis that all the work
done under these locks is indeed properly bounded and cannot cause
excessive latencies.
