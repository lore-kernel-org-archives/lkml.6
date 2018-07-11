Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1CC2C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 17:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F77920C48
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 17:10:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F77920C48
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390098AbeGKRP5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 13:15:57 -0400
Received: from mga11.intel.com ([192.55.52.93]:42644 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388700AbeGKRP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 13:15:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jul 2018 10:10:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,338,1526367600"; 
   d="scan'208";a="56885705"
Received: from 2b52.sc.intel.com ([143.183.136.52])
  by orsmga006.jf.intel.com with ESMTP; 11 Jul 2018 10:09:08 -0700
Message-ID: <1531328731.15351.3.camel@intel.com>
Subject: Re: [RFC PATCH v2 16/27] mm: Modify can_follow_write_pte/pmd for
 shadow stack
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromiun.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Date:   Wed, 11 Jul 2018 10:05:31 -0700
In-Reply-To: <de510df6-7ea9-edc6-9c49-2f80f16472b4@linux.intel.com>
References: <20180710222639.8241-1-yu-cheng.yu@intel.com>
         <20180710222639.8241-17-yu-cheng.yu@intel.com>
         <de510df6-7ea9-edc6-9c49-2f80f16472b4@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-10 at 16:37 -0700, Dave Hansen wrote:
> On 07/10/2018 03:26 PM, Yu-cheng Yu wrote:
> > 
> > There are three possible shadow stack PTE settings:
> > 
> >   Normal SHSTK PTE: (R/O + DIRTY_HW)
> >   SHSTK PTE COW'ed: (R/O + DIRTY_HW)
> >   SHSTK PTE shared as R/O data: (R/O + DIRTY_SW)
> > 
> > Update can_follow_write_pte/pmd for the shadow stack.
> First of all, thanks for the excellent patch headers.  It's nice to
> have
> that reference every time even though it's repeated.
> 
> > 
> > -static inline bool can_follow_write_pte(pte_t pte, unsigned int
> > flags)
> > +static inline bool can_follow_write_pte(pte_t pte, unsigned int
> > flags,
> > +					bool shstk)
> >  {
> > +	bool pte_cowed = shstk ? is_shstk_pte(pte):pte_dirty(pte);
> > +
> >  	return pte_write(pte) ||
> > -		((flags & FOLL_FORCE) && (flags & FOLL_COW) &&
> > pte_dirty(pte));
> > +		((flags & FOLL_FORCE) && (flags & FOLL_COW) &&
> > pte_cowed);
> >  }
> Can we just pass the VMA in here?  This use is OK-ish, but I
> generally
> detest true/false function arguments because you can't tell what they
> are when they show up without a named variable.
> 
> But...  Why does this even matter?  Your own example showed that all
> shadowstack PTEs have either DIRTY_HW or DIRTY_SW set, and
> pte_dirty()
> checks both.
> 
> That makes this check seem a bit superfluous.

My understanding is that we don't want to follow write pte if the page
is shared as read-only.  For a SHSTK page, that is (R/O + DIRTY_SW),
which means the SHSTK page has not been COW'ed.  Is that right?

Thanks,
Yu-cheng
