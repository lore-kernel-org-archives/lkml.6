Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1702C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 03:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E3CE20892
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 03:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="qARq20rv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E3CE20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbeKKM4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 07:56:39 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35512 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726945AbeKKM4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 07:56:39 -0500
Received: by mail-pf1-f196.google.com with SMTP id v9-v6so2676148pff.2
        for <linux-kernel@vger.kernel.org>; Sat, 10 Nov 2018 19:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wPD7LKfrs+pdF8VE+B6W1KWMA6VQdZKm/MLJ/tUrQ3Q=;
        b=qARq20rvk779lPgHMuIScj2tfJvBe/2sugDU5ujTUWq4Ev/4Dl1e6n3Of6dFiqmhIa
         3Mz30r3pzLB7zZowBtXx0Dy6HqXc+F0BEDZTymW8waOp3HzWGTKzEuSf/LnUOLqz9h/E
         V/WMB+IOiwRvOgFN1MSdaH3VO+y/kHQKgavUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wPD7LKfrs+pdF8VE+B6W1KWMA6VQdZKm/MLJ/tUrQ3Q=;
        b=iOMrh9KIiNKI3cDbxtXeIeYyLTsXHXH0np6EzLXZsdIiXXfj84LsvfnHjcnxNT9oh2
         ih5aNqcyDjquetJCYwRUjmcIJy5dNtwN96bdczRgSxRFuikGEFjW+R9YvbMaj6R19IqB
         pdDD/Il6EvannwAmQs9bybvGh7Zpvjx2ulrn2jZmlLMMk8Sm9LYLw98T2C3goTMo0hDJ
         B6M//UrFTczGJc6cVEuNqaXgVJ4SHUj3E2J5tmb7O1UqjVpwmAHdAsU/8QArLn53TzKM
         lfc7G8dscRor15cWGveHWUT5FdXOZQ8Iowb06YUVNVXdFzdyJ3dPUJZpY46xvXcw+dfZ
         bM2w==
X-Gm-Message-State: AGRZ1gIja6Y4g1djLtH5/N88BFHlRxetmDpoww/I2vQTD8B53JAIliGn
        CcLle2tAw+BajFIpep4hYHr6sBS2Vek=
X-Google-Smtp-Source: AJdET5cpJoOx1SiU3+AEuBFRpejbFj+KUWhmVwP1aTXrVpjRIUn9Mp6GgSYV5YMeiPgo6I9TCIf1dg==
X-Received: by 2002:a62:3a54:: with SMTP id h81-v6mr15032530pfa.119.1541905767208;
        Sat, 10 Nov 2018 19:09:27 -0800 (PST)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id l3sm11358337pga.92.2018.11.10.19.09.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 10 Nov 2018 19:09:26 -0800 (PST)
Date:   Sat, 10 Nov 2018 19:09:25 -0800
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com
Subject: Re: dyntick-idle CPU and node's qsmask
Message-ID: <20181111030925.GA182908@google.com>
References: <20181110214659.GA96924@google.com>
 <20181110230436.GL4170@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181110230436.GL4170@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 10, 2018 at 03:04:36PM -0800, Paul E. McKenney wrote:
> On Sat, Nov 10, 2018 at 01:46:59PM -0800, Joel Fernandes wrote:
> > Hi Paul and everyone,
> > 
> > I was tracing/studying the RCU code today in paul/dev branch and noticed that
> > for dyntick-idle CPUs, the RCU GP thread is clearing the rnp->qsmask
> > corresponding to the leaf node for the idle CPU, and reporting a QS on their
> > behalf.
> > 
> > rcu_sched-10    [003]    40.008039: rcu_fqs:              rcu_sched 792 0 dti
> > rcu_sched-10    [003]    40.008039: rcu_fqs:              rcu_sched 801 2 dti
> > rcu_sched-10    [003]    40.008041: rcu_quiescent_state_report: rcu_sched 805 5>0 0 0 3 0
> > 
> > That's all good but I was wondering if we can do better for the idle CPUs if
> > we can some how not set the qsmask of the node in the first place. Then no
> > reporting would be needed of quiescent state is needed for idle CPUs right?
> > And we would also not need to acquire the rnp lock I think.
> > 
> > At least for a single node tree RCU system, it seems that would avoid needing
> > to acquire the lock without complications. Anyway let me know your thoughts
> > and happy to discuss this at the hallways of the LPC as well for folks
> > attending :)
> 
> We could, but that would require consulting the rcu_data structure for
> each CPU while initializing the grace period, thus increasing the number
> of cache misses during grace-period initialization and also shortly after
> for any non-idle CPUs.  This seems backwards on busy systems where each

When I traced, it appears to me that rcu_data structure of a remote CPU was
being consulted anyway by the rcu_sched thread. So it seems like such cache
miss would happen anyway whether it is during grace-period initialization or
during the fqs stage? I guess I'm trying to say, the consultation of remote
CPU's rcu_data happens anyway.

> CPU will with high probability report its own quiescent state before three
> jiffies pass, in which case the cache misses on the rcu_data structures
> would be wasted motion.

If all the CPUs are busy and reporting their QS themselves, then I think the
qsmask is likely 0 so then rcu_implicit_dynticks_qs (called from
force_qs_rnp) wouldn't be called and so there would no cache misses on
rcu_data right?

> Now, this does increase overhead on mostly idle systems, but the theory
> is that mostly idle systems are most able to absorb this extra overhead.

Yes. Could we use rcuperf to check the impact of such change?

Anyway it was just an idea that popped up when I was going through traces :)
Thanks for the discussion and happy to discuss further or try out anything.

- Joel

