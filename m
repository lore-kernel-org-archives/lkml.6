Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E2B7C2F421
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62EF12087F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TCWlEXiZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729680AbfAUOqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:46:33 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38474 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729393AbfAUOqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 09:46:33 -0500
Received: by mail-wm1-f67.google.com with SMTP id m22so11098801wml.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 06:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=LIKE9WgSo1P+t9CNLFqYv0GaD+p1+bEnspmCMY3NvMs=;
        b=TCWlEXiZXc0f6dPL+27FyvCaiN0ijdor9pGJw/GbRvY9++j9q9XW0o8DlR+eT17pwE
         p4vKZX3Zp98Td1t1JKF4SVKl1tdUZpOp4MRX04tISa5kwtnMxybwiGccRI95wlZp9I77
         ryoAG12GNK8/JBG9GL+iY053gkGQb9Jx3NXY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=LIKE9WgSo1P+t9CNLFqYv0GaD+p1+bEnspmCMY3NvMs=;
        b=dcBQ4hNkoFqQcTYzpxnFGWyIW1UPI1a+JJab3ceWGB0qPYB3Psbim+WamCSh5LuMfz
         4sSh8uOKYnoFdhMz5Z3MtwTYD779pKtNs+WK34zykG0lKOg/MN6dzejN8z0BsQthqqm3
         8geaq6mcUaELmFYXWITBprjAVUh/8XDY4HTHmFZuHCldV5Aao/p/W4RZ6VCFrehYhsG0
         sTV2rQKtKvV6gT4OfMJqL3kiUdtXWvQtlz7ikdQRWeK1wPetV/YO/s8aQh0Hm0yPn3hm
         x47PFbSsaSxAYWbZkcAfcpbshT7HUsWrqeLozhW7npivyGXpIyIXg2gEcoTK1/7eWhNu
         wtvg==
X-Gm-Message-State: AJcUuke+4hhJyXD5rzifBxwuFEvE6agML7ocBpIiyle3xmKcWnjtccvf
        YQ306HUYAoW0gK3J4rgTCQWPiw==
X-Google-Smtp-Source: ALg8bN5Lx1BdPiPr+SUiqqHCPNdpHKjMcJyXd9jr5MhtwTwpAV9T/hl0O78r+HyaS+8XlsJlZ0PQtA==
X-Received: by 2002:a1c:3905:: with SMTP id g5mr24532414wma.30.1548081990473;
        Mon, 21 Jan 2019 06:46:30 -0800 (PST)
Received: from linaro.org ([2a01:e0a:f:6020:b18f:5b70:743d:c29a])
        by smtp.gmail.com with ESMTPSA id v6sm76038411wro.57.2019.01.21.06.46.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 06:46:29 -0800 (PST)
Date:   Mon, 21 Jan 2019 15:46:28 +0100
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Gabriel Hartmann <ghartmann@netflix.com>,
        Gabriel Hartmann <gabriel.hartmann@gmail.com>
Subject: Re: Crash in list_add_leaf_cfs_rq due to bad tmp_alone_branch
Message-ID: <20190121144628.GA28655@linaro.org>
References: <CAMp4zn-w8y7ubvWoqTGSUycFJTd9ir5OikE9F4TiM_FtG4XdXQ@mail.gmail.com>
 <CAMp4zn-jZj9uLwfvM5uVm5hVPKYbu4FLNwD9g-xnbhmVqN1cZw@mail.gmail.com>
 <CAKfTPtDkrf6YjrgQVgm52DAB9EWQe3q5BZZCvzm9g4k=BjCEUw@mail.gmail.com>
 <CAKfTPtCOnc18K4noJAZKRRzUCfDspr4oRj6F90zqGZ7N6_UBHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKfTPtCOnc18K4noJAZKRRzUCfDspr4oRj6F90zqGZ7N6_UBHw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sargun,

