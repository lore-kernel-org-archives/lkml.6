Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A54BC43612
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25F9421872
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:32:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730820AbfAILcq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 06:32:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:57338 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730111AbfAILcq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 06:32:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BECEBAEA3;
        Wed,  9 Jan 2019 11:32:43 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 9F36D1E157B; Wed,  9 Jan 2019 12:32:42 +0100 (CET)
Date:   Wed, 9 Jan 2019 12:32:42 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Sasha Levin <sashal@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH AUTOSEL 4.20 016/117] fanotify: return only user
 requested event types in event mask
Message-ID: <20190109113242.GE15397@quack2.suse.cz>
References: <20190108192628.121270-1-sashal@kernel.org>
 <20190108192628.121270-16-sashal@kernel.org>
 <CAOQ4uxgwZjyoEOeRRj0eRsPR2+QmyUht0sErtZV=meKcPTDVcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgwZjyoEOeRRj0eRsPR2+QmyUht0sErtZV=meKcPTDVcA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 09-01-19 08:50:33, Amir Goldstein wrote:
> On Tue, Jan 8, 2019 at 10:11 PM Sasha Levin <sashal@kernel.org> wrote:
> >
> > From: Matthew Bobrowski <mbobrowski@mbobrowski.org>
> >
> > [ Upstream commit 2d10b23082a7eb8be508b3789f2e7250a88a5ddb ]
> >
> > Modify fanotify_should_send_event() so that it now returns a mask for
> > an event that contains ONLY flags for the event types that have been
> > specifically requested by the user. Flags that may have been included
> > within the event mask, but have not been explicitly requested by the
> > user will not be present in the returned value.
> >
> > As an example, given the situation where a user requests events of type
> > FAN_OPEN. Traditionally, the event mask returned within an event that
> > occurred on a filesystem object that has been marked for monitoring and is
> > opened, will only ever have the FAN_OPEN bit set. With the introduction of
> > the new flags like FAN_OPEN_EXEC, and perhaps any other future event
> > flags, there is a possibility of the returned event mask containing more
> > than a single bit set, despite having only requested the single event type.
> > Prior to these modifications performed to fanotify_should_send_event(), a
> > user would have received a bundled event mask containing flags FAN_OPEN
> > and FAN_OPEN_EXEC in the instance that a file was opened for execution via
> > execve(), for example. This means that a user would receive event types
> > in the returned event mask that have not been requested. This runs the
> > possibility of breaking existing systems and causing other unforeseen
> > issues.
> >
> > To mitigate this possibility, fanotify_should_send_event() has been
> > modified to return the event mask containing ONLY event types explicitly
> > requested by the user. This means that we will NOT report events that the
> > user did no set a mask for, and we will NOT report events that the user
> > has set an ignore mask for.
> >
> > The function name fanotify_should_send_event() has also been updated so
> > that it's more relevant to what it has been designed to do.
> >
> > Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
> > Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > ---
> 
> I have no objection to applying this patch to 4.20, but FYI, it does not
> fix anything.  Before introducing FAN_OPEN_EXEC in 5.0-rc1, this patch
> has no visible effect.

Yes, the patch is just a code refactoring useful for the FAN_OPEN_EXEC
feature.

> I don't mind if you apply it. It will make stable code closer to
> mainline, which is always a good thing IMO. And FWIW, I think that patch
> is quite trivial and low risk.

I don't think applying code refactoring to stable is a good idea. Every
change has a risk of regression and this particular one brings users no
benefit. So I'd prefer to drop this patch from stable queue.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
