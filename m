Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6547C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 18:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DBDC208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 18:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lf3fB19w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DBDC208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756574AbeFOScK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 14:32:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:57568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756489AbeFOScJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 14:32:09 -0400
Received: from mail-wm0-f41.google.com (mail-wm0-f41.google.com [74.125.82.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 639EB208AF
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 18:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529087528;
        bh=C9wIssmBQ0gJeTEgrFunr9lm2m/cJsqQnR5nEEQ0puk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lf3fB19wkxp3DSEjKIR99klR8rQ3wnpHbwQTb9rcjrNOdZkGjIwRgjb1Ecd1gul12
         vl47RGh7uQrYgd9FuH+Wi0ufgo64aA1SUG94KBKlUf7bhRdNT0sjl82qVGVv0WBX4Y
         gNrM0Z4INxRsQ3FCAuMiYGJnuF47pyKgQfBNAhS8=
Received: by mail-wm0-f41.google.com with SMTP id r125-v6so5428478wmg.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 11:32:08 -0700 (PDT)
X-Gm-Message-State: APt69E1htiI9FDPomlsKQRq0dKsHi3cHhvNmcTD9k5B0Xt2JBeXMP1vZ
        moYafaVfT4vLGA0kumNS+RwYvq/NmGPl4zH2Am3dFQ==
X-Google-Smtp-Source: ADUXVKKHqevYJe6rbkc/o50SPnKPbz3NE5diTtB32QWMo3cIBnSf07V+lrG+LwJfOm0C0Wg3K5GTo2UX1qI/jNssuYA=
X-Received: by 2002:a1c:f902:: with SMTP id x2-v6mr1953393wmh.116.1529087526870;
 Fri, 15 Jun 2018 11:32:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAHmME9pBqGhCjdwx64GxYTKWiMkDNY3v2gnVL_Xm2q=3guOAsQ@mail.gmail.com>
In-Reply-To: <CAHmME9pBqGhCjdwx64GxYTKWiMkDNY3v2gnVL_Xm2q=3guOAsQ@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 15 Jun 2018 11:31:55 -0700
X-Gmail-Original-Message-ID: <CALCETrU+2mBPDfkBz1i_GT1EOJau+mzj4yOK8N0UnT2pGjiUWQ@mail.gmail.com>
Message-ID: <CALCETrU+2mBPDfkBz1i_GT1EOJau+mzj4yOK8N0UnT2pGjiUWQ@mail.gmail.com>
Subject: Re: Lazy FPU restoration / moving kernel_fpu_end() to context switch
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 6:11 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Hi Andy & folks,
>
> Lots of crypto routines look like this:
>
> kernel_fpu_begin();
> encrypt();
> kernel_fpu_end();
>
> If you call such a routine twice, you get:
>
> kernel_fpu_begin();
> encrypt();
> kernel_fpu_end();
> kernel_fpu_begin();
> encrypt();
> kernel_fpu_end();
>
> In a loop this looks like:
>
> for (thing) {
>   kernel_fpu_begin();
>   encrypt(thing);
>   kernel_fpu_end();
> }
>
> This is obviously very bad, because begin() and end() are slow, so
> WireGuard does the obvious:
>
> kernel_fpu_begin();
> for (thing)
>   encrypt(thing);
> kernel_fpu_end();
>
> This is fine and well, and the crypto API I'm working on will enable
> this to be done in a clear way, but I do wonder if maybe this is not
> something that should be happening at the level of the caller, but
> rather in the fpu functions themselves. Namely, what are your thoughts
> on modifying kernel_fpu_end() so that it doesn't actually restore the
> state, but just reenables preemption and marks that on the next
> context switch, the state should be restored? Then, essentially,
> kernel_fpu_begin() and end() become free after the first usage of
> kernel_fpu_begin().
>
> Is this something feasible? I know that performance-wise, I'm really
> gaining a lot from hoisting those functions out of the loops, and API
> wise, it'd be slightly simpler to implement if I didn't have to all
> for that hoisting.

Hi Jason-

Funny you asked.  This has been discussed a few times, although not
quite in the form you imagined.  The idea that we've tossed around is
to restore FPU state on return to user mode.  Roughly, we'd introduce
a new thread flag TIF_FPU_UNLOADED (name TBD).
prepare_exit_to_usermode() would notice this flag, copy the fpstate to
fpregs, and clear the flag.  (Or maybe exit_to_usermode_loop() -- No
one has quite thought it through, but I think it should be outside the
loop.)  We'd update all the FPU accessors to understand the flag.
We'd probably have a helper like:

void unload_user_fpstate(void)

that would do nothing if TIF_FPU_UNLOADED is set.  If TIF_FPU_UNLOADED
is clear, it would move the state to memory and set TIF_FPU_UNLOADED.
We'd call unload_user_fpstate() during context switch in the prev task
context and in kernel_fpu_begin().

The one major complication I know of is that PKRU is different from
all other FPU state in that it needs to be loaded when *kernel* code
does any user memory access.  So we'd need to make sure that context
switches load the new task's PKRU eagerly.  Using WRPKRU is easy, but,
unless we do something very clever, actually finding PKRU in the
in-memory fpstate image may be slightly nontrivial.

I suppose we could eagerly load the new FPU state on context switches,
but I'm not sure I see any point.  We'd still have to load it when we
switch back to user mode, so it would be slower but not necessarily
any simpler.

I'd love to review patches to make this change, but I don't have the
bandwidth to write them right now.
