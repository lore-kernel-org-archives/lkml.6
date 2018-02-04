Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752126AbeBDSko (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 13:40:44 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:41348 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751872AbeBDSki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 13:40:38 -0500
X-Google-Smtp-Source: AH8x226hlEV8k4Xntr/qY+L5qeHJtiYOO7SgSyyCe5tNA7D45PQzP2+2t2psovMmilfONfWKqVMqHJfoJbHVrqYcN00=
MIME-Version: 1.0
In-Reply-To: <CAPcyv4gy=Oq5=ZXCvs0mgziwfgEb2p+pE9BJZZP47W+4yrz0Vg@mail.gmail.com>
References: <151770009169.7213.12476757146099518628.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151770009703.7213.12036560755602017391.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAMzpN2jeq+LDajvwSALpmaZKOChNX1uhRbuEJ3v97HyOEsH44A@mail.gmail.com> <CAPcyv4gy=Oq5=ZXCvs0mgziwfgEb2p+pE9BJZZP47W+4yrz0Vg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 4 Feb 2018 10:40:36 -0800
X-Google-Sender-Auth: vBUTvHy37OdaSx5MwuLnvL1Epgw
Message-ID: <CA+55aFzC03b5VASq3xjLhU4WAA=gwqKNT2i6-9OBPQd-G_AHEA@mail.gmail.com>
Subject: Re: [PATCH 1/3] x86/entry: Clear extra registers beyond syscall
 arguments for 64bit kernels
To: Dan Williams <dan.j.williams@intel.com>
Cc: Brian Gerst <brgerst@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
        Andi Kleen <ak@linux.intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 4, 2018 at 9:42 AM, Dan Williams <dan.j.williams@intel.com> wrote:
> On Sun, Feb 4, 2018 at 5:01 AM, Brian Gerst <brgerst@gmail.com> wrote:
>>
>> Now that the fast syscall path is gone, all regs (except RSP
>> obviously) are dead after being saved to pt_regs.
>
> They're saved, but not dead afaics.

Actually, they _are_ dead with the slow-path - it will reload them off
the ptregs pointer instead.

However, exactly because the slow-path will just reload the
user-supplied values, there's no point in clearing them anyway.  Those
values will be live in the system call sequence anyway.

So even for the slow system call case, there's no point in clearing
them. If we ever end up only reloading the required values (ie we push
the 'struct ptregs' pointer lower down into the syscall stack), at
that point we might want to clear those registers, because many system
calls will reload only a small subset.

But as the commit message says, the system call argument registers are
also likely to be aggressively clobbered unless used, since the low
registers are preferred for code generation (smaller code, and many of
them are special anyway in various ways and have forced uses for
shifts, function arguments, or just are special in general like %rax).

So the actual argument registers tend to not be an issue anyway.

               Linus
