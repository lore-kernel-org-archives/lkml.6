Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FBFFC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 17:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3442520855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 17:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HHb7MlT4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3442520855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbeKJC7S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 21:59:18 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47770 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbeKJC7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 21:59:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jLpnOVJ+M6GvWpdCZ7qu/Ypx8ghGwTs4p32VfyHKziw=; b=HHb7MlT4TNKDVH0wMHL7m7ODn
        namrqgoBWSD6fpGjNMAxVe50j65z7T9mngzINKy/z/E1qeArPs0yS/uY/pucASJ6Si+R58cKvFHrk
        HqsPgc6ukbBksRmJjukgvIaUwbrExWglWkUKKJtAAoKwNIhGXCmu++CqVXIA6xmyc9pyz7KkRB6eW
        VzabVXJJnshEDKwuVjW+Wr2kRWPHaVGOieqgHQrUIL8iC6VDlc3vt7gbKzC22iUJpyeE0B2ejh2zv
        f3MRfXFRM41tGyOuXWugNO+ltJAnkB4bXJF3jIEgiN+WOADFSWdsYpBQtYCKb+cY7D5x9o+9i86JT
        WZfBFT4UQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gLAPd-0006pj-1i; Fri, 09 Nov 2018 17:17:41 +0000
Date:   Fri, 9 Nov 2018 09:17:40 -0800
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
Message-ID: <20181109171740.GT3074@bombadil.infradead.org>
References: <20181011151523.27101-1-yu-cheng.yu@intel.com>
 <20181011151523.27101-5-yu-cheng.yu@intel.com>
 <CALCETrVAe8R=crVHoD5QmbN-gAW+V-Rwkwe4kQP7V7zQm9TM=Q@mail.gmail.com>
 <4295b8f786c10c469870a6d9725749ce75dcdaa2.camel@intel.com>
 <CALCETrUKzXYzRrWRdi8Z7AdAF0uZW5Gs7J4s=55dszoyzc29rw@mail.gmail.com>
 <043a17ef-dc9f-56d2-5fba-1a58b7b0fd4d@intel.com>
 <20181108220054.GP3074@bombadil.infradead.org>
 <ead230ab-a904-50d6-c4cf-46d5804f6151@intel.com>
 <20181109003225.GQ3074@bombadil.infradead.org>
 <6cd2ae51-2d2a-9c68-df7c-45b49e0a813f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6cd2ae51-2d2a-9c68-df7c-45b49e0a813f@intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 09:13:32AM -0800, Dave Hansen wrote:
> On 11/8/18 4:32 PM, Matthew Wilcox wrote:
> >> Now, looking at Yu-cheng's specific example, it doesn't matter.  We've
> >> got 64-bit types and natural 64-bit alignment.  Without __packed, we
> >> need to look out for natural alignment screwing us up.  With __packed,
> >> it just does what it *looks* like it does.
> > The question is whether Yu-cheng's struct is ever embedded in another
> > struct.  And if so, what does the hardware do?
> 
> It's not really.
> 
> +struct cet_user_state {
> +	u64 u_cet;	/* user control flow settings */
> +	u64 user_ssp;	/* user shadow stack pointer */
> +} __packed;
> 
> This ends up embedded in 'struct fpu'.  The hardware tells us what the
> sum of all the sizes of all the state components are, and also tells us
> the offsets inside the larger buffer.
> 
> We double-check that the structure sizes exactly match the sizes that
> the hardware tells us that the buffer pieces are via XCHECK_SZ().
> 
> But, later versions of the hardware have instructions that don't have
> static offsets for the state components (when the XSAVES/XSAVEC
> instructions are used).  So, for those, the structure embedding isn't
> used at *all* since some state might not be present.

But *when present*, this structure is always aligned on an 8-byte
boundary, right?

