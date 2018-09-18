Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB1CBC04ABA
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F6882086E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fbJoFM63"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F6882086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729833AbeIRTKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 15:10:54 -0400
Received: from merlin.infradead.org ([205.233.59.134]:53496 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727207AbeIRTKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 15:10:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=p0rsKkkMM1fWB2KKGf3W9qkuVQvLMIK38763629zTxs=; b=fbJoFM63l2pCC7CrQWNFh4T/CG
        ZLliht3mJPzU+bg3ntEsNQ3Yy26od+xAelI8+5hM5nqq4XlTpwhM8IRtI95CGFWKVtDEEAZJ8r+V1
        zhXlc0ebBC1JbVmIAobGFqvonS5rUcEDKDS0AcPElJzZ4dVuTKBsH1g/1NnHvC6T0AtzLf1Z6upma
        HlxlG8DhZPEdze7s9GGVP8Ls8LV2XOXuSn+Yd0yFf6fggZ1ywP0bgg/ovzzuAbI5s7bfolVYG59ET
        FFHGYQ/O0yLsJRaYjSRuBlczvsDRgGUEbW/rJUoq2zw/lbgzuYGkdlD3So5VV9W7m7xjYCpYPQvWm
        LiTFd0kQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g2GCd-00030z-2j; Tue, 18 Sep 2018 13:38:07 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 64CE5202C1A38; Tue, 18 Sep 2018 15:38:05 +0200 (CEST)
Date:   Tue, 18 Sep 2018 15:38:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jan =?iso-8859-1?Q?H=2E_Sch=F6nherr?= <jschoenh@amazon.de>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Paul Turner <pjt@google.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Rik van Riel <riel@surriel.com>
Subject: Re: Task group cleanups and optimizations (was: Re: [RFC 00/60]
 Coscheduling for Linux)
Message-ID: <20180918133805.GN24106@hirez.programming.kicks-ass.net>
References: <20180907214047.26914-1-jschoenh@amazon.de>
 <20180914111251.GC24106@hirez.programming.kicks-ass.net>
 <1d86f497-9fef-0b19-50d6-d46ef1c0bffa@amazon.de>
 <282230fe-b8de-01f9-c19b-6070717ba5f8@amazon.de>
 <20180917094844.GR24124@hirez.programming.kicks-ass.net>
 <08b930d9-7ffe-7df3-ab35-e7b58073e489@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <08b930d9-7ffe-7df3-ab35-e7b58073e489@amazon.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 03:22:13PM +0200, Jan H. Schönherr wrote:
> On 09/17/2018 11:48 AM, Peter Zijlstra wrote:
> > On Sat, Sep 15, 2018 at 10:48:20AM +0200, Jan H. Schönherr wrote:
> >> On 09/14/2018 06:25 PM, Jan H. Schönherr wrote:
> > 
> >>> b) ability to move CFS RQs between CPUs: someone changed the affinity of
> >>>    a cpuset? No problem, just attach the runqueue with all the tasks elsewhere.
> >>>    No need to touch each and every task.
> > 
> > Can't do that, tasks might have individual constraints that are tighter
> > than the cpuset.
> 
> AFAIK, changing the affinity of a cpuset overwrites the individual affinities of tasks
> within them. Thus, it shouldn't be an issue.

No, it only shrinks the set. Also nothing stops you calling
sched_setaffinity() once you're inside the cpuset. The only contraint is
that your mask is a subset of the cpuset mask.
