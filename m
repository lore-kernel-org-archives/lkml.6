Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA3DC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 09:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3690A214C1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 09:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Tt9VdO+O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3690A214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731390AbeHGLTP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 07:19:15 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46382 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727156AbeHGLTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 07:19:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GHm7YnteHhMn41bV2KqfzS8FRKyEYvxzwdAoe1+Tzbk=; b=Tt9VdO+OtRQgTpj0LWKuwKFHh
        U924TJW7vDmYnHU/4i1iS/npXooQbGzQF9+ZvVZo4rcSJJgXarH86it8CKHuQqgSTxa9I1f1bN1Pc
        oPnl22EQAJQTg0zZ/zk2MpUWtIeCfNsTPCbSS3/rqeUexLmtbZeHpMajfPduf5303Oy18JXSp/Ghw
        EoOsfi4X38dJ61x4CHDOJh5qkwWNhCJTsWCbWfvQpDRt/Nk9UA3Xvu6oLwD0ZpbI52QEboj0qZWwo
        n/HbL6s7XyiS3Itz3dEYsJubIFlmSrTCYpGWlMX77es7QCU5sgGcYMXnAs+0QsfD00gBWgPxerJoK
        8oO5UVV3w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fmxw3-0007Br-9J; Tue, 07 Aug 2018 09:05:47 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A854520588138; Tue,  7 Aug 2018 11:05:44 +0200 (CEST)
Date:   Tue, 7 Aug 2018 11:05:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Fubo Chen <fubo.chen@gmail.com>
Cc:     jpoimboe@redhat.com, Ingo Molnar <mingo@kernel.org>,
        bhole_prashant_q7@lab.ntt.co.jp,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf/x86/intel: Fix unwind errors from PEBS entries
 (mk-II)
Message-ID: <20180807090544.GX2494@hirez.programming.kicks-ass.net>
References: <20180719153347.buoe6pavpqc75zbb@treble>
 <20180719174311.GK2494@hirez.programming.kicks-ass.net>
 <20180719211954.GZ2512@hirez.programming.kicks-ass.net>
 <CAJAFBLDtRUwYhMaOrgHer4eTvjWL2jC-fy0GGv+Pjd8q3wgywA@mail.gmail.com>
 <20180806154235.GO2494@hirez.programming.kicks-ass.net>
 <CAJAFBLCt574QmeP5N9D-d+Sc67BWQ5E2C=LhqFVvUpchC4O3PQ@mail.gmail.com>
 <20180806180423.GC2476@hirez.programming.kicks-ass.net>
 <CAJAFBLA2WigOMxuWXxZvHVwuGtvYr3_b4gpNbdGzry-=AVxjqA@mail.gmail.com>
 <20180806223008.GW2494@hirez.programming.kicks-ass.net>
 <CAJAFBLDzX78w=uaTdBQ_obb9hBMLGXG1Ec0hb199HEXxXQBPjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJAFBLDzX78w=uaTdBQ_obb9hBMLGXG1Ec0hb199HEXxXQBPjQ@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2018 at 04:04:40PM -0700, Fubo Chen wrote:
> On Mon, Aug 6, 2018 at 3:30 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Mon, Aug 06, 2018 at 02:28:18PM -0700, Fubo Chen wrote:
> > > Do you think the patch below is sufficient to suppress the sparse warning?
> >
> > Why would I want to make the code ugly to supress it?
> 
> There are many kernel developers who use sparse to verify the
> correctness of endianness annotations (__be32, __le32, ...). When
> compiling kernel code with sparse every warning that is reported by
> sparse should be analyzed. Most kernel developers consider it annoying
> having to deal with false positive warnings. So I think that is useful
> to suppress false positive sparse warnings if it is possible to
> suppress false positives with a reasonable effort.

Last time I used sparse there were a metric ton of warnings. I really
can't be bothered about one more. Maybe fix sparse if you're bothered?
