Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8300C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEA542070B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfBVTaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 14:30:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:59470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726441AbfBVTa3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 14:30:29 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A49F206C0;
        Fri, 22 Feb 2019 19:30:27 +0000 (UTC)
Date:   Fri, 22 Feb 2019 14:30:26 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable <stable@vger.kernel.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>, daniel@iogearbox.net,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 1/2 v2] kprobe: Do not use uaccess functions to access
 kernel memory that can fault
Message-ID: <20190222143026.17d6f0f6@gandalf.local.home>
In-Reply-To: <20190222192703.epvgxghwybte7gxs@ast-mbp.dhcp.thefacebook.com>
References: <CAHk-=wgJzNp0R3cVhjBPHTR4X9sOvHdqK4UVFfbsOKQ6L=A_eQ@mail.gmail.com>
        <CAHk-=wh9XrOykA5J9RQ7zaBio-S_D+1AE+rGnBYWSd==pCXh+w@mail.gmail.com>
        <20190219111802.1d6dbaa3@gandalf.local.home>
        <CAHk-=wgTuK3kAduP-gr10vykT1uG=B2VpdffvmyBuTQ1UxPpMg@mail.gmail.com>
        <20190219140330.5dd9e876@gandalf.local.home>
        <20190220171019.5e81a4946b56982f324f7c45@kernel.org>
        <20190220094926.0ab575b3@gandalf.local.home>
        <20190222172745.2c7205d62003c0a858e33278@kernel.org>
        <20190222173509.88489b7c5d1bf0e2ec2382ee@kernel.org>
        <CAHk-=whNf_n1WXWW+ugAVeL5ZK0GcEP3cTYocju1nS85VtMjjQ@mail.gmail.com>
        <20190222192703.epvgxghwybte7gxs@ast-mbp.dhcp.thefacebook.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Feb 2019 11:27:05 -0800
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> On Fri, Feb 22, 2019 at 09:43:14AM -0800, Linus Torvalds wrote:
> > 
> > Then we should still probably fix up "__probe_kernel_read()" to not
> > allow user accesses. The easiest way to do that is actually likely to
> > use the "unsafe_get_user()" functions *without* doing a
> > uaccess_begin(), which will mean that modern CPU's will simply fault
> > on a kernel access to user space.  
> 
> On bpf side the bpf_probe_read() helper just calls probe_kernel_read()
> and users pass both user and kernel addresses into it and expect
> that the helper will actually try to read from that address.
> 
> If __probe_kernel_read will suddenly start failing on all user addresses
> it will break the expectations.
> How do we solve it in bpf_probe_read?
> Call probe_kernel_read and if that fails call unsafe_get_user byte-by-byte
> in the loop?
> That's doable, but people already complain that bpf_probe_read() is slow
> and shows up in their perf report.

We're changing kprobes to add a specific flag to say that we want to
differentiate between kernel or user reads. Can this be done with
bpf_probe_read()? If it's showing up in perf report, I doubt a single
check is going to cause an issue. In fact, it may actually help speed
things up as the read will be optimized for either user or kernel
address reading.

-- Steve
