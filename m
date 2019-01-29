Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7BC0C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B75132087E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ec0i2dTs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbfA2KlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 05:41:07 -0500
Received: from merlin.infradead.org ([205.233.59.134]:57168 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbfA2KlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 05:41:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pJ8AxhrRM9qT1PNZ3CqRF8YEvfKWIQCI2sjgTj85hTc=; b=ec0i2dTsAeVCskkDxACabq9aV
        7xMJKYYAEJ0GB+I00fp+EO1ATXhQGAYu3NxV/kM6hfpoh08LPixWOub7Df5z/kwUNaj/HqJp9X//Q
        +9g97E1qQ0rFOmubcT2Zt/n1vSFXPWZFRQoXq6NWx7biB3edFUsGOVMUlrxF1KhPVPlATi5rJQR12
        cNfqXyoStGByRZxIkIGfBmaIkRY2pLLGXIWXq72fVpKW3h9OqBPKoZeSIx5pZdXF1L00as/9PL5ih
        /Vg+tAHSFA5xEi8NFy8dxsNd6oxDKywueV5bIJbmDhkvJoqln7Ndv9YfHv+QICCtxxZ0+kWSjzpCh
        29LBvpfGQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1goQp4-0000JW-OO; Tue, 29 Jan 2019 10:40:55 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 77F9A201EC171; Tue, 29 Jan 2019 11:40:53 +0100 (CET)
Date:   Tue, 29 Jan 2019 11:40:53 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chunyan Zhang <chunyan.zhang@unisoc.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Vincent Wang <vincent.wang@unisoc.com>,
        Quentin Perret <quentin.perret@arm.com>,
        linux-kernel@vger.kernel.org, Chunyan Zhang <zhang.lyra@gmail.com>
Subject: Re: [PATCH V3] sched/cpufreq: calculate util / cap in advance in
 map_util_freq()
Message-ID: <20190129104053.GI28467@hirez.programming.kicks-ass.net>
References: <1548656841-3440-1-git-send-email-chunyan.zhang@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548656841-3440-1-git-send-email-chunyan.zhang@unisoc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 02:27:21PM +0800, Chunyan Zhang wrote:
> From: "vincent.wang" <vincent.wang@unisoc.com>
> 
> When a task that is in_iowait state is enqueued, cpufreq_update_util()
> will be invoked with SCHED_CPUFREQ_IOWAIT flag. In this case,the value
> of util and cap, which are parameters used in map_util_freq(), will be
> cpu frequency, instead of cpu util and capactiy.

Didn't I tell you to fix the IOWAIT case to not pass in such large
numbers?
