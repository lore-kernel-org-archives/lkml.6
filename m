Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F909C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4305E20645
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nWJMeO7/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731204AbfAOPym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 10:54:42 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34332 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbfAOPym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 10:54:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nPdzQygTiYTUiTtpVTyXaavvZP2udPtLlZ15E981i6A=; b=nWJMeO7/LRrLaF3dqNw3Ci1Nd
        fafdn3ooBqHoO4KG3hHqLymRo/x/Ime31wYnIOvzCM0JRofgW5QSLmX8MM3qdEsQidS+NPFRaVPyn
        Hmsz3D/luP296vq/Zf6SJ0TLaBNacTVKWyZJry5s0tYzRUXBnPcgWQYfY3naVMTGRN5d3/vb5krpU
        0JysuHnDxKpBUz5VAyH7RM+zOoOu+/bQQSuZKPccaBmzHxTHSdOne8puPpzklo29ib7GRJj/kiGY0
        l8+tQpiP1f+NQh+95Dzd2gCu8TwJ3RNvKXFOAqC05v9J6yMq7iT1c4l9C3if/GeLFIF4Uyot6e5/g
        Z/gKldMAA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gjR2z-0003YP-O4; Tue, 15 Jan 2019 15:54:37 +0000
Date:   Tue, 15 Jan 2019 07:54:37 -0800
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
Subject: Re: [PATCH v4 2/5] irqchip: sifive-plic: Don't inline plic_toggle()
 and plic_irq_toggle()
Message-ID: <20190115155437.GA13095@infradead.org>
References: <20181227111821.80908-1-anup@brainfault.org>
 <20181227111821.80908-3-anup@brainfault.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181227111821.80908-3-anup@brainfault.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 27, 2018 at 04:48:18PM +0530, Anup Patel wrote:
> The plic_toggle() uses raw_spin_lock() and plic_irq_toggle has a
> for loop so both these functions are not suitable for being inline
> hence this patch removes the inline keyword.

That is a weird argument for a function which has by design exactly
two callers and is in the hot path.  The alternative to the inline
here would be to duplicate the code.
