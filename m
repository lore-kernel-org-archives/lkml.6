Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 254FDC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 22:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE5B1204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 22:07:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE5B1204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbeKBHMc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 03:12:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48058 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727412AbeKBHMc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 03:12:32 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EC63A307EA8D;
        Thu,  1 Nov 2018 22:07:40 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-24.phx2.redhat.com [10.3.112.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7245960BF1;
        Thu,  1 Nov 2018 22:07:27 +0000 (UTC)
Date:   Thu, 1 Nov 2018 18:07:24 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-audit@redhat.com, linux-kernel@vger.kernel.org,
        ebiederm@xmission.com, luto@kernel.org, dhowells@redhat.com,
        viro@zeniv.linux.org.uk, simo@redhat.com,
        Eric Paris <eparis@parisplace.org>,
        Serge Hallyn <serge@hallyn.com>
Subject: Re: [PATCH ghak90 (was ghak32) V4 01/10] audit: collect audit task
 parameters
Message-ID: <20181101220724.ggkqyf5kjv7lhabx@madcap2.tricolour.ca>
References: <cover.1533065887.git.rgb@redhat.com>
 <8e617ab568df28a66dfbe3284452de186b42fb0f.1533065887.git.rgb@redhat.com>
 <CAHC9VhQFqs1SyvximK+8XJG5Fk3p9WsWhEV5sY6kksN9tc6eKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhQFqs1SyvximK+8XJG5Fk3p9WsWhEV5sY6kksN9tc6eKw@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Thu, 01 Nov 2018 22:07:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-19 19:15, Paul Moore wrote:
> On Sun, Aug 5, 2018 at 4:32 AM Richard Guy Briggs <rgb@redhat.com> wrote:
> > The audit-related parameters in struct task_struct should ideally be
> > collected together and accessed through a standard audit API.
> >
> > Collect the existing loginuid, sessionid and audit_context together in a
> > new struct audit_task_info called "audit" in struct task_struct.
> >
> > Use kmem_cache to manage this pool of memory.
> > Un-inline audit_free() to be able to always recover that memory.
> >
> > See: https://github.com/linux-audit/audit-kernel/issues/81
> >
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > ---
> >  include/linux/audit.h | 34 ++++++++++++++++++++++++----------
> >  include/linux/sched.h |  5 +----
> >  init/init_task.c      |  3 +--
> >  init/main.c           |  2 ++
> >  kernel/auditsc.c      | 51 ++++++++++++++++++++++++++++++++++++++++++---------
> >  kernel/fork.c         |  4 +++-
> >  6 files changed, 73 insertions(+), 26 deletions(-)
> 
> ...
> 
> > diff --git a/include/linux/audit.h b/include/linux/audit.h
> > index 9334fbe..8964332 100644
> > --- a/include/linux/audit.h
> > +++ b/include/linux/audit.h
> > @@ -219,8 +219,15 @@ static inline void audit_log_task_info(struct audit_buffer *ab,
> >
> >  /* These are defined in auditsc.c */
> >                                 /* Public API */
> > +struct audit_task_info {
> > +       kuid_t                  loginuid;
> > +       unsigned int            sessionid;
> > +       struct audit_context    *ctx;
> > +};
> 
> ...
> 
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index 87bf02d..e117272 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -873,10 +872,8 @@ struct task_struct {
> >
> >         struct callback_head            *task_works;
> >
> > -       struct audit_context            *audit_context;
> >  #ifdef CONFIG_AUDITSYSCALL
> > -       kuid_t                          loginuid;
> > -       unsigned int                    sessionid;
> > +       struct audit_task_info          *audit;
> >  #endif
> >         struct seccomp                  seccomp;
> 
> Prior to this patch audit_context was available regardless of
> CONFIG_AUDITSYSCALL, after this patch the corresponding audit_context
> is only available when CONFIG_AUDITSYSCALL is defined.

This was intentional since audit_context is not used when AUDITSYSCALL is
disabled.  audit_alloc() was stubbed in that case to return 0.  audit_context()
returned NULL.

The fact that audit_context was still present in struct task_struct was an
oversight in the two patches already accepted:
	("audit: use inline function to get audit context")
	("audit: use inline function to get audit context")
that failed to hide or remove it from struct task_struct when it was no longer
relevant.

The 0-day kbuildbot was happy and it tests many configs.

On further digging, loginuid and sessionid (and audit_log_session_info) should
be part of CONFIG_AUDIT scope and not CONFIG_AUDITSYSCALL since it is used in
CONFIG_CHANGE, ANOM_LINK, FEATURE_CHANGE(, INTEGRITY_RULE), none of which are
otherwise dependent on AUDITSYSCALL.

Looking ahead, contid should be treated like loginuid and sessionid, which are
currently only available when syscall auditting is.

Converting records from standalone to syscall and checking audit_dummy_context
changes the nature of CONFIG_AUDIT/!CONFIG_AUDITSYSCALL separation.
eg: ANOM_LINK accompanied by PATH record (which needed CWD addition to be
complete anyways)

> > diff --git a/init/main.c b/init/main.c
> > index 3b4ada1..6aba171 100644
> > --- a/init/main.c
> > +++ b/init/main.c
> > @@ -92,6 +92,7 @@
> >  #include <linux/rodata_test.h>
> >  #include <linux/jump_label.h>
> >  #include <linux/mem_encrypt.h>
> > +#include <linux/audit.h>
> >
> >  #include <asm/io.h>
> >  #include <asm/bugs.h>
> > @@ -721,6 +722,7 @@ asmlinkage __visible void __init start_kernel(void)
> >         nsfs_init();
> >         cpuset_init();
> >         cgroup_init();
> > +       audit_task_init();
> >         taskstats_init_early();
> >         delayacct_init();
> 
> It seems like we would need either init_struct_audit or
> audit_task_init(), but not both, yes?

One sets initial values of init task via an included struct, other makes a call
to create the kmem cache.  Both seem appropriate to me unless we move the
initialization from a struct to assignments in audit_task_init(), but I'm not
that comfortable separating the audit init values from the rest of the
task_struct init task initializers (though there are other subsystems that need
to do so dynamically).

> > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > index fb20746..88779a7 100644
> > --- a/kernel/auditsc.c
> > +++ b/kernel/auditsc.c
> > @@ -841,7 +841,7 @@ static inline struct audit_context *audit_take_context(struct task_struct *tsk,
> >                                                       int return_valid,
> >                                                       long return_code)
> >  {
> > -       struct audit_context *context = tsk->audit_context;
> > +       struct audit_context *context = tsk->audit->ctx;
> >
> >         if (!context)
> >                 return NULL;
> > @@ -926,6 +926,15 @@ static inline struct audit_context *audit_alloc_context(enum audit_state state)
> >         return context;
> >  }
> >
> > +static struct kmem_cache *audit_task_cache;
> > +
> > +void __init audit_task_init(void)
> > +{
> > +       audit_task_cache = kmem_cache_create("audit_task",
> > +                                            sizeof(struct audit_task_info),
> > +                                            0, SLAB_PANIC, NULL);
> > +}
> 
> This is somewhat related to the CONFIG_AUDITSYSCALL comment above, but
> since the audit_task_info contains generic audit state (not just
> syscall related state), it seems like this, and the audit_task_info
> accessors/helpers, should live in kernel/audit.c.

Well, in fact it was only containing syscall related state.

> There are probably a few other things that should move to
> kernel/audit.c too, e.g. audit_alloc().  Have you verified that this
> builds/runs correctly on architectures that define CONFIG_AUDIT but
> not CONFIG_AUDITSYSCALL?

I was under the mistaken impression that all this went away and wondered why
not just rip out the AUDITSYSCALL config option, but that was not completely
solved by cb74ed278f80 ("audit: always enable syscall auditing when supported
and audit is enabled").
I vaguely knew that AUDITSYSCALL was not implemented on all platforms but that
a number were expunged recently from mainline.  It turns out that 5-10+ remain.

> >  /**
> >   * audit_alloc - allocate an audit context block for a task
> >   * @tsk: task
> > @@ -940,17 +949,28 @@ int audit_alloc(struct task_struct *tsk)
> >         struct audit_context *context;
> >         enum audit_state     state;
> >         char *key = NULL;
> > +       struct audit_task_info *info;
> > +
> > +       info = kmem_cache_zalloc(audit_task_cache, GFP_KERNEL);
> > +       if (!info)
> > +               return -ENOMEM;
> > +       info->loginuid = audit_get_loginuid(current);
> > +       info->sessionid = audit_get_sessionid(current);
> > +       tsk->audit = info;
> >
> >         if (likely(!audit_ever_enabled))
> >                 return 0; /* Return if not auditing. */
> 
> I don't view this as necessary for initial acceptance, and
> synchronization/locking might render this undesirable, but it would be
> curious to see if we could do something clever with refcnts and
> copy-on-write to minimize the number of kmem_cache objects in use in
> the !audit_ever_enabled (and possibly the AUDIT_DISABLED) case.
> 
> >         state = audit_filter_task(tsk, &key);
> >         if (state == AUDIT_DISABLED) {
> > +               audit_set_context(tsk, NULL);
> 
> It's already NULL, isn't it?

Yes, holdover from copying audit_task_info as a struct from the parent task.
Fixed.

> >                 clear_tsk_thread_flag(tsk, TIF_SYSCALL_AUDIT);
> >                 return 0;
> >         }
> >
> >         if (!(context = audit_alloc_context(state))) {
> > +               tsk->audit = NULL;
> > +               kmem_cache_free(audit_task_cache, info);
> >                 kfree(key);
> >                 audit_log_lost("out of memory in audit_alloc");
> >                 return -ENOMEM;
> > @@ -962,6 +982,12 @@ int audit_alloc(struct task_struct *tsk)
> >         return 0;
> >  }
> >
> > +struct audit_task_info init_struct_audit = {
> > +       .loginuid = INVALID_UID,
> > +       .sessionid = AUDIT_SID_UNSET,
> > +       .ctx = NULL,
> > +};
> > +
> >  static inline void audit_free_context(struct audit_context *context)
> >  {
> >         audit_free_names(context);
> 
> paul moore

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
