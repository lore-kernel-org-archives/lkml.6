Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DEAC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 06:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9C5F206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 06:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SJkqxyyY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9C5F206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbeIKLUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 07:20:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34576 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbeIKLUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 07:20:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PIWycZsHrgc/axP5ZJcu+OJR6McHLDE5Aa7wDL1J+/E=; b=SJkqxyyYRJLYFy8rFkHpyaeva
        502mURLSibL/gJ9uZrm3SrLw8Tnu310IrXybBI6uZboriM5AmlQtJHtZbG/ZI0iKI2PD+PwjdZKTn
        kVzYBYDdE09uBYpgONTkgwy8EerrdhDJP1BJ/fxZq/LQHbt+3XsnZtk3jbqypevasfWYseo5OQXkF
        Btlmsw1phRPSp4ULKpgaXRRx2E2U9Liyuf5/aJGnwGe4w9GqRHr/fVgsCyFxwkjy2pMHUjTov3H1K
        ++/lgq7RfP9XOMBCNzJBa1C3SUKxBeHM60TJItj0esMLy4/mM/lbumAMAi1bCI2wnYJvSr1N5kIEJ
        J/jeo2rtQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fzc4c-0007cr-IB; Tue, 11 Sep 2018 06:22:54 +0000
Date:   Mon, 10 Sep 2018 23:22:54 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Anup Patel <anup@brainfault.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 3/5] irqchip: RISC-V Local Interrupt Controller Driver
Message-ID: <20180911062254.GA23395@infradead.org>
References: <20180910134915.GB30774@infradead.org>
 <CAAhSdy1be_ibiowifBdgBZjbHuFU=CR4rZXQDwQghVYkex5bMg@mail.gmail.com>
 <alpine.DEB.2.21.1809101805110.1419@nanos.tec.linutronix.de>
 <20180910161143.GA1053@infradead.org>
 <CAAhSdy0kgsy0QFDQGYeVy6vxu8v7UwRGbdJC9Hhz+36TNYjyGA@mail.gmail.com>
 <20180910163936.GA18699@infradead.org>
 <CAAhSdy3AN4YTaAJCR50WMB8CgaoZNeT9uOZt2GH2O6i8Y6z6ew@mail.gmail.com>
 <alpine.DEB.2.21.1809102133240.1419@nanos.tec.linutronix.de>
 <20180910221902.GB7368@infradead.org>
 <CAAhSdy2uAqOQohmx_HDgR1MbtWeOdc0MTFxToMK2Ak9-za1evg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhSdy2uAqOQohmx_HDgR1MbtWeOdc0MTFxToMK2Ak9-za1evg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 09:27:45AM +0530, Anup Patel wrote:
> The list of currently defined RISC-V local interrupts will definitely grow
> based on my experience from ARM/ARM64 world.
> 
> Like Thomas mentioned, we will definitely end-up having separate
> irqchip and irq_domain for RISC-V local interrupts for flexibility. Better
> do it now with separate RISC-V INTC driver.

I disagree.  Just because arm made a mess of their irq handling there
is no need to repeat mistakes by paving their way.  IFF we end up
with a convoluted mess like arm in the end we'll need an irqchip,
and as your series has shown that is fairly easily doable.  But I'd
rather spend my effort on it not becoming a mess in the first place
rather than helping the mess.
