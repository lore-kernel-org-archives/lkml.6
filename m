Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D7AC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 21:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C946420876
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 21:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZbMUWEmp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C946420876
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbeIGBvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 21:51:12 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:52655 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbeIGBvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 21:51:11 -0400
Received: by mail-it0-f67.google.com with SMTP id h3-v6so17733468ita.2;
        Thu, 06 Sep 2018 14:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EnYW6ky3ItoT2KivNLq/iXbl9f+ePTKUcOmgWI5+k2Y=;
        b=ZbMUWEmprABY+YRbPRJdMPpOUhWglTIyxdTbNeRNb2iXmku8eVAULCaqOIpsTpEvNQ
         DvTs9HGZl/GDigvQQYHVlapZj9YhV/WsFAu+7g2GayYhl4B5FTu3U1406MLZvi0fSG2U
         myAbiofGAyhHA8F90mbI3KFwEiMKUmFQJQ030=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EnYW6ky3ItoT2KivNLq/iXbl9f+ePTKUcOmgWI5+k2Y=;
        b=H7GhsNl8VxayFPe4lFXb6cq2wZTT0wyWqvpKyd43EbhJR2x5+r3Zj3pT+ebk1z57h6
         WQYYlnDyPZuNlamHjQT/vm+pLmajewQxb4+ogjSTWaNTSW/SriDSkmbO5naP9PAdXWRl
         qQw4iHVydw9O6ohPbtiRERv9YHFbMY0nM6Og7dzFYJ0PBwtivdMKxr8jDnxd2gYlJu59
         IQTiPcc/TEzZS09NgFlAQ64pIqpio7F1us4n8am3xcK7WHgtPKxTXJwoN57xZ5XrRRbZ
         L5X9hpCXZuwbqGW1L4EigSBlhsJhkPY0udZZML698ThIMA4YooXZs0h6ZNJHcKfgMGQZ
         1tbg==
X-Gm-Message-State: APzg51D3wTNys6PV4m4Gi+EpDbjHruEpz+YO/ug7M8qnV76CjiMaasME
        LGGv86lrWWqrikdVvccCgq61gn2qG3aOneKzBTA=
X-Google-Smtp-Source: ANB0VdZdNq0WBx5vFfZUu5v90Zk1b9LMwkztk3ipM1rc0mldeVBM6XgfathqdPs/Pj3iCABo9IuD+4LNJx+Ayv/qyk4=
X-Received: by 2002:a24:61d2:: with SMTP id s201-v6mr4750602itc.22.1536268432238;
 Thu, 06 Sep 2018 14:13:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1535629099.git.andreyknvl@google.com> <5d54526e5ff2e5ad63d0dfdd9ab17cf359afa4f2.1535629099.git.andreyknvl@google.com>
In-Reply-To: <5d54526e5ff2e5ad63d0dfdd9ab17cf359afa4f2.1535629099.git.andreyknvl@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 6 Sep 2018 14:13:41 -0700
Message-ID: <CA+55aFyW9N2tSb2bQvkthbVVyY6nt5yFeWQRLHp1zruBmb5ocw@mail.gmail.com>
Subject: Re: [PATCH v6 11/11] arm64: annotate user pointers casts detected by sparse
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>, eugenis@google.com,
        Lee.Smith@arm.com,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob.Bramley@arm.com, Ruben.Ayrapetyan@arm.com,
        cpandya@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 4:41 AM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> This patch adds __force annotations for __user pointers casts detected by
> sparse with the -Wcast-from-as flag enabled (added in [1]).

No, several of these are wrong, and just silence a warning that shows a problem.

So for example:

>  static inline compat_uptr_t ptr_to_compat(void __user *uptr)
>  {
> -       return (u32)(unsigned long)uptr;
> +       return (u32)(__force unsigned long)uptr;
>  }

this actually looks correct.

But:

> --- a/arch/arm64/include/asm/uaccess.h
> +++ b/arch/arm64/include/asm/uaccess.h
> @@ -76,7 +76,7 @@ static inline unsigned long __range_ok(const void __user *addr, unsigned long si
>  {
>         unsigned long ret, limit = current_thread_info()->addr_limit;
>
> -       __chk_user_ptr(addr);
> +       __chk_user_ptr((void __force *)addr);

This looks actively wrong. The whole - and only - point of
"__chk_user_ptr()" is that it warns about a lack of a "__user *" type.

So the above makes no sense at all.

There are other similar "that makes no sense what-so-ever", like this one:

> -               struct compat_group_req __user *gr32 = (void *)optval;
> +               struct compat_group_req __user *gr32 = (__force void *)optval;

no, the additionl of __force is not the right thing, the problem, is
that a __user pointer is cast to a non-user 'void *' only to be
assigned to another user type.

The fix should have been to use (void __user *) as the cast instead,
no __force needed.

In general, I think the patch shows all the signs of "mindlessly just
add casts", which is exactly the wrong thing to do to sparse warnings.

                   Linus
