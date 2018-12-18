Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A4AC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C86A217D8
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qM+T0J4p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbeLRKs0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 05:48:26 -0500
Received: from merlin.infradead.org ([205.233.59.134]:36428 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbeLRKsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 05:48:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EMcmWvwcB5sS6oAoVht9CmCG7i+vKHiJrI4i5GmHuVQ=; b=qM+T0J4pTCyWKjhlQoarTl6fx
        Zv/RrVZz+BGMP7VU+18syzA1LMySuyr+L1zHGvn2QglLp6/yRCZqNbZrRIvKh89ti6ClFo5hbRz8+
        z/PW0zDXPQQ6roi3xw9S0TC2VVB+NBWkKKWKQsJb2K7DudXVe3XZnbxW2nvX2wrXnmN37YI+xySWr
        JBQ+JiWnOdFmJ5Rwne1MqDDTbQwnqFwVO9jocNTJcucapVgVVXmZPLPzDUJ1x0flDBo0TuE+h2ObY
        E0UaqQpgg1dvCzhD8/92A6s9DWNYu2Rlc1VQ5bxuiQuScEORcdbxGVNDG2eMY/HFueegUbKBwBEUP
        CFnZrMTSQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gZCv8-0007Tl-TO; Tue, 18 Dec 2018 10:48:15 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 855862027E1A4; Tue, 18 Dec 2018 11:48:12 +0100 (CET)
Date:   Tue, 18 Dec 2018 11:48:12 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC][PATCH] printk: increase devkmsg write() ratelimit
Message-ID: <20181218104812.GC15430@hirez.programming.kicks-ass.net>
References: <20181218091842.4996-1-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218091842.4996-1-sergey.senozhatsky@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 06:18:42PM +0900, Sergey Senozhatsky wrote:
> 	Hello,
> 	
> 	RFC
> 
> A painful subject:
> 
> I just noticed that stock systemd (no systemd debugging enabled) on my
> x86 box write()-s during shutdown to devkmsg more than before, so old
> devkmsg ratelimits do not apply:
> 
> $ sudo journalctl -n 40000 -f | grep "kernel: printk: systemd-shutdow"
>  kernel: printk: systemd-shutdow: 35 output lines suppressed due to ratelimiting
>  kernel: printk: systemd-shutdow: 31 output lines suppressed due to ratelimiting
>  kernel: printk: systemd-shutdow: 35 output lines suppressed due to ratelimiting
>  kernel: printk: systemd-shutdow: 36 output lines suppressed due to ratelimiting
>  kernel: printk: systemd-shutdow: 36 output lines suppressed due to ratelimiting
>  kernel: printk: systemd-shutdow: 36 output lines suppressed due to ratelimiting
>  kernel: printk: systemd-shutdow: 36 output lines suppressed due to ratelimiting
>  kernel: printk: systemd-shutdow: 35 output lines suppressed due to ratelimiting
> 
> I know that there is a "kernel.printk_devkmsg" interface; do we
> expect every systemd-enabled distro to find that out and to tweak
> kernel.printk_devkmsg or shall we change the default devkmsg
> ratelimit instead?

How about we complain to systemd instead?
