Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 749B0C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 13:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11094218CD
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 13:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546348625;
	bh=0YzB4cK5bZOYvdrybdMcXidG4SQZaKrwZfe7or/giLk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ApNyI1xU7CHBaSqibLoIGjhO57JSzSmauBLK+TgnSiprDvhFj3X31dZOHj2itBBZi
	 gQqwKGll3Ohr6NRxFXSfzMrzs3iV4Qt2Jy5hvYSsEc1Njlk42XXvREfdkZ4AQzVdDi
	 X7OI7Bl5PX0GG9qO9byIWKOFEFJYEbA7aJuAnRQc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbfAANRC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 08:17:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:32990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728294AbfAANRB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 08:17:01 -0500
Received: from devnote (ftth61-89-219-172.sensyu.ne.jp [61.89.219.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 532CB218AE;
        Tue,  1 Jan 2019 13:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546348620;
        bh=0YzB4cK5bZOYvdrybdMcXidG4SQZaKrwZfe7or/giLk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HUdTMj7YBD0F2vW0HI7KsKXbo0rIOdKRExOzN2UN+PhBTMafxGuCX0qYJ6X/ks08G
         SqOk7YQ1Jm6vmwHH8guCh/igU0HNOtEXMfQVv6uombZs+cdYBS+0GA3NAVeCKvPmZh
         0nhWthpTzaqXo1XdahJswbqBCATyEjIAkC8ssNSA=
Date:   Tue, 1 Jan 2019 22:16:54 +0900
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
Message-Id: <20190101221654.fedda794776540d6b81f6167@kernel.org>
In-Reply-To: <20181227170934.GA2057@xps-13>
References: <154503482486.26176.6224515860220847638.stgit@devbox>
        <20181217154713.GA1308@Dell>
        <20181218135026.6f96a89247e9b70fa45afbe9@kernel.org>
        <20181218172134.GA2902@xps-13>
        <20181227170934.GA2057@xps-13>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrea,

Sorry for late reply,

On Thu, 27 Dec 2018 18:09:34 +0100
Andrea Righi <righi.andrea@gmail.com> wrote:

> On Tue, Dec 18, 2018 at 06:24:35PM +0100, Andrea Righi wrote:,
> > On Tue, Dec 18, 2018 at 01:50:26PM +0900, Masami Hiramatsu wrote:
> > ...
> > > > Side question: there are certain symbols in arch/x86/xen that should be
> > > > blacklisted explicitly, because they're non-attachable.
> > > > 
> > > > More exactly, all functions defined in arch/x86/xen/spinlock.c,
> > > > arch/x86/xen/time.c and arch/x86/xen/irq.c.
> > > > 
> > > > The reason is that these files are compiled without -pg to allow the
> > > > usage of ftrace within a Xen domain apparently (from
> > > > arch/x86/xen/Makefile):
> > > > 
> > > >  ifdef CONFIG_FUNCTION_TRACER
> > > >  # Do not profile debug and lowlevel utilities
> > > >  CFLAGS_REMOVE_spinlock.o = -pg
> > > >  CFLAGS_REMOVE_time.o = -pg
> > > >  CFLAGS_REMOVE_irq.o = -pg
> > > >  endif
> > > 
> > > 
> > > Actually, the reason why you can not probe those functions via
> > > tracing/kprobe_events is just a side effect. You can probe it if you
> > > write a kprobe module. Since the kprobe_events depends on some ftrace
> > > tracing functions, it sometimes cause a recursive call problem. To avoid
> > > this issue, I have introduced a CONFIG_KPROBE_EVENTS_ON_NOTRACE, see
> > > commit 45408c4f9250 ("tracing: kprobes: Prohibit probing on notrace function").
> > > 
> > > If you set CONFIG_KPROBE_EVENTS_ON_NOTRACE=n, you can continue putting probes
> > > on Xen spinlock functions too.
> > 
> > OK.
> > 
> > > 
> > > > Do you see a nice and clean way to blacklist all these functions
> > > > (something like arch_populate_kprobe_blacklist()), or should we just
> > > > flag all of them explicitly with NOKPROBE_SYMBOL()?
> > > 
> > > As I pointed, you can probe it via your own kprobe module. Like systemtap,
> > > you still can probe it. The blacklist is for "kprobes", not for "kprobe_events".
> > > (Those are used to same, but since the above commit, those are different now)
> > > 
> > > I think the most sane solution is, identifying which (combination of) functions
> > > in ftrace (kernel/trace/*) causes a problem, marking those NOKPROBE_SYMBOL() and
> > > removing CONFIG_KPROBE_EVENTS_ON_NOTRACE.
> 
> I'm planning to spend a little bit more time on this and see if I can
> identify the problematic ftrace functions and eventually drop
> CONFIG_KPROBE_EVENTS_ON_NOTRACE, following the sane solution.
> 
> However, in the meantime, with the following patch I've been able to get
> a more reliable kprobes blacklist and show also the notrace functions in
> debugfs when CONFIG_KPROBE_EVENTS_ON_NOTRACE is off.

Hmm, if CONFIG_KPROBE_EVENTS_ON_NOTRACE=n, we already have a whitelist of
functions in /sys/kernel/debug/tracing/available_filter_functions,
so I don't think we need a blacklist.

> It's probably ugly and inefficient, because it's iterating over all
> symbols in x86's arch_populate_kprobe_blacklist(), but it seems to work
> for my specific use case, so I thought it shouldn't be bad to share it,
> just in case (maybe someone else is also interested).

Hmm, but in that case, it limits other native kprobes users like systemtap
to disable probing on notrace functions with no reasons. That may not be acceptable.

OK, I'll retry to find which notrace function combination tracing with
kprobes are problematic. Let me do it...

Thank you,

> 
> Thanks,
> 
> From: Andrea Righi <righi.andrea@gmail.com>
> Subject: [PATCH] x86: kprobes: automatically blacklist all non-traceable functions
> 
> Iterate over all symbols to detect those that are non-traceable and
> blacklist them.
> 
> Signed-off-by: Andrea Righi <righi.andrea@gmail.com>
> ---
>  arch/x86/kernel/kprobes/core.c | 11 +++++++++--
>  kernel/kprobes.c               | 22 ++++++++++++++++++++--
>  2 files changed, 29 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
> index 4ba75afba527..8cc7191ba3f9 100644
> --- a/arch/x86/kernel/kprobes/core.c
> +++ b/arch/x86/kernel/kprobes/core.c
> @@ -1026,10 +1026,17 @@ int kprobe_fault_handler(struct pt_regs *regs, int trapnr)
>  }
>  NOKPROBE_SYMBOL(kprobe_fault_handler);
>  
> +static int do_kprobes_arch_blacklist(void *data, const char *name,
> +				     struct module *mod, unsigned long addr)
> +{
> +	if (arch_within_kprobe_blacklist(addr))
> +		kprobe_add_ksym_blacklist(addr);
> +	return 0;
> +}
> +
>  int __init arch_populate_kprobe_blacklist(void)
>  {
> -	return kprobe_add_area_blacklist((unsigned long)__entry_text_start,
> -					 (unsigned long)__entry_text_end);
> +	return kallsyms_on_each_symbol(do_kprobes_arch_blacklist, NULL);
>  }
>  
>  int __init arch_init_kprobes(void)
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index f4ddfdd2d07e..2e824cd536ba 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -1389,11 +1389,29 @@ static int register_aggr_kprobe(struct kprobe *orig_p, struct kprobe *p)
>  	return ret;
>  }
>  
> +#if defined(CONFIG_KPROBES_ON_FTRACE) && \
> +	!defined(CONFIG_KPROBE_EVENTS_ON_NOTRACE)
> +static bool within_notrace(unsigned long addr)
> +{
> +	unsigned long offset, size;
> +
> +	if (!kallsyms_lookup_size_offset(addr, &size, &offset))
> +		return true;
> +	return !ftrace_location_range(addr - offset, addr - offset + size);
> +}
> +#else
> +static bool within_notrace(unsigned long addr)
> +{
> +	return false;
> +}
> +#endif
> +
>  bool __weak arch_within_kprobe_blacklist(unsigned long addr)
>  {
>  	/* The __kprobes marked functions and entry code must not be probed */
> -	return addr >= (unsigned long)__kprobes_text_start &&
> -	       addr < (unsigned long)__kprobes_text_end;
> +	return (addr >= (unsigned long)__kprobes_text_start &&
> +	       addr < (unsigned long)__kprobes_text_end) ||
> +	       within_notrace(addr);
>  }
>  
>  bool within_kprobe_blacklist(unsigned long addr)
> -- 
> 2.17.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
