Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754115AbeC1Pyl (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 11:54:41 -0400
Received: from foss.arm.com ([217.140.101.70]:46092 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753816AbeC1Pyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 11:54:40 -0400
Date: Wed, 28 Mar 2018 16:54:33 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Michel Pollet <michel.pollet@bp.renesas.com>
Cc: open list <linux-kernel@vger.kernel.org>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Will Deacon <will.deacon@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "buserror@gmail.com" <buserror@gmail.com>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: arm/arm64: smp_spin_table.c for arm32?
Message-ID: <20180328155432.znx2w2xfa3aflccs@armageddon.cambridge.arm.com>
References: <OSBPR01MB2054DFD1BEECD87186E29E51D2A30@OSBPR01MB2054.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OSBPR01MB2054DFD1BEECD87186E29E51D2A30@OSBPR01MB2054.jpnprd01.prod.outlook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 28, 2018 at 08:12:50AM +0000, Michel Pollet wrote:
> I'm currently adapting a port from a machine-file based approach to driver based, and I
> would have a need for arch/arm64/kernel/smp_spin_table.c -- it's *exactly* my use
> case, but for arm32.
> So what would be my options here?
> 
> 1) Make myself a custom driver and ignore this one...
> 2) Fully duplicate smp_spin_table.c in arch/arm/kernel...
> 3) .... something else involving a shared bit of code?

There will be some small differences between the two like writeq() vs
writel(). My advice:

4) Use PSCI, already available in arch/arm/kernel/psci_smp.c

Otherwise, if you do need a spin table, duplicating is probably the
easiest, especially since you need a .S counterpart, but you'd need to
keep the arch/arm/mach-* directory. Also see this thread (and maybe
others):

https://lkml.org/lkml/2014/3/28/458

As long as booting is not standardised for your SoC, I don't think you'd
be able to move everything into drivers/.

On arm64, we only keep the pen release mechanism for XGene as they don't
have EL3 and cannot implement PSCI. All other platforms use PSCI (at
least those supported upstream).

-- 
Catalin
