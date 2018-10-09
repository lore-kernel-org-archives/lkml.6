Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1253ECDE44
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A8902075C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="L47BK+ce"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A8902075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbeJIXiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 19:38:15 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44092 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbeJIXiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 19:38:15 -0400
Received: by mail-wr1-f66.google.com with SMTP id 63-v6so2479845wra.11
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 09:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=emzlWK3DpHPymOZVypUVrrtsXXbZs1u71okMqU+xyys=;
        b=L47BK+ce6egki5LfXus+J9ghGGqnXX+Jnq2VzP9EaqGql7KHLgc6AyW7o9XePrJ7b2
         FstTIUn6orFo65mWZpP4un77Ehayd4yB96YTQDZzc8sBMxb18qCKxOPt3B+Rxgi8bEw5
         tutc4lWs5c5M/3pFHXdfZnPeeWiWg1l/UnK3Ixgar4fkDNgOIdOKwM01/q743NAgO2xc
         6itCYI0wGCzehtlrVf9fihiZWdoxLeGEqEpRLHCb/5JljjlNRChRPXMwFsGicddWaO3t
         L8GSUo38K8+pu5f3GdQk2Rj+TYPEp/+DCYB+ZU0I/dkvvP+PBQJ/chQ4mqdE3284YirN
         CIug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=emzlWK3DpHPymOZVypUVrrtsXXbZs1u71okMqU+xyys=;
        b=NeTRHMG7ddQkXP/Q0kMrNMw5J1Q4jBR63VV0WkDeBtL8lskFaUGvWBdNGOz4f+nZET
         /LfwOVXDV49yvYujyox9u30AgqXgMH45vJlqSR7IlYB+hsog7zvXkgCPT8m4+91usjs3
         NGyw4QJ95qicPNhpZH8LvYUjp416GsCnKv8BDk4kMG9TK+edOLSVhXW5x+qWmp6PGefH
         zAwUTjfmIaiCo2h4q/JKfvv9J95zo1hdNuZkwSl4aE0fRuerDIb5xs8rVgYMdBXCa7LC
         GPt+Pyh7aM90Eb3s8CExA7n8W/LUK0JyxwAPY6PA5IAOnGvb83mlyhAXnfzc3cwnWk0u
         /TVg==
X-Gm-Message-State: ABuFfoiEE7vKKBWHTu4+YxYjjnu/iPhu5J2PJRbSwEwtGuXddBXAwnLd
        lmkH8e1XibxdmnMnThgA9/ZM4Q==
X-Google-Smtp-Source: ACcGV60GGb5jDrwC/POVOUcnvlBsaNvTqf/uK+uH/bU7UyLryle49/Vo2Qw/BNZmCbhSLT8KNqNqOg==
X-Received: by 2002:adf:afdd:: with SMTP id y29-v6mr21817130wrd.176.1539102031225;
        Tue, 09 Oct 2018 09:20:31 -0700 (PDT)
Received: from brauner.io ([2a02:8070:8895:9700:8197:8849:535a:4f00])
        by smtp.gmail.com with ESMTPSA id l4-v6sm24133813wrb.92.2018.10.09.09.20.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 09:20:30 -0700 (PDT)
Date:   Tue, 9 Oct 2018 18:20:24 +0200
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
Message-ID: <20181009162022.d7fd2wibyq6xi6sg@brauner.io>
References: <20181008162147.ubfxxsv2425l2zsp@brauner.io>
 <CAG48ez3O+wAkq+0yDfoMt73ybnCOEPpi3Mu-uF57_v=6hA8ZEw@mail.gmail.com>
 <20181008181815.pwnqxngj22mhm2vj@brauner.io>
 <CAG48ez3PEce4ynRnDk=yfsAOuFGH=YMmuf13CAxEt07Yjk3ZCw@mail.gmail.com>
 <20181009132850.fp6yne2vgmfpi27k@brauner.io>
 <CAG48ez2EV8Z=Egn7hNpXd86bHdvQhVxStqE1N=U2L2R7sA-gjg@mail.gmail.com>
 <20181009134923.2fvf5roghqgaj5gq@brauner.io>
 <CAG48ez1hnKkm7mzXuZLP4n6x8K1JqmTwQb-e79oJguTaH1mkUw@mail.gmail.com>
 <20181009140932.e5w5lgbgucbl72kt@brauner.io>
 <CAG48ez12SYRUJTWRdzWhpvHBkQion4i8Gpef4r1L6epo9JF-ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAG48ez12SYRUJTWRdzWhpvHBkQion4i8Gpef4r1L6epo9JF-ng@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2018 at 05:26:26PM +0200, Jann Horn wrote:
