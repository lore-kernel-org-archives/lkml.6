Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF50C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 09:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 654BA20821
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 09:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbfBEJSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 04:18:25 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40285 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727573AbfBEJSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 04:18:25 -0500
Received: by mail-wm1-f65.google.com with SMTP id f188so2738326wmf.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 01:18:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Gehefy1XcjInH7BDp9wZCF7J5+L7mg8aA6ZxFOG13no=;
        b=g82DY1qtHJYY0wV7MqORUXA7DU7BesHKPmG75L3HjNFphME1x841k86AWv7Vn9qXkl
         ONzpl4CVfJyOnMF587p0oTmior+ow2bxBTAXFUBRL4yFc0/CNatFVuvWuddCZcjbPuL2
         kpo2djPc+L649N0qb5ic85Vl2HxBma9C3Xuu0ONZqeRgqXBzplIteCFLg9dFsCi9jOOR
         Wmbrufu3fpsdJeYuEStAGASWzScyJXtGktF6AoXi7FjLYLg3/AzmVIgTQpPg3E3ahG9a
         Sr63vnMoXfCC0Ecd9O/y9CeQUYdQ8M9MMj8xseQAysTEBfB7aqGzBZiFQ+mz9lJb5RgU
         W9RQ==
X-Gm-Message-State: AHQUAuZmzTAYa9GwNrzKGVZ0FAQF/Z7gzitX4Up2Ql98UEgEm2w1M6HD
        KAoFYjwYsu1hAveRsi0Dc4Qteg==
X-Google-Smtp-Source: AHgI3IaloSuY3+6/ckyBOCdOzKCClh6RAein5L8azxPSUW1hJFy9VQ5Va4+vIdloo89eIELrghxlAA==
X-Received: by 2002:a1c:cec1:: with SMTP id e184mr2900254wmg.75.1549358303069;
        Tue, 05 Feb 2019 01:18:23 -0800 (PST)
Received: from localhost.localdomain ([151.15.206.34])
        by smtp.gmail.com with ESMTPSA id a12sm22090689wrm.45.2019.02.05.01.18.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Feb 2019 01:18:22 -0800 (PST)
Date:   Tue, 5 Feb 2019 10:18:20 +0100
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, rostedt@goodmis.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org, lizefan@huawei.com,
        cgroups@vger.kernel.org
Subject: Re: [PATCH v6 3/5] cgroup/cpuset: make callback_lock raw
Message-ID: <20190205091820.GE30905@localhost.localdomain>
References: <20190117084739.17078-1-juri.lelli@redhat.com>
 <20190117084739.17078-4-juri.lelli@redhat.com>
 <20190204120236.GC17550@hirez.programming.kicks-ass.net>
 <20190204120711.GA17582@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204120711.GA17582@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/02/19 13:07, Peter Zijlstra wrote:
> On Mon, Feb 04, 2019 at 01:02:36PM +0100, Peter Zijlstra wrote:
> > On Thu, Jan 17, 2019 at 09:47:37AM +0100, Juri Lelli wrote:
> > > @@ -3233,11 +3233,11 @@ void cpuset_cpus_allowed(struct task_struct *tsk, struct cpumask *pmask)
> > >  {
> > >  	unsigned long flags;
> > >  
> > > -	spin_lock_irqsave(&callback_lock, flags);
> > > +	raw_spin_lock_irqsave(&callback_lock, flags);
> > >  	rcu_read_lock();
> > >  	guarantee_online_cpus(task_cs(tsk), pmask);
> > >  	rcu_read_unlock();
> > > -	spin_unlock_irqrestore(&callback_lock, flags);
> > > +	raw_spin_unlock_irqrestore(&callback_lock, flags);
> > >  }
> > >  
> > >  void cpuset_cpus_allowed_fallback(struct task_struct *tsk)
> > > @@ -3285,11 +3285,11 @@ nodemask_t cpuset_mems_allowed(struct task_struct *tsk)
> > >  	nodemask_t mask;
> > >  	unsigned long flags;
> > >  
> > > -	spin_lock_irqsave(&callback_lock, flags);
> > > +	raw_spin_lock_irqsave(&callback_lock, flags);
> > >  	rcu_read_lock();
> > >  	guarantee_online_mems(task_cs(tsk), &mask);
> > >  	rcu_read_unlock();
> > > -	spin_unlock_irqrestore(&callback_lock, flags);
> > > +	raw_spin_unlock_irqrestore(&callback_lock, flags);
> > >  
> > >  	return mask;
> > >  }
> > > @@ -3381,14 +3381,14 @@ bool __cpuset_node_allowed(int node, gfp_t gfp_mask)
> > >  		return true;
> > >  
> > >  	/* Not hardwall and node outside mems_allowed: scan up cpusets */
> > > -	spin_lock_irqsave(&callback_lock, flags);
> > > +	raw_spin_lock_irqsave(&callback_lock, flags);
> > >  
> > >  	rcu_read_lock();
> > >  	cs = nearest_hardwall_ancestor(task_cs(current));
> > >  	allowed = node_isset(node, cs->mems_allowed);
> > >  	rcu_read_unlock();
> > >  
> > > -	spin_unlock_irqrestore(&callback_lock, flags);
> > > +	raw_spin_unlock_irqrestore(&callback_lock, flags);
> > >  	return allowed;
> > >  }
> > 
> > These three appear to be a user-controlled O(n) (depth of cgroup tree).
> > Which is basically bad for raw_spinlock_t.
> > 
> > The Changelog should really have mentioned this; and ideally we'd
> > somehow avoid this.
> 
> N/m avoiding it; we have this all over the place, just mention it..

OK.
