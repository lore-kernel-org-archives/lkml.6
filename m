Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 401E1C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 09:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE16320664
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 09:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V48fmEF+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE16320664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbeKZUYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 15:24:30 -0500
Received: from merlin.infradead.org ([205.233.59.134]:57514 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbeKZUYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 15:24:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=y1C+U3er+UTlKWMSDrMoXJRVyFZ2s3zavNVn7l21m0s=; b=V48fmEF+h1ktF+ZVDbb/JgJ1k
        npJa4Rwh3YyICk9O6afzD2C7SGzdDQa1oCYETRdTt7VvfQD5xDv5Sy0m+vqkrzIBL4SIIkXI64V6Z
        kS4tpH8UZ7j7gPF1wJWCAubfWcX8dH4DYxQpLPcsmp+kXKOjDeN8OHKWHbXlr/PPREQ8UHAQv2f4b
        AggJbrNEIZK6N54vrQisSf5CEAgrKLZGIhkOaJpW8h18cIMozRFcEKs2jQDTaAATx/kA6jIZpWZK6
        UaEemmDn0mbZsw9saZiPao1DTzpFhb84Vp7LsEDP4I6ydqiTXWfaetGQXbPOpM4o6LPkIdrFjwdFu
        bOtqPzSsw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gRDEE-00069R-UF; Mon, 26 Nov 2018 09:30:55 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 837D62029FD58; Mon, 26 Nov 2018 10:30:51 +0100 (CET)
Date:   Mon, 26 Nov 2018 10:30:51 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [Question] atomic_fetch_andnot() in nohz_idle_balance()
Message-ID: <20181126093051.GV2131@hirez.programming.kicks-ass.net>
References: <20181121223453.GA4016@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181121223453.GA4016@andrea>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 11:34:53PM +0100, Andrea Parri wrote:
> Hi,
> 
> The comment for the atomic_fetch_andnot() in nohz_idle_balance() says:
> 
>   "barrier, pairs with nohz_balance_enter_idle(), ensures ..."
> 
> which, well, does sound a note of warning... ;-)
> 
> I see that nohz_balance_enter_idle() has an smp_mb__after_atomic() but
> the comment for the latter suggests that this barrier is pairing with
> the smp_mb() in _nohz_idle_balance().
> 
> So, what is the intended pairing barrier for the atomic_fetch_andnot()?
> what (which memory accesses) do you want "to order" here?

I can't seem to make sense of that comment either; the best I can come
up with is that it would order the prior NOHZ_KICK_MASK load vs us then
changing it.

But that would order against kick_ilb(), not enter_idle.

Vincent?
