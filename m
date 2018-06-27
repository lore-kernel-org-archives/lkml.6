Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E95ACC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A847D25EDA
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:14:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A847D25EDA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752592AbeF0POf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 11:14:35 -0400
Received: from foss.arm.com ([217.140.101.70]:33138 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751002AbeF0POd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 11:14:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A5AB718A;
        Wed, 27 Jun 2018 08:14:33 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 76EB03F266;
        Wed, 27 Jun 2018 08:14:33 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 5D1101AE3692; Wed, 27 Jun 2018 16:15:11 +0100 (BST)
Date:   Wed, 27 Jun 2018 16:15:11 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Garnier <thgarnie@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Russell King <linux@armlinux.org.uk>,
        Paul Mackerras <paulus@samba.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Petr Mladek <pmladek@suse.com>, Ingo Molnar <mingo@redhat.com>,
        James Morris <jmorris@namei.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Pitre <nico@linaro.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jessica Yu <jeyu@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: Re: [PATCH v9 0/6] add support for relative references in special
 sections
Message-ID: <20180627151510.GE30631@arm.com>
References: <20180626182802.19932-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626182802.19932-1-ard.biesheuvel@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,

On Tue, Jun 26, 2018 at 08:27:55PM +0200, Ard Biesheuvel wrote:
> This adds support for emitting special sections such as initcall arrays,
> PCI fixups and tracepoints as relative references rather than absolute
> references. This reduces the size by 50% on 64-bit architectures, but
> more importantly, it removes the need for carrying relocation metadata
> for these sections in relocatable kernels (e.g., for KASLR) that needs
> to be fixed up at boot time. On arm64, this reduces the vmlinux footprint
> of such a reference by 8x (8 byte absolute reference + 24 byte RELA entry
> vs 4 byte relative reference)
> 
> Patch #3 was sent out before as a single patch. This series supersedes
> the previous submission. This version makes relative ksymtab entries
> dependent on the new Kconfig symbol HAVE_ARCH_PREL32_RELOCATIONS rather
> than trying to infer from kbuild test robot replies for which architectures
> it should be blacklisted.
> 
> Patch #1 introduces the new Kconfig symbol HAVE_ARCH_PREL32_RELOCATIONS,
> and sets it for the main architectures that are expected to benefit the
> most from this feature, i.e., 64-bit architectures or ones that use
> runtime relocations.
> 
> Patch #2 add support for #define'ing __DISABLE_EXPORTS to get rid of
> ksymtab/kcrctab sections in decompressor and EFI stub objects when
> rebuilding existing C files to run in a different context.

I had a small question on patch 3, but it's really for my understanding.
So, for patches 1-3:

Reviewed-by: Will Deacon <will.deacon@arm.com>

Thanks,

Will
