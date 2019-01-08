Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9345C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85B2C2087F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JBCXTWF3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbfAHTBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:01:14 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53774 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727947AbfAHTBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:01:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Kg2ZOj3oRtfmirfVDZJAz6uTlws91sqS1srR4JV9AYU=; b=JBCXTWF3YwF5hqGK9OkYPzmLPe
        k39t1i/HG9XMpJiNJj8Hgda4LWkzjkmKMurXFM2Tx83nmdRzmULzx/d+3fEpde8A0a5a/vF+zjo9H
        spkppwI7V55wNk+NezY5DOTvoUF4pXcbjD2mXwOBIX+QFzwe2BhBrV650hA0stfUfSHxtD8tkqeCe
        FlrDSR5xU/6tsS+Kq9yzoFrAB1ZeoaLolzpjHVz2kEDUnb8WKMgJj31biMCyoMDJq93aJkOVykRnh
        G6Yf3TaSXX0bsvXoxN+TVuTMjQhpw8gHu/xwvl2BSkxB9J2hj5c9aJihTpdvgM3zsDKNkA+UCN8qG
        3uAdbVTQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ggwcc-0006JM-0n; Tue, 08 Jan 2019 19:01:06 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8579420280451; Tue,  8 Jan 2019 20:01:04 +0100 (CET)
Date:   Tue, 8 Jan 2019 20:01:04 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Edward Cree <ecree@solarflare.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        songliubraving@fb.com
Subject: Re: [RFC v2 0/6] x86: dynamic indirect branch promotion
Message-ID: <20190108190104.GC1900@hirez.programming.kicks-ass.net>
References: <20181231072112.21051-1-namit@vmware.com>
 <87zhshe66w.fsf@linux.intel.com>
 <20190107163227.GH14122@hirez.programming.kicks-ass.net>
 <c4e836e8-1949-27f5-f6a0-ed860f590ec5@intel.com>
 <20190108092559.GA6808@hirez.programming.kicks-ass.net>
 <306d38fb-7ce6-a3ec-a351-6c117559ebaa@intel.com>
 <20190108101058.GB6808@hirez.programming.kicks-ass.net>
 <20190108172721.GN6118@tassilo.jf.intel.com>
 <D1A153D5-D23B-45E6-9E7A-EB9CBAE84B7E@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D1A153D5-D23B-45E6-9E7A-EB9CBAE84B7E@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 10:28:02AM -0800, Nadav Amit wrote:
> Is it really that important for debugging to get the instructions at the
> time of execution? Wouldn’t it be easier to annotate the instructions that
> might change? After all, it is not as if any instruction can change to any
> other instruction.

I think PT has a bitstream encoding of branch-taken; to decode and
follow the actual code-flow you then need to have the actual and
accurate branch target from the code. If we go muck about with the code
and change that, decoding gets somewhat 'tricky'.

Or something along those lines..
