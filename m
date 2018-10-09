Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F2BEC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D43542086D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:09:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="c0fS0aM1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D43542086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbeJIV0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 17:26:51 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35416 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbeJIV0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 17:26:51 -0400
Received: by mail-wm1-f68.google.com with SMTP id e187-v6so2178628wmf.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 07:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+ySPUymLT4MeIZyqVH+Mo2WUpYK0f8EwMdFIOn+Ivak=;
        b=c0fS0aM1d9+FlyRqNyTdGj5d1RA3FpamoClDW6Bf5rjXkceQnw/zVKQCZetlMW5mDR
         08UyB6hW8H0aAvZl7YhrNOyzCyNy9x1i0k72zH9lBn9nFHyNZu2ZJToaO6zBu0k+29sh
         vN1xshfAtA1G7kg0I7NnGFdlvu3cEWKJG7E4mA7b/qr4aDo3i7H/rT6soYkXzquHkPir
         Fn7EUtiCHyuIy2YEN0Sk67quWprE0H/K+iVp6hxqEd8/108UYXvhYsScK4YH9jOcBumw
         LC5xvffYgpLpEABpbcZjna5LRu2OIpKFLOFJanSkyWgUzgfjA3PRAs9y932PBcbaVsKw
         Fkkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+ySPUymLT4MeIZyqVH+Mo2WUpYK0f8EwMdFIOn+Ivak=;
        b=L7pxcoMeKDLjXynitGydyDDklwk7V1XlH7KB6tHfX+5yH55tCXHHQZI2ZPCaxqz1sF
         UbdULE6EEZlAoNlo7LHQy3b+lU+1m8TDWMIAL8e7IfW0TnB79UfUgCwlyL+KfuyJjbrW
         AVnK4DFmSooIHV20VGVkeQOF2nSetnLGd5TipQdOZhO0mIrPSfsUOs7lUMOJdEvVQ50+
         KCQVLV7Of5ph7ra0XS7QM0u4L+yNUvcvOrSRzcqBN5pVYncelt5AJDaGio4Uf9ECKORM
         JGgQKeAdyRcZ/nC1G3Dcmg6f8MA7p69/0e0x70Hm1Bo2HZ9d2ZXL76HGn1HHv9bOdb+K
         u4WA==
X-Gm-Message-State: ABuFfohoDg21E6QwCY0Xy4fowJkpLC6p131tPKyzMwy1ofgV5+BQBZ9z
        1Va+WX9dfWUhqYYZgkzWP5CsLA==
X-Google-Smtp-Source: ACcGV611WWMBCCZuDDiNL2Yh4RhR7H/G1PP6z7BDHq6Z18hGgjpE1joRuLDPcvLz+siJIUSh+J3ZqQ==
X-Received: by 2002:a1c:b605:: with SMTP id g5-v6mr1996725wmf.97.1539094181268;
        Tue, 09 Oct 2018 07:09:41 -0700 (PDT)
Received: from brauner.io (u-084-c138.eap.uni-tuebingen.de. [134.2.84.138])
        by smtp.gmail.com with ESMTPSA id y76-v6sm5191999wmd.37.2018.10.09.07.09.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 07:09:39 -0700 (PDT)
Date:   Tue, 9 Oct 2018 16:09:33 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Jann Horn <jannh@google.com>
Cc:     Tycho Andersen <tycho@tycho.ws>, Kees Cook <keescook@chromium.org>,
        Linux API <linux-api@vger.kernel.org>,
        containers@lists.linux-foundation.org, suda.akihiro@lab.ntt.co.jp,
        Oleg Nesterov <oleg@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andy Lutomirski <luto@amacapital.net>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        selinux@tycho.nsa.gov, Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>
Subject: Re: [PATCH v7 3/6] seccomp: add a way to get a listener fd from
 ptrace
Message-ID: <20181009140932.e5w5lgbgucbl72kt@brauner.io>
References: <20181008151629.hkgzzsluevwtuclw@brauner.io>
 <CAG48ez3zaqOXH_jHN8=+jXjOf3vhFyWUkM_6KLPi9T8HcQySeg@mail.gmail.com>
 <20181008162147.ubfxxsv2425l2zsp@brauner.io>
 <CAG48ez3O+wAkq+0yDfoMt73ybnCOEPpi3Mu-uF57_v=6hA8ZEw@mail.gmail.com>
 <20181008181815.pwnqxngj22mhm2vj@brauner.io>
 <CAG48ez3PEce4ynRnDk=yfsAOuFGH=YMmuf13CAxEt07Yjk3ZCw@mail.gmail.com>
 <20181009132850.fp6yne2vgmfpi27k@brauner.io>
 <CAG48ez2EV8Z=Egn7hNpXd86bHdvQhVxStqE1N=U2L2R7sA-gjg@mail.gmail.com>
 <20181009134923.2fvf5roghqgaj5gq@brauner.io>
 <CAG48ez1hnKkm7mzXuZLP4n6x8K1JqmTwQb-e79oJguTaH1mkUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAG48ez1hnKkm7mzXuZLP4n6x8K1JqmTwQb-e79oJguTaH1mkUw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2018 at 03:50:53PM +0200, Jann Horn wrote:
