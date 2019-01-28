Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00FBEC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B72A42171F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548701011;
	bh=hJrYZDLe+YFEGj7aoyevHKsgNVfjWv6antMiu3zBQUQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Jo3v3CrULKKNF80Jb4JMqSoR8AhChNX8rpMC08NsHptwIz2OB/ET1cLBZoHFeH3qG
	 5XiyDHXI7I7KI5YuMn/zSmpY1BDbUt8qprpon4FDsUhs7EuvmXq0fABSBStauSu+Ll
	 +0jXZPWKnRgYnOtyjWOfxmjwZdsSYmHfXB9biZ/c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbfA1Sna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 13:43:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:56232 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727246AbfA1Sn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 13:43:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E8810B018;
        Mon, 28 Jan 2019 18:43:27 +0000 (UTC)
Date:   Mon, 28 Jan 2019 19:43:26 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, mm-commits@vger.kernel.org,
        penguin-kernel@i-love.sakura.ne.jp, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: + memcg-do-not-report-racy-no-eligible-oom-tasks.patch added to
 -mm tree
Message-ID: <20190128184326.GT18811@dhcp22.suse.cz>
References: <20190109190306.rATpT%akpm@linux-foundation.org>
 <20190125165624.GA17719@cmpxchg.org>
 <20190125172416.GB20411@dhcp22.suse.cz>
 <20190128102616.d7d63f8e1ecdf176bc313f8a@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128102616.d7d63f8e1ecdf176bc313f8a@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 28-01-19 10:26:16, Andrew Morton wrote:
> On Fri, 25 Jan 2019 18:24:16 +0100 Michal Hocko <mhocko@kernel.org> wrote:
> 
> > > >     out_of_memory
> > > >       select_bad_process # no task
> > > > 
> > > > If Thread1 didn't race it would bail out from try_charge and force the
> > > > charge.  We can achieve the same by checking tsk_is_oom_victim inside the
> > > > oom_lock and therefore close the race.
> > > > 
> > > > [1] http://lkml.kernel.org/r/bb2074c0-34fe-8c2c-1c7d-db71338f1e7f@i-love.sakura.ne.jp
> > > > Link: http://lkml.kernel.org/r/20190107143802.16847-3-mhocko@kernel.org
> > > > Signed-off-by: Michal Hocko <mhocko@suse.com>
> > > > Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> > > > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > > > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > > 
> > > It looks like this problem is happening in production systems:
> > > 
> > > https://www.spinics.net/lists/cgroups/msg21268.html
> > > 
> > > where the threads don't exit because they are trapped writing out the
> > > oom messages to a slow console (running the reproducer from this email
> > > thread triggers the oom flooding).
> > > 
> > > So IMO we should put this into 5.0 and add:
> > 
> > Please note that Tetsuo has found out that this will not work with the
> > CLONE_VM without CLONE_SIGHAND cases and his http://lkml.kernel.org/r/01370f70-e1f6-ebe4-b95e-0df21a0bc15e@i-love.sakura.ne.jp
> > should handle this case as well. I've only had objections to the
> > changelog but other than that the patch looked sensible to me.
> 
> So I think you're saying that 
> 
> mm-oom-marks-all-killed-tasks-as-oom-victims.patch
> and
> memcg-do-not-report-racy-no-eligible-oom-tasks.patch
> 
> should be dropped and that "[PATCH v2] memcg: killed threads should not
> invoke memcg OOM killer" should be redone with some changelog
> alterations and should be merged instead?

Yup.

-- 
Michal Hocko
SUSE Labs
