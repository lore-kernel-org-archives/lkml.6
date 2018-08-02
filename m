Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C42EC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E1A62150A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:39:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SvvGu54R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E1A62150A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732374AbeHBOad (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 10:30:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34446 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732130AbeHBOac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 10:30:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=X+gueWMU+QorZpcfp+foDLCYffln1iijYVQt60xvrTM=; b=SvvGu54RxuNOdOeV5qv5EIlH6
        gusSbGGLzLtZMQ+Jke+gHA5+PcQBSOS7ivH++isw3MCCv0dfjFnlUQSnFhmDs/oSAZOyBezLUH3qV
        8bKc2SXuJcGsksBO9lE/Cf8PfRb5NTgBKKZhD8CGY8IrYeDpSM15xoMu0tDXWAqHgK4pSmczVf5Bp
        6nKNrqq7goyDO5c1WzLsWrqPCTY5dxMlwxdt0g4cd4o83wUQKW6Z1/Sk68R76wP9o/SVMRymsxdoA
        n8mg6NjqelAYA1Rm16qwpx4LzwSaS1gu+uvvJs8XBOfZ5hXkQA/KngAFsC9gXEp6/WP48MibnBdWL
        7NDYrqwhw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1flCt3-00076E-JU; Thu, 02 Aug 2018 12:39:25 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 14A0020268263; Thu,  2 Aug 2018 14:39:24 +0200 (CEST)
Date:   Thu, 2 Aug 2018 14:39:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, fenghua.yu@intel.com,
        tony.luck@intel.com, vikas.shivappa@linux.intel.com,
        gavin.hindman@intel.com, jithu.joseph@intel.com,
        dave.hansen@intel.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] x86/intel_rdt and perf/x86: Fix lack of coordination
 with perf
Message-ID: <20180802123923.GJ2530@hirez.programming.kicks-ass.net>
References: <cover.1533064851.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1533064851.git.reinette.chatre@intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 12:38:27PM -0700, Reinette Chatre wrote:
> Dear Maintainers,
> 
> The success of Cache Pseudo-Locking can be measured via the use of
> performance events. Specifically, the number of cache hits and misses
> reading a memory region after it has been pseudo-locked to cache. This
> measurement is triggered via the resctrl debugfs interface.
> 
> To ensure most accurate results the performance counters and their
> configuration registers are accessed directly.

NAK on that.
