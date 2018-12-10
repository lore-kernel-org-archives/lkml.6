Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB43BC5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DFD02084E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ht4qoTv6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DFD02084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729868AbeLJWvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 17:51:43 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50872 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728778AbeLJWvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 17:51:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PQb1q845RWQZm358ejdkwZ6SIZIUEOGu4lnd0KyFk1k=; b=Ht4qoTv6aSYyOJ2d4RsYJCPS4
        tQ2KGpJHR1j4Dm5tQtn2TPzjq+fv/nwC35YxF7SZ0s3Y9ZHDrUmmKdWHmcfQioafhGGD9ItEMTpy8
        MSGVGJFaCfJDkUeJf5dMjFmlf+goc7oFGNu5l/Ux106fgSM6DAwuiUnpu9eCSKg4HTCQidstPq7VD
        5zFPbNR+ZDMlD1A02MvtLG13GGprBj/0dYFXXzGg3+H5vLv2LSSTl+u2ohFPlOFzjRFf16fe06Fm8
        yzj3v272O8nSAzPa3Z90Ep1ZPjrUaHWfcAlP7Eze6sIlrFG9tdiQWYmXfqHHMoMar8VZuzt3kk1Gq
        YbgBHdfUQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gWUOn-0003Lo-Go; Mon, 10 Dec 2018 22:51:37 +0000
Received: by worktop (Postfix, from userid 1000)
        id C64896E1394; Mon, 10 Dec 2018 23:51:34 +0100 (CET)
Date:   Mon, 10 Dec 2018 23:51:34 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Doug Smythies <dsmythies@telus.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v2] cpuidle: Add 'above' and 'below' idle state metrics
Message-ID: <20181210225134.GB24811@worktop.programming.kicks-ass.net>
References: <3514439.dzOWKx1Cjx@aspire.rjw.lan>
 <20181210122104.GL5289@hirez.programming.kicks-ass.net>
 <CAJZ5v0j-a6cHayRtcsUPbUTBT0iBSUvmcUy6pfSSvUVcTMBxbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0j-a6cHayRtcsUPbUTBT0iBSUvmcUy6pfSSvUVcTMBxbw@mail.gmail.com>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 10:36:40PM +0100, Rafael J. Wysocki wrote:
> On Mon, Dec 10, 2018 at 1:21 PM Peter Zijlstra <peterz@infradead.org> wrote:

> > One question on this; why is this tracked unconditionally?
> 
> Because I didn't quite see how to make that conditional in a sensible way.

Something like:

	if (static_branch_unlikely(__tracepoint_idle_above) ||
	    static_branch_unlikely(__tracepoint_idle_below)) {

		// do stuff that calls trace_idle_above() /
		// trace_idle_below().

	}

> These things are counters and counting with the help of tracepoints
> isn't particularly convenient (and one needs debugfs to be there to
> use tracepoints and they require root access etc).

Root only should not be a problem for a developer; and aren't these
numbers only really interesting if you're prodding at the idle governor?

> > Would not a tracepoint be better?; then there is no overhead in the
> > normal case where nobody gives a crap about these here numbers.
> 
> There is an existing tracepoint that in principle could be used to
> produce this information, but it is such a major PITA in practice that
> nobody does that.  Guess why. :-)

Sounds like you need to ship a convenient script or something :-)

> Also, the "usage" and "time" counters are there in sysfs, so why not these two?
> 
> And is the overhead really that horrible?

Dunno; it could be cold cachelines, at which point it can be fairly
expensive. Also, being stuck with API is fairly horrible if you want to
'fix' it.
