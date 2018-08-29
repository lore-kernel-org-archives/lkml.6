Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A5DFC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 11:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C45F920858
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 11:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WrDAI/gz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C45F920858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbeH2PeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 11:34:09 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54249 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728198AbeH2PeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 11:34:09 -0400
Received: by mail-wm0-f65.google.com with SMTP id b19-v6so4947902wme.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 04:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ISNup6eeLVW/kqxe5NfOP7l1u2qGMELWb+KQypGRf1E=;
        b=WrDAI/gz9FeM9rIKM0ddhgqZZdTyC6qWppN3Q09KeNl91oLvatmTTsIF6OQ0qrUKCb
         zm05e9ObpkUSzxvw9UdRrVrOCkYqv7kcMSuLpR4boEVKSFz+lFlLT6eJ8DOP+vZCjeDs
         Uk6H47+JXMyo8J9QZapmbGUeqitWK7R3DN8N8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ISNup6eeLVW/kqxe5NfOP7l1u2qGMELWb+KQypGRf1E=;
        b=nxGQe8Ds4NQiuF1bt/nTmCKLb1NsGyXwYdNyvQL9wSzXAk+uWCzlwm19cUJwRgbRee
         5/02FLJHku868kbBDMBlNvKtdiP0AhIb3QoZxnAGZF650axgV5ytBVmcB03R/j4rrWD2
         hqD4or7/C8XgPVFDnlaGgelSMThq+WBRjl342SuqqdzMXG04nqaeAASgS1vZhXCesIKn
         APFUUI8Su+aNF1mQBjYSrRJGpSgerq/mPox4Bydu/09rhwuVZtBqcXfOq/Rfq1fkeWzJ
         WMJIbWitX8SUyHoZB9JKcJ/JhlCcfAc2g/fmUT9+n0VGyRVfQoi0o0tOUqLCqMRqwPql
         wmng==
X-Gm-Message-State: APzg51CF8zjPLNTzb6b6RCBk/R1ubfVEoRSg2clSmb8IVXUq8ekDtRr2
        ICW02lx3fAAzLMsfKZ70OCFAiQ==
X-Google-Smtp-Source: ANB0VdbDDRMWeOEY6CWPQKyHysE7Cz4cfihED6F0j6ucYJ7G2/dtY4NrXxfjYIok+yUoDF7sqeieYQ==
X-Received: by 2002:a1c:5c4:: with SMTP id 187-v6mr4024277wmf.10.1535542656866;
        Wed, 29 Aug 2018 04:37:36 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id h17-v6sm4556615wrq.73.2018.08.29.04.37.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 04:37:36 -0700 (PDT)
Date:   Wed, 29 Aug 2018 12:37:34 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Julien Thierry <julien.thierry@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org, marc.zyngier@arm.com, mark.rutland@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com
Subject: Re: [PATCH v5 00/27] arm64: provide pseudo NMI with GICv3
Message-ID: <20180829113734.evdvs46in6j6xksx@holly.lan>
References: <1535471497-38854-1-git-send-email-julien.thierry@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535471497-38854-1-git-send-email-julien.thierry@arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 04:51:10PM +0100, Julien Thierry wrote:
> Hi,
> 
> This series is a continuation of the work started by Daniel [1]. The goal
> is to use GICv3 interrupt priorities to simulate an NMI.
> 
> The patches depend on the core API for NMIs patches [2].

As before... is there a git tree? With the NMI core API I think I might
be able to get some of my old pseudo-NMI demos working.


> To achieve this, set two priorities, one for standard interrupts and
> another, higher priority, for NMIs. Whenever we want to disable interrupts,
> we mask the standard priority instead so NMIs can still be raised. Some
> corner cases though still require to actually mask all interrupts
> effectively disabling the NMI.
> 
> Daniel Thompson ran some benchmarks [3] on the previous version showing a
> small (<1%) performance drop when using interrupt priorities.

IMHO it is very important to disclose which micro-architecture (in this
case I think I was using C-A53 and GIC-500) the performance drop is
observed with.

We know from both micro- and macro-benchmarks that the performance delta
is deeply dependant on core implementation. In fact, my own work in this
area stalled largely because the main device that justified my spending
working-hours on pseudo-NMI was too badly impacted to see it enabled by
default.


Daniel.


