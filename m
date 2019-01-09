Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7956CC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 22:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DF66206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 22:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sargun.me header.i=@sargun.me header.b="fjF9Zw7o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbfAIWnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 17:43:06 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35617 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbfAIWnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 17:43:05 -0500
Received: by mail-ed1-f68.google.com with SMTP id x30so8676467edx.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 14:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=2E4xn2izlEUg+62TcYlL7VvJukCVkfj6sZDpb1WHghE=;
        b=fjF9Zw7oCvlPGXjuOhL+ZHZvm/7NCC3idKqLJoVGPs2Kwg6P3hF2iIS9Cf7NH+xhmG
         HPCX9K0mTx/mwEThz7H8fC2moaLw9Drx+ObJ8pjSOGNAjmnmsWLJhED5FP4+Da7Yp3M5
         2VcA6dQQOrnYe+1fEGQZWKeAkMbD0fpRVDgvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=2E4xn2izlEUg+62TcYlL7VvJukCVkfj6sZDpb1WHghE=;
        b=nEwqOict2YjYXcOYf+NGNKKqui4o1FYVC0XVCLCzCBdkcUQa2fWkdfhZDRM2jQGZA+
         cWu2VV7qa5B+lZv+v1hSwNJX5Kwv5O9g9OyAy6vMTc58A2JRyJkth2/FiprqeqpeMg9Y
         lzZP/njFMdFO1h1HJbKJSzZrVMv/PKUXL+kgS6+2eYbbkBKM7NLOBcSlMrV4RwNoOqNz
         C9JcoGdDs9JxcRmduPAW0GIK0n4Q5WLkENHST3zjOK7siptAk+fJu0IJUjquOnz1q2je
         PQUFGUxPQ/Qq9i9qs+W7vErrImzsOmu9nMKnzR2qSInQKSvMSnhV3XfAUSsyXPx/WWCE
         WsJQ==
X-Gm-Message-State: AJcUukcMgwlGdQ3pcfyDEzQ5lOMPgVYsIjdLOaNLyO7a/8rOBtgQa7Wx
        4MEz1wJ5UhjshHCQUJYdjo4WmgWyjsTp3RvntY5rW/9a9iQ=
X-Google-Smtp-Source: ALg8bN4oXdnoQAh43RCg2FvhkDWXL4iSXbjHhC+Mq7bPcZFptwag1rWCGrN5SOr/VzGzpWyR36f3gIF7semx7xEZEis=
X-Received: by 2002:a50:b881:: with SMTP id l1mr7436011ede.167.1547073783723;
 Wed, 09 Jan 2019 14:43:03 -0800 (PST)
MIME-Version: 1.0
References: <CAMp4zn-w8y7ubvWoqTGSUycFJTd9ir5OikE9F4TiM_FtG4XdXQ@mail.gmail.com>
In-Reply-To: <CAMp4zn-w8y7ubvWoqTGSUycFJTd9ir5OikE9F4TiM_FtG4XdXQ@mail.gmail.com>
From:   Sargun Dhillon <sargun@sargun.me>
Date:   Wed, 9 Jan 2019 14:42:27 -0800
Message-ID: <CAMp4zn-jZj9uLwfvM5uVm5hVPKYbu4FLNwD9g-xnbhmVqN1cZw@mail.gmail.com>
Subject: Re: Crash in list_add_leaf_cfs_rq due to bad tmp_alone_branch
To:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Gabriel Hartmann <ghartmann@netflix.com>,
        gabriel.hartmann@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 9, 2019 at 2:14 PM Sargun Dhillon <sargun@sargun.me> wrote:
>
> I picked up c40f7d74c741a907cfaeb73a7697081881c497d0 sched/fair: Fix
> infinite loop in update_blocked_averages() by reverting a9e7f6544b9c
> and put it on top of 4.19.13. In addition to this, I uninlined
> list_add_leaf_cfs_rq for debugging.
>
> This revealed a new bug that we didn't get to because we kept getting
> crashes from the previous issue. When we are running with cgroups that
> are rapidly changing, with CFS bandwidth control, and in addition
> using the cpusets cgroup, we see this crash. Specifically, it seems to
> occur with cgroups that are throttled and we change the allowed
> cpuset.
>

This patch from Gabriel should fix the problem:


[PATCH] sched/fair: Reset tmp_alone_branch on cfs_rq delete

When a child cfs_rq is added to the leaf cfs_rq list before its parent
tmp_alone_branch is set to point to the child in preparation for the
parent being added.

If the child is deleted before the parent is added then tmp_alone_branch
points to a freed cfs_rq. Any future reference to tmp_alone_branch will
result in a use after free.

Signed-off-by: Gabriel Hartmann <gabriel.hartmann@gmail.com>
Reported-by: Sargun Dhillon <sargun@sargun.me>
---
 kernel/sched/fair.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7137bc343b4a..0987629cbb76 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -347,6 +347,11 @@ static inline void list_add_leaf_cfs_rq(struct
cfs_rq *cfs_rq)
 static inline void list_del_leaf_cfs_rq(struct cfs_rq *cfs_rq)
 {
     if (cfs_rq->on_list) {
+        struct rq *rq = rq_of(cfs_rq);
+
+        if (rq->tmp_alone_branch == &cfs_rq->leaf_cfs_rq_list)
+            rq->tmp_alone_branch = &rq->leaf_cfs_rq_list;
+
         list_del_rcu(&cfs_rq->leaf_cfs_rq_list);
         cfs_rq->on_list = 0;
     }
