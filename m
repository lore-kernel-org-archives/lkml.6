Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DFBBC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 08:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A01F20989
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 08:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TdGxaNuK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A01F20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729640AbeK0Tnc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 14:43:32 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47268 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728882AbeK0Tnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 14:43:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=iuLp4s6y6rj8RCZL9CaZJBkgCZjGAysoZ45iIheC+Z0=; b=TdGxaNuKop2qu8Ua35NAS4gEh
        Gpex6VwWKUeSOKRNR3Dbclxd8stoID24o4aVB/V8MIukvjjEHmaspDSsqz0A21qg0Asb5J/omyxFU
        5Gajr7lhiETIJI9uFX6WFNZBtLnr0spCpTEtwdOaP/ezhyNWlL1mWWQwK+le2WjLT9Ntmt0JzaDIH
        5IcBGTr1o8ARWY+9PJnKKJtyxLICAF7ljlmJFXgLl47GL9DIrln6K+vitSErMQhAecOMxs2IAQDls
        PupXfTU4r+u/gwzSMyuy2O1QX6MNUNsnlbTu5crib9ycfN3bA4mjcNFGi9qZz7ibIWpR9fVsVK1IQ
        ydl4EsyRg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gRZ0W-0007qP-P4; Tue, 27 Nov 2018 08:46:13 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 792EE2029FD58; Tue, 27 Nov 2018 09:46:05 +0100 (CET)
Date:   Tue, 27 Nov 2018 09:46:05 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>, julia@ni.com, jeyu@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 4/4] x86/static_call: Add inline static call
 implementation for x86-64
Message-ID: <20181127084605.GY2113@hirez.programming.kicks-ass.net>
References: <cover.1543200841.git.jpoimboe@redhat.com>
 <62188c62f6dda49ca2e20629ee8e5a62a6c0b500.1543200841.git.jpoimboe@redhat.com>
 <20181126160217.GR2113@hirez.programming.kicks-ass.net>
 <20181126171036.chcbmb35ygpxziub@treble>
 <CALCETrX+FP4V+SoMEwX2-WeSmr2g2xZvGbS5qthuO6N6dXE+bQ@mail.gmail.com>
 <20181126201449.xepvj3owldkrsvgr@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126201449.xepvj3owldkrsvgr@treble>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 02:14:49PM -0600, Josh Poimboeuf wrote:
> On Mon, Nov 26, 2018 at 10:28:08AM -0800, Andy Lutomirski wrote:

> > Can you add a comment that it will need updating when kernel CET is added?
> 
> Will do, though I get the feeling there's a lot of other (existing) code
> that will also need to change for kernel CET.

Yeah, function graph tracer and kretprobes at the very least. But I
suspect there's a few surprises to be hand once they try kernel CET.

