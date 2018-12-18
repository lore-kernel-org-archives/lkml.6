Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776CAC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 17:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44B03218A3
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 17:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cEe9Z06G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbeLRRVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 12:21:18 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53658 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbeLRRVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 12:21:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bb0X2bTtkDjmBJqyQPos1ClaHaQNdMFm7mSAo4n5hNQ=; b=cEe9Z06GjqMwwpL+3jnSurDeX
        tFV1oEIbl05ObVV4t6VQR7s/vRNSBAb/YHbaX92+l1VyfQJDsBh+ZV5N8uwM/g3BvZNNV5GiOrKaK
        tqSiyWC/qvWs4FGzYH8hoanUom2gOOTLvDVcGOIKoOcTU2H4cR1mNSe5Z1gcyOjhTP469AHDq5d5v
        MIRk3AloXhzzLAx1fPbCDDtvvM5Wd4psxcGNeCNeJsgKf5DHfbE0tamyMG7HKYmDKOc+d3MoYaaTo
        R+61OlRkBdA+iFAxSG1bGPtrUG9Ipjqr6k8LLd3RpSoFi8EFQs+9/GK+2aFZZG4ODqFdd5XFLSs4I
        fREKruwgw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gZJ3Q-00031M-76; Tue, 18 Dec 2018 17:21:12 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E844D201409D6; Tue, 18 Dec 2018 18:21:09 +0100 (CET)
Date:   Tue, 18 Dec 2018 18:21:09 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] printk: increase devkmsg write() ratelimit
Message-ID: <20181218172109.GK15430@hirez.programming.kicks-ass.net>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218165217.GA534@tigerII.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 01:52:17AM +0900, Sergey Senozhatsky wrote:
> On (12/18/18 16:24), Borislav Petkov wrote:
> > On Wed, Dec 19, 2018 at 12:14:55AM +0900, Sergey Senozhatsky wrote:
> > > Right, but unlike log_buf_len, devkmsg is a bit close to a "binary" knob:
> > > either all messages or none;
> > 
> > ... which is perfectly fine for a debugging session.
> 
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

Again, complain to system-doofus for printing so much crap to somewhere
it should not print to begin with.
