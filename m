Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA794ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0C2520852
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eAOF2EU4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0C2520852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388415AbeGWPQD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 11:16:03 -0400
Received: from merlin.infradead.org ([205.233.59.134]:41704 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388102AbeGWPQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 11:16:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1qRw0stbsLX3KZASsJ0S5ra2Ga533lDT7uIbtnuem88=; b=eAOF2EU47Qc+u6Ul21Xs+fo2x
        ZDNFd/B0E0lKWMvHueUX1V9SfI4MrLE1VpTfkVI56M6guwNJvcLpuRTOiOXrKynHAHxKwFZEjLG9M
        mpL2sxUwdRAt35kpscr4rFX0zfk7ZeOlMtIO/94OQyrgOHjtLschHvzPN9SK9SeRdHPgWv9FpI7yp
        GP0YFr/D5pwV6XKH0jILyAEsLTWZ27YBBX61b3yKb939JBgO0+TIc/naUUDo1/DTbf5YSQVR9G8wu
        820pH3EwaN+cBZzaCaxyFGH36Hyx908KZByvx8q4eZjuPUVaFEvBXa4CZB53xEODDpSBo5qoxibMD
        B2YJHzJLw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fhbbY-0007SZ-Ek; Mon, 23 Jul 2018 14:14:28 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 26F2320275F47; Mon, 23 Jul 2018 16:14:27 +0200 (CEST)
Date:   Mon, 23 Jul 2018 16:14:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Prashant Bhole <bhole_prashant_q7@lab.ntt.co.jp>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/x86/intel: Fix unwind errors from PEBS entries
 (mk-II)
Message-ID: <20180723141427.GA2458@hirez.programming.kicks-ass.net>
References: <60466ab6-311b-ad8d-2f79-32702174cb95@lab.ntt.co.jp>
 <20180719153347.buoe6pavpqc75zbb@treble>
 <20180719174311.GK2494@hirez.programming.kicks-ass.net>
 <20180719211954.GZ2512@hirez.programming.kicks-ass.net>
 <20180723133006.7mkzrdeaa4jo56md@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180723133006.7mkzrdeaa4jo56md@treble>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 08:30:06AM -0500, Josh Poimboeuf wrote:
> On Thu, Jul 19, 2018 at 11:19:54PM +0200, Peter Zijlstra wrote:
> > --- a/include/uapi/linux/perf_event.h
> > +++ b/include/uapi/linux/perf_event.h
> > @@ -143,6 +143,8 @@ enum perf_event_sample_format {
> >  	PERF_SAMPLE_PHYS_ADDR			= 1U << 19,
> >  
> >  	PERF_SAMPLE_MAX = 1U << 20,		/* non-ABI */
> > +
> > +	__PERF_SAMPLE_CALLCHAIN_EARLY		= 1UL << 63,
> 
> Given the kbuild test robot errors for building on 32-bit, looks like
> the 63 needs to be changed to 31 so it fits in an int?

I made it 1ULL << 63. The actual field (perf_event_attr::sample_type is
u64).
