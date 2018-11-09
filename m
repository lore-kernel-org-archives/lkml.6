Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E18C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 08:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E93B20840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 08:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hR1sSy2l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E93B20840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbeKISWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 13:22:37 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43716 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727676AbeKISWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 13:22:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=S34i6VFy87zAWppVV7S8AeRavC19rT4dvlwLNX+KCCY=; b=hR1sSy2lphKNTSrWa5Qx2bLdB
        wwBuHjhsgTw4SrpE/jodyaVCL6i/zLxzeonl4Zqq+DurMhRz7QN9B036e3TaX4wo2C42t8Oy26bVY
        jOobP3PVzZJd0zfMh+4PMT3qFFJwlBnxJzMqlQqII4ooBw8tEFzF61apXxptUSUJkbYKpsDi+38ID
        qyDvfweQ3uWQ28o4mJeuYjjx/h9pbzUOkT/t+PMuecuRDjmZU7GUbvQZe/4SEmR5E5INz82HBDSO6
        DGKvA+mFQlXbbIOJszCNcH6p4iURgtS8K+70SaKsRHonysfAj4p1sqz/ZgHFjOZZnmFFd9vV1Vuvx
        34AghyGvg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gL2NV-0004l7-2v; Fri, 09 Nov 2018 08:42:57 +0000
Date:   Fri, 9 Nov 2018 00:42:56 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Anup Patel <anup@brainfault.org>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Atish Patra <atish.patra@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] irqchip: sifive-plic: Pre-compute context hart base
 and enable base
Message-ID: <20181109084256.GA6508@infradead.org>
References: <20181022114517.22748-1-anup@brainfault.org>
 <20181022114517.22748-2-anup@brainfault.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181022114517.22748-2-anup@brainfault.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 05:15:14PM +0530, Anup Patel wrote:
> This patch does following optimizations:
> 1. Pre-compute hart base for each context handler
> 2. Pre-compute enable base for each context handler

Why?

> 3. Have enable lock for each context handler instead
> of global plic_toggle_lock

Why?  Also even if you want this it should be a separate patch.

>  #define PRIORITY_BASE			0
> -#define     PRIORITY_PER_ID		4
> +#define PRIORITY_PER_ID			4

Also please drop the random whitespace changes.
