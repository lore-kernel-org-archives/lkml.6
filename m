Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56CD9FA3756
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C366C2150F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 15:59:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C366C2150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbeIMVJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 17:09:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44880 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727636AbeIMVJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 17:09:16 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BAE42307DA3C;
        Thu, 13 Sep 2018 15:59:08 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-40.phx2.redhat.com [10.3.112.40])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BFCB55C1A1;
        Thu, 13 Sep 2018 15:58:59 +0000 (UTC)
Date:   Thu, 13 Sep 2018 11:54:18 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     John Stultz <john.stultz@linaro.org>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Steve Grubb <sgrubb@redhat.com>,
        Miroslav Lichvar <mlichvar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH ghak10 v5 1/2] audit: Add functions to log time
 adjustments
Message-ID: <20180913155418.regeoj6veiivpvlt@madcap2.tricolour.ca>
References: <20180824120001.20771-1-omosnace@redhat.com>
 <20180824120001.20771-2-omosnace@redhat.com>
 <CALAqxLU7UyCqs9t8E+UV7BQvfYOSB6mdYB2f5RYmu_mb76i7VA@mail.gmail.com>
 <CAFqZXNsZSN=pVupOHZwam8k9V357sA7KPuK3EjtZ=hPRrr1ocA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqZXNsZSN=pVupOHZwam8k9V357sA7KPuK3EjtZ=hPRrr1ocA@mail.gmail.com>
