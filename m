Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD32ECDFB0
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 22:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81489208E9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 22:40:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81489208E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387446AbeGLWwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 18:52:35 -0400
Received: from mga09.intel.com ([134.134.136.24]:14614 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732601AbeGLWwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 18:52:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jul 2018 15:40:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,345,1526367600"; 
   d="scan'208";a="239911458"
Received: from 2b52.sc.intel.com ([143.183.136.52])
  by orsmga005.jf.intel.com with ESMTP; 12 Jul 2018 15:40:54 -0700
Message-ID: <1531435034.2965.15.camel@intel.com>
Subject: Re: [RFC PATCH v2 25/27] x86/cet: Add PTRACE interface for CET
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
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
        Peter Zijlstra <peterz@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Date:   Thu, 12 Jul 2018 15:37:14 -0700
In-Reply-To: <20180712140327.GA7810@gmail.com>
References: <20180710222639.8241-1-yu-cheng.yu@intel.com>
         <20180710222639.8241-26-yu-cheng.yu@intel.com>
         <20180711102035.GB8574@gmail.com> <1531323638.13297.24.camel@intel.com>
         <20180712140327.GA7810@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-07-12 at 16:03 +0200, Ingo Molnar wrote:
> * Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
> 
> > 
> > > 
> > > > 
> > > > diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
> > > > index e2ee403865eb..ac2bc3a18427 100644
> > > > --- a/arch/x86/kernel/ptrace.c
> > > > +++ b/arch/x86/kernel/ptrace.c
> > > > @@ -49,7 +49,9 @@ enum x86_regset {
> > > >  	REGSET_IOPERM64 = REGSET_XFP,
> > > >  	REGSET_XSTATE,
> > > >  	REGSET_TLS,
> > > > +	REGSET_CET64 = REGSET_TLS,
> > > >  	REGSET_IOPERM32,
> > > > +	REGSET_CET32,
> > > >  };
> > > Why does REGSET_CET64 alias on REGSET_TLS?
> > In x86_64_regsets[], there is no [REGSET_TLS].  The core dump code
> > cannot handle holes in the array.
> Is there a fundamental (ABI) reason for that?

What I did was, ran Linux with 'slub_debug', and forced a core dump
(kill -abrt <pid>), then there was a red zone warning in the dmesg.
My feeling is there could be issues in the core dump code.  These
enum's are only local to arch/x86/kernel/ptrace.c and not exported.
I am not aware this is in the ABI.

> 
> > 
> > > 
> > > to "CET" (which is a well-known acronym for "Central European Time"),
> > > not to CFE?
> > > 
> > I don't know if I can change that, will find out.
> So what I'd suggest is something pretty simple: to use CFT/cft in kernel internal 
> names, except for the Intel feature bit and any MSR enumeration which can be CET 
> if Intel named it that way, and a short comment explaining the acronym difference.
> 
> Or something like that.

Ok, I will make changes in the next version and probably revise
from that if still not optimal.

Yu-cheng

