Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC31C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E0292084C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:32:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E0292084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbeJAQJt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 12:09:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:57428 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728804AbeJAQJs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 12:09:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 246E3B05A;
        Mon,  1 Oct 2018 09:32:55 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A6C7E1E356C; Mon,  1 Oct 2018 11:32:49 +0200 (CEST)
Date:   Mon, 1 Oct 2018 11:32:49 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     rong.a.chen@intel.com, Jan Kara <jack@suse.cz>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, LKP <lkp@01.org>
Subject: Re: [LKP] [fsnotify] 60f7ed8c7c: will-it-scale.per_thread_ops -5.9%
 regression
Message-ID: <20181001093249.GD3913@quack2.suse.cz>
References: <20180930065100.GL15893@shao2-debian>
 <CAOQ4uxiHkufAtt87bMs9n-0sFxJSHsBxDX6jn8v28vkvy=a_qQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxiHkufAtt87bMs9n-0sFxJSHsBxDX6jn8v28vkvy=a_qQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 30-09-18 12:00:46, Amir Goldstein wrote:
> On Sun, Sep 30, 2018 at 9:50 AM kernel test robot <rong.a.chen@intel.com> wrote:
> >
> > Greeting,
> >
> > FYI, we noticed a -5.9% regression of will-it-scale.per_thread_ops due to commit:
> >
> >
> > commit: 60f7ed8c7c4d06aeda448c6da74621552ee739aa ("fsnotify: send path type events to group with super block marks")
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> >
> > in testcase: will-it-scale
> > on test machine: 88 threads Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz with 64G memory
> > with following parameters:
> >
> >         nr_task: 16
> >         mode: thread
> >         test: unlink2
> >         cpufreq_governor: performance
> >
> > test-description: Will It Scale takes a testcase and runs it from 1 through to n parallel copies to see if the testcase will scale. It builds both a process and threads based test in order to see any differences between the two.
> > test-url: https://github.com/antonblanchard/will-it-scale
> >
> >
> >
> > Details are as below:
> > -------------------------------------------------------------------------------------------------->
> >
> >
> > To reproduce:
> >
> >         git clone https://github.com/intel/lkp-tests.git
> >         cd lkp-tests
> >         bin/lkp install job.yaml  # job file is attached in this email
> >         bin/lkp run     job.yaml
> >
> > =========================================================================================
> > compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
> >   gcc-7/performance/x86_64-rhel-7.2/thread/16/debian-x86_64-2018-04-03.cgz/lkp-bdw-ep3d/unlink2/will-it-scale
> >
> > commit:
> >   1e6cb72399 ("fsnotify: add super block object type")
> >   60f7ed8c7c ("fsnotify: send path type events to group with super block marks")
> >
> 
> I have to admit this looks strange.
> All this commit does is dereference mnt->mnt.mnt_sb and then
> sb->s_fsnotify_mask/sb->s_fsnotify_marks to find that they are zero.
> AFAICT there should be no extra contention added by this commit and it's
> hard to believe that parallel unlink workload would suffer from this change.

Well, it could be those additional fetches of
sb->s_fsnotify_mask/sb->s_fsnotify_marks if they happen to be cache cold.
Or it could be just code layout differences (i.e., compiler is not able to
optimize resulting code as good or the code layout just happens to align
with cache lines in a wrong way or something like that). Anyway, without
being able to reproduce this and do detailed comparison of perf profiles I
don't think we'll be able to tell.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
