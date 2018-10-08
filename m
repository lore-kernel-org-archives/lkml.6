Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649FBC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 16:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09C9C2089D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 16:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="bu92eMXQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09C9C2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbeJHXe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 19:34:28 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50710 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeJHXe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 19:34:28 -0400
Received: by mail-wm1-f66.google.com with SMTP id i8-v6so2625386wmg.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 09:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Puy0dHBha4s/npAf1cLvCd9OaxBxe3baF9envUyvhcs=;
        b=bu92eMXQ92Bs9bhIHTmoXhhLi4roaaOwbTLCFQi+sq29nidFN3prWK6TZdHHyC6pB2
         TuhRq7lH8/iJpGNcqiY8lyrVDosmLTVn+zHZdm2lar8T9usO+fwWlVBRgln169wE96yB
         qj4GKByZ4+uAL4jJ2JOe0IuetRxdLANogfHfBEiZ7odxGJtRnNMwW8P4r8YelWFXIjzS
         ITsv8AWoUOWNk6WWIyTKKzqKa+QtI4KWAde1to+5Fs55k+/D+TxrxLWsnuVbJBARjOSj
         09uqfkFZwjV0CIR3tSIZ9ChOi1gSRsbbBE/Gd0E7heIDED8rJ+y0y7nMnw7UuEmlVcu7
         HoHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Puy0dHBha4s/npAf1cLvCd9OaxBxe3baF9envUyvhcs=;
        b=EatWGKK71R8IeERGbsl/ZtrWuOpjx/g/v4/2QqacRslU7eDgKrrjhbmHw/Ar68Cs8G
         YfRmQuNlRPgI4MBJIvI8Ik95k1xZYhHS42xlnJvhZyFqnhywfNO2gh8kw/dwTg9P8I+u
         Qy/WFrsFXIv2PUMmIBYIzTcmrYB1ljVS78JwU8v6O268rbMGGNibe4PLc8FsUmmPFugf
         a2cK0zvqC7NNwf+/iZfJj8bM8wQwsFGmkq15jhVo70ak8U3gzC4RTb8KNtdODCVleppw
         kNpc/ZAyPtSsKRHT4O4pROoMI5uxpRo9xJIbAqT1PAdOmx4VJvTfzXtf/yAE21jaevB/
         ynoQ==
X-Gm-Message-State: ABuFfoh8Gw7qBhS7QwnXkmSt3E/6YfeZ3RqhdBS25CmxjXCi2l/EC1JL
        Ce30/0YAEwJfHrDUqJH6FRCWcw==
X-Google-Smtp-Source: ACcGV61Aw02Lf8bO1trGw/0Q5TdY4j2XidzoRkiGH9ifBL/CCM22HQSeaR3K7B1IwnesuNFmEH7lCQ==
X-Received: by 2002:a1c:3ad3:: with SMTP id h202-v6mr15693455wma.120.1539015715879;
        Mon, 08 Oct 2018 09:21:55 -0700 (PDT)
Received: from brauner.io ([2a02:8070:8895:9700:8197:8849:535a:4f00])
        by smtp.gmail.com with ESMTPSA id z69-v6sm9978772wmz.18.2018.10.08.09.21.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Oct 2018 09:21:55 -0700 (PDT)
Date:   Mon, 8 Oct 2018 18:21:48 +0200
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
        Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v7 3/6] seccomp: add a way to get a listener fd from
 ptrace
Message-ID: <20181008162147.ubfxxsv2425l2zsp@brauner.io>
References: <20180927151119.9989-1-tycho@tycho.ws>
 <20180927151119.9989-4-tycho@tycho.ws>
 <20181008151629.hkgzzsluevwtuclw@brauner.io>
 <CAG48ez3zaqOXH_jHN8=+jXjOf3vhFyWUkM_6KLPi9T8HcQySeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAG48ez3zaqOXH_jHN8=+jXjOf3vhFyWUkM_6KLPi9T8HcQySeg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 05:33:22PM +0200, Jann Horn wrote:
