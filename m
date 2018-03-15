Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752788AbeCOPKr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 11:10:47 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40820 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751502AbeCOPKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 11:10:46 -0400
Date: Thu, 15 Mar 2018 15:10:42 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Borislav Petkov <bp@alien8.de>
Cc: York Sun <york.sun@nxp.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/2] drivers/edac: Add L1 and L2 error detection for
 A53 and A57
Message-ID: <20180315151042.ikmjg67s6te5ov4x@lakrids.cambridge.arm.com>
References: <1521073067-24348-1-git-send-email-york.sun@nxp.com>
 <20180315010728.GF11061@pd.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180315010728.GF11061@pd.tnic>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 02:07:28AM +0100, Borislav Petkov wrote:
> On Wed, Mar 14, 2018 at 05:17:46PM -0700, York Sun wrote:
> > Add error detection for A53 and A57 cores. Hardware error injection
> > is supported on A53. Software error injection is supported on both.
> > For hardware error injection on A53 to work, proper access to
> > L2ACTLR_EL1, CPUACTLR_EL1 needs to be granted by EL3 firmware. This
> > is done by making an SMC call in the driver. Failure to enable access
> > disables hardware error injection. For error interrupt to work,
> > another SMC call enables access to L2ECTLR_EL1. Failure to enable
> > access disables interrupt for error reporting.
> > 
> > Signed-off-by: York Sun <york.sun@nxp.com>
> > ---
> >  .../devicetree/bindings/edac/cortex-arm64-edac.txt |  37 +
> >  arch/arm64/include/asm/cacheflush.h                |   1 +
> >  arch/arm64/mm/cache.S                              |  35 +
> >  drivers/edac/Kconfig                               |   6 +
> >  drivers/edac/Makefile                              |   1 +
> >  drivers/edac/cortex_arm64_l1_l2.c                  | 741 +++++++++++++++++++++
> 
> I don't want per-functional unit EDAC drivers. Also, what happened to
> talking to ARM people about designing a generic ARM64 EDAC driver?

Practically speaking, a generic drivers is only possible on ARMv8.2
parts where RAS functionality is architected.

On other parts, it's IMPLEMENTATION DEFINED, and varies wildly between
CPU implementations, even if they sometimes look deceptively similar at
first glance...

This driver is certainly not generic, and is specific to Cortex-A53 and
Cortex-A57 as integrated by NXP (since it relies on NXP-specific
firmware interfaces).

Thanks,
Mark.
