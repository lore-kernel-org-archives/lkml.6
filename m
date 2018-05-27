Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032603AbeE0DpI (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 23:45:08 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:46286 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032558AbeE0DpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 23:45:07 -0400
Date: Sat, 26 May 2018 20:45:03 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Michael Ellerman <michael@ellerman.id.au>
Cc: Michael Neuling <mikey@neuling.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/64s: Clear PCR on boot
Message-ID: <20180527034503.GA31985@roeck-us.net>
References: <20180525133308.GA17443@roeck-us.net>
 <31148B04-5AA9-4F4F-BD34-CD9665F7F6D6@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31148B04-5AA9-4F4F-BD34-CD9665F7F6D6@ellerman.id.au>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On Sun, May 27, 2018 at 12:22:23PM +1000, Michael Ellerman wrote:
> 
> 
> On 25 May 2018 11:33:08 pm AEST, Guenter Roeck <linux@roeck-us.net> wrote:
> >On Fri, May 18, 2018 at 11:37:42AM +1000, Michael Neuling wrote:
> >> Clear the PCR (Processor Compatibility Register) on boot to ensure we
> >> are not running in a compatibility mode.
> >> 
> >> We've seen this cause problems when a crash (and kdump) occurs while
> >> running compat mode guests. The kdump kernel then runs with the PCR
> >> set and causes problems. The symptom in the kdump kernel (also seen
> >in
> >> petitboot after fast-reboot) is early userspace programs taking
> >> sigills on newer instructions (seen in libc).
> >> 
> >
> >Hi folks,
> >
> >this patch causes qemu to bail out with
> >
> >Trying to write privileged spr 338 (0x152) at c000000000033454
> >
> >when running it with "-M powernv -cpu POWER8" and powernv_defconfig.
> >
> >Can you confirm that this is a bug in qemu ?
> 
> Hi Guenter,
> 
> Thanks for the report. As far as I'm concerned this is a qemu bug, that register should exist on a bare metal Power8.
> 
> Will try and get you a qemu patch to fix it.
> 
I already have a patch, or at least one that does the trick for me.
Getting qemu patched was not the problem. I just want to be sure that
the problem is indeed a qemu problem.

Thanks,
Guenter

---
>From 1617bac264b4c49d817b6947611affa9b73318f6 Mon Sep 17 00:00:00 2001
From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 25 May 2018 06:38:40 -0700
Subject: [PATCH] PowerPC: Permit privileged access to SPR_PCR for POWER7+

Without this access, Linux mainline bails out.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 target/ppc/translate_init.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index 391b94b..3b09c49 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -7953,11 +7953,12 @@ static void gen_spr_power6_common(CPUPPCState *env)
 #endif
     /*
      * Register PCR to report POWERPC_EXCP_PRIV_REG instead of
-     * POWERPC_EXCP_INVAL_SPR.
+     * POWERPC_EXCP_INVAL_SPR in userspace. Permit privileged
+     * access.
      */
     spr_register(env, SPR_PCR, "PCR",
                  SPR_NOACCESS, SPR_NOACCESS,
-                 SPR_NOACCESS, SPR_NOACCESS,
+                 &spr_read_generic, &spr_write_generic,
                  0x00000000);
 }
 
-- 
2.7.4
