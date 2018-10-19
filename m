Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8198CECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 11:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4001B2145D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 11:24:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4001B2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbeJST3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 15:29:41 -0400
Received: from foss.arm.com ([217.140.101.70]:50704 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726609AbeJST3k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 15:29:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD3D280D;
        Fri, 19 Oct 2018 04:24:01 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AB89F3F71D;
        Fri, 19 Oct 2018 04:24:01 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id B44671AE06EF; Fri, 19 Oct 2018 12:24:04 +0100 (BST)
Date:   Fri, 19 Oct 2018 12:24:04 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Kristina Martsenko <kristina.martsenko@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arch@vger.kernel.org, Andrew Jones <drjones@redhat.com>,
        Jacob Bramley <jacob.bramley@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Adam Wallis <awallis@codeaurora.org>,
        "Suzuki K . Poulose" <suzuki.poulose@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        kvmarm@lists.cs.columbia.edu,
        Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
        Amit Kachhap <Amit.Kachhap@arm.com>,
        Dave P Martin <Dave.Martin@arm.com>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        gorcunov@openvz.org
Subject: Re: [PATCH v5 07/17] arm64: add basic pointer authentication support
Message-ID: <20181019112404.GD14246@arm.com>
References: <20181005084754.20950-1-kristina.martsenko@arm.com>
 <20181005084754.20950-8-kristina.martsenko@arm.com>
 <20181019111542.6wrvjguirglzg7vg@mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181019111542.6wrvjguirglzg7vg@mbp>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+Cyrill Gorcunov for CRIU stuff]

On Fri, Oct 19, 2018 at 12:15:43PM +0100, Catalin Marinas wrote:
> On Fri, Oct 05, 2018 at 09:47:44AM +0100, Kristina Martsenko wrote:
> > diff --git a/arch/arm64/include/asm/pointer_auth.h b/arch/arm64/include/asm/pointer_auth.h
> > new file mode 100644
> > index 000000000000..2aefedc31d9e
> > --- /dev/null
> > +++ b/arch/arm64/include/asm/pointer_auth.h
> > @@ -0,0 +1,63 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#ifndef __ASM_POINTER_AUTH_H
> > +#define __ASM_POINTER_AUTH_H
> > +
> > +#include <linux/random.h>
> > +
> > +#include <asm/cpufeature.h>
> > +#include <asm/sysreg.h>
> > +
> > +#ifdef CONFIG_ARM64_PTR_AUTH
> > +/*
> > + * Each key is a 128-bit quantity which is split across a pair of 64-bit
> > + * registers (Lo and Hi).
> > + */
> > +struct ptrauth_key {
> > +	unsigned long lo, hi;
> > +};
> > +
> > +/*
> > + * We give each process its own instruction A key (APIAKey), which is shared by
> > + * all threads. This is inherited upon fork(), and reinitialised upon exec*().
> > + * All other keys are currently unused, with APIBKey, APDAKey, and APBAKey
> > + * instructions behaving as NOPs.
> > + */
> 
> I don't remember the past discussions but I assume the tools guys are ok
> with a single key shared by multiple threads. Ramana, could you ack this
> part, FTR?
> 
> (and it would help if someone from the Android and Chrome camps can
> confirm)

FWIW: I think we should be entertaining a prctl() interface to use a new
key on a per-thread basis. Obviously, this would need to be used with care
(e.g. you'd fork(); use the prctl() and then you'd better not return from
the calling function!).

Assuming we want this (Kees -- I was under the impression that everything in
Android would end up with the same key otherwise?), then the question is
do we want:

  - prctl() get/set operations for the key, or
  - prctl() set_random_key operation, or
  - both of the above?

Part of the answer to that may lie in the requirements of CRIU, where I
strongly suspect they need explicit get/set operations, although these
could be gated on CONFIG_CHECKPOINT_RESTORE=y.

Will
