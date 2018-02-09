Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751424AbeBIJZY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 04:25:24 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39386 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751030AbeBIJZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 04:25:22 -0500
Date: Fri, 9 Feb 2018 04:21:39 -0500
From: Richard Guy Briggs <rgb@redhat.com>
To: Paul Moore <paul@paul-moore.com>
Cc: linux-audit@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] audit: deprecate the AUDIT_FILTER_ENTRY filter
Message-ID: <20180209092139.puragxfx6ynzwzij@madcap2.tricolour.ca>
References: <0b3961849e1fdcb10b95dd3ca0dc818e8997a8f5.1518002656.git.rgb@redhat.com>
 <CAHC9VhRWq-iW4kKkhKLiORSVtDXyeWNLyGX1wcmT4LwuoDiDgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhRWq-iW4kKkhKLiORSVtDXyeWNLyGX1wcmT4LwuoDiDgw@mail.gmail.com>
User-Agent: NeoMutt/20171027
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-02-08 18:58, Paul Moore wrote:
> On Wed, Feb 7, 2018 at 6:24 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
> > The audit entry filter has been long deprecated with userspace support
> > finally removed in audit-v2.6.7 and plans to remove kernel support have
> > existed since kernel-v2.6.31.
> > Remove it.
> >
> > Passes audit-testsuite.
> >
> > See: https://github.com/linux-audit/audit-kernel/issues/6
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > ---
> >  kernel/auditfilter.c | 4 ++--
> >  kernel/auditsc.c     | 3 ++-
> >  2 files changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
> > index 4a1758a..1bbf5de 100644
> > --- a/kernel/auditfilter.c
> > +++ b/kernel/auditfilter.c
> > @@ -258,8 +258,8 @@ static inline struct audit_entry *audit_to_entry_common(struct audit_rule_data *
> >                 goto exit_err;
> >  #ifdef CONFIG_AUDITSYSCALL
> >         case AUDIT_FILTER_ENTRY:
> > -               if (rule->action == AUDIT_ALWAYS)
> > -                       goto exit_err;
> > +               pr_err("AUDIT_FILTER_ENTRY is deprecated\n");
> > +               goto exit_err;
> >         case AUDIT_FILTER_EXIT:
> >         case AUDIT_FILTER_TASK:
> >  #endif
> > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > index e80459f..9348302 100644
> > --- a/kernel/auditsc.c
> > +++ b/kernel/auditsc.c
> > @@ -1530,7 +1530,8 @@ void __audit_syscall_entry(int major, unsigned long a1, unsigned long a2,
> >         context->dummy = !audit_n_rules;
> >         if (!context->dummy && state == AUDIT_BUILD_CONTEXT) {
> >                 context->prio = 0;
> > -               state = audit_filter_syscall(tsk, context, &audit_filter_list[AUDIT_FILTER_ENTRY]);
> > +               if (auditd_test_task(tsk))
> > +                       return;
> 
> Since we are removing the call to audit_filter_syscall() entirely -
> which would appear to be the right thing - I wonder if it would be a
> good idea to move the auditd_test_task() check earlier in the function
> (fail early).  I'm thinking up where we check audit_enabled, before we
> start populating context.

Ok, agreed, along some other minor code shuffles.

> >         }
> >         if (state == AUDIT_DISABLED)
> >                 return;
> > --
> 
> paul moore

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
