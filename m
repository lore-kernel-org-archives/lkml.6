Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAAA5C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 15:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7E9D206B2
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 15:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZuHgMBQt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7E9D206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbeJMWtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 18:49:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:49848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726292AbeJMWtr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 18:49:47 -0400
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27BE72150F
        for <linux-kernel@vger.kernel.org>; Sat, 13 Oct 2018 15:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539443535;
        bh=3DQgUXjim3DE86Q1Dhg416AjsygSI2y0jVlyMqk7/P4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZuHgMBQt/o1ijt/hy45c/Vv7LKL4arCtmPXejONfx1UUOlf8mvqqLRXaWM9Vi6wcy
         PasTG30KTFRSgd1RwS8fCcR7JKzmoyAnAKo2HR/ftqCZ2uh0HsvLmIyY4G41jdVREZ
         ZvJ078JEVnySOuyWXdwvZ0anu4pATeHdIr+lFDiI=
Received: by mail-wm1-f48.google.com with SMTP id 206-v6so14881891wmb.5
        for <linux-kernel@vger.kernel.org>; Sat, 13 Oct 2018 08:12:15 -0700 (PDT)
X-Gm-Message-State: ABuFfoiHY856Q+t2OQVHI2S88HOehHcBi0H0YdL+ec6/IV/V56NeVQa4
        4Al/7VuR966r4QWAS/1064e5roWynl6uXf+cI5LCMg==
X-Google-Smtp-Source: ACcGV61utiAa6YjKFFahIA2+BL4OFMsQN0rQQzI2yz/mYvckE1xj/oXZvpqvmiE3gfR3IZaGtf1sylfpSf2y8m8NxBE=
X-Received: by 2002:a1c:f312:: with SMTP id q18-v6mr8109368wmq.14.1539443533428;
 Sat, 13 Oct 2018 08:12:13 -0700 (PDT)
MIME-Version: 1.0
References: <1531906876-13451-1-git-send-email-joro@8bytes.org>
 <1531906876-13451-11-git-send-email-joro@8bytes.org> <97421241-2bc4-c3f1-4128-95b3e8a230d1@siemens.com>
 <35a24feb-5970-aa03-acbf-53428a159ace@web.de>
In-Reply-To: <35a24feb-5970-aa03-acbf-53428a159ace@web.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 13 Oct 2018 08:12:01 -0700
X-Gmail-Original-Message-ID: <CALCETrWveao7jthnfKr5F=UyEpyowP0VA20eZi5OxizgT05EDA@mail.gmail.com>
Message-ID: <CALCETrWveao7jthnfKr5F=UyEpyowP0VA20eZi5OxizgT05EDA@mail.gmail.com>
Subject: Re: [PATCH] x86/entry/32: Fix setup of CS high bits
To:     jan.kiszka@web.de
Cc:     Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Lutomirski <luto@kernel.org>,
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
        Andrea Arcangeli <aarcange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 13, 2018 at 3:02 AM Jan Kiszka <jan.kiszka@web.de> wrote:
>
> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> Even if we are not on an entry stack, we have to initialize the CS high
> bits because we are unconditionally evaluating them
> PARANOID_EXIT_TO_KERNEL_MODE. Failing to do so broke the boot on Galileo
> Gen2 and IOT2000 boards.
>
> Fixes: b92a165df17e ("x86/entry/32: Handle Entry from Kernel-Mode on Entry-Stack")
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  arch/x86/entry/entry_32.S | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
> index 2767c625a52c..95c94d48ecd2 100644
> --- a/arch/x86/entry/entry_32.S
> +++ b/arch/x86/entry/entry_32.S
> @@ -389,6 +389,12 @@
>          * that register for the time this macro runs
>          */
>
> +       /*
> +        * Clear unused upper bits of the dword containing the word-sized CS
> +        * slot in pt_regs in case hardware didn't clear it for us.
> +        */
> +       andl    $(0x0000ffff), PT_CS(%esp)
> +

Please improve the comment. Since commit:

commit 385eca8f277c4c34f361a4c3a088fd876d29ae21
Author: Andy Lutomirski <luto@kernel.org>
Date:   Fri Jul 28 06:00:30 2017 -0700

    x86/asm/32: Make pt_regs's segment registers be 16 bits

Those fields are genuinely 16 bit.  So the comment should say
something like "Those high bits are used for CS_FROM_ENTRY_STACK and
CS_FROM_USER_CR3".

Also, can you fold something like this in:

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 2767c625a52c..358eed8cf62a 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -171,7 +171,7 @@
        ALTERNATIVE "jmp .Lend_\@", "", X86_FEATURE_PTI
        .if \no_user_check == 0
        /* coming from usermode? */
-       testl   $SEGMENT_RPL_MASK, PT_CS(%esp)
+       testb   $SEGMENT_RPL_MASK, PT_CS(%esp)
        jz      .Lend_\@
        .endif
        /* On user-cr3? */
