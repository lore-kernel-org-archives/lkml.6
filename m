Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 898ADC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38787245E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EEnMfZVK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38787245E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934406AbeFVQjX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 12:39:23 -0400
Received: from merlin.infradead.org ([205.233.59.134]:51902 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934264AbeFVQjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 12:39:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bmdOilb0zldvRv5xIXH9lF9Aoe4+v0KAieOz990pxRM=; b=EEnMfZVK8YdtiOJWAfdVJnx71
        U8Ir37JktyllZfQAD4HVgrpr0NloskXj9prw4BFk837NfuWVmHFJHC98HqZ5mLpdLUtAlQZC0m1pP
        C4t/CyrYOLXQ9B3OAYkLGizkLHf8/KcQGQSftkbrQAfDl0MT05tFm6D3uCecS/LjYRXHNlKeDkR97
        cv3BqmvCXt4lfmoC6UzazeYbPH+lqNDqu4wbuKkunH/unX8jtQzgL6hFkGm/QEnj48icrd9U9eSXI
        YLJogSZ5BvcnzWht4Az2rgV6ok8vAKF04rnETc3RLdbij1EOgI6hG15XdFXgXWouNFjBIA4avw5ii
        X2ohaHeIQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fWP5Z-00022Q-3W; Fri, 22 Jun 2018 16:39:09 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 21CBC2029F1D9; Fri, 22 Jun 2018 18:39:04 +0200 (CEST)
Date:   Fri, 22 Jun 2018 18:39:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        SergeySenozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC][PATCH 0/6] Use printk_safe context for TTY and UART port
 locks
Message-ID: <20180622163904.GP2494@hirez.programming.kicks-ass.net>
References: <20180615093919.559-1-sergey.senozhatsky@gmail.com>
 <20180618143818.50b2f2f9@alans-desktop>
 <20180619005308.GA405@jagdpanzerIV>
 <20180619083021.4avsgvcqjrpkat6s@pathway.suse.cz>
 <CA+55aFz9aGc-vGvKv_ZR2W2ZkZNSZfOHa0m_MbGH_a=x8oAW5Q@mail.gmail.com>
 <20180619223447.4369748b@vmware.local.home>
 <CA+55aFwpcbNO6FS4=O-BrsC4vMBaT3JeFG-_D9WtgmW+Dof3iA@mail.gmail.com>
 <20180622172100.2293b5e5@alans-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622172100.2293b5e5@alans-desktop>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 05:21:00PM +0100, Alan Cox wrote:
> Really that's all that you need - log the message to whichever console
> targets you can currently safely do so. If it's none well there was
> always the proposed morse code keyboard light driver 8)

Only if your keyboard still has blinky lights on.. (mine doesn't)
