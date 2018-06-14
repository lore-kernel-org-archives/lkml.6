Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 89495C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 13:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49DCF208DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 13:51:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49DCF208DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755327AbeFNNvY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 09:51:24 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:32809 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754869AbeFNNvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 09:51:23 -0400
Received: by mail-wm0-f65.google.com with SMTP id z6-v6so3232793wma.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 06:51:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F2e2Xm5IuN2nvZT7HQCKcWH17xsad2eFOIOkiveL3CU=;
        b=KGAw5hsw+pJutt5CuPCxBNKS0RPVJItaIVDmo6FT4JdyJpVLOHwu+ocwVloxc/mzKa
         2AVEpW9VVIaPdsFnR3RJXdimxkMqje9w37b9alJeXoD6BaomjR0fib0Y8PlJaR7B0vzT
         OvOuk5BEGm/PcjlIe3zDgdrozTFdVUrJ0z9E666UocYEdaDDNeTpAGlEW2NoVrTMIol5
         ZS8YVb0MMmY/Jr64imghk6o1XparRvpCwE0DLqWKepGeSeJNDKpfcdw/upqkvNfsH3M5
         slLXrHPxD6/I3tnlhO2aZ0Kx0lELVyd07tuX07Tx5zN2W1qJ5pFyY4wPs0ExToPjDoew
         zj5w==
X-Gm-Message-State: APt69E2ltbuMlwbgPc6ImMoBO5VYsq6m+w3X2z/jb9P0iV8K492pOTJf
        UAhJOpOUeGPvu6HlYcJHX+j/Zg==
X-Google-Smtp-Source: ADUXVKJCcmXl2awgnBT66W3K3h/RZ3Xmfi/4EhW2GOi2rUIJaLqKrdKQPmKn48HmOgcsEpFfkvj14A==
X-Received: by 2002:a1c:ad4:: with SMTP id 203-v6mr1916643wmk.98.1528984282019;
        Thu, 14 Jun 2018 06:51:22 -0700 (PDT)
Received: from localhost.localdomain ([151.15.207.242])
        by smtp.gmail.com with ESMTPSA id e2-v6sm6491379wro.97.2018.06.14.06.51.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Jun 2018 06:51:21 -0700 (PDT)
Date:   Thu, 14 Jun 2018 15:51:19 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org, lizefan@huawei.com,
        cgroups@vger.kernel.org
Subject: Re: [PATCH v4 4/5] sched/core: Prevent race condition between cpuset
 and __sched_setscheduler()
Message-ID: <20180614135119.GF12032@localhost.localdomain>
References: <20180613121711.5018-1-juri.lelli@redhat.com>
 <20180613121711.5018-5-juri.lelli@redhat.com>
 <20180614094518.00a181cf@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180614094518.00a181cf@gandalf.local.home>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/06/18 09:45, Steven Rostedt wrote:
> On Wed, 13 Jun 2018 14:17:10 +0200
> Ju
> > diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> > index b42037e6e81d..d26fd4795aa3 100644
> > --- a/kernel/cgroup/cpuset.c
> > +++ b/kernel/cgroup/cpuset.c
> > @@ -2409,6 +2409,22 @@ void __init cpuset_init_smp(void)
> >  	BUG_ON(!cpuset_migrate_mm_wq);
> >  }
> >  
> > +/**
> > + * cpuset_lock - Grab the cpuset_mutex from another subsysytem
> > + */
> > +int cpuset_lock(void)
> 
> Shouldn't this be called "cpuset_trylock()" otherwise one may think
> that it will always return with the cpuset_mutex locked.

Sure.

Thanks,

- Juri
