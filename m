Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F0C2C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 19:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C1A72075E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 19:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="onTUpfNh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C1A72075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729558AbeIFXsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 19:48:54 -0400
Received: from merlin.infradead.org ([205.233.59.134]:48184 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729536AbeIFXsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 19:48:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6wTmRSdEXXiquxYTRtuIgcije3CnEPAwPJlE5RvZkRs=; b=onTUpfNhtNLuyKrDz8WJyHp/j
        tx14LzojebUCbUmGuQKa9Br57cNUY3uMBkMf3vmMvaOLRP72aFKnjw3Y3APyOBps7msqJrUjpnPI+
        0wy9a1GMx5OzuKqE31Ltka9l9TrVR9EGb/YnTIRCKMTwsEdvIhWYHRVwIdHfvpJ1a5/jOpxaF6OOE
        SM00o9KrK7UIys2EnrDrO/5QzxbYwmFnud8o3FyWv0m9V0AUGdc+uz34MVeGxQTS2gdZ5O0SU4jAs
        O2O/u2Q33P2riaxGBmveuDNc+hkfJEGda66/k6xBlu3okVqTQkO527NJZUNya8niV0u37uI+tHlVz
        VK/QX67hQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fxzh1-0004U8-Bz; Thu, 06 Sep 2018 19:11:52 +0000
Received: by worktop (Postfix, from userid 1000)
        id D31146E0AA9; Thu,  6 Sep 2018 21:11:40 +0200 (CEST)
Date:   Thu, 6 Sep 2018 21:11:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>, jbaron@akamai.com,
        viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH -next 0/2] fs/epoll: loosen irq safety when possible
Message-ID: <20180906191140.GA4816@worktop.programming.kicks-ass.net>
References: <20180720172956.2883-1-dave@stgolabs.net>
 <20180720124212.7260d76d83e2b8e5e3349ea5@linux-foundation.org>
 <20180720200559.27nc7j2rrxpy5p3n@linux-r8p5>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180720200559.27nc7j2rrxpy5p3n@linux-r8p5>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 01:05:59PM -0700, Davidlohr Bueso wrote:
> On Fri, 20 Jul 2018, Andrew Morton wrote:

> >I'm surprised.  Is spin_lock_irqsave() significantly more expensive
> >than spin_lock_irq()?  Relative to all the other stuff those functions
> >are doing?  If so, how come?  Some architectural thing makes
> >local_irq_save() much more costly than local_irq_disable()?
> 
> For example, if you compare x86 native_restore_fl() to xen_restore_fl(),
> the cost of Xen is much higher.

Xen is a moot argument. IIRC the point is that POPF (as used by
*irqrestore()) is a very expensive operation because it changes all
flags and thus has very 'difficult' instruction dependencies, killing
the front end reorder and generating a giant bubble in the pipeline.

Similarly, I suppose PUSHF is an expensive instruction because it needs
all the flags 'stable' and thus needs to wait for a fair number of prior
instructions to retire before it can get on with it.

Combined the whole PUSHF + POPF is _far_ more expensive than STI + CLI,
because the latter only has dependencies on instructions that muck about
with IF -- not that many.