User-Agent: NeoMutt/20180512
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Thu, 13 Sep 2018 15:59:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-27 10:28, Ondrej Mosnacek wrote:
> On Fri, Aug 24, 2018 at 8:33 PM John Stultz <john.stultz@linaro.org> wrote:
> > On Fri, Aug 24, 2018 at 5:00 AM, Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > This patch adds two auxiliary record types that will be used to annotate
> > > the adjtimex SYSCALL records with the NTP/timekeeping values that have
> > > been changed.
> > >
> > > Next, it adds two functions to the audit interface:
> > >  - audit_tk_injoffset(), which will be called whenever a timekeeping
> > >    offset is injected by a syscall from userspace,
> > >  - audit_ntp_adjust(), which will be called whenever an NTP internal
> > >    variable is changed by a syscall from userspace.
> > >
> > > Quick reference for the fields of the new records:
> > >     AUDIT_TIME_INJOFFSET
> > >         sec - the 'seconds' part of the offset
> > >         nsec - the 'nanoseconds' part of the offset
> > >     AUDIT_TIME_ADJNTPVAL
> > >         op - which value was adjusted:
> > >             offset - corresponding to the time_offset variable
> > >             freq   - corresponding to the time_freq variable
> > >             status - corresponding to the time_status variable
> > >             adjust - corresponding to the time_adjust variable
> > >             tick   - corresponding to the tick_usec variable
> > >             tai    - corresponding to the timekeeping's TAI offset
> > >         old - the old value
> > >         new - the new value
> > >
> > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > ---
> > >  include/linux/audit.h      | 21 +++++++++++++++++++++
> > >  include/uapi/linux/audit.h |  2 ++
> > >  kernel/auditsc.c           | 15 +++++++++++++++
> > >  3 files changed, 38 insertions(+)
> > >
> > > diff --git a/include/linux/audit.h b/include/linux/audit.h
> > > index 9334fbef7bae..0d084d4b4042 100644
> > > --- a/include/linux/audit.h
> > > +++ b/include/linux/audit.h
> > > @@ -26,6 +26,7 @@
> > >  #include <linux/sched.h>
> > >  #include <linux/ptrace.h>
> > >  #include <uapi/linux/audit.h>
> > > +#include <uapi/linux/timex.h>
> > >
> > >  #define AUDIT_INO_UNSET ((unsigned long)-1)
> > >  #define AUDIT_DEV_UNSET ((dev_t)-1)
> > > @@ -356,6 +357,8 @@ extern void __audit_log_capset(const struct cred *new, const struct cred *old);
> > >  extern void __audit_mmap_fd(int fd, int flags);
> > >  extern void __audit_log_kern_module(char *name);
> > >  extern void __audit_fanotify(unsigned int response);
> > > +extern void __audit_tk_injoffset(struct timespec64 offset);
> > > +extern void __audit_ntp_adjust(const char *type, s64 oldval, s64 newval);
> > >
> > >  static inline void audit_ipc_obj(struct kern_ipc_perm *ipcp)
> > >  {
> > > @@ -458,6 +461,18 @@ static inline void audit_fanotify(unsigned int response)
> > >                 __audit_fanotify(response);
> > >  }
> > >
> > > +static inline void audit_tk_injoffset(struct timespec64 offset)
> > > +{
> > > +       if (!audit_dummy_context())
> > > +               __audit_tk_injoffset(offset);
> > > +}
> > > +
> > > +static inline void audit_ntp_adjust(const char *type, s64 oldval, s64 newval)
> > > +{
> > > +       if (!audit_dummy_context())
> > > +               __audit_ntp_adjust(type, oldval, newval);
> > > +}
> > > +
> > >  extern int audit_n_rules;
> > >  extern int audit_signals;
> > >  #else /* CONFIG_AUDITSYSCALL */
> > > @@ -584,6 +599,12 @@ static inline void audit_log_kern_module(char *name)
> > >  static inline void audit_fanotify(unsigned int response)
> > >  { }
> > >
> > > +static inline void audit_tk_injoffset(struct timespec64 offset)
> > > +{ }
> > > +
> > > +static inline void audit_ntp_adjust(const char *type, s64 oldval, s64 newval)
> > > +{ }
> > > +
> > >  static inline void audit_ptrace(struct task_struct *t)
> > >  { }
> > >  #define audit_n_rules 0
> > > diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> > > index 4e3eaba84175..242ce562b41a 100644
> > > --- a/include/uapi/linux/audit.h
> > > +++ b/include/uapi/linux/audit.h
> > > @@ -114,6 +114,8 @@
> > >  #define AUDIT_REPLACE          1329    /* Replace auditd if this packet unanswerd */
> > >  #define AUDIT_KERN_MODULE      1330    /* Kernel Module events */
> > >  #define AUDIT_FANOTIFY         1331    /* Fanotify access decision */
> > > +#define AUDIT_TIME_INJOFFSET   1332    /* Timekeeping offset injected */
> > > +#define AUDIT_TIME_ADJNTPVAL   1333    /* NTP value adjustment */
> > >
> > >  #define AUDIT_AVC              1400    /* SE Linux avc denial or grant */
> > >  #define AUDIT_SELINUX_ERR      1401    /* Internal SE Linux Errors */
> > > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > > index fb207466e99b..d355d32d9765 100644
> > > --- a/kernel/auditsc.c
> > > +++ b/kernel/auditsc.c
> > > @@ -2422,6 +2422,21 @@ void __audit_fanotify(unsigned int response)
> > >                 AUDIT_FANOTIFY, "resp=%u", response);
> > >  }
> > >
> > > +/* We need to allocate with GFP_ATOMIC here, since these two functions will be
> > > + * called while holding the timekeeping lock: */
> > > +void __audit_tk_injoffset(struct timespec64 offset)
> > > +{
> > > +       audit_log(audit_context(), GFP_ATOMIC, AUDIT_TIME_INJOFFSET,
> > > +                 "sec=%lli nsec=%li", (long long)offset.tv_sec, offset.tv_nsec);
> > > +}
> > > +
> > > +void __audit_ntp_adjust(const char *type, s64 oldval, s64 newval)
> > > +{
> > > +       audit_log(audit_context(), GFP_ATOMIC, AUDIT_TIME_ADJNTPVAL,
> > > +                 "op=%s old=%lli new=%lli", type,
> > > +                 (long long)oldval, (long long)newval);
> > > +}
> >
> > So it looks like you've been careful here, but just want to make sure,
> > nothing in the audit_log path calls anything that might possibly call
> > back into timekeeping code? We've had a number of issues over time
> > where debug calls out to other subsystems end up getting tweaked to
> > add some timestamping and we deadlock.  :)
> 
> Hm, that's a good point... AFAIK, the only place where audit_log()
> might call into timekeeping is when it captures the timestamp for the
> record (via ktime_get_coarse_real_ts64()), but this is only called
> when the functions are called outside of a syscall and that should
> never happen here. I'm thinking I could harden this more by returning
> early from these functions if WARN_ON_ONCE(!audit_context() ||
> !audit_context()->in_syscall)... It is not a perfect solution, but at
> least there will be something in the code reminding us about this
> issue.

It looks like this should be safe already since if there is no context,
it won't call into the real audit logging function and as you point out,
this should never happen outside of a syscall.

> > One approach we've done to make sure we don't create a trap for future
> > changes in other subsystems, is avoid calling into other subsystems
> > until later when we've dropped the locks, (see clock_was_set).  Its a
> > little rough for some of the things done deep in the ntp code, but
> > might be an extra cautious approach to try.
> 
> I'm afraid that delaying the audit_* calls would complicate things too
> much here... Paul/Richard, any thoughts?

The other way to address this would be to have your timekeeping audit
logging functions save the parameters you want to log somewhere in the
struct audit_context union and have it print the record on syscall exit
based on the presence of this type and applicable filters.

> Ondrej Mosnacek <omosnace at redhat dot com>

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
