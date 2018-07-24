Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A1E9ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 09:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33FF020874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 09:50:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33FF020874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388335AbeGXKzj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 06:55:39 -0400
Received: from foss.arm.com ([217.140.101.70]:46586 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726479AbeGXKzj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 06:55:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7CD8B7A9;
        Tue, 24 Jul 2018 02:50:00 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4F2E43F237;
        Tue, 24 Jul 2018 02:50:00 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id DF67D1AE3B5E; Tue, 24 Jul 2018 10:49:59 +0100 (BST)
Date:   Tue, 24 Jul 2018 10:49:59 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
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
Message-ID: <20180724094959.GH19324@arm.com>
References: <20180724093345.1575921-1-arnd@arndb.de>
 <CAJZ5v0jTowUW6myVf0B2Gyq0ZA2ATqPNnaeOgFS01ce8A=FBpA@mail.gmail.com>
 <20180724094406.GF19324@arm.com>
 <CAK8P3a12WfW9GmUW+=cW+2ZfUzSw3c-71KkiT_1UxxxivgFedw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a12WfW9GmUW+=cW+2ZfUzSw3c-71KkiT_1UxxxivgFedw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 11:46:23AM +0200, Arnd Bergmann wrote:
> On Tue, Jul 24, 2018 at 11:44 AM, Will Deacon <will.deacon@arm.com> wrote:
> > On Tue, Jul 24, 2018 at 11:37:10AM +0200, Rafael J. Wysocki wrote:
> >> On Tue, Jul 24, 2018 at 11:33 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> 
> >
> > How about something along the lines of what Ard suggested? Untested diff
> > below.
> >
> >
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index 303809c6..ec78d4d 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -56,6 +56,7 @@ config ARM64
> >         select ARCH_USE_CMPXCHG_LOCKREF
> >         select ARCH_USE_QUEUED_RWLOCKS
> >         select ARCH_USE_QUEUED_SPINLOCKS
> > +       select ARCH_SUPPORTS_ACPI
> >         select ARCH_SUPPORTS_MEMORY_FAILURE
> >         select ARCH_SUPPORTS_ATOMIC_RMW
> >         select ARCH_SUPPORTS_INT128 if GCC_VERSION >= 50000 || CC_IS_CLANG
> 
> I'd prefer Rafael's suggestion of just leaving out the architecture names from
> the dependency, and making all three 'select ARCH_SUPPORTS_ACPI'.
> 
> I'll send a v2.

Ok, thanks.

Will
