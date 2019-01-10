Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE543C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 07:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B974121872
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 07:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547106871;
	bh=8JRS7t3LQBVuWRrn2OKmr2Gbs+pjdCgQrXxyEHhWL1k=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=ZmoZi3bx2KdSXZo3tlJorl0K2vXoo12k6yxui00XrqNoiEStB4TD0blHnhwaILHeX
	 JpybcaWhiLvyFl3dkeHx04D5sG2otJ8UUKPOopJhNoxqxWtkJIrtOWVE0HKLQlMDJO
	 OL16x1mLX77JJ3LdNm5B3HxVqgeCUi7mw3koOvSM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbfAJHyb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 02:54:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:42192 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726137AbfAJHya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 02:54:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 10AADAC6E;
        Thu, 10 Jan 2019 07:54:29 +0000 (UTC)
Date:   Thu, 10 Jan 2019 08:54:23 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>, Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH] mm/mincore: allow for making sys_mincore() privileged
In-Reply-To: <20190110011533.GI27534@dastard>
Message-ID: <nycvar.YFH.7.76.1901100852080.6626@cbobk.fhfr.pm>
References: <20190106001138.GW6310@bombadil.infradead.org> <CAHk-=wiT=ov+6zYcnw_64ihYf74Amzqs67iVGtJMQq65PxiVYw@mail.gmail.com> <CAHk-=wg1A44Roa8C4dmfdXLRLmNysEW36=3R7f+tzZzbcJ2d2g@mail.gmail.com> <CAHk-=wiqbKEC5jUXr3ax+oUuiRrp=QMv_ZnUfO-SPv=UNJ-OTw@mail.gmail.com>
 <20190108044336.GB27534@dastard> <CAHk-=wjvzEFQcTGJFh9cyV_MPQftNrjOLon8YMMxaX0G1TLqkg@mail.gmail.com> <20190109022430.GE27534@dastard> <nycvar.YFH.7.76.1901090326460.16954@cbobk.fhfr.pm> <20190109043906.GF27534@dastard> <nycvar.YFH.7.76.1901091050560.16954@cbobk.fhfr.pm>
 <20190110011533.GI27534@dastard>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jan 2019, Dave Chinner wrote:

> > Yeah, preadv2(RWF_NOWAIT) is in the same teritory as mincore(), it has 
> > "just" been overlooked. I can't speak for Daniel, but I believe he might 
> > be ok with rephrasing the above as "Restricting mincore() and RWF_NOWAIT 
> > is sufficient ...".
> 
> Good luck with restricting RWF_NOWAIT. I eagerly await all the
> fstests that exercise both the existing and new behaviours to
> demonstrate they work correctly.

Well, we can still resurrect my original aproach of doing this opt-in 
based on a sysctl setting, and letting the admin choose his poison.

If 'secure' mode is selected, RWF_NOWAIT will then probably just always 
fail wit EAGAIN.

-- 
Jiri Kosina
SUSE Labs

