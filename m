Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89091C4360F
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 04:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5785820850
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 04:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550897494;
	bh=42v0VnQi3IqZwIOMtu8X9hxtLnOZgCOMiNjt33ERHwk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=oznPIuNW5aB4QFDdsSyBhrrGE9n8Zv75DSP3FyOl87K6A4Yx9MVpyL8/KFQrz/g/n
	 Y6aWCJXNcNlHAEG/dbnZPjPBQ+mKna8moQUYGX6GSjOYwkUUmGQ3vnc1YxdJ642NJg
	 nsq1aU3TTln5gkdQlYFmhzpXcJdc4W688NNwfmvc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbfBWEvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 23:51:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:50332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbfBWEvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 23:51:32 -0500
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05C12206A3;
        Sat, 23 Feb 2019 04:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550897490;
        bh=42v0VnQi3IqZwIOMtu8X9hxtLnOZgCOMiNjt33ERHwk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RW6CV5sBrpGvBAojuJoLgh0HNgTHAf6PUk6pSMaYQGqv693gJEaT4eevt4w8N/ObM
         WT/tFG6X7lVIT6k5Pvnq0zOxiMk4gT/fm1luImbhe4MX7VIPbp7yO7xDknetIrVNi2
         IyivcLio7Y2Yo/+WKroQfUK8/cFOkXLluc+BU4fs=
Date:   Sat, 23 Feb 2019 13:51:26 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Miller <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable <stable@vger.kernel.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Netdev <netdev@vger.kernel.org>, bpf@vger.kernel.org
Subject: Re: [PATCH 1/2 v2] kprobe: Do not use uaccess functions to access
 kernel memory that can fault
Message-Id: <20190223135126.1722237ffda9c50e66fff135@kernel.org>
In-Reply-To: <20190222235618.dxewmv5dukltaoxl@ast-mbp.dhcp.thefacebook.com>
References: <CAHk-=whNf_n1WXWW+ugAVeL5ZK0GcEP3cTYocju1nS85VtMjjQ@mail.gmail.com>
        <20190222192703.epvgxghwybte7gxs@ast-mbp.dhcp.thefacebook.com>
        <CAHk-=wib9VSbwbS+N82ZPNtvt4vrvYyHyQduhFimX8nyjCyZyA@mail.gmail.com>
        <20190222.133842.1637029078039923178.davem@davemloft.net>
        <CAHk-=wh9uWJaih5i6qBPer5rzcs=A+yb_ejU093b1esAhoFveQ@mail.gmail.com>
        <20190222225103.o5rr5zr4fq77jdg4@ast-mbp.dhcp.thefacebook.com>
        <CAHk-=wjJqVXydQf_dprBmr=zXsyNVrB9mBCmDL0nGmH_b0vY5g@mail.gmail.com>
        <20190222235618.dxewmv5dukltaoxl@ast-mbp.dhcp.thefacebook.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Feb 2019 15:56:20 -0800
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> On Fri, Feb 22, 2019 at 03:16:35PM -0800, Linus Torvalds wrote:
> > 
> > So a kernel pointer value of 0x12345678 could be a value kernel
> > pointer pointing to some random kmalloc'ed kernel memory, and a user
> > pointer value of 0x12345678 could be a valid _user_ pointer pointing
> > to some user mapping.
> > 
> > See?
> > 
> > If you access a user pointer, you need to use a user accessor function
> > (eg "get_user()"), while if you access a kernel pointer you need to
> > just dereference it directly (unless you can't trust it, in which case
> > you need to use a _different_ accessor function).
> 
> that was clear already.
> Reading 0x12345678 via probe_kernel_read can return valid value
> and via get_user() can return another valid value on _some_ architectures.
> 
> > The fact that user and kernel pointers happen to be distinct on x86-64
> > (right now) is just a random implementation detail.
> 
> yes and my point that people already rely on this implementation detail.
> Say we implement 
> int bpf_probe_read(void *val, void *unsafe_ptr)
> {
>   if (probe_kernel_read(val, unsafe_ptr) == OK) {
>      return 0;
>   } else (get_user(val, unsafe_ptr) == OK) {
>      return 0;
>   } else {
>      *val = 0;
>      return -EFAULT;
>   }
> }

Note that we can not use get_user() form kprobe handler. If you use it,
you have to prepare fault_handler() and make bpf itself can be aborted.
So, maybe you can use probe_user_read().

Hmm, however, it still doesn't work correctly on "some" architecture,
since whether a pointer (address) points user-space or kernel-space
depends on the context. In kprobe/bpf, the context means where you
put the probe and which pointer you record.

I think only "__user" tag tells us which one is user-space. But 
unfortunately, that "__user" tag is only for compiler or checker, not
for runtime binary. Such useful attribute goes away when we execute it.

So, even if we introduce "ustring", ftrace/perf users has to decide to use
it by themselves. As far as I know, DWARF(debuginfo) also doesn't have
that attribute. So perf-probe can not help it from debuginfo.
(Maybe if we introduce C parser, it might be detected...)

> It will preserve existing bpf_probe_read() behavior on x86.
> If x86 implementation changes tomorrow then progs that read user
> addresses may start failing randomly because first probe_kernel_read()
> will be returning random values from kernel memory and that's no good,
> but at least we won't be breaking them today, so we have time to
> introduce bpf_user_read and bpf_kernel_read and folks have time to adopt them.

I see. I think bpf also has to introduce new bpf_probe_read_user() and
keep bpf_probe_read() for kernel dataa only.

> Imo that's much better than making current bpf_probe_read() fail
> on user addresses today and not providing a non disruptive path forward.

Agreed.

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
