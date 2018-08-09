Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175EEC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 10:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9FB221A8D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 10:19:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9FB221A8D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730060AbeHIMoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 08:44:07 -0400
Received: from foss.arm.com ([217.140.101.70]:51496 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727371AbeHIMoH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 08:44:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 75B0B18A;
        Thu,  9 Aug 2018 03:19:55 -0700 (PDT)
Received: from [10.4.13.119] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A11F23F5D4;
        Thu,  9 Aug 2018 03:19:52 -0700 (PDT)
Subject: Re: [PATCH 03/11] dt-bindings: interrupt-controller: RISC-V PLIC
 documentation
To:     Christoph Hellwig <hch@lst.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, atish.patra@wdc.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-riscv@lists.infradead.org, Stafford Horne <shorne@gmail.com>
References: <CAL_Jsq+pVzqKUbhErRr15JX2mPUOSTp_ddGvu9KAuf=TtXfduQ@mail.gmail.com>
 <mhng-4bc89d00-bc90-440f-996f-861dde382aaa@palmer-si-x1c4>
 <CAL_JsqKPFSQYH3p6a0VoCr-VAzf_98H7N3fNJ+4+DquS8WcjUQ@mail.gmail.com>
 <20180808150938.GA32274@lst.de>
 <bb671fe1-6c43-3218-0096-7c5280ffb6b5@arm.com> <20180808165729.GA6079@lst.de>
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <15990cbc-042c-027e-ea2d-c4f0433c29a1@arm.com>
Date:   Thu, 9 Aug 2018 11:19:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180808165729.GA6079@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/18 17:57, Christoph Hellwig wrote:
> On Wed, Aug 08, 2018 at 05:47:40PM +0100, Marc Zyngier wrote:
>> The original GIC driver deals with 2.5 revisions of the architecture
>> (yes, there was something pre-GICv1...), and implementers have been
>> creative to the extreme. Still, we could have done without most of these
>> compat strings. Hindsight and all that jazz.
>>
>> GICv3 is a much more controlled architecture, and although people have
>> come up with a number of turds masquerading as implementations, it has
>> never been bad enough to mandate a different set of compat strings.
>> Also, you cannot describe that kind of stuff in ACPI, and we need to
>> support both, so we've come up with different ways of handling this.
> 
> So the claim from SiFive is that all their current plic blocks are
> the same.  Based on that I'd be really tempted to just match for
> sifive,plic (or sifive,plic1 as suggested by them), but also require
> each device to actually provide a board specific compatible string,
> just in case that something goes wrong.  Which I suspect is what you
> are doing with GICv3, right?

We do it slightly differently:

Each GICv3 implementation has a set of ID registers that uniquely
identifies the implementer and revision of the HW block. This allows us
to quirk individual implementations while only having a single matching
property, and be independent of a single firmware implementation (DT vs
ACPI).

We don't mandate anything at the board or even SoC level though (it
would quickly become unmanageable given the number of SOCs and devices).

	M.
-- 
Jazz is not dead. It just smells funny...
