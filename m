Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C28CC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30A592075C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="Yi+3k0O2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30A592075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbeJIXmG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 19:42:06 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41642 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbeJIXmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 19:42:05 -0400
Received: by mail-wr1-f66.google.com with SMTP id x12-v6so2490603wru.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 09:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BxpOvtOGRVXADev/Tnf0WKUksiK8WRPMFDd73PhsQ8c=;
        b=Yi+3k0O2mhGED62I0zIzPUWcrHsshoLt13FkcMiFgvK6HGtzDXmQOqqfa/ZS7kXKrM
         fnS/LAvh9WQmwJQiqFkfw0hqfdkPLKBraJNbK62DJCkrFnmun0VzBq+CAl9C9Ai8Sk3s
         fuWParM4oLDLf46bcBOdcJYudpIzBq05+s1p6YiniIOIGazgfLhEdAkpjieoqRWo0BM1
         80H8hjrEpdn4//RYJAGDjfn0phSBFQzf9Li3ZOvcZditFpPmxk1i0s/U0IQ6YFDmdDHv
         LxY2LveDCUqy7Yvh0ul8EY7+vwzLiuJV/wHZLEXFUxoeLKw7MlncoxNHJoxGdn3CeqUX
         vzPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BxpOvtOGRVXADev/Tnf0WKUksiK8WRPMFDd73PhsQ8c=;
        b=jPS4V0pXOjE9alCrBfUic2SGRnRilJvAS6F1ZOALCPvqRs+EKG4tEG838JW7KxGc0o
         xuVXIBB5mrYQMIpdtPDF5TXuGAGf2Y66t2xsNY/62Tv2dfsP7fPxUrMDG5bbXk2LJBjW
         wJC1PRKuzA/c2lotxb4kguw+rG4KAaIKtOCZQ6K+Hg7HsCLxrY07mxLH1O33Qrovk9hU
         mL5SwMsn9l68aq72ewrd0lepcyPIfnh45A+XIDGphAeszqn+OwN9XhcXT6DROcyFQXAH
         Wyig0/F4zyyATVs4ag0YLc4HP1zvBtPZzEloPUxiWC+LlP7KjvJ+NUkzcUhp+jgpwpjI
         Du4Q==
X-Gm-Message-State: ABuFfogPhD0FOwq38DiE4sTFCHSKQBtAYSLYwhUqcGod9E+WiVYHlM68
        tVqNNHMOWkJoLFBMVNZssyI3mg==
X-Google-Smtp-Source: ACcGV62P5F5I/QHAi8pAeX2jSuTiSqhIV0+dgb/GXrxn8xmr6/X9uziZcyE6Xymik8aTvOlI4fSuNg==
X-Received: by 2002:a5d:4dd2:: with SMTP id f18-v6mr22217411wru.80.1539102261613;
        Tue, 09 Oct 2018 09:24:21 -0700 (PDT)
Received: from brauner.io ([2a02:8070:8895:9700:8197:8849:535a:4f00])
        by smtp.gmail.com with ESMTPSA id v76-v6sm22265029wmd.32.2018.10.09.09.24.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 09:24:20 -0700 (PDT)
Date:   Tue, 9 Oct 2018 18:24:14 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Oleg Nesterov <oleg@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v7 1/6] seccomp: add a return code to trap to userspace
Message-ID: <20181009162413.sry5hnplvvpjggd4@brauner.io>
References: <20180927151119.9989-1-tycho@tycho.ws>
 <20180927151119.9989-2-tycho@tycho.ws>
 <CAGXu5jJr3JWLYGrJ+knu3sj4wwJ_irVvs+JRrY5MuYT3voLegg@mail.gmail.com>
 <20180927224839.GF15491@cisco.cisco.com>
 <20181008145803.ycawjwhc3mwkdogf@brauner.io>
 <20181009142833.GA10149@cisco>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181009142833.GA10149@cisco>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2018 at 07:28:33AM -0700, Tycho Andersen wrote:
> On Mon, Oct 08, 2018 at 04:58:05PM +0200, Christian Brauner wrote:
> > On Thu, Sep 27, 2018 at 04:48:39PM -0600, Tycho Andersen wrote:
> > > On Thu, Sep 27, 2018 at 02:31:24PM -0700, Kees Cook wrote:
> > > > I have to say, I'm vaguely nervous about changing the semantics here
> > > > for passing back the fd as the return code from the seccomp() syscall.
> > > > Alternatives seem less appealing, though: changing the meaning of the
> > > > uargs parameter when SECCOMP_FILTER_FLAG_NEW_LISTENER is set, for
> > > > example. Hmm.
> > > 
> > > From my perspective we can drop this whole thing. The only thing I'll
> > > ever use is the ptrace version. Someone at some point (I don't
> > > remember who, maybe stgraber) suggested this version would be useful
> > > as well.
> > 
> > So I think we want to have the ability to get an fd via seccomp().
> > Especially, if we all we worry about are weird semantics. When we
> > discussed this we knew the whole patchset was going to be weird. :)
> > 
> > This is a seccomp feature so seccomp should - if feasible - equip you
> > with everything to use it in a meaningful way without having to go
> > through a different kernel api. I know ptrace and seccomp are
> > already connected but I still find this cleaner. :)
> > 
> > Another thing is that the container itself might be traced for some
> > reason while you still might want to get an fd out.
> 
> Sure, I don't see the problem here.

How'd you to PTRACE_ATTACH in that case?

Anyway, the whole point is as we've discusses in the other thread we
really want a one-syscall-only, purely-seccomp() based way of getting
the fd. There are multiple options to get the fd even when you block
sendmsg()/socket() whatever and there's no good reason to only be able
to get the fd via a three-syscall-ptrace dance. :)
