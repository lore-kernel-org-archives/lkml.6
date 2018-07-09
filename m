Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9275C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8855A2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="heNt1XSR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8855A2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933405AbeGIPpn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:45:43 -0400
Received: from merlin.infradead.org ([205.233.59.134]:60128 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932688AbeGIPpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:45:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pPco/asdqDwIrsXvUcoo19/R9u6XdrYqoTLu2G0NKwo=; b=heNt1XSRb37SR62s+uTw1QxTy
        cBJe/m2D9Iy8KYNTkLctFwbeI/3AWDo/8v/EuFXTydPTw4SQEUGko5fu8/1tDX8zDPDC+7wHYgRcG
        tXVk+GPbuOcCCIKxbnAmC+XeRlUJgdyZEXpeXmEq/+ALiw9WMufTgzSsk9DZoUZOf/GOA1DO5k2JA
        ZdnlhEvFLiRnlTK8771gYotQ1SRC49PmKesYSu2vOdYOYPidJGxrXGyXrt1eBMJpE1cDJcITSle/k
        Yl5mvgTNYBeNv1YpfSt6QBIZwuZkrhdybGPS/gUoUUUeFettTMnr2dfD+PZdJYXpPD9jxIj7cTRg+
        f+l+bz0Ew==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fcYLq-0003SH-NM; Mon, 09 Jul 2018 15:45:23 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6A09920289CF4; Mon,  9 Jul 2018 17:45:21 +0200 (CEST)
Date:   Mon, 9 Jul 2018 17:45:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "greg@kroah.com" <greg@kroah.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "David.Laight@ACULAB.COM" <David.Laight@ACULAB.COM>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>
Subject: Re: [PATCH v3] devres: Explicitly align datai[] to 64-bit
Message-ID: <20180709154521.GS2512@hirez.programming.kicks-ass.net>
References: <20180709134550.29541-1-abrodkin@synopsys.com>
 <20180709140717.GR2476@hirez.programming.kicks-ass.net>
 <20180709141056.GR2512@hirez.programming.kicks-ass.net>
 <44727d3cebda7bee5b68fb388bd2fecfc6dc7b89.camel@synopsys.com>
 <20180709144925.GU2476@hirez.programming.kicks-ass.net>
 <20180709152958.565weccfaktqauef@lakrids.cambridge.arm.com>
 <20180709153427.GY2476@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709153427.GY2476@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 05:34:27PM +0200, Peter Zijlstra wrote:
> On Mon, Jul 09, 2018 at 04:29:58PM +0100, Mark Rutland wrote:
> > Shouldn't that be 8? AFAICT, __alignof__(unsigned long long) is 8 on
> > x86_32:
> 
> Curious, I wonder why we put that align in atomic64_32 then.

Shiny, look at this: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=54188


