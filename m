Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752745AbeAaVBA convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 16:01:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:52512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752500AbeAaVA4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 16:00:56 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C5E8217A0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
X-Google-Smtp-Source: AH8x227k3zVXi9hxBBMW7tbOKuIrOPwrYytgdpQlXAT3Cz5/cFRb1I0olGwO/xm2wlQ3j/kSnEFfAB1AFTHeeJD0u6c=
MIME-Version: 1.0
In-Reply-To: <747E60F0-2315-4BEC-895E-0E29C57A0AF0@gmail.com>
References: <20180131201118.1694-1-namit@vmware.com> <BD28D2CF-CAD7-45A1-87D0-DE38F7B0EFE5@amacapital.net>
 <747E60F0-2315-4BEC-895E-0E29C57A0AF0@gmail.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Wed, 31 Jan 2018 13:00:35 -0800
X-Gmail-Original-Message-ID: <CALCETrXOvq6gdedFBwKPML=DhSWpPtRdZvsTpD5D=-GPhVuVKQ@mail.gmail.com>
Message-ID: <CALCETrXOvq6gdedFBwKPML=DhSWpPtRdZvsTpD5D=-GPhVuVKQ@mail.gmail.com>
Subject: Re: [PATCH] x86: Align TLB invalidation info
To: Nadav Amit <nadav.amit@gmail.com>
Cc: X86 ML <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2018 at 12:48 PM, Nadav Amit <nadav.amit@gmail.com> wrote:
> Andy Lutomirski <luto@amacapital.net> wrote:
>
>>
>>
>>> On Jan 31, 2018, at 12:11 PM, Nadav Amit <namit@vmware.com> wrote:
>>>
>>> The TLB invalidation info is allocated on the stack, which might cause
>>> it to be unaligned. Since this information may be transferred to
>>> different cores for TLB shootdown, this might result in an additional
>>> cache-line bouncing between the cores.
>>>
>>> GCC provides a way to deal with it by using
>>> __builtin_alloca_with_align(). Use it to avoid the bouncing cache lines.
>>
>> Eww.  How about __aligned?
>
> Err.. Stupid me. For some reason I remembered I tried it and it didn’t have
> the desired effect, which caused me to assume it does not work for variables
> on the stack. Anyhow, it does the work. I’ll submit v2.
>

You're probably remembering that __aligned(16) malfunctions on older
GCC versions.  But __aligned(64), which is what you want, has always
been okay AFAIK.
