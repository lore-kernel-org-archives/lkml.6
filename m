Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753238AbeDSS2q (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 14:28:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:34190 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752667AbeDSS2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 14:28:45 -0400
Date: Thu, 19 Apr 2018 20:28:40 +0200
From: Joerg Roedel <jroedel@suse.de>
To: Joerg Roedel <joro@8bytes.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        rjw@rjwysocki.net, pavel@ucw.cz, hpa@zytor.com,
        Michal Kubecek <mkubecek@suse.cz>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH] x86/power/64: Fix page-table setup for temporary text
 mapping
Message-ID: <20180419182840.mfl64py7pnbudruc@suse.de>
References: <1524162360-26179-1-git-send-email-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524162360-26179-1-git-send-email-joro@8bytes.org>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Dave Hansen to Cc, forgot that in the initial post.

On Thu, Apr 19, 2018 at 08:26:00PM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> When we have a 4-level page-table there is no p4d, so we map
> the pud in the pgd. The old code before commit fb43d6cb91ef
> already did that.
> 
> With the change from above commit we end up with an invalid
> page-table which causes undefined behavior. In one report it
> caused triple faults.
> 
> Fix it by changing the p4d back to pud so that we have a
> correct page-table.
> 
> Reported-by: Borislav Petkov <bp@suse.de>
> Fixes: fb43d6cb91ef ('x86/mm: Do not auto-massage page protections')
> Tested-by: Michal Kubecek <mkubecek@suse.cz>
> Tested-by: Borislav Petkov <bp@suse.de>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  arch/x86/power/hibernate_64.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/power/hibernate_64.c b/arch/x86/power/hibernate_64.c
> index 48b14b534897..ccf4a49bb065 100644
> --- a/arch/x86/power/hibernate_64.c
> +++ b/arch/x86/power/hibernate_64.c
> @@ -98,7 +98,7 @@ static int set_up_temporary_text_mapping(pgd_t *pgd)
>  		set_pgd(pgd + pgd_index(restore_jump_address), new_pgd);
>  	} else {
>  		/* No p4d for 4-level paging: point the pgd to the pud page table */
> -		pgd_t new_pgd = __pgd(__pa(p4d) | pgprot_val(pgtable_prot));
> +		pgd_t new_pgd = __pgd(__pa(pud) | pgprot_val(pgtable_prot));
>  		set_pgd(pgd + pgd_index(restore_jump_address), new_pgd);
>  	}
>  
> -- 
> 2.13.6
