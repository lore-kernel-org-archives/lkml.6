Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59FFEECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 117362146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Oy/J3kUx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 117362146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729843AbeIRTPF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 15:15:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58046 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727207AbeIRTPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 15:15:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=un2oZt/A9xE4GNb1l+xXgkrBkW4XBT2tlo/fYYXlJS0=; b=Oy/J3kUxadyxKx1BZ7P1xV+Elr
        5fZ1wBPwN/ghOHzk1Y/7RKG94Xx1KLgcZuAPNVncXipzbHo7+yAFoEeJvijgGS6BhmiuY40VuuvSK
        xFLaG2NP5fy14LnL24WETazJm6VfVkFF03rbF8YlgPTgpTan3Ck8H5lnCLTxNapNVlqAqnjcHVek3
        bgmV7bU70A4UTO9g3JUda0I7ZB3wvc5Xdxt2i19LEvUNE+/e+Mm6xCdkFCQGkK7aV2EqqZzYpvlkI
        lcgNKvkySdMpfUI4knxUnTx6uEMulaKOmjrCm6OpnVyeGQkCdk3vnMhYOPz1lYpxLc0H9RgEmBQUH
        PX+BJFiQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g2GGd-00032c-3e; Tue, 18 Sep 2018 13:42:15 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 90270202C1A2E; Tue, 18 Sep 2018 15:42:13 +0200 (CEST)
Date:   Tue, 18 Sep 2018 15:42:13 +0200
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
Message-ID: <20180918134213.GV24124@hirez.programming.kicks-ass.net>
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
> to always restrict tasks in a task group to just one core/node/whatever. On an
> SMT system, you would typically need at most two runqueues for a core; the memory

You forget that SMT4 and SMT8 are fairly common outside of x86.
