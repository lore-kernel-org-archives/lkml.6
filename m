Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E6FC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 19:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BB4C206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 19:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Zf/+S/Sc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BB4C206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbeKGFS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 00:18:28 -0500
Received: from merlin.infradead.org ([205.233.59.134]:42880 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbeKGFS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 00:18:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Q57uU5u68BspbuBOA5NjT88EWpisTycpj6GL6HXmAcE=; b=Zf/+S/Sc33Qg5t/hangXG71ld
        BXXHAT7DLJGgHo8WPrChRDCcwokhue1xGN9j7nRcZwWURMdiu0+0qW1ywAYN9NF48uZFGfEFX33HQ
        lC4XvqFIItLdGqoZ8gIVSCjrgk6ci+CudCCzc7rT41MES8T5fZr7zVIHxMsl40+Bs+sHdkkZ5NOqL
        usjT2tHSt9sVR8oeO37XAgQlBb02FVxD2JtQv2z+yTH/oopM38kDVJCfEJSYqxoE1yA9U3W8UNfI0
        8y4rXcehmL3gvdz3XIQOZ/MxIJpPPkk0lgZ7X63/3+WAgHmrPd+xFTHBGS9HCkFlUYXjHjgOoU5Pq
        8M5BcSzAg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gK7No-0001oi-OJ; Tue, 06 Nov 2018 19:51:29 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 544962029F883; Tue,  6 Nov 2018 20:51:27 +0100 (CET)
Date:   Tue, 6 Nov 2018 20:51:27 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Doug Smythies <dsmythies@telus.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC/RFT][PATCH v3] cpuidle: New timer events oriented governor
 for tickless systems
Message-ID: <20181106195127.GD9781@hirez.programming.kicks-ass.net>
References: <1556808.yKVbhZSazi@aspire.rjw.lan>
 <20181106170442.GC9781@hirez.programming.kicks-ass.net>
 <CAJZ5v0hmm2UWRt1j6hQo14nZLgPrE3DZkOznfo2kMxsZ1spo-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hmm2UWRt1j6hQo14nZLgPrE3DZkOznfo2kMxsZ1spo-Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 07:19:24PM +0100, Rafael J. Wysocki wrote:
> On Tue, Nov 6, 2018 at 6:04 PM Peter Zijlstra <peterz@infradead.org> wrote:

> > Instead of this detector; why haven't you used the code from
> > kernel/irq/timings.c ?
> 
> Because it doesn't help much AFAICS.
> 
> Wakeups need not be interrupts in particular 

You're alluding to the MWAIT wakeup through the MONITOR address ?

> and interrupt patterns that show up when the CPU is busy may not be
> relevant for when it is idle.

I think that is not always true; consider things like the periodic
interrupt from frame rendering or audio; if there is nothing more going
on in the system than say playing your favourite tune, it gets the
'need more data soon' interrupt from the audio card, wakes up, does a little
mp3/flac/ogg/whatever decode to fill up the buffer and goes back to
sleep. Same for video playback I assume, the vsync interrupt for buffer
flips is fairly predictable.

The interrupt predictor we have in kernel/irq/timings.c should be very
accurate in predicting those interrupts.


