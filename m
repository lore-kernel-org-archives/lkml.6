Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.9 required=3.0 tests=BODY_8BITS,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04AB4C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 07:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA3F42083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 07:23:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M3iu43Ew"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA3F42083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756206AbeFSHXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 03:23:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44392 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755463AbeFSHXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 03:23:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=r82M0Nf+k4GMGFrElp0fUqvdbG8NbsQ0Xreisy+okG8=; b=M3iu43EwsnprKFN8+FnkQ3C/WV
        m4fwc6y37UrkZ4zD2jnM62LeOfYowtJ/mTrc3dScgmwLIJPwqKefw5z9r+pe7LKe39620ynspuqSy
        yVlHZywGRFeAqnyHJEZB4IL12Pmi4sUSRzlIWsQ/567bt8SYAYl5/qFrgh8SU13LYMcHPKc+jM+sd
        nIYM8OK+tYwIJkDRQD7lcurUwxpvXs1KbbrWb291ohsYYk6irwqEEnHwA4oB9UoRh8KLz08/oL+Mn
        Bo9G64DcErszTs7iu8lViuFa8/Z9Lfmd3LtuBCNsXm6ws5X9eGdMw4klY5GniZ6pTyCEPtXmw0XKm
        znufAlWQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fVAyT-000518-94; Tue, 19 Jun 2018 07:22:45 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D2AE120268507; Tue, 19 Jun 2018 09:22:42 +0200 (CEST)
Date:   Tue, 19 Jun 2018 09:22:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     =?utf-8?B?6ZmI5Y2O5omN?= <chenhc@lemote.com>
Cc:     Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@mips.com>,
        linux-mips <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        wuzhangjin <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>,
        stable <stable@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        AndreaParri <andrea.parri@amarulasolutions.com>,
        Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MIPS: implement smp_cond_load_acquire() for Loongson-3
Message-ID: <20180619072242.GC2494@hirez.programming.kicks-ass.net>
References: <1529042858-9483-1-git-send-email-chenhc@lemote.com>
 <20180618185141.yvkrsbdi2gbxjxj7@pburton-laptop>
 <tencent_59DC823168EC2F5D42AE44F0@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_59DC823168EC2F5D42AE44F0@qq.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 02:40:14PM +0800, 陈华才 wrote:
> Hi, Paul,
> 
> First of all, could you please check why linux-mips reject e-mails
> from lemote.com? Of course I can send e-mails by gmail, but my gmail
> can't receive e-mails from linux-mips since March, 2018.

Could you please learn to use email? No top posting and wrap lines at 78
chars.

> I have already read Documentation/memory-barriers.txt, but I don't
> think we should define a smp_read_barrier_depends() for Loongson-3.
> Because Loongson-3's behavior isn't like Alpha, and in syntax, this is
> not a data-dependent issue.

Agreed, this is not a data-dependency issue.

> There is no document about Loongson-3's SFB. In my opinion, SFB looks
> like the L0 cache but sometimes it is out of cache-coherent machanism
> (L1 cache's cross-core coherency is maintained by hardware, but not
> always true for SFB). smp_mb() is needed for smp_cond_load_acquire(),
> but not every READ_ONCE().

Linux does _NOT_ support non-coherent SMP. If your system is not fully
coherent, you're out of luck.

But please, explain in excruciating detail what exactly you need that
smp_mb for. If, like I posited in my previous email, it is to ensure
remote store buffer flushes, then your machine is terminally broken.