> On Tue, Oct 9, 2018 at 3:49 PM Christian Brauner <christian@brauner.io> wrote:
> >
> > On Tue, Oct 09, 2018 at 03:36:04PM +0200, Jann Horn wrote:
> > > +cc selinux people explicitly, since they probably have opinions on this
> > >
> > > On Tue, Oct 9, 2018 at 3:29 PM Christian Brauner <christian@brauner.io> wrote:
> > > > On Tue, Oct 09, 2018 at 02:39:53PM +0200, Jann Horn wrote:
> > > > > On Mon, Oct 8, 2018 at 8:18 PM Christian Brauner <christian@brauner.io> wrote:
> > > > > > On Mon, Oct 08, 2018 at 06:42:00PM +0200, Jann Horn wrote:
> > > > > > > On Mon, Oct 8, 2018 at 6:21 PM Christian Brauner <christian@brauner.io> wrote:
> > > > > > > > On Mon, Oct 08, 2018 at 05:33:22PM +0200, Jann Horn wrote:
> > > > > > > > > On Mon, Oct 8, 2018 at 5:16 PM Christian Brauner <christian@brauner.io> wrote:
> > > > > > > > > > On Thu, Sep 27, 2018 at 09:11:16AM -0600, Tycho Andersen wrote:
> > > > > > > > > > > diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> > > > > > > > > > > index 44a31ac8373a..17685803a2af 100644
> > > > > > > > > > > --- a/kernel/seccomp.c
> > > > > > > > > > > +++ b/kernel/seccomp.c
> > > > > > > > > > > @@ -1777,4 +1777,35 @@ static struct file *init_listener(struct task_struct *task,
> > > > > > > > > > >
> > > > > > > > > > >       return ret;
> > > > > > > > > > >  }
> > > > > > > > > > > +
> > > > > > > > > > > +long seccomp_new_listener(struct task_struct *task,
> > > > > > > > > > > +                       unsigned long filter_off)
> > > > > > > > > > > +{
> > > > > > > > > > > +     struct seccomp_filter *filter;
> > > > > > > > > > > +     struct file *listener;
> > > > > > > > > > > +     int fd;
> > > > > > > > > > > +
> > > > > > > > > > > +     if (!capable(CAP_SYS_ADMIN))
> > > > > > > > > > > +             return -EACCES;
> > > > > > > > > >
> > > > > > > > > > I know this might have been discussed a while back but why exactly do we
> > > > > > > > > > require CAP_SYS_ADMIN in init_userns and not in the target userns? What
> > > > > > > > > > if I want to do a setns()fd, CLONE_NEWUSER) to the target process and
> > > > > > > > > > use ptrace from in there?
> > > > > > > > >
> > > > > > > > > See https://lore.kernel.org/lkml/CAG48ez3R+ZJ1vwGkDfGzKX2mz6f=jjJWsO5pCvnH68P+RKO8Ow@mail.gmail.com/
> > > > > > > > > . Basically, the problem is that this doesn't just give you capability
> > > > > > > > > over the target task, but also over every other task that has the same
> > > > > > > > > filter installed; you need some sort of "is the caller capable over
> > > > > > > > > the filter and anyone who uses it" check.
> > > > > > > >
> > > > > > > > Thanks.
> > > > > > > > But then this new ptrace feature as it stands is imho currently broken.
> > > > > > > > If you can install a seccomp filter with SECCOMP_RET_USER_NOTIF if you
> > > > > > > > are ns_cpabable(CAP_SYS_ADMIN) and also get an fd via seccomp() itself
> > > > > > > > if you are ns_cpabable(CAP_SYS_ADMIN)
> > > > >
> > > > > Actually, you don't need CAP_SYS_ADMIN for seccomp() at all as long as
> > > > > you enable the NNP flag, I think?
> > > >
> > > > Yes, if you turn on NNP you don't even need sys_admin.
> > > >
> > > > >
> > > > > > > > then either the new ptrace() api
> > > > > > > > extension should be fixed to allow for this too or the seccomp() way of
> > > > > > > > retrieving the pid - which I really think we want - needs to be fixed to
> > > > > > > > require capable(CAP_SYS_ADMIN) too.
> > > > > > > > The solution where both require ns_capable(CAP_SYS_ADMIN) is - imho -
> > > > > > > > the preferred way to solve this.
> > > > > > > > Everything else will just be confusing.
> > > > > > >
> > > > > > > First you say "broken", then you say "confusing". Which one do you mean?
> > > > > >
> > > > > > Both. It's broken in so far as it places a seemingly unnecessary
> > > > > > restriction that could be fixed. You outlined one possible fix yourself
> > > > > > in the link you provided.
> > > > >
> > > > > If by "possible fix" you mean "check whether the seccomp filter is
> > > > > only attached to a single task": That wouldn't fundamentally change
> > > > > the situation, it would only add an additional special case.
> > > > >
> > > > > > And it's confusing in so far as there is a way
> > > > > > via seccomp() to get the fd without said requirement.
> > > > >
> > > > > I don't find it confusing at all. seccomp() and ptrace() are very
> > > >
> > > > Fine, then that's a matter of opinion. I find it counterintuitive that
> > > > you can get an fd without privileges via one interface but not via
> > > > another.
> > > >
> > > > > different situations: When you use seccomp(), infrastructure is
> > > >
> > > > Sure. Note, that this is _one_ of the reasons why I want to make sure we
> > > > keep the native seccomp() only based way of getting an fd without
> > > > forcing userspace to switching to a differnet kernel api.
> > > >
> > > > > already in place for ensuring that your filter is only applied to
> > > > > processes over which you are capable, and propagation is limited by
> > > > > inheritance from your task down. When you use ptrace(), you need a
> > > > > pretty different sort of access check that checks whether you're
> > > > > privileged over ancestors, siblings and so on of the target task.
> > > >
> > > > So, don't get me wrong I'm not arguing against the ptrace() interface in
> > > > general. If this is something that people find useful, fine. But, I
> > > > would like to have a simple single-syscall pure-seccomp() based way of
> > > > getting an fd, i.e. what we have in patch 1 of this series.
> > >
> > > Yeah, I also prefer the seccomp() one.
> > >
> > > > > But thinking about it more, I think that CAP_SYS_ADMIN over the saved
> > > > > current->mm->user_ns of the task that installed the filter (stored as
> > > > > a "struct user_namespace *" in the filter) should be acceptable.
> > > >
> > > > Hm... Why not CAP_SYS_PTRACE?
> > >
> > > Because LSMs like SELinux add extra checks that apply even if you have
> > > CAP_SYS_PTRACE, and this would subvert those. The only capability I
> > > know of that lets you bypass LSM checks by design (if no LSM blocks
> > > the capability itself) is CAP_SYS_ADMIN.
> > >
> > > > One more thing. Citing from [1]
> > > >
> > > > > I think there's a security problem here. Imagine the following scenario:
> > > > >
> > > > > 1. task A (uid==0) sets up a seccomp filter that uses SECCOMP_RET_USER_NOTIF
> > > > > 2. task A forks off a child B
> > > > > 3. task B uses setuid(1) to drop its privileges
> > > > > 4. task B becomes dumpable again, either via prctl(PR_SET_DUMPABLE, 1)
> > > > > or via execve()
> > > > > 5. task C (the attacker, uid==1) attaches to task B via ptrace
> > > > > 6. task C uses PTRACE_SECCOMP_NEW_LISTENER on task B
> > > >
> > > > Sorry, to be late to the party but would this really pass
> > > > __ptrace_may_access() in ptrace_attach()? It doesn't seem obvious to me
> > > > that it would... Doesn't look like it would get past:
> > > >
> > > >         tcred = __task_cred(task);
> > > >         if (uid_eq(caller_uid, tcred->euid) &&
> > > >             uid_eq(caller_uid, tcred->suid) &&
> > > >             uid_eq(caller_uid, tcred->uid)  &&
> > > >             gid_eq(caller_gid, tcred->egid) &&
> > > >             gid_eq(caller_gid, tcred->sgid) &&
> > > >             gid_eq(caller_gid, tcred->gid))
> > > >                 goto ok;
> > > >         if (ptrace_has_cap(tcred->user_ns, mode))
> > > >                 goto ok;
> > > >         rcu_read_unlock();
> > > >         return -EPERM;
> > > > ok:
> > > >         rcu_read_unlock();
> > > >         mm = task->mm;
> > > >         if (mm &&
> > > >             ((get_dumpable(mm) != SUID_DUMP_USER) &&
> > > >              !ptrace_has_cap(mm->user_ns, mode)))
> > > >             return -EPERM;
> > >
> > > Which specific check would prevent task C from attaching to task B? If
> > > the UIDs match, the first "goto ok" executes; and you're dumpable, so
> > > you don't trigger the second "return -EPERM".
> >
> > You'd also need CAP_SYS_PTRACE in the mm->user_ns which you shouldn't
> > have if you did a setuid to an unpriv user. (But I always find that code
> > confusing.)
> 
> Only if the target hasn't gone through execve() since setuid().

Sorry if I want to know this in excessive detail but I'd like to
understand this properly so bear with me :)
- If task B has setuid()ed and prctl(PR_SET_DUMPABLE, 1)ed but not
  execve()ed then C won't pass ptrace_has_cap(mm->user_ns, mode).
- If task B has setuid()ed, exeved()ed it will get its dumpable flag set
  to /proc/sys/fs/suid_dumpable which by default is 0. So C won't pass
  (get_dumpable(mm) != SUID_DUMP_USER).
In both cases PTRACE_ATTACH shouldn't work. Now, if
/proc/sys/fs/suid_dumpable is 1 I'd find it acceptable for this to work.
This is an administrator choice.
