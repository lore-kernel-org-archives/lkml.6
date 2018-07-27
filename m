Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51ABBC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 14:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B034208AF
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 14:40:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B034208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732846AbeG0QCZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 12:02:25 -0400
Received: from verein.lst.de ([213.95.11.211]:41659 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730458AbeG0QCZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 12:02:25 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 47D0568D60; Fri, 27 Jul 2018 16:44:05 +0200 (CEST)
Date:   Fri, 27 Jul 2018 16:44:05 +0200
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
Subject: Re: RFC: simplified RISC-V interrupt and clocksource handling
Message-ID: <20180727144405.GB29626@lst.de>
References: <20180726143723.16585-1-hch@lst.de> <dc346650-0b48-3c2b-9190-b87ea6987e37@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc346650-0b48-3c2b-9190-b87ea6987e37@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 04:38:43PM -0700, Atish Patra wrote:
> 1. As per my understanding, timer interrupt now can't be registered as a 
> Linux IRQ now. Thus, /proc/interrupts will not be automatically populated 
> for timer interrupt stats. Am I wrong in my assumption?

Yes, with this code the timer interrupt does not show up in
/proc/interrupts.  I wonder if that is an issue and if there is any
precedence for it?

> 2. The future version of local interrupt controller known as Core Level 
> Interrupt Controller aka CLIC. Do we have to change the current design
> again for CLIC in future?
>
> Here are the docs:
> https://github.com/sifive/clic-spec/blob/master/clic.adoc

This doesn't really look like 'the future' version but a proposal for
something more like low end realtime microcontrollers ala ARM Cortex M*.
At least the priorities don't really make much sense for a general
purpose SOC.

Either way the existing architectural scause/sie interrupt handling will
remain but can be opted out, but if we really want to support the CLIC
it would have to grow a new irqchip driver, and the PLIC driver would
require a few dozend new lines of glue code to chain underneath it.
