Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752135AbeBDRVq (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 12:21:46 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:38446 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752088AbeBDRVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 12:21:34 -0500
X-Google-Smtp-Source: AH8x226K/4sTl6itV/XhYzRLaheomP9iq4/WAI0w/4/MSEMD1Gjm4as2NmVROfydKo42kEiPWrDYCw==
Date: Sun, 4 Feb 2018 09:21:30 -0800
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, mingo@kernel.org,
        akpm@linux-foundation.org, tglx@linutronix.de, peterz@infradead.org,
        acme@kernel.org, corbet@lwn.net, mathieu.desnoyers@efficios.com,
        namhyung@kernel.org, daniel@iogearbox.net, davem@davemloft.net
Subject: Re: [PATCH 00/18] [ANNOUNCE] Dynamically created function based
 events
Message-ID: <20180204172128.swbgrr7uc72amxgh@ast-mbp>
References: <20180202230458.840252014@goodmis.org>
 <20180203223817.0c8cc485d8163ad84039cf02@kernel.org>
 <20180203102759.56d03ada@gandalf.local.home>
 <20180204125747.70eb79dd0a69d30fb8a47fcd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180204125747.70eb79dd0a69d30fb8a47fcd@kernel.org>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 04, 2018 at 12:57:47PM +0900, Masami Hiramatsu wrote:
> 
> > I based some of the code from kprobes too. But I wanted this to be
> > simpler, and as such, not as powerful as kprobes. More of a "poor mans"
> > kprobe ;-) Where you are limited to functions and their arguments. If
> > you need more power, switch to kprobes. In other words, its just an
> > added stepping stone.
> > 
> > Also, this should work without kprobe support, only ftrace, and function
> > args from the arch.
> 
> Hmm, but implementation seems very far from current probe events, we need
> to consider how to unify it. Anyway, it is a very good time to do, because
> I found current probe-event fetch method is not good with retpoline/IBRS,
> it is full of indirect call.
> 
> I would like to convert it to eBPF if possible. It will be good for the
> performance with JIT, and we can collaborate on the same code with BPF
> people.

The current probe fetch method is indeed going to slow down due to
retpoline, but this issue is going to affect not only this piece
of code, but the rest of the kernel where indirect call performance
matters a lot. Like networking stack where we have at least 4 indirect
calls per packet.
So I'd suggest to focus on finding a general method instead of coming
with a specific solution for this kprobe fetching problem.
Devirtualization approach works well and applicable in many cases.
For networking stack deliver_skb() and __netif_receive_skb_core()
can check if (pt_prev->func == ip_rcv || ipv6_rcv)
and call them directly.
The other approach I was thinking to explore is static_key-like
for indirect calls. In many cases the target is rarely changed,
so we can do arch specific rewrite of destination offset inside
normal direct call instruction. That should be faster than retpoline.

As far as emitting raw bpf insns instead of kprobe fetch methods
there is a big problem with such apporach. Interpreter and all
JITs take 'struct bpf_prog' that passed the verifier and not just
random set of bpf instructions. BPF is not a generic assembler.
BPF is an instruction set _with_ C calling convention.
The registers and instructions must be used in certain way or
things will horribly break.
See Documentation/bpf/bpf_design_QA.txt for details.
Long ago I wrote a patch that converted pred tree walk into
raw bpf insns. If that patch made it into mainline back then
it would have been a huge headache for us now.
So if you plan on generating bpf programs they _must_ pass the verifier.
