Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B5DECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 16:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 337612089F
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 16:11:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 337612089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731422AbeGMQ05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 12:26:57 -0400
Received: from mga09.intel.com ([134.134.136.24]:50420 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729736AbeGMQ05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 12:26:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jul 2018 09:11:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,348,1526367600"; 
   d="scan'208";a="71159019"
Received: from 2b52.sc.intel.com ([143.183.136.52])
  by fmsmga004.fm.intel.com with ESMTP; 13 Jul 2018 09:11:40 -0700
Message-ID: <1531498079.8494.16.camel@intel.com>
Subject: Re: [RFC PATCH v2 25/27] x86/cet: Add PTRACE interface for CET
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
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
Date:   Fri, 13 Jul 2018 09:07:59 -0700
In-Reply-To: <alpine.DEB.2.21.1807130102470.1597@nanos.tec.linutronix.de>
References: <20180710222639.8241-1-yu-cheng.yu@intel.com>
          <20180710222639.8241-26-yu-cheng.yu@intel.com>
          <20180711102035.GB8574@gmail.com> <1531323638.13297.24.camel@intel.com>
          <20180712140327.GA7810@gmail.com> <1531435034.2965.15.camel@intel.com>
         <alpine.DEB.2.21.1807130102470.1597@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-07-13 at 01:08 +0200, Thomas Gleixner wrote:
> On Thu, 12 Jul 2018, Yu-cheng Yu wrote:
> > 
> > On Thu, 2018-07-12 at 16:03 +0200, Ingo Molnar wrote:
> > > 
> > > * Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
> > > > 
> > > > > 
> > > > > > 
> > > > > > diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
> > > > > > index e2ee403865eb..ac2bc3a18427 100644
> > > > > > --- a/arch/x86/kernel/ptrace.c
> > > > > > +++ b/arch/x86/kernel/ptrace.c
> > > > > > @@ -49,7 +49,9 @@ enum x86_regset {
> > > > > >  	REGSET_IOPERM64 = REGSET_XFP,
> > > > > >  	REGSET_XSTATE,
> > > > > >  	REGSET_TLS,
> > > > > > +	REGSET_CET64 = REGSET_TLS,
> > > > > >  	REGSET_IOPERM32,
> > > > > > +	REGSET_CET32,
> > > > > >  };
> > > > > Why does REGSET_CET64 alias on REGSET_TLS?
> > > > In x86_64_regsets[], there is no [REGSET_TLS].  The core dump code
> > > > cannot handle holes in the array.
> > > Is there a fundamental (ABI) reason for that?
> > What I did was, ran Linux with 'slub_debug', and forced a core dump
> > (kill -abrt <pid>), then there was a red zone warning in the dmesg.
> > My feeling is there could be issues in the core dump code.  These
> Kernel development is not about feelings.

I got that :-)

> 
> Either you can track down the root cause or you cannot. There is no place
> for feelings and no place in between. And if you cannot track down the root
> cause and explain it proper then the resulting patch is just papering over
> the symptoms and will come back to hunt you (or others) sooner than later.
> 
> No if, no could, no feelings. Facts is what matters. Really.

In kernel/ptrace.c,

find_regset(const struct user_regset_view *view, unsigned int type)
{
	const struct user_regset *regset;
	int n;

	for (n = 0; n < view->n; ++n) {
		regset = view->regsets + n;
		if (regset->core_note_type == type)
			return regset;
	}

	return NULL;
}

If there is a hole in the regset array, the empty slot's
regset->core_note_type is not defined.

We can add some comments near those enum's.

Yu-cheng