> On Mon, Oct 8, 2018 at 5:16 PM Christian Brauner <christian@brauner.io> wrote:
> >
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
> >
> > >
> > > v2: fix a bug where listener mode was not unset when an unused fd was not
> > >     available
> > > v3: fix refcounting bug (Oleg)
> > > v4: * change the listener's fd flags to be 0
> > >     * rename GET_LISTENER to NEW_LISTENER (Matthew)
> > > v5: * add capable(CAP_SYS_ADMIN) requirement
> > > v7: * point the new listener at the right filter (Jann)
> > >
> > > Signed-off-by: Tycho Andersen <tycho@tycho.ws>
> > > CC: Kees Cook <keescook@chromium.org>
> > > CC: Andy Lutomirski <luto@amacapital.net>
> > > CC: Oleg Nesterov <oleg@redhat.com>
> > > CC: Eric W. Biederman <ebiederm@xmission.com>
> > > CC: "Serge E. Hallyn" <serge@hallyn.com>
> > > CC: Christian Brauner <christian.brauner@ubuntu.com>
> > > CC: Tyler Hicks <tyhicks@canonical.com>
> > > CC: Akihiro Suda <suda.akihiro@lab.ntt.co.jp>
> > > ---
> > >  include/linux/seccomp.h                       |  7 ++
> > >  include/uapi/linux/ptrace.h                   |  2 +
> > >  kernel/ptrace.c                               |  4 ++
> > >  kernel/seccomp.c                              | 31 +++++++++
> > >  tools/testing/selftests/seccomp/seccomp_bpf.c | 68 +++++++++++++++++++
> > >  5 files changed, 112 insertions(+)
> > >
> > > diff --git a/include/linux/seccomp.h b/include/linux/seccomp.h
> > > index 017444b5efed..234c61b37405 100644
> > > --- a/include/linux/seccomp.h
> > > +++ b/include/linux/seccomp.h
> > > @@ -83,6 +83,8 @@ static inline int seccomp_mode(struct seccomp *s)
> > >  #ifdef CONFIG_SECCOMP_FILTER
> > >  extern void put_seccomp_filter(struct task_struct *tsk);
> > >  extern void get_seccomp_filter(struct task_struct *tsk);
> > > +extern long seccomp_new_listener(struct task_struct *task,
> > > +                              unsigned long filter_off);
> > >  #else  /* CONFIG_SECCOMP_FILTER */
> > >  static inline void put_seccomp_filter(struct task_struct *tsk)
> > >  {
> > > @@ -92,6 +94,11 @@ static inline void get_seccomp_filter(struct task_struct *tsk)
> > >  {
> > >       return;
> > >  }
> > > +static inline long seccomp_new_listener(struct task_struct *task,
> > > +                                     unsigned long filter_off)
> > > +{
> > > +     return -EINVAL;
> > > +}
> > >  #endif /* CONFIG_SECCOMP_FILTER */
> > >
> > >  #if defined(CONFIG_SECCOMP_FILTER) && defined(CONFIG_CHECKPOINT_RESTORE)
> > > diff --git a/include/uapi/linux/ptrace.h b/include/uapi/linux/ptrace.h
> > > index d5a1b8a492b9..e80ecb1bd427 100644
> > > --- a/include/uapi/linux/ptrace.h
> > > +++ b/include/uapi/linux/ptrace.h
> > > @@ -73,6 +73,8 @@ struct seccomp_metadata {
> > >       __u64 flags;            /* Output: filter's flags */
> > >  };
> > >
> > > +#define PTRACE_SECCOMP_NEW_LISTENER  0x420e
> > > +
> > >  /* Read signals from a shared (process wide) queue */
> > >  #define PTRACE_PEEKSIGINFO_SHARED    (1 << 0)
> > >
> > > diff --git a/kernel/ptrace.c b/kernel/ptrace.c
> > > index 21fec73d45d4..289960ac181b 100644
> > > --- a/kernel/ptrace.c
> > > +++ b/kernel/ptrace.c
> > > @@ -1096,6 +1096,10 @@ int ptrace_request(struct task_struct *child, long request,
> > >               ret = seccomp_get_metadata(child, addr, datavp);
> > >               break;
> > >
> > > +     case PTRACE_SECCOMP_NEW_LISTENER:
> > > +             ret = seccomp_new_listener(child, addr);
> > > +             break;
> > > +
> > >       default:
> > >               break;
> > >       }
> > > diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> > > index 44a31ac8373a..17685803a2af 100644
> > > --- a/kernel/seccomp.c
> > > +++ b/kernel/seccomp.c
> > > @@ -1777,4 +1777,35 @@ static struct file *init_listener(struct task_struct *task,
> > >
> > >       return ret;
> > >  }
> > > +
> > > +long seccomp_new_listener(struct task_struct *task,
> > > +                       unsigned long filter_off)
> > > +{
> > > +     struct seccomp_filter *filter;
> > > +     struct file *listener;
> > > +     int fd;
> > > +
> > > +     if (!capable(CAP_SYS_ADMIN))
> > > +             return -EACCES;
> >
> > I know this might have been discussed a while back but why exactly do we
> > require CAP_SYS_ADMIN in init_userns and not in the target userns? What
> > if I want to do a setns()fd, CLONE_NEWUSER) to the target process and
> > use ptrace from in there?
> 
> See https://lore.kernel.org/lkml/CAG48ez3R+ZJ1vwGkDfGzKX2mz6f=jjJWsO5pCvnH68P+RKO8Ow@mail.gmail.com/
> . Basically, the problem is that this doesn't just give you capability
> over the target task, but also over every other task that has the same
> filter installed; you need some sort of "is the caller capable over
> the filter and anyone who uses it" check.

Thanks.
But then this new ptrace feature as it stands is imho currently broken.
If you can install a seccomp filter with SECCOMP_RET_USER_NOTIF if you
are ns_cpabable(CAP_SYS_ADMIN) and also get an fd via seccomp() itself
if you are ns_cpabable(CAP_SYS_ADMIN) then either the new ptrace() api
extension should be fixed to allow for this too or the seccomp() way of
retrieving the pid - which I really think we want - needs to be fixed to
require capable(CAP_SYS_ADMIN) too.
The solution where both require ns_capable(CAP_SYS_ADMIN) is - imho -
the preferred way to solve this.
Everything else will just be confusing.
