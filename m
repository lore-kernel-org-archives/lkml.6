Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F18B4C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 11:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE2C821655
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 11:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZW1fmKnL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE2C821655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbeHTOSM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 10:18:12 -0400
Received: from merlin.infradead.org ([205.233.59.134]:60740 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbeHTOSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 10:18:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pt1XV7TMguPjcBhIviy74GSY8GGerSZJ83xEDpix5Ak=; b=ZW1fmKnL+qDl+M7GntOAYn1IV
        oCCVc3cOOO02rcPi9S6dvGHrR9h9IudZt3pXs9D52tYWks/e0eR3dZXJ3ZSoKWVar4u/KpPZyqDmR
        a+KigeSPcHUuCBj/kgZ/LRv4OByBc8b35cv8OycpjnLPEVeeV/wzPsgE1b2+eF9pMFHejsbF0ryRN
        HMjQamBfbHWtNLO8w7PhB55qSCDXGRfoIb9BJh9WtvmnES6os2uYaRvDsN0OyH3xdGZ9YiCLYIxNM
        uVUyuU+GozklOVWUduYSJY48RcXJ2Z5g9sfnoqRghHxvbIVoRxaOSQR1NmK63sIxgDUWOauy07SVg
        4EQHZf2dA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1frhxY-0003fY-Gl; Mon, 20 Aug 2018 11:02:57 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0DD6520267B13; Mon, 20 Aug 2018 13:02:54 +0200 (CEST)
Date:   Mon, 20 Aug 2018 13:02:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v5] cpuidle: menu: Handle stopped tick more aggressively
Message-ID: <20180820110254.GX2494@hirez.programming.kicks-ass.net>
References: <1951009.1jlQfyrxio@aspire.rjw.lan>
 <1754612.IcCR94pSYR@aspire.rjw.lan>
 <1582055.9b67urWYFa@aspire.rjw.lan>
 <1572343.jWaXB8XNF1@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572343.jWaXB8XNF1@aspire.rjw.lan>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 12:34:40PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Commit 87c9fe6ee495 (cpuidle: menu: Avoid selecting shallow states
> with stopped tick) missed the case when the target residencies of
> deep idle states of CPUs are above the tick boundary which may cause
> the CPU to get stuck in a shallow idle state for a long time.
> 
> Say there are two CPU idle states available: one shallow, with the
> target residency much below the tick boundary and one deep, with
> the target residency significantly above the tick boundary.  In
> that case, if the tick has been stopped already and the expected
> next timer event is relatively far in the future, the governor will
> assume the idle duration to be equal to TICK_USEC and it will select
> the idle state for the CPU accordingly.  However, that will cause the
> shallow state to be selected even though it would have been more
> energy-efficient to select the deep one.
> 
> To address this issue, modify the governor to always use the time
> till the closest timer event instead of the predicted idle duration
> if the latter is less than the tick period length and the tick has
> been stopped already.  Also make it extend the search for a matching
> idle state if the tick is stopped to avoid settling on a shallow
> state if deep states with target residencies above the tick period
> length are available.
> 
> In addition, make it always indicate that the tick should be stopped
> if it has been stopped already for consistency.
> 
> Fixes: 87c9fe6ee495 (cpuidle: menu: Avoid selecting shallow states with stopped tick)
> Reported-by: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Seems OK,

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
