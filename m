Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB7DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 11:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE84A21783
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 11:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547206437;
	bh=JAu6dM5ltIAaZLsL+moCh74R4z07us1l7E167AnkIqo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=odJ7TCWeKz4rPW3Xtzr2PROPoMJ3rsEHe0k57GFjmbzjMC1LE5XSg9/2qUMBrKyIQ
	 rhTz1wlpQCToDyDBuQtct5Ey/ewmyo6VBdlhLCaY9Ey5z0lM8FDAMlZL46lFmGtDcU
	 PjLwa8nCgxUJm3bqd/EXwM4c4lRt8qQsaOE/hIjw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731339AbfAKLd4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 06:33:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:39424 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729901AbfAKLd4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 06:33:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 423D5AE63;
        Fri, 11 Jan 2019 11:33:55 +0000 (UTC)
Date:   Fri, 11 Jan 2019 12:33:54 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] oom, memcg: do not report racy no-eligible OOM
Message-ID: <20190111113354.GD14956@dhcp22.suse.cz>
References: <e55fb27c-f23b-0ac5-acfd-7265c0a3b8dc@i-love.sakura.ne.jp>
 <20190109120212.GT31793@dhcp22.suse.cz>
 <201901102359.x0ANxIbn020225@www262.sakura.ne.jp>
 <fbdfdfeb-5664-ddf3-4d65-c64f9851ac26@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbdfdfeb-5664-ddf3-4d65-c64f9851ac26@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 11-01-19 19:25:22, Tetsuo Handa wrote:
> On 2019/01/11 8:59, Tetsuo Handa wrote:
> > Michal Hocko wrote:
> >> On Wed 09-01-19 20:34:46, Tetsuo Handa wrote:
> >>> On 2019/01/09 20:03, Michal Hocko wrote:
> >>>> Tetsuo,
> >>>> can you confirm that these two patches are fixing the issue you have
> >>>> reported please?
> >>>>
> >>>
> >>> My patch fixes the issue better than your "[PATCH 2/2] memcg: do not
> >>> report racy no-eligible OOM tasks" does.
> >>
> >> OK, so we are stuck again. Hooray!
> > 
> > Andrew, will you pick up "[PATCH 3/2] memcg: Facilitate termination of memcg OOM victims." ?
> > Since mm-oom-marks-all-killed-tasks-as-oom-victims.patch does not call mark_oom_victim()
> > when task_will_free_mem() == true, memcg-do-not-report-racy-no-eligible-oom-tasks.patch
> > does not close the race whereas my patch closes the race better.
> > 
> 
> I confirmed that mm-oom-marks-all-killed-tasks-as-oom-victims.patch and
> memcg-do-not-report-racy-no-eligible-oom-tasks.patch are completely failing
> to fix the issue I am reporting. :-(

OK, this is really interesting. This means that we are racing
when marking all the tasks sharing the mm with the clone syscall.
Does fatal_signal_pending handle this better?
-- 
Michal Hocko
SUSE Labs
