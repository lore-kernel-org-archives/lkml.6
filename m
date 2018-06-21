Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1541C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 19:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8519E21CCF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 19:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YULie6aw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8519E21CCF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933293AbeFUTzw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 15:55:52 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33222 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932899AbeFUTzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 15:55:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Z84Xm/UqbzujvAjIs+QD/VTeO6yPNzfp+L8JEZkP/ds=; b=YULie6awFV/YM+JoRNhxMJdmI
        UuQ6C9Qo0Qm+bXod3mvUOtr7/ndC5mE7+N1qX841/5R66m3e8xc73rNjWSXUYW7kUwQutF7B8W0yt
        TCD9ZRdRAH1Pb85J9SGzN2lDoGbTna3ASf6gb4Mu8x82n7ITzsaASuQtWqcTrLG949PviPz3IqMQ/
        SWhpTfZfLAxXRdyvosM9lhorrOV+17AzTFuUHjxIFY+SIZ251Qes493QGzuOcVdHBAcDKXPQADMsv
        ZI2hvQoDoT+VwEMEZWPkL56Z+WSChE36O2rKHrCPv9GxHnIU4h2/g0VV8FfgIw752p/bfVNAkdDZd
        CM1/P9S3A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fW5gE-0001GU-PZ; Thu, 21 Jun 2018 19:55:44 +0000
Received: by worktop (Postfix, from userid 1000)
        id EF9BE6E093E; Thu, 21 Jun 2018 21:55:40 +0200 (CEST)
Date:   Thu, 21 Jun 2018 21:55:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Alan Cox <alan@linux.intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [RFC PATCH 04/16] x86/split_lock: Use non locked bit set
 instruction in set_cpu_cap
Message-ID: <20180621195540.GC13636@worktop.programming.kicks-ass.net>
References: <1527435965-202085-1-git-send-email-fenghua.yu@intel.com>
 <1527435965-202085-5-git-send-email-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527435965-202085-5-git-send-email-fenghua.yu@intel.com>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 27, 2018 at 08:45:53AM -0700, Fenghua Yu wrote:
> set_bit() called by set_cpu_cap() is a locked bit set instruction for
> atomic operation.
> 
> Since the c->x86_capability can span two cache lines depending on kernel
> configuration and building evnironment, the locked bit set instruction may
> cause #AC exception when #AC exception for split lock is enabled.

That doesn't make sense. Sure the bitmap may be longer, but depending on
if the argument is an immediate or not we either use a byte instruction
(which can never cross a cacheline boundary) or a 'word' aligned BTS.
And the bitmap really _should_ be 'unsigned long' aligned.

If it is not aligned, fix that too.

/me looks at cpuinfo_x86 and finds x86_capability is in fact a __u32
array.. see that's broken and needs fixing first.
