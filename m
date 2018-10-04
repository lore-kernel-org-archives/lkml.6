Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C0AC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 17:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A57C42087D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 17:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="TrS5aZtV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A57C42087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbeJEAV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 20:21:58 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37926 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727608AbeJEAV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 20:21:58 -0400
Received: by mail-wr1-f68.google.com with SMTP id a13-v6so10789275wrt.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 10:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=P8kl98Li1rt5lR6hobg7mb5TDDvSb/hXl7BfveHi2xU=;
        b=TrS5aZtV74qgb8CH6liKgn6kkk9hh6ssqMpSPQBBMKY47qFsuLdGSG8dyiODQgoXNE
         uq6HVp/6C2DHWo5gtLl23Xdi0PflFr5hOrimeo1yQZ6WOC2wDhlwoqqectmhnJhsFFq6
         duGHm0xH2N6z1QOKAZi4fVHXh4JPqpTYBXN5Bs4wEZEAqrOfRLSlBQHgTQFShxJSEcyg
         mzLKEoP8OSEUBYtq9/leULmhtmS1fZ4068njHpq98/CN9ByMj7UU8ud1YtUnwA5wuE2t
         trPzBR1kG+jvzpXaL+U71DEH27HvQprQKCO9z+cKeC0IpEEvPxfkCLwzlTZZ8A2lmUVD
         3myQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=P8kl98Li1rt5lR6hobg7mb5TDDvSb/hXl7BfveHi2xU=;
        b=kxltaz95QoeMRt1DTdoq4QFIrTLws06Q8NJrw/3T7inaMa7+iPFtiwxFejbDzHOM8f
         NriQCqCXmvvRB7itN+mjOIoSjYHhr9rPLhT4iu7HDNqlFOJcL5vIZOZKZFL1VTjtbow+
         8DV/XT+A2zpc91Rsi9E5m0gqI3Dm/oP3blbqx9uVJvqpd6X+VEwb8VOaLKotTUmtq6wH
         vRb/EuClXgUllHfG+g9cMsrzBn0aphF1IMrjlvvLc9cehXggbXmKBP5bqae9pkVEmMP0
         VPi7yhjWkPPvNvCthNqSjo2kZO1eEmmwuIxNn6jYkiOdabtldz3EdW38V3tXtkWnrR5L
         N35Q==
X-Gm-Message-State: ABuFfoghVQwUbYbS9dOrczE91q+TScURy590NVDd52Iw+UAWHRHH2q+G
        hWtqLIYah/dIhaGlL+TmggqiWQ==
X-Google-Smtp-Source: ACcGV60FQrDq60gL+ftCLZfG1GcOPcjvsF005LIM3PAfS55F1Cb3Ek/WhigA0O1yqc5P+mBF9Raqtg==
X-Received: by 2002:adf:9464:: with SMTP id 91-v6mr5720936wrq.200.1538674061417;
        Thu, 04 Oct 2018 10:27:41 -0700 (PDT)
Received: from brauner.io ([2a02:8070:8895:9700:2824:7b8c:14f1:9980])
        by smtp.gmail.com with ESMTPSA id e14-v6sm4609678wrs.69.2018.10.04.10.27.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Oct 2018 10:27:40 -0700 (PDT)
Date:   Thu, 4 Oct 2018 19:27:34 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Jann Horn <jannh@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Al Viro <viro@zeniv.linux.org.uk>, jlayton@kernel.org,
        Bruce Fields <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>, shuah@kernel.org,
        David Howells <dhowells@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Tycho Andersen <tycho@tycho.ws>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, dev@opencontainers.org,
        containers@lists.linux-foundation.org,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH 2/3] namei: implement AT_THIS_ROOT chroot-like path
 resolution
