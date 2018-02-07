Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754509AbeBGTBe (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 14:01:34 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:41750 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754149AbeBGTBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 14:01:32 -0500
X-Google-Smtp-Source: AH8x226vqojca9Fxq3paFr2mC3B9QeA8f/6rUTWOvA3zhmg3Iff/hhO1UjwwXE0kdKqQAFp6MMwqPmnfSFVvl2xbhdU=
MIME-Version: 1.0
In-Reply-To: <cab93459-5c44-4049-ae7e-096e37d43737@infradead.org>
References: <5a7ae6af.WSMpvDEeUt6oucKB%fengguang.wu@intel.com>
 <CA+55aFxU7TArLUdcndeLnhfRKLO-Vu-1d0Q6VPb9NYt+-S-LNg@mail.gmail.com> <cab93459-5c44-4049-ae7e-096e37d43737@infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 7 Feb 2018 11:01:29 -0800
X-Google-Sender-Auth: faHirCX9MpS_SlrXIlkNjbP3DB8
Message-ID: <CA+55aFwV6qePNO9YbjN2ezXcGaF1dPcrcXyTq=1kOcABQ7+TaA@mail.gmail.com>
Subject: Re: [linus:master] BUILD REGRESSION a2e5790d841658485d642196dbb0927303d6c22f
To: Randy Dunlap <rdunlap@infradead.org>
Cc: kbuild test robot <fengguang.wu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 7, 2018 at 10:38 AM, Randy Dunlap <rdunlap@infradead.org> wrote:
> On 02/07/2018 10:13 AM, Linus Torvalds wrote:
>>
>> That said, intel only _documents_ UD2 (0f 0b).
>
> Intel Order Number: 325383-064US, October 2017, documents UD0, UD1, and UD2.
> Section A.2.5, Table A-1, says:

Ahh, I had an older version.

Looking at the latest one I can find (325462-065US), it does specify
that it has a modrm byte:

  0F FF /r   UD0 1 r32, r/m32

so I think that our opcode maps are wrong, and it's a bit dangerous to
put random constants right after the UD0.

Maybe we should make our use of UD0 have a third byte: add a harmless
modrm byte before the warning constants?

But yes, at least my objdump just thinks it's a bad 2-byte sequence,
and doesn't look at any modrm bytes at all.

                Linus
