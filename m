Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751853AbeCVRo3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 13:44:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:38740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751455AbeCVRo1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 13:44:27 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1259D21848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
X-Google-Smtp-Source: AG47ELuLFtzoiC7Lmye+Wb3dyu/uwwj5DQdbZ6Bbo/Vya/zqMXpqNtBAh2BBRVMfuu27lIcLYvkaZFhTTKXtBvGA4y0=
MIME-Version: 1.0
In-Reply-To: <20180322174024.tuillc5ojh4oadf4@ast-mbp.dhcp.thefacebook.com>
References: <cover.1521469118.git.rahul.lakkireddy@chelsio.com>
 <7f0ddb3678814c7bab180714437795e0@AcuMS.aculab.com> <alpine.DEB.2.21.1803191557400.2010@nanos.tec.linutronix.de>
 <7f8d811e79284a78a763f4852984eb3f@AcuMS.aculab.com> <alpine.DEB.2.21.1803191625080.2010@nanos.tec.linutronix.de>
 <20180320082651.jmxvvii2xvmpyr2s@gmail.com> <CA+55aFybTvLz47mw=AG21jCJv_hE2vaVyiJP_F-4vAD-3Gnc7Q@mail.gmail.com>
 <20180321074634.dzpyjz3ia46snodh@gmail.com> <CA+55aFyK6uJopBjZGyeDz0O+qzCac6AwPkJyOpuaT69inPgVgw@mail.gmail.com>
 <20180322093343.aatl3prhheha4dlm@gmail.com> <20180322174024.tuillc5ojh4oadf4@ast-mbp.dhcp.thefacebook.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Thu, 22 Mar 2018 17:44:05 +0000
X-Gmail-Original-Message-ID: <CALCETrX6H4wO-sFhpVCjw-x2gZUagohO+_dNkcf0X_zy41qUCg@mail.gmail.com>
Message-ID: <CALCETrX6H4wO-sFhpVCjw-x2gZUagohO+_dNkcf0X_zy41qUCg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] kernel: add support for 256-bit IO access
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Laight <David.Laight@aculab.com>,
        Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "ganeshgr@chelsio.com" <ganeshgr@chelsio.com>,
        "nirranjan@chelsio.com" <nirranjan@chelsio.com>,
        "indranil@chelsio.com" <indranil@chelsio.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Fenghua Yu <fenghua.yu@intel.com>, Eric Biggers <ebiggers3@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 22, 2018 at 5:40 PM, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> On Thu, Mar 22, 2018 at 10:33:43AM +0100, Ingo Molnar wrote:
>>
>>  - I think the BPF JIT, whose byte code machine languge is used by an
>>    increasing number of kernel subsystems, could benefit from having vector ops.
>>    It would possibly allow the handling of floating point types.
>
> this is on our todo list already.
> To process certain traffic inside BPF in XDP we'd like to have access to
> floating point. The current workaround is to precompute the math and do
> bpf map lookup instead.
> Since XDP processing of packets is batched (typically up to napi budget
> of 64 packets at a time), we can, in theory, wrap the loop with
> kernel_fpu_begin/end and it will be cleaner and faster,
> but the work hasn't started yet.
> The microbenchmark numbers you quoted for xsave/xrestore look promising,
> so we probably will focus on it soon.
>
> Another use case for vector insns is to accelerate fib/lpm lookups
> which is likely beneficial for kernel overall regardless of bpf usage.
>

This is a further argument for the deferred restore approach IMO.
With deferred restore, kernel_fpu_begin() + kernel_fpu_end() has very
low amortized cost as long as we do lots of work in the kernel before
re-entering userspace.  For XDP workloads, this could be a pretty big
win, I imagine.

Someone just needs to do the nasty x86 work.
