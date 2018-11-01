Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB0BC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 18:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E2EE2064C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 18:49:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E2EE2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727759AbeKBDxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 23:53:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49210 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726322AbeKBDxV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 23:53:21 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BA2E93082AF5;
        Thu,  1 Nov 2018 18:49:10 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-24.phx2.redhat.com [10.3.112.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1F3DD5E1BC;
        Thu,  1 Nov 2018 18:48:55 +0000 (UTC)
Date:   Thu, 1 Nov 2018 14:48:53 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     containers@lists.linux-foundation.org, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        ebiederm@xmission.com, luto@kernel.org, carlos@redhat.com,
        dhowells@redhat.com, viro@zeniv.linux.org.uk, simo@redhat.com,
        Eric Paris <eparis@parisplace.org>,
        Serge Hallyn <serge@hallyn.com>
Subject: Re: [PATCH ghak90 (was ghak32) V4 05/10] audit: add support for
 non-syscall auxiliary records
Message-ID: <20181101184853.vxel3dfdntzmhcnq@madcap2.tricolour.ca>
References: <cover.1533065887.git.rgb@redhat.com>
 <2827530000d6b4972d446b0226adab153ff3b5c5.1533065887.git.rgb@redhat.com>
 <CAHC9VhSG3Hk2zrNP3w=CfEBXN7_LcywiTpvhGp48661xYhRq2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhSG3Hk2zrNP3w=CfEBXN7_LcywiTpvhGp48661xYhRq2A@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Thu, 01 Nov 2018 18:49:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-19 19:17, Paul Moore wrote:
> On Sun, Aug 5, 2018 at 4:33 AM Richard Guy Briggs <rgb@redhat.com> wrote:
> > Standalone audit records have the timestamp and serial number generated
> > on the fly and as such are unique, making them standalone.  This new
> > function audit_alloc_local() generates a local audit context that will
> > be used only for a standalone record and its auxiliary record(s).  The
> > context is discarded immediately after the local associated records are
> > produced.
> >
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > Acked-by: Serge Hallyn <serge@hallyn.com>
> > ---
> >  include/linux/audit.h |  8 ++++++++
> >  kernel/audit.h        |  1 +
> >  kernel/auditsc.c      | 33 ++++++++++++++++++++++++++++-----
> >  3 files changed, 37 insertions(+), 5 deletions(-)
> 
> I'm not in love with the local flag, and the whole local context in
> general, but that's a larger discussion and not something I want to
> force on this patchset; we can fix it later.

I understand your reasoning to combine it so that if one patch gets
backported then both do, or if one gets reverted both do, but I really
prefer them seperate for similar reasons if there is more than one user.

> I think this patch looks fine, but it seems a bit odd standalone; it's
> almost always better to include new capabilities/functions in the same
> patch as the user.  Since the only user is the networking bits, it
> might make more sense to fold this patch into that one.

It was kept seperate due to tty_audit usage.  See my reasoning for patch
6, but I'm willing to negotiate if that merits an exception like the
USER records do.

> > diff --git a/include/linux/audit.h b/include/linux/audit.h
> > index 4f514ed..1f340ad 100644
> > --- a/include/linux/audit.h
> > +++ b/include/linux/audit.h
> > @@ -234,7 +234,9 @@ struct audit_task_info {
> >  extern struct audit_task_info init_struct_audit;
> >  extern void __init audit_task_init(void);
> >  extern int  audit_alloc(struct task_struct *task);
> > +extern struct audit_context *audit_alloc_local(gfp_t gfpflags);
> >  extern void audit_free(struct task_struct *task);
> > +extern void audit_free_context(struct audit_context *context);
> >  extern void __audit_syscall_entry(int major, unsigned long a0, unsigned long a1,
> >                                   unsigned long a2, unsigned long a3);
> >  extern void __audit_syscall_exit(int ret_success, long ret_value);
> > @@ -495,6 +497,12 @@ static inline int audit_alloc(struct task_struct *task)
> >  {
> >         return 0;
> >  }
> > +static inline struct audit_context *audit_alloc_local(gfp_t gfpflags)
> > +{
> > +       return NULL;
> > +}
> > +static inline void audit_free_context(struct audit_context *context)
> > +{ }
> >  static inline void audit_free(struct task_struct *task)
> >  { }
> >  static inline void audit_syscall_entry(int major, unsigned long a0,
> > diff --git a/kernel/audit.h b/kernel/audit.h
> > index 1cf1c35..a6d00a5 100644
> > --- a/kernel/audit.h
> > +++ b/kernel/audit.h
> > @@ -110,6 +110,7 @@ struct audit_proctitle {
> >  struct audit_context {
> >         int                 dummy;      /* must be the first element */
> >         int                 in_syscall; /* 1 if task is in a syscall */
> > +       bool                local;      /* local context needed */
> >         enum audit_state    state, current_state;
> >         unsigned int        serial;     /* serial number for record */
> >         int                 major;      /* syscall number */
> > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > index cdb24cf..7627f21 100644
> > --- a/kernel/auditsc.c
> > +++ b/kernel/auditsc.c
> > @@ -913,11 +913,13 @@ static inline void audit_free_aux(struct audit_context *context)
> >         }
> >  }
> >
> > -static inline struct audit_context *audit_alloc_context(enum audit_state state)
> > +static inline struct audit_context *audit_alloc_context(enum audit_state state,
> > +                                                       gfp_t gfpflags)
> >  {
> >         struct audit_context *context;
> >
> > -       context = kzalloc(sizeof(*context), GFP_KERNEL);
> > +       /* We can be called in atomic context via audit_tg() */
> > +       context = kzalloc(sizeof(*context), gfpflags);
> >         if (!context)
> >                 return NULL;
> >         context->state = state;
> > @@ -970,7 +972,8 @@ int audit_alloc(struct task_struct *tsk)
> >                 return 0;
> >         }
> >
> > -       if (!(context = audit_alloc_context(state))) {
> > +       context = audit_alloc_context(state, GFP_KERNEL);
> > +       if (!(context)) {
> >                 tsk->audit = NULL;
> >                 kmem_cache_free(audit_task_cache, info);
> >                 kfree(key);
> > @@ -991,8 +994,27 @@ struct audit_task_info init_struct_audit = {
> >         .ctx = NULL,
> >  };
> >
> > -static inline void audit_free_context(struct audit_context *context)
> > +struct audit_context *audit_alloc_local(gfp_t gfpflags)
> >  {
> > +       struct audit_context *context;
> > +
> > +       if (!audit_ever_enabled)
> > +               return NULL; /* Return if not auditing. */
> > +
> > +       context = audit_alloc_context(AUDIT_RECORD_CONTEXT, gfpflags);
> > +       if (!context)
> > +               return NULL;
> > +       context->serial = audit_serial();
> > +       context->ctime = current_kernel_time64();
> > +       context->local = true;
> > +       return context;
> > +}
> > +EXPORT_SYMBOL(audit_alloc_local);
> > +
> > +void audit_free_context(struct audit_context *context)
> > +{
> > +       if (!context)
> > +               return;
> >         audit_free_names(context);
> >         unroll_tree_refs(context, NULL, 0);
> >         free_tree_refs(context);
> > @@ -1002,6 +1024,7 @@ static inline void audit_free_context(struct audit_context *context)
> >         audit_proctitle_free(context);
> >         kfree(context);
> >  }
> > +EXPORT_SYMBOL(audit_free_context);
> >
> >  static int audit_log_pid_context(struct audit_context *context, pid_t pid,
> >                                  kuid_t auid, kuid_t uid, unsigned int sessionid,
> > @@ -2024,7 +2047,7 @@ void __audit_inode_child(struct inode *parent,
> >  int auditsc_get_stamp(struct audit_context *ctx,
> >                        struct timespec64 *t, unsigned int *serial)
> >  {
> > -       if (!ctx->in_syscall)
> > +       if (!ctx->in_syscall && !ctx->local)
> >                 return 0;
> >         if (!ctx->serial)
> >                 ctx->serial = audit_serial();
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
