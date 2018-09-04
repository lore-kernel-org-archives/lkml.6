Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE28C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 18:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA7822073D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 18:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kMqj5m8f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA7822073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbeIDXQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 19:16:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54916 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbeIDXQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 19:16:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hp2f7rcJl3YqNDwtPzECXr4tykaphJmHZCEtnOugVyo=; b=kMqj5m8faLsmfAr4DyoL/Bf9a
        uP2LhKnGJ37NPPnkYmHDJMglIjZrF8FUWgWMbAaYtqEkFt51zfD9eCuJsXwcfT4cKI2rstwDPd+jJ
        sxyzYzprdvQnV8qsQgAuWueuXcGZe0X/9/7VWt6KhnPQR36VAdZJr4yQ3d/x96ctA5mjLzL8QxFf3
        d04VkXYX/7JACgKowlR6Rtfie2MUhlppERZOsz4tt0PpzDfQtxwkxkVRIo9bgzKRiS46kSSRTLtOs
        fkMn4diQrFWJjjnK30R8z4v8tMNJ0qJqIypa0bZoHdrJ4ytfPvETa2wreMJ+p89D3HbmxbIfKL0jT
        k+8sHBOeQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fxGOp-0006c1-8E; Tue, 04 Sep 2018 18:50:03 +0000
Date:   Tue, 4 Sep 2018 11:50:02 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Anup Patel <anup@brainfault.org>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Atish Patra <atish.patra@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/5] RISC-V: Make IPI triggering flexible
Message-ID: <20180904185001.GA25119@infradead.org>
References: <20180904124514.6290-1-anup@brainfault.org>
 <20180904124514.6290-2-anup@brainfault.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180904124514.6290-2-anup@brainfault.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2018 at 06:15:10PM +0530, Anup Patel wrote:
> The mechanism to trigger IPI is generally part of interrupt-controller
> driver for various architectures. On RISC-V, we have an option to trigger
> IPI using SBI or SOC vendor can implement RISC-V CPU where IPI will be
> triggered using SOC interrupt-controller (e.g. custom PLIC).

Which is exactly what we want to avoid, and should not make it easy.

The last thing we need is non-standard whacky IPI mechanisms, and
that is why we habe SBI calls for it.  I think we should simply
stat that if an RISC-V cpu design bypasse the SBI for no good reason
we'll simply not support it.

So NAK for this patch.
