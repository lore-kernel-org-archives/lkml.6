Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1591CC43444
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 17:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E27BB218A3
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 17:12:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbeLRRMe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 12:12:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37610 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726899AbeLRRMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 12:12:34 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 76D0958E2C;
        Tue, 18 Dec 2018 17:12:33 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.131])
        by smtp.corp.redhat.com (Postfix) with SMTP id 650612CFC7;
        Tue, 18 Dec 2018 17:12:31 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 18 Dec 2018 18:12:33 +0100 (CET)
Date:   Tue, 18 Dec 2018 18:12:30 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Roman Gushchin <guroan@gmail.com>, Tejun Heo <tj@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v5 4/7] cgroup: cgroup v2 freezer
Message-ID: <20181218171230.GA11319@redhat.com>
References: <20181207201531.1665-1-guro@fb.com>
 <20181207201531.1665-5-guro@fb.com>
 <20181211162632.GB8504@redhat.com>
 <20181211184033.GA8971@tower.DHCP.thefacebook.com>
 <20181212174902.GA30309@redhat.com>
 <20181218012800.GA29563@tower.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218012800.GA29563@tower.DHCP.thefacebook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Tue, 18 Dec 2018 17:12:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/18, Roman Gushchin wrote:
>
> On Wed, Dec 12, 2018 at 06:49:02PM +0100, Oleg Nesterov wrote:
> > > > and btw.... what about suspend? try_to_freeze_tasks() will obviously fail
> > > > if there is a ->frozen thread?
> > >
> > > I have to think a bit more here, but something like this will probably work:
> > >
> > > diff --git a/kernel/freezer.c b/kernel/freezer.c
> > > index b162b74611e4..590ac4d10b02 100644
> > > --- a/kernel/freezer.c
> > > +++ b/kernel/freezer.c
> > > @@ -134,7 +134,7 @@ bool freeze_task(struct task_struct *p)
> > >                 return false;
> > >
> > >         spin_lock_irqsave(&freezer_lock, flags);
> > > -       if (!freezing(p) || frozen(p)) {
> > > +       if (!freezing(p) || frozen(p) || cgroup_task_frozen()) {
> > >                 spin_unlock_irqrestore(&freezer_lock, flags);
> > >                 return false;
> > >         }
> > >
> > > --
> > >
> > > If the task is already frozen by the cgroup freezer, we don't have to do
> > > anything additionally.
> >
> > I don't think so. A cgroup_task_frozen() task can be killed after
> > try_to_freeze_tasks() succeeds, and the exiting task can close files,
> > do IO, etc. Or it can be thawed by cgroup_freeze_task(false).
> >
> > In short, if try_to_freeze_tasks() succeeds, the caller has all rights
> > to assume that nobody can escape from __refrigerator().
>
> But this is what we do with stopped and ptraced tasks, isn't it?

No,

> We do use freezable_schedule() and the system freezer just ignores such tasks.

	static inline void freezable_schedule(void)
	{
		freezer_do_not_count();
		schedule();
		freezer_count();
	}

and note that freezer_count() calls try_to_freeze().

IOW, the task sleeping in freezable_schedule() doesn't really differ from the
task sleeping in __refrigerator(). It is not that "the system freezer just
ignores such tasks", it ignores them because it can safely count them as frozen.

> > And what about TASK_STOPPED/TASK_TRACED tasks? They can not be frozen
> > or thawed, right? This doesn't look good, and this differs from the
> > current freezer controller...
>
> Good question!
>
> It looks like cgroup v1 freezer just ignores them treating as already frozen,
> which doesn't look nice.

Not sure I understand you, but see above... cgroup v1 freezer looks fine wrt
stopped/traced tasks.

Oleg.

