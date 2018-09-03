Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0034C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98D0E20658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k684zhJz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98D0E20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbeICSIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 14:08:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52728 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbeICSIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 14:08:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RSJ9dMuvOpV6mhRHhDgdBZefOdut6QN7XZKbtYPaL+M=; b=k684zhJzUVe99eTRGtqX9+9Um
        e4T+OZE8aPgZ2SEZ+JMxs4SD9VW9ygnqrLt6hjFSJp5RRpMpX8AS6rdY7rGkVT0RteW4656LpkuxE
        UBL4p492Jf7Vsqjv+Z06zh3MUpaHv/CGEUoelQNrvbuMPOV/jH34NAspFpaIdYScD9tkbe4X4Gr8/
        eXoZUgo99If9uXBF1OJuShy8fxotYqLPz2bnPAKialLx6tOSsc5j82LN94upKE4fzWAivPhfO0nL2
        LpOIWY3itFvHiRgeTobniUXIQvjoGPJ5h+XC57KU8btmb5w/XJ1IBMXdOX4UdBU0gzpyGvvRSKGvl
        VoTwWq9aw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fwpCr-0003Ku-8C; Mon, 03 Sep 2018 13:47:53 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 36B3E2018FA29; Mon,  3 Sep 2018 15:47:51 +0200 (CEST)
Date:   Mon, 3 Sep 2018 15:47:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH v2 2/3] x86/speculation: Apply IBPB more strictly to
 avoid cross-process spectre v2 leak
Message-ID: <20180903134751.GV24124@hirez.programming.kicks-ass.net>
References: <nycvar.YFH.7.76.1809031443540.25787@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.1809031443540.25787@cbobk.fhfr.pm>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 03, 2018 at 02:45:25PM +0200, Jiri Kosina wrote:
>  		if (tsk && tsk->mm &&
>  		    tsk->mm->context.ctx_id != last_ctx_id &&
> -		    get_dumpable(tsk->mm) != SUID_DUMP_USER)
> +		    ___ptrace_may_access(tsk, current, PTRACE_MODE_IBPB))
>  			indirect_branch_prediction_barrier();

So the question posed here is: can @next ptrace @prev?

Which confuses me greatly; it is @prev doing the BTB poisoning for
@next, so we want to know if @prev can ptrace @next, no?
