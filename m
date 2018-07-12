Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D01AECDFB0
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 23:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 525E120842
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 23:08:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 525E120842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387500AbeGLXUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 19:20:19 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:46071 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733207AbeGLXUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 19:20:18 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos.glx-home)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fdkhE-0007hs-IU; Fri, 13 Jul 2018 01:08:24 +0200
Date:   Fri, 13 Jul 2018 01:08:23 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
cc:     Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
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
Subject: Re: [RFC PATCH v2 25/27] x86/cet: Add PTRACE interface for CET
In-Reply-To: <1531435034.2965.15.camel@intel.com>
Message-ID: <alpine.DEB.2.21.1807130102470.1597@nanos.tec.linutronix.de>
References: <20180710222639.8241-1-yu-cheng.yu@intel.com>  <20180710222639.8241-26-yu-cheng.yu@intel.com>  <20180711102035.GB8574@gmail.com> <1531323638.13297.24.camel@intel.com>  <20180712140327.GA7810@gmail.com> <1531435034.2965.15.camel@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1575887918-1531436904=:1597"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1575887918-1531436904=:1597
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 12 Jul 2018, Yu-cheng Yu wrote:
> On Thu, 2018-07-12 at 16:03 +0200, Ingo Molnar wrote:
> > * Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
> > > > > diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
> > > > > index e2ee403865eb..ac2bc3a18427 100644
> > > > > --- a/arch/x86/kernel/ptrace.c
> > > > > +++ b/arch/x86/kernel/ptrace.c
> > > > > @@ -49,7 +49,9 @@ enum x86_regset {
> > > > >  	REGSET_IOPERM64 = REGSET_XFP,
> > > > >  	REGSET_XSTATE,
> > > > >  	REGSET_TLS,
> > > > > +	REGSET_CET64 = REGSET_TLS,
> > > > >  	REGSET_IOPERM32,
> > > > > +	REGSET_CET32,
> > > > >  };
> > > > Why does REGSET_CET64 alias on REGSET_TLS?
> > > In x86_64_regsets[], there is no [REGSET_TLS].  The core dump code
> > > cannot handle holes in the array.
> > Is there a fundamental (ABI) reason for that?
> 
> What I did was, ran Linux with 'slub_debug', and forced a core dump
> (kill -abrt <pid>), then there was a red zone warning in the dmesg.
> My feeling is there could be issues in the core dump code.  These

Kernel development is not about feelings.

Either you can track down the root cause or you cannot. There is no place
for feelings and no place in between. And if you cannot track down the root
cause and explain it proper then the resulting patch is just papering over
the symptoms and will come back to hunt you (or others) sooner than later.

No if, no could, no feelings. Facts is what matters. Really.

Thanks,

	tglx
--8323329-1575887918-1531436904=:1597--
