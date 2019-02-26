Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D4FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F34B2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbfBZQUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 11:20:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52754 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728165AbfBZQUz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 11:20:55 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E6F193001974;
        Tue, 26 Feb 2019 16:20:54 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.31])
        by smtp.corp.redhat.com (Postfix) with SMTP id E5BE760BF4;
        Tue, 26 Feb 2019 16:20:51 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 26 Feb 2019 17:20:53 +0100 (CET)
Date:   Tue, 26 Feb 2019 17:20:50 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     Sherry Yang <sherryy@android.com>, Michal Hocko <mhocko@suse.com>,
        srikar@linux.vnet.ibm.com, songliubraving@fb.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        aneesh.kumar@linux.ibm.com,
        syzbot+1068f09c44d151250c33@syzkaller.appspotmail.com
Subject: Re: [PATCH] Uprobes: Fix deadlock between delayed_uprobe_lock and
 fs_reclaim
Message-ID: <20190226162049.GB21443@redhat.com>
References: <20190204040614.20450-1-ravi.bangoria@linux.ibm.com>
 <20190206133601.GA21522@redhat.com>
 <0f6683c9-50c8-f26f-02e0-4689eee8ea5d@linux.ibm.com>
 <611d2ba9-c14b-4580-a7ec-8bcf0013cd6b@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <611d2ba9-c14b-4580-a7ec-8bcf0013cd6b@linux.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Tue, 26 Feb 2019 16:20:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/26, Ravi Bangoria wrote:
>
> On 2/8/19 2:03 PM, Ravi Bangoria wrote:
> >
> >
> > On 2/6/19 7:06 PM, Oleg Nesterov wrote:
> >> Ravi, I am on vacation till the end of this week, can't read your patch
> >> carefully.
> >>
> >> I am not sure I fully understand the problem, but shouldn't we change
> >> binder_alloc_free_page() to use mmput_async() ? Like it does if trylock
> >> fails.
> >
> > I don't understand binderfs code much so I'll let Sherry comment on this.
>
> Sherry, Can you please comment on this.

Yes, please. I don't even know what android/binder does, but I think we need
the trivial patch below.

If nothing else, any reason why err_down_write_mmap_sem_failed needs _async
should equally apply to the case when down_write_trylock() succeeds, no?

And. This lockdep report basically means that (without this change) kmalloc
is not safe under any lock which can be taken in __mmput() path, I don't think
we should blame or change uprobes.c.

Oleg.

--- x/drivers/android/binder_alloc.c
+++ x/drivers/android/binder_alloc.c
@@ -981,7 +981,7 @@ enum lru_status binder_alloc_free_page(s
 		trace_binder_unmap_user_end(alloc, index);

 		up_write(&mm->mmap_sem);
-		mmput(mm);
+		mmput_async(mm);
 	}

 	trace_binder_unmap_kernel_start(alloc, index);

