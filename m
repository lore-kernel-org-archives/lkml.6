Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A914BC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 04:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 742EA217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 04:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545108632;
	bh=rDFEyGlRfP6Fj4eQLVLTifDbKb/gwUIX4WgoTW4zPKE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=CJ59F6RGEnzk8SJ6MbMYZ0QovLoxxZz/1lwNnwCMRQvbTpEGGIZJdVfPO3cdiSoKA
	 x+tpK4wManap/GhVHHR2jekse0nSHUkpVArKfkHH0F73uTuF0NpjGHMTtm5b9gA4GI
	 gTViqrD8nqmUK5SYvyAKumvLoLnIwHaMiRhpHeMU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbeLREub (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 23:50:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:38754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726534AbeLREub (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 23:50:31 -0500
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85375217D8;
        Tue, 18 Dec 2018 04:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545108630;
        bh=rDFEyGlRfP6Fj4eQLVLTifDbKb/gwUIX4WgoTW4zPKE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lTE+5yh+7elOqxhR+1snjAxbvKakqE7OtQuXW8APua0/IDUI+ReEi90dCRip5hlbb
         pLjPuQYbDZBsN4u0Txf9YJ2IphZUvZEXQYtI32NuKCn7BdU5FOfYC5b1d7uOSxEmiU
         MSRgF44uWuJaC9x8867kOuzLRcgO6FIuP+zt9kvY=
Date:   Tue, 18 Dec 2018 13:50:26 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Andrea Righi <righi.andrea@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Yonghong Song <yhs@fb.com>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] x86: kprobes: Show correct blaclkist in debugfs
Message-Id: <20181218135026.6f96a89247e9b70fa45afbe9@kernel.org>
In-Reply-To: <20181217154713.GA1308@Dell>
References: <154503482486.26176.6224515860220847638.stgit@devbox>
        <20181217154713.GA1308@Dell>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Dec 2018 16:47:13 +0100
Andrea Righi <righi.andrea@gmail.com> wrote:

> On Mon, Dec 17, 2018 at 05:20:25PM +0900, Masami Hiramatsu wrote:
> > This is v2 series for showing correct kprobe blacklist in
> > debugfs.
> > 
> > v1 is here:
> > 
> >  https://lkml.org/lkml/2018/12/7/517
> > 
> > I splitted the RFC v1 patch into x86 and generic parts,
> > also added a patch to remove unneeded arch-specific
> > blacklist check function (because those have been added
> > to the generic blacklist.)
> > 
> > If this style is good, I will make another series for the
> > archs which have own arch_within_kprobe_blacklist(), and
> > eventually replace that with arch_populate_kprobe_blacklist()
> > so that user can get the correct kprobe blacklist in debugfs.
> > 
> > Thank you,
> 
> Looks good to me. Thanks!
> 
> Tested-by: Andrea Righi <righi.andrea@gmail.com>

Thank you for testing!

> 
> Side question: there are certain symbols in arch/x86/xen that should be
> blacklisted explicitly, because they're non-attachable.
> 
> More exactly, all functions defined in arch/x86/xen/spinlock.c,
> arch/x86/xen/time.c and arch/x86/xen/irq.c.
> 
> The reason is that these files are compiled without -pg to allow the
> usage of ftrace within a Xen domain apparently (from
> arch/x86/xen/Makefile):
> 
>  ifdef CONFIG_FUNCTION_TRACER
>  # Do not profile debug and lowlevel utilities
>  CFLAGS_REMOVE_spinlock.o = -pg
>  CFLAGS_REMOVE_time.o = -pg
>  CFLAGS_REMOVE_irq.o = -pg
>  endif


Actually, the reason why you can not probe those functions via
tracing/kprobe_events is just a side effect. You can probe it if you
write a kprobe module. Since the kprobe_events depends on some ftrace
tracing functions, it sometimes cause a recursive call problem. To avoid
this issue, I have introduced a CONFIG_KPROBE_EVENTS_ON_NOTRACE, see
commit 45408c4f9250 ("tracing: kprobes: Prohibit probing on notrace function").

If you set CONFIG_KPROBE_EVENTS_ON_NOTRACE=n, you can continue putting probes
on Xen spinlock functions too.

> Do you see a nice and clean way to blacklist all these functions
> (something like arch_populate_kprobe_blacklist()), or should we just
> flag all of them explicitly with NOKPROBE_SYMBOL()?

As I pointed, you can probe it via your own kprobe module. Like systemtap,
you still can probe it. The blacklist is for "kprobes", not for "kprobe_events".
(Those are used to same, but since the above commit, those are different now)

I think the most sane solution is, identifying which (combination of) functions
in ftrace (kernel/trace/*) causes a problem, marking those NOKPROBE_SYMBOL() and
removing CONFIG_KPROBE_EVENTS_ON_NOTRACE.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
