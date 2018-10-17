Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D24C5ACCC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 00:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19389214C3
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 00:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0GG2Rqi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19389214C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbeJQIhZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 04:37:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:34774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727348AbeJQIhZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 04:37:25 -0400
Received: from localhost (LFbn-NCY-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04A8821471;
        Wed, 17 Oct 2018 00:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539737062;
        bh=fXrre6KmyUt6DvzZFb2ekMe6P8ZBDZAx8KUYSYc8KEo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S0GG2RqiRJ0S2PHBhR6QeWdxLEsIXXQFFWFyp8O0Ol/xiKie4YffWMwpCtP3mn+Id
         QXpMvu95LM6SlhlKzb4mcyTyYrll8+ilPY9fjlHMnm7M/mGcek4wuT+sMAhU9S2ZVq
         RzlBl0orLGk0WJtVxGzoUOIedYOcyyEobcFbkQHc=
Date:   Wed, 17 Oct 2018 02:44:19 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        rostedt@goodmis.org
Subject: Re: [RFC PATCH 12/30] rcu: Prepare rcu_read_[un]lock_bh() for
 handling softirq mask
Message-ID: <20181017004419.GA24723@lerouge>
References: <1539213137-13953-1-git-send-email-frederic@kernel.org>
 <1539213137-13953-13-git-send-email-frederic@kernel.org>
 <20181016052844.GA25151@joelaf.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016052844.GA25151@joelaf.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 10:28:44PM -0700, Joel Fernandes wrote:
> > diff --git a/crypto/pcrypt.c b/crypto/pcrypt.c
> > index f8ec3d4..490358c 100644
> > --- a/crypto/pcrypt.c
> > +++ b/crypto/pcrypt.c
> > @@ -73,12 +73,13 @@ struct pcrypt_aead_ctx {
> >  static int pcrypt_do_parallel(struct padata_priv *padata, unsigned int *cb_cpu,
> >  			      struct padata_pcrypt *pcrypt)
> >  {
> > +	unsigned int bh;
> >  	unsigned int cpu_index, cpu, i;
> >  	struct pcrypt_cpumask *cpumask;
> >  
> >  	cpu = *cb_cpu;
> >  
> > -	rcu_read_lock_bh();
> > +	bh = rcu_read_lock_bh();
> >  	cpumask = rcu_dereference_bh(pcrypt->cb_cpumask);
> >  	if (cpumask_test_cpu(cpu, cpumask->mask))
> >  			goto out;
> > @@ -95,7 +96,7 @@ static int pcrypt_do_parallel(struct padata_priv *padata, unsigned int *cb_cpu,
> >  	*cb_cpu = cpu;
> >  
> >  out:
> > -	rcu_read_unlock_bh();
> > +	rcu_read_unlock_bh(bh);
> >  	return padata_do_parallel(pcrypt->pinst, padata, cpu);
> >  }
> 
> This complicates the RCU API for -bh and doesn't look pretty at all. Is there
> anything better we can do so we don't have to touch existing readers at all?

Indeed, so I'm going to give up with the idea of converting all the callers
in once, this is unmaintainable anyway. I'll keep the RCU API as is for now,
ie: disable all softirqs, and we'll see later if we need per vector granularity.
Surely that would be too fun to handle, with per vector quiescent states and grace
periods ;-)

> 
> Also, I thought softirqs were kind of a thing of the past, and threaded
> interrupts are the more preferred interrupt bottom halves these days,
> especially for -rt. Maybe that was just wishful thinking on my part :-)

We all wish that. I think it was the plan but threaded IRQs involve context
switches and IIUC it's the border that's hard to cross on some performance
measurements.
