Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D2BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 13:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB0C92146F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 13:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551101801;
	bh=QZ5sLAX9jFqBUUba4gTaT7tgb3EUrBrb7rvstnwC8hA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=2weLZxYDJsHEeA/qPqytJ6j7Moh5YNQF5Qty2GOgzostgtQmlMt9M5eA0XsVCq3aU
	 MP1QagMi9lI0l5QtakuTRAiCDEACzB6/PKC4CQu3P3ZoNquXiJww4aWbHMs99cAxme
	 eaIA0hRX3u2KuMzIK/9rlkJ0vtz/1ZII19m9Qqv8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbfBYNgi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 08:36:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:40806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727044AbfBYNgi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 08:36:38 -0500
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3554213A2;
        Mon, 25 Feb 2019 13:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551101796;
        bh=QZ5sLAX9jFqBUUba4gTaT7tgb3EUrBrb7rvstnwC8hA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=H1KLQOSASc3WPLCvLg/m0OWwL9rAqHR8gL6aHLjCmJmhKKwxGtrqPHaiEjgfXx01y
         0WjW1+V1eyVTJKYUzL7qZ+avXMnTP9u7ucb7Z0U9DW79nmiYsR2ZgKjz5f5ABW0bok
         53cZwfJk4CmvD9FxlElGIxbraXjYOQm3/bLqT98Q=
Date:   Mon, 25 Feb 2019 22:36:31 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Jann Horn <jannh@google.com>, Nadav Amit <namit@vmware.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Network Development <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Igor Stoppa <igor.stoppa@gmail.com>
Subject: Re: [PATCH 1/2 v2] kprobe: Do not use uaccess functions to access
 kernel memory that can fault
Message-Id: <20190225223631.8ad8e949aa17a6c1eaae74ee@kernel.org>
In-Reply-To: <CALCETrU2V5KBA97g3O-yHiUu1acmM_K9b2a5ATmKSqGwdd-+Dw@mail.gmail.com>
References: <20190219111802.1d6dbaa3@gandalf.local.home>
        <20190220094926.0ab575b3@gandalf.local.home>
        <20190222172745.2c7205d62003c0a858e33278@kernel.org>
        <20190222173509.88489b7c5d1bf0e2ec2382ee@kernel.org>
        <CAHk-=whNf_n1WXWW+ugAVeL5ZK0GcEP3cTYocju1nS85VtMjjQ@mail.gmail.com>
        <20190222192703.epvgxghwybte7gxs@ast-mbp.dhcp.thefacebook.com>
        <20190222143026.17d6f0f6@gandalf.local.home>
        <20190222193456.5vqppubzrcx5wsul@ast-mbp.dhcp.thefacebook.com>
        <9E670A9A-699C-4B65-962F-CE1AEFD72974@amacapital.net>
        <CAG48ez2tVwzhKPu1tvK+E52jUCq5vTwjssrtMaGuCO=kMpSXGw@mail.gmail.com>
        <0ED6836E-3432-4E1C-BABC-BEA6BDD36287@vmware.com>
        <CAG48ez10RH2YhQ0wnEDOpKoGjrociq+zK0En6Aq06Yg9W3o5aQ@mail.gmail.com>
        <7701651F-F10E-4212-925E-1CB77C5D3E69@vmware.com>
        <A7232EDD-C53C-4B7D-AD02-4A480F40538B@vmware.com>
        <CAG48ez1Dm04kg2x3O=OOmBFFBSDr+RmnhBYChcwYv5zLbPGudQ@mail.gmail.com>
        <CALCETrU2V5KBA97g3O-yHiUu1acmM_K9b2a5ATmKSqGwdd-+Dw@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Feb 2019 15:59:30 -0800
Andy Lutomirski <luto@kernel.org> wrote:

