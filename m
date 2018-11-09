Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B3CCC0044B
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 00:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5009620883
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 00:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nC78xKGJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5009620883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbeKIKKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 05:10:39 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34620 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727483AbeKIKKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 05:10:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OsnntpvzRra1bKCuMyJWMzb3tscjWBVS1AEp7qWVZAI=; b=nC78xKGJJftKkq7l3M2+Mh9vu
        NjTLkICrkMLdnLEY4rAOF0N9bCaOF/3NOIxyd+bGuqiIOzpF7zS3iK3zQlA2C6Z3Jcgue552NcGJn
        YDxnHgsWZpIFbw0x4iFbpsZAlZ4iJBGcE3tmYgX3/MUlKqVc6La7C+Mmv1mKXwPIZ2/q/lWNZ03Xk
        gp27cFSGlONLRxdLGEA6i2DMtQhTEOBmyOwykgE3Tf71PGuglZFPpXDUlA3kCuAeHP3LjkHuPtvUr
        CyrB1ccI9Y8Yp62tX7wSkNhJ7hAXmqFX70TPjxEWgYZZjZ4JmqOroSTCC5VhWSAvNHar4gXwfBIkq
        YaqUjXooQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gKuin-00057a-H8; Fri, 09 Nov 2018 00:32:25 +0000
Date:   Thu, 8 Nov 2018 16:32:25 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H. J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>
Subject: Re: [PATCH v5 04/27] x86/fpu/xstate: Add XSAVES system states for
 shadow stack
Message-ID: <20181109003225.GQ3074@bombadil.infradead.org>
References: <20181011151523.27101-1-yu-cheng.yu@intel.com>
 <20181011151523.27101-5-yu-cheng.yu@intel.com>
 <CALCETrVAe8R=crVHoD5QmbN-gAW+V-Rwkwe4kQP7V7zQm9TM=Q@mail.gmail.com>
 <4295b8f786c10c469870a6d9725749ce75dcdaa2.camel@intel.com>
 <CALCETrUKzXYzRrWRdi8Z7AdAF0uZW5Gs7J4s=55dszoyzc29rw@mail.gmail.com>
 <043a17ef-dc9f-56d2-5fba-1a58b7b0fd4d@intel.com>
 <20181108220054.GP3074@bombadil.infradead.org>
 <ead230ab-a904-50d6-c4cf-46d5804f6151@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ead230ab-a904-50d6-c4cf-46d5804f6151@intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 03:35:02PM -0800, Dave Hansen wrote:
> On 11/8/18 2:00 PM, Matthew Wilcox wrote:
> > struct a {
> > 	char c;
> > 	struct b b;
> > };
> > 
> > we want struct b to start at offset 8, but with __packed, it will start
> > at offset 1.
> 
> You're talking about how we want the struct laid out in memory if we
> have control over the layout.  I'm talking about what happens if
> something *else* tells us the layout, like a hardware specification
> which is what is in play with the XSAVE instruction dictated layout
> that's in question here.
> 
> What I'm concerned about is a structure like this:
> 
> struct foo {
>         u32 i1;
>         u64 i2;
> };
> 
> If we leave that to natural alignment, we end up with a 16-byte
> structure laid out like this:
> 
> 	0-3	i1
> 	3-8	alignment gap
> 	8-15	i2

I know you actually meant:

	0-3	i1
	4-7	pad
	8-15	i2

> Which isn't what we want.  We want a 12-byte structure, laid out like this:
> 
> 	0-3	i1
> 	4-11	i2
> 
> Which we get with:
> 
> struct foo {
>         u32 i1;
>         u64 i2;
> } __packed;

But we _also_ get pessimised accesses to i1 and i2.  Because gcc can't
rely on struct foo being aligned to a 4 or even 8 byte boundary (it
might be embedded in "struct a" from above).

> Now, looking at Yu-cheng's specific example, it doesn't matter.  We've
> got 64-bit types and natural 64-bit alignment.  Without __packed, we
> need to look out for natural alignment screwing us up.  With __packed,
> it just does what it *looks* like it does.

The question is whether Yu-cheng's struct is ever embedded in another
struct.  And if so, what does the hardware do?
