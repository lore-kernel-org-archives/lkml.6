Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36755C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E36722083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="O/6BrMj9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E36722083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756498AbeFSIIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 04:08:46 -0400
Received: from merlin.infradead.org ([205.233.59.134]:59902 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756448AbeFSIIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 04:08:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yzuCCPw5tAkt3dW+ZM3YxgiO0gREicFwTILWVl3cMtg=; b=O/6BrMj9C15aeI0XeFD4LAe65
        qkoYb1MN2OPtNVc6xSFA7EcVH3tLIWf9u4dvQdVMD/f/JHaC3G6zVBFgn8WMQoE2GqoZaqB/UfBrt
        F1DUGGksABWRIT4uhsb5a3Tv+mxdhQttUx39ea4ONUUpCte+7hVDl2O5k6BTqOEKR5yr8RrfrGFF/
        v/tVVuBXIv2PoDHPZqunGv0aJmYL3CGYx/3bYeFS8rxCvlS/CDtASoBORQCVkPnEzHPS4E/EVI1+W
        K9UMAW9X+HeoZdsR6aJpL3w0JZDgtKygFsQaQp1NywspmLaCz1EfFGvKwwB6J5Jkw40M2WsQDSvkg
        k7ESfZmZg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fVBgl-0005aT-LF; Tue, 19 Jun 2018 08:08:31 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 15D8D2029FA0B; Tue, 19 Jun 2018 10:08:30 +0200 (CEST)
Date:   Tue, 19 Jun 2018 10:08:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC][PATCH 0/6] Use printk_safe context for TTY and UART port
 locks
Message-ID: <20180619080830.GD2476@hirez.programming.kicks-ass.net>
References: <20180615093919.559-1-sergey.senozhatsky@gmail.com>
 <20180618143818.50b2f2f9@alans-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180618143818.50b2f2f9@alans-desktop>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 02:38:18PM +0100, Alan Cox wrote:
> Given printk nowdays is already somewhat unreliable with all the perf
> related changes,

printk is a steaming pile of @#$#@, unreliable doesn't even begin to
cover it.

> and we have other good debug tools

What other good debug tools do you have? The only thing I have that
actually works is earlyser/8250_early -- and I route everything printk
into that.
