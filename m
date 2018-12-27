Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85432C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 10:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D4E021741
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 10:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="N6HHfUd7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730698AbeL0KX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 05:23:58 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:39447 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727771AbeL0KX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 05:23:58 -0500
Received: by mail-io1-f66.google.com with SMTP id k7so14192549iob.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Dec 2018 02:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/zc8ppuAFQuKw1I+9wlWnsujLNgXnqVQdnZZXtx118c=;
        b=N6HHfUd7V1vJLnH14/N0xZomrrZiT88gI+yw+R4PiEzUdG0tQT5aH7IdOmqLAixdnv
         7JA+HkMjHGqA3D3BzVKMekLArsXtac3tnRHdwXtC30HJLGPPVMMpKlPZU4+wCPInYqM2
         XqJvKxdWJArxw49+VFew30vIb03oL7DL3lewA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/zc8ppuAFQuKw1I+9wlWnsujLNgXnqVQdnZZXtx118c=;
        b=rn1XQvWAE+DjHHQls1aLiEEvfFYojx2Vjy7kzFhsskfDIW4lGqVE3LJslSdz0zNDcS
         hdqWI5KlCkEuLeFQf96fCQb7F3905SWBcFXmYpZrcL1d6SbuUev4dRDB8wLf1gsNKkiI
         7oxVsjWlWeJ0GchDznFakKanPziHsjmoDqzZsZXwq1pdwYnBq2AEJVdZZW3cafA8ccav
         q2gVB4ZDCwsr+iDwP8EEMznQRg+Ep3kWyColu1cQ+925iUkOKxlkWzviQP312jQoJSoR
         oL6lmgA5sai0b0De36xMRkbFFenSFIFRXTFDrCamzU1yRfOAJ6mNf8Un+a4Loitz34V8
         nShQ==
X-Gm-Message-State: AJcUukf2+IxsJ64A9BFnujWktShs3eOtB4/OIXnsMsYoPw9kZmBxCt4F
        cJ+lklwW1F+2zdK/7ZO+Ls+FWOXS9FhfgllhsN0JKg==
X-Google-Smtp-Source: ALg8bN4wUDfA2qbX1225iH/MBU/rV2HaVJRXNwAzRKgsnAu3JPOspBxwmwyvAaY1dcmw8kQvHsnTVEBriNQqt99Kp7A=
X-Received: by 2002:a6b:c8c9:: with SMTP id y192mr14940514iof.183.1545906236830;
 Thu, 27 Dec 2018 02:23:56 -0800 (PST)
MIME-Version: 1.0
References: <1545879866-27809-1-git-send-email-xiexiuqi@huawei.com>
 <CAKfTPtDRGULW3mdFzeyT=OBPdtPsz-6BG-=UGWbK6RQ7Lg8YpA@mail.gmail.com> <20181227102107.GA21156@linaro.org>
In-Reply-To: <20181227102107.GA21156@linaro.org>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 27 Dec 2018 11:23:45 +0100
Message-ID: <CAKfTPtD7O_DU5no36jaQziZDCvy=BMJk+tZbnQk2yVt=pzRfPw@mail.gmail.com>
Subject: Re: [PATCH] sched: fix infinity loop in update_blocked_averages
To:     Xie XiuQi <xiexiuqi@huawei.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, xiezhipeng1@huawei.com,
        huawei.libin@huawei.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Sargun Dhillon <sargun@sargun.me>, dmitry.adamushko@gmail.com,
        Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Sargun and Dimitry who faced similar problem
Adding Tejun

