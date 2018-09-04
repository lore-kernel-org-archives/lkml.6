Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56369C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FBB320645
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NSCL4yCg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FBB320645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727748AbeIDUbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 16:31:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33748 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbeIDUbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 16:31:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wamesnXEMkJQ7j+0Ah2I7TqKePqH+2af/Qpjxo0f79g=; b=NSCL4yCguGIkPrOQ3VRiNBaNb
        7sO219YG+6yQkjFC+gQaznTQII3J7hRrTZIBzT2nAzAMiKlo1tXtpHKK/3RnI74WpxcNk8Wt0fMzG
        +ibWiZI2k+zdmFLF+ozWlunDr7JIyuuWFOCnM6uW/OlsPzs37QoTR9nKnipysoYT4XAUTxUcWGPMs
        KG8EiQpBa0VuNF+aXjUYNVIYdqe73nw0t8oijyiMwdXjxx3puu58WoWFInW5UCtv8AauHhzjawC/x
        +pniaHjaHqtznKuf04r5ldX0+oG6eEgi0tvj77lyymG3VKTBmU3kyeVqrlul4Uz48ptA2yzWr0XR/
        2c6a/w0jQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fxDpn-0003VQ-HS; Tue, 04 Sep 2018 16:05:43 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9838A202AFE0D; Tue,  4 Sep 2018 18:05:41 +0200 (CEST)
Date:   Tue, 4 Sep 2018 18:05:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [RFC] perf tool improvement requests
Message-ID: <20180904160541.GK24124@hirez.programming.kicks-ass.net>
References: <CABPqkBT0kEMOnTw1-E1kezCvtWNSws7dp2qzCWKVmjGPOEga8Q@mail.gmail.com>
 <20180904071049.GY24124@hirez.programming.kicks-ass.net>
 <20180904134218.GA5364@kernel.org>
 <CABPqkBSm9xgqiPx1hUY2njn3SsPGhxjqK02HbM5Qar8di-q97w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBSm9xgqiPx1hUY2njn3SsPGhxjqK02HbM5Qar8di-q97w@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2018 at 08:50:07AM -0700, Stephane Eranian wrote:
> > > When we get an exact IP (using PEBS) and were sampling a data related
> > > event (say L1 misses), we can get the data type from the instruction
> > > itself; that is, through DWARF. We _know_ what type (structure::member)
> > > is read/written to.
> >
> I have been asking this from the compiler people for a long time!
> I don't think it is there. I'd like each load/store to be annotated
> with a data type + offset
> within the type. It would allow data type profiling. This would not be
> bulletproof though
> because of the accessor function problem:
>   void incr(int *v) { (*v)++; }
>   struct foo { int a, int b } bar;
>   incr(&bar.a);

Cute, yes. Also, array accesses are tricky.

But I think even with those caveats it would be _very_ useful.

> There are concern with the volume of data that this
> would generate. But my argument
> is that this is just debug binaries, does not make the stripped binary
> any bigger.

Right; the alternative is that we build an asm interpreter and follow
the data types throughout the function, because DWARF can tell us about
the types at a number of places, like function call arguments etc..

That is, of course, a terrible lot of work :/
