Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B64C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 16:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A64F20854
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 16:46:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A64F20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbeIIVgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 17:36:23 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:34359 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbeIIVgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 17:36:22 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126] helo=xylophone)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1fz2qX-00082E-UE; Sun, 09 Sep 2018 17:46:02 +0100
Message-ID: <1536511561.3024.115.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 41/43] x86/mm/pat: Make set_memory_np() L1TF safe
From:   Ben Hutchings <ben.hutchings@codethink.co.uk>
To:     David Woodhouse <dwmw@amazon.co.uk>,
        Guenter Roeck <linux@roeck-us.net>,
        Michal Hocko <mhocko@suse.cz>
Cc:     stable@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Sun, 09 Sep 2018 17:46:01 +0100
In-Reply-To: <20180814171519.769320295@linuxfoundation.org>
References: <20180814171517.014285600@linuxfoundation.org>
         <20180814171519.769320295@linuxfoundation.org>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-08-14 at 19:18 +0200, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Andi Kleen <ak@linux.intel.com>
> 
> commit 958f79b9ee55dfaf00c8106ed1c22a2919e0028b upstream
[...]
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -378,12 +378,39 @@ static inline pmd_t pfn_pmd(unsigned lon
> >  	return __pmd(pfn | massage_pgprot(pgprot));
>  }
>  
> +static inline pud_t pfn_pud(unsigned long page_nr, pgprot_t pgprot)
> +{
> +	phys_addr_t pfn = page_nr << PAGE_SHIFT;
> +	pfn ^= protnone_mask(pgprot_val(pgprot));
> +	pfn &= PHYSICAL_PUD_PAGE_MASK;
> +	return __pud(pfn | massage_pgprot(pgprot));
> +}
[...]

This (and the backport to 4.9) are missing the fix from commit
e14d7dfb41f5 "x86/speculation/l1tf: Fix up pte->pfn conversion for
PAE", as that was applied earlier in the series.  But since PAE implies
only 3-level paging I don't know how the PUD functions get used or
whether this actually matters.

Ben.

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
