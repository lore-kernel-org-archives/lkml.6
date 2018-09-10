Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01445C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 22:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B11320855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 22:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jFob413A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B11320855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbeIKDNC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 23:13:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39908 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbeIKDNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 23:13:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8KIRiD9ZlTHm3Ln9yqup7ZC3QSFn0qlowOO2s9KbUqk=; b=jFob413AjHR9ZWr0yxrPXH7n6
        U4WmMeckSZtf6ga8pB7jYkGOHNIBPmnSE7KpK3uKqwX8gy5XpBCyTcD956ojFY63MKzdw2ma5u/T+
        zQVXOFbetgPWo1Mo37DRmXU7I3CSg+zu9EHCOgqTQBjnrXsWDf25n6DFOS2vDoaDzEbd261yuY+Ik
        1mJY8Efub8TawkRCqQyy7gvQOQK4nc+2b48v5+nw2ccribd50EMuBPSXwVTC2yaIwZtXj7PQgUr2z
        4O0Ci2tL88GESYWgrPL+UXpDO9B+13dxS8XNhKbeCJwhueTR/kxmPK1QquEufAT7CfxtY1WIalJaH
        cf3dxXF8w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fzUUB-0001xn-3e; Mon, 10 Sep 2018 22:16:47 +0000
Date:   Mon, 10 Sep 2018 15:16:46 -0700
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
Message-ID: <20180910221646.GA7368@infradead.org>
References: <alpine.DEB.2.21.1809101536410.1292@nanos.tec.linutronix.de>
 <20180910133902.GB21593@infradead.org>
 <alpine.DEB.2.21.1809101544560.1292@nanos.tec.linutronix.de>
 <20180910134915.GB30774@infradead.org>
 <CAAhSdy1be_ibiowifBdgBZjbHuFU=CR4rZXQDwQghVYkex5bMg@mail.gmail.com>
 <alpine.DEB.2.21.1809101805110.1419@nanos.tec.linutronix.de>
 <20180910161143.GA1053@infradead.org>
 <CAAhSdy0kgsy0QFDQGYeVy6vxu8v7UwRGbdJC9Hhz+36TNYjyGA@mail.gmail.com>
 <20180910163936.GA18699@infradead.org>
 <CAAhSdy3AN4YTaAJCR50WMB8CgaoZNeT9uOZt2GH2O6i8Y6z6ew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhSdy3AN4YTaAJCR50WMB8CgaoZNeT9uOZt2GH2O6i8Y6z6ew@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 10:41:22PM +0530, Anup Patel wrote:
> RISC-V priv spec 1.10 defines the 9 bits in MIE and MIP registers and
> other bits are reserved.
> 
> The unused bits in MIP are WIRI (reserved write ignored and read ignored)
> and unused bits in MIE are WPRI (reserved write preserve values and
> read ignored).
> 
> The RISC-V priv spec 1.10 does not tell that unused reserved bits in
> MIE/MIP cannot be used for:
> 1. CPU implementation specific local interrupts
> 2. Per-CPU device interrupts.
> 
> The RISC-V priv spec 1.10 tries to only describe MIE/MIP bits which
> are mandatory on any RISC-V 1.10 compliant CPU but it possible to
> used other reserved bits for implementation specific local interrupts.

Reserved means reserved for future versions of the spec, not for vendor
specific bad ideas.
