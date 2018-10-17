Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC401C5ACCC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 00:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DDF3205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 00:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="fK+pEaVf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DDF3205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbeJQIs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 04:48:28 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39998 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbeJQIs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 04:48:28 -0400
Received: by mail-pf1-f195.google.com with SMTP id g21-v6so5297106pfi.7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 17:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QAEhVvk8if2elCJKEfIpPWN5iSU2q7nxmCcuwrLcMlQ=;
        b=fK+pEaVfAXq4Ehl2b/rOH8bCQg8coBuilzm/E5j80CTlSH8VdfjUiAJVsyBoy0WfIG
         5pq+VJkNGwxBairUNse2qlzxunQTKDlG9U2UrxFD9CBZhUD1cu/xChJ0jCOrvYjsTQww
         R9tSrXr+UmjxyCO4d0fhOBfbeXODiaFWhsj2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QAEhVvk8if2elCJKEfIpPWN5iSU2q7nxmCcuwrLcMlQ=;
        b=Dl4fBxHeWVedbGfBFrMcupHAiA6H2n8MLKicP+20bf9ad7AbfPqSA8RbMgut3+cRcu
         CpvKPpwEf7VURIh9lQ+75TEHhqY2nYOlIfXIAv2EMroZb7BaR3K18xuD00Lo6Nl9gGfG
         UOo1OfDswXvyfF2E0+ougNdBILoZWIoc3c99qqcCkmLCcQTguycNlAFlxcob1X9n6FWM
         tVMzAOMBob53QeEvw4XGPgXYfgR/YNZl7zXfbIRROiSdunOFCuxVfmqs3g+gTTKVDOJb
         BVkO3Atw9f74AWVrKrOO8Oj6SZ+gPVrNTcsLFWuyXHUdHjEITbG3K9itHNu0C2HgqnVU
         VeTA==
X-Gm-Message-State: ABuFfoiG/R0GaeyyRuIJD0FwqOVkn2qd2iyqmPdwkptGDo4gx8UMSzai
        ObfO+qYXGvhRENlQ/TkT6bh18A==
X-Google-Smtp-Source: ACcGV61dK7cRDV/fwdS0W38VVcQNder/Ww0Q43VeN/dwKoBgzthNu4GpgU6zGr+5pkb71qGkEL6NAg==
X-Received: by 2002:a62:1906:: with SMTP id 6-v6mr24855127pfz.9.1539737722951;
        Tue, 16 Oct 2018 17:55:22 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id i184-v6sm21492680pfg.88.2018.10.16.17.55.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 17:55:21 -0700 (PDT)
Date:   Tue, 16 Oct 2018 17:55:20 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Frederic Weisbecker <frederic@kernel.org>
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
Message-ID: <20181017005520.GA146369@joelaf.mtv.corp.google.com>
References: <1539213137-13953-1-git-send-email-frederic@kernel.org>
 <1539213137-13953-13-git-send-email-frederic@kernel.org>
 <20181016052844.GA25151@joelaf.mtv.corp.google.com>
 <20181017004419.GA24723@lerouge>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181017004419.GA24723@lerouge>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 02:44:19AM +0200, Frederic Weisbecker wrote:
> On Mon, Oct 15, 2018 at 10:28:44PM -0700, Joel Fernandes wrote:
> > > diff --git a/crypto/pcrypt.c b/crypto/pcrypt.c
> > > index f8ec3d4..490358c 100644
> > > --- a/crypto/pcrypt.c
> > > +++ b/crypto/pcrypt.c
> > > @@ -73,12 +73,13 @@ struct pcrypt_aead_ctx {
> > >  static int pcrypt_do_parallel(struct padata_priv *padata, unsigned int *cb_cpu,
> > >  			      struct padata_pcrypt *pcrypt)
> > >  {
> > > +	unsigned int bh;
> > >  	unsigned int cpu_index, cpu, i;
> > >  	struct pcrypt_cpumask *cpumask;
> > >  
> > >  	cpu = *cb_cpu;
> > >  
> > > -	rcu_read_lock_bh();
> > > +	bh = rcu_read_lock_bh();
> > >  	cpumask = rcu_dereference_bh(pcrypt->cb_cpumask);
> > >  	if (cpumask_test_cpu(cpu, cpumask->mask))
> > >  			goto out;
> > > @@ -95,7 +96,7 @@ static int pcrypt_do_parallel(struct padata_priv *padata, unsigned int *cb_cpu,
> > >  	*cb_cpu = cpu;
> > >  
> > >  out:
> > > -	rcu_read_unlock_bh();
> > > +	rcu_read_unlock_bh(bh);
> > >  	return padata_do_parallel(pcrypt->pinst, padata, cpu);
> > >  }
> > 
> > This complicates the RCU API for -bh and doesn't look pretty at all. Is there
> > anything better we can do so we don't have to touch existing readers at all?
> 
> Indeed, so I'm going to give up with the idea of converting all the callers
> in once, this is unmaintainable anyway. I'll keep the RCU API as is for now,
> ie: disable all softirqs, and we'll see later if we need per vector granularity.
> Surely that would be too fun to handle, with per vector quiescent states and grace
> periods ;-)

Cool, sounds good.

> > 
> > Also, I thought softirqs were kind of a thing of the past, and threaded
> > interrupts are the more preferred interrupt bottom halves these days,
> > especially for -rt. Maybe that was just wishful thinking on my part :-)
> 
> We all wish that. I think it was the plan but threaded IRQs involve context
> switches and IIUC it's the border that's hard to cross on some performance
> measurements.

Ok, thanks.

- Joel

