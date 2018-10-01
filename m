Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 884E5C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 598542084C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:25:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 598542084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729155AbeJAQCr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 12:02:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:54996 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729038AbeJAQCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 12:02:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5EAFDB044;
        Mon,  1 Oct 2018 09:25:55 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 58C7C1E093C; Mon,  1 Oct 2018 11:25:49 +0200 (CEST)
Date:   Mon, 1 Oct 2018 11:25:49 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     rong.a.chen@intel.com, Jan Kara <jack@suse.cz>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, LKP <lkp@01.org>
Subject: Re: [LKP] [fsnotify] 60f7ed8c7c: will-it-scale.per_thread_ops -5.9%
 regression
Message-ID: <20181001092549.GC3913@quack2.suse.cz>
References: <20180930065100.GL15893@shao2-debian>
 <CAOQ4uxiHkufAtt87bMs9n-0sFxJSHsBxDX6jn8v28vkvy=a_qQ@mail.gmail.com>
 <CAOQ4uxgqBgYiGpf_6zrZk=L2bAQsujzcFE0ZzUXFHu8AnHSk7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgqBgYiGpf_6zrZk=L2bAQsujzcFE0ZzUXFHu8AnHSk7g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 30-09-18 12:16:45, Amir Goldstein wrote:
> On Sun, Sep 30, 2018 at 12:00 PM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Sun, Sep 30, 2018 at 9:50 AM kernel test robot <rong.a.chen@intel.com> wrote:
> > >
> > > Greeting,
> > >
> > > FYI, we noticed a -5.9% regression of will-it-scale.per_thread_ops due to commit:
> > >
> > >
> > > commit: 60f7ed8c7c4d06aeda448c6da74621552ee739aa ("fsnotify: send path type events to group with super block marks")
> > > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> > >
> > > in testcase: will-it-scale
> > > on test machine: 88 threads Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz with 64G memory
> > > with following parameters:
> > >
> > >         nr_task: 16
> > >         mode: thread
> > >         test: unlink2
> > >         cpufreq_governor: performance
> > >
> > > test-description: Will It Scale takes a testcase and runs it from 1 through to n parallel copies to see if the testcase will scale. It builds both a process and threads based test in order to see any differences between the two.
> > > test-url: https://github.com/antonblanchard/will-it-scale
> > >
> > >
> > >
> > > Details are as below:
> > > -------------------------------------------------------------------------------------------------->
> > >
> > >
> > > To reproduce:
> > >
> > >         git clone https://github.com/intel/lkp-tests.git
> > >         cd lkp-tests
> > >         bin/lkp install job.yaml  # job file is attached in this email
> > >         bin/lkp run     job.yaml
> > >
> > > =========================================================================================
> > > compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
> > >   gcc-7/performance/x86_64-rhel-7.2/thread/16/debian-x86_64-2018-04-03.cgz/lkp-bdw-ep3d/unlink2/will-it-scale
> > >
> > > commit:
> > >   1e6cb72399 ("fsnotify: add super block object type")
> > >   60f7ed8c7c ("fsnotify: send path type events to group with super block marks")
> > >
> >
> > I have to admit this looks strange.
> > All this commit does is dereference mnt->mnt.mnt_sb and then
> > sb->s_fsnotify_mask/sb->s_fsnotify_marks to find that they are zero.
> > AFAICT there should be no extra contention added by this commit and it's
> > hard to believe that parallel unlink workload would suffer from this change.
> >
> > I will try to install lkp-tests to verify this on my own system, but
> > until proven
> > otherwise I will regard this as false positive.
> >
> 
> Actually, is it possible to ask for a private test with the following patch
> to optimize out an unneeded srcu_derefence().
> This optimization (assuming it is correct) could in fact improve scaling
> compared to upstream, because there are already 2 calls to
> fsnotify_first_mark in the code. The blamed commit just adds a 3rd one.

I'd be surprised if your patch actually changed anything. On x86,
srcu_dereference(foo) is just READ_ONCE(foo) and that is just a syntactic
suggar around foo to make sure compiler really fetches the value from
memory to a register only once... But it's probably worth a try.

> I am assuming that() in the test there is an fsnotify mount mark (maybe setup
> by systemd) otherwise, the optimization in line 351 would have not reached
> the extra fsnotify_first_mark() call.
> Can you confirm or disprove the assumption that an fanotify mount mark
> is present during the test?

This would be good to know.

								Honza

> ----
> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index 422fbc6dffde..8d45d82e09ff 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -246,6 +246,9 @@ static struct fsnotify_mark
> *fsnotify_first_mark(struct fsnotify_mark_connector
>         struct fsnotify_mark_connector *conn;
>         struct hlist_node *node = NULL;
> 
> +       if (!*connp)
> +               return NULL;
> +
>         conn = srcu_dereference(*connp, &fsnotify_mark_srcu);
>         if (conn)
>                 node = srcu_dereference(conn->list.first, &fsnotify_mark_srcu);
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
