Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F2D4C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 529382086C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YBlRBz1G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388977AbeLQS1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 13:27:25 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38744 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732405AbeLQS1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 13:27:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=V1AZ6Rv5gqo874NO+3M1S/MKnTRClD0a9hdXcAkawwY=; b=YBlRBz1GDphFo1v2KR7tY7GLM
        79Ix+CBeXtvOoWX/t8D72xDsVR8HE0zGBuGyGI2AnIgwugahezFvrut8Cse/Oqy+jKspTpKAwERDL
        gMNSB0Yk4CIGD+BZDZpXc3GsFa0M+vWqSUXuwU0NkrHZte5LNTHCm6nSsc73+5w/+/fHBDy5LRuPV
        aZ3AOEQ5PJV8SzshTS8gp0/1sq0xpBDTYn6AMGPjqn7TIOj7I58uR4K0Ib8tLcPSYsZCojkON50NQ
        /6pzJ2xPSlpJ9MexK/2N8OmYw+5swAyPOQiz4IMngpmZsYpJVPh8wBb8KnAOmQsV9K3Ct4WyMaApO
        NVYBlsKFQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gYxbr-0003qR-UO; Mon, 17 Dec 2018 18:27:19 +0000
Date:   Mon, 17 Dec 2018 10:27:19 -0800
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
Subject: Re: [PATCH v3 3/6] irqchip: sifive-plic: More flexible
 plic_irq_toggle()
Message-ID: <20181217182719.GC7086@infradead.org>
References: <20181130080207.20505-1-anup@brainfault.org>
 <20181130080207.20505-4-anup@brainfault.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130080207.20505-4-anup@brainfault.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -static inline void plic_toggle(struct plic_handler *handler,
> -				int hwirq, int enable)
> +static void plic_toggle(struct plic_handler *handler, int hwirq, int enable)
>  {
>  	u32 __iomem *reg = handler->enable_base + (hwirq / 32) * sizeof(u32);
>  	u32 hwirq_mask = 1 << (hwirq % 32);
> @@ -92,27 +91,27 @@ static inline void plic_toggle(struct plic_handler *handler,
>  	raw_spin_unlock(&handler->enable_lock);
>  }
>  
> -static inline void plic_irq_toggle(struct irq_data *d, int enable)
> +static void plic_irq_toggle(const struct cpumask *mask, int hwirq, int enable)

It also removes inline statements which seems rather unrelated to
the patch description.

Also the actual addintion of the single cpumask argument is simple
enough that it should probably go into the patch that makes use of it.
