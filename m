Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1802FC070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 21:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B752520C0A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 21:04:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B752520C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lichtvoll.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbeIMCKS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 22:10:18 -0400
Received: from mondschein.lichtvoll.de ([194.150.191.11]:55523 "EHLO
        mail.lichtvoll.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbeIMCKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 22:10:18 -0400
Authentication-Results: auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id A84EA3AA705;
        Wed, 12 Sep 2018 23:03:56 +0200 (CEST)
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Intel Gfx Mailing List <intel-gfx@freedesktop.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Intel-gfx] [REGRESSION 4.19-rc2] sometimes hangs with black screen when resuming from suspend or hibernation (was: Re: Linux 4.19-rc2)
Date:   Wed, 12 Sep 2018 23:03:55 +0200
Message-ID: <4227681.v6uuv6rMDp@merkaba>
In-Reply-To: <20180912171020.GE5565@intel.com>
References: <CA+55aFyG0GbDfoghEhAmKBPcZCiPu6CCpPRz9GwjCzLuP_Vv5Q@mail.gmail.com> <3346308.cXARZRajoW@merkaba> <20180912171020.GE5565@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ville Syrjälä - 12.09.18, 19:10:
> On Tue, Sep 11, 2018 at 12:17:05PM +0200, Martin Steigerwald wrote:
> > Cc´d Intel Gfx mailing list, in case somebody there knows something:
> > 
> > Cc´d Thorsten for regression tracking… forgot initially. Can also
> > open bug report at a later time but so far I cannot provide many
> > details about the issue.
> > 
> > Rafael J. Wysocki - 11.09.18, 10:17:
> > > On Tue, Sep 11, 2018 at 10:01 AM Martin Steigerwald
> > 
> > <martin@lichtvoll.de> wrote:
> > > > Hi.
> > > > 
> > > > Linus Torvalds - 02.09.18, 23:45:
> > > > > As usual, the rc2 release is pretty small. People are taking a
> > > > 
> > > > With 4.19-rc2 this ThinkPad T520 with i5 Sandybrdige sometimes
> > > > hangs
> > > > with black screen when resuming from suspend or hibernation. 
> > > > With
> > > > 4.18.1 it did not. Of course there have been userspace related
> > > > updates that could be related.
> > > > 
> > > > I currently have no time to dig into this and on this production
> > > > laptop I generally do not do bisects between major kernel
> > > > releases.
> > > > So currently I only answer questions that do not require much
> > > > time
> > > > to answer.
> > > > 
> > > > For now I switched back to 4.18. If that is stable – and thus
> > > > likely
> > > > no userspace component is related –, I go with 4.19-rc3 or
> > > > whatever
> > > > is most recent version to see if the issue has been fixed
> > > > already.
> > > 
> > > There were almost no general changes related to system-wide PM
> > > between 4.18 and current, so I would suspect one of the device
> > > drivers or the x86 core.  It also may be something like CPU
> > > online/offline, however.> 
> > I see. I wondered about intel-gfx driver already. Of course it could
> > also be something else.
> > 
> > I forgot to mention: The mouse pointer was visible, but the screen
> > remained black.
> 
> Did the mouse cursor still move or not?

No, it did not move.

> Could also try suspend without any GUI stuff in the way. Or try the
> intel ddx instead of the modesetting ddx (assuming that's what
> you're using now) and no compositor to rule out GPU hangs killing
> the compositor. The intel ddx can also deal with the GPU not
> recovering from a hang by switching to software rendering,
> whereas modesetting cannot.

Thanks for these suggestions. Currently laptop is still on 4.18 again 
(4.18.7) and I did not see this hang after resume so far. If it 
continues to be stable for a few more days, I try with latest 4.19 again 
as then its very likely kernel related.

> Hmm. Also T520 is an optimus laptop maybe? If there's an nvidia
> GPU involved it's going to be hard to get anyone to care. Better
> switch that off in the BIOS if you haven't already.

I decided back then for Intel only graphics. I never regretted this.

For me NVidia graphics is not an option, unless NVidia significantly 
changes their policy regarding free software drivers.

Thanks,
-- 
Martin


