Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B340FC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 18:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BF8F20892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 18:50:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BF8F20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731914AbeG3U1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 16:27:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54016 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729542AbeG3U1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 16:27:02 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6B9D640214E2;
        Mon, 30 Jul 2018 18:50:41 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-17.rdu2.redhat.com [10.10.112.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B701A2026D6D;
        Mon, 30 Jul 2018 18:50:37 +0000 (UTC)
Date:   Mon, 30 Jul 2018 14:47:31 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     cgroups@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-api@vger.kernel.org, linux-audit@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, ebiederm@xmission.com, luto@kernel.org,
        jlayton@redhat.com, carlos@redhat.com, dhowells@redhat.com,
        viro@zeniv.linux.org.uk, simo@redhat.com,
        Eric Paris <eparis@parisplace.org>, serge@hallyn.com
Subject: Re: [RFC PATCH ghak90 (was ghak32) V3 01/10] audit: add container id
Message-ID: <20180730184731.aycnmknlew4vhnqe@madcap2.tricolour.ca>
References: <cover.1528304203.git.rgb@redhat.com>
 <0377c3ced6bdbc44fe17f9a5679cb6eda4304024.1528304203.git.rgb@redhat.com>
 <CAHC9VhRk+qLAyizM9i8D+cjKxyhruuj_Z9N0QRmjM-fjm4hgRw@mail.gmail.com>
 <20180724190613.ww6yhsqpa7n4s62k@madcap2.tricolour.ca>
 <CAHC9VhQ3KwG-YmpJsOa9k=YqQmaQTaJXeB=eM9Fm80hujbngBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhQ3KwG-YmpJsOa9k=YqQmaQTaJXeB=eM9Fm80hujbngBg@mail.gmail.com>
User-Agent: NeoMutt/20180512
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 30 Jul 2018 18:50:41 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 30 Jul 2018 18:50:41 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'rgb@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-24 17:54, Paul Moore wrote:
> On Tue, Jul 24, 2018 at 3:09 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > On 2018-07-20 18:13, Paul Moore wrote:
> > > On Wed, Jun 6, 2018 at 1:00 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > > Implement the proc fs write to set the audit container identifier of a
> > > > process, emitting an AUDIT_CONTAINER_ID record to document the event.
> > > >
> > > > This is a write from the container orchestrator task to a proc entry of
> > > > the form /proc/PID/audit_containerid where PID is the process ID of the
> > > > newly created task that is to become the first task in a container, or
> > > > an additional task added to a container.
> > > >
> > > > The write expects up to a u64 value (unset: 18446744073709551615).
> > > >
> > > > The writer must have capability CAP_AUDIT_CONTROL.
> > > >
> > > > This will produce a record such as this:
> > > >   type=CONTAINER_ID msg=audit(2018-06-06 12:39:29.636:26949) : op=set opid=2209 old-contid=18446744073709551615 contid=123456 pid=628 auid=root uid=root tty=ttyS0 ses=1 subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 comm=bash exe=/usr/bin/bash res=yes
> > > >
> > > > The "op" field indicates an initial set.  The "pid" to "ses" fields are
> > > > the orchestrator while the "opid" field is the object's PID, the process
> > > > being "contained".  Old and new audit container identifier values are
> > > > given in the "contid" fields, while res indicates its success.
> > > >
> > > > It is not permitted to unset or re-set the audit container identifier.
> > > > A child inherits its parent's audit container identifier, but then can
> > > > be set only once after.
> > > >
> > > > See: https://github.com/linux-audit/audit-kernel/issues/90
> > > > See: https://github.com/linux-audit/audit-userspace/issues/51
> > > > See: https://github.com/linux-audit/audit-testsuite/issues/64
> > > > See: https://github.com/linux-audit/audit-kernel/wiki/RFE-Audit-Container-ID
> > > >
> > > > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > > > ---
> > > >  fs/proc/base.c             | 37 ++++++++++++++++++++++++
> > > >  include/linux/audit.h      | 25 ++++++++++++++++
> > > >  include/uapi/linux/audit.h |  2 ++
> > > >  kernel/auditsc.c           | 71 ++++++++++++++++++++++++++++++++++++++++++++++
> > > >  4 files changed, 135 insertions(+)
> 
> ...
> 
> > > > @@ -2112,6 +2116,73 @@ int audit_set_loginuid(kuid_t loginuid)
> > > >  }
> > > >
> > > >  /**
> > > > + * audit_set_contid - set current task's audit_context contid
> > > > + * @contid: contid value
> > > > + *
> > > > + * Returns 0 on success, -EPERM on permission failure.
> > > > + *
> > > > + * Called (set) from fs/proc/base.c::proc_contid_write().
> > > > + */
> > > > +int audit_set_contid(struct task_struct *task, u64 contid)
> > > > +{
> > > > +       u64 oldcontid;
> > > > +       int rc = 0;
> > > > +       struct audit_buffer *ab;
> > > > +       uid_t uid;
> > > > +       struct tty_struct *tty;
> > > > +       char comm[sizeof(current->comm)];
> > > > +
> > > > +       /* Can't set if audit disabled */
> > > > +       if (!task->audit)
> > > > +               return -ENOPROTOOPT;
> > > > +       oldcontid = audit_get_contid(task);
> > > > +       /* Don't allow the audit containerid to be unset */
> > > > +       if (!cid_valid(contid))
> > > > +               rc = -EINVAL;
> > > > +       /* if we don't have caps, reject */
> > > > +       else if (!capable(CAP_AUDIT_CONTROL))
> > > > +               rc = -EPERM;
> > > > +       /* if task has children or is not single-threaded, deny */
> > > > +       else if (!list_empty(&task->children))
> > > > +               rc = -EBUSY;
> > >
> > > Is this safe without holding tasklist_lock?  I worry we might be
> > > vulnerable to a race with fork().
> > >
> > > > +       else if (!(thread_group_leader(task) && thread_group_empty(task)))
> > > > +               rc = -EALREADY;
> > >
> > > Similar concern here as well, although related to threads.
> >
> > I think you are correct here and tasklist_lock should cover both.  Do we
> > also want rcu_read_lock() immediately preceeding it?
> 
> You'll need to take a closer look and determine the locking scheme. I
> simply took a quick look while reviewing this patch to see what of the
> existing locks, if any, would be most applicable here; tasklist_lock
> seemed like a good starting point.
> 
> It looks like tasklist_lock is defined as a rwlock_t so I'm not sure
> it would make sense to use it with a RCU protected structure
> (typically it's RCU+spinlock), but maybe that is the case with a
> task_struct, you'll need to check.

All I need is a read rather than write tasklist_lock since I'm not
changing any inter-task relationships, which makes it possible to nest
it inside or outside the task_lock().  I don't think I need the RCU
lock.

> > > > +       /* it is already set, and not inherited from the parent, reject */
> > > > +       else if (cid_valid(oldcontid) && !task->audit->inherited)
> > > > +               rc = -EEXIST;
> > >
> > > Maybe I'm missing something, but why do we care about preventing
> > > reassigning the audit container ID in this case?  The task is single
> > > threaded and has no descendants at this point so it should be safe,
> > > yes?  So long as the task changing the audit container ID has
> > > capable(CAP_AUDIT_CONTOL) it shouldn't matter, right?
> >
> > Because we hammered out this idea 6 months ago in the design phase and I
> > thought we all firmly agreed that the audit container identifier could
> > only be set once.  Has any significant discussion happenned since then
> > to change that wisdom?  I just wonder why this is coming up now.
> 
> Implementation, and time, can change how one looks at an earlier
> design.  I believe this is why most well reasoned specifications have
> a reference design.
> 
> Remind me why the design had the restriction of write once for the
> audit container ID?  At this point given the CAP_AUDIT_CONTROL and the
> single-thread, no-children restrictions I'm not sure what harm there
> is in allowing the value to be written multiple times (so long as the
> changes are audited of course).

Looking back through the conversations, I think you may be right that we
no longer need it, but it is easy to re-add if we find it necessary.

> > > Related, I'm questioning if we would ever care if the audit container
> > > ID was inherited or not?
> >
> > We do since that is the only way we can tell if the value has been set
> > once already or inherited unless we check if the parent's audit
> > container identifier is identical (which tells us it was inherited).
> 
> Tied to the above question.  If we don't care about multiple changes,
> given the other constraints, we probably don't need the inherited
> flag.

Agreed.

> paul moore

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
