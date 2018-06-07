Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 78A8OvGXGVvSfgAAmS7hNA
	; Thu, 07 Jun 2018 20:39:18 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 20BFF608BA; Thu,  7 Jun 2018 20:39:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id AB24960452;
	Thu,  7 Jun 2018 20:39:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AB24960452
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932696AbeFGUjP (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 16:39:15 -0400
Received: from mga12.intel.com ([192.55.52.136]:42265 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753220AbeFGUjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 16:39:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jun 2018 13:39:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,488,1520924400";
   d="scan'208";a="46099859"
Received: from 2b52.sc.intel.com (HELO [143.183.136.51]) ([143.183.136.51])
  by fmsmga008.fm.intel.com with ESMTP; 07 Jun 2018 13:39:12 -0700
Message-ID: <1528403761.5265.37.camel@2b52.sc.intel.com>
Subject: Re: [PATCH 6/9] x86/mm: Introduce ptep_set_wrprotect_flush and
 related functions
From: Yu-cheng Yu <yu-cheng.yu@intel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@amacapital.net>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. J. Lu" <hjl.tools@gmail.com>,
        "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        mike.kravetz@oracle.com
Date: Thu, 07 Jun 2018 13:36:01 -0700
In-Reply-To: <5c39caf1-2198-3c2b-b590-8c38a525747f@linux.intel.com>
References: <20180607143705.3531-1-yu-cheng.yu@intel.com>
         <20180607143705.3531-7-yu-cheng.yu@intel.com>
         <CALCETrVa8MtxP9iqYkZLnetaQiN4UaWb=jGz1+rLsCuETHKydg@mail.gmail.com>
         <5c39caf1-2198-3c2b-b590-8c38a525747f@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-06-07 at 13:29 -0700, Dave Hansen wrote:
> On 06/07/2018 09:24 AM, Andy Lutomirski wrote:
> 
> >> +static inline void ptep_set_wrprotect_flush(struct vm_area_struct *vma,
> >> +                                           unsigned long addr, pte_t *ptep)
> >> +{
> >> +       bool rw;
> >> +
> >> +       rw = test_and_clear_bit(_PAGE_BIT_RW, (unsigned long *)&ptep->pte);
> >> +       if (IS_ENABLED(CONFIG_X86_INTEL_SHADOW_STACK_USER)) {
> >> +               struct mm_struct *mm = vma->vm_mm;
> >> +               pte_t pte;
> >> +
> >> +               if (rw && (atomic_read(&mm->mm_users) > 1))
> >> +                       pte = ptep_clear_flush(vma, addr, ptep);
> > Why are you clearing the pte?
> 
> I found my notes on the subject. :)
> 
> Here's the sequence that causes the problem.  This could happen any time
> we try to take a PTE from read-write to read-only.  P==Present, W=Write,
> D=Dirty:
> 
> CPU0 does a write, sees PTE with P=1,W=1,D=0
> CPU0 decides to set D=1
> CPU1 comes in and sets W=0
> CPU0 does locked operation to set D=1
> 	CPU0 sees P=1,W=0,D=0
> 	CPU0 sets back P=1,W=0,D=1
> CPU0 loads P=1,W=0,D=1 into the TLB
> CPU0 attempts to continue the write, but sees W=0 in the TLB and a #PF
> is generated because of the write fault.
> 
> The problem with this is that we end up with a shadowstack-PTE
> (Write=0,Dirty=1) where we didn't want one.  This, unfortunately,
> imposes extra TLB flushing overhead on the R/W->R/O transitions that
> does not exist before shadowstack enabling.
> 
> Yu-cheng, could you please add this to the patch description?

I will add that.
