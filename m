Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20CE3C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEFB121873
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbfA1S0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 13:26:19 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:58934 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727227AbfA1S0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 13:26:19 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D854120E9;
        Mon, 28 Jan 2019 18:26:17 +0000 (UTC)
Date:   Mon, 28 Jan 2019 10:26:16 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, mm-commits@vger.kernel.org,
        penguin-kernel@i-love.sakura.ne.jp, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: + memcg-do-not-report-racy-no-eligible-oom-tasks.patch added to
 -mm tree
Message-Id: <20190128102616.d7d63f8e1ecdf176bc313f8a@linux-foundation.org>
In-Reply-To: <20190125172416.GB20411@dhcp22.suse.cz>
References: <20190109190306.rATpT%akpm@linux-foundation.org>
        <20190125165624.GA17719@cmpxchg.org>
        <20190125172416.GB20411@dhcp22.suse.cz>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jan 2019 18:24:16 +0100 Michal Hocko <mhocko@kernel.org> wrote:

> > >     out_of_memory
> > >       select_bad_process # no task
> > > 
> > > If Thread1 didn't race it would bail out from try_charge and force the
> > > charge.  We can achieve the same by checking tsk_is_oom_victim inside the
> > > oom_lock and therefore close the race.
> > > 
> > > [1] http://lkml.kernel.org/r/bb2074c0-34fe-8c2c-1c7d-db71338f1e7f@i-love.sakura.ne.jp
> > > Link: http://lkml.kernel.org/r/20190107143802.16847-3-mhocko@kernel.org
> > > Signed-off-by: Michal Hocko <mhocko@suse.com>
> > > Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> > > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > 
> > It looks like this problem is happening in production systems:
> > 
> > https://www.spinics.net/lists/cgroups/msg21268.html
> > 
> > where the threads don't exit because they are trapped writing out the
> > oom messages to a slow console (running the reproducer from this email
> > thread triggers the oom flooding).
> > 
> > So IMO we should put this into 5.0 and add:
> 
> Please note that Tetsuo has found out that this will not work with the
> CLONE_VM without CLONE_SIGHAND cases and his http://lkml.kernel.org/r/01370f70-e1f6-ebe4-b95e-0df21a0bc15e@i-love.sakura.ne.jp
> should handle this case as well. I've only had objections to the
> changelog but other than that the patch looked sensible to me.

So I think you're saying that 

mm-oom-marks-all-killed-tasks-as-oom-victims.patch
and
memcg-do-not-report-racy-no-eligible-oom-tasks.patch

should be dropped and that "[PATCH v2] memcg: killed threads should not
invoke memcg OOM killer" should be redone with some changelog
alterations and should be merged instead?

