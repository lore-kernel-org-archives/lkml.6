Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11133C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAFF32186A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:09:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Il00iSVp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbfBLHJf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 02:09:35 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35130 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfBLHJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 02:09:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oJ8Lf+WqyK8XHYzmCU9ASXjpWHI+Pi1oJblH35r6YpY=; b=Il00iSVppHyQ2NyM9vUUAuIbA
        omBstN6MpCPAnqSkIe2W/8G+bI38g91ktBCghpKmYU0MreZfGAgs1jfbLMnGT1/JloC9DTU5fmQgT
        9BLnJ8HGwCbV7qBRE/p583F+tVJHHKSRtsTGOIGvkqw3jCWMj5WoTG/j6XnxOZAa3XyV23QAuh1WC
        6LZ9DxOvXduef8Xwl7VbkudZKYtaX+vhNFAGbnuQaYcHL/E+m0m3qKCtP278CrhMN/lpvDPjcVeW/
        /hdRAFlFkg+EIwpIsTx8RZdB+0mYpYrQ+n86h4O28hRaTWeJ8G1zU0ajWdb+NCbpJLmXeQiOJvHW9
        e7/f/uD+A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtSC5-000168-8M; Tue, 12 Feb 2019 07:09:25 +0000
Date:   Mon, 11 Feb 2019 23:09:25 -0800
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
Subject: Re: [PATCH v5 2/5] irqchip: sifive-plic: Don't inline plic_toggle()
 and plic_irq_toggle()
Message-ID: <20190212070925.GE26747@infradead.org>
References: <20190119055625.100054-1-anup@brainfault.org>
 <20190119055625.100054-3-anup@brainfault.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190119055625.100054-3-anup@brainfault.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 19, 2019 at 11:26:22AM +0530, Anup Patel wrote:
> The plic_toggle() uses raw_spin_lock() and plic_irq_toggle has a
> for loop so both these functions are not suitable for being inline
> hence this patch removes the inline keyword.

I still very much disagree.  Very strongly with the above rationale,
but also (less strongly) with the decision not to inline here.
