Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D391C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 13:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EBC620658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 13:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QqACMXaN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EBC620658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbeH3RHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 13:07:03 -0400
Received: from merlin.infradead.org ([205.233.59.134]:34844 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728789AbeH3RHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 13:07:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jwhfN8K0sgEjwa3G9QFiEqUZWEdB1n8YtT3aeeR0nek=; b=QqACMXaNSYvbJWZle91xK4Dj+
        Y/VxiVSY+TUSNHEHywWv8Sy1Cb5rExzpqWqAeII5ltteTS4xxzFBQlgkjJYASQGjWn22v5CTnMXnF
        G+biCFmqizjgvy4CAqnYg4SrUYUjCN2f9Tm2aR8iGQtwkSn56vptbf5MZ/UpjgfrOK8u50Mls/bPg
        OZcbkGeAuUOx0+HRAVWiEU4GfRhU5mXa/bmiKeJknMAy+HxCV0R+/SgiC+312LmqXwnrwDht2cXTT
        CO3PvOZFrGVi+wwI/6zjPzkWDmp8yc2xZSwG/1d6HhqFvnV/aJwg3+SnQy4pCsC8blIbcQmin6ULo
        ++9f7mGXw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fvMcs-0000M3-I8; Thu, 30 Aug 2018 13:04:43 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 307332024D73F; Thu, 30 Aug 2018 15:04:39 +0200 (CEST)
Date:   Thu, 30 Aug 2018 15:04:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Siegfried Metz <frame@mailbox.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        rafael.j.wysocki@intel.com, len.brown@intel.com, rjw@rjwysocki.net,
        diego.viola@gmail.com, rui.zhang@intel.com,
        viktor_jaegerskuepper@freenet.de
Subject: Re: REGRESSION: boot stalls on several old dual core Intel CPUs
Message-ID: <20180830130439.GM24082@hirez.programming.kicks-ass.net>
References: <74c5abc8-7430-5bc9-2f8a-a2205608bee7@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74c5abc8-7430-5bc9-2f8a-a2205608bee7@mailbox.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 12:55:30PM +0200, Siegfried Metz wrote:
> Dear kernel developers,
> 
> since mainline kernel 4.18 (up to the latest mainline kernel 4.18.5)
> Intel Core 2 Duo processors are affected by boot stalling early in the
> boot process. As it is so early there is no dmesg output (or any log).
> 
> A few users in the Arch Linux community used git bisect and tracked the
> issue down to this the bad commit:
> 7197e77abcb65a71d0b21d67beb24f153a96055e clocksource: Remove kthread

I just dug out my core2duo laptop (Lenovo T500) and build a tip/master
kernel for it (x86_64 debian distro .config).

Seems to boot just fine.. 3/3 so far.

Any other clues?
