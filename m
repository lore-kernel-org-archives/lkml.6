Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 214DAC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E51712184A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="seDAYLaG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbfBLHLe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 02:11:34 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35662 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfBLHLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 02:11:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7UPNvdw0qsfhF/kLm16K67bEGEYfgSW+VFtNl/D3Zjo=; b=seDAYLaG8+H+t2bCCGdXFmQNM
        ZK6vc1f5h0Gs/kmGoviXzXszrX+bZld0uKtVxLJPeGtzvGwNwjziH12d/tQjvy/Y99KuTPjHzYsXp
        swQioj3SrUnfW3KyBctV5ZoGdyIyUh9N45JdKv15TBc0EW+RjPtJqpJ4ZfKLXlFBFC8QdfkfCcb6c
        tN8UQaUbFIv9TaisPZM0qHNi1g7JBfKsq28uzI4AKtbhTWNAFJg5gFg3qIhkrn4qMhJs8aCKEptwA
        d4y5007rjCT81pcCUeMeYxJvU8837O5ah5U+NBpYDQqn+X/hLnUo2XAiwGgtQhl7FwaqFfKDnobW0
        kxfF+3lvw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtSE4-0002bA-Rw; Tue, 12 Feb 2019 07:11:28 +0000
Date:   Mon, 11 Feb 2019 23:11:28 -0800
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
Subject: Re: [PATCH v5 1/5] irqchip: sifive-plic: Pre-compute context hart
 base and enable base
Message-ID: <20190212071128.GG26747@infradead.org>
References: <20190119055625.100054-1-anup@brainfault.org>
 <20190119055625.100054-2-anup@brainfault.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190119055625.100054-2-anup@brainfault.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 19, 2019 at 11:26:21AM +0530, Anup Patel wrote:
> This patch does following optimizations:
> 1. Pre-compute hart base for each context handler
> 2. Pre-compute enable base for each context handler
> 3. Have enable lock for each context handler instead
> of global plic_toggle_lock
> 
> Signed-off-by: Anup Patel <anup@brainfault.org>
> ---
>  drivers/irqchip/irq-sifive-plic.c | 47 ++++++++++++++-----------------
>  1 file changed, 21 insertions(+), 26 deletions(-)

I don't really see the point, but the code looks clean enough and
removes a few lines, so:

Reviewed-by: Christoph Hellwig <hch@lst.de>
