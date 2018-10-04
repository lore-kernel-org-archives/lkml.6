Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F0FC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6A5B20652
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:54:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6A5B20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbeJDWry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 18:47:54 -0400
Received: from mga17.intel.com ([192.55.52.151]:36594 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727369AbeJDWrx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 18:47:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Oct 2018 08:54:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,340,1534834800"; 
   d="scan'208";a="79879490"
Received: from 2b52.sc.intel.com ([143.183.136.147])
  by orsmga006.jf.intel.com with ESMTP; 04 Oct 2018 08:52:16 -0700
Message-ID: <beb7872250b61e42c0069a4aab710b31f804d72c.camel@intel.com>
Subject: Re: [RFC PATCH v4 03/27] x86/fpu/xstate: Enable XSAVES system states
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
Date:   Thu, 04 Oct 2018 08:47:35 -0700
In-Reply-To: <20181002171554.GE29601@zn.tnic>
References: <20180921150351.20898-1-yu-cheng.yu@intel.com>
         <20180921150351.20898-4-yu-cheng.yu@intel.com>
         <20181002171554.GE29601@zn.tnic>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-10-02 at 19:15 +0200, Borislav Petkov wrote:
> On Fri, Sep 21, 2018 at 08:03:27AM -0700, Yu-cheng Yu wrote:
> > 
> > diff --git a/arch/x86/include/asm/fpu/xstate.h
> > b/arch/x86/include/asm/fpu/xstate.h
> > index 9b382e5157ed..a32dc5f8c963 100644
> > --- a/arch/x86/include/asm/fpu/xstate.h
> > +++ b/arch/x86/include/asm/fpu/xstate.h
> > @@ -19,10 +19,10 @@
> >  #define XSAVE_YMM_SIZE	    256
> >  #define XSAVE_YMM_OFFSET    (XSAVE_HDR_SIZE + XSAVE_HDR_OFFSET)
> >  
> > -/* System features */
> > -#define XFEATURE_MASK_SYSTEM (XFEATURE_MASK_PT)
> 
> Previous patch renames it, this patch deletes it. Why do we need all
> that unnecessary churn?
> 
> Also, this patch is trying to do a couple of things at once and
> reviewing it is not trivial. Please split the changes logically.

Yes, if we leave XFEATURE_MASK_SUPERVISOR unchanged in the previous patch, this
patch becomes much simpler.  Perhaps we don't even need to split this one.

> > diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> > index 19f8df54c72a..dd2c561c4544 100644
> > --- a/arch/x86/kernel/fpu/xstate.c
> > +++ b/arch/x86/kernel/fpu/xstate.c
> > @@ -51,13 +51,16 @@ static short xsave_cpuid_features[] __initdata = {
> >  };
> >  
> >  /*
> > - * Mask of xstate features supported by the CPU and the kernel:
> > + * Mask of xstate features supported by the CPU and the kernel.
> > + * This is the result from CPUID query, SUPPORTED_XFEATURES_MASK,
> > + * and boot_cpu_has().
> >   */
> 
> This needs to explain what both masks are - user and system. "CPU" and
> "kernel" is not "user" and "all".
> 
> >  u64 xfeatures_mask_user __read_mostly;
> > +u64 xfeatures_mask_all __read_mostly;

The first one is all supported "user" states; the latter is "system" and "user"
states combined.  I will put in comments.

Yu-cheng
