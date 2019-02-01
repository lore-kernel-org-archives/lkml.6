Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A039BC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62F2720870
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="EI4lk9yN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfBAJ4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 04:56:04 -0500
Received: from mail.skyhub.de ([5.9.137.197]:57030 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726116AbfBAJ4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 04:56:04 -0500
Received: from zn.tnic (p200300EC2BCC5000604F5F4DB2DDD4A2.dip0.t-ipconnect.de [IPv6:2003:ec:2bcc:5000:604f:5f4d:b2dd:d4a2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8E2421EC0573;
        Fri,  1 Feb 2019 10:56:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1549014962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=WDhRMHYvzBvBLZ8TyBYNZLP7z4syk0IijSBRbbjBN+I=;
        b=EI4lk9yNhIjCkDQnlNvdBR++Y2nFlwBHZdmCM36UElz+ApNEEVxns9Tx2ItvTRMTy3WfrB
        mPQ92d/qS0r+YurGxTJntcnu6rkHYaeG1PF2DoDZ8QhMkxGYpuji76dZHSEaMGr2RWXsQj
        TTRLIEDHaifJYVHgJDMlY3Yes4RQXBM=
Date:   Fri, 1 Feb 2019 10:55:53 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/mce: Initialize "bank" when we find a fatal error in
 mce_no_way_out()
Message-ID: <20190201095553.GC31854@zn.tnic>
References: <20190201003341.10638-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190201003341.10638-1-tony.luck@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 04:33:41PM -0800, Tony Luck wrote:
> Internal injection testing crashed with a console log that said:
> 
> mce: [Hardware Error]: CPU 7: Machine Check Exception: f Bank 0: bd80000000100134
> 
> This caused a lot of head scratching because the MCACOD (bits 15:0) of that
> status is a signature from an L1 data cache error. But Linux says that it found
> it in "Bank 0", which on this model CPU only reports L1 instruction cache errors.
> 
> The answer was that Linux doesn't initialize "m->bank" in the case that it finds
> a fatal error in the mce_no_way_out() pre-scan of banks. If this was a local machine
> check, then we pass this partially initialized "struct mce" to mce_panic().
> 
> Fix is simple. Just initialize m->bank in the case that we found a fatal error.
> 
> Fixes: 40c36e2741d7 ("x86/mce: Fix incorrect "Machine check from unknown source" message")
> Cc: stable@vger.kernel.org # v4.18 Note pre-v5.0 arch/x86/kernel/cpu/mce/core.c was called arch/x86/kernel/cpu/mcheck/mce.c
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  arch/x86/kernel/cpu/mce/core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index 672c7225cb1b..6ce290c506d9 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -784,6 +784,7 @@ static int mce_no_way_out(struct mce *m, char **msg, unsigned long *validp,
>  			quirk_no_way_out(i, m, regs);
>  
>  		if (mce_severity(m, mca_cfg.tolerant, &tmp, true) >= MCE_PANIC_SEVERITY) {
> +			m->bank = i;

So conceptually this write belongs in...

>  			mce_read_aux(m, i);

... this function, i.e., in mce_read_aux() because it gets the bank
number passed in already. And our calling pattern when populating struct
mce is:

	mce_gather_info()
	mce_read_aux()

so it'll be more robust if we moved it there.

Also, that argument "i" of mce_read_aux() is not very telling and it
should be "bank" but that would complicate the stable backporting so if
you feel like it, you could do a second, cleanup patch ontop to fix that
too.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
