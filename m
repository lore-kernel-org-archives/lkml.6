Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753331AbeBEQjD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 11:39:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:48086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752925AbeBEQiy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 11:38:54 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BD69217BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
X-Google-Smtp-Source: AH8x226irGw7X73C1bP/hJ3Wu8VUeyl8ZY2OfYedMhyRtMfqUEoMfbDmKDrhgeVzqkA5OaLox6YcR5Y278AD/yFCmkM=
MIME-Version: 1.0
In-Reply-To: <20180205162659.kimgef6dkskc6quq@gmail.com>
References: <151770009169.7213.12476757146099518628.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151770009703.7213.12036560755602017391.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAMzpN2jeq+LDajvwSALpmaZKOChNX1uhRbuEJ3v97HyOEsH44A@mail.gmail.com>
 <CAPcyv4gy=Oq5=ZXCvs0mgziwfgEb2p+pE9BJZZP47W+4yrz0Vg@mail.gmail.com>
 <CA+55aFzC03b5VASq3xjLhU4WAA=gwqKNT2i6-9OBPQd-G_AHEA@mail.gmail.com> <20180205162659.kimgef6dkskc6quq@gmail.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Mon, 5 Feb 2018 16:38:33 +0000
X-Gmail-Original-Message-ID: <CALCETrU4S3owtVF5_zVMxH_dXox6HXBbb-Q3+GzTQ-RU_xqgcw@mail.gmail.com>
Message-ID: <CALCETrU4S3owtVF5_zVMxH_dXox6HXBbb-Q3+GzTQ-RU_xqgcw@mail.gmail.com>
Subject: Re: [PATCH 1/3] x86/entry: Clear extra registers beyond syscall
 arguments for 64bit kernels
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Brian Gerst <brgerst@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
        Andi Kleen <ak@linux.intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 5, 2018 at 4:26 PM, Ingo Molnar <mingo@kernel.org> wrote:
>
> * Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
>> [...]
>>
>> But as the commit message says, the system call argument registers are
>> also likely to be aggressively clobbered unless used, since the low
>> registers are preferred for code generation (smaller code, and many of
>> them are special anyway in various ways and have forced uses for
>> shifts, function arguments, or just are special in general like %rax).
>>
>> So the actual argument registers tend to not be an issue anyway.
>

>
> So I submit that we should probably extend the register clearing/sanitization to
> R10 and R11 as well, because while they are technically caller-saved and freely
> clobberable, in practice they don't get clobbered all that often and there might
> be various code paths into complex system calls where these R10/R11 values survive
> just fine and can be used in Spectre gadgets.


Maybe R11, but we have to be careful, since R11 is used as scratch
space in a bunch of the asm.  Clearing R10 is mostly useless in the
syscall path because we'll just unconditionally reload it in
do_syscall_64().  If we manage to change the way syscall wrappers
work, then we can think about clearing R10 and maybe even more regs.
