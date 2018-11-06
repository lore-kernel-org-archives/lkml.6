Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB96C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 20:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 757FA20881
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 20:26:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 757FA20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388426AbeKGFxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 00:53:49 -0500
Received: from mga03.intel.com ([134.134.136.65]:29200 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726184AbeKGFxt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 00:53:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2018 12:26:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,472,1534834800"; 
   d="scan'208";a="89057739"
Received: from unknown (HELO yyu32-desk1) ([143.183.136.51])
  by orsmga006.jf.intel.com with ESMTP; 06 Nov 2018 12:26:49 -0800
Message-ID: <26c7e2dd72efe8168b296285985eb5f025881bb1.camel@intel.com>
Subject: Re: [PATCH v5 21/27] x86/cet/shstk: Introduce WRUSS instruction
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Date:   Tue, 06 Nov 2018 12:21:38 -0800
In-Reply-To: <ee5a93f7-ed42-dcc5-0e55-e73ac2637e84@intel.com>
References: <20181011151523.27101-1-yu-cheng.yu@intel.com>
         <20181011151523.27101-22-yu-cheng.yu@intel.com>
         <ee5a93f7-ed42-dcc5-0e55-e73ac2637e84@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-11-06 at 10:43 -0800, Dave Hansen wrote:
> On 10/11/18 8:15 AM, Yu-cheng Yu wrote:
> > --- a/arch/x86/mm/fault.c
> > +++ b/arch/x86/mm/fault.c
> > @@ -1305,6 +1305,15 @@ __do_page_fault(struct pt_regs *regs, unsigned long
> > error_code,
> >  		error_code |= X86_PF_USER;
> >  		flags |= FAULT_FLAG_USER;
> >  	} else {
> > +		/*
> > +		 * WRUSS is a kernel instruction and but writes
> > +		 * to user shadow stack.  When a fault occurs,
> > +		 * both X86_PF_USER and X86_PF_SHSTK are set.
> > +		 * Clear X86_PF_USER here.
> > +		 */
> > +		if ((error_code & (X86_PF_USER | X86_PF_SHSTK)) ==
> > +		    (X86_PF_USER | X86_PF_SHSTK))
> > +			error_code &= ~X86_PF_USER;
> 
> This hunk of code basically points out that the architecture of WRUSS is
> broken for Linux.  The setting of X86_PF_USER for a ring-0 instruction
> really is a mis-feature of the architecture for us and we *undo* it in
> software which is unfortunate.  Wish I would have caught this earlier.
> 
> Andy, note that this is another case where hw_error_code and
> sw_error_code will diverge, unfortunately.
> 
> Anyway, this is going to necessitate some comment updates in the page
> fault code.  Yu-cheng, you are going to collide with some recent changes
> I made to the page fault code.  Please be careful with the context when
> you do the merge and make sure that all the new comments stay correct.

Ok.  Thanks!

Yu-cheng
