Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753048AbeDSTWn (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 15:22:43 -0400
Received: from mga06.intel.com ([134.134.136.31]:43005 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751194AbeDSTWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 15:22:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,297,1520924400";
   d="scan'208";a="35571292"
Subject: Re: [PATCH] x86/ldt: Fix support_pte_mask filtering in
 map_ldt_struct()
To: Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@suse.de>
References: <1523871837-8378-1-git-send-email-joro@8bytes.org>
 <CALCETrVgQspiO3nnyhqiXi17iaGG7bRDsr3gpHwdDnYfFDZabQ@mail.gmail.com>
 <07e2c23e-10b7-b03f-5706-3d4b910537ba@linux.intel.com>
 <20180418121403.GA3434@pd.tnic> <20180419130011.GG3896@pd.tnic>
 <20180419141134.GI15462@8bytes.org>
Cc: Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <jroedel@suse.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <a47fd151-a691-6b11-597e-aad1f646fdef@linux.intel.com>
Date: Thu, 19 Apr 2018 12:22:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180419141134.GI15462@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/19/2018 07:11 AM, Joerg Roedel wrote:
> On Thu, Apr 19, 2018 at 03:00:11PM +0200, Borislav Petkov wrote:
>> fb43d6cb91ef x86/mm: Do not auto-massage page protections <--- NOT OK
> Hmm, that hunk from above patch looks suspicious:
> 
> -               set_pgd(pgd + pgd_index(restore_jump_address), __pgd(__pa(pud) | _KERNPG_TABLE));
> +               pgd_t new_pgd = __pgd(__pa(p4d) | pgprot_val(pgtable_prot));
> +               set_pgd(pgd + pgd_index(restore_jump_address), new_pgd);
> 
> The old code used __pa(pud) while the new one uses __pa(p4d).
> 
> Boris, can you change that back to __pa(pud) and test please?

That does look like the culprit.  I probably copy/pasted the p4d line
from above and missed that 'p4d' when converting it to pud.

Thanks for finding this, guys.
