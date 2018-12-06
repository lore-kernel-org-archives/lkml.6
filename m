Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AADA4C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6598E20868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JzQFlNcp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6598E20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725984AbeLFSP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 13:15:29 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41448 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbeLFSP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 13:15:28 -0500
Received: by mail-lf1-f66.google.com with SMTP id c16so1058771lfj.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 10:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yjaI9EIjhMeyEcd+7fU+c//AJmqzUhVXJJD+k1+XWKE=;
        b=JzQFlNcpKtAxsBBKZgR9TgNyuNSJaKrwXWgjx92htfytb080iwN4ki6H8NkRiOHHFD
         hS3T1TlJx4TM+fsXF1FVrqfJyXStQasDERNUwz6aqILmR8NUNSrFl4p15ozKfhgXMhPD
         PWKETm+yQ6QeyNGfZdTRvpH0b5hesuUT1U+o4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yjaI9EIjhMeyEcd+7fU+c//AJmqzUhVXJJD+k1+XWKE=;
        b=gPWa20jrl7/M0+nSem1/vDWQrJZd35HIWpVmpZITtmhZG7T3PsPdpzKftiMUnEOCxs
         Qy43DWkuwH8z+i8M3zh6NViZUMRtVtXW3uN6c3rbOR3IqhxnNf0iopOXigM8Y43V5rHs
         b2xbU1BKOYTT++e6H44GnT3ql8JaXW0rgrca6I6EOzsvA3ax+9MWTv/8qm3/S8njWOY0
         Fxn+Xa40ltFZbI+t4I1tHN16YpMPLNMIiZa82YK0DOt+PwdJqhal4BiCjCASCD4wtc3y
         0fZE5++6oMEM3t8NgQne1Rfzvb9VpYxEJOgQfSDQdYlsB+V5XvqCNTmzXch/WioOMmzT
         yoBw==
X-Gm-Message-State: AA+aEWZB8AjkxbtV/gJUv3yQaCRT7V2Ah7x/IhYM9g6xvUxI6zLETBqy
        ohIRG8D8FV+k0WbGINePI/AqXjmU2Wg=
X-Google-Smtp-Source: AFSGD/ViRY6Q21Oe1/RinFxS8qaCNuThqbConx3RyBp9DblU7MKYID8+j9uGGA5lyeCHANjeiTqZZA==
X-Received: by 2002:a19:f204:: with SMTP id q4mr18667879lfh.133.1544120126158;
        Thu, 06 Dec 2018 10:15:26 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id p77-v6sm212380lja.0.2018.12.06.10.15.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 10:15:25 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id n18so1071286lfh.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 10:15:24 -0800 (PST)
X-Received: by 2002:a19:3fcf:: with SMTP id m198mr16822120lfa.106.1544120124263;
 Thu, 06 Dec 2018 10:15:24 -0800 (PST)
MIME-Version: 1.0
References: <20181205163624.1842-1-sean.j.christopherson@intel.com> <20181206073409.GA64887@gmail.com>
In-Reply-To: <20181206073409.GA64887@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 6 Dec 2018 10:15:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgrpUQyux2ZTJj8FUEdHcEoM0KUNrN3KCc+bBhi0fRhaQ@mail.gmail.com>
Message-ID: <CAHk-=wgrpUQyux2ZTJj8FUEdHcEoM0KUNrN3KCc+bBhi0fRhaQ@mail.gmail.com>
Subject: Re: [PATCH] x86/mm/fault: Streamline the fault error_code decoder
 some more
To:     Ingo Molnar <mingo@kernel.org>
Cc:     sean.j.christopherson@intel.com, dave.hansen@linux.intel.com,
        Andrew Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, bp@alien8.de,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Peter Anvin <hpa@zytor.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>, yu-cheng.yu@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 5, 2018 at 11:34 PM Ingo Molnar <mingo@kernel.org> wrote:
>
> Yeah, so I don't like the overly long 'SUPERVISOR' and the somewhat
> inconsistent, sporadic handling of negatives. Here's our error code bits:
>
> /*
>  * Page fault error code bits:
>  *
>  *   bit 0 ==    0: no page found       1: protection fault
>  *   bit 1 ==    0: read access         1: write access
>  *   bit 2 ==    0: kernel-mode access  1: user-mode access

No. Really not at all.

Bit 2 is *not* "kernel vs user".  Never has been. Never will be.

It's a single bit that mixes up *three* different cases:

 - regular user mode access (value: 1)

 - regular CPL0 access (value: 0)

 - CPU system access (value: 0)

and that third case really is important and relevant. And importantly,
it can happen from user space.

In fact, these days we possibly have a fourth case:

 - kernel access using wruss (value: 1)

and I'd rather see just the numbers (which you have to know to decode)
than see the simplified AND WRONG decoding of those numbers.

Please don't ever confuse the fault U/S bit with "user vs kernel".
It's just not true, and people should be very very aware of it now
being true.

If you care whether a page fault happened in user mode or not, you
have to look at the register state (ie "user_mode(regs)").

Please call the U/S bit something else than "user" or "kernel".

           Linus
