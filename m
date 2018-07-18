Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E8CECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 22:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 066152084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 22:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="QKc+oagR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 066152084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729832AbeGRWst (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 18:48:49 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:43005 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729221AbeGRWss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 18:48:48 -0400
Received: by mail-yb0-f195.google.com with SMTP id c10-v6so2478816ybf.9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 15:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8FZn5tD2SDlpbmPv1h30BRNTXCLS4iiwX2enbFu/UTs=;
        b=QKc+oagRIRFxaoHWLeUiQvvuHMgci7IB6E2rZmik09n+2ysSUM7loPzfx3v+K3bb4S
         OzutDeSQtn+Ut+kp9nwPScKZUhrU9x6coXmcMU7SnxDDcdQzFNGXGHgSLHzAXWdc/2tl
         SaMWFgNf95alHxpuIW/f6lY8czF3HhaXGxiZm+Yewy2HF8RjCp/7HRAtycS31gl1I4Uk
         ZeYMWDUAdcwJhcO1rcr+jzCAOSVIMthgYN+8DrNhelW+L1tmZdxIwVFMyKXnx3Un9aAK
         BU1BDX3ZRVfPcZluxJFRq6fKZmOmNCtGe5ILgwOb5gL/6Z/E94qEiGlR9ejdFXncnOYx
         wKqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8FZn5tD2SDlpbmPv1h30BRNTXCLS4iiwX2enbFu/UTs=;
        b=O7jd/l8UcwQNYxejnI003itxbifm2T8++j6rOebJv+7TIMqKfJ+hFVEPMOfqUZe7Il
         RDvRobsXGVSs5LKgTZRF7MIN9EN+8hjb7J5KY97GXsabyOgT9of2ItiNLDUpN4T4Nv69
         FeVN54wT/MTOYoU0TJMGLlUfR3rpvYdY8Y+Y6Lu2SphvB/XEP23pX6GX0sdgLlmBXDaR
         65cw4ATIaqyVUf9o1hhkOalc23vbB/WE/GNWTPmqIbnLB8ICNN+po9y/q/27AUKvShNK
         ywqiRk+XZAiPkSVyvlwCRbUczzTXy8oSXCyDpLGG/K6O3F+NTcLk5a/aKqLWFfST2fsh
         KFHw==
X-Gm-Message-State: AOUpUlHNUxDr5fzmz0qrzzFK3zbIj6qkKz2djJAzPaXDeBZ858EOgkZL
        f4w2udLkmKYRtdMlQQMygpycEg==
X-Google-Smtp-Source: AAOMgpc5IyHcvhGxrJqxLVC9SbfyMq2Yb/PkZ6XVd4HUZcX1hy9VrT9H0GjFH4k8dYG2fTNnJdYn6g==
X-Received: by 2002:a5b:34e:: with SMTP id q14-v6mr4182866ybp.133.1531951733254;
        Wed, 18 Jul 2018 15:08:53 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::2:7eca])
        by smtp.gmail.com with ESMTPSA id r3-v6sm5676079ywr.80.2018.07.18.15.08.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Jul 2018 15:08:52 -0700 (PDT)
Date:   Wed, 18 Jul 2018 18:11:39 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Christopher Lameter <cl@linux.com>,
        Mike Galbraith <efault@gmx.de>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 08/10] psi: pressure stall information for CPU, memory,
 and IO
Message-ID: <20180718221139.GF2838@cmpxchg.org>
References: <20180712172942.10094-1-hannes@cmpxchg.org>
 <20180712172942.10094-9-hannes@cmpxchg.org>
 <20180717151705.GH2494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717151705.GH2494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 05:17:05PM +0200, Peter Zijlstra wrote:
> On Thu, Jul 12, 2018 at 01:29:40PM -0400, Johannes Weiner wrote:
> > @@ -457,6 +457,22 @@ config TASK_IO_ACCOUNTING
> >  
> >  	  Say N if unsure.
> >  
> > +config PSI
> > +	bool "Pressure stall information tracking"
> > +	select SCHED_INFO
> 
> What's the deal here? AFAICT it does not in fact use SCHED_INFO for
> _anything_. You just hooked into the sched_info_{en,de}queue() hooks,
> but you don't use any of the sched_info data.
> 
> So the dependency is an artificial one that should not exist.

You're right, it doesn't strictly depend on it. I'll split that out.
