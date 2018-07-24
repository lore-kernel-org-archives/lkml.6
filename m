Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A694EC28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 19:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FFF920874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 19:40:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FFF920874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388697AbeGXUsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 16:48:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52080 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388454AbeGXUsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 16:48:23 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A465340241D3;
        Tue, 24 Jul 2018 19:40:22 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-54.rdu2.redhat.com [10.10.112.54])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6BDB62166BA3;
        Tue, 24 Jul 2018 19:40:19 +0000 (UTC)
Date:   Tue, 24 Jul 2018 15:37:25 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     cgroups@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-api@vger.kernel.org, linux-audit@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, ebiederm@xmission.com, luto@kernel.org,
        jlayton@redhat.com, carlos@redhat.com, dhowells@redhat.com,
        viro@zeniv.linux.org.uk, simo@redhat.com,
        Eric Paris <eparis@parisplace.org>, serge@hallyn.com
Subject: Re: [RFC PATCH ghak90 (was ghak32) V3 04/10] audit: add support for
 non-syscall auxiliary records
Message-ID: <20180724193725.k27la4ubg2g2n4qm@madcap2.tricolour.ca>
References: <cover.1528304203.git.rgb@redhat.com>
 <dcd3d6e27c4beb8aec11805faeb4de7013132bd7.1528304204.git.rgb@redhat.com>
 <CAHC9VhRkH+UaZXfbsmfMsuCO7rQ48R5cBPU__00eG=pyO7AyCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhRkH+UaZXfbsmfMsuCO7rQ48R5cBPU__00eG=pyO7AyCw@mail.gmail.com>
User-Agent: NeoMutt/20180512
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 24 Jul 2018 19:40:22 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 24 Jul 2018 19:40:22 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'rgb@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-20 18:14, Paul Moore wrote:
> On Wed, Jun 6, 2018 at 1:01 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > Standalone audit records have the timestamp and serial number generated
> > on the fly and as such are unique, making them standalone.  This new
> > function audit_alloc_local() generates a local audit context that will
> > be used only for a standalone record and its auxiliary record(s).  The
> > context is discarded immediately after the local associated records are
> > produced.
> >
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > ---
> >  include/linux/audit.h |  8 ++++++++
> >  kernel/auditsc.c      | 25 +++++++++++++++++++++++--
> >  2 files changed, 31 insertions(+), 2 deletions(-)
> 
> ...
> 
> > --- a/kernel/auditsc.c
> > +++ b/kernel/auditsc.c
> > @@ -916,8 +916,11 @@ static inline void audit_free_aux(struct audit_context *context)
> >  static inline struct audit_context *audit_alloc_context(enum audit_state state)
> >  {
> >         struct audit_context *context;
> > +       gfp_t gfpflags;
> >
> > -       context = kzalloc(sizeof(*context), GFP_KERNEL);
> > +       /* We can be called in atomic context via audit_tg() */
> > +       gfpflags = (in_atomic() || irqs_disabled()) ? GFP_ATOMIC : GFP_KERNEL;
> 
> Instead of trying to guess the proper gfp flags, and likely getting it
> wrong at some point (the in_atomic() comment in preempt.h don't give
> me the warm fuzzies), why not pass the gfp flags as an argument?
> 
> Right now it looks like we would only have two callers: audit_alloc()
> and audit_audit_local().  The audit_alloc() invocation would simply
> pass GFP_KERNEL and we could allow the audit_alloc_local() callers to
> specify the gfp flags when calling audit_alloc_local() (although I
> suspect that will always be GFP_ATOMIC since we should only be calling
> audit_alloc_local() from interrupt-like context, in all other cases we
> should use the audit_context from the current task_struct.

Ok, I'll explicitly pass it in.

> > +       context = kzalloc(sizeof(*context), gfpflags);
> >         if (!context)
> >                 return NULL;
> >         context->state = state;
> > @@ -993,8 +996,26 @@ struct audit_task_info init_struct_audit = {
> >         .ctx = NULL,
> >  };
> >
> > -static inline void audit_free_context(struct audit_context *context)
> > +struct audit_context *audit_alloc_local(void)
> >  {
> 
> Let's see where this goes, but we may want to rename this slightly to
> indicate that this should only be called from interrupt context when
> we can't rely on current's audit_context.  Bonus points if we can find
> a way to enforce this with a WARN() assertion so we can better catch
> abuse.

I'll see what I can come up with.

> > +       struct audit_context *context;
> > +
> > +       if (!audit_ever_enabled)
> > +               return NULL; /* Return if not auditing. */
> > +
> > +       context = audit_alloc_context(AUDIT_RECORD_CONTEXT);
> > +       if (!context)
> > +               return NULL;
> > +       context->serial = audit_serial();
> > +       context->ctime = current_kernel_time64();
> > +       context->in_syscall = 1;
> 
> Setting in_syscall is both interesting and a bit troubling, if for no
> other reason than I expect most (all?) callers to be in an interrupt
> context when audit_alloc_local() is called.  Setting in_syscall would
> appear to be conceptually in this case.  Can you help explain why this
> is the right thing to do, or necessary to ensure things are handled
> correctly?

I'll admit this is cheating a bit, but seemed harmless.  It is needed so
that auditsc_get_stamp() from audit_get_stamp() from audit_log_start()
doesn't bail on me without giving me its already assigned time and
serial values rather than generating a new one.  I did look to see if
there were any other undesireable side effects and found none, so I'm
tmepted to rename the ->in_syscall to something a bit more helpful.  I
could add a new audit_context structure member to make
auditsc_get_stamp() co-operative, but this seems wasteful and
unnecessary.

> Looking quickly at the audit code, it seems to only be used on record
> and/or syscall termination to end things properly as well as in some
> of the PATH record code paths to limit filename collection to actual
> syscalls.  However, this was just a quick look so I could be missing
> some important points.
> 
> > +       return context;
> > +}
> > +
> > +void audit_free_context(struct audit_context *context)
> > +{
> > +       if (!context)
> > +               return;
> >         audit_free_names(context);
> >         unroll_tree_refs(context, NULL, 0);
> >         free_tree_refs(context);
> > --
> > 1.8.3.1
> >
> > --
> > Linux-audit mailing list
> > Linux-audit@redhat.com
> > https://www.redhat.com/mailman/listinfo/linux-audit
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
