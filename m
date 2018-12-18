Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82346C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 17:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5308221873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 17:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="aZHPdKxR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbeLRRrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 12:47:31 -0500
Received: from mail.skyhub.de ([5.9.137.197]:41940 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726659AbeLRRra (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 12:47:30 -0500
Received: from zn.tnic (p200300EC2BD1780024767CD486D27DCB.dip0.t-ipconnect.de [IPv6:2003:ec:2bd1:7800:2476:7cd4:86d2:7dcb])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C0AF51EC0AC4;
        Tue, 18 Dec 2018 18:47:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1545155248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=J9FtZd02FqpcwI3gCnC/QIS1vF5PhX7bNJRnD+aEa20=;
        b=aZHPdKxRYCvJFhywkbzutl2ZneAkhj8mHTfaDnoDIlEt/b88qqOAqg+eEqXHOkc9SBXTBf
        n/hiMrefT5JCOceKUEoGNx3xq8HV8P605jhkcp9xtYXWNmJKMLrFcEIDT0QJYgFeUHePoW
        G5lVhQ/fEDlD3GZelESEynmVGXFFJOc=
Date:   Tue, 18 Dec 2018 18:47:23 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] printk: increase devkmsg write() ratelimit
Message-ID: <20181218174723.GK7485@zn.tnic>
References: <20181218104812.GC15430@hirez.programming.kicks-ass.net>
 <20181218111701.GA32522@jagdpanzerIV>
 <20181218114709.GF7485@zn.tnic>
 <20181218130750.GA665@tigerII.localdomain>
 <20181218142623.GH7485@zn.tnic>
 <20181218145558.GD665@tigerII.localdomain>
 <20181218150313.GI7485@zn.tnic>
 <20181218151455.GE665@tigerII.localdomain>
 <20181218152413.GJ7485@zn.tnic>
 <20181218165217.GA534@tigerII.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181218165217.GA534@tigerII.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 01:52:17AM +0900, Sergey Senozhatsky wrote:
> But devkmsg ratelimits systemd errors, so one does not even know that
> "some debugging is required". For instance from my x86 box:
> 
>  Unmounting /home...
>  [..]
>  home.mount: Mount process exited, code=exited status=32
>  Failed unmounting /home.
> 
> I don't want to debug systemd, I want to know that something didn't
> work out. 10 messages max and 5 seconds interval looks a bit too strict.

So how much is not strict?

And what happens if you raise that ratelimiting level and the *one* line
which is most important for debugging an issue, still doesn't get logged
because all of a sudden, doofus is more talkative, overflows the new
limit and we drop the important line?

All I'm saying is, gradually raising the limit is the wrong approach
- there will always be a case where something important doesn't get
logged.

What we need is a different solution, maybe what Rostedt proposes or
so...

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
