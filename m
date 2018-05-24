Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034099AbeEXRGV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 13:06:21 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:59626 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033609AbeEXRGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 13:06:18 -0400
Date: Thu, 24 May 2018 18:06:05 +0100
From: "Maciej W. Rozycki" <macro@mips.com>
To: Paul Burton <paul.burton@mips.com>
CC: James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
Subject: Re: [PATCH] MIPS: prctl: Disallow FRE without FR with PR_SET_FP_MODE
 requests
In-Reply-To: <20180524163617.dts46enhigc2yjfo@pburton-laptop>
Message-ID: <alpine.DEB.2.00.1805241757321.10896@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1805141439290.10896@tp.orcam.me.uk> <20180524163617.dts46enhigc2yjfo@pburton-laptop>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.188]
X-ClientProxiedBy: mipsdag02.mipstec.com (10.20.40.47) To
 mipsdag02.mipstec.com (10.20.40.47)
X-BESS-ID: 1527181573-321457-30576-10480-1
X-BESS-VER: 2018.6-r1805181819
X-BESS-Apparent-Source-IP: 12.201.5.32
X-BESS-Outbound-Spam-Score: 0.01
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.193318
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound
        0.01 BSF_SC0_SA_TO_FROM_DOMAIN_MATCH META: Sender Domain Matches Recipient Domain
X-BESS-Outbound-Spam-Status: SCORE=0.01 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_SC0_SA_TO_FROM_DOMAIN_MATCH
X-BESS-BRTS-Status: 1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

> > Having PR_FP_MODE_FRE (i.e. Config5.FRE) set without PR_FP_MODE_FR (i.e. 
> > Status.FR) is not supported as the lone purpose of Config5.FRE is to 
> > emulate Status.FR=0 handling on FPU hardware that has Status.FR=1 
> > hardwired[1][2].  Also we do not handle this case elsewhere, and assume 
> > throughout our code that TIF_HYBRID_FPREGS and TIF_32BIT_FPREGS cannot 
> > be set both at once for a task, leading to inconsistent behaviour if 
> > this does happen.
> 
> Reviewing the code I think we should actually end up with FR=1 in this
> case, because neither __own_fpu() nor the FPU emulator depend on the
> value of TIF_32BIT_FPREGS if TIF_HYBRID_FPREGS is set. So it's not too
> awful & I don't see the kernel doing anything too crazy, but it
> definitely isn't what the user asked for.

 However `arch_ptrace' does check TIF_32BIT_FPREGS and gets things wrong 
if TIF_HYBRID_FPREGS is also set.  Which is actually how I discovered 
this issue.

> > Return unsuccessfully then from prctl(2) PR_SET_FP_MODE calls requesting 
> > PR_FP_MODE_FRE to be set with PR_FP_MODE_FR clear.  This corresponds to 
> > modes allowed by `mips_set_personality_fp'.
> 
> Looks good to me:
> 
>   Reviewed-by: Paul Burton <paul.burton@mips.com>

 Thanks for your review.

  Maciej
