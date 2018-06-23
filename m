Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E3AC43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 07:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F44124B4F
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 07:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ACXAC4Z1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F44124B4F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751595AbeFWH23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 03:28:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47606 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751514AbeFWH22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 03:28:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=j5mUwJRIKGIxvlP3o+tfxwNq8eRopr5+SexQQWZwDFA=; b=ACXAC4Z15KTJnRQwUoXtwO9Wb
        yFenn8yBOL+/QOHRgux2bb69bBRwgiRSKZZNYVxqygl3Hq210C944G/RNotPmzLne39Prt69HtRmX
        ws+p5UNLAWewhmZa9vfmc93EkY0+/YyMgLVnEnzlU8WXrqojVC5xHIc92ClfdVdctvMKO2Z6LtO73
        ZxEC7oaL3vJV0UpQdzQ682IdLa0F8cBmDe62IfT6liNJjjAiad+slNGrTdy1SNLrzTyiP4qg7y+03
        OQcQm25bU4DAHijvciZJ6pqrVPh3LwV+2IGoBV2Y0coopsQQ/NMMXGbA85r0zh5727a7I3ZPxW570
        eWysXlyUg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fWcy9-0008Nz-23; Sat, 23 Jun 2018 07:28:25 +0000
Date:   Sat, 23 Jun 2018 00:28:24 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, Michael Clark <mjc@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org, shorne@gmail.com
Subject: Re: [PATCH 3/3] irqchip: RISC-V Local Interrupt Controller Driver
Message-ID: <20180623072824.GC25573@infradead.org>
References: <20180622232006.12158-1-palmer@sifive.com>
 <20180622232006.12158-4-palmer@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622232006.12158-4-palmer@sifive.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +config RISCV_INTC
> +	#bool "RISC-V Interrupt Controller"
> +	depends on RISCV
> +	default y
> +	help
> +	   This enables support for the local interrupt controller found in
> +	   standard RISC-V systems.  The local interrupt controller handles
> +	   timer interrupts, software interrupts, and hardware interrupts.
> +	   Without a local interrupt controller the system will be unable to
> +	   handle any interrupts, including those passed via the PLIC.

This can just be:

config RISCV_INTC
	def_bool y if RISCV
	depends on RISCV

as this isn't a user selectable option.

> index 000000000000..7ca3060e76b4
> --- /dev/null
> +++ b/drivers/irqchip/irq-riscv-intc.c
> @@ -0,0 +1,215 @@
> +/*
> + * Copyright (C) 2012 Regents of the University of California
> + * Copyright (C) 2017-2018 SiFive
> + */
> +/* SPDX-License-Identifier: GPL-2.0 */

SPDX tags need to be the first thing in the file, and use // -style
comments.

FYI, I've got a version with this and a few other cleanups here:

http://git.infradead.org/users/hch/riscv.git/commitdiff/d0789843f663ba8a6573ac5f73d8b6f999c8e6ed
