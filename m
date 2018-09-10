Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E1CFC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1382520645
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="E/hkDwB9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1382520645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbeIJVan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 17:30:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60170 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728137AbeIJVam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 17:30:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jON4lN9Cmgjvu23tnYMldLvotKPjMdzYd/j2VBA4Wnc=; b=E/hkDwB9r1Of+nHTWMSTog1VI
        thj0GFccdta2jOTZaw6S4xHQ6JkkBmg3FyEehFgL/400okvp5QnN7Bw0Vev48OVe36e+wPWFS+1Hi
        LJOK4ZGD++Ra78aLSk1GEq0MTYtf6yykIBr2IrK2M/sN1T7rnxE0usVWDewmRUbX4K0is3uv1fd5l
        oxfGJ7BP2XnJ6JqIlyIR/x5b5wTx09NuQFNRxmQ42eE94r72PU44Q1IIcFiPunlRAAHIeGBbXrk9/
        yexiJaqfahXTLwkI8ZyGUyhzpWGg+P6frGKmV54gtxL727qdgQGd8TqY8NYOqj6uX6OxSCU5Amc8Y
        6fFXMdBQg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fzPA7-0004hE-Rf; Mon, 10 Sep 2018 16:35:43 +0000
Date:   Mon, 10 Sep 2018 09:35:43 -0700
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
Message-ID: <20180910163543.GA13052@infradead.org>
References: <alpine.DEB.2.21.1809081241310.1402@nanos.tec.linutronix.de>
 <20180910132924.GA6987@infradead.org>
 <alpine.DEB.2.21.1809101533330.1292@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1809101536410.1292@nanos.tec.linutronix.de>
 <20180910133902.GB21593@infradead.org>
 <alpine.DEB.2.21.1809101544560.1292@nanos.tec.linutronix.de>
 <20180910134915.GB30774@infradead.org>
 <CAAhSdy1be_ibiowifBdgBZjbHuFU=CR4rZXQDwQghVYkex5bMg@mail.gmail.com>
 <20180910161328.GA13171@infradead.org>
 <CAAhSdy2Y-XTZ12i5aV+SzraMZP1YQBhAArpER-YssPcBJNOPOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhSdy2Y-XTZ12i5aV+SzraMZP1YQBhAArpER-YssPcBJNOPOA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 10:02:09PM +0530, Anup Patel wrote:
> You are thinking very much in-context of SiFive CPUs only.

No.  I think in terms of the RISC-V spec.  I could care less about
SiFive to be honest.

> Lot of SOC vendors are trying to come-up with their own CPUs
> and RISC-V spec does not restrict the use of local interrupts.

Yes, it does.

> The mie/mip/sie/sip/uie/uip are all machine word size so on
> riscv64 we can theoretically have maximum 64 local interrupts.

They could in theory IFF someone actually get the use case through
the riscv privileged spec working group.
