Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752959AbeFEX1h (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 19:27:37 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:53446 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752431AbeFEX1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 19:27:36 -0400
X-Google-Smtp-Source: ADUXVKIZVdr1wqzLz/xoD2iT1651lWoaLBDAKiAC7ucN8sQJYGzI8c3n8azv9rFX4H0RQ5Me15TEXzTKSkywujVG6h8=
MIME-Version: 1.0
References: <20180604122132.GA3337@gmail.com> <CA+55aFx=zLkZx4h4rcWv79OKQSGJAwC3eS8=zSDgKjyrsbLrNA@mail.gmail.com>
 <20180605150514.GA31065@gmail.com> <20180605172243.GA2059@avx2>
 <CA+55aFxTve6FxLuvWyyD88ACOg+3eHKbpWUeuvNZMSB=AFfuqg@mail.gmail.com>
 <20180605224150.GA2051@avx2> <CA+55aFwt0SOns=tfsD9GCfbc9-xY04O5AWfKiQTroeH=edO7wQ@mail.gmail.com>
 <CA+55aFxz46_efiQw9Nk_pFbX3AYx+oehPQOk-BDd1Xpbr2Oa3w@mail.gmail.com> <20180605232022.GA4468@avx2>
In-Reply-To: <20180605232022.GA4468@avx2>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 5 Jun 2018 16:27:24 -0700
Message-ID: <CA+55aFxEwWespnh+=pmdUR6WkBresxde9eoXm2nHVUEw6ZzsyQ@mail.gmail.com>
Subject: Re: x86/asm: __clear_user() micro-optimization (was: "Re: [GIT PULL]
 x86/asm changes for v4.18")
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrew Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>, Peter Anvin <hpa@zytor.com>,
        Denys Vlasenko <dvlasenk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 5, 2018 at 4:20 PM Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> This is Broadwell Xeon E5-2620 v4.
> Which is somewhat strange indeed because it should be modern enough.

Yeah, odd.

Here's the benchmark I used:

  #define SIZE 4068

  int main(int argc, char **argv)
  {
    int i;
    unsigned char buffer[SIZE], *p;

    for (i = 0; i < 1000000; i++)
        asm volatile(
            "1: movq %[zero],(%[mem]); addq %[eight],%[mem]; decl
%[count]; jne 1b"
            : [mem] "=r" (p)
            : [zero] "i" (0l), [eight] "i" (8l),
             "0" (buffer), [count] "r" (SIZE/8));
  }

where you can change that "i" for [zero] and [eight] to be "r" to get
the register version.

I just timed it, because I'm lazy and perf seemed to be overkill.

It might be some very specific loop buffer issue or something.

Or maybe my benchmark above is broken, I didn't really verify that the
end result was any good (I just did an objdump to verify the asm code
superficially).

                 Linus
