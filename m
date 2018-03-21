Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751632AbeCUAkT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 20:40:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:57096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751018AbeCUAkP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 20:40:15 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 099C52183B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
X-Google-Smtp-Source: AG47ELt6F72LsNMu3pcUbkw0p6CQqxod7how4no9FEp08fghs3YCNaHsyyrLVLlKBr9YPEs4kVIPCmGyU6XN+amq+O4=
MIME-Version: 1.0
In-Reply-To: <c1eac43cd8e143d09477a34ed6de6302@AcuMS.aculab.com>
References: <cover.1521469118.git.rahul.lakkireddy@chelsio.com>
 <7f0ddb3678814c7bab180714437795e0@AcuMS.aculab.com> <alpine.DEB.2.21.1803191557400.2010@nanos.tec.linutronix.de>
 <7f8d811e79284a78a763f4852984eb3f@AcuMS.aculab.com> <alpine.DEB.2.21.1803191625080.2010@nanos.tec.linutronix.de>
 <20180320082651.jmxvvii2xvmpyr2s@gmail.com> <CALCETrVMF140-XZLi9nARPeAmyi8QRRzLRm6SSpB0BkAUSGakg@mail.gmail.com>
 <c1eac43cd8e143d09477a34ed6de6302@AcuMS.aculab.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Wed, 21 Mar 2018 00:39:53 +0000
X-Gmail-Original-Message-ID: <CALCETrV8d5HD2q_qmiRfs-vB=JkiDm3yDx-5KcYqu7yEQrdu0A@mail.gmail.com>
Message-ID: <CALCETrV8d5HD2q_qmiRfs-vB=JkiDm3yDx-5KcYqu7yEQrdu0A@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] kernel: add support for 256-bit IO access
To: David Laight <David.Laight@aculab.com>
Cc: Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "ganeshgr@chelsio.com" <ganeshgr@chelsio.com>,
        "nirranjan@chelsio.com" <nirranjan@chelsio.com>,
        "indranil@chelsio.com" <indranil@chelsio.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Fenghua Yu <fenghua.yu@intel.com>, Eric Biggers <ebiggers3@gmail.com>,
        Rik van Riel <riel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 20, 2018 at 3:10 PM, David Laight <David.Laight@aculab.com> wrote:
> From: Andy Lutomirski
>> Sent: 20 March 2018 14:57
> ...
>> I'd rather see us finally finish the work that Rik started to rework
>> this differently.  I'd like kernel_fpu_begin() to look like:
>>
>> if (test_thread_flag(TIF_NEED_FPU_RESTORE)) {
>>   return; // we're already okay.  maybe we need to check
>> in_interrupt() or something, though?
>> } else {
>>   XSAVES/XSAVEOPT/XSAVE;
>>   set_thread_flag(TIF_NEED_FPU_RESTORE):
>> }
>>
>> and kernel_fpu_end() does nothing at all.
>
> I guess it might need to set (clear?) the CFLAGS bit for a process
> that isn't using the fpu at all - which seems a sensible feature.

What do you mean "CFLAGS"?

But we no longer have any concept of "isn't using the fpu at all" --
we got rid of that.

>
>> We take the full performance hit for a *single* kernel_fpu_begin() on
>> an otherwise short syscall or interrupt, but there's no additional
>> cost for more of them or for long-enough-running things that we
>> schedule in the middle.
>
> It might be worth adding a parameter to kernel_fpu_begin() to indicate
> which registers are needed, and a return value to say what has been
> granted.
> Then a driver could request AVX2 (for example) and use a fallback path
> if the register set isn't available (for any reason).
> A call from an ISR could always fail.

Last time I benchmarked it, XSAVEC on none of the state wasn't a whole
lot faster than XSAVEC for all of it.

>
>> As I remember, the main hangup was that this interacts a bit oddly
>> with PKRU, but that's manageable.
>
> WTF PKRU ??

PKRU is uniquely demented.  All the rest of the XSAVEC state only
affects code that explicitly references that state.  PKRU affects
every single access to user pages, so we need PKRU to match the
current task at all times in the kernel.  This means that, if we start
deferring XRSTORS until prepare_exit_to_usermode(), we need to start
restoring PKRU using WRPKRU in __switch_to().  Of course, *that*
interacts a bit oddly with XINUSE, but maybe we don't care.

Phooey on you, Intel, for putting PKRU into xstate and not giving a
fast instruction to control XINUSE.
