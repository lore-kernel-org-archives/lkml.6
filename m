Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 634A7C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 07:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 273BC20652
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 07:56:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 273BC20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbeIFMap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 08:30:45 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:32821 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbeIFMap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 08:30:45 -0400
Received: from p4fea45ac.dip0.t-ipconnect.de ([79.234.69.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fxp9U-0008Sz-I7; Thu, 06 Sep 2018 09:56:32 +0200
Date:   Thu, 6 Sep 2018 09:56:32 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     pheragu@codeaurora.org
cc:     linux-kernel@vger.kernel.org, ckadabi@codeaurora.org,
        tsoni@codeaurora.org, bryanh@codeaurora.org,
        Prasad Sodagudi <psodagud@codeaurora.org>
Subject: Re: [PATCH] genirq: Avoid race between cpu hot plug and irq_desc()
 allocation paths
In-Reply-To: <819e8a811ebf49366d75676922903368@codeaurora.org>
Message-ID: <alpine.DEB.2.21.1809060947000.1416@nanos.tec.linutronix.de>
References: <1536167131-20585-1-git-send-email-pheragu@codeaurora.org> <alpine.DEB.2.21.1809052022110.1416@nanos.tec.linutronix.de> <819e8a811ebf49366d75676922903368@codeaurora.org>
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

On Wed, 5 Sep 2018, pheragu@codeaurora.org wrote:

> On 2018-09-05 11:23, Thomas Gleixner wrote:
> > On Wed, 5 Sep 2018, Prakruthi Deepak Heragu wrote:
> > 
> > > One of the cores might have just allocated irq_desc() and other core
> > > might be doing irq migration in the hot plug path. In the hot plug path
> > > during the IRQ migration, for_each_active_irq macro is trying to get
> > > irqs whose bits are set in allocated_irqs bit map but there is no return
> > > value check after irq_to_desc for desc validity.
> > 
> > Confused. All parts involved, irq allocation/deallocation and the CPU
> > hotplug code take sparse_irq_lock to prevent exavtly that.
> > 
> Removing the NULL pointer check and adding this sparse_irq_lock
> that you suggested will solve this issue. The code looks like
> this now. Is this okay?

No, it's not okay at all. You _CANNOT_ take sparse_irq_lock() there.

I wrote that _ALL_ parts take that lock already. Care to look at the code?

takedown_cpu()
{
 	/*
	 * Prevent irq alloc/free while the dying cpu reorganizes the
         * interrupt affinities.
         */
        irq_lock_sparse();

        /*
         * So now all preempt/rcu users must observe !cpu_active().
         */
	err = stop_machine_cpuslocked(take_cpu_down, NULL, cpumask_of(cpu));

and __cpu_disable() which in turn calls irq_migrate_all_off_this_cpu() is
called from take_cpu_down(). So this deadlocks in any case.

I have no idea what kind of modifications you have in your kernel which
make

   1) The thing explode in the first place

   2) Not immediately deadlock with that hack you just sent

and honestly I don't want to know at all.

Thanks,

	tglx
