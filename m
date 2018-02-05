Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751910AbeBEWZI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 17:25:08 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:36658 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750796AbeBEWZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 17:25:04 -0500
X-Google-Smtp-Source: AH8x224PgtzmLbH0AR65tqDlGg6BVbOvcEXgWwsc2gQf5qJ/RM1TDD7vCzYCx0Bcp1iUi3YOyPS7aYxgn+POI335Cyo=
MIME-Version: 1.0
In-Reply-To: <CA+55aFyxgnVP1C3bgNDgX01NZi2x=FYjAw=YHAdn17ENS9P7bg@mail.gmail.com>
References: <151776623555.23236.14152911329227555005.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151776624080.23236.1865339140666550495.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180205115836.otnviqbae3pxjk5g@gmail.com> <CAPcyv4gyP4LAzS=8-ZNfy5gX=QHKK7VpGmeYXoP=rbe47kOg9A@mail.gmail.com>
 <CA+55aFyvGkuM33C8ki=5-11idWWK4tHKuPaSrSb0FPTaJmC_iQ@mail.gmail.com>
 <CALCETrV_7dxKAgwNyfDbvQ+0nTJG6NJqbKkngZyU-VPA3fvg8Q@mail.gmail.com> <CA+55aFyxgnVP1C3bgNDgX01NZi2x=FYjAw=YHAdn17ENS9P7bg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 5 Feb 2018 14:25:02 -0800
X-Google-Sender-Auth: gYKlyyONT7gFrFIhxgK8tcKYXwY
Message-ID: <CA+55aFy=Nb0Qp50SbArw2S+9frMOeHNXs0WuaEwacfip41HK9Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] x86/entry: Clear extra registers beyond syscall
 arguments for 64bit kernels
To: Andy Lutomirski <luto@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Andi Kleen <ak@linux.intel.com>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 5, 2018 at 2:22 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> But I'm not timing it.

I lied.

I did this:

        for (i = 0; i < 100000; i++)
                asm(".rept 16384\n"
                "subq $128,%rsp\n\t"
                "pushq %rbx\n\t"
                "pushq %r10\n\t"
                "pushq %r11\n\t"
                "pushq %r12\n\t"
                "pushq %r13\n\t"
                "pushq %r14\n\t"
                "pushq %r15\n\t"

                "popq %r15\n\t"
                "popq %r14\n\t"
                "popq %r13\n\t"
                "popq %r12\n\t"
                "popq %r11\n\t"
                "popq %r10\n\t"
                "popq %rbx\n\t"
                "addq $128,%rsp\n\t"
                ".endr");

and then I timed it like that, and with "xorq" of the register after
each "pushq".

And the timings came out the same, to within the (bad) timing I did.

So I really do think you can just put the xor right next to the push,
and it will be effectively free.

            Linus