On Thu, 27 Dec 2018 at 11:21, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> Le Thursday 27 Dec 2018 =C3=A0 10:21:53 (+0100), Vincent Guittot a =C3=A9=
crit :
> > Hi Xie,
> >
> > On Thu, 27 Dec 2018 at 03:57, Xie XiuQi <xiexiuqi@huawei.com> wrote:
> > >
> > > Zhepeng Xie report a bug, there is a infinity loop in
> > > update_blocked_averages().
> > >
> > > PID: 14233  TASK: ffff800b2de08fc0  CPU: 1   COMMAND: "docker"
> > >  #0 [ffff00002213b9d0] update_blocked_averages at ffff00000811e4a8
> > >  #1 [ffff00002213ba60] pick_next_task_fair at ffff00000812a3b4
> > >  #2 [ffff00002213baf0] __schedule at ffff000008deaa88
> > >  #3 [ffff00002213bb70] schedule at ffff000008deb1b8
> > >  #4 [ffff00002213bb80] futex_wait_queue_me at ffff000008180754
> > >  #5 [ffff00002213bbd0] futex_wait at ffff00000818192c
> > >  #6 [ffff00002213bd00] do_futex at ffff000008183ee4
> > >  #7 [ffff00002213bde0] __arm64_sys_futex at ffff000008184398
> > >  #8 [ffff00002213be60] el0_svc_common at ffff0000080979ac
> > >  #9 [ffff00002213bea0] el0_svc_handler at ffff000008097a6c
> > >  #10 [ffff00002213bff0] el0_svc at ffff000008084044
> > >
> > > rq->tmp_alone_branch introduced in 4.10, used to point to
> > > the new beg of the list. If this cfs_rq is deleted somewhere
> > > else, then the tmp_alone_branch will be illegal and cause
> > > a list_add corruption.
> >
> > shouldn't all the sequence  be protected by rq_lock ?
> >
> >
> > >
> > > (When enabled DEBUG_LIST, we fould this list_add corruption)
> > >
> > > [ 2546.741103] list_add corruption. next->prev should be prev
> > > (ffff800b4d61ad40), but was ffff800ba434fa38. (next=3Dffff800b6a95e74=
0).
> > > [ 2546.741130] ------------[ cut here ]------------
> > > [ 2546.741132] kernel BUG at lib/list_debug.c:25!
> > > [ 2546.741136] Internal error: Oops - BUG: 0 [#1] SMP
> > > [ 2546.742870] CPU: 1 PID: 29428 Comm: docker-runc Kdump: loaded Tain=
ted: G E  4.19.5-1.aarch64 #1
> > > [ 2546.745415] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02=
/06/2015
> > > [ 2546.747402] pstate: 40000085 (nZcv daIf -PAN -UAO)
> > > [ 2546.749015] pc : __list_add_valid+0x50/0x90
> > > [ 2546.750485] lr : __list_add_valid+0x50/0x90
> > > [ 2546.751975] sp : ffff00001b5eb910
> > > [ 2546.753286] x29: ffff00001b5eb910 x28: ffff800abacf0000
> > > [ 2546.754976] x27: ffff00001b5ebbb0 x26: ffff000009570000
> > > [ 2546.756665] x25: ffff00000960d000 x24: 00000250f41ca8f8
> > > [ 2546.758366] x23: ffff800b6a95e740 x22: ffff800b4d61ad40
> > > [ 2546.760066] x21: ffff800b4d61ad40 x20: ffff800ba434f080
> > > [ 2546.761742] x19: ffff800b4d61ac00 x18: ffffffffffffffff
> > > [ 2546.763425] x17: 0000000000000000 x16: 0000000000000000
> > > [ 2546.765089] x15: ffff000009570748 x14: 6666662073617720
> > > [ 2546.766755] x13: 747562202c293034 x12: 6461313664346230
> > > [ 2546.768429] x11: 3038666666662820 x10: 0000000000000000
> > > [ 2546.770124] x9 : 0000000000000001 x8 : ffff000009f34a0f
> > > [ 2546.771831] x7 : 0000000000000000 x6 : 000000000000250d
> > > [ 2546.773525] x5 : 0000000000000000 x4 : 0000000000000000
> > > [ 2546.775227] x3 : 0000000000000000 x2 : 70ef7f624013ca00
> > > [ 2546.776929] x1 : 0000000000000000 x0 : 0000000000000075
> > > [ 2546.778623] Process docker-runc (pid: 29428, stack limit =3D 0x000=
00000293494a2)
> > > [ 2546.780742] Call trace:
> > > [ 2546.781955]  __list_add_valid+0x50/0x90
> > > [ 2546.783469]  enqueue_entity+0x4a0/0x6e8
> > > [ 2546.784957]  enqueue_task_fair+0xac/0x610
> > > [ 2546.786502]  sched_move_task+0x134/0x178
> > > [ 2546.787993]  cpu_cgroup_attach+0x40/0x78
> > > [ 2546.789540]  cgroup_migrate_execute+0x378/0x3a8
> > > [ 2546.791169]  cgroup_migrate+0x6c/0x90
> > > [ 2546.792663]  cgroup_attach_task+0x148/0x238
> > > [ 2546.794211]  __cgroup1_procs_write.isra.2+0xf8/0x160
> > > [ 2546.795935]  cgroup1_procs_write+0x38/0x48
> > > [ 2546.797492]  cgroup_file_write+0xa0/0x170
> > > [ 2546.799010]  kernfs_fop_write+0x114/0x1e0
> > > [ 2546.800558]  __vfs_write+0x60/0x190
> > > [ 2546.801977]  vfs_write+0xac/0x1c0
> > > [ 2546.803341]  ksys_write+0x6c/0xd8
> > > [ 2546.804674]  __arm64_sys_write+0x24/0x30
> > > [ 2546.806146]  el0_svc_common+0x78/0x100
> > > [ 2546.807584]  el0_svc_handler+0x38/0x88
> > > [ 2546.809017]  el0_svc+0x8/0xc
> > >
> >
> > Have you got more details about the sequence that generates this bug ?
> > Is it easily reproducible ?
> >
> > > In this patch, we move rq->tmp_alone_branch point to its prev before =
delete it
> > > from list.
> > >
> > > Reported-by: Zhipeng Xie <xiezhipeng1@huawei.com>
> > > Cc: Bin Li <huawei.libin@huawei.com>
> > > Cc: <stable@vger.kernel.org>        [4.10+]
> > > Fixes: 9c2791f936ef (sched/fair: Fix hierarchical order in rq->leaf_c=
fs_rq_list)
> >
> > If it only happens in update_blocked_averages(), the del leaf has been =
added by:
> > a9e7f6544b9c (sched/fair: Fix O(nr_cgroups) in load balance path)
> >
> > > Signed-off-by: Xie XiuQi <xiexiuqi@huawei.com>
> > > Tested-by: Zhipeng Xie <xiezhipeng1@huawei.com>
> > > ---
> > >  kernel/sched/fair.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index ac855b2..7a72702 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -347,6 +347,11 @@ static inline void list_add_leaf_cfs_rq(struct c=
fs_rq *cfs_rq)
> > >  static inline void list_del_leaf_cfs_rq(struct cfs_rq *cfs_rq)
> > >  {
> > >         if (cfs_rq->on_list) {
> > > +               struct rq *rq =3D rq_of(cfs_rq);
> > > +
> > > +               if (rq->tmp_alone_branch =3D=3D &cfs_rq->leaf_cfs_rq_=
list)
> > > +                       rq->tmp_alone_branch =3D cfs_rq->leaf_cfs_rq_=
list.prev;
> > > +
>
> I'm afraid that your patch will break the ordering of leaf_cfs_rq_list
>
> Can you tried the patch below:
>
> ---
>  kernel/sched/fair.c | 7 -------
>  1 file changed, 7 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index ca46964..4d51b2d 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7694,13 +7694,6 @@ static void update_blocked_averages(int cpu)
>                 if (se && !skip_blocked_update(se))
>                         update_load_avg(cfs_rq_of(se), se, 0);
>
> -               /*
> -                * There can be a lot of idle CPU cgroups.  Don't let ful=
ly
> -                * decayed cfs_rqs linger on the list.
> -                */
> -               if (cfs_rq_is_decayed(cfs_rq))
> -                       list_del_leaf_cfs_rq(cfs_rq);
> -
>                 /* Don't need periodic decay once load/util_avg are null =
*/
>                 if (cfs_rq_has_blocked(cfs_rq))
>                         done =3D false;
> --
> 2.7.4
>
>
>
>
> > >                 list_del_rcu(&cfs_rq->leaf_cfs_rq_list);
> > >                 cfs_rq->on_list =3D 0;
> > >         }
> > > --
> > > 1.8.3.1
> > >
