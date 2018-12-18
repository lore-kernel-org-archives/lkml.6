Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D91C8C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9D07217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wiNfxZ7S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbeLRLCY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 06:02:24 -0500
Received: from merlin.infradead.org ([205.233.59.134]:36482 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbeLRLCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 06:02:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KVDyShIHy6Q3LiFxJcfGuwsez7qnc/pFs5hzLCu6bag=; b=wiNfxZ7SgvTiBCRT1coJK685D
        mYWu5C9ruhS1qBGmhl2YMwwCUVoFJBgxfQaxymeJH6fUvW+9jpJrldJ33zts9WG7U/z1SXEiQNA02
        iPCukchJVLFFh4F1YHYUmxXnedUKuXc6sD4QufeUC+7q6BdSmQHigiVYx7JWe8ubsLHbPithAVraF
        n0tmG8tMyLoKEqt93EBW6Q4nX/2Np+urSOCXt6EhMq8R4OYVa8js62aRsdZJioeBK6ZVI9wOpo5Mm
        nCr2At3a3iCvDvhBFkS64XIdungw1JvleO8oHcmvltVBN1Euhes26xAfTaiDKFxisV/43/gyz1UUB
        JtgJQi/ng==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gZD8d-0007Vx-SZ; Tue, 18 Dec 2018 11:02:12 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 019A82027B9FA; Tue, 18 Dec 2018 12:02:09 +0100 (CET)
Date:   Tue, 18 Dec 2018 12:02:09 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     zhe.he@windriver.com
Cc:     acme@kernel.org, ak@linux.intel.com,
        alexander.shishkin@linux.intel.com, bp@alien8.de, hpa@zytor.com,
        jolsa@kernel.org, jolsa@redhat.com, kan.liang@linux.intel.com,
        mingo@redhat.com, namhyung@kernel.org, tglx@linutronix.de,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] perf/x86/intel: Avoid unnecessary reallocations of
 memory allocated in cpu hotplug prepare state
Message-ID: <20181218110209.GD15430@hirez.programming.kicks-ass.net>
References: <1545129033-21757-1-git-send-email-zhe.he@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545129033-21757-1-git-send-email-zhe.he@windriver.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 06:30:33PM +0800, zhe.he@windriver.com wrote:
> Besides, in preempt-rt full mode, the freeing can happen in atomic context and
> thus cause the following BUG.

Hurm, I though we fixed all those long ago..

And no, the patch is horrible; that's what we have things like
x86_pmu::cpu_dead() for.
