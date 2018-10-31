Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6DAFC6786F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 00:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4490C2082D
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 00:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="PtFm6Va7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4490C2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbeJaJxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 05:53:13 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:32886 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728591AbeJaJxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 05:53:13 -0400
Received: by mail-pf1-f194.google.com with SMTP id a15-v6so6743200pfn.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 17:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3uDb/lmLWw3HWuGL3n/wi65BBdbtBwwSCJhrS1GpAXY=;
        b=PtFm6Va7Lwp5J7BdnMdJCNNVv8Jj3YTXEsN26NeK/TUa6Dl93rBpaRv6SMB83VO1BK
         AXX5Rd7NOY3f5OR6i8dzvnQoBdQAbo7TfFkP+xWmfh4jpTz+GJsew9NrTP6TWuG9VVem
         wjxVo2ENcO2aoPtk9xaxKv15AuCuL69iV39T4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3uDb/lmLWw3HWuGL3n/wi65BBdbtBwwSCJhrS1GpAXY=;
        b=Jkh02z8QCl+AUEqNJLxEjlMTg4mRXaNb9o4wHZ+ud2OcCo7NlHhSfH0R7Yj6RqCK9Y
         5cV7FFD4S9OqGs6yFoFGgSx5HjXZOO9aOB223WgLXa/xae8Si0pZ8UAYM2X5Dt3/D+Y/
         yZgVigY8WdkhAjwLHMU4IwAlJCNy0R2bbTpy7yYimX1Gf+1O3YIhuKwXNKDWsODtidwm
         gc9eROQOExalWKkVc1XY+dsri1/1YxDfKvJFWc32+SCWJVG0UdXpkuhfhgOh2ZaeWXEK
         5Y5i/xd0i9LCSodhCOFLqdH7ujxzrBhs1ELyrSs/Jt2avGpauSmnOq7CW95vWCC9u2JQ
         SDvQ==
X-Gm-Message-State: AGRZ1gKOIZQiWzswk5vIPcEH3A+gaURwadGfYAHUWIx1WAYmcdPztN2I
        +S1alspPvMPaoUkCuwEeiFie0oebgcI=
X-Google-Smtp-Source: AJdET5dZH4/npLBaY9nWSSCcZxpwvLQdweCZQ4D6hmCJoDsVv9KqZ2d1OJC3kQznpVlIOV+2urZrPA==
X-Received: by 2002:a63:42c1:: with SMTP id p184mr986241pga.202.1540947445713;
        Tue, 30 Oct 2018 17:57:25 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id r23-v6sm28492636pgm.48.2018.10.30.17.57.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 17:57:24 -0700 (PDT)
Date:   Tue, 30 Oct 2018 17:57:23 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Daniel Colascione <dancol@google.com>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [RFC PATCH] Implement /proc/pid/kill
Message-ID: <20181031005723.GD224709@google.com>
References: <20181029221037.87724-1-dancol@google.com>
 <20181030050012.u43lcvydy6nom3ul@yavin>
 <CAKOZuesKVic-5epRj8XcFNR_63SgvaPcbjDQuSLxNrEfS=O=Jg@mail.gmail.com>
 <20181030204501.jnbe7dyqui47hd2x@yavin>
 <20181030214243.GB32621@google.com>
 <20181030222339.ud4wfp75tidowuo4@yavin>
 <20181030223343.GB105735@joelaf.mtv.corp.google.com>
 <CAKOZueuBdY_b=CVk29pzn0NAt9sJtzr6yqx9Y00WCppCm1JFWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKOZueuBdY_b=CVk29pzn0NAt9sJtzr6yqx9Y00WCppCm1JFWQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 11:10:47PM +0000, Daniel Colascione wrote:
> On Tue, Oct 30, 2018 at 10:33 PM, Joel Fernandes <joel@joelfernandes.org> wrote:
> > On Wed, Oct 31, 2018 at 09:23:39AM +1100, Aleksa Sarai wrote:
> >> On 2018-10-30, Joel Fernandes <joel@joelfernandes.org> wrote:
> >> > On Wed, Oct 31, 2018 at 07:45:01AM +1100, Aleksa Sarai wrote:
> >> > [...]
> >> > > > > (Unfortunately
> >> > > > > there are lots of things that make it a bit difficult to use /proc/$pid
> >> > > > > exclusively for introspection of a process -- especially in the context
> >> > > > > of containers.)
> >> > > >
> >> > > > Tons of things already break without a working /proc. What do you have in mind?
> >> > >
> >> > > Heh, if only that was the only blocker. :P
> >> > >
> >> > > The basic problem is that currently container runtimes either depend on
> >> > > some non-transient on-disk state (which becomes invalid on machine
> >> > > reboots or dead processes and so on), or on long-running processes that
> >> > > keep file descriptors required for administration of a container alive
> >> > > (think O_PATH to /dev/pts/ptmx to avoid malicious container filesystem
> >> > > attacks). Usually both.
> >> > >
> >> > > What would be really useful would be having some way of "hiding away" a
> >> > > mount namespace (of the pid1 of the container) that has all of the
> >> > > information and bind-mounts-to-file-descriptors that are necessary for
> >> > > administration. If the container's pid1 dies all of the transient state
> >> > > has disappeared automatically -- because the stashed mount namespace has
> >> > > died. In addition, if this was done the way I'm thinking with (and this
> >> > > is the contentious bit) hierarchical mount namespaces you could make it
> >> > > so that the pid1 could not manipulate its current mount namespace to
> >> > > confuse the administrative process. You would also then create an
> >> > > intermediate user namespace to help with several race conditions (that
> >> > > have caused security bugs like CVE-2016-9962) we've seen when joining
> >> > > containers.
> >> > >
> >> > > Unfortunately this all depends on hierarchical mount namespaces (and
> >> > > note that this would just be that NS_GET_PARENT gives you the mount
> >> > > namespace that it was created in -- I'm not suggesting we redesign peers
> >> > > or anything like that). This makes it basically a non-starter.
> >> > >
> >> > > But if, on top of this ground-work, we then referenced containers
> >> > > entirely via an fd to /proc/$pid then you could also avoid PID reuse
> >> > > races (as well as being able to find out implicitly whether a container
> >> > > has died thanks to the error semantics of /proc/$pid). And that's the
> >> > > way I would suggest doing it (if we had these other things in place).
> >> >
> >> > I didn't fully follow exactly what you mean. If you can explain for the
> >> > layman who doesn't know much experience with containers..
> >> >
> >> > Are you saying that keeping open a /proc/$pid directory handle is not
> >> > sufficient to prevent PID reuse while the proc entries under /proc/$pid are
> >> > being looked into? If its not sufficient, then isn't that a bug? If it is
> >> > sufficient, then can we not just keep the handle open while we do whatever we
> >> > want under /proc/$pid ?
> >>
> >> Sorry, I went on a bit of a tangent about various internals of container
> >> runtimes. My main point is that I would love to use /proc/$pid because
> >> it makes reuse handling very trivial and is always correct, but that
> >> there are things which stop us from being able to use it for everything
> >> (which is what my incoherent rambling was on about).
> >
> > Ok thanks. So I am guessing if the following sequence works, then Dan's patch is not
> > needed.
> >
> > 1. open /proc/<pid> directory
> > 2. inspect /proc/<pid> or do whatever with <pid>
> > 3. Issue the kill on <pid>
> > 4. Close the /proc/<pid> directory opened in step 1.
> >
> > So unless I missed something, the above sequence will not cause any PID reuse
> > races.
> 
> Keeping a /proc/$PID directory file descriptor open does not prevent
> $PID being used to name some other process. If it could, you could
> pretty quickly fill a whole system's process table. See the program
> below, which demonstrates the PID collision.

I know. We both were not sure about that earlier, that's why I requested you
to write the program when we were privately chatting. Now I'm sure because
Aleska answered that and the you program you wrote showed that too.

I wonder if this cannot be plumbed by just making the /proc/$PID directory
opens hold a reference to task_struct (and a reference to whatever else is
supposed to prevent the PID from getting reused), instead of introducing a
brand new API.

> I think Aleksa's larger point is that it's useful to treat processes
> as other file-descriptor-named, poll-able, wait-able resources.
> Consistency is important. A process is just another system resource,
> and like any other system resource, you should be open to hold a file
> descriptor to it and do things to that process via that file
> descriptor. The precise form of this process-handle FD is up for
> debate. The existing /proc/$PID directory FD is a good candidate for a
> process handle FD, since it does almost all of what's needed. But
> regardless of what form a process handle FD takes, we need it. I don't
> see a case for continuing to treat processes in a non-unixy,
> non-file-descriptor-based manner.

So wait, how is that supposed to address what you're now saying above
"quickly fill a whole process table"? You either want this, or you don't :)

