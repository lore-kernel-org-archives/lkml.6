Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id wZ+EJvdfGVtQWgAAmS7hNA
	; Thu, 07 Jun 2018 16:49:25 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 7299E6089E; Thu,  7 Jun 2018 16:49:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 008D6605A2;
	Thu,  7 Jun 2018 16:49:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 008D6605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753551AbeFGQtX (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 12:49:23 -0400
Received: from mga18.intel.com ([134.134.136.126]:18222 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750933AbeFGQtV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 12:49:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jun 2018 09:49:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,487,1520924400";
   d="scan'208";a="47238763"
Received: from 2b52.sc.intel.com (HELO [143.183.136.51]) ([143.183.136.51])
  by orsmga007.jf.intel.com with ESMTP; 07 Jun 2018 09:49:20 -0700
Message-ID: <1528389969.4636.25.camel@2b52.sc.intel.com>
Subject: Re: [PATCH 7/9] x86/mm: Shadow stack page fault error checking
From: Yu-cheng Yu <yu-cheng.yu@intel.com>
To: Andy Lutomirski <luto@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. J. Lu" <hjl.tools@gmail.com>,
        "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        mike.kravetz@oracle.com
Date: Thu, 07 Jun 2018 09:46:09 -0700
In-Reply-To: <CALCETrXA--XrVNvPM4-Cv6-E6OFd=TZ5Gw_MWePt7MtqCBBqRg@mail.gmail.com>
References: <20180607143705.3531-1-yu-cheng.yu@intel.com>
         <20180607143705.3531-8-yu-cheng.yu@intel.com>
         <CALCETrXA--XrVNvPM4-Cv6-E6OFd=TZ5Gw_MWePt7MtqCBBqRg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-06-07 at 09:26 -0700, Andy Lutomirski wrote:
> On Thu, Jun 7, 2018 at 7:40 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
> >
> > If a page fault is triggered by a shadow stack access (e.g.
> > call/ret) or shadow stack management instructions (e.g.
> > wrussq), then bit[6] of the page fault error code is set.
> >
> > In access_error(), we check if a shadow stack page fault
> > is within a shadow stack memory area.
> >
> > Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> 
> > diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> > index 73bd8c95ac71..2b3b9170109c 100644
> > --- a/arch/x86/mm/fault.c
> > +++ b/arch/x86/mm/fault.c
> > @@ -1166,6 +1166,17 @@ access_error(unsigned long error_code, struct vm_area_struct *vma)
> >                                        (error_code & X86_PF_INSTR), foreign))
> >                 return 1;
> >
> > +       /*
> > +        * Verify X86_PF_SHSTK is within a shadow stack VMA.
> > +        * It is always an error if there is a shadow stack
> > +        * fault outside a shadow stack VMA.
> > +        */
> > +       if (error_code & X86_PF_SHSTK) {
> > +               if (!(vma->vm_flags & VM_SHSTK))
> > +                       return 1;
> > +               return 0;
> > +       }
> > +
> 
> What, if anything, would go wrong without this change?  It seems like
> it might be purely an optimization.  If so, can you mention that in
> the comment?

Without this check, the page fault code could overlook the fact that the
application is trying to use non shadow stack area for shadow stack.
I will add this to the comments.
