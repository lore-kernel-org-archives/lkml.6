Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CAA5ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 20:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B97C206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 20:45:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B97C206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbeKIGWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 01:22:30 -0500
Received: from mga07.intel.com ([134.134.136.100]:14746 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbeKIGW3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 01:22:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Nov 2018 12:45:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,480,1534834800"; 
   d="scan'208";a="89671600"
Received: from yyu32-desk1.sc.intel.com ([143.183.136.147])
  by orsmga006.jf.intel.com with ESMTP; 08 Nov 2018 12:45:16 -0800
Message-ID: <bb049aa9578bae7cfc6bd7c05b540f033f6685cc.camel@intel.com>
Subject: Re: [PATCH v5 04/27] x86/fpu/xstate: Add XSAVES system states for
 shadow stack
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Borislav Petkov <bp@alien8.de>
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
Date:   Thu, 08 Nov 2018 12:40:02 -0800
In-Reply-To: <20181108184038.GJ7543@zn.tnic>
References: <20181011151523.27101-1-yu-cheng.yu@intel.com>
         <20181011151523.27101-5-yu-cheng.yu@intel.com>
         <20181108184038.GJ7543@zn.tnic>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-11-08 at 19:40 +0100, Borislav Petkov wrote:
> On Thu, Oct 11, 2018 at 08:15:00AM -0700, Yu-cheng Yu wrote:
> > [...] 
> > +/*
> > + * State component 11 is Control flow Enforcement user states
> 
> Why the Camel-cased naming?
> 
> "Control" then "flow" then capitalized again "Enforcement".
> 
> Fix all occurrences pls, especially the user-visible strings.

I will change it to "Control-flow Enforcement" everywhere.

> > + */
> > +struct cet_user_state {
> > +	u64 u_cet;	/* user control flow settings */
> > +	u64 user_ssp;	/* user shadow stack pointer */
> 
> Prefix both with "usr_" instead.

Ok.

> [...]
> 
> Just write "privilege level" everywhere - not "ring".
> 
> Btw, do you see how the type and the name of all those other fields in
> that file are tabulated? Except yours...

I will fix it.

[...] 
> > 
> > diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> > index 605ec6decf3e..ad36ea28bfd1 100644
> > --- a/arch/x86/kernel/fpu/xstate.c
> > +++ b/arch/x86/kernel/fpu/xstate.c
> > @@ -35,6 +35,9 @@ static const char *xfeature_names[] =
> >  	"Processor Trace (unused)"	,
> >  	"Protection Keys User registers",
> >  	"unknown xstate feature"	,
> > +	"Control flow User registers"	,
> > +	"Control flow Kernel registers"	,
> > +	"unknown xstate feature"	,
> 
> So there are two "unknown xstate feature" array elems now...
> 
> >  static short xsave_cpuid_features[] __initdata = {
> > @@ -48,6 +51,9 @@ static short xsave_cpuid_features[] __initdata = {
> >  	X86_FEATURE_AVX512F,
> >  	X86_FEATURE_INTEL_PT,
> >  	X86_FEATURE_PKU,
> > +	0,		   /* Unused */
> 
> What's that for?

In fpu_init_system_xstate(), we test and clear features that are not enabled.
There we depend on the order of these elements.  This is the tenth "unknown
xstate feature".

Yu-cheng
