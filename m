Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98034C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 18:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F72020844
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 18:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jtrwReKQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F72020844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730460AbeIFXI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 19:08:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45108 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727640AbeIFXI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 19:08:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=EaTQRWH92bKkiyrNh9+noUJ6tLv7LImLaL95HpCzMPw=; b=jtrwReKQniX2UadwV3/dwisazu
        CioeYKnXos3NJEJu7xhow+B897MCwX46oXeXqzJ+21vScFYhCLRF5/lHpFZLRdzab5/Fznc1ScNFk
        0XzD1ZuAjKQF9LVJYqn2XrLKtkoV8CejHrauNj8u4BFSMvJ6xKaaOtc4/LLv70qQ6v7dhyt2VvyBZ
        lK9Sa1e50SFxF1WPZs5FvOvYuBttOv9K9NOoS9q7FEAXDZPZgy9UlToGB3+G765njq508Ho8eN5Ge
        uuhAdobIMt/XWI+f+l3ww1WN0kYQ86XXeNuYE2IEHVTEKbB2o4oogRwEctyv151yOgWprOmYG6L68
        CrII+zxQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fxz4W-0007cM-WC; Thu, 06 Sep 2018 18:32:05 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D7DDA2018BF7D; Thu,  6 Sep 2018 20:31:57 +0200 (CEST)
Date:   Thu, 6 Sep 2018 20:31:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Nadav Amit <namit@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Andy Lutomirski <luto@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2 0/6] x86/alternatives: text_poke() fixes
Message-ID: <20180906183157.GK24106@hirez.programming.kicks-ass.net>
References: <20180902173224.30606-1-namit@vmware.com>
 <20180905185617.GC24082@hirez.programming.kicks-ass.net>
 <8D3CE999-6D3A-4984-934A-634BDD8AC25A@vmware.com>
 <6B256AB7-0158-47DF-B2D5-4C835579F3A3@vmware.com>
 <20180906081300.GF24082@hirez.programming.kicks-ass.net>
 <20180906101641.GG24142@hirez.programming.kicks-ass.net>
 <6703CD9F-2D84-4449-A423-A4DC24677673@vmware.com>
 <20180906171754.GJ24106@hirez.programming.kicks-ass.net>
 <9AF220A3-D783-442E-8E5B-AD0150628347@vmware.com>
 <32902EEE-FF64-4C12-A043-1848CC927C88@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <32902EEE-FF64-4C12-A043-1848CC927C88@amacapital.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 11:09:23AM -0700, Andy Lutomirski wrote:
> > On Sep 6, 2018, at 10:58 AM, Nadav Amit <namit@vmware.com> wrote:
> > It depends what security you want. Some may consider even the short
> > time-window in which the kernel code is writable from other cores as
> > insufficient for security.
> > 
> > In addition, the set removes the need for remote TLB shootdowns that
> > text_poke() - with this fix - requires.
> > 
> 
> I’m personally in favor of not needing a global broadcast flush to install kprobes.

That's fine. But at that point its an optimization, not a correctness
issue.
