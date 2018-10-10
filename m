Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC55C46462
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 17:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2DE92086D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 17:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="VHAESBZz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2DE92086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbeJKAiR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 20:38:17 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42019 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbeJKAiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 20:38:16 -0400
Received: by mail-wr1-f67.google.com with SMTP id g15-v6so6594201wru.9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 10:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=e5wwHPZLBrLlcfGC9dC7ys7NYgaVOUJ0XC5z2JBAsdc=;
        b=VHAESBZzTO967toSEhVvMIXopWJj0wfOW3gmCCL2dBSrVelOk222q26PmxIDTQMmrJ
         rdvwYKvAbirQOdxTczzea69vjwcQhb1RmRXigf9trT6sqVe4cXfVi9xFy87Yh6liaQa1
         1m24itMd+W/kUJPsZ59X5iizIt0VL5Txqh6hr0vygs7qp2ZlQ+FTquZ4SzgOEr3N87pb
         6ElNMx/M/rEo9d2m2x+tsNvy99TNsQjFW28jzFys8Q2cikhPHk9S9ws/K4pkUdJy6/Jx
         L5hJiBhbRmlw36SKeaNUCEnirREy20Mng/iPasgDpbZrH0e0T+MREHxvTqzhXK932vZ+
         OLZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e5wwHPZLBrLlcfGC9dC7ys7NYgaVOUJ0XC5z2JBAsdc=;
        b=kSk/buyVEy+uzKyJIJKhXOTPrm3pMNlKvbVplGWfJ/2Ndpkd5guBAscodiuiiFLtZP
         AXxMHHI05fAP4wiUbffQmnXmduasXAPF3C1sY31aKTwKRoDsob1rdfRsEOGVi8kbhBno
         SmC6Fshs6SUkRS0M0LkYrQ5mSiY1uLN9AWX9rCkHVT0zFNB30z5kpQFmuDjbrTOw/9yd
         c+aZ/Cn++9P+QjjnQ8y95IKf0vt7cjXlYp5qxR1BNiu88HmXpbZCXK1ERXLMY9cQPN6V
         jM/s4+AlMS+jXFRPyqLEKgfw/rRPaJzjg4rrBEb33fvHAcB3/WRF7SwXwc7Z60lmJJej
         m4CA==
X-Gm-Message-State: ABuFfoigl7LPb7qacoTgCjtYsxvDqAPhax72JCgaQ+uUwy1x9d81Nayi
        ePGxt2fhSX/Ul+vL/YhEQX4X+A==
X-Google-Smtp-Source: ACcGV60OnR5zymYrk1YHXNoJkXvb77V2D1tBN1X1kbEj4RO/MF67V50yATbQ8ayvCrf+C9KITpdT0g==
X-Received: by 2002:adf:ef86:: with SMTP id d6-v6mr23135862wro.204.1539191709600;
        Wed, 10 Oct 2018 10:15:09 -0700 (PDT)
Received: from brauner.io ([2a02:8070:8895:9700:8197:8849:535a:4f00])
        by smtp.gmail.com with ESMTPSA id r134-v6sm12110606wmg.9.2018.10.10.10.15.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 10:15:08 -0700 (PDT)
Date:   Wed, 10 Oct 2018 19:15:02 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     Jann Horn <jannh@google.com>, Paul Moore <paul@paul-moore.com>,
        Kees Cook <keescook@chromium.org>,
        Linux API <linux-api@vger.kernel.org>,
        containers@lists.linux-foundation.org, suda.akihiro@lab.ntt.co.jp,
        Oleg Nesterov <oleg@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andy Lutomirski <luto@amacapital.net>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>
Subject: Re: [PATCH v7 3/6] seccomp: add a way to get a listener fd from
 ptrace
Message-ID: <20181010171500.wh4yygmh7u6ynqid@brauner.io>
References: <20181008162147.ubfxxsv2425l2zsp@brauner.io>
 <CAG48ez3O+wAkq+0yDfoMt73ybnCOEPpi3Mu-uF57_v=6hA8ZEw@mail.gmail.com>
 <20181008181815.pwnqxngj22mhm2vj@brauner.io>
 <CAG48ez3PEce4ynRnDk=yfsAOuFGH=YMmuf13CAxEt07Yjk3ZCw@mail.gmail.com>
 <20181009132850.fp6yne2vgmfpi27k@brauner.io>
 <CAG48ez2EV8Z=Egn7hNpXd86bHdvQhVxStqE1N=U2L2R7sA-gjg@mail.gmail.com>
 <CAHC9VhQfzJgG3i=Q8C+pGY2Lpr+2MRTwxgUWec_heGOecd=xRg@mail.gmail.com>
 <CAG48ez2hTBFwmA65FXv0zJjc0_wpc1S-uOBn1t+X=0vPH25YvQ@mail.gmail.com>
 <20181010153956.zzlatxdlcwolbs6k@brauner.io>
 <20181010165458.GA5607@cisco>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181010165458.GA5607@cisco>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 09:54:58AM -0700, Tycho Andersen wrote:
> On Wed, Oct 10, 2018 at 05:39:57PM +0200, Christian Brauner wrote:
> > On Wed, Oct 10, 2018 at 05:33:43PM +0200, Jann Horn wrote:
> > > On Wed, Oct 10, 2018 at 5:32 PM Paul Moore <paul@paul-moore.com> wrote:
> > > > On Tue, Oct 9, 2018 at 9:36 AM Jann Horn <jannh@google.com> wrote:
> > > > > +cc selinux people explicitly, since they probably have opinions on this
> > > >
> > > > I just spent about twenty minutes working my way through this thread,
> > > > and digging through the containers archive trying to get a good
> > > > understanding of what you guys are trying to do, and I'm not quite
> > > > sure I understand it all.  However, from what I have seen, this
> > > > approach looks very ptrace-y to me (I imagine to others as well based
> > > > on the comments) and because of this I think ensuring the usual ptrace
> > > > access controls are evaluated, including the ptrace LSM hooks, is the
> > > > right thing to do.
> > > 
> > > Basically the problem is that this new ptrace() API does something
> > > that doesn't just influence the target task, but also every other task
> > > that has the same seccomp filter. So the classic ptrace check doesn't
> > > work here.
> > 
> > Just to throw this into the mix: then maybe ptrace() isn't the right
> > interface and we should just go with the native seccomp() approach for
> > now.
> 
> Please no :).
> 
> I don't buy your arguments that 3-syscalls vs. one is better. If I'm
> doing this setup with a new container, I have to do
> clone(CLONE_FILES), do this seccomp thing, so that my parent can pick
> it up again, then do another clone without CLONE_FILES, because in the
> general case I don't want to share my fd table with the container,
> wait on the middle task for errors, etc. So we're still doing a bunch
> of setup, and it feels more awkward than ptrace, with at least as many
> syscalls, and it only works for your children.

You're talking about the case where you already have shot yourself in
the foot by blocking basically all other sensible ways of getting the fd
out.

Also, this was meant to show that parts of your initial justification
for implementing the ptrace() way of getting an fd doesn't really stand.
And it doesn't really. Even with ptrace() you can get into situations
where you're not able to get an fd. (see prior threads)

> 
> I don't mind leaving capable(CAP_SYS_ADMIN) for the ptrace() part,

Again, (prior threads) ptrace() or no ptrace() is something I do not
particularly care about as long as we have the
non-capable(CAP_SYS_ADMIN) seccomp() way of getting an fd out.

> though. So if that's ok, then I think we can agree :)
> 
> Tycho
