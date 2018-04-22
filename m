Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753476AbeDVTGt (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 15:06:49 -0400
Received: from foss.arm.com ([217.140.101.70]:33886 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753417AbeDVTGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 15:06:47 -0400
Date: Sun, 22 Apr 2018 20:06:39 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Jan Kiszka <jan.kiszka@web.de>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        will.deacon@arm.com, catalin.marinas@arm.com, suzuki.poulose@arm.com
Subject: Re: BUG: KASAN: global-out-of-bounds in
 unmap_kernel_at_el0+0x70/0x1a0
Message-ID: <20180422190639.lyfvgnzapo2mrpu6@salmiak>
References: <97d99ad9-c5cf-a4d2-126a-2b39ffead0b3@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97d99ad9-c5cf-a4d2-126a-2b39ffead0b3@web.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 22, 2018 at 12:47:57PM +0200, Jan Kiszka wrote:
> Hi,
> 
> this can be triggered simply by running
> 
> # echo 0 > /sys/devices/system/cpu/cpu3/online
> # echo 1 > /sys/devices/system/cpu/cpu3/online
> 
> [  455.904854] ==================================================================
> [  455.906108] BUG: KASAN: global-out-of-bounds in unmap_kernel_at_el0+0x70/0x1a0
> [  455.906668] Read of size 4 at addr ffff200008e3a9d8 by task swapper/3/0

It looks like we miss a sentinel in kpti_safe_list.

Does the below help?

Mark.

---->8----
>From ade322407e3d6d1f50e558ebd50d2c1c7bd811c2 Mon Sep 17 00:00:00 2001
From: Mark Rutland <mark.rutland@arm.com>
Date: Sun, 22 Apr 2018 19:58:08 +0100
Subject: [PATCH] arm64: add sentinel to kpti_safe_list

We're missing a sentinel entry in kpti_safe_list. Thus is_midr_in_range_list()
can walk past the end of kpti_safe_list. Depending on the contents of memory,
this could erroneously match a CPU's MIDR, cause a data abort, or other bad
outcomes.

Add the sentinel entry to avoid this.

Fixes: be5b299830c63ed7 ("arm64: capabilities: Add support for checks based on a list of MIDRs")
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reported-by: Jan Kiszka <jan.kiszka@web.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/cpufeature.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 536d572e5596..9d1b06d67c53 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -868,6 +868,7 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
 	static const struct midr_range kpti_safe_list[] = {
 		MIDR_ALL_VERSIONS(MIDR_CAVIUM_THUNDERX2),
 		MIDR_ALL_VERSIONS(MIDR_BRCM_VULCAN),
+		{ /* sentinel */ }
 	};
 	char const *str = "command line option";
 
-- 
2.11.0
