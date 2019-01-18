Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 996C8C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F61320850
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:16:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vPUmQTyo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbfARQQ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 11:16:26 -0500
Received: from merlin.infradead.org ([205.233.59.134]:33800 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727241AbfARQQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 11:16:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8J0KEgksINfaZwZNgj6ZCNAGBR3wkWZqqcLlb6hhP/E=; b=vPUmQTyoS8r9xPbjTsgvLC4f5
        6PyhG9WFkJZllxljlHBMpQVpKMBa7fI3wOgzujeTEyn9GRbIy/qlq3slvLrGyueoaFriIG07f7OmR
        CU9aLkCqZ9VzchYmENm68HI67jhGzjWrSkNAwqCnR4iKwNFJtZ3hrbQsQf9Ltj1ZpHpyoNSbjXnES
        CldzsuMFhs08RUb3mR6WPONlrF/bS1PNltQ/QcpMMovfHDBBWktEtt7xsCMZuNaRmhbzxzanpf0qP
        sHtO4XKN7y5U+2tnKvengidENL9TULbN61kTLMSyryvr6LjEutvXbfSZG0buBYYr+vUtrYV7HBn/k
        p3llGvTRg==;
Received: from [89.200.44.227] (helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gkWob-00046w-VG; Fri, 18 Jan 2019 16:16:18 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4454B9818FF; Fri, 18 Jan 2019 17:16:16 +0100 (CET)
Date:   Fri, 18 Jan 2019 17:16:16 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chunyan Zhang <chunyan.zhang@unisoc.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Vincent Wang <vincent.wang@unisoc.com>,
        Quentin Perret <quentin.perret@arm.com>,
        linux-kernel@vger.kernel.org, Chunyan Zhang <zhang.lyra@gmail.com>
Subject: Re: [PATCH V2] sched/cpufreq: calculate util / cap in advance in
 map_util_freq()
Message-ID: <20190118161616.GH14054@worktop.programming.kicks-ass.net>
References: <1547089325-15691-1-git-send-email-chunyan.zhang@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547089325-15691-1-git-send-email-chunyan.zhang@unisoc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 11:02:05AM +0800, Chunyan Zhang wrote:
> From: Vincent Wang <vincent.wang@unisoc.com>
> 
> When a task that is in_iowait state is enqueued, cpufreq_update_util()
> will be invoked with SCHED_CPUFREQ_IOWAIT flag. In this case,the value
> of util and cap, which are parameters used in map_util_freq(), will be
> cpu frequency, instead of cpu util and capactiy.
> 
> For some 32bit architectures, the size of unsigned long is 32. When
> calculating freq, there may be an overflow error in this expression:

Would it not be much better to fix that one case instead of adding extra
instructions for everyone all the time?
