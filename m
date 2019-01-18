Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF7AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA16B20883
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547818378;
	bh=tpgEN9hei0cSu0QMQUqt+S7kCVpdIeY4bfLSCWtjoow=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=OeNA9V4w5rlpuReAAy7vFSlzOkUHfMF/FNtS9Cxc/KgDkhp4FVGCQoPuZ8/AjBOX8
	 llSqlZC4lmgszzIBr0s3rcYVvA7tfayHx4UGLr0ZrTbvrt4Eqa7asKTxpflqVslgkK
	 hDCiD031vXZ5DpzWf7rejjjQ0KhevAkMly5Dxrl8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbfARNc4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 08:32:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:52730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726593AbfARNcz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 08:32:55 -0500
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59DCD2087E;
        Fri, 18 Jan 2019 13:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547818374;
        bh=tpgEN9hei0cSu0QMQUqt+S7kCVpdIeY4bfLSCWtjoow=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fBVvlOZZ5mQwo37cY+fAmLunV89dmC5wJtpM+DIDjGgbZH9utKqAyiRKjZ5z2Fmv4
         lrG7ZyTvrWVl02rdpJKgVpJahDqkSyn78MvC3Ro6P1HSYpL2gZ0C83mA6zyTWhO4DA
         bbuj6objZP4Rb/Rgyu2ZeGlJtSkaY6ZUCMItmw4U=
Date:   Fri, 18 Jan 2019 22:32:49 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Damian Tometzki <linux_dti@icloud.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux-MM <linux-mm@kvack.org>, Will Deacon <will.deacon@arm.com>,
        ard.biesheuvel@linaro.org, kristen@linux.intel.com,
        deneen.t.dock@intel.com
Subject: Re: [PATCH 17/17] module: Prevent module removal racing with
 text_poke()
Message-Id: <20190118223249.94436b58fbf5f9592d92dfca@kernel.org>
In-Reply-To: <69EA2C81-826F-46BA-8D80-241C39B0B70B@gmail.com>
References: <20190117003259.23141-1-rick.p.edgecombe@intel.com>
        <20190117003259.23141-18-rick.p.edgecombe@intel.com>
        <20190117165422.d33d1af83db8716e24960a3c@kernel.org>
        <e865e051-be79-adce-7275-72abf2173bdb@zytor.com>
        <69EA2C81-826F-46BA-8D80-241C39B0B70B@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jan 2019 17:15:27 -0800
Nadav Amit <nadav.amit@gmail.com> wrote:

> > On Jan 17, 2019, at 3:58 PM, H. Peter Anvin <hpa@zytor.com> wrote:
> > 
> > On 1/16/19 11:54 PM, Masami Hiramatsu wrote:
> >> On Wed, 16 Jan 2019 16:32:59 -0800
> >> Rick Edgecombe <rick.p.edgecombe@intel.com> wrote:
> >> 
> >>> From: Nadav Amit <namit@vmware.com>
> >>> 
> >>> It seems dangerous to allow code modifications to take place
> >>> concurrently with module unloading. So take the text_mutex while the
> >>> memory of the module is freed.
> >> 
> >> At that point, since the module itself is removed from module list,
> >> it seems no actual harm. Or would you have any concern?
> > 
> > The issue isn't the module list, but rather when it is safe to free the
> > contents, so we don't clobber anything. We absolutely need to enforce
> > that we can't text_poke() something that might have already been freed.
> > 
> > That being said, we *also* really would prefer to enforce that we can't
> > text_poke() memory that doesn't actually contain code; as far as I can
> > tell we don't currently do that check.
> 
> Yes, that what the mutex was supposed to achieve. It’s not supposed just
> to check whether it is a code page, but also that it is the same code
> page that you wanted to patch. 
> 
> > This, again, is a good use for a separate mm context. We can enforce
> > that that context will only ever contain valid page mappings for actual
> > code pages.
> 
> This will not tell you that you have the *right* code-page. The module
> notifiers help to do so, since they synchronize the text poking with
> the module removal.
> 
> > (Note: in my proposed algorithm, with a separate mm, replace INVLPG with
> > switching CR3 if we have to do a rollback or roll forward in the
> > breakpoint handler.)
> 
> I really need to read your patches more carefully to see what you mean.
> 
> Anyhow, so what do you prefer? I’m ok with either one:
> 	1. Keep this patch
> 	2. Remove this patch and change into a comment on text_poke()
> 	3. Just drop the patch

I would prefer 2. so at least we should add a comment to text_poke().

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
