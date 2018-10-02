Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C2DC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 19:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CAB8205C9
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 19:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="OTIzihsK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CAB8205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbeJCB5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 21:57:19 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46617 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbeJCB5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 21:57:19 -0400
Received: by mail-ed1-f68.google.com with SMTP id g32-v6so3073253edg.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 12:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ra+GoEMQmzFEAVO1u2FBW8dITr+pQqftJOFKpb+Zgec=;
        b=OTIzihsKGOwijcMH675JbT7pIw0q7ANJDaDCwojbf14LZx8rlfomJ3D0xk3kKcXeir
         fXOD2KLB6CbN5CR0EIeIp3QYjJ6WrrqC8/iXKioC9fUajTaAT2h+406AnX/BqllrffxZ
         aIX2MddrnxKUZcgSXMQSxNpEs6PTVTFAQwnb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ra+GoEMQmzFEAVO1u2FBW8dITr+pQqftJOFKpb+Zgec=;
        b=Eu3gkWSAjOJ3bv3YYds3KzcyntaDUMiaxlnckgkVBruJWehswoIjY2pdqH5IcCaZjC
         aVYi5vC1oOZeZbikHNC7T2dmSTyI3qPOkJ9Fm8GW0PBkVXDb2MItUH+SxqAfYkNM52nC
         ho3Mw6NErn0rQCZebpDNyzc3eqDrHuYPLsktFu5ky55DTjgtACoFLCwJFATWUJhPj+Wj
         lJiSK4pV7brVI0AsE4caNq+x+TAk9ZGVOUD6riB5OCLEqLG4b7BcrYcc0Xa6ERT5vjic
         jTSXuttAoajURjT9elmHusFmy0iuG00l7qj3JIoIsm70pMGcM8LZ0NAbXw47cjiWPQ0C
         UjFQ==
X-Gm-Message-State: ABuFfoitrLfnLhOXUZ3avS5h6QId64asNm8Cx1v6eq43Bqk0ZESWaGE9
        aulbRReW9IZVmiacf8Dq9m953g==
X-Google-Smtp-Source: ACcGV624yJo9cNCHNyRy0J5ineNFFvg74/EDE9lXjyF/4MnwsppoibQERSf6nMNW9KTWLowltdthQg==
X-Received: by 2002:a17:906:f87:: with SMTP id q7-v6mr9585169ejj.25.1538507545945;
        Tue, 02 Oct 2018 12:12:25 -0700 (PDT)
Received: from andrea (15.152.230.94.awnet.cz. [94.230.152.15])
        by smtp.gmail.com with ESMTPSA id e5-v6sm2871732ejc.47.2018.10.02.12.12.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 12:12:25 -0700 (PDT)
Date:   Tue, 2 Oct 2018 21:12:17 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        gregkh@linuxfoundation.org, mingo@redhat.com,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        chris.redpath@arm.com, patrick.bellasi@arm.com,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        thara.gopinath@linaro.org, viresh.kumar@linaro.org,
        tkjos@google.com, joel@joelfernandes.org, smuckle@google.com,
        adharmap@codeaurora.org, skannan@codeaurora.org,
        pkondeti@codeaurora.org, juri.lelli@redhat.com,
        edubezval@gmail.com, srinivas.pandruvada@linux.intel.com,
        currojerez@riseup.net, javi.merino@kernel.org
Subject: Re: [PATCH v7 03/14] PM: Introduce an Energy Model management
 framework
Message-ID: <20181002191217.GA4160@andrea>
References: <20180912091309.7551-1-quentin.perret@arm.com>
 <20180912091309.7551-4-quentin.perret@arm.com>
 <20181002123031.GZ3439@hirez.programming.kicks-ass.net>
 <20181002125115.245r3ocusvyiexno@queper01-lin>
 <20181002134857.GE26858@hirez.programming.kicks-ass.net>
 <20181002140430.fpeiqzblbcaewg6n@queper01-lin>
 <20181002142924.GI26858@hirez.programming.kicks-ass.net>
 <20181002144025.wnanxibhdcnl23sf@queper01-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002144025.wnanxibhdcnl23sf@queper01-lin>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 03:40:28PM +0100, Quentin Perret wrote:
> On Tuesday 02 Oct 2018 at 16:29:24 (+0200), Peter Zijlstra wrote:
> > On Tue, Oct 02, 2018 at 03:05:23PM +0100, Quentin Perret wrote:
> > > On Tuesday 02 Oct 2018 at 15:48:57 (+0200), Peter Zijlstra wrote:
> > > > +/**
> > > > + * em_cpu_get() - Return the performance domain for a CPU
> > > > + * @cpu : CPU to find the performance domain for
> > > > + *
> > > > + * Return: the performance domain to which 'cpu' belongs, or NULL if it doesn't
> > > > + * exist.
> > > > + */
> > > > +struct em_perf_domain *em_cpu_get(int cpu)
> > > > +{
> > > > +       return READ_ONCE(per_cpu(em_data, cpu));
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(em_cpu_get);
> > > > 
> > > > But your read side doesn't take, not is required to take em_pd_mutex.
> > > > 
> > > > At that point, the mutex_unlock() doesn't guarantee anything.
> > > > 
> > > > A CPU observing the em_data store, doesn't need to observe the store
> > > > that filled the data structure it points to.
> > > 
> > > Right but even if I add the smp_store_release(), I can still have a
> > > CPU observing em_data while another is in the process of updating it.
> > > So, if smp_store_release() doesn't guarantee that readers will see a
> > > complete update, do I actually get something interesting from it ?
> > > (That's not a rhetorical question, I'm actually wondering :-)
> > 
> > I thought the update would fail if em_data was already set.
> > 
> > That is, you can only set this thing up _once_ and then you'll have to
> > forever live with it.
> > 
> > Or did I read that wrong?
> 
> No no, that's correct. em_data is populated once and kept as-is
> forever.
> 
> What I was trying to say is, when em_data is being populated for the
> first time, nothing prevents a reader from using em_cpu_get()
> concurrently. And in this case, it doesn't matter if you use
> smp_store_release() or not, the reader might see the table half-updated.
> 
> So, basically, smp_store_release() doesn't guarantee that readers won't
> see a half-baked em_data. That's the point I'm trying to make at least :-)

An example might help clarify this: here is a scenario I can _imagine,
based on your description.

CPU0 (em_register_perf_domain())	CPU1 (reader)

[...]					my_pd = READ_ONCE(per_cpu(em_data, 1)); /* em_cpu_get() */
pd->table = table			if (my_pd)
WRITE_ONCE(per_cpu(em_data, 1), pd);		my_table = my_pd->table; /* process, dereference, ... my_table */

In this scenario, we'd like CPU1 to see CPU0's store to ->table (as well
as the stores to table[]) _if CPU1 sees CPU0's store to em_data (that is,
if my_pd != NULL).

This guarantee does not hold with the WRITE_ONCE(), because CPU0 could
propagate the store to ->table and the store to em_data out-of-order.
The smp_store_release(), together with the address dependency headed by
the READ_ONCE(), provides this guarantee (and more...).

(Enclosing the reader into an em_pd_mutex critical section would also
provide this guarantee, but I can imagine a few arguments for not using
a mutex... ;-) ).

The question, I guess, is whether you want such a guarantee.

  Andrea
