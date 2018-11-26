Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B80C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 18:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9954D20862
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 18:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="PCrtsy8D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9954D20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbeK0FZ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 00:25:27 -0500
Received: from mail.skyhub.de ([5.9.137.197]:42606 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726260AbeK0FZ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 00:25:27 -0500
Received: from zn.tnic (p200300EC2BDEFE00DCA0409AA15535E1.dip0.t-ipconnect.de [IPv6:2003:ec:2bde:fe00:dca0:409a:a155:35e1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CF8741EC047F;
        Mon, 26 Nov 2018 19:30:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1543257029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=RDNzXtn+HNtoCQox5ql8d7eGjIh4D5a/YKWp0NeyHtY=;
        b=PCrtsy8DyWimPVtHoBK7KkWljcIJbhBbA2dPXq3+GHp1luQqQhHBo7M28Ls+sAp+Ceh6du
        pbYp5e5LoUV/ocDS22CfCIpACw1ishrM05+LeizF3x5x9t0xuNz1N09E/VQDVZrOqBEQ37
        WuwSu3KG5bA1z110Qn1O1wHiyEO5A8Y=
Date:   Mon, 26 Nov 2018 19:30:24 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Dave Stewart <david.c.stewart@intel.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [patch V2 19/28] x86/process: Consolidate and simplify
 switch_to_xtra() code
Message-ID: <20181126183024.GJ4843@zn.tnic>
References: <20181125183328.318175777@linutronix.de>
 <20181125185005.280855518@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181125185005.280855518@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 25, 2018 at 07:33:47PM +0100, Thomas Gleixner wrote:
> Move the conditional invocation of __switch_to_xtra() into an inline
> function so the logic can be shared between 32 and 64 bit.
> 
> Remove the handthrough of the TSS pointer and retrieve the pointer directly

s/handthrough/passing/

I guess.

> in the bitmap handling function. Use this_cpu_ptr() instead of the
> per_cpu() indirection.
>
> This is a preparatory change so integration of conditional indirect branch
> speculation optimization happens only in one place.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/include/asm/switch_to.h |    3 ---
>  arch/x86/kernel/process.c        |   12 +++++++-----
>  arch/x86/kernel/process.h        |   24 ++++++++++++++++++++++++
>  arch/x86/kernel/process_32.c     |   10 +++-------
>  arch/x86/kernel/process_64.c     |   10 +++-------
>  5 files changed, 37 insertions(+), 22 deletions(-)

...

> --- /dev/null
> +++ b/arch/x86/kernel/process.h
> @@ -0,0 +1,24 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Code shared between 32 and 64 bit

checkpatch mutters here too:

WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
#105: FILE: arch/x86/kernel/process.h:1:
+// SPDX-License-Identifier: GPL-2.0

I guess you want /* comments.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
