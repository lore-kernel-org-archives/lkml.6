Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4F4C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 02:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F06C2177F
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 02:46:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F06C2177F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lge.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbeHVGIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 02:08:41 -0400
Received: from lgeamrelo11.lge.com ([156.147.23.51]:50341 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbeHVGIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 02:08:41 -0400
Received: from unknown (HELO lgemrelse6q.lge.com) (156.147.1.121)
        by 156.147.23.51 with ESMTP; 22 Aug 2018 11:45:52 +0900
X-Original-SENDERIP: 156.147.1.121
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO X58A-UD3R) (10.177.222.33)
        by 156.147.1.121 with ESMTP; 22 Aug 2018 11:45:52 +0900
X-Original-SENDERIP: 10.177.222.33
X-Original-MAILFROM: byungchul.park@lge.com
Date:   Wed, 22 Aug 2018 11:45:35 +0900
From:   Byungchul Park <byungchul.park@lge.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        kernel-team@lge.com
Subject: Re: [PATCH 1/2] workqueue: skip lockdep wq dependency in
 cancel_work_sync()
Message-ID: <20180822024535.GA2414@X58A-UD3R>
References: <20180821120317.4115-1-johannes@sipsolutions.net>
 <20180821120317.4115-2-johannes@sipsolutions.net>
 <20180821160814.GP3978217@devbig004.ftw2.facebook.com>
 <1534871894.25523.34.camel@sipsolutions.net>
 <20180821172711.GR3978217@devbig004.ftw2.facebook.com>
 <1534872621.25523.39.camel@sipsolutions.net>
 <20180821175550.GS3978217@devbig004.ftw2.facebook.com>
 <1534879241.25523.44.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534879241.25523.44.camel@sipsolutions.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 09:20:41PM +0200, Johannes Berg wrote:
> On Tue, 2018-08-21 at 10:55 -0700, Tejun Heo wrote:
> 
> > > I'm not really sure what you think we might be missing? Am I missing
> > > some case where cancel_work_sync() can possibly deadlock? Apart from the
> > > issue I addressed in the second patch, obviously.
> > 
> > Ah, that was me being slow.  I thought you were skipping the work's
> > lockdep_map.  I can almost swear we had that before (the part you're
> > adding on the second patch).  Right, fd1a5b04dfb8 ("workqueue: Remove
> > now redundant lock acquisitions wrt. workqueue flushes") removed it
> > because it gets propagated through wait_for_completion().  Did we miss
> > some cases with that change?
> 
> Hmm.
> 
> It doesn't seem to be working.
> 
> No, ok, actually it probably *does*, but the point is similar to my
> issue # 3 before - we don't do any of this unless the work is actually
> running, but we really want the lockdep annotation *regardless* of that,
> so that we catch the error unconditionally.
> 
> So perhaps that commit just needs to be reverted entirely - I'd only
> looked at a small subset of it, but the flush_workqueue() case has the
> same problem - we only get to the completion when there's something to
> flush, not when the workqueue happens to actually be empty. But again,
> for lockdep we want to catch *potential* problems, not only *actual*
> ones.
> 
> The remaining part of the patch I'm not sure I fully understand (removal
> of lockdep_init_map_crosslock()), but I suppose if we revert the other
> bits we need to revert this as well.
> 
> So please drop this patch, but revert Byungchul Park's commit
> fd1a5b04dfb8 again, I don't think the lockdep annotations there are
> really redundant as I just explained.

That should've been adjusted as well when Ingo reverted Cross-release.
It would be much easier to add each pair, acquire/release, before
wait_for_completion() in both flush_workqueue() and flush_work() than
reverting the whole commit.

What's lacking is only lockdep annotations for wait_for_completion().

Byungchul

> 
> johannes
