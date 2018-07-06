Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D0B8C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF48523FCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="q1k4WZgN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF48523FCE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933320AbeGFNVi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 09:21:38 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45378 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932833AbeGFNVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 09:21:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XLMhFXfpO97zP3A+ie+dPn9f7PxeOJR4PrUSQqBg1rM=; b=q1k4WZgNoTJFUALnw4z2PzE+B
        ilZe8SlzIl3qTr1nHGb+Y4nEuqzAF/ROQfc2vD3H61SDlP/1FY+T8S8F28NA0bP2PzZZJd393Y5TN
        Mmnz8md54bHlImhdXFJ66cuH9J/uV1F1YAhDft+OFz07YYz+8B/59yg/GlvWh4Upi2lp2NFXMWIaC
        52P2TXS19RZcrFlHYXKxFiXiDgMKvodZQGzzvfJ+OVitkgfU/TN6iXlFe9AJptp5jwrqTUegkKUaP
        t7s0C3pX1N//nTnZ5Pgkt0kohTHDf3eiFyj6A3iF244bv+gnUAy66S0YPxlJqbpPG0CHFCZBpYK34
        ik0eswoqA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fbQft-0001Ho-NW; Fri, 06 Jul 2018 13:21:25 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 74D8120289CF4; Fri,  6 Jul 2018 15:21:24 +0200 (CEST)
Date:   Fri, 6 Jul 2018 15:21:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, andy.shevchenko@gmail.com,
        arnd@arndb.de, aryabinin@virtuozzo.com, boqun.feng@gmail.com,
        catalin.marinas@arm.com, dvyukov@google.com, glider@google.com,
        hpa@zytor.com, linuxdrivers@attotech.com, mingo@kernel.org,
        mingo@redhat.com, parri.andrea@gmail.com, peter@hurleysoftware.com,
        tglx@linutronix.de
Subject: Re: [PATCHv3 00/12] atomics: generate atomic headers / instrument
 arm64
Message-ID: <20180706132124.GN2494@hirez.programming.kicks-ass.net>
References: <20180705164053.10073-1-mark.rutland@arm.com>
 <20180706131603.GA11172@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706131603.GA11172@arm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 02:16:04PM +0100, Will Deacon wrote:
> Hi Mark,
> 
> On Thu, Jul 05, 2018 at 05:40:41PM +0100, Mark Rutland wrote:
> > This series scripts the generation of the various atomic headers, to ensure
> > that the various atomic APIs remain consistent, reducing the risk of human
> > error, and simplifying future rework. This fleshes out the instrumented atomics
> > such that arm64 can be migrated over to them.
> 
> Thanks! For the series apart from the shell scripts:
> 
> Acked-by: Will Deacon <will.deacon@arm.com>

Awesome, Ingo can you stuff these here patches into locking/core
someplace?
