Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9FE5C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC793208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PWZxMT4P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730130AbfAJUMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 15:12:23 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37068 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730100AbfAJUMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 15:12:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wbiickOP40LLH/UtEwMrQ5X8VYvNhXyQgFfwQqT2dyk=; b=PWZxMT4PLIbMhVxjo+l21VEd7
        cbyXXlnYEAfEA1K2HNTPKo+7qkSyld3AUMc3TLzlcUDetQ/B9g6HC4MCS4VwFqyhhDLfP40L7c6fV
        uDdP20Z/DtI0LgrEuQoXpiaK1BN1KqkGAKvAfkGLE18SZen4/dGLVyGhXXiVBnLlPFoe43FRQQhYy
        TcBlAyS2M/FqIAO8QBR81+mw80TleVHrcgm1NrIwlGhAC3KTyqzOSTuCBCXR3F7+/2TpJgUnIm64d
        t++gBDylqPLVvU5OiV4L/sn9uj/F5tSZG2y3DtofZq9qKIoTJcbflfPzwL8o6YXZ+Zwe7RIJcYpzv
        UCsPZKj2w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ghgge-0003Bz-1z; Thu, 10 Jan 2019 20:12:20 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id C07FF9844AF; Thu, 10 Jan 2019 21:12:17 +0100 (CET)
Date:   Thu, 10 Jan 2019 21:12:17 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     James Morse <james.morse@arm.com>
Cc:     Waiman Long <longman@redhat.com>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        SRINIVAS <srinivas.eeda@oracle.com>
Subject: Re: Question about qspinlock nest
Message-ID: <20190110201217.GH2861@worktop.programming.kicks-ass.net>
References: <e784a592-5dec-b0b3-6c70-d9ef775621d5@oracle.com>
 <910e9fb6-d0df-4711-fe2b-244b3c20eb82@redhat.com>
 <d06126a1-1db8-f937-2084-2c1234b6f56f@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d06126a1-1db8-f937-2084-2c1234b6f56f@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 06:25:57PM +0000, James Morse wrote:

> On arm64 if all the RAS and psuedo-NMI patches land, our worst-case interleaving
> jumps to at least 7. The culprit is APEI using spinlocks to protect fixmap slots.
> 
> I have an RFC to bump the number of node bits from 2 to 3, but as this is APEI
> four times, it may be preferable to make it use something other than spinlocks.
> 
> 
> The worst-case order is below. Each one masks those before it:
> 1. process context
> 2. soft-irq
> 3. hard-irq
> 4. psuedo-nmi [0]
>    - using the irqchip priorities to configure some IRQs as NMI.
> 5. SError [1]
>    - a bit like an asynchronous MCE. ACPI allows this to convey CPER records,
>      requiring an APEI call.
> 6&7. SDEI [2]
>      - a firmware triggered software interrupt, only its two of them, either of
>        which could convey CPER records.
> 8. Synchronous external abort
>    - again, similar to MCE. There are systems using this with APEI.

The thing is, everything non-maskable (NMI like) really should not be
using spinlocks at all.

I otherwise have no clue about wth APEI is, but it sounds like horrible
crap ;-)
