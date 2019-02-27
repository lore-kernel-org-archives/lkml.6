Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50EF7C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15CC620C01
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="F+F7mpm7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729756AbfB0Re2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 12:34:28 -0500
Received: from merlin.infradead.org ([205.233.59.134]:37040 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727636AbfB0Re2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 12:34:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fH5U7HBCeIOHhM3PEx8G974tsbEs5EFbZGdA5Fo6tPI=; b=F+F7mpm7XuCNCW52RZ9F+nyNQ
        TuSxySPwS5sWNVsob1qmE8A5fbOSyRDIA1vt+SeMUp6D4oELCW6Ot6tbkkU68P8bGd9cV2SkbUQ1U
        W6hUJB6rtGo6ccwsNU9jwwWXTpPusar23kD6rGXz+gvWv4Jkd3/uM97GAwNaJRJfPjKxL+ddAIsaS
        s6CBMEBld1wjlU17GNK4jhwJ7wpKEAqmLTDakr6z76FtgcK2JmQX91GLDcEroLbsWVUX029lmEJ8Q
        1Vxh8VHKBSy/tdFlGxG3hBEHVXOx2cCuVbGNqAnDDd1g/zaJYf+T46vEC0eIXtrEUbY3L/exvp6Wf
        vSrA5w8Ag==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gz367-00060Z-II; Wed, 27 Feb 2019 17:34:23 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 574752393ABA8; Wed, 27 Feb 2019 18:34:22 +0100 (CET)
Date:   Wed, 27 Feb 2019 18:34:22 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Lutomirski <luto@kernel.org>,
        Nadav Amit <namit@vmware.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: Re: [PATCH 1/5] x86/percpu: Differentiate this_cpu_{}() and
 __this_cpu_{}()
Message-ID: <20190227173422.GV32494@hirez.programming.kicks-ass.net>
References: <20190227101252.413192716@infradead.org>
 <20190227101544.210748832@infradead.org>
 <CAHk-=wiv6dgJDj81wukpJCJBVhAVn-CYJdhj+o8JGN1LfRwb0g@mail.gmail.com>
 <20190227164806.GS32494@hirez.programming.kicks-ass.net>
 <CAHk-=wi_0GUBgi3guWqUzT3gZOAC+iEyZcSLdw0=_9xWJEwHZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi_0GUBgi3guWqUzT3gZOAC+iEyZcSLdw0=_9xWJEwHZg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 09:17:42AM -0800, Linus Torvalds wrote:
> It all seems pretty ad-hoc, and we already _know_ that "asm volatile" is bad.

Ah, all I wanted was the ONCE thing and my inline asm foo sucks. If +m
gets us that, awesome.

But the ONCE thing defeats CSE (on purpose!) so for code-gen that
likes/wants that we then have to use the __this_cpu crud.