> On Tue, Oct 9, 2018 at 4:09 PM Christian Brauner <christian@brauner.io> wrote:
> > On Tue, Oct 09, 2018 at 03:50:53PM +0200, Jann Horn wrote:
> > > On Tue, Oct 9, 2018 at 3:49 PM Christian Brauner <christian@brauner.io> wrote:
> > > > On Tue, Oct 09, 2018 at 03:36:04PM +0200, Jann Horn wrote:
> > > > > On Tue, Oct 9, 2018 at 3:29 PM Christian Brauner <christian@brauner.io> wrote:
> > > > > > One more thing. Citing from [1]
> > > > > >
> > > > > > > I think there's a security problem here. Imagine the following scenario:
> > > > > > >
> > > > > > > 1. task A (uid==0) sets up a seccomp filter that uses SECCOMP_RET_USER_NOTIF
> > > > > > > 2. task A forks off a child B
> > > > > > > 3. task B uses setuid(1) to drop its privileges
> > > > > > > 4. task B becomes dumpable again, either via prctl(PR_SET_DUMPABLE, 1)
> > > > > > > or via execve()
> > > > > > > 5. task C (the attacker, uid==1) attaches to task B via ptrace
> > > > > > > 6. task C uses PTRACE_SECCOMP_NEW_LISTENER on task B
> > > > > >
> > > > > > Sorry, to be late to the party but would this really pass
> > > > > > __ptrace_may_access() in ptrace_attach()? It doesn't seem obvious to me
> > > > > > that it would... Doesn't look like it would get past:
> > > > > >
> > > > > >         tcred = __task_cred(task);
> > > > > >         if (uid_eq(caller_uid, tcred->euid) &&
> > > > > >             uid_eq(caller_uid, tcred->suid) &&
> > > > > >             uid_eq(caller_uid, tcred->uid)  &&
> > > > > >             gid_eq(caller_gid, tcred->egid) &&
> > > > > >             gid_eq(caller_gid, tcred->sgid) &&
> > > > > >             gid_eq(caller_gid, tcred->gid))
> > > > > >                 goto ok;
> > > > > >         if (ptrace_has_cap(tcred->user_ns, mode))
> > > > > >                 goto ok;
> > > > > >         rcu_read_unlock();
> > > > > >         return -EPERM;
> > > > > > ok:
> > > > > >         rcu_read_unlock();
> > > > > >         mm = task->mm;
> > > > > >         if (mm &&
> > > > > >             ((get_dumpable(mm) != SUID_DUMP_USER) &&
> > > > > >              !ptrace_has_cap(mm->user_ns, mode)))
> > > > > >             return -EPERM;
> > > > >
> > > > > Which specific check would prevent task C from attaching to task B? If
> > > > > the UIDs match, the first "goto ok" executes; and you're dumpable, so
> > > > > you don't trigger the second "return -EPERM".
> > > >
> > > > You'd also need CAP_SYS_PTRACE in the mm->user_ns which you shouldn't
> > > > have if you did a setuid to an unpriv user. (But I always find that code
> > > > confusing.)
> > >
> > > Only if the target hasn't gone through execve() since setuid().
> >
> > Sorry if I want to know this in excessive detail but I'd like to
> > understand this properly so bear with me :)
> > - If task B has setuid()ed and prctl(PR_SET_DUMPABLE, 1)ed but not
> >   execve()ed then C won't pass ptrace_has_cap(mm->user_ns, mode).
> 
> Yeah.
> 
> > - If task B has setuid()ed, exeved()ed it will get its dumpable flag set
> >   to /proc/sys/fs/suid_dumpable
> 
> Not if you changed all UIDs (e.g. by calling setuid() as root). In
> that case, setup_new_exec() calls "set_dumpable(current->mm,
> SUID_DUMP_USER)".

Actually, looking at this when C is trying to PTRACE_ATTACH to B as an
unprivileged user even if B execve()ed and it is dumpable C still
wouldn't have CAP_SYS_PTRACE in the mm->user_ns unless it already is
privileged over mm->user_ns which means it must be in an ancestor
user_ns.

> 
> > which by default is 0. So C won't pass
> >   (get_dumpable(mm) != SUID_DUMP_USER).
> > In both cases PTRACE_ATTACH shouldn't work. Now, if
> > /proc/sys/fs/suid_dumpable is 1 I'd find it acceptable for this to work.
> > This is an administrator choice.
