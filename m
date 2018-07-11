Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90416C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 496FF2083D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dLkTS7pN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 496FF2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388483AbeGKQd5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 12:33:57 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:43831 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbeGKQd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 12:33:57 -0400
Received: by mail-io0-f193.google.com with SMTP id y10-v6so9487613ioa.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 09:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6mAhl+CODAPJ2AgKAbYGX1tJG5WxvwYIDQl2vaEkf8c=;
        b=dLkTS7pNQqKfVUKOHYsPJavI7YnvQBOQmSJ97n8wYuYkfxRKEkgvVdiF7XOKTXriuN
         2Id0AzwLzabZ0dcicU8OWY6ra+pY4lO3OLuJdVaIb9PTYIaJyZgec7iLjh3fr1oftOBU
         rH81C1NEFKljnGNDFlM1WLshZGDDztDXgtZCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6mAhl+CODAPJ2AgKAbYGX1tJG5WxvwYIDQl2vaEkf8c=;
        b=NXPZN9kbBlPXQPZ6NskPz7c25kFcSUVfWOnRNxX/N6Ha2L8SMvL4Z9Vherro41ZghJ
         GEO8CGHY/g+uJUwXVbdUTUSfUqMoV+q7NR4wfVuMEYQt/HYyP1R9YIZLhcyvh+Dd6MET
         7/JSCbdfBTMo69P3wSE0iqtzf7VHbKcTNTBZgnvkPu5RlEiwETfuXx4MzwNgkrMaUn7l
         do45KwfKuvbRm+qJ0p0oO5b1kugpvgLQi2alDM8tb5F1y3VfkTyK5/jz1l3b+hURJW3M
         qEWgtV4/wQ0hF9Dtgc3m+cZyxl8+u6v2FPvwmKm5EPagb26rxy5bPhpbbF+qh0JB3TMo
         +T/Q==
X-Gm-Message-State: APt69E2yUkW8B/4/1FCWV7y9l0SVTk4cddNuBtGY169DSMPxYV5Mhqs5
        HKb1lXW3hiMYFkJ7XS0sf8VaUAkhE+BUu8XXEDI=
X-Google-Smtp-Source: AAOMgpfJ2zKeo/i3Jb2Dfwv+dXYW5yVA3jsidYIg5OfoN1DAruVmm+MijffnVRcY3U0gGj6/kUkdBgWCEP3VxRzLhhU=
X-Received: by 2002:a02:2b12:: with SMTP id h18-v6mr22214371jaa.10.1531326530605;
 Wed, 11 Jul 2018 09:28:50 -0700 (PDT)
MIME-Version: 1.0
References: <1531308586-29340-1-git-send-email-joro@8bytes.org>
In-Reply-To: <1531308586-29340-1-git-send-email-joro@8bytes.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 11 Jul 2018 09:28:39 -0700
Message-ID: <CA+55aFzrG+GV5ySVUiiod8Va5P0_vmUuh25Pner1r7c_aQgH9g@mail.gmail.com>
Subject: Re: [PATCH 00/39 v7] PTI support for x86-32
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Peter Anvin <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Brian Gerst <brgerst@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Eduardo Valentin <eduval@amazon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>,
        "Liguori, Anthony" <aliguori@amazon.com>,
        Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
        Hugh Dickins <hughd@google.com>,
        Kees Cook <keescook@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        "David H . Gutteridge" <dhgutteridge@sympatico.ca>,
        Joerg Roedel <jroedel@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 4:30 AM Joerg Roedel <joro@8bytes.org> wrote:
>
> I did the load-testing again with 'perf top', the ldt_gdt
> self-test and a kernel-compile running in a loop again.

So none of the patches looked scary to me, but then, neither did
earlier versions.

It's the testing that worries me most. Pretty much no developers run
32-bit any more, and I'd be most worried about the odd interactions
that might be hw-specific. Some crazy EFI mapping setup or the similar
odd case that simply requires a particular configuration or setup.

But I guess those issues will never be found until we just spring this
all on the unsuspecting public.

                 Linus
