Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B62C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 09:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8511420875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 09:44:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8511420875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388455AbeGXKtp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 06:49:45 -0400
Received: from foss.arm.com ([217.140.101.70]:46380 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbeGXKtp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 06:49:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD5B67A9;
        Tue, 24 Jul 2018 02:44:07 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AEE613F237;
        Tue, 24 Jul 2018 02:44:07 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 4E6941AE3B5E; Tue, 24 Jul 2018 10:44:07 +0100 (BST)
Date:   Tue, 24 Jul 2018 10:44:07 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH] arm64: fix ACPI dependencies
Message-ID: <20180724094406.GF19324@arm.com>
References: <20180724093345.1575921-1-arnd@arndb.de>
 <CAJZ5v0jTowUW6myVf0B2Gyq0ZA2ATqPNnaeOgFS01ce8A=FBpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jTowUW6myVf0B2Gyq0ZA2ATqPNnaeOgFS01ce8A=FBpA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 11:37:10AM +0200, Rafael J. Wysocki wrote:
> On Tue, Jul 24, 2018 at 11:33 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > Kconfig reports a warning on x86 builds after the ARM64 dependency
> > was added.
> >
> > drivers/acpi/Kconfig:6:error: recursive dependency detected!
> > drivers/acpi/Kconfig:6:       symbol ACPI depends on EFI
> >
> > This rephrases the dependency to keep the ARM64 details out of the
> > shared Kconfig file, so Kconfig no longer gets confused by it.
> >
> > Fixes: 5bcd44083a08 ("drivers: acpi: add dependency of EFI for arm64")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  arch/arm64/Kconfig   | 1 +
> >  drivers/acpi/Kconfig | 5 ++++-
> >  2 files changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index cdcaa6a798b2..2f987a938405 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -1267,6 +1267,7 @@ config EFI
> >         bool "UEFI runtime support"
> >         depends on OF && !CPU_BIG_ENDIAN
> >         depends on KERNEL_MODE_NEON
> > +       select ARCH_SUPPORTS_ACPI
> >         select LIBFDT
> >         select UCS2_STRING
> >         select EFI_PARAMS_FROM_FDT
> > diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> > index a8da730fabc6..0cda51c5d433 100644
> > --- a/drivers/acpi/Kconfig
> > +++ b/drivers/acpi/Kconfig
> > @@ -6,7 +6,7 @@
> >  menuconfig ACPI
> >         bool "ACPI (Advanced Configuration and Power Interface) Support"
> >         depends on !IA64_HP_SIM
> > -       depends on IA64 || X86 || (ARM64 && EFI)
> > +       depends on IA64 || X86 || ARCH_SUPPORTS_ACPI
> 
> That doesn't look particularly consistent to me.
> 
> It should be either "depends on ARCH_SUPPORTS_ACPI" alone or mention
> ARM64 somehow IMO

How about something along the lines of what Ard suggested? Untested diff
below.

Will

--->8

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 303809c6..ec78d4d 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -56,6 +56,7 @@ config ARM64
        select ARCH_USE_CMPXCHG_LOCKREF
        select ARCH_USE_QUEUED_RWLOCKS
        select ARCH_USE_QUEUED_SPINLOCKS
+       select ARCH_SUPPORTS_ACPI
        select ARCH_SUPPORTS_MEMORY_FAILURE
        select ARCH_SUPPORTS_ATOMIC_RMW
        select ARCH_SUPPORTS_INT128 if GCC_VERSION >= 50000 || CC_IS_CLANG
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 15ab1da..198db2d 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -3,10 +3,12 @@
 # ACPI Configuration
 #
 
+config ARCH_SUPPORTS_ACPI
+       def_bool (IA64 && !IA64_HP_SIM) || X86
+
 menuconfig ACPI
        bool "ACPI (Advanced Configuration and Power Interface) Support"
-       depends on !IA64_HP_SIM
-       depends on IA64 || X86 || (ARM64 && EFI)
+       depends on ARCH_SUPPORTS_ACPI
        depends on PCI
        select PNP
        default y if (IA64 || X86)
