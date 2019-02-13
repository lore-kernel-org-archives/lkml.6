Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0185DC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4851222D2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392748AbfBMQuk convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 11:50:40 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:47091 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388561AbfBMQuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 11:50:40 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gtxk2-0007kV-Hp; Wed, 13 Feb 2019 17:50:34 +0100
Date:   Wed, 13 Feb 2019 17:50:34 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     Julien Grall <julien.grall@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rt-users@vger.kernel.org, catalin.marinas@arm.com,
        will.deacon@arm.com, ard.biesheuvel@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] arm64/fpsimd: Don't disable softirq when touching
 FPSIMD/SVE state
Message-ID: <20190213165034.mda5rdfwsxbcdtfa@linutronix.de>
References: <20190208165513.8435-1-julien.grall@arm.com>
 <20190213143029.ad2kzg7vtuo3zpjk@linutronix.de>
 <20190213153630.GK3567@e103592.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190213153630.GK3567@e103592.cambridge.arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-02-13 15:36:30 [+0000], Dave Martin wrote:
> On Wed, Feb 13, 2019 at 03:30:29PM +0100, Sebastian Andrzej Siewior wrote:
> > On 2019-02-08 16:55:13 [+0000], Julien Grall wrote:
> > > When the kernel is compiled with CONFIG_KERNEL_MODE_NEON, some part of
> > > the kernel may be able to use FPSIMD/SVE. This is for instance the case
> > > for crypto code.
> > > 
> > > Any use of FPSIMD/SVE in the kernel are clearly marked by using the
> > > function kernel_neon_{begin, end}. Furthermore, this can only be used
> > > when may_use_simd() returns true.
> > 
> > This is equal what x86 is currently doing. The naming is slightly
> > different, there is irq_fpu_usable().
> 
> Yes, I think it's basically the same idea.
> 
> It's been evolving a bit on both sides, but is quite similar now.

I though that this is complicated and wanted to submit a patch to remove
irq_fpu_usable() and disable BH as part of kernel_fpu_begin() (but have
currently the onother FPU series ongoing which I want to finish first).

…
> "Usually" is probably not good enough if another task can run: if the
> preempting task enters userspace then the vector registers are needed
> for its use, which is tricky to arrange if the registers are currently
> in use by context switch logic running in the first task.

Yes.

> My current feeling is that we probably have to stick with
> preempt_disable() here, but hopefully we can get rid of
> local_bh_disable() (as proposed) with no ill effects...
> 
> Does that sound sensible?

If you want to stick with may_use_simd() then yes.

> Cheers
> ---Dave

Sebastian
