Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4179ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8713220852
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2lPdmFFF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8713220852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388147AbeGWPFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 11:05:54 -0400
Received: from merlin.infradead.org ([205.233.59.134]:41584 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388029AbeGWPFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 11:05:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zdLIINDLKSmwAWzkS8yDt0uBoMRTdFyHuUY9rQ0vwyU=; b=2lPdmFFFz9DXZ4m7ivTaHTrL0
        kd8wg1yEA/n5wTbQOWRCQkb61fRnm7xJtOHI6PB7znCxxaG/AJldkeczWknwwZ6l4o6CMkgHnrqlm
        XYo2bZoC/cA0pnkprRRFIlvq6fMdbDK5EhzLndWK+BL57YNxQGrKT+KzdH2jYGs8fNUSlw/2tXqb5
        evhofVCTRz+nRZAJSaJm+x9Qiv5WCNjKOozRRnjBrdm0zAEFqvFlwvmsRgocZvGymqmF4E3U2pBP/
        OplXVJHb5XnIliv9l1YIupertG7LaiMQ4A1gvaMA2dGuMCG5VRnemSFvECLAenMGtlZt1SEIvonvZ
        Sra9pTcqg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fhbRn-0007NX-7i; Mon, 23 Jul 2018 14:04:23 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id ECE1020275F47; Mon, 23 Jul 2018 16:04:20 +0200 (CEST)
Date:   Mon, 23 Jul 2018 16:04:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 13/19] mm/migrate: Use xchg instead of spinlock
Message-ID: <20180723140420.GY2458@hirez.programming.kicks-ass.net>
References: <1529514181-9842-1-git-send-email-srikar@linux.vnet.ibm.com>
 <1529514181-9842-14-git-send-email-srikar@linux.vnet.ibm.com>
 <20180723105438.GD2494@hirez.programming.kicks-ass.net>
 <20180723112032.GH30345@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180723112032.GH30345@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 04:20:32AM -0700, Srikar Dronamraju wrote:
> > If you maybe write that like:
> > 
> > 	if (time_after(jiffies, next_window) &&
> > 	    xchg(&pgdat->numabalancing_migrate_nr_pages, 0UL)) {
> > 
> > 		do {
> > 			next_window += interval;
> > 		} while (unlikely(time_after(jiffies, next_window)));
> > 
> > 		WRITE_ONCE(pgdat->numabalancing_migrate_next_window, next_window);
> > 	}
> > 
> > Then you avoid an indent level and line-wrap, resulting imo easier to
> > read code.
> > 
> 
> Okay will do.

FWIW, that code seems to rely on @nr_pages != 0, otherwise you can have
the xchg fail even though time_after is true.

Probably not a problem, but it is a semantic change vs the spinlock.
Also, the spinlock thing could probably have changed to a trylock and
you'd have seens similar 'gains' I suppose.

Another difference vs the lock+unlock is that you lost the release
ordering. Again, probably not a big deal, but it does make the whole
things a little dodgy.
