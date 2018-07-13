Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10398ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 21:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B76082087A
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 21:47:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B76082087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730683AbeGMWDt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 18:03:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45244 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726126AbeGMWDt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 18:03:49 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5EDB2DFFE;
        Fri, 13 Jul 2018 21:47:21 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-10.rdu2.redhat.com [10.10.112.10])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8C78C1C737;
        Fri, 13 Jul 2018 21:47:16 +0000 (UTC)
Date:   Fri, 13 Jul 2018 17:44:45 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-audit@redhat.com, linux-kernel@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>, sgrubb@redhat.com,
        aviro@redhat.com
Subject: Re: [RFC PATCH ghak59 V1 4/6] audit: hand taken context to
 audit_kill_trees for syscall logging
Message-ID: <20180713214445.6kdccolnabjchr4d@madcap2.tricolour.ca>
References: <cover.1529003588.git.rgb@redhat.com>
 <7a95a34c5e90053f8214090e0d73cd54d6d281a2.1529003588.git.rgb@redhat.com>
 <CAHC9VhRMhX8iL2N2TN7qQmZ=3rb8uAr=kUiOjc04JAR0QzR6fg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhRMhX8iL2N2TN7qQmZ=3rb8uAr=kUiOjc04JAR0QzR6fg@mail.gmail.com>
