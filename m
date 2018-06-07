Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id P4R5GT2WGVs0bwAAmS7hNA
	; Thu, 07 Jun 2018 20:33:32 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C9EE3608B8; Thu,  7 Jun 2018 20:33:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 5A66C6063F;
	Thu,  7 Jun 2018 20:33:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5A66C6063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932381AbeFGUda (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 16:33:30 -0400
Received: from mga14.intel.com ([192.55.52.115]:36195 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932213AbeFGUd2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 16:33:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jun 2018 13:33:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,487,1520924400";
   d="scan'208";a="61319966"
Received: from 2b52.sc.intel.com (HELO [143.183.136.51]) ([143.183.136.51])
  by fmsmga004.fm.intel.com with ESMTP; 07 Jun 2018 13:33:28 -0700
Message-ID: <1528403417.5265.35.camel@2b52.sc.intel.com>
Subject: Re: [PATCH 06/10] x86/cet: Add arch_prctl functions for shadow stack
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
Date: Thu, 07 Jun 2018 13:30:17 -0700
In-Reply-To: <CALCETrU6axo158CiSCRRkC4GC5hib9hypC98t7LLjA3gDaacsw@mail.gmail.com>
References: <20180607143807.3611-1-yu-cheng.yu@intel.com>
         <20180607143807.3611-7-yu-cheng.yu@intel.com>
         <CALCETrU6axo158CiSCRRkC4GC5hib9hypC98t7LLjA3gDaacsw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-06-07 at 11:48 -0700, Andy Lutomirski wrote:
> On Thu, Jun 7, 2018 at 7:41 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
> >
> > The following operations are provided.
> >
> > ARCH_CET_STATUS:
> >         return the current CET status
> >
> > ARCH_CET_DISABLE:
> >         disable CET features
> >
> > ARCH_CET_LOCK:
> >         lock out CET features
> >
> > ARCH_CET_EXEC:
> >         set CET features for exec()
> >
> > ARCH_CET_ALLOC_SHSTK:
> >         allocate a new shadow stack
> >
> > ARCH_CET_PUSH_SHSTK:
> >         put a return address on shadow stack
> >
> > ARCH_CET_ALLOC_SHSTK and ARCH_CET_PUSH_SHSTK are intended only for
> > the implementation of GLIBC ucontext related APIs.
> 
> Please document exactly what these all do and why.  I don't understand
> what purpose ARCH_CET_LOCK and ARCH_CET_EXEC serve.  CET is opt in for
> each ELF program, so I think there should be no need for a magic
> override.

CET is initially enabled if the loader has CET capability.  Then the
loader decides if the application can run with CET.  If the application
cannot run with CET (e.g. a dependent library does not have CET), then
the loader turns off CET before passing to the application.  When the
loader is done, it locks out CET and the feature cannot be turned off
anymore until the next exec() call.  When the next exec() is called, CET
feature is turned on/off based on the values set by ARCH_CET_EXEC.

I will put more details in Documentation/x86/intel_cet.txt.
 
