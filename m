Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B574ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C45B22084A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="urqhv9Hf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C45B22084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388153AbeGTR7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 13:59:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:57344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731556AbeGTR7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 13:59:00 -0400
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C5D72086D
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 17:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532106588;
        bh=sBw5Hd+gWC18fpJE8J4gLAQMCg1CCO4ZvoLRrhiV45c=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=urqhv9HfpnuGzoN92MmhUQp05gLb8EjSVazmIV6GSnhH1vSh61MwohLsLkJYQkHw5
         ElPVTulJkUvsxyWmyd9+1Pb/sh/DX7ypOiNXBs6vbZQ2tHxVkQzB8SA0+76w2tamLg
         xl799WWQiFr7flGF6HBgplVABN58+wVkrIALiSes=
Received: by mail-wr1-f53.google.com with SMTP id q10-v6so11953894wrd.4
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 10:09:48 -0700 (PDT)
X-Gm-Message-State: AOUpUlG8UicjSCdWHLnkGn0ktCUWx6ppMx1JYJkeZi0w1Ls5LnqfMpH5
        WslHXOR/xa2rchXNHbfqQoqrfafqHdrnLbDJ3lZmRw==
X-Google-Smtp-Source: AAOMgpdwEZ+0NtNKrKeLGbrSjFOZ4h2Ag9gyjvTCfou5pKJ3lM/jryn0MUczIRFi/5mFk6k+KmTK007fpMfxi3dtwIM=
X-Received: by 2002:adf:8325:: with SMTP id 34-v6mr2007828wrd.67.1532106586541;
 Fri, 20 Jul 2018 10:09:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:d548:0:0:0:0:0 with HTTP; Fri, 20 Jul 2018 10:09:26
 -0700 (PDT)
In-Reply-To: <1532103744-31902-4-git-send-email-joro@8bytes.org>
References: <1532103744-31902-1-git-send-email-joro@8bytes.org> <1532103744-31902-4-git-send-email-joro@8bytes.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 20 Jul 2018 10:09:26 -0700
X-Gmail-Original-Message-ID: <CALCETrWmd3arHdkTzAS7reLRjm96jrJC-1O5dYAPwbh2EqKMSA@mail.gmail.com>
Message-ID: <CALCETrWmd3arHdkTzAS7reLRjm96jrJC-1O5dYAPwbh2EqKMSA@mail.gmail.com>
Subject: Re: [PATCH 3/3] x86/entry/32: Copy only ptregs on paranoid entry/exit path
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Brian Gerst <brgerst@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Eduardo Valentin <eduval@amazon.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>,
        "Liguori, Anthony" <aliguori@amazon.com>,
        Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
        Hugh Dickins <hughd@google.com>,
        Kees Cook <keescook@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        "David H . Gutteridge" <dhgutteridge@sympatico.ca>,
        Joerg Roedel <jroedel@suse.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 9:22 AM, Joerg Roedel <joro@8bytes.org> wrote:
> From: Joerg Roedel <jroedel@suse.de>
>
> The code that switches from entry- to task-stack when we
> enter from kernel-mode copies the full entry-stack contents
> to the task-stack.
>
> That is because we don't trust that the entry-stack
> contents. But actually we can trust its contents if we are
> not scheduled between entry and exit.
>
> So do less copying and move only the ptregs over to the
> task-stack in this code-path.
>
> Suggested-by: Andy Lutomirski <luto@amacapital.net>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  arch/x86/entry/entry_32.S | 70 +++++++++++++++++++++++++----------------------
>  1 file changed, 38 insertions(+), 32 deletions(-)
>
> diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
> index 2767c62..90166b2 100644
> --- a/arch/x86/entry/entry_32.S
> +++ b/arch/x86/entry/entry_32.S
> @@ -469,33 +469,48 @@
>          * segment registers on the way back to user-space or when the
>          * sysenter handler runs with eflags.tf set.
>          *
> -        * When we switch to the task-stack here, we can't trust the
> -        * contents of the entry-stack anymore, as the exception handler
> -        * might be scheduled out or moved to another CPU. Therefore we
> -        * copy the complete entry-stack to the task-stack and set a
> -        * marker in the iret-frame (bit 31 of the CS dword) to detect
> -        * what we've done on the iret path.
> +        * When we switch to the task-stack here, we extend the
> +        * stack-frame we copy to include the entry-stack %esp and a
> +        * pseudo %ss value so that we have a full ptregs struct on the
> +        * stack. We set a marker in the frame (bit 31 of the CS dword).
>          *
> -        * On the iret path we copy everything back and switch to the
> -        * entry-stack, so that the interrupted kernel code-path
> -        * continues on the same stack it was interrupted with.
> +        * On the iret path we read %esp from the PT_OLDESP slot on the
> +        * stack and copy ptregs (except oldesp and oldss) to it, when
> +        * we find the marker set. Then we switch to the %esp we read,
> +        * so that the interrupted kernel code-path continues on the
> +        * same stack it was interrupted with.


Can you give an example of the exact scenario in which any of this
copying happens and why it's needed?  IMO you should just be able to
*run* on the entry stack without copying anything at all.