> Currently, only PPIs and SPIs can be set as NMIs. IPIs being currently
> hardcoded IRQ numbers, there isn't a generic interface to set SGIs as NMI
> for now. LPIs being controlled by the ITS cannot be delivered as NMI.
> When an NMI is active on a CPU, no other NMI can be triggered on the CPU.
> 
> Requirements to use this:
> - Have GICv3
> - SCR_EL3.FIQ is set to 1 when linux runs or have single security state
> - Select Kernel Feature -> Use ICC system registers for IRQ masking
> 
> 
> * Patches 1 to 3 aim at applying some alternatives early in the boot
>   process.
> 
> * Patches 4 to 7 ensure the logic of daifflags remains valid
>   after arch_local_irq flags use ICC_PMR_EL1.
> 
> * Patches 8 and 9 clean up GIC current priority definition to make it
>   easier to introduce a new priority
> 
> * Patches 10 to 16 prepare arch code for the use of priorities, saving and
>   restoring ICC_PMR_EL1 appropriately
> 
> * Patches 17 to 20 add the support to GICv3 driver to use priority masking
>   if required by the architecture
> 
> * Patches 21 to 23 make arm64 code use ICC_PMR_EL1 to enable/disable
>   interrupts, leaving PSR.I as often as possible
> 
> * Patches 24 to 27 add the support for NMIs to GICv3 driver
> 
> 
> Changes since V4[4]:
> * Rebased to v4.19-rc1
> * Adapted GIC driver to the core NMI API
> * Added option to disable priority masking on command line
> * Added Daniel's Tested-by on patches related replacing PSR.I toggling with
>   PMR masking
> * Fix scope matching for alternative features.
> * Spotted some more places using PSR.I or daif and replaced with generic
>   interrupt functions
> 
> Changes since V3[5]:
> * Big refactoring. As suggested by Marc Z., some of the bigger patches
>   needed to be split into smaller one.
> * Try to reduce the amount of #ifdef for the new feature by introducing
>   an individual cpufeature for priority masking
> * Do not track which alternatives have been applied (was a bit dodgy
>   anyway), and use an alternative for VHE cpu_enable callback
> * Fix a build failure with arm by adding the correct RPR accessors
> * Added Suggested-by tags for changes from comming or inspired by Daniel's
>   series. Do let me know if you feel I missed something and am not giving
>   you due credit.
> 
> Changes since V2[6]:
> * Series rebase to v4.17-rc6
> * Adapt pathces 1 and 2 to the rework of cpufeatures framework
> * Use the group0 detection scheme in the GICv3 driver to identify
>   the priority view, and drop the use of a fake interrupt
> * Add the case for a GIC configured in a single security state
> * Use local_daif_restore instead of local_irq_enable the first time
>   we enable interrupts after a bp hardening in the handling of a kernel
>   entry. Otherwise PRS.I remains set...
> 
> Changes since V1[7]:
> * Series rebased to v4.15-rc8.
> * Check for arm64_early_features in this_cpu_has_cap (spotted by Suzuki).
> * Fix issue where debug exception were not masked when enabling debug in
>   mdscr_el1.
> 
> Changes since RFC[8]:
> * The series was rebased to v4.15-rc2 which implied some changes mainly
>   related to the work on exception entries and daif flags by James Morse.
>   - The first patch in the previous series was dropped because no longer
>     applicable.
>   - With the semantics James introduced of "inheriting" daif flags,
>     handling of PMR on exception entry is simplified as PMR is not altered
>     by taking an exception and already inherited from previous state.
>   - James pointed out that taking a PseudoNMI before reading the FAR_EL1
>     register should not be allowed as per the TRM (D10.2.29):
>     "FAR_EL1 is made UNKNOWN on an exception return from EL1."
>     So in this submission PSR.I bit is cleared only after FAR_EL1 is read.
> * For KVM, only deal with PMR unmasking/restoring in common code, and VHE
>   specific code makes sure PSR.I bit is set when necessary.
> * When detecting the GIC priority view (patch 5), wait for an actual
>   interrupt instead of trying only once.
> 
> 
> [1] http://www.spinics.net/lists/arm-kernel/msg525077.html
> [2] https://lkml.org/lkml/2018/8/28/661
> [3] https://lkml.org/lkml/2018/7/20/803
> [4] https://lkml.org/lkml/2018/7/24/321
> [5] https://lkml.org/lkml/2018/5/21/276
> [6] https://lkml.org/lkml/2018/1/17/335
> [7] https://www.spinics.net/lists/arm-kernel/msg620763.html
> [8] https://www.spinics.net/lists/arm-kernel/msg610736.html
> 
> Cheers,
> 
> Julien
> 
> -->
> 
> Daniel Thompson (1):
>   arm64: alternative: Apply alternatives early in boot process
> 
> Julien Thierry (26):
>   arm64: cpufeature: Set SYSREG_GIC_CPUIF as a boot system feature
>   arm64: cpufeature: Use alternatives for VHE cpu_enable
>   arm64: daifflags: Use irqflags functions for daifflags
>   arm64: Use daifflag_restore after bp_hardening
>   arm64: Delay daif masking for user return
>   arm64: xen: Use existing helper to check interrupt status
>   irqchip/gic: Unify GIC priority definitions
>   irqchip/gic: Lower priority of GIC interrupts
>   arm64: cpufeature: Add cpufeature for IRQ priority masking
>   arm64: Make PMR part of task context
>   arm64: Unmask PMR before going idle
>   arm/arm64: gic-v3: Add helper functions to manage IRQ priorities
>   arm64: kvm: Unmask PMR before entering guest
>   arm64: irqflags: Use ICC_PMR_EL1 for interrupt masking
>   arm64: daifflags: Include PMR in daifflags restore operations
>   irqchip/gic-v3: Factor group0 detection into functions
>   irqchip/gic-v3: Do not overwrite PMR value
>   irqchip/gic-v3: Remove acknowledge loop
>   irqchip/gic-v3: Switch to PMR masking after IRQ acknowledge
>   arm64: Switch to PMR masking when starting CPUs
>   arm64: Add build option for IRQ masking via priority
>   arm64: Handle serror in NMI context
>   irqchip/gic-v3: Detect current view of GIC priorities
>   irqchip/gic-v3: Add base support for pseudo-NMI
>   irqchip/gic: Add functions to access irq priorities
>   irqchip/gic-v3: Allow interrupts to be set as pseudo-NMI
> 
>  Documentation/admin-guide/kernel-parameters.txt |   3 +
>  Documentation/arm64/booting.txt                 |   5 +
>  arch/arm/include/asm/arch_gicv3.h               |  33 +++
>  arch/arm64/Kconfig                              |  15 ++
>  arch/arm64/include/asm/alternative.h            |   3 +-
>  arch/arm64/include/asm/arch_gicv3.h             |  33 +++
>  arch/arm64/include/asm/assembler.h              |  17 +-
>  arch/arm64/include/asm/cpucaps.h                |   3 +-
>  arch/arm64/include/asm/cpufeature.h             |   2 +
>  arch/arm64/include/asm/daifflags.h              |  29 ++-
>  arch/arm64/include/asm/efi.h                    |   3 +-
>  arch/arm64/include/asm/irqflags.h               | 100 +++++++--
>  arch/arm64/include/asm/kvm_host.h               |  12 +
>  arch/arm64/include/asm/processor.h              |   1 +
>  arch/arm64/include/asm/ptrace.h                 |  13 +-
>  arch/arm64/include/asm/xen/events.h             |   2 +-
>  arch/arm64/kernel/alternative.c                 |  28 ++-
>  arch/arm64/kernel/asm-offsets.c                 |   1 +
>  arch/arm64/kernel/cpufeature.c                  |  51 ++++-
>  arch/arm64/kernel/entry.S                       |  63 +++++-
>  arch/arm64/kernel/head.S                        |  35 +++
>  arch/arm64/kernel/process.c                     |   2 +
>  arch/arm64/kernel/smp.c                         |  12 +
>  arch/arm64/kernel/traps.c                       |   8 +-
>  arch/arm64/kvm/hyp/switch.c                     |  17 ++
>  arch/arm64/mm/fault.c                           |   5 +-
>  arch/arm64/mm/proc.S                            |  18 ++
>  drivers/irqchip/irq-gic-common.c                |  10 +
>  drivers/irqchip/irq-gic-common.h                |   2 +
>  drivers/irqchip/irq-gic-v3-its.c                |   2 +-
>  drivers/irqchip/irq-gic-v3.c                    | 279 +++++++++++++++++++-----
>  include/linux/irqchip/arm-gic-common.h          |   6 +
>  include/linux/irqchip/arm-gic.h                 |   5 -
>  33 files changed, 699 insertions(+), 119 deletions(-)
> 
> --
> 1.9.1
