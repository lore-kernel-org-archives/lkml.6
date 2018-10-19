Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948ECECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5061C2064A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:36:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5061C2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbeJSUml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 16:42:41 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51820 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727011AbeJSUmk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 16:42:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD869A78;
        Fri, 19 Oct 2018 05:36:44 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7D2BE3F71D;
        Fri, 19 Oct 2018 05:36:44 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 8CD561AE06FD; Fri, 19 Oct 2018 13:36:47 +0100 (BST)
Date:   Fri, 19 Oct 2018 13:36:47 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Kristina Martsenko <kristina.martsenko@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Adam Wallis <awallis@codeaurora.org>,
        Amit Kachhap <Amit.Kachhap@arm.com>,
        Andrew Jones <drjones@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Dave P Martin <Dave.Martin@arm.com>,
        Jacob Bramley <jacob.bramley@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
        "Suzuki K . Poulose" <suzuki.poulose@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/17] ARMv8.3 pointer authentication support
Message-ID: <20181019123646.GG14246@arm.com>
References: <20181005084754.20950-1-kristina.martsenko@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181005084754.20950-1-kristina.martsenko@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2018 at 09:47:37AM +0100, Kristina Martsenko wrote:
> 1) Key support
> 
> This series enables the use of instructions using APIAKey, which is
> initialised and maintained per-process (shared by all threads). GCC
> currently only makes use of APIAKey.
> 
> This series does not add support for APIBKey, APDAKey, APDBKey, nor
> APGAKey. HINT-space instructions using these keys will currently execute
> as NOPs. Support for these keys can be added as users appear.
> 
> Note that while we expose the cpuid register (ID_AA64ISAR1_EL1) to
> userspace, it only contains one feature for address authentication
> (API/APA), so it cannot be used by userspace to tell which keys the
> kernel supports. For this the kernel exposes HWCAP bits, one per key
> (currently only APIAKey), which must be checked instead.

Given that the architecture doesn't provide an identification mechanism
for the case where only one of the keys is available, I would much prefer
that we expose both of the keys to userspace. Is the only downside of
that a possible exception entry overhead if the kernel wants to use pointer
authentication as well?

Having an initial implementation where the B key operations act as NOPs
isn't ideal if we want to support future users -- chances are they'll
be put off because deployed kernels don't give them whatever security
guarantees they require. It's a bit of a chicken-and-egg problem, so
unless we have good reasons to keep the B key hidden, I think we should
be exposing it from the start.

Will
