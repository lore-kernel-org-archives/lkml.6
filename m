Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2C1ECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 20:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FE522083A
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 20:43:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FE522083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbeIOB7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 21:59:39 -0400
Received: from mga06.intel.com ([134.134.136.31]:8694 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727128AbeIOB7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 21:59:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Sep 2018 13:43:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,374,1531810800"; 
   d="scan'208";a="70937186"
Received: from 2b52.sc.intel.com ([143.183.136.51])
  by fmsmga008.fm.intel.com with ESMTP; 14 Sep 2018 13:43:32 -0700
Message-ID: <1536957543.12990.9.camel@intel.com>
Subject: Re: [RFC PATCH v3 12/24] x86/mm: Modify ptep_set_wrprotect and
 pmdp_set_wrprotect for _PAGE_DIRTY_SW
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Jann Horn <jannh@google.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Florian Weimer <fweimer@redhat.com>, hjl.tools@gmail.com,
        Jonathan Corbet <corbet@lwn.net>, keescook@chromium.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        ravi.v.shankar@intel.com, vedvyas.shanbhogue@intel.com
Date:   Fri, 14 Sep 2018 13:39:03 -0700
In-Reply-To: <20180831162920.GQ24124@hirez.programming.kicks-ass.net>
References: <1535660494.28258.36.camel@intel.com>
         <CAG48ez0yOuDhqxB779aO3Kss3gQ3cZTJL1VphDXQm+_M9jFPvQ@mail.gmail.com>
         <1535662366.28781.6.camel@intel.com>
         <CAG48ez0mkr95_TbLQnDGuGUd6G+eJVLZ-fEjDkwA6dSrm+9tLw@mail.gmail.com>
         <CAG48ez3S3+DzAyo_SnoUW1GO0Cpd_x0A83MOx2p_MkogoAatLQ@mail.gmail.com>
         <20180831095300.GF24124@hirez.programming.kicks-ass.net>
         <1535726032.32537.0.camel@intel.com>
         <f5a36e32-7c5f-91fe-9e98-fb44867fda11@linux.intel.com>
         <1535730524.501.13.camel@intel.com>
         <6d31bd30-6d5b-bbde-1e97-1d8255eff76d@linux.intel.com>
         <20180831162920.GQ24124@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-08-31 at 18:29 +0200, Peter Zijlstra wrote:
> On Fri, Aug 31, 2018 at 08:58:39AM -0700, Dave Hansen wrote:
> > 
> > On 08/31/2018 08:48 AM, Yu-cheng Yu wrote:
> > > 
> > > To trigger a race in ptep_set_wrprotect(), we need to fork from one of
> > > three pthread siblings.
> > > 
> > > Or do we measure only how much this affects fork?
> > > If there is no racing, the effect should be minimal.
> > We don't need a race.
> > 
> > I think the cmpxchg will be slower, even without a race, than the code
> > that was there before.  The cmpxchg is a simple, straightforward
> > solution, but we're putting it in place of a plain memory write, which
> > is suboptimal.
> Note quite, the clear_bit() is LOCK prefixed.

With the updated ptep_set_wrprotect() below, I did MADV_WILLNEED to a shadow
stack of 8 MB, then 10,000 fork()'s, but could not prove it is more or less
efficient than the other.  So can we say this is probably fine in terms of
efficiency?

Yu-cheng




--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1203,7 +1203,36 @@ static inline pte_t ptep_get_and_clear_full(struct
mm_struct *mm,
 static inline void ptep_set_wrprotect(struct mm_struct *mm,
 				      unsigned long addr, pte_t *ptep)
 {
+#ifdef CONFIG_X86_INTEL_SHADOW_STACK_USER
+	pte_t new_pte, pte = READ_ONCE(*ptep);
+
+	/*
+	 * Some processors can start a write, but end up
+	 * seeing a read-only PTE by the time they get
+	 * to the Dirty bit.  In this case, they will
+	 * set the Dirty bit, leaving a read-only, Dirty
+	 * PTE which looks like a Shadow Stack PTE.
+	 *
+	 * However, this behavior has been improved and
+	 * will not occur on processors supporting
+	 * Shadow Stacks.  Without this guarantee, a
+	 * transition to a non-present PTE and flush the
+	 * TLB would be needed.
+	 *
+	 * When changing a writable PTE to read-only and
+	 * if the PTE has _PAGE_DIRTY_HW set, we move
+	 * that bit to _PAGE_DIRTY_SW so that the PTE is
+	 * not a valid Shadow Stack PTE.
+	 */
+	do {
+		new_pte = pte_wrprotect(pte);
+		new_pte.pte |= (new_pte.pte & _PAGE_DIRTY_HW) >>
+				_PAGE_BIT_DIRTY_HW << _PAGE_BIT_DIRTY_SW;
+		new_pte.pte &= ~_PAGE_DIRTY_HW;
+	} while (!try_cmpxchg(ptep, &pte, new_pte));
+#else
 	clear_bit(_PAGE_BIT_RW, (unsigned long *)&ptep->pte);
+#endif
 }
