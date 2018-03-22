Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751925AbeCVRkk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 13:40:40 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:36998 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751668AbeCVRka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 13:40:30 -0400
X-Google-Smtp-Source: AG47ELuAaL00IkElPAjpmgCqGT7qKUGTd3C2J5jr8XXDdIlMpeFK2zYgO1lUS78ttdpIM7or9ibHSw==
Date: Thu, 22 Mar 2018 10:40:25 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
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
Subject: Re: [RFC PATCH 0/3] kernel: add support for 256-bit IO access
Message-ID: <20180322174024.tuillc5ojh4oadf4@ast-mbp.dhcp.thefacebook.com>
References: <cover.1521469118.git.rahul.lakkireddy@chelsio.com>
 <7f0ddb3678814c7bab180714437795e0@AcuMS.aculab.com>
 <alpine.DEB.2.21.1803191557400.2010@nanos.tec.linutronix.de>
 <7f8d811e79284a78a763f4852984eb3f@AcuMS.aculab.com>
 <alpine.DEB.2.21.1803191625080.2010@nanos.tec.linutronix.de>
 <20180320082651.jmxvvii2xvmpyr2s@gmail.com>
 <CA+55aFybTvLz47mw=AG21jCJv_hE2vaVyiJP_F-4vAD-3Gnc7Q@mail.gmail.com>
 <20180321074634.dzpyjz3ia46snodh@gmail.com>
 <CA+55aFyK6uJopBjZGyeDz0O+qzCac6AwPkJyOpuaT69inPgVgw@mail.gmail.com>
 <20180322093343.aatl3prhheha4dlm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180322093343.aatl3prhheha4dlm@gmail.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 22, 2018 at 10:33:43AM +0100, Ingo Molnar wrote:
> 
>  - I think the BPF JIT, whose byte code machine languge is used by an
>    increasing number of kernel subsystems, could benefit from having vector ops.
>    It would possibly allow the handling of floating point types.

this is on our todo list already.
To process certain traffic inside BPF in XDP we'd like to have access to
floating point. The current workaround is to precompute the math and do
bpf map lookup instead.
Since XDP processing of packets is batched (typically up to napi budget
of 64 packets at a time), we can, in theory, wrap the loop with
kernel_fpu_begin/end and it will be cleaner and faster,
but the work hasn't started yet.
The microbenchmark numbers you quoted for xsave/xrestore look promising,
so we probably will focus on it soon.

Another use case for vector insns is to accelerate fib/lpm lookups
which is likely beneficial for kernel overall regardless of bpf usage.
