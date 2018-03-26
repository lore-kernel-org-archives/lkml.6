Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751776AbeCZTgS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 15:36:18 -0400
Received: from mail.skyhub.de ([5.9.137.197]:36996 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751124AbeCZTgR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 15:36:17 -0400
Date: Mon, 26 Mar 2018 21:35:26 +0200
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <Yazen.Ghannam@amd.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, x86@kernel.org
Subject: Re: [PATCH 2/2] x86/MCE: Always save MCA_{ADDR,MISC,SYND} register
 contents
Message-ID: <20180326193526.GK25548@pd.tnic>
References: <20180326191526.64314-1-Yazen.Ghannam@amd.com>
 <20180326191526.64314-2-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180326191526.64314-2-Yazen.Ghannam@amd.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 26, 2018 at 02:15:26PM -0500, Yazen Ghannam wrote:
> From: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> The Intel SDM and AMD APM both state that the contents of the MCA_ADDR
> register should be saved if MCA_STATUS[ADDRV] is set. The same applies
> to MCA_MISC and MCA_SYND (on SMCA systems) and their respective valid
> bits.
> 
> However, the Fam17h Processor Programming Reference states
> "Error handlers should save the values in MCA_ADDR, MCA_MISC0, and
> MCA_SYND even if MCA_STATUS[AddrV], MCA_STATUS[MiscV], and
> MCA_STATUS[SyndV] are zero."

Well, then you can't remove valid bit checks for older families. This
sounds like F17h only.

If so, it better be abstracted away cleanly and not changing the generic
code.

> 
> This is to ensure that all MCA state information is collected even if
> software cannot act upon it (because the valid bits are cleared).
> 
> So always save the auxiliary MCA register contents even if the valid
> bits are cleared. This should not affect error processing because
> software should still check the valid bits before using the register
> contents for error processing.
> 
> Also, print MCA_{ADDR,MISC,SYND} even if their valid bits are not set.
> Printing from EDAC/mce_amd is included here since we want to do this on
> AMD systems.
> 
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
>  arch/x86/kernel/cpu/mcheck/mce.c     | 23 +++++++----------------
>  arch/x86/kernel/cpu/mcheck/mce_amd.c | 10 +++-------
>  drivers/edac/mce_amd.c               | 10 +++-------
>  3 files changed, 13 insertions(+), 30 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
> index 42cf2880d0ed..a556e1cadfbc 100644
> --- a/arch/x86/kernel/cpu/mcheck/mce.c
> +++ b/arch/x86/kernel/cpu/mcheck/mce.c
> @@ -248,19 +248,14 @@ static void __print_mce(struct mce *m)
>  	}
>  
>  	pr_emerg(HW_ERR "TSC %llx ", m->tsc);
> -	if (m->addr)
> -		pr_cont("ADDR %llx ", m->addr);
> -	if (m->misc)
> -		pr_cont("MISC %llx ", m->misc);
> +	pr_cont("ADDR %016llx ", m->addr);
> +	pr_cont("MISC %016llx\n", m->misc);

You simply can't do this - this is generic code, not AMD only.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
