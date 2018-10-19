Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7001C67863
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 02:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B9DD21476
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 02:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="hpn8leeT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B9DD21476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbeJSK3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 06:29:30 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36754 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbeJSK3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 06:29:30 -0400
Received: by mail-pf1-f196.google.com with SMTP id l81-v6so15779718pfg.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 19:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CKUsTW0mu0TMb5zqP3PVGKvleD94SeUvhyXg5ouDahM=;
        b=hpn8leeT3kpcKbjiDCveIb2uj4nmm3dxH5lc4MVIVlAcR83zcs2OTKJzy1Rn93qa7/
         UU1RFHGVybubzQrG4ZHo6EkqOMfVVZcQTm+1D1fmFjxWnJ4VVJ3mNRUENJUNf0eZWVZP
         xajK3sOHqoexpg+65caW34FupW0gLOZuFJv5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CKUsTW0mu0TMb5zqP3PVGKvleD94SeUvhyXg5ouDahM=;
        b=WXYEJd9MkD1/2K9dB9z/JDeLh+b+Zdv6RUusQczRaLIclODHyNE0f00uS/CPpaxP0M
         L4zTxBP4eh0wx+YIDR49G0o2BKbjx165OjvylKdyanJEI6BYPYd3OstWpYetBGN5xP3V
         MTzW2iKqw6QjuTJ8G8y98H4MFB1sInsKCaBNBHvI/DYR+XUZZm0HdH5zyDHGuuJs8ydE
         hXLJrR+jtgP+YwgK3RSKbhX8k9YrJ29REQptl3c5VoKzcy7QHSXx8AxhXeIHYO91rXrV
         FLk991Gn6EmTN5kwU3qicfAgmMAOLzEXkS0aaQyq4SfwDIfE5VEcc3SGnVxKjd8EoKk5
         IONg==
X-Gm-Message-State: ABuFfojQqTAJk5UYQ2FikjzRuloVC4nCZi68hvDwTBiWvXXOiECtYziU
        7R/SjzlPbl2KjwTW0BLoC5+Wtg==
X-Google-Smtp-Source: ACcGV62AxMnSsLnc/5KINoxpxr/0/J8bXrhXPqwc7BWfEEMko2vKFckCk4EPsOjEt3pHD+SDiz1ESw==
X-Received: by 2002:a62:4803:: with SMTP id v3-v6mr33843473pfa.89.1539915931885;
        Thu, 18 Oct 2018 19:25:31 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id t85-v6sm33063332pfi.73.2018.10.18.19.25.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 19:25:30 -0700 (PDT)
Date:   Thu, 18 Oct 2018 19:25:29 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Nikolay Borisov <nborisov@suse.com>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH RFC] doc: rcu: remove obsolete (non-)requirement about
 disabling preemption
Message-ID: <20181019022529.GA155753@joelaf.mtv.corp.google.com>
References: <20181016204122.GA8176@joelaf.mtv.corp.google.com>
 <20181017161100.GP2674@linux.ibm.com>
 <20181017181505.GC107185@joelaf.mtv.corp.google.com>
 <20181017203324.GS2674@linux.ibm.com>
 <20181018020751.GB99677@joelaf.mtv.corp.google.com>
 <20181018144637.GD2674@linux.ibm.com>
 <20181019000350.GB89903@joelaf.mtv.corp.google.com>
 <20181019001932.GR2674@linux.ibm.com>
 <20181019012645.GC89903@joelaf.mtv.corp.google.com>
 <20181018215035.5e8ff553@vmware.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181018215035.5e8ff553@vmware.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 09:50:35PM -0400, Steven Rostedt wrote:
> On Thu, 18 Oct 2018 18:26:45 -0700
> Joel Fernandes <joel@joelfernandes.org> wrote:
> 
> > Yes, local_irq_restore is light weight, and does not check for reschedules.
> > 
> > I was thinking of case where ksoftirqd is woken up, but does not run unless
> > we set the NEED_RESCHED flag. But that should get set anyway since probably
> > ksoftirqd is of high enough priority than the currently running task..
> > 
> > Roughly speaking the scenario could be something like:
> > 
> > rcu_read_lock();
> >                  <-- IPI comes in for the expedited GP, sets exp_hint
> > local_irq_disable();
> > // do a bunch of stuff
> > rcu_read_unlock();   <-- This calls the rcu_read_unlock_special which raises
> >                          the soft irq, and wakesup softirqd.
> 
> If softirqd is of higher priority than the current running task, then
> the try_to_wake_up() will set NEED_RESCHED of the current task here.
> 

Yes, only *if*. On my system, ksoftirqd is CFS nice 0. I thought expedited
grace periods are quite important and they should complete quickly which is
the whole reason for interrupting rcu read sections with an IPI and stuff.
IMO there should be no harm in setting NEED_RESCHED unconditionally anyway
for possible benefit of systems where the ksoftirqd is not of higher priority
than the currently running task, and we need to run it soon on the CPU. But
I'm Ok with whatever Paul and you want to do here.

- Joel

