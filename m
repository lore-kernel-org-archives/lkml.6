Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA3AC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 10:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CD4E20856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 10:21:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CD4E20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388385AbeGXL0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 07:26:49 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47866 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbeGXL0t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 07:26:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DDF197A9;
        Tue, 24 Jul 2018 03:21:03 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AE4EB3F237;
        Tue, 24 Jul 2018 03:21:03 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 4D7471AE3B5E; Tue, 24 Jul 2018 11:21:03 +0100 (BST)
Date:   Tue, 24 Jul 2018 11:21:03 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ia64@vger.kernel.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH] [SUBMITTED 20180724] arm64: fix ACPI dependencies
Message-ID: <20180724102102.GI19324@arm.com>
References: <20180724094957.1967541-1-arnd@arndb.de>
 <CAJZ5v0jMtWDZePW=mu_cO2PjHVGp1hQThSveq9+=2aNozESENQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jMtWDZePW=mu_cO2PjHVGp1hQThSveq9+=2aNozESENQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 11:54:25AM +0200, Rafael J. Wysocki wrote:
> On Tue, Jul 24, 2018 at 11:48 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > Kconfig reports a warning on x86 builds after the ARM64 dependency
> > was added.
> >
> > drivers/acpi/Kconfig:6:error: recursive dependency detected!
> > drivers/acpi/Kconfig:6:       symbol ACPI depends on EFI
> >
> > This rephrases the dependency to keep the ARM64 details out of the
> > shared Kconfig file, so Kconfig no longer gets confused by it.
> >
> > For consistency, all three architectures that support ACPI now
> > select ARCH_SUPPORTS_ACPI in exactly the configuration in which
> > they allow it. We still need the 'default x86', as each one
> > wants a different default: default-y on x86, default-n on arm64,
> > and always-y on ia64.
> >
> > Fixes: 5bcd44083a08 ("drivers: acpi: add dependency of EFI for arm64")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> > v2: use 'select ARCH_SUPPORTS_ACPI' for all three.
> 
> LGTM
> 
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Same here:

Acked-by: Will Deacon <will.deacon@arm.com>

Would it be ok if I take this via the arm64 tree, since that's where the
warning was introduced?

Will
