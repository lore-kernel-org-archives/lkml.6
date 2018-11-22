Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38AA5C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA3B520684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NVJ1M0TJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA3B520684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394095AbeKVUzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 15:55:04 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40062 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388046AbeKVUzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 15:55:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CB0Z3YxfBno1i6LPZPpdqntOM8Qu8aw1Tp/eAS31r4M=; b=NVJ1M0TJ00qxlk2VRD35w8ebL
        zhCDlUn8qszCKlzoB9QHP+Xxml4lG2SdL4Sg1L4LFkL5tJzgjpPTBe8+2q7HzzMWt9vajbTiwH+iG
        WusomwSeirnFxUggiG6t/3JnIupGEVfcQz8Ih8rvvcuusGfl0yDVhJK5hRBIVjkhgtwzZhN3GZDE8
        +a45ijwsRYsVmCzcr6XRgYODFldil72gv1JiAX/rghUX9VuMditr0ulypB/w3e8Dt8n/3FD/Oj1x1
        ZIJysbR7mVvqJ93U8R0FI7JbwE3kqBJH7uuw0ALiud8FJyY1puASRc9y8GWULiRi4L5IT4bQXJa3i
        7Jab6dfSw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gPm1q-000174-RX; Thu, 22 Nov 2018 10:16:11 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 10E2B2029FD58; Thu, 22 Nov 2018 11:16:06 +0100 (CET)
Date:   Thu, 22 Nov 2018 11:16:06 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 07/17] debugobjects: Move printk out of db lock
 critical sections
Message-ID: <20181122101606.GP2131@hirez.programming.kicks-ass.net>
References: <1542653726-5655-1-git-send-email-longman@redhat.com>
 <1542653726-5655-8-git-send-email-longman@redhat.com>
 <2ddd9e3d-951e-1892-c941-54be80f7e6aa@redhat.com>
 <20181122020422.GA3441@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122020422.GA3441@jagdpanzerIV>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 11:04:22AM +0900, Sergey Senozhatsky wrote:
> Some serial consoles call mod_timer(). So what we could have with the
> debug objects enabled was
> 
> 	mod_timer()
> 	 lock_timer_base()
> 	  debug_activate()
> 	   printk()
> 	    call_console_drivers()
> 	     foo_console()
> 	      mod_timer()
> 	       lock_timer_base()       << deadlock
> 
> That's one possible scenario. The other one can involve console's
> IRQ handler, uart port spinlock, mod_timer, debug objects, printk,
> and an eventual deadlock on the uart port spinlock. This one can
> be mitigated with printk_safe. But mod_timer() deadlock will require
> a different fix.
> 
> So maybe we need to switch debug objects print-outs to _always_
> printk_deferred(). Debug objects can be used in code which cannot
> do direct printk() - timekeeping is just one example.

No, printk_deferred() is a disease, it needs to be eradicated, not
spread around.
