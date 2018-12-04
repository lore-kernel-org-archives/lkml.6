Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA425C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77996206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:21:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PTQoG4aT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77996206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727157AbeLDRVO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 12:21:14 -0500
Received: from mail-lf1-f51.google.com ([209.85.167.51]:44719 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbeLDRVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 12:21:13 -0500
Received: by mail-lf1-f51.google.com with SMTP id z13so12534908lfe.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 09:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=frCayHFgjLGgzvQSrHOWPLeGXNjD4qzP/3lgGoFKbUU=;
        b=PTQoG4aT5LSo/nLg+JDEihosV9Ua9QcgnHAClv1InF4DwQtU2bzaUzal5aPPE3r7qh
         O9TuV26L4sH6qd3t7mxmjH248dlSkxWYAiPC2LHe6txs4fHXpmNDbWLZdPfFp45lSesz
         LH3Ehk5+yJIvhQXTnmOFE2nNYTNl4wZzb88Mo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=frCayHFgjLGgzvQSrHOWPLeGXNjD4qzP/3lgGoFKbUU=;
        b=ptRmkycaju4mNdYmzsCtZET3t3B6nQX8a4ycMKDCO+mQQxXB9JM1L2aWYaZIogNsWe
         AesBTlmPTrJBT1PWBWpUh23/seDEF6Gvfq1XcOt0AMNZBJseOlOlWdtX1g/NFI2mmyj9
         y1PFlWONbngoQ9l8/hV9nbL+wP7c08PvdPTx+IEQKKG4Tau5vkC6UklboFfpDjSww9cK
         aYKbtJPapkD4dSBN9DNMPOzOfcnTuw7xe7oAqOk3dGG+sj+cWTwAxjaXkbgEUH4GIh6k
         ApU7I4C0WB9VhSG7OZT+roTp3+l1VIUaaFXg+came5hI3YJ3cq+xC5ec4Y2NXYTo2AcL
         eJ/A==
X-Gm-Message-State: AA+aEWZUivb5wynHO5vGQ777NXN9G4ti0XQ0bgCFPTYXz1nFVGDmmb0X
        q7HWa2dggNEwHbmHIV4pJ2Z2mH+akA8=
X-Google-Smtp-Source: AFSGD/VXFmxilGCWYa6N9/87H9n/RvXYQXyQw4eFo5U4DPA8CBLJNkghL4ZUVLY+FeQMCL2lJut/1Q==
X-Received: by 2002:a19:8f45:: with SMTP id r66mr13310812lfd.9.1543944071130;
        Tue, 04 Dec 2018 09:21:11 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id e82sm3100338lfg.34.2018.12.04.09.21.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 09:21:09 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id p86so12557964lfg.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 09:21:09 -0800 (PST)
X-Received: by 2002:a19:4287:: with SMTP id p129mr12958203lfa.135.1543944068525;
 Tue, 04 Dec 2018 09:21:08 -0800 (PST)
MIME-Version: 1.0
References: <20181125183328.318175777@linutronix.de> <20181125185006.051663132@linutronix.de>
 <CAHk-=whtiX45YPjFPMFuktZ3WB23zqBZR-rL6RewrTyvrFj2Fw@mail.gmail.com> <f4b903ef-828c-0b05-29c6-6f71677d120d@linux.intel.com>
In-Reply-To: <f4b903ef-828c-0b05-29c6-6f71677d120d@linux.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 4 Dec 2018 09:20:52 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj7h=eCrvEPuO_AJ2Y5T5akTQPs5cLA811O64wORf+NyQ@mail.gmail.com>
Message-ID: <CAHk-=wj7h=eCrvEPuO_AJ2Y5T5akTQPs5cLA811O64wORf+NyQ@mail.gmail.com>
Subject: Re: [patch V2 27/28] x86/speculation: Add seccomp Spectre v2 user
 space protection mode
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Jiri Kosina <jkosina@suse.cz>, thomas.lendacky@amd.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>, dave.hansen@intel.com,
        Casey Schaufler <casey.schaufler@intel.com>,
        "Mallick, Asit K" <asit.k.mallick@intel.com>,
        "Van De Ven, Arjan" <arjan@linux.intel.com>, jcm@redhat.com,
        longman9394@gmail.com, Greg KH <gregkh@linuxfoundation.org>,
        david.c.stewart@intel.com, Kees Cook <keescook@chromium.org>,
        jason.w.brandt@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 3, 2018 at 5:38 PM Tim Chen <tim.c.chen@linux.intel.com> wrote:
>
> To make the usage of STIBP and its working principles clear,
> here are some additional explanations of STIBP from our Intel
> HW architects.  This should also help answer some of the questions
> from Thomas and others on STIBP's usages with IBPB and IBRS.
>
> Thanks.
>
> Tim
>
> ---
>
> STIBP
> ^^^^^
> Implementations of STIBP on existing Core-family processors (where STIBP
> functionality was added through a microcode update) work by disabling
> branch predictors that both:
>
>     1. Contain indirect branch predictions for both hardware threads, and
>     2. Do not contain a dedicated thread ID bit

Honestly, it still feels entirely misguided to me.

The above is not STIBP. It's just "disable IB". There's nothing "ST" about it.

So on processors where there is no thread ID bit (or per-thread
predictors), Intel simply SHOULD NOT EXPOSE this at all.

As it is, I refuse to call this shit "STIBP", because on current CPU's
that's simply a lie.

Being "technically correct" is not an excuse. It's just lying. I would
really hope that we restrict the lying to politicians, and not do it
in technical documentation.

               Linus
