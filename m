Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B26C43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 03:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59C1324D9E
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 03:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="vwFpO9v4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59C1324D9E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752269AbeFXDCF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 23:02:05 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:43882 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752113AbeFXDCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 23:02:04 -0400
Received: by mail-pg0-f67.google.com with SMTP id a14-v6so4576301pgw.10
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jun 2018 20:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=92ry53j5zijOF9aqo904mXvJZY7mEqZyxe2rok6cO/s=;
        b=vwFpO9v4qxQGhwqgbihUaNGieqFQ51X/ihTEGzfoSEkTnNULpDcqa2kpIScqF9iI+g
         E96l3/d/IMc3dPU9D0bwH59HxhP3hYdtJpZ0TwUkAP9QK4jXOBQmNYR7fDss2KH6lLjr
         kkCUs4sNYVjop3+ImmaA3XJVSTLAyDFqfovoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=92ry53j5zijOF9aqo904mXvJZY7mEqZyxe2rok6cO/s=;
        b=cjqstPvAX9MAh8DE+p/+an2WKnExix2PUz/v9G5sBb3jeOAVDdytjsA1Jkzd16zCQU
         +ltCk8kpGX2WY+1T5dQLMSujv/S/l9tCEfKSgOBwPkh+MdADOdW6rp48PV1vRodYLk/I
         48aNC8LvDk+mu+OFJEnAcdQj07K1EV+aFaomREsZ+EbFL4VnWGVTRn77rH9DUlkRavO5
         Zh/kXjtN2XbYp4/zNb+mbi+p7FzOHk/4AvRL4vWYk03MqulL3YuQj2SHOb/jIsirRLmL
         pw1DsG6Spe6njOkJDoZd7bHauiM2OoOmA4vBOwFrjsKwu4ayvdlnNKwGMcTyiTr40VKh
         JPoA==
X-Gm-Message-State: APt69E3K2rtTAY4wVtguB0jdLmbI5on2mj+Q3qG/DEvWlqGygQyRmG1J
        K94N0GY/tzG/LFgR4Karj4l9Iw3igh0=
X-Google-Smtp-Source: ADUXVKLXVu9SUM6vzycBGBz+Eo36mdGV9zk722lwBUh5OTfyShjhEanOizAT8e6O2ygbyLPNTUoqyw==
X-Received: by 2002:a65:4587:: with SMTP id o7-v6mr6277288pgq.386.1529809323738;
        Sat, 23 Jun 2018 20:02:03 -0700 (PDT)
Received: from localhost ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id v78-v6sm23476688pfd.64.2018.06.23.20.02.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 23 Jun 2018 20:02:02 -0700 (PDT)
Date:   Sat, 23 Jun 2018 20:02:01 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Byungchul Park <max.byungchul.park@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        jiangshanlai@gmail.com, josh@joshtriplett.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org, kernel-team@lge.com, luto@kernel.org
Subject: Re: [RFC 2/2] rcu: Remove ->dynticks_nmi_nesting from struct
 rcu_dynticks
Message-ID: <20180624030201.GA161749@joelaf.mtv.corp.google.com>
References: <CANrsvRMYc5u3L53nnnGC6p-QcjBTfLPjkJGZyubGWAPauc-W8w@mail.gmail.com>
 <20180620164902.GW3593@linux.vnet.ibm.com>
 <20180622055659.GA255098@joelaf.mtv.corp.google.com>
 <20180622132843.GN3593@linux.vnet.ibm.com>
 <20180622181916.GA13628@joelaf.mtv.corp.google.com>
 <20180622205813.GV3593@linux.vnet.ibm.com>
 <20180622170042.4adfbe21@gandalf.local.home>
 <20180622211600.GX3593@linux.vnet.ibm.com>
 <20180623154839.GA12939@joelaf.mtv.corp.google.com>
 <20180623175634.GI3593@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180623175634.GI3593@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 23, 2018 at 10:56:34AM -0700, Paul E. McKenney wrote:
> On Sat, Jun 23, 2018 at 08:48:39AM -0700, Joel Fernandes wrote:
> > On Fri, Jun 22, 2018 at 02:16:00PM -0700, Paul E. McKenney wrote:
> > > On Fri, Jun 22, 2018 at 05:00:42PM -0400, Steven Rostedt wrote:
> > > > On Fri, 22 Jun 2018 13:58:13 -0700
> > > > "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> > > > 
> > > > > Something like this:
> > > > > 
> > > > > 	IRQ entered
> > > > > 
> > > > > And never exited.  Ever.  I actually saw this in 2011.
> > > > 
> > > > I still believe this was actually a bug. And perhaps you made the RCU
> > > > code robust enough to handle this bug ;-)
> > > 
> > > Welcome to my world!
> > > 
> > > But I recall it being used in several places, so if it was a bug, it
> > > was an intentional bug.  Probably the worst kind.
> > > 
> > > Sort of like nested NMIs and interrupts within NMI handlers.  ;-)
> > > 
> > > > > Or something like this:
> > > > > 
> > > > > 	IRQ exited
> > > > > 
> > > > > Without a corresponding IRQ enter.
> > > > > 
> > > > > The current code handles both of these situations, at least assuming
> > > > > that the interrupt entry/exit happens during a non-idle period.
> > > > > 
> > > > > > > So why this function-call structure?  Well, you see, NMI handlers can
> > > > > > > take what appear to RCU to be normal interrupts...
> > > > > > > 
> > > > > > > (And I just added that fun fact to Requirements.html.)  
> > > > > > 
> > > > > > Yes, I'll definitely go through all the interrupt requirements in the doc and
> > > > > > thanks for referring me to it.  
> > > > > 
> > > > > My concern may well be obsolete.  It would be good if it was!  ;-)
> > > > 
> > > > I'd love to mandate that irq_enter() must be paired with irq_exit(). I
> > > > don't really see any rationale for it to be otherwise. If there is a
> > > > case, perhaps it needs to be fixed.
> > > 
> > > Given that the usermode helpers now look to be common code using
> > > workqueues, kthreads, and calls to do_execve(), it might well be that
> > > the days of half-interrupts are behind us.
> > > 
> > > But how to actually validate this?  My offer of adding a WARN_ON_ONCE()
> > > and waiting a few years still stands, but perhaps you have a better
> > > approach.
> > 
> > Hi Paul, I am Ok with adding a warning for a couple of releases if you and
> > others are Ok with it, how about something like this? Feel free to use the
> > diff as a starting point or a different approach if you/others prefer
> > something else. Thanks.
> 
> A few years rather than a few releases, but yes.  ;-)
> The checks would need to go just before the "crowbar" stores.  

Ok. I guess that would work too.

> I will put something together after Byungchul's patches in this area have
> had time to burn in for a few days.

Sounds great, thanks!

 - Joel

