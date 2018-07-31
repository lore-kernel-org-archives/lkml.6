Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6B9C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 16:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6416B20841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 16:52:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6416B20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731990AbeGaSd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 14:33:58 -0400
Received: from verein.lst.de ([213.95.11.211]:58173 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727471AbeGaSd6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 14:33:58 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 8632768D64; Tue, 31 Jul 2018 18:57:12 +0200 (CEST)
Date:   Tue, 31 Jul 2018 18:57:12 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "shorne@gmail.com" <shorne@gmail.com>
Subject: Re: [PATCH 7/9] irqchip: add a RISC-V PLIC driver
Message-ID: <20180731165712.GA2521@lst.de>
References: <20180726143723.16585-1-hch@lst.de> <20180726143723.16585-8-hch@lst.de> <1b3f6066-0c7c-a5f5-75ad-559fe81091ee@wdc.com> <dc69d688-f765-74cc-3234-563fecff6002@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc69d688-f765-74cc-3234-563fecff6002@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 08:21:33PM -0700, Atish Patra wrote:
> I found the issue. As per PLIC documentation, a hart context is a given 
> privilege mode on a given hart. Thus, cpu context ID & cpu numbers are not 
> same. Here is the PLIC register Maps in U54 core:
>
> Ref: https://static.dev.sifive.com/U54-MC-RVCoreIP.pdf
>
> Memory address for Interrupt enable
> Address
> 0x0C00-2080   Hart 1 M-mode enables
> 0x0C00 2094   End of Hart 1 M-mode enables
>
> 0x0C00-2100   Hart 1 S-mode enables
> 0x0C00-2114   End of Hart 1 S-mode enables
>
> Memory map Claim/Threshold
> Address
> 0x0C20-1000 4B 	 M-mode priority threshold
> 0x0C20-1004 4B   M-mode claim/complete
> 0x0C20-2000 4B   S-mode priority threshold
> 0x0C20-2004 4B   S-mode claim/complete
>
> The original PLIC patch was calculating based on handle->contextid which 
> will assume numbers on a HighFive Unleashed board as 2 4 6 8.
>
> In this patch, context id is assigned as cpu numbers which will be 1 2 3 4. 
> Thus it will lead to incorrect plic address access as shown below.

Indeed.  Can you try this branch, which puts back the OF contextid
parsing from the original code:

   git://git.infradead.org/users/hch/riscv.git riscv-irq-simple.2

Gitweb:

   http://git.infradead.org/users/hch/riscv.git/shortlog/refs/heads/riscv-irq-simple.2

