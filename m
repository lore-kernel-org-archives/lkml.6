Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98751C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 09:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CD9220839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 09:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="OSSDbh3p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CD9220839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbeIKOdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 10:33:33 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37070 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbeIKOdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 10:33:33 -0400
Received: by mail-ed1-f67.google.com with SMTP id a20-v6so18708725edd.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 02:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mxIiK9oZkBFPnxjb/Wh9/HRumnuxC2N69y1qwK1GLf0=;
        b=OSSDbh3p3oi10hDsfZk/1vFWNYuQaPnHka9+AqSVJKcZvlUBIabhF+GeQyBCNGrYrq
         /+99gI7Bew0nw+BP7VXQEVbZgtAQgb8kcakX+NR9zJzOz89EPb3LuByrTbXl1KkIlwC5
         FOwBc07B31TrgOPgtDy6B8R5lgbNPULR/ZcbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mxIiK9oZkBFPnxjb/Wh9/HRumnuxC2N69y1qwK1GLf0=;
        b=HM7ZsHLE5Vp+LcG2BBAEltsGhum8tjaGHXYhgfxLU+nYt/bJuVb2991RGg7zmDhtMd
         G26pkW0bjJ4yRxaRyxV2XzFY4w/HDSdTX3ORVJHeQlqr8ziGykdDc6AyNKwjhIi4VILj
         bosLHqbqMDEJFGr71ZYsDx00wunuE57JbaApL+M9pQnSl3qdYvYRH79kbhpqzdS9Z0B/
         PRiDQlqxlgVgMEp+0whT3Kmkz69TGySGe2PUttUtEFujoSiGVTS6kdf0Q772D0q/2VlV
         xz9j0RG1oBCXTkFaYLpwMqjy4G1z0cyQhP3rlWba+zVUcWIbsC4em0TL/ImGZMMGK2d3
         m+nw==
X-Gm-Message-State: APzg51CJ7gSLb5JRaphwKsHoL5Lh3im9w7pQIuVCRZgzvWk5tvL26h3v
        L+Tth6OaBfDp32XakRoBcSqHLA==
X-Google-Smtp-Source: ANB0VdZU/HCpNP8sYP4eGg3AAkEiwSTEXSAcGU+54bN4oFr93HrUTyxkCsp5XsKWNPWqLsXwObd2Vg==
X-Received: by 2002:a50:af03:: with SMTP id g3-v6mr28514971edd.220.1536658503239;
        Tue, 11 Sep 2018 02:35:03 -0700 (PDT)
Received: from andrea (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id p28-v6sm13963903eda.85.2018.09.11.02.35.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 02:35:02 -0700 (PDT)
Date:   Tue, 11 Sep 2018 11:34:56 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     Patrick Bellasi <patrick.bellasi@arm.com>, peterz@infradead.org,
        rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, gregkh@linuxfoundation.org,
        mingo@redhat.com, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        thara.gopinath@linaro.org, viresh.kumar@linaro.org,
        tkjos@google.com, joel@joelfernandes.org, smuckle@google.com,
        adharmap@codeaurora.org, skannan@codeaurora.org,
        pkondeti@codeaurora.org, juri.lelli@redhat.com,
        edubezval@gmail.com, srinivas.pandruvada@linux.intel.com,
        currojerez@riseup.net, javi.merino@kernel.org
Subject: Re: [PATCH v6 03/14] PM: Introduce an Energy Model management
 framework
Message-ID: <20180911093456.GA27352@andrea>
References: <20180820094420.26590-1-quentin.perret@arm.com>
 <20180820094420.26590-4-quentin.perret@arm.com>
 <20180829100435.GP2960@e110439-lin>
 <20180829132811.iacfltcos6kfgp7e@queper01-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180829132811.iacfltcos6kfgp7e@queper01-lin>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quentin,

> > 1. use of a single memory barrier
> > 
> >    Since we are already em_pd_mutex protected, i.e. there cannot be a
> >    concurrent writers, we can use one single memory barrier after the
> >    loop, i.e.
> > 
> >         for_each_cpu(cpu, span)
> >                 WRITE_ONCE()
> >         smp_wmb()
> > 
> >    which should be just enough to ensure that all other CPUs will see
> >    the pointer set once we release the mutex
> 
> Right, I'm actually wondering if the memory barrier is needed at all ...
> The mutex lock()/unlock() should already ensure the ordering I want no ?
> 
> WRITE_ONCE() should prevent load/store tearing with concurrent em_cpu_get(),
> and the release/acquire semantics of mutex lock/unlock should be enough to
> serialize the memory accesses of concurrent em_register_perf_domain() calls
> properly ...
> 
> Hmm, let me read memory-barriers.txt again.

FYI, the directory "tools/memory-model/" provides an "automated
memory-barriers.txt": in short, you encode your "memory ordering
questions" into "litmus tests" to be passed to the tool/simulator;
the tool will then answer with "Yes/No" (plus other information).

Some preparation is required to set up and learn how to use the
LKMM tools, but once there, I expect them to be more "efficient"
than reading memory-barriers.txt... ;-)  Please don't hesitate
to contact me/the LKMM maintainers if you need help with this.

You'd need some info in order to write down a _well-formed litmus
test, e.g., matching barrier/synchronization and interested memory
accesses on the reader side (IAC, the replacement "store-release
-> store-once+smp_wmb" discussed above is suspicious...).

  Andrea