> On Fri, Feb 22, 2019 at 3:02 PM Jann Horn <jannh@google.com> wrote:
> >
> > On Fri, Feb 22, 2019 at 11:39 PM Nadav Amit <namit@vmware.com> wrote:
> > > > On Feb 22, 2019, at 2:21 PM, Nadav Amit <namit@vmware.com> wrote:
> > > >
> > > >> On Feb 22, 2019, at 2:17 PM, Jann Horn <jannh@google.com> wrote:
> > > >>
> > > >> On Fri, Feb 22, 2019 at 11:08 PM Nadav Amit <namit@vmware.com> wrote:
> > > >>>> On Feb 22, 2019, at 1:43 PM, Jann Horn <jannh@google.com> wrote:
> > > >>>>
> > > >>>> (adding some people from the text_poke series to the thread, removing stable@)
> > > >>>>
> > > >>>> On Fri, Feb 22, 2019 at 8:55 PM Andy Lutomirski <luto@amacapital.net> wrote:
> > > >>>>>> On Feb 22, 2019, at 11:34 AM, Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> > > >>>>>>> On Fri, Feb 22, 2019 at 02:30:26PM -0500, Steven Rostedt wrote:
> > > >>>>>>> On Fri, 22 Feb 2019 11:27:05 -0800
> > > >>>>>>> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> > > >>>>>>>
> > > >>>>>>>>> On Fri, Feb 22, 2019 at 09:43:14AM -0800, Linus Torvalds wrote:
> > > >>>>>>>>>
> > > >>>>>>>>> Then we should still probably fix up "__probe_kernel_read()" to not
> > > >>>>>>>>> allow user accesses. The easiest way to do that is actually likely to
> > > >>>>>>>>> use the "unsafe_get_user()" functions *without* doing a
> > > >>>>>>>>> uaccess_begin(), which will mean that modern CPU's will simply fault
> > > >>>>>>>>> on a kernel access to user space.
> > > >>>>>>>>
> > > >>>>>>>> On bpf side the bpf_probe_read() helper just calls probe_kernel_read()
> > > >>>>>>>> and users pass both user and kernel addresses into it and expect
> > > >>>>>>>> that the helper will actually try to read from that address.
> > > >>>>>>>>
> > > >>>>>>>> If __probe_kernel_read will suddenly start failing on all user addresses
> > > >>>>>>>> it will break the expectations.
> > > >>>>>>>> How do we solve it in bpf_probe_read?
> > > >>>>>>>> Call probe_kernel_read and if that fails call unsafe_get_user byte-by-byte
> > > >>>>>>>> in the loop?
> > > >>>>>>>> That's doable, but people already complain that bpf_probe_read() is slow
> > > >>>>>>>> and shows up in their perf report.
> > > >>>>>>>
> > > >>>>>>> We're changing kprobes to add a specific flag to say that we want to
> > > >>>>>>> differentiate between kernel or user reads. Can this be done with
> > > >>>>>>> bpf_probe_read()? If it's showing up in perf report, I doubt a single
> > > >>>>>>
> > > >>>>>> so you're saying you will break existing kprobe scripts?
> > > >>>>>> I don't think it's a good idea.
> > > >>>>>> It's not acceptable to break bpf_probe_read uapi.
> > > >>>>>
> > > >>>>> If so, the uapi is wrong: a long-sized number does not reliably identify an address if you don’t separately know whether it’s a user or kernel address. s390x and 4G:4G x86_32 are the notable exceptions. I have lobbied for RISC-V and future x86_64 to join the crowd.  I don’t know whether I’ll win this fight, but the uapi will probably have to change for at least s390x.
> > > >>>>>
> > > >>>>> What to do about existing scripts is a different question.
> > > >>>>
> > > >>>> This lack of logical separation between user and kernel addresses
> > > >>>> might interact interestingly with the text_poke series, specifically
> > > >>>> "[PATCH v3 05/20] x86/alternative: Initialize temporary mm for
> > > >>>> patching" (https://na01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flkml%2F20190221234451.17632-6-rick.p.edgecombe%40intel.com%2F&amp;data=02%7C01%7Cnamit%40vmware.com%7Cf2513009ef734ecd6b0d08d69913a5ae%7Cb39138ca3cee4b4aa4d6cd83d9dd62f0%7C0%7C0%7C636864707020821793&amp;sdata=HAbnDcrBne64JyPuVUMKmM7nQk67F%2BFvjuXEn8TmHeo%3D&amp;reserved=0)
> > > >>>> and "[PATCH v3 06/20] x86/alternative: Use temporary mm for text
> > > >>>> poking" (https://na01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flkml%2F20190221234451.17632-7-rick.p.edgecombe%40intel.com%2F&amp;data=02%7C01%7Cnamit%40vmware.com%7Cf2513009ef734ecd6b0d08d69913a5ae%7Cb39138ca3cee4b4aa4d6cd83d9dd62f0%7C0%7C0%7C636864707020821793&amp;sdata=vNRIMKtFDy%2F3z5FlTwDiJY6VGEV%2FMHgQPTdFSFtCo4s%3D&amp;reserved=0),
> > > >>>> right? If someone manages to get a tracing BPF program to trigger in a
> > > >>>> task that has switched to the patching mm, could they use
> > > >>>> bpf_probe_write_user() - which uses probe_kernel_write() after
> > > >>>> checking that KERNEL_DS isn't active and that access_ok() passes - to
> > > >>>> overwrite kernel text that is mapped writable in the patching mm?
> > > >>>
> > > >>> Yes, this is a good point. I guess text_poke() should be defined with
> > > >>> “__kprobes” and open-code memcpy.
> > > >>>
> > > >>> Does it sound reasonable?
> > > >>
> > > >> Doesn't __text_poke() as implemented in the proposed patch use a
> > > >> couple other kernel functions, too? Like switch_mm_irqs_off() and
> > > >> pte_clear() (which can be a call into a separate function on paravirt
> > > >> kernels)?
> > > >
> > > > I will move the pte_clear() to be done after the poking mm was unloaded.
> > > > Give me a few minutes to send a sketch of what I think should be done.
> > >
> > > Err.. You are right, I don’t see an easy way of preventing a kprobe from
> > > being set on switch_mm_irqs_off(), and open-coding this monster is too ugly.
> > >
> > > The reasonable solution seems to me as taking all the relevant pieces of
> > > code (and data) that might be used during text-poking and encapsulating them, so they
> > > will be set in a memory area which cannot be kprobe'd. This can also be
> > > useful to write-protect data structures of code that calls text_poke(),
> > > e.g., static-keys. It can also protect data on that stack that is used
> > > during text_poke() from being overwritten from another core.
> > >
> > > This solution is somewhat similar to Igor Stoppa’s idea of using “enclaves”
> > > when doing write-rarely operations.
> > >
> > > Right now, I think that text_poke() will keep being susceptible to such
> > > an attack, unless you have a better suggestion.
> >
> > A relatively simple approach might be to teach BPF not to run kprobe
> > programs and such in contexts where current->mm isn't the active mm?
> > Maybe using nmi_uaccess_okay(), or something like that? It looks like
> > perf_callchain_user() also already uses that. Except that a lot of
> > this code is x86-specific...
> 
> This sounds like exactly the right solution.  If you're running from
> some unknown context (like NMI or tracing), then you should check
> nmi_uaccess_okay().  I think we should just promote that to be a
> non-arch-specific function (that returns true by default) and check it
> the relevant bpf_probe_xyz() functions.

This treat may also need for my work, like probe_user_read() we should
fail if nmi_uaccess_okay().

Thank you,

> 
> Alexei, does that seem reasonable?


-- 
Masami Hiramatsu <mhiramat@kernel.org>
