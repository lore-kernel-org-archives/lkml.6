Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5414ECE560
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8521121471
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kTS3YjIA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8521121471
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729587AbeIRSdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 14:33:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33844 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbeIRSdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 14:33:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+WS/wrqU/zCp7qOOa37J/9jKkMTW3g6Jn9uAdCqpAH8=; b=kTS3YjIAfu2LOlQuyKLl0FnYU
        kOmdRkKIBn58Yvb3xOGR/VC64BDbZrENTCXfXArt6E0txIOp+zg/0NX8+kSpzjSvGP1MnkgCdyM72
        C1JE/M/yfuG5DhgwZST/xeuxUlY+nB7NOhd8RyDlaxJWtngQiSctZMM92qUSpzA/0ESgRXFJ8kzLT
        m+05H7GaYPABZGotR1IPM3glOmUtdc31sKyoJgeJJy8Psyq60NGRfSVPZQ0pGTvM5TaOYxlVEizYy
        VftbOyMNddqEZghCQ4WfSqZaqVWg1e5hsYc7yiLbHWaG0LnVbhnKP+u5+pGW1mzCmk6RL/lRKkuNz
        8zwfjMxzg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g2Fcj-00028O-R0; Tue, 18 Sep 2018 13:01:01 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6404B202C1A32; Tue, 18 Sep 2018 15:00:58 +0200 (CEST)
Date:   Tue, 18 Sep 2018 15:00:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Zhenzhong Duan <zhenzhong.duan@oracle.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        konrad.wilk@oracle.com, x86@kernel.org, dwmw@amazon.co.uk,
        tglx@linutronix.de, Srinivas REDDY Eeda <srinivas.eeda@oracle.com>,
        bp@suse.de, hpa@zytor.com, dhaval.giani@oracle.com
Subject: Re: [PATCH] x86/speculation: Use AMD specific retpoline for inline
 asm on AMD
Message-ID: <20180918130058.GM24106@hirez.programming.kicks-ass.net>
References: <87411705-893f-46d3-b899-b09ed9fa8d1b@default>
 <20180918095015.GE19234@hirez.programming.kicks-ass.net>
 <3fcc1453-1618-9a79-71c9-5eede0023775@oracle.com>
 <20180918105939.GK24106@hirez.programming.kicks-ass.net>
 <1c6ca05f-094e-03e9-b21a-866aaf80cebb@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c6ca05f-094e-03e9-b21a-866aaf80cebb@oracle.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 08:04:44PM +0800, Zhenzhong Duan wrote:
> On 2018/9/18 18:59, Peter Zijlstra wrote:
> > On Tue, Sep 18, 2018 at 06:31:07PM +0800, Zhenzhong Duan wrote:
> > > On 2018/9/18 17:50, Peter Zijlstra wrote:
> > > > On Mon, Sep 17, 2018 at 10:17:30PM -0700, Zhenzhong Duan wrote:
> > > > > -#elif defined(CONFIG_X86_32) && defined(CONFIG_RETPOLINE)
> > > > > +#elif defined(CONFIG_RETPOLINE)
> > > > 
> > > > This doesn't make any sense..
> > > This change is used for x86_64 to have minimal Retpoline support when
> > > CONFIG_RETPOLINE is defined but RETPOLINE isn't defined, or I missed
> > > something?
> > 
> > No it doesn't.
> > 
> > #if defined(X86_64) && defined(RETPOLINE)
> > 
> >   /* x86_64 retpoline goes here */
> > 
> > #elif defined(RETPOLINE)
> > 
> >   /* !x86_64 retpoline goes here */
> > 
> > #else
> > 
> >   /* !retpoline goes here
> > 
> > #endif
> 
> Sorry, but I am confused.
> So where is 'if defined(x86_64) && !defined(RETPOLINE) &&
> defined(CONFIG_RETPOLINE)' go?

Argh, CONFIG_RETPOLINE vs RETPOLINE :/

The thing is, the one you modify has a comment on that explains why it
is i386 only. CET and retpolines don't like one another much.

And the x86_64 version uses %V which requires new GCC.

So I'm all for fixing the RETPOLINE_AMD thing, but at this point nobody
should use the minimal stuff, that's just delusional.

> In original code, it will go to "call *%[thunk_target]\n" while
> we have set SPECTRE_V2_RETPOLINE_MINIMAL or
> SPECTRE_V2_RETPOLINE_MINIMAL_AMD. Is this expected?

Yes, that is exactly right -- it does that with or without your change
though.