Message-ID: <20181004172733.x75nmwqan2iu3kyv@brauner.io>
References: <20180929103453.12025-1-cyphar@cyphar.com>
 <20180929131534.24472-1-cyphar@cyphar.com>
 <CAG48ez30WJhbsro2HOc_DR7V91M+hNFzBP5ogRMZaxbAORvqzg@mail.gmail.com>
 <20181001054246.gfinmx3api7kjhmc@ryuk>
 <CAG48ez3ApZC5cGzTxyt1ej0CyhYPD4PUEf5nbkqPmNbO+daOXQ@mail.gmail.com>
 <20181001161833.sg5iy6gk7n7crcvy@ryuk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181001161833.sg5iy6gk7n7crcvy@ryuk>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 02:18:33AM +1000, Aleksa Sarai wrote:
> On 2018-10-01, Jann Horn <jannh@google.com> wrote:
> > > If this is an issue for AT_THIS_ROOT, I believe this might also be an
> > > issue for AT_BENEATH since they are effectively both using the same
> > > nd->root trick (so you could similarly trick AT_BENEATH to not error
> > > out). So we'd need to figure out how to solve this problem in order for
> > > AT_BENEATH to be safe.
> > 
> > Oh, wait, what? I think I didn't notice that the semantics of
> > AT_BENEATH changed like that since the original posting of David
> > Drysdale's O_BENEATH_ONLY patch
> > (https://lore.kernel.org/lkml/1439458366-8223-2-git-send-email-drysdale@google.com/).
> > David's patch had nice, straightforward semantics, blocking any form
> > of upwards traversal. Why was that changed? Does anyone actually want
> > to use paths that contain ".." with AT_BENEATH? I would strongly
> > prefer something that blocks any use of "..".
> > 
> > @Al: It looks like this already changed back when you posted
> > https://lore.kernel.org/lkml/20170429220414.GT29622@ZenIV.linux.org.uk/
> > ?
> 
> Yes, I copied the semantics from Al's patchset. I don't know why he felt
> strongly that this was the best idea, but in my opinion allowing paths
> like "a/../b/../c" seems like it's quite useful because otherwise you
> wouldn't be able to operate on most distribution root filesystems (many
> have symlinks that have ".." components). Looking at my own (openSUSE)
> machine there are something like 100k such symlinks (~37% of symlinks on
> my machine).
> 
> While I do understand that the easiest way of solving this problem is to
> disallow ".." entirely with AT_BENEATH, given that support ".." has
> utility, I would like to know whether it's actually not possible to have
> this work safely.
> 
> > > Speaking naively, doesn't it make sense to invalidate the walk if a path
> > > component was modified? Or is this something that would be far too
> > > costly with little benefit? What if we do more aggressive nd->root
> > > checks when resolving with AT_BENEATH or AT_THIS_ROOT (or if nd->root !=
> > > current->mnt_ns->root)?
> > 
> > It seems to me like doing that would basically require looking at each
> > node in the path walk twice? And it'd be difficult to guarantee
> > forward progress unless you're willing to do some fairly heavy
> > locking.
> 
> I had another idea since I wrote my previous mail -- since the issue (at
> least the way I understand it) is that ".." can "skip" over nd->root
> because of the rename, what if we had some sort of is_descendant() check
> within follow_dotdot()? (FWIW, ".." already has some pretty interesting
> "hand-over-hand" locking semantics.) This should be effectively similar
> to how prepend_path() deals with a path that is not reachable from @root
> (I'm not sure if the locking is acceptable for the namei path though).
> 
> Since ".." with AT_THIS_ROOT (or AT_BENEATH) is not going to be the most
> common component type (and we only need to do these checks for those
> flags), I would think that the extra cost would not be _that_ awful.
> 
> Would this work?
> 
> > > You're right about this -- for C runtimes. In Go we cannot do a raw
> > > clone() or fork() (if you do it manually with RawSyscall you'll end with
> > > broken runtime state). So you're forced to do fork+exec (which then
> > > means that you can't use CLONE_FILES and must use SCM_RIGHTS). Same goes
> > > for CLONE_VFORK.
> > 
> > If you insist on implementing every last bit of your code in Go, I guess.
> 
> Fair enough, though I believe this would affect most multi-threaded
> programs as well (regardless of the language they're written in).

(Depends on whether you do any explicit locking and have atfork handlers
for your locks and so on. If you do a clone syscall directly to avoid
having libc running any additional atfork handlers (flushing streams
etc.) it's doable though not ideal.)
