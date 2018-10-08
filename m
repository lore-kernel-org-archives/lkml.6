Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2ACAC677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 700E421479
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="Jp+9Pc3z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 700E421479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729524AbeJIByS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:54:18 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35263 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729593AbeJIByS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:54:18 -0400
Received: by mail-wm1-f67.google.com with SMTP id e187-v6so9290568wmf.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 11:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8W7vay3C4kJVTbRrfHrHZEyEls1HHkDBMzLd57GOkL8=;
        b=Jp+9Pc3z5PxTkpk1RWlypoGoGHJBBPPbyHi+QZNBMk7TSrg7epnCSATen+Pow9Mp/P
         YRXc3vNNtx9wh6SfU+44pS/a1EhnjxosMR9aDuHambIriOivrZHpwgEh9S8PFUusXrmO
         tQ1NbyZSlgA4FPbzu9A8HqvcBv6IevVtIqPqckKlCeWNx6f/LZMXx3m3wkqzgPBODwON
         A23SHt4+/TvMrQPKm5VqPrPDTCfWyqPsR64gIO2TxUCGhyTUnXBDkCKClVy6YA/2kR8J
         AVxUk29+e/Mt3FrMDymsIlcXgI1S3JmuIb6SWUHfGjxvaA+HTXjzHwGAJeWEUO3Qqj90
         LSXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8W7vay3C4kJVTbRrfHrHZEyEls1HHkDBMzLd57GOkL8=;
        b=jBWROJoqUcrXvlGzmygWoyKbWURCXqI+XyM0Fr9yp0lIwrNDj126HuqcIN+YBCJYRx
         AdvARwXgjlhx2cb17u9CvudIp6VotTOqUw+DS0tz3yateMllT7ZRLLMvLnt4j5cJm+uB
         oiV1QK7Z6Aqe8EyQ7jP5GwfStilRh5Ez42gyJ6Y9ByGpNyDFiWQS7uOBUKAaYUmqQgkL
         CS29MWMuf7hgQX5ajIp3KQhaGuUzAShmPW3g815vb/Yuxs/yiB7unjY9uDfbbWJFT1OZ
         zH4MQOUL+/MZucy2C7gwDmD3Ov2IGIL3TCL/k9z+8h3UnVvU2BSpJa33nCbuTSqiiKlO
         Vt1Q==
X-Gm-Message-State: ABuFfoh0W76tFbUZf10bOVT13zprVaos4LRd/3afdLIa4k0YCkCvnZKJ
        h3CL99ZwcUHuJblo7Pi5sH43qw==
X-Google-Smtp-Source: ACcGV60mljoAKIjlah6gQ4ZzMPP7kBb2RxfqyXBeh5floH2eA3GmG5tHHNDDEnm+38OXFx3q79e32w==
X-Received: by 2002:a1c:14d1:: with SMTP id 200-v6mr16935601wmu.106.1539024072668;
        Mon, 08 Oct 2018 11:41:12 -0700 (PDT)
Received: from brauner.io ([2a02:8070:8895:9700:8197:8849:535a:4f00])
        by smtp.gmail.com with ESMTPSA id b139-v6sm24607279wmd.36.2018.10.08.11.41.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Oct 2018 11:41:11 -0700 (PDT)
Date:   Mon, 8 Oct 2018 20:41:05 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>,
        linux-api@vger.kernel.org, containers@lists.linux-foundation.org,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v7 3/6] seccomp: add a way to get a listener fd from
 ptrace
Message-ID: <20181008184104.4vngt5k24bog3j4f@brauner.io>
References: <20180927151119.9989-1-tycho@tycho.ws>
 <20180927151119.9989-4-tycho@tycho.ws>
 <20181008151629.hkgzzsluevwtuclw@brauner.io>
 <20181008180043.GE28238@cisco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181008180043.GE28238@cisco.lan>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 12:00:43PM -0600, Tycho Andersen wrote:
> On Mon, Oct 08, 2018 at 05:16:30PM +0200, Christian Brauner wrote:
> > On Thu, Sep 27, 2018 at 09:11:16AM -0600, Tycho Andersen wrote:
> > > As an alternative to SECCOMP_FILTER_FLAG_GET_LISTENER, perhaps a ptrace()
> > > version which can acquire filters is useful. There are at least two reasons
> > > this is preferable, even though it uses ptrace:
> > > 
> > > 1. You can control tasks that aren't cooperating with you
> > > 2. You can control tasks whose filters block sendmsg() and socket(); if the
> > >    task installs a filter which blocks these calls, there's no way with
> > >    SECCOMP_FILTER_FLAG_GET_LISTENER to get the fd out to the privileged task.
> > 
> > So for the slow of mind aka me:
> > I'm not sure I completely understand this problem. Can you outline how
> > sendmsg() and socket() are involved in this?
> > 
> > I'm also not sure that this holds (but I might misunderstand the
> > problem) afaict, you could do try to get the fd out via CLONE_FILES and
> > other means so something like: 
> > 
> > // let's pretend the libc wrapper for clone actually has sane semantics
> > pid = clone(CLONE_FILES);
> > if (pid == 0) {
> >         fd = seccomp(SECCOMP_SET_MODE_FILTER, SECCOMP_FILTER_FLAG_NEW_LISTENER, &prog);
> > 
> >         // Now this fd will be valid in both parent and child.
> >         // If you haven't blocked it you can inform the parent what
> >         // the fd number is via pipe2(). If you have blocked it you can
> >         // use dup2() and dup to a known fd number.
> > }
> 
> But what if your seccomp filter wants to block both pipe2() and
> dup2()? Whatever syscall you want to use to do this could be blocked

(Fwiw, setup shared memory before the clone(CLONE_FILES) and write the
fd in the shared memory. :))


> by some seccomp policy, which means you might not be able to use this
> feature in some cases.

> 
> Perhaps it's unlikely, and we can just go forward knowing this. But it
> seems like it is worth at least acknowledging that you can wedge
> yourself into a corner.

Sure, if you try really really hard to shoot yourself in the foot you'll
always be able to. From the top of my hat I'd say you can at least
probably filter the seccomp() syscall with the listener argument. Once
you've loaded the policy you're out of luck.
You also might be seccomp confided and not be able to use the ptrace()
syscall. AppArmor might prevent you from using ptrace()ing etc. pp.

So I think we really want both ways but the seccomp interface is way
cleaner. To get the fd from ptrace() you need three syscalls. With
seccomp() you need one.