Le Friday 18 Jan 2019 à 15:06:28 (+0100), Vincent Guittot a écrit :
> On Fri, 18 Jan 2019 at 11:16, Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > On Wed, 9 Jan 2019 at 23:43, Sargun Dhillon <sargun@sargun.me> wrote:
> > >
> > > On Wed, Jan 9, 2019 at 2:14 PM Sargun Dhillon <sargun@sargun.me> wrote:
> > > >
> > > > I picked up c40f7d74c741a907cfaeb73a7697081881c497d0 sched/fair: Fix
> > > > infinite loop in update_blocked_averages() by reverting a9e7f6544b9c
> > > > and put it on top of 4.19.13. In addition to this, I uninlined
> > > > list_add_leaf_cfs_rq for debugging.
> 
> With the fix above applied, the code that manages the leaf_cfs_rq_list
> is the same since v4.9.
> Have you noticed similar problem on other older kernel version between
> v4.9 and v4.19 ? The problem might have been introduce while modifying
> other part of the scheduler like the sequence for adding/removing
> cgroup.
> 
> Knowing the most recent kernel version without the problem could help
> to narrow the problem
> 
> Thanks,
> Vincent
> 
> > > >
> > > > This revealed a new bug that we didn't get to because we kept getting
> > > > crashes from the previous issue. When we are running with cgroups that
> > > > are rapidly changing, with CFS bandwidth control, and in addition
> > > > using the cpusets cgroup, we see this crash. Specifically, it seems to
> > > > occur with cgroups that are throttled and we change the allowed
> > > > cpuset.
> >
> > Thanks for the context, I will try to reproduce the problem and
> > understand how we can stop in the middle of walking to the
> > sched_entity branch with a parent not already added
> >
> > How many cgroup level have you got in you setup ?
> >
> > > >
> > >
> > > This patch from Gabriel should fix the problem:
> > >
> > >
> > > [PATCH] sched/fair: Reset tmp_alone_branch on cfs_rq delete
> > >
> > > When a child cfs_rq is added to the leaf cfs_rq list before its parent
> > > tmp_alone_branch is set to point to the child in preparation for the
> > > parent being added.
> > >
> > > If the child is deleted before the parent is added then tmp_alone_branch
> > > points to a freed cfs_rq. Any future reference to tmp_alone_branch will
> > > result in a use after free.
> >
> > So, the patch below is a temporary fix that helps to recover from the
> > situation where tmp_alone_branch doesn't finished back to
> > rq->leaf_cfs_rq_list
> > But this situation should not happened at the beginning

I have been able to reproduce the situation where tmp_alone_branch doesn't
point to rq->leaf_cfs_rq_list after enqueuing a task.

Can you try the patch below which ensures all cfs_rq of a cgroup branch will
be added in the list even if throttled ?

The algorithm used to order cfs_rq in rq->leaf_cfs_rq_list assumes that
it will walk down to root the 1st time a cfs_rq is used and we will finished
to add either a cfs_rq without parent or a cfs_rq with a parent that is already
on the list. But this is not always true in presence of throttling.
Because a cfs_rq can be throttled even if it has never been used but other CPUS
of the cgroup have already used all the bandwdith, we are not sure to go down to
the root and add all cfs_rq in the list.

Ensure that all cfs_rq will be added in the list even if they are throttled.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6483834..ae468ab 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -352,6 +352,20 @@ static inline void list_del_leaf_cfs_rq(struct cfs_rq *cfs_rq)
 	}
 }
 
+static inline void list_add_branch_cfs_rq(struct sched_entity *se, struct rq *rq)
+{
+struct cfs_rq *cfs_rq;
+
+	for_each_sched_entity(se) {
+		cfs_rq = cfs_rq_of(se);
+		list_add_leaf_cfs_rq(cfs_rq);
+
+		/* If parent is already in the list, we can stop */
+		if (rq->tmp_alone_branch == &rq->leaf_cfs_rq_list)
+			break;
+	}
+}
+
 /* Iterate through all leaf cfs_rq's on a runqueue: */
 #define for_each_leaf_cfs_rq(rq, cfs_rq) \
 	list_for_each_entry_rcu(cfs_rq, &rq->leaf_cfs_rq_list, leaf_cfs_rq_list)
@@ -5177,6 +5191,9 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 
 	}
 
+	/* Ensure that all cfs_rq have been added to the list */
+	list_add_branch_cfs_rq(se, rq);
+
 	hrtick_update(rq);
 }
 


> >
> >
> > >
> > > Signed-off-by: Gabriel Hartmann <gabriel.hartmann@gmail.com>
> > > Reported-by: Sargun Dhillon <sargun@sargun.me>
> > > ---
> > >  kernel/sched/fair.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index 7137bc343b4a..0987629cbb76 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -347,6 +347,11 @@ static inline void list_add_leaf_cfs_rq(struct
> > > cfs_rq *cfs_rq)
> > >  static inline void list_del_leaf_cfs_rq(struct cfs_rq *cfs_rq)
> > >  {
> > >      if (cfs_rq->on_list) {
> > > +        struct rq *rq = rq_of(cfs_rq);
> > > +
> > > +        if (rq->tmp_alone_branch == &cfs_rq->leaf_cfs_rq_list)
> > > +            rq->tmp_alone_branch = &rq->leaf_cfs_rq_list;
> > > +
> > >          list_del_rcu(&cfs_rq->leaf_cfs_rq_list);
> > >          cfs_rq->on_list = 0;
> > >      }
