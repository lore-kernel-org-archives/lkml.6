Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28EF0C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF7ED20C0C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:14:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF7ED20C0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387781AbeGKQTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 12:19:51 -0400
Received: from mga03.intel.com ([134.134.136.65]:16374 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726457AbeGKQTv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 12:19:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jul 2018 09:14:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,338,1526367600"; 
   d="scan'208";a="70522785"
Received: from 2b52.sc.intel.com ([143.183.136.52])
  by fmsmga004.fm.intel.com with ESMTP; 11 Jul 2018 09:14:40 -0700
Message-ID: <1531325463.13297.30.camel@intel.com>
Subject: Re: [RFC PATCH v2 14/27] mm: Handle THP/HugeTLB shadow stack page
 fault
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromiun.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Date:   Wed, 11 Jul 2018 09:11:03 -0700
In-Reply-To: <20180711091022.GT2476@hirez.programming.kicks-ass.net>
References: <20180710222639.8241-1-yu-cheng.yu@intel.com>
         <20180710222639.8241-15-yu-cheng.yu@intel.com>
         <20180711091022.GT2476@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-07-11 at 11:10 +0200, Peter Zijlstra wrote:
> On Tue, Jul 10, 2018 at 03:26:26PM -0700, Yu-cheng Yu wrote:
> > 
> > diff --git a/mm/memory.c b/mm/memory.c
> > index a2695dbc0418..f7c46d61eaea 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -4108,7 +4108,13 @@ static int __handle_mm_fault(struct
> > vm_area_struct *vma, unsigned long address,
> >  			if (pmd_protnone(orig_pmd) &&
> > vma_is_accessible(vma))
> >  				return do_huge_pmd_numa_page(&vmf,
> > orig_pmd);
> >  
> > -			if (dirty && !pmd_write(orig_pmd)) {
> > +			/*
> > +			 * Shadow stack trans huge PMDs are copy-
> > on-access,
> > +			 * so wp_huge_pmd() on them no mater if we
> > have a
> > +			 * write fault or not.
> > +			 */
> > +			if (is_shstk_mapping(vma->vm_flags) ||
> > +			    (dirty && !pmd_write(orig_pmd))) {
> >  				ret = wp_huge_pmd(&vmf, orig_pmd);
> >  				if (!(ret & VM_FAULT_FALLBACK))
> >  					return ret;
> Can't we do this (and the do_wp_page thing) by setting
> FAULT_FLAG_WRITE
> in the arch fault handler on shadow stack faults?

This can work.  I don't know if that will create other issues.
Let me think about that.

Yu-cheng
