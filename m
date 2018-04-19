Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753805AbeDSO6g (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 10:58:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:47043 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752900AbeDSO6e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 10:58:34 -0400
Date: Thu, 19 Apr 2018 16:58:32 +0200
From: Michal Kubecek <mkubecek@suse.cz>
To: Joerg Roedel <joro@8bytes.org>
Cc: Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <jroedel@suse.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] x86/ldt: Fix support_pte_mask filtering in
 map_ldt_struct()
Message-ID: <20180419145832.5mq3va53swswajmu@unicorn.suse.cz>
References: <1523871837-8378-1-git-send-email-joro@8bytes.org>
 <CALCETrVgQspiO3nnyhqiXi17iaGG7bRDsr3gpHwdDnYfFDZabQ@mail.gmail.com>
 <07e2c23e-10b7-b03f-5706-3d4b910537ba@linux.intel.com>
 <20180418121403.GA3434@pd.tnic>
 <20180419130011.GG3896@pd.tnic>
 <20180419141134.GI15462@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180419141134.GI15462@8bytes.org>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 04:11:34PM +0200, Joerg Roedel wrote:
> On Thu, Apr 19, 2018 at 03:00:11PM +0200, Borislav Petkov wrote:
> > fb43d6cb91ef x86/mm: Do not auto-massage page protections <--- NOT OK
> 
> Hmm, that hunk from above patch looks suspicious:
> 
> -               set_pgd(pgd + pgd_index(restore_jump_address), __pgd(__pa(pud) | _KERNPG_TABLE));
> +               pgd_t new_pgd = __pgd(__pa(p4d) | pgprot_val(pgtable_prot));
> +               set_pgd(pgd + pgd_index(restore_jump_address), new_pgd);
> 
> The old code used __pa(pud) while the new one uses __pa(p4d).
> 
> Boris, can you change that back to __pa(pud) and test please?

I had the same problem with v4.17-rc1 and fb43d6cb91ef and the change
you suggested applied on top of

  (a) fb43d6cb91ef with cherry-picked e6f39e87b643
  (b) current master (87ef12027b9b)

fixes the resume on my system.

Michal Kubecek
