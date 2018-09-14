Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4019DFC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 12:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA19720881
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 12:01:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IxTw6N2b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA19720881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbeINRPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 13:15:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39784 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727134AbeINRPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 13:15:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=JasgV8QD5xXOe86E0sCadXzIoKd4fLwFxGn3HK5uZbo=; b=IxTw6N2bBV7sV0pNDxeE/MwRe
        ENj6hA6k6cykmRmRwKNk3A8BIy43lPaFCR2zfcIOnHo/z6xhVqXEBXuXBbzCj2taeyfIf7lMqP2aw
        qVHZWv2HPaWW3Yn+3K7OaE/2exUoDfexAc1cJnnZDJkMpUFaSGz2sPXDZe4Jr6c7H9tVuA0Rzdt0V
        YdDQXZSP1nTBxeJFMiDrm8a0cD8Ky6+k716+KLEG44QYUKx3VeeaygJJrNYXEAy7C7xb3w7sxFMmO
        6z76kYNk89svX7K2+fxgMZYsly7AJN9KdIfEPOXd84q6ZtIX/ULHbGzLhU52YpW01zXPHBdZ/3NXp
        GcM1Bijfg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g0mmx-0000P5-BK; Fri, 14 Sep 2018 12:01:31 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B537F202B2E3B; Fri, 14 Sep 2018 14:01:29 +0200 (CEST)
Date:   Fri, 14 Sep 2018 14:01:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <andi@firstfloor.org>, kernel-team@lge.com
Subject: Re: [RFCv2 00/48] perf tools: Add threads to record command
Message-ID: <20180914120129.GJ24124@hirez.programming.kicks-ass.net>
References: <20180913125450.21342-1-jolsa@kernel.org>
 <cba27d6a-a97b-cbb7-4be8-d1c14fb7dea5@linux.intel.com>
 <20180914022910.GA15146@sejong>
 <20180914082307.GF24224@krava>
 <20180914094022.GB96351@gmail.com>
 <20180914111528.GH24124@hirez.programming.kicks-ass.net>
 <20180914114725.GB17042@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180914114725.GB17042@krava>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 01:47:25PM +0200, Jiri Olsa wrote:
> On Fri, Sep 14, 2018 at 01:15:28PM +0200, Peter Zijlstra wrote:
> > On Fri, Sep 14, 2018 at 11:40:22AM +0200, Ingo Molnar wrote:
> > > In fact keeping the files separate has scalability advantages for 'perf report' and similar 
> > > parsing tools: they could read all the streams in a per-CPU fashion already, from the very 
> > > beginning.
> > 
> > Also writing to different files from different CPUs is good for record,
> > less contention on the inode state (which include pagecache).
> 
> maybe I should explain a little bit more on this
> 
> we write to different (per-cpu) files during the record,
> and at the end of the session, we take them and store
> them inside perf.data

How long does it take to combine that? If we generated a lot of data,
that could take a fair amount of time, no?

I feel that record should not mysteriously 'hang' when it is done. It
used to do that at some point because of that stupid .debug crap, but
acme fixed that I think.
