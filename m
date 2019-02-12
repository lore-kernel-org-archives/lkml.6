Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A6F9C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06E6C2083B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549980080;
	bh=2BvZe1Ts98EG+kycQmlMUqHyGNFczCKJ6kp7vjQxb8E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eBWQJMY+Pgqevf+X7W4yCmONZN+hTCkUjdPN4BIMiqNnaZ5uK5cnXdz4dEmP2Dobt
	 egSj2NxxF8UIDHZk+I8QZyZPW1lD+UYnR87jXuJP1JBuumqPnKeIICm6kbXEp4tElK
	 lRPMDHtlWpvy7qEKg6plNWG5nGBw3BL7Mju7QFGM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730156AbfBLOBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 09:01:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:34982 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728126AbfBLOBS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 09:01:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 62C4AAEFF;
        Tue, 12 Feb 2019 14:01:16 +0000 (UTC)
Date:   Tue, 12 Feb 2019 15:01:14 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jann Horn <jannh@google.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Chinner <david@fromorbit.com>,
        Kevin Easton <kevin@guarana.org>,
        Matthew Wilcox <willy@infradead.org>,
        Cyril Hrubis <chrubis@suse.cz>, Tejun Heo <tj@kernel.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Daniel Gruss <daniel@gruss.cc>, Josh Snyder <joshs@netflix.com>
Subject: Re: [PATCH 3/3] mm/mincore: provide mapped status when cached status
 is not allowed
Message-ID: <20190212140114.GX15609@dhcp22.suse.cz>
References: <nycvar.YFH.7.76.1901051817390.16954@cbobk.fhfr.pm>
 <20190130124420.1834-1-vbabka@suse.cz>
 <20190130124420.1834-4-vbabka@suse.cz>
 <20190131100907.GS18811@dhcp22.suse.cz>
 <99ee4d3e-aeb2-0104-22be-b028938e7f88@suse.cz>
 <nycvar.YFH.7.76.1902120440430.11598@cbobk.fhfr.pm>
 <20190212063643.GL15609@dhcp22.suse.cz>
 <nycvar.YFH.7.76.1902121405440.11598@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.1902121405440.11598@cbobk.fhfr.pm>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 12-02-19 14:09:03, Jiri Kosina wrote:
> On Tue, 12 Feb 2019, Michal Hocko wrote:
> 
> > I would go with patch 1 for 5.1. Patches 2 still sounds controversial or
> > incomplete to me. 
> 
> Is it because of the disagreement what 'non-blocking' really means, or do 
> you see something else missing?

Not only. See the remark from Dave [1] that the patch in its current
form seems to be incomplete. Also FS people were not involved
properly to evaluate all the potential fallouts. Even if the only way
forward is to "cripple" IOCB_NOWAIT then the documentation should go
along with the change rather than suprise people much later when the
system behaves unexpectedly. So I _think_ this patch is not really ready
yet.

Also I haven't heard any discussion whether we can reduce the effect of
the change in a similar way we do for mincore.

> Merging patch just patch 1 withouth patch 2 is probably sort of useless 
> excercise, unfortunately.

Why would that be the case. We know that mincore is the simplest way
_right now_. Closing it makes sense on its own.

[1] http://lkml.kernel.org/r/20190201014446.GU6173@dastard
-- 
Michal Hocko
SUSE Labs
