Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB3CC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 07:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55E93214DE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 07:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wzHyWHJY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55E93214DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726058AbeLDHlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 02:41:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:45834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725994AbeLDHlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 02:41:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA91920834;
        Tue,  4 Dec 2018 07:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543909271;
        bh=8e+PiYl6JNqwdbz+QraRMLIChsn94/E1pgngDspvnmU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wzHyWHJYnjxjvRP30sjUFdBRLDekedMKwz/SEcwDgP5aBOz3jRxVHhSnQfWQmyRj7
         XIhtt6ULYdfx0ZYvC7wIaJEZtYe2YZLnNLDV8SKqF6HUL8ZCBGRLi4SHWwVVgTNDxn
         k5XHtCNYLZyZOhtBCExJ++RFiMVQnmovWdHxoKyA=
Date:   Tue, 4 Dec 2018 08:41:09 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Martin Kepplinger <martin.kepplinger@ginzinger.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Sasha Levin <sashal@kernel.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Stable <stable@vger.kernel.org>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        linux-mtd@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Juergen <juergen.lachmann@harman.com>
Subject: Re: [PATCH] ubi: fastmap: Check each mapping only once
Message-ID: <20181204074109.GA27141@kroah.com>
References: <20181126103842.3249-1-martin.kepplinger@ginzinger.com>
 <CADVatmP1h7GJJRVURkinwSM44Y4iooMP-U_7zew4V+zsMva4Vw@mail.gmail.com>
 <20181202143543.GE221015@sasha-vm>
 <1678636.EYQpd7BODG@blindfold>
 <e977dca6-60f0-ce5b-d116-30acf60058f9@ginzinger.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e977dca6-60f0-ce5b-d116-30acf60058f9@ginzinger.com>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 08:39:16AM +0100, Martin Kepplinger wrote:
> On 02.12.18 16:02, Richard Weinberger wrote:
> > Sasha,
> > 
> > Am Sonntag, 2. Dezember 2018, 15:35:43 CET schrieb Sasha Levin:
> > > On Sun, Dec 02, 2018 at 11:50:33AM +0000, Sudip Mukherjee wrote:
> > > > > > Now queued up for 4.14.y, thanks.
> > > > > 
> > > > > can you *please* slow a little down?
> > > > 
> > > > True. It will really help if you can have some sort of fixed schedule
> > > > for stable release, like maybe stablerc is ready on Thursday or Friday
> > > > and release the stable on Monday. Having a weekend in stablerc will be
> > > > helpful for people like me who only get the time in weekends for
> > > > upstream or stable kernel.
> > > 
> > > Any sort of schedule will never work for everyone (for example, if it's
> > > part of your paid job - you don't necessarily want to review stuff over
> > > the weekend).
> > 
> > a schedule is not needed, but please give maintainers at least a chance
> > to react on stable inclusion request.
> > In this case Martin asked for inclusion on Monday and the patch was applied
> > two days later.
> 
> True, especially when the maintainer is asked a question as part of the
> patch.
> 
> I've already had the feeling that we'd need the other patch too, but in this
> case at least I should have searched for Fixes tags.
> 
> Greg, how about reminding people of Fixes tags in
> Documentation/process/stable-kernel-rules.rst ?

Reminding people how?  Patches to that file are always gladly accepted :)

thanks,

greg k-h
