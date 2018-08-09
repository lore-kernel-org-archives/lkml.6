Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A70C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D1E521EA3
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="K2VCe/p8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D1E521EA3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732483AbeHIROc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 13:14:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:33638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732124AbeHIROc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 13:14:32 -0400
Received: from tleilax.poochiereds.net (cpe-71-70-156-158.nc.res.rr.com [71.70.156.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC12021E97;
        Thu,  9 Aug 2018 14:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533826157;
        bh=V72XnSvUa/hFMB7S9QoWPT+9JtHZpdqEsC4e7vv9dtc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=K2VCe/p8W4MpIM8d4ulhtbGQ4SlgzlDuGxubFoIT00jfVqFzRx7uaRUU/Nnjzl3LP
         hnbRAJl6NcIqNzAx7ZlX1v9qgMxehLIcGYcsqL48LEERcdoOD9OnSqYnGWv1XXwsPB
         1AJ8wipHEpwP++kucerOJCeeMoJQZM0Uke3JxL2E=
Message-ID: <4f9b616df9eb8ee5e29e1fd313edeca9fd97db90.camel@kernel.org>
Subject: Re: [PATCH 0/4] locks: avoid thundering-herd wake-ups
From:   Jeff Layton <jlayton@kernel.org>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     NeilBrown <neilb@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Wilck <mwilck@suse.de>
Date:   Thu, 09 Aug 2018 10:49:15 -0400
In-Reply-To: <20180809130001.GG23873@fieldses.org>
References: <153369219467.12605.13472423449508444601.stgit@noble>
         <20180808195445.GD23873@fieldses.org> <20180808200912.GE23873@fieldses.org>
         <20180808212832.GF23873@fieldses.org>
         <04ffa27c29d2bff8bd9cb9b6d4ea6b6fd3969b6c.camel@kernel.org>
         <20180809130001.GG23873@fieldses.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-08-09 at 09:00 -0400, J. Bruce Fields wrote:
> On Wed, Aug 08, 2018 at 06:50:06PM -0400, Jeff Layton wrote:
> > That seems like a legit problem.
> > 
> > One possible fix might be to have the waiter on (1,2) walk down the
> > entire subtree and wake up any waiter that is waiting on a lock that
> > doesn't conflict with the lock on which it's waiting.
> > 
> > So, before the task waiting on 1,2 goes back to sleep to wait on 2,2, it
> > could walk down its entire fl_blocked subtree and wake up anything
> > waiting on a lock that doesn't conflict with (2,2).
> > 
> > That's potentially an expensive operation, but:
> > 
> > a) the task is going back to sleep anyway, so letting it do a little
> > extra work before that should be no big deal
> 
> I don't understand why cpu used by a process going to sleep is cheaper
> than cpu used in any other situation.
> 

It's not any cheaper in that sense. It's just that this task is not
slated to be doing any useful work anyway as it's going to sleep, so we
aren't delaying any "real work" by this task by having it do this 
before returning to userland. It's already scheduled and holds the
appropriate lock.

The alternative would be to do this in the context of a different task,
but that means extra context switching and spinlocking, etc.

> > b) it's probably still cheaper than waking up the whole herd
> 
> Yeah, I'd like to understand this.
> 
> I feel like Neil's addressing two different performance costs:
> 
> 	- the cost of waking up all the waiters
> 	- the cost of walking the list of waiters
> 
> Are they equally important?
> 
> If we only cared about the former, and only in simple cases, we could
> walk the entire list and skip waking up only the locks that conflict
> with the first one we wake.  We wouldn't need the tree.

-- 
Jeff Layton <jlayton@kernel.org>

