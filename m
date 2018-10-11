Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A535C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 07:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 530392085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 07:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tFIRynzC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 530392085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbeJKO5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 10:57:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49708 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbeJKO5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 10:57:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ahBK5zqI2DJ5p1osG+ETUl8gjyom6+IwguNdYgg3iCE=; b=tFIRynzCbKkBSDvIcOj2gtSRT
        W0C2Ngej2q/jlLXpTNQmvlbGXp4kvq9YADo2oSCnKy0741QtCV3dhQxDfPRV53KDU5YuBbQ8+ydov
        /1I8c423SHkXslWnenfdBOsslfiFdEIZSw8CfrrWAKhGeFLf60u332ACBHNHKLan9PGzLH7LDCsRc
        ih7clJ09E9u990I7KusYS8GDExZ7D6ZFW9LyllPUknuxgxuFiLLwdGJcLVtriPg+boBc/Do0Q5OdQ
        IZHLgp5lXSSBXpFz2OveTx/CbKAQg6kJd4yl8g4c3bISoN00NjcHzhf4kNzhDlOeHnYM9D9Kzljkw
        5Rf9sPoMQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gAVRY-0006ez-7w; Thu, 11 Oct 2018 07:31:36 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 74E6520291FCC; Thu, 11 Oct 2018 09:31:33 +0200 (CEST)
Date:   Thu, 11 Oct 2018 09:31:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Eric Dumazet <edumazet@google.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86/tsc: use real seqcount_latch in cyc2ns_read_begin()
Message-ID: <20181011073133.GZ5663@hirez.programming.kicks-ass.net>
References: <20181011003336.168941-1-edumazet@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181011003336.168941-1-edumazet@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 05:33:36PM -0700, Eric Dumazet wrote:
> While looking at native_sched_clock() disassembly I had
> the surprise to see the compiler (gcc 7.3 here) had
> optimized out the loop, meaning the code is broken.
> 
> Using the documented and approved API not only fixes the bug,
> it also makes the code more readable.
> 
> Replacing five this_cpu_read() by one this_cpu_ptr() makes
> the generated code smaller.

Does not for me, that is, the resulting asm is actually larger

You're quite right the loop went missing; no idea wth that compiler is
smoking (gcc-8.2 for me). In order to eliminate that loop it needs to
think that two consecutive loads of this_cpu_read(cyc2ns.seq.sequence)
will return the same value. But this_cpu_read() is an asm() statement,
it _should_ not assume such.

We assume that this_cpu_read() implies READ_ONCE() in a number of
locations, this really should not happen.

The reason it was written using this_cpu_read() is so that it can use
%gs: prefixed instructions and avoid ever loading that percpu offset and
doing manual address computation.

Let me prod at this with a sharp stick.
