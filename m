Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754215AbeCFWbI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 17:31:08 -0500
Received: from mail-ua0-f195.google.com ([209.85.217.195]:36830 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754091AbeCFWbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 17:31:06 -0500
X-Google-Smtp-Source: AG47ELuqoLn5kazXqPv41vhFrOUPYFhyDQQ7mp9FMxJ1u3KX/cL7/oAZ1GJ2GZ6FnEXssIJMN3v75NEEYTX8UlGdbuc=
MIME-Version: 1.0
In-Reply-To: <20180306180319.GC2080@avx2>
References: <20180306000721.gx9qqFGe8%akpm@linux-foundation.org>
 <CAGXu5jKP03X7+XX9Oq+vVjQJhO1+A9ZyLDD+Gsxv2nRCgVD4wQ@mail.gmail.com>
 <20180306174218.GA2080@avx2> <20180306180319.GC2080@avx2>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 6 Mar 2018 14:31:05 -0800
X-Google-Sender-Auth: 0VM-f236RqLWLOrJVVP2yvcoBnA
Message-ID: <CAGXu5jLvTKmScAtg0PY+gsLAofeNonx2CyFEe7NvdSa6xNeOtg@mail.gmail.com>
Subject: Re: + mm-relax-ptrace-mode-in-process_vm_readv2.patch added to -mm tree
To: Alexey Dobriyan <adobriyan@gmail.com>,
        Andy Lutomirski <luto@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jann@thejh.net>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 6, 2018 at 10:03 AM, Alexey Dobriyan <adobriyan@gmail.com> wrote:
> On Tue, Mar 06, 2018 at 08:42:19PM +0300, Alexey Dobriyan wrote:
>> On Mon, Mar 05, 2018 at 05:02:08PM -0800, Kees Cook wrote:
>> > On Mon, Mar 5, 2018 at 4:07 PM,  <akpm@linux-foundation.org> wrote:
>>
>> > > It is more natural to check for read-from-memory permissions in case of
>> > > process_vm_readv() as PTRACE_MODE_ATTACH is equivalent to write
>> > > permissions.
>> >
>> > NAK, this weakens the existing permission model for reading
>>
>> What if existing permission model is overezealous?
>>
>> /proc/*/auxv, /proc/*/environ, /proc*/cmdline, /proc/*/mem opened
>> for reading and process_vm_readv(2) should do PTRACE_MODE_READ and
>> everything else should do PTRACE_MODE_ATTACH.
>
> Or in other words:
>
> what if there should be 3 levels:
> 1) permission to write to address space
> 2) permission to read arbitrarily from adress space
> 3) permission to read auxv, argv and envp
>
> Current code conflates (1) and (2).

There is also:

4) permission to read address layout (e.g. access to /proc/$pid/maps)

1 and 2 require ATTACH
3 and 4 require READ

ATTACH is a higher bar, and I think it is appropriate here, still, for
2, since being able to examine secrets in memory should be considered
a security boundary.

Is there something you're trying from userspace that is being blocked?

-Kees

-- 
Kees Cook
Pixel Security