User-Agent: NeoMutt/20180512
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 13 Jul 2018 21:47:21 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 13 Jul 2018 21:47:21 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'rgb@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-06-28 18:23, Paul Moore wrote:
> On Thu, Jun 14, 2018 at 4:23 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > Since the context is taken from the task in __audit_syscall_exit() and
> > __audit_free(), hand it to audit_kill_trees() so it can be used to
> > associate with a syscall record.  This requires adding the context
> > parameter to kill_rules() rather than using the current audit_context
> > (which has been taken).
> >
> > The callers of trim_marked() and evict_chunk() still have their context.
> >
> > See: https://github.com/linux-audit/audit-kernel/issues/50
> > See: https://github.com/linux-audit/audit-kernel/issues/59
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > ---
> >  kernel/audit.h      |  4 ++--
> >  kernel/audit_tree.c | 18 ++++++++++--------
> >  kernel/auditsc.c    |  4 ++--
> >  3 files changed, 14 insertions(+), 12 deletions(-)
> >
> > diff --git a/kernel/audit.h b/kernel/audit.h
> > index 214e149..f39f7aa 100644
> > --- a/kernel/audit.h
> > +++ b/kernel/audit.h
> > @@ -312,7 +312,7 @@ extern void audit_log_d_path_exe(struct audit_buffer *ab,
> >  extern int audit_tag_tree(char *old, char *new);
> >  extern const char *audit_tree_path(struct audit_tree *tree);
> >  extern void audit_put_tree(struct audit_tree *tree);
> > -extern void audit_kill_trees(struct list_head *list);
> > +extern void audit_kill_trees(struct audit_context *context);
> >  #else
> >  #define audit_remove_tree_rule(rule) BUG()
> >  #define audit_add_tree_rule(rule) -EINVAL
> > @@ -321,7 +321,7 @@ extern void audit_log_d_path_exe(struct audit_buffer *ab,
> >  #define audit_put_tree(tree) (void)0
> >  #define audit_tag_tree(old, new) -EINVAL
> >  #define audit_tree_path(rule) ""       /* never called */
> > -#define audit_kill_trees(list) BUG()
> > +#define audit_kill_trees(context) BUG()
> >  #endif
> >
> >  extern char *audit_unpack_string(void **bufp, size_t *remain, size_t len);
> > diff --git a/kernel/audit_tree.c b/kernel/audit_tree.c
> > index a01b9da..2d3e1071 100644
> > --- a/kernel/audit_tree.c
> > +++ b/kernel/audit_tree.c
> > @@ -493,13 +493,13 @@ static int tag_chunk(struct inode *inode, struct audit_tree *tree)
> >         return 0;
> >  }
> >
> > -static void audit_tree_log_remove_rule(struct audit_krule *rule)
> > +static void audit_tree_log_remove_rule(struct audit_context *context, struct audit_krule *rule)
> >  {
> >         struct audit_buffer *ab;
> >
> >         if (!audit_enabled)
> >                 return;
> > -       ab = audit_log_start(audit_context(), GFP_KERNEL, AUDIT_CONFIG_CHANGE);
> > +       ab = audit_log_start(context, GFP_KERNEL, AUDIT_CONFIG_CHANGE);
> >         if (unlikely(!ab))
> >                 return;
> >         audit_log_format(ab, "op=remove_rule");
> > @@ -510,7 +510,7 @@ static void audit_tree_log_remove_rule(struct audit_krule *rule)
> >         audit_log_end(ab);
> >  }
> >
> > -static void kill_rules(struct audit_tree *tree)
> > +static void kill_rules(struct audit_context *context, struct audit_tree *tree)
> >  {
> >         struct audit_krule *rule, *next;
> >         struct audit_entry *entry;
> > @@ -521,7 +521,7 @@ static void kill_rules(struct audit_tree *tree)
> >                 list_del_init(&rule->rlist);
> >                 if (rule->tree) {
> >                         /* not a half-baked one */
> > -                       audit_tree_log_remove_rule(rule);
> > +                       audit_tree_log_remove_rule(context, rule);
> >                         if (entry->rule.exe)
> >                                 audit_remove_mark(entry->rule.exe);
> >                         rule->tree = NULL;
> > @@ -584,7 +584,7 @@ static void trim_marked(struct audit_tree *tree)
> >                 tree->goner = 1;
> >                 spin_unlock(&hash_lock);
> >                 mutex_lock(&audit_filter_mutex);
> > -               kill_rules(tree);
> > +               kill_rules(audit_context(), tree);
> >                 list_del_init(&tree->list);
> >                 mutex_unlock(&audit_filter_mutex);
> >                 prune_one(tree);
> > @@ -924,8 +924,10 @@ static void audit_schedule_prune(void)
> >   * ... and that one is done if evict_chunk() decides to delay until the end
> >   * of syscall.  Runs synchronously.
> >   */
> > -void audit_kill_trees(struct list_head *list)
> > +void audit_kill_trees(struct audit_context *context)
> >  {
> > +       struct list_head *list = &context->killed_trees;
> > +
> >         audit_ctl_lock();
> >         mutex_lock(&audit_filter_mutex);
> >
> > @@ -933,7 +935,7 @@ void audit_kill_trees(struct list_head *list)
> >                 struct audit_tree *victim;
> >
> >                 victim = list_entry(list->next, struct audit_tree, list);
> > -               kill_rules(victim);
> > +               kill_rules(context, victim);
> >                 list_del_init(&victim->list);
> >
> >                 mutex_unlock(&audit_filter_mutex);
> > @@ -972,7 +974,7 @@ static void evict_chunk(struct audit_chunk *chunk)
> >                 list_del_init(&owner->same_root);
> >                 spin_unlock(&hash_lock);
> >                 if (!postponed) {
> > -                       kill_rules(owner);
> > +                       kill_rules(audit_context(), owner);
> >                         list_move(&owner->list, &prune_list);
> >                         need_prune = 1;
> >                 } else {
> > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > index ceb1c45..2590c9e 100644
> > --- a/kernel/auditsc.c
> > +++ b/kernel/auditsc.c
> > @@ -1490,7 +1490,7 @@ void __audit_free(struct task_struct *tsk)
> >         if (context->in_syscall && context->current_state == AUDIT_RECORD_CONTEXT)
> >                 audit_log_exit(context, tsk);
> >         if (!list_empty(&context->killed_trees))
> > -               audit_kill_trees(&context->killed_trees);
> > +               audit_kill_trees(context);
> 
> See my comment below about the ordering of audit_kill_trees() and
> audit_log_exit().
> 
> >         audit_free_context(context);
> >  }
> > @@ -1577,7 +1577,7 @@ void __audit_syscall_exit(int success, long return_code)
> >         context->prio = context->state == AUDIT_RECORD_CONTEXT ? ~0ULL : 0;
> >
> >         if (!list_empty(&context->killed_trees))
> > -               audit_kill_trees(&context->killed_trees);
> > +               audit_kill_trees(context);
> 
> I wonder if we should move the kill_trees if-block above the
> audit_log_exit() block so that any records that are emitted will be
> before the SYSCALL record.  I didn't chase down all the code paths,
> but it seems like it should be safe, no?

Interesting.  I thought I had looked at re-ordering them and rejected
that approach due to that information being needed for audit_log_exit(),
but I don't find any such dependency this pass through the code.

I guess the only concern I have then is that if the state is anything
other than AUDIT_RECORD_CONTEXT it would be an orphan record, but it
would be regardless with the existing code or with my proposed changes.
Perhaps that is a bug to start with, though I'm not sure it is at all
serious, so I'm not concerned about it.

I think re-ordering should be safe and that eliminates the seeming
complexity introduced by the next patch, which is a good thing.

> >         audit_free_names(context);
> >         unroll_tree_refs(context, NULL, 0);
> 
> paul moore

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
