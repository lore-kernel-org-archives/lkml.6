Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92FF8C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56C6A20C0C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:11:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56C6A20C0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389618AbeGKQQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 12:16:33 -0400
Received: from mga06.intel.com ([134.134.136.31]:45856 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726457AbeGKQQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 12:16:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jul 2018 09:11:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,338,1526367600"; 
   d="scan'208";a="66141725"
Received: from 2b52.sc.intel.com ([143.183.136.52])
  by orsmga003.jf.intel.com with ESMTP; 11 Jul 2018 09:11:29 -0700
Message-ID: <1531325272.13297.27.camel@intel.com>
Subject: Re: [RFC PATCH v2 15/27] mm/mprotect: Prevent mprotect from
 changing shadow stack
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
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
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Date:   Wed, 11 Jul 2018 09:07:52 -0700
In-Reply-To: <20180711091232.GU2476@hirez.programming.kicks-ass.net>
References: <20180710222639.8241-1-yu-cheng.yu@intel.com>
         <20180710222639.8241-16-yu-cheng.yu@intel.com>
         <04800c52-1f86-c485-ba7c-2216d8c4966f@linux.intel.com>
         <20180711091232.GU2476@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-07-11 at 11:12 +0200, Peter Zijlstra wrote:
> On Tue, Jul 10, 2018 at 04:10:08PM -0700, Dave Hansen wrote:
> > 
> > On 07/10/2018 03:26 PM, Yu-cheng Yu wrote:
> > > 
> > > Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> > This still needs a changelog, even if you think it's simple.
> > > 
> > > --- a/mm/mprotect.c
> > > +++ b/mm/mprotect.c
> > > @@ -446,6 +446,15 @@ static int do_mprotect_pkey(unsigned long
> > > start, size_t len,
> > >  	error = -ENOMEM;
> > >  	if (!vma)
> > >  		goto out;
> > > +
> > > +	/*
> > > +	 * Do not allow changing shadow stack memory.
> > > +	 */
> > > +	if (vma->vm_flags & VM_SHSTK) {
> > > +		error = -EINVAL;
> > > +		goto out;
> > > +	}
> > > +
> > I think this is a _bit_ draconian.  Why shouldn't we be able to use
> > protection keys with a shadow stack?  Or, set it to PROT_NONE?
> Right, and then there's also madvise() and some of the other
> accessors.
> 
> Why do we need to disallow this? AFAICT the worst that can happen is
> that a process wrecks itself, so what?

Agree.  I will remove the patch.
