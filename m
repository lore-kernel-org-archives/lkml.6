Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F85BECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 18:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07F06206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 18:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AAfeTLz0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07F06206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391263AbeIVAZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 20:25:07 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:47082 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391089AbeIVAZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 20:25:07 -0400
Received: by mail-yb1-f193.google.com with SMTP id y20-v6so5809207ybi.13
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 11:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sExD8i4jvCOL4Zp3pZc8aNg2i3wRkgAenXJfeRMHAeU=;
        b=AAfeTLz0anYwKN6H2xdtOLNgrcV1q07Bv5nYNs564RK8hzB3Z3lppjfmamIOxnJQH9
         MkhrlIFgCbwlevlKQjT/QQLXvbKqLz1D3W+gsPjS/RZ/iZ6wwtd8t7ZvgDyztiZ5C/O/
         hJ+AzsehDFo2uxv4db6IuIkW3YO+ydmkfMGkg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sExD8i4jvCOL4Zp3pZc8aNg2i3wRkgAenXJfeRMHAeU=;
        b=Gi24vNw1fEr5KlOD23D5LQanUQVzkSKlPiC8zcq8kIVP+LpZ10u9YVu7KNZVvgvyf9
         jjTkKUTCZX6zM9KE8I7uOSV1BwB3cXQxhEeCmelNu160igklZbxQeZSRlT1pO5TBThvg
         17jTU8jgnFNTStJLDV+CT2IGWC9NAIeGKekR7ThttBbI0jDnRHavGsv8QCUbFYR8l15y
         wR4BiA4ZvY/mfJTDLgM8M6t3W+0kLXGVfOnr1vDEQD6FQxZpCpRJwBAj+9vZirADy7L0
         2YY1ofhcZCOmfranBeu0UDR0GAEuoLjxVjwd/6DfvoyUEXvGUNfqRHfvKUokRVby3ao6
         s8mQ==
X-Gm-Message-State: APzg51A/E1u2wfYu9DQs43jkZI3QQTKAWnMkdi/suRaHfYST7ML7RPrC
        P4uX0cNX/BNWHDyJA6ZQVS7+WGaMjeY=
X-Google-Smtp-Source: ANB0VdY2IJKVN+vCU3a/dY6WVHJEjzlgiBXbfLmwwdmRzbVMHulqw6i+dzmJVfXmr3KhD3e//HVbDA==
X-Received: by 2002:a25:5485:: with SMTP id i127-v6mr4303285ybb.23.1537554899533;
        Fri, 21 Sep 2018 11:34:59 -0700 (PDT)
Received: from mail-yw1-f41.google.com (mail-yw1-f41.google.com. [209.85.161.41])
        by smtp.gmail.com with ESMTPSA id p126-v6sm7321440ywf.22.2018.09.21.11.34.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 11:34:59 -0700 (PDT)
Received: by mail-yw1-f41.google.com with SMTP id x83-v6so5573872ywd.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 11:34:59 -0700 (PDT)
X-Received: by 2002:a0d:fe87:: with SMTP id o129-v6mr4468409ywf.237.1537554398910;
 Fri, 21 Sep 2018 11:26:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Fri, 21 Sep 2018 11:26:38
 -0700 (PDT)
In-Reply-To: <20180918212847.199085-1-namit@vmware.com>
References: <20180918212847.199085-1-namit@vmware.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 21 Sep 2018 11:26:38 -0700
X-Gmail-Original-Message-ID: <CAGXu5jK307b+bs6h-1f6dhRCj3HfoQQmbACuurOE9RbhzijHAQ@mail.gmail.com>
Message-ID: <CAGXu5jK307b+bs6h-1f6dhRCj3HfoQQmbACuurOE9RbhzijHAQ@mail.gmail.com>
Subject: Re: [PATCH v8 00/10] x86: macrofying inline asm for better compilation
To:     Nadav Amit <namit@vmware.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Alok Kataria <akataria@vmware.com>,
        Christopher Li <sparse@chrisli.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Jan Beulich <JBeulich@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Sparse Mailing-list <linux-sparse@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        virtualization@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 2:28 PM, Nadav Amit <namit@vmware.com> wrote:
> This patch-set deals with an interesting yet stupid problem: kernel code
> that does not get inlined despite its simplicity. There are several
> causes for this behavior: "cold" attribute on __init, different function
> optimization levels; conditional constant computations based on
> __builtin_constant_p(); and finally large inline assembly blocks.
>
> This patch-set deals with the inline assembly problem. I separated these
> patches from the others (that were sent in the RFC) for easier
> inclusion. I also separated the removal of unnecessary new-lines which
> would be sent separately.
>
> The problem with inline assembly is that inline assembly is often used
> by the kernel for things that are other than code - for example,
> assembly directives and data. GCC however is oblivious to the content of
> the blocks and assumes their cost in space and time is proportional to
> the number of the perceived assembly "instruction", according to the
> number of newlines and semicolons. Alternatives, paravirt and other
> mechanisms are affected, causing code not to be inlined, and degrading
> compilation quality in general.
>
> The solution that this patch-set carries for this problem is to create
> an assembly macro, and then call it from the inline assembly block.  As
> a result, the compiler sees a single "instruction" and assigns the more
> appropriate cost to the code.
>
> To avoid uglification of the code, as many noted, the macros are first
> precompiled into an assembly file, which is later assembled together
> with the C files. This also enables to avoid duplicate implementation
> that was set before for the asm and C code. This can be seen in the
> exception table changes.
>
> Overall this patch-set slightly increases the kernel size (my build was
> done using my Ubuntu 18.04 config + localyesconfig for the record):
>
>    text    data     bss     dec     hex filename
> 18140829 10224724 2957312 31322865 1ddf2f1 ./vmlinux before
> 18163608 10227348 2957312 31348268 1de562c ./vmlinux after (+0.1%)
>
> The number of static functions in the image is reduced by 379, but
> actually inlining is even better, which does not always shows in these
> numbers: a function may be inlined causing the calling function not to
> be inlined.
>
> I ran some limited number of benchmarks, and in general the performance
> impact is not very notable. You can still see >10 cycles shaved off some
> syscalls that manipulate page-tables (e.g., mprotect()), in which
> paravirt caused many functions not to be inlined. In addition this
> patch-set can prevent issues such as [1], and improves code readability
> and maintainability.
>
> [1] https://patchwork.kernel.org/patch/10450037/
>
> v7->v8: * Add acks (Masahiro, Max)
>         * Rebase on 4.19 (Ingo)

I've tested the series for booting and with the refcount lkdtm tests.
Looks good, thanks!

Tested-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
