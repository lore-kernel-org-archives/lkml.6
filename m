Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752122AbeENDWK convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 23:22:10 -0400
Received: from ozlabs.org ([203.11.71.1]:58435 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751953AbeENDWJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 23:22:09 -0400
Message-ID: <1526268127.30369.21.camel@neuling.org>
Subject: Re: [PATCH 2/2] powerpc: Enable ASYM_SMT on interleaved big-core
 systems
From: Michael Neuling <mikey@neuling.org>
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
        Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
        Balbir Singh <bsingharora@gmail.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Mon, 14 May 2018 13:22:07 +1000
In-Reply-To: <1526037444-22876-3-git-send-email-ego@linux.vnet.ibm.com>
References: <1526037444-22876-1-git-send-email-ego@linux.vnet.ibm.com>
         <1526037444-22876-3-git-send-email-ego@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-05-11 at 16:47 +0530, Gautham R. Shenoy wrote:
> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> 
> Each of the SMT4 cores forming a fused-core are more or less
> independent units. Thus when multiple tasks are scheduled to run on
> the fused core, we get the best performance when the tasks are spread
> across the pair of SMT4 cores.
> 
> Since the threads in the pair of SMT4 cores of an interleaved big-core
> are numbered {0,2,4,6} and {1,3,5,7} respectively, enable ASYM_SMT on
> such interleaved big-cores that will bias the load-balancing of tasks
> on smaller numbered threads, which will automatically result in
> spreading the tasks uniformly across the associated pair of SMT4
> cores.
> 
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/smp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index 9ca7148..0153f01 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -1082,7 +1082,7 @@ static int powerpc_smt_flags(void)
>  {
>  	int flags = SD_SHARE_CPUCAPACITY | SD_SHARE_PKG_RESOURCES;
>  
> -	if (cpu_has_feature(CPU_FTR_ASYM_SMT)) {
> +	if (cpu_has_feature(CPU_FTR_ASYM_SMT) || has_interleaved_big_core) {

Shouldn't we just set CPU_FTR_ASYM_SMT and leave this code unchanged?


>  		printk_once(KERN_INFO "Enabling Asymmetric SMT
> scheduling\n");
>  		flags |= SD_ASYM_PACKING;
>  	}
