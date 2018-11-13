Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE8EC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 16:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1DFC223DD
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 16:34:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1DFC223DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-mips.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731345AbeKNCdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 21:33:03 -0500
Received: from eddie.linux-mips.org ([148.251.95.138]:53610 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727475AbeKNCdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 21:33:03 -0500
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23993048AbeKMQdmj6ry9 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org> + 1 other);
        Tue, 13 Nov 2018 17:33:42 +0100
Date:   Tue, 13 Nov 2018 16:33:42 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Yasha Cherikovsky <yasha.che3@gmail.com>
cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC v2 1/7] MIPS: Add support for the Lexra LX5280 CPU
In-Reply-To: <20181001102952.7913-2-yasha.che3@gmail.com>
Message-ID: <alpine.LFD.2.21.1811131513070.9637@eddie.linux-mips.org>
References: <20181001102952.7913-1-yasha.che3@gmail.com> <20181001102952.7913-2-yasha.che3@gmail.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Oct 2018, Yasha Cherikovsky wrote:

> The Lexra LX5280 CPU [1][2] implements the MIPS-I ISA,
> without unaligned load/store instructions (lwl, lwr, swl, swr).

 I think you actually need to emulate these missing instructions for user 
programs, so that the 32-bit MIPS psABI is supported and standard software 
can run unmodified.  There'll be a performance hit and software will best 
be recompiled for the limited instruction set provided by actual hardware, 
however rebuilding is not always possible or feasible (also handcoded 
assembly may require actual reimplementation here and there).

> - RDHWR instruction emulation from the page fault handler
>   (more details in a code comment)

 The details are lacking I am afraid and I think it would be good to have 
them provided for long-term support to be feasible.

 First, the MIPS architecture does not have a single "page fault" 
exception.  There are three MMU exception codes defined: Mod, TLBL and 
TLBS, and also two vectors, either the TLB Refill or the General 
Exception.  So please be specific which of those are taken by the LX5280 
with the RDHWR instruction.

 Second, please explain why this MMU exception happens, i.e. does the CPU 
decode the SPECIAL3 major opcode as an I-Type memory access instruction, 
and then faults on `GPR[0] + offset' pointing to an unmapped page?

 If documentation is publicly available this information can be inferred 
from, then please provide a reference; otherwise please just describe the 
observed behaviour as you know it.

  Maciej
