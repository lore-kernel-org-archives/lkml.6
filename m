Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A332C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 422802075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KQmmN+/4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 422802075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbeIFQxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 12:53:13 -0400
Received: from merlin.infradead.org ([205.233.59.134]:44206 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727644AbeIFQxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 12:53:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YM2BXb1hp6s5v0LAvUCGh6OvlPbSp5YrhzsXsfNN27g=; b=KQmmN+/4cb5NfZK5y6MKTJyjE
        ncwBxrlhW8mCPvkd9RgVswtQDZCkU9YBCzgNg61uLtc7JldDQrETH/DtTCehEC8Cg0pIYwBKg8sbU
        7M6eJN0fEOPMDuZ6QJEkVmUIG1aNAhTeNDAtOlCtBp+bMLnGa2DO6UxtCY3QQU99zJiVBugeTP2Lj
        PwpjtaJxz4Kg+eLpIXEH+mmoX5CRlluyiXnFtxW6HXMFbqTCize3Fst1qZWD5imhjxsD23PkVgOti
        bw6uvxpQZrH90SEwtEfDYtjHXUcKPwyrxEGFH+ZohFxdGwuAYHsAUQCFObM5nvGZtWY3bDCheNwnX
        YFgztALug==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fxtEO-00029p-9C; Thu, 06 Sep 2018 12:17:52 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BF6FD201F9C42; Thu,  6 Sep 2018 14:17:50 +0200 (CEST)
Date:   Thu, 6 Sep 2018 14:17:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/6] numa-balancing patches
Message-ID: <20180906121750.GI24082@hirez.programming.kicks-ass.net>
References: <1533276841-16341-1-git-send-email-srikar@linux.vnet.ibm.com>
 <20180821120150.GB2080@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180821120150.GB2080@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 05:01:50AM -0700, Srikar Dronamraju wrote:
> * Srikar Dronamraju <srikar@linux.vnet.ibm.com> [2018-08-03 11:43:55]:
> 
> > This patchset based on current tip/sched/core, provides left out patches
> > from the previous series. This version handles the comments given to some of
> > the patches. It drops "sched/numa: Restrict migrating in parallel to the same
> > node." It adds an additional patch from Mel Gorman.
> > It also provides specjbb2005 /dbench/ perf bench numa numbers on a patch
> > basis on 4 node and 2 node systems.
> > 
> > v2: http://lkml.kernel.org/r/1529514181-9842-1-git-send-email-srikar@linux.vnet.ibm.com
> > v1: http://lkml.kernel.org/r/1528106428-19992-1-git-send-email-srikar@linux.vnet.ibm.com
> > 
> 
> Hi Peter, Ingo
> 
> Can you please respond with your comments suggestions.
> 
> Mel and Rik have acked most of the patches.

The patches do not contain a single ack.

But I pickd them up now. Thanks.
