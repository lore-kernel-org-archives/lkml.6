Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA191C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7D3221848
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y8ZzuVWz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731591AbfAKKC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 05:02:59 -0500
Received: from merlin.infradead.org ([205.233.59.134]:56254 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727653AbfAKKC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 05:02:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pcTMygEALRHllzFZxAMVlB56K3XYfhrHxK7e9gi5eDs=; b=Y8ZzuVWzO1AebgDhpKIBTWlOr
        fH8MlCNm2sUuAlNutbHFS+XCUWbkOUBEsGQmxmppbQBYZ3j+IVOSZiOIgbuGuuPW4nBITngLHGcVx
        dLdPkGmqcskPVAQP90N2PCCFLIvj1V/5rBvXppD1qzYplCNkpmS41zACybBQxjx6oEqSWfKLis4mQ
        h+sUoFatpVDvrDfHMiubofyD/CLlzgZuEfGALfKtfvBsM3vQOrp+7C6vvxZp4Md+GtiNOS2CF+vDo
        YiT5sCVUGahWyMz2acqlbAbPlA3RKXVoYph2EL5JRfqnMRQ1MMSVdQfhKD8RfNnUX9iKvTbJYvBVb
        q/jTSFARQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ghteQ-0008Dc-Il; Fri, 11 Jan 2019 10:02:55 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5C00F201267E1; Fri, 11 Jan 2019 11:02:53 +0100 (CET)
Date:   Fri, 11 Jan 2019 11:02:53 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Esme <esploit@protonmail.ch>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        JJiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: syzkaller found / reduced C repro for non-fatal
 unchecked MSR access error
Message-ID: <20190111100253.GO30894@hirez.programming.kicks-ass.net>
References: <z3BgwrH88cXG8bH06po3hzY6vkYpdvZWqzSGl4lLXojvzk-33tKzdK1NWsTL1Ta-CBG7GKAWYziBAfPKsGA2CV6MVkXT93Al3SUfArOnUQE=@protonmail.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <z3BgwrH88cXG8bH06po3hzY6vkYpdvZWqzSGl4lLXojvzk-33tKzdK1NWsTL1Ta-CBG7GKAWYziBAfPKsGA2CV6MVkXT93Al3SUfArOnUQE=@protonmail.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 11:21:16PM +0000, Esme wrote:
> Attached is a fairly small C repro I did not see any references to
> this possible flaw (unchecked MSR access) in relation to
> __NR_perf_event_open
> 
> Attached is the config directly extracted from proc.  This is the call
> stack in relation to the MSR access error (5.0.0-rc1+), I get a very
> similar stack running this test case on a stock Ubuntu
> "4.18.0-11-generic" (pasted after this one).

> -- Esme
> 
> [   70.228744] unchecked MSR access error: WRMSR to 0xc0010000 (tried to write 0x0000020000130076) at rIP: 0xffffffff812dde28 (native_write_msr+0x8/0x30)

That's K7_EVNTSEL0. What kind of hardware are you running this on?
