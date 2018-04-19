Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753842AbeDSOLi (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 10:11:38 -0400
Received: from 8bytes.org ([81.169.241.247]:48532 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753750AbeDSOLg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 10:11:36 -0400
Date: Thu, 19 Apr 2018 16:11:34 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Borislav Petkov <bp@suse.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <jroedel@suse.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] x86/ldt: Fix support_pte_mask filtering in
 map_ldt_struct()
Message-ID: <20180419141134.GI15462@8bytes.org>
References: <1523871837-8378-1-git-send-email-joro@8bytes.org>
 <CALCETrVgQspiO3nnyhqiXi17iaGG7bRDsr3gpHwdDnYfFDZabQ@mail.gmail.com>
 <07e2c23e-10b7-b03f-5706-3d4b910537ba@linux.intel.com>
 <20180418121403.GA3434@pd.tnic>
 <20180419130011.GG3896@pd.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180419130011.GG3896@pd.tnic>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 03:00:11PM +0200, Borislav Petkov wrote:
> fb43d6cb91ef x86/mm: Do not auto-massage page protections <--- NOT OK

Hmm, that hunk from above patch looks suspicious:

-               set_pgd(pgd + pgd_index(restore_jump_address), __pgd(__pa(pud) | _KERNPG_TABLE));
+               pgd_t new_pgd = __pgd(__pa(p4d) | pgprot_val(pgtable_prot));
+               set_pgd(pgd + pgd_index(restore_jump_address), new_pgd);

The old code used __pa(pud) while the new one uses __pa(p4d).

Boris, can you change that back to __pa(pud) and test please?


Thanks,

	Joerg
