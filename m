Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D26FC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 12:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CC592083B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 12:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="DRBpNRi/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728618AbfBEMfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 07:35:41 -0500
Received: from mail.skyhub.de ([5.9.137.197]:51226 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725947AbfBEMfl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 07:35:41 -0500
Received: from zn.tnic (p200300EC2BCB6B00551F5C4602011D50.dip0.t-ipconnect.de [IPv6:2003:ec:2bcb:6b00:551f:5c46:201:1d50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F06221EC02AE;
        Tue,  5 Feb 2019 13:35:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1549370139;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=qy0tAhFBRu2LNdPFTbVIGZuXfaj4t8RKzaRmpgJF9M0=;
        b=DRBpNRi/AE/ddp/N7PrPG+UELrdIUTt+dE0vNyWk0LmyVCMEV87pZqiHROizDHuJ+chxOY
        wbn2bNksDewsX0nnPJonclKBTBPDLlbqaAPJQfBgIqfugNE/JGPoeg3HX/yPwElmarfcka
        AkZNyj+mTvYwgUo4/GGLwq7WnhR/PHo=
Date:   Tue, 5 Feb 2019 13:35:33 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, hpa@zytor.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Nadav Amit <nadav.amit@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux_dti@icloud.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, akpm@linux-foundation.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        will.deacon@arm.com, ard.biesheuvel@linaro.org,
        kristen@linux.intel.com, deneen.t.dock@intel.com,
        Nadav Amit <namit@vmware.com>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v2 06/20] x86/alternative: use temporary mm for text
 poking
Message-ID: <20190205123533.GN21801@zn.tnic>
References: <20190129003422.9328-1-rick.p.edgecombe@intel.com>
 <20190129003422.9328-7-rick.p.edgecombe@intel.com>
 <20190205095853.GJ21801@zn.tnic>
 <20190205113146.GP17528@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190205113146.GP17528@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2019 at 12:31:46PM +0100, Peter Zijlstra wrote:
> ...
>
> So while in general I agree with BUG_ON() being undesirable, I think
> liberal sprinking in text_poke() is fine; you really _REALLY_ want this
> to work or fail loudly. Text corruption is just painful.

Ok. It would be good to have the gist of this sentiment in a comment
above it so that it is absolutely clear why we're doing it.

And since text_poke() can't fail, then it doesn't need a retval too.
AFAICT, nothing is actually using it.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
