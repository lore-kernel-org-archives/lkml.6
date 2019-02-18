Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 941A0C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57FC521773
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550517266;
	bh=7TrL3/Dx5Qd9idBQj7w4ezPkKcjRB5vD90M+9YssUZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vMfkwj5fnna7LxvzKBDcaTDiKxpbjvC6YyPSNksSDHJl9xp68rxysWVfm/OxvYB5G
	 0UecceSJThy7NOvr3bPkndY1EuWRi8eVxBqNlckOF4rfqehCkPjzu/B2kllCBCkXzT
	 rrxlX4FIkGNh+h6zq9JL/gxVpsxHbSYM+8wgLAvQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729105AbfBRTOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 14:14:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:33320 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728501AbfBRTOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 14:14:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F384AABD5;
        Mon, 18 Feb 2019 19:14:22 +0000 (UTC)
Date:   Mon, 18 Feb 2019 20:14:21 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rik van Riel <riel@surriel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Wolfgang Walter <linux@stwm.de>, Spock <dairinin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 4.20 71/92] Revert "mm: slowly shrink slabs with a
 relatively small number of objects"
Message-ID: <20190218191421.GE4525@dhcp22.suse.cz>
References: <20190218133454.668268457@linuxfoundation.org>
 <20190218133501.533140116@linuxfoundation.org>
 <a998a5028aa3bb17a5a60fffd3db558223b84cd5.camel@surriel.com>
 <20190218161634.GA30873@kroah.com>
 <20190218173825.GB4525@dhcp22.suse.cz>
 <20190218185738.GA3745@castle.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190218185738.GA3745@castle.DHCP.thefacebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 18-02-19 18:57:45, Roman Gushchin wrote:
> On Mon, Feb 18, 2019 at 06:38:25PM +0100, Michal Hocko wrote:
> > On Mon 18-02-19 17:16:34, Greg KH wrote:
> > > On Mon, Feb 18, 2019 at 10:30:44AM -0500, Rik van Riel wrote:
> > > > On Mon, 2019-02-18 at 14:43 +0100, Greg Kroah-Hartman wrote:
> > > > > 4.20-stable review patch.  If anyone has any objections, please let
> > > > > me know.
> > > > > 
> > > > > ------------------
> > > > > 
> > > > > From: Dave Chinner <dchinner@redhat.com>
> > > > > 
> > > > > commit a9a238e83fbb0df31c3b9b67003f8f9d1d1b6c96 upstream.
> > > > > 
> > > > > This reverts commit 172b06c32b9497 ("mm: slowly shrink slabs with a
> > > > > relatively small number of objects").
> > > > 
> > > > This revert will result in the slab caches of dead
> > > > cgroups with a small number of remaining objects never
> > > > getting reclaimed, which can be a memory leak in some
> > > > configurations.
> > > > 
> > > > But hey, that's your tradeoff to make.
> > > 
> > > That's what is in Linus's tree.  Should we somehow diverge from that?
> > 
> > I believe we should start working on a memcg specific solution to
> > minimize regressions for others and start a more complex solution from
> > there.
> > 
> > Can we special case dead memcgs in the slab reclaim and reclaim more
> > aggressively?
> 
> It's probably better to start a new thread to discuss this issue

agreed

> (btw, doesn't LSF/MM looks like the best place to do it? I can send a proposal).

I was about to do that if nobody else did.

dropped the rest of the email because this really deserves a new
discussion.
-- 
Michal Hocko
SUSE Labs
