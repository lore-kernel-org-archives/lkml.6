Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752573AbeEJVSL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 17:18:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56356 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752419AbeEJVSI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 17:18:08 -0400
Date: Thu, 10 May 2018 17:17:46 -0400
From: Richard Guy Briggs <rgb@redhat.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux NetDev Upstream Mailing List <netdev@vger.kernel.org>,
        Netfilter Devel List <netfilter-devel@vger.kernel.org>,
        Linux Security Module list
        <linux-security-module@vger.kernel.org>,
        Integrity Measurement Architecture
        <linux-integrity@vger.kernel.org>,
        SElinux list <selinux@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH ghak81 RFC V1 3/5] audit: use inline function to get
 audit context
Message-ID: <20180510211746.o3bb4wdnfue2fecf@madcap2.tricolour.ca>
References: <cover.1525466167.git.rgb@redhat.com>
 <0e43c5135c197209b3189032d538244571e7443d.1525466167.git.rgb@redhat.com>
 <CAHC9VhSbMaJ72jJnEivDd-M2UXDomexva8B-xsWXapTyeF0JVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhSbMaJ72jJnEivDd-M2UXDomexva8B-xsWXapTyeF0JVQ@mail.gmail.com>
User-Agent: NeoMutt/20171027
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-09 11:28, Paul Moore wrote:
> On Fri, May 4, 2018 at 4:54 PM, Richard Guy Briggs <rgb@redhat.com> wrote:
> > Recognizing that the audit context is an internal audit value, use an
> > access function to retrieve the audit context pointer for the task
> > rather than reaching directly into the task struct to get it.
> >
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > ---
> >  include/linux/audit.h                | 16 ++++++++---
> >  include/net/xfrm.h                   |  2 +-
> >  kernel/audit.c                       |  4 +--
> >  kernel/audit_watch.c                 |  2 +-
> >  kernel/auditsc.c                     | 52 ++++++++++++++++++------------------
> >  net/bridge/netfilter/ebtables.c      |  2 +-
> >  net/core/dev.c                       |  2 +-
> >  net/netfilter/x_tables.c             |  2 +-
> >  net/netlabel/netlabel_user.c         |  2 +-
> >  security/integrity/ima/ima_api.c     |  2 +-
> >  security/integrity/integrity_audit.c |  2 +-
> >  security/lsm_audit.c                 |  2 +-
> >  security/selinux/hooks.c             |  4 +--
> >  security/selinux/selinuxfs.c         |  6 ++---
> >  security/selinux/ss/services.c       | 12 ++++-----
> >  15 files changed, 60 insertions(+), 52 deletions(-)
> >
> > diff --git a/include/linux/audit.h b/include/linux/audit.h
> > index 5f86f7c..93e4c61 100644
> > --- a/include/linux/audit.h
> > +++ b/include/linux/audit.h
> > @@ -235,26 +235,30 @@ extern void __audit_inode_child(struct inode *parent,
> >  extern void __audit_seccomp(unsigned long syscall, long signr, int code);
> >  extern void __audit_ptrace(struct task_struct *t);
> >
> > +static inline struct audit_context *audit_context(struct task_struct *task)
> > +{
> > +       return task->audit_context;
> > +}
> 
> Another case where I think I agree with everything here on principle,
> especially when one considers it in the larger context of the audit
> container ID work.  However, I think we might be able to somply this a
> bit by eliminating the parameter to the new audit_context() helper and
> making it always reference the current task_struct.  Based on this
> patch it would appear that this change would work for all callers
> except for audit_take_context() and __audit_syscall_entry(), both of
> which are contained within the core audit code and are enough of a
> special case that I think it is acceptable for them to access the
> context directly.  I'm trying to think of reasons why a non-audit
> kernel subsystem would ever need to access the audit context of a
> process other than current and I can't think of any ... removing the
> task_struct pointer might help prevent mistakes/abuse in the future.

As for __audit_syscall_{entry,exit}() and audit_signal_info(), they are
using current.  current is assigned to local variable tsk only to be
used as the LHS in assignments and for locking.

But, audit_take_context() and audit_log_exit() are both called also from
__audit_free() which can have non-current handed to it by copy_process()
cleaning up, while do_exit() appears to still be in current.

So, Ok, ditch the parameter to audit_context() and use local access when
needed.

> > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > index 6e3ceb9..a4bbdcc 100644
> > --- a/kernel/auditsc.c
> > +++ b/kernel/auditsc.c
> > @@ -836,7 +836,7 @@ static inline struct audit_context *audit_take_context(struct task_struct *tsk,
> >                                                       int return_valid,
> >                                                       long return_code)
> >  {
> > -       struct audit_context *context = tsk->audit_context;
> > +       struct audit_context *context = audit_context(tsk);
> >
> >         if (!context)
> >                 return NULL;
> > @@ -1510,7 +1510,7 @@ void __audit_syscall_entry(int major, unsigned long a1, unsigned long a2,
> >                            unsigned long a3, unsigned long a4)
> >  {
> >         struct task_struct *tsk = current;
> > -       struct audit_context *context = tsk->audit_context;
> > +       struct audit_context *context = audit_context(tsk);
> >         enum audit_state     state;
> >
> >         if (!audit_enabled || !context)
> 
> -- 
> paul moore
> www.paul-moore.com

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
