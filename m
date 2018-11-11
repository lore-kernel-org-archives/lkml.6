Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77559C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 21:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0100620881
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 21:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="BF+0meAT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0100620881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729759AbeKLGxv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:53:51 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45126 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbeKLGxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 01:53:51 -0500
Received: by mail-pl1-f195.google.com with SMTP id r3-v6so2548501pls.12
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 13:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VtZLvi1i5i3/o6eED3xQ7YUlWUIzrxTzRo49NWMIPl0=;
        b=BF+0meATvt4cio6Aad5ANop2mxZRAkQUBR9fjhIADx4dZyihP9J5ZpGXTAAc2WaKNf
         R6vbOPjsliYxRk/xolYzL4w7TkJ42m/1Tz7BNaWDDc2WveUnprkrFsDW0PzpKRDi4/pr
         jVvq74oGWr7r552+NN7cRZQVuDx/1dL6MmU34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VtZLvi1i5i3/o6eED3xQ7YUlWUIzrxTzRo49NWMIPl0=;
        b=mwyzCexlMuDsT2cP/ArvmXBxZOkwxQE78xnS+MMMQJvoPJ4T0v4ar3zbcHd9A7c3ke
         RFoXCmN1O7CGVi/hDs9lCWyqkDLoLnpNG58ZWo0ICmSyn+b5fUql2miTNAlwSdQBpKfN
         5a0EYPty4KotY8QjpteD9iMQ2gkVcslgzMAyy/qtaSA90krqR8gpeA9nhOzk75eRVkhz
         R0LxRA2hjv60JjN6Cc5/vtTC9CEgKEpbuoCMy673jAe3L2+8Kii2iphLCQofPHI9zNRw
         Nj2xZnLgrhmsu0ZFvFBv91uUrIcxdgzScQ9rhgpbYEbiYF4SV86dniWE42j+AmmYA92n
         FZIA==
X-Gm-Message-State: AGRZ1gIN+qdlQaPG7eNy5g4Y6rygB26fMyHIM+UNTKPaaVR0Md0Edfj4
        NmDc59LhUjJWLDlOCFt01X6OjQ==
X-Google-Smtp-Source: AJdET5fzhKR2kfQcwZ7fUlygR9Je36SAJ0kBUhI+0jkmp24lSpoDWrc6FYoXByxgZDLDVlnGgTNbiA==
X-Received: by 2002:a17:902:110a:: with SMTP id d10-v6mr17531664pla.85.1541970250658;
        Sun, 11 Nov 2018 13:04:10 -0800 (PST)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id a16-v6sm323526pfh.107.2018.11.11.13.04.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 11 Nov 2018 13:04:09 -0800 (PST)
Date:   Sun, 11 Nov 2018 13:04:08 -0800
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com
Subject: Re: dyntick-idle CPU and node's qsmask
Message-ID: <20181111210408.GA85122@google.com>
References: <20181110214659.GA96924@google.com>
 <20181110230436.GL4170@linux.ibm.com>
 <20181111030925.GA182908@google.com>
 <20181111042210.GN4170@linux.ibm.com>
 <20181111180916.GA25327@google.com>
 <20181111183618.GY4170@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181111183618.GY4170@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2018 at 10:36:18AM -0800, Paul E. McKenney wrote:
[..]
> > > > > CPU will with high probability report its own quiescent state before three
> > > > > jiffies pass, in which case the cache misses on the rcu_data structures
> > > > > would be wasted motion.
> > > > 
> > > > If all the CPUs are busy and reporting their QS themselves, then I think the
> > > > qsmask is likely 0 so then rcu_implicit_dynticks_qs (called from
> > > > force_qs_rnp) wouldn't be called and so there would no cache misses on
> > > > rcu_data right?
> > > 
> > > Yes, but assuming that all CPUs report their quiescent states before
> > > the first call to rcu_gp_fqs().  One exception is when some CPU is
> > > looping in the kernel for many milliseconds without passing through a
> > > quiescent state.  This is because for recent kernels, cond_resched()
> > > is not a quiescent state until the grace period is something like 100
> > > milliseconds old.  (For older kernels, cond_resched() was never an RCU
> > > quiescent state unless it actually scheduled.)
> > > 
> > > Why wait 100 milliseconds?  Because otherwise the increase in
> > > cond_resched() overhead shows up all too well, causing 0day test robot
> > > to complain bitterly.  Besides, I would expect that in the common case,
> > > CPUs would be executing usermode code.
> > 
> > Makes sense. I was also wondering about this other thing you mentioned about
> > waiting for 3 jiffies before reporting the idle CPU's quiescent state. Does
> > that mean that even if a single CPU is dyntick-idle for a long period of
> > time, then the minimum grace period duration would be atleast 3 jiffies? In
> > our mobile embedded devices, jiffies is set to 3.33ms (HZ=300) to keep power
> > consumption low. Not that I'm saying its an issue or anything (since IIUC if
> > someone wants shorter grace periods, they should just use expedited GPs), but
> > it sounds like it would be shorter GP if we just set the qsmask early on some
> > how and we can manage the overhead of doing so.
> 
> First, there is some autotuning of the delay based on HZ:
> 
> #define RCU_JIFFIES_TILL_FORCE_QS (1 + (HZ > 250) + (HZ > 500))
> 
> So at HZ=300, you should be seeing a two-jiffy delay rather than the
> usual HZ=1000 three-jiffy delay.  Of course, this means that the delay
> is 6.67ms rather than the usual 3ms, but the theory is that lower HZ
> rates often mean slower instruction execution and thus a desire for
> lower RCU overhead.  There is further autotuning based on number of
> CPUs, but this does not kick in until you have 256 CPUs on your system,
> and I bet that smartphones aren't there yet.  Nevertheless, check out
> RCU_JIFFIES_FQS_DIV for more info on this.

Got it. I agree with that heuristic.

> But you can always override this autotuning using the following kernel
> boot paramters:
> 
> rcutree.jiffies_till_first_fqs
> rcutree.jiffies_till_next_fqs
> 
> You can even set the first one to zero if you want the effect of pre-scanning
> for idle CPUs.  ;-)
> 
> The second must be set to one or greater.
> 
> Both are capped at one second (HZ).

Got it. Thanks a lot for the explanations.

> > > > Anyway it was just an idea that popped up when I was going through traces :)
> > > > Thanks for the discussion and happy to discuss further or try out anything.
> > > 
> > > Either way, I do appreciate your going through this.  People have found
> > > RCU bugs this way, one of which involved RCU uselessly calling a particular
> > > function twice in quick succession.  ;-)
> >  
> > Thanks.  It is my pleasure and happy to help :) I'll keep digging into it.
> 
> Looking forward to further questions and patches.  ;-)

Will do! thanks,

 - Joel

