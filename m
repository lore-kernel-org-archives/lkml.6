Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48346C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 12:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF9FB20881
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 12:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YbrprRvQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF9FB20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbeJPUIQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 16:08:16 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55012 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbeJPUIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 16:08:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lkv7F9s3yd7+Qk29xEzWEIVuX+bu8QpDsmIzDEjojUI=; b=YbrprRvQhICGlYOLnwiYpZyPc
        1pw2paX0Io75uVQfJ3FSE6ngBHm+/RXf2BioOS3W5sONYpwMJALS7pzYpRGhXDphfUhQ+F00R8OyX
        sSxvUHpTZy3YOA7mt8v79Mhe/vL6RY94YAd6UiOHLWd4zdwd6bAnAj548U7eZkEewnxUb7jGKtHRt
        9aD/D0D2b9jrpE0BQGVBw1SZLlLl27pZABUmwUZ8PaS4wwCp90obSkxTuedyRrlZh8Kg/2qUWythB
        aSLu+mMsOnu8KXTW0sFc/FYopSZ2XEk/JlpgvTsttXBKSQqmU2ECoD+aZAXC01uXisq+FWZwcVbpX
        oy+229+uA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gCOIL-0001e2-N7; Tue, 16 Oct 2018 12:17:54 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2A49020297B7B; Tue, 16 Oct 2018 14:17:52 +0200 (CEST)
Date:   Tue, 16 Oct 2018 14:17:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Daniel Wang <wonderfly@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Feiner <pfeiner@google.com>,
        linux-serial@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC][PATCHv2 2/4] printk: move printk_safe macros to printk
 header
Message-ID: <20181016121752.GA2537@hirez.programming.kicks-ass.net>
References: <20181016050428.17966-1-sergey.senozhatsky@gmail.com>
 <20181016050428.17966-3-sergey.senozhatsky@gmail.com>
 <20181016072719.GB4030@hirez.programming.kicks-ass.net>
 <20181016114006.6q5atyaitapcwbud@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016114006.6q5atyaitapcwbud@pathway.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 01:40:06PM +0200, Petr Mladek wrote:
> On Tue 2018-10-16 09:27:19, Peter Zijlstra wrote:

> > Instead of this tinkering around the edges, why don't you make the main
> > logbuf a lockless ringbuffer and then delegate the actual printing of
> > that buffer to a kthread, except for earlycon, which can do synchronous
> > output.
> 
> In fact, there is no problem with printk log buffer. This patchset
> tries to avoid deadlock caused by console-specific locks
> used by console->write() methods.
> 
> By other words, we neither need printk_safe or lockless log buffer
> to fix this prolem. Instead, we need either printk_deferred context
> or lockless consoles.

If you have a lockless buffer and a trailing printk thread, that's
deferred.

And earlycon _should_ be lockless (yes, I know, some suck)

But if you do this deferred nonsense that's currently in printk, then
you risk never seeing the message -- the same problem I have with the
whole printk_safe thing too.

Printing _after_ the fact is horrible for robustness.
