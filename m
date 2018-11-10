Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5FA3C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 15:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80D2920892
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 15:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EfBJ/XH1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80D2920892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbeKKBRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 20:17:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:33630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726068AbeKKBRG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 20:17:06 -0500
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B27A20818;
        Sat, 10 Nov 2018 15:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541863902;
        bh=0vsm6gonEsw/OJilFDSuH1TJDtMdH/vsOpss6vbTnts=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EfBJ/XH1MDsmbdLmvmmuowocZqtKJ8Y+nLfl7v0Kp8E8HcVIRNV6XhBa7UhvDIZGs
         YRpc7Q10JZaVZhf4oDrtkEXsbtuX8hA2NrcSmD8phtKgrRr7BZ1y/HcTMfR7u3GQSx
         0BbDnffvQSdHMzNtnuqGmqD9C0qId9FzYzn10Gz0=
Date:   Sun, 11 Nov 2018 00:31:37 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Aleksa Sarai <asarai@suse.de>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Brendan Gregg <bgregg@netflix.com>,
        Christian Brauner <christian@brauner.io>,
        netdev@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v3 1/2] kretprobe: produce sane stack traces
Message-Id: <20181111003137.c9df7a077d983cde57c06ee8@kernel.org>
In-Reply-To: <20181109150629.wpedwxsgbftkl3ab@mikami>
References: <20181101204720.6ed3fe37@vmware.local.home>
        <20181102050509.tw3dhvj5urudvtjl@yavin>
        <20181102065932.bdt4pubbrkvql4mp@yavin>
        <20181102091658.1bc979a4@gandalf.local.home>
        <20181103070253.ajrqzs5xu2vf5stu@yavin>
        <20181104115913.74l4yzecisvtt2j5@yavin>
        <20181106171501.59ccabbc@gandalf.local.home>
        <20181108074612.ldy6rozdpsdps6bf@yavin>
        <20181108080448.rggfn4zawi3por23@yavin>
        <20181109161551.6b96bd7d932c71432ac65e83@kernel.org>
        <20181109150629.wpedwxsgbftkl3ab@mikami>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Nov 2018 02:06:29 +1100
Aleksa Sarai <asarai@suse.de> wrote:

> On 2018-11-09, Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > > diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h
> > > index ee696efec99f..c4dfafd43e11 100644
> > > --- a/arch/x86/include/asm/ptrace.h
> > > +++ b/arch/x86/include/asm/ptrace.h
> > > @@ -172,6 +172,7 @@ static inline unsigned long kernel_stack_pointer(struct pt_regs *regs)
> > >  	return regs->sp;
> > >  }
> > >  #endif
> > > +#define stack_addr(regs) ((unsigned long *) kernel_stack_pointer(regs))
> > 
> > No, you should use kernel_stack_pointer(regs) itself instead of stack_addr().
> > 
> > > 
> > >  #define GET_IP(regs) ((regs)->ip)
> > >  #define GET_FP(regs) ((regs)->bp)
> > > diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
> > > index b0d1e81c96bb..eb4da885020c 100644
> > > --- a/arch/x86/kernel/kprobes/core.c
> > > +++ b/arch/x86/kernel/kprobes/core.c
> > > @@ -69,8 +69,6 @@
> > >  DEFINE_PER_CPU(struct kprobe *, current_kprobe) = NULL;
> > >  DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
> > >  
> > > -#define stack_addr(regs) ((unsigned long *)kernel_stack_pointer(regs))
> > 
> > I don't like keeping this meaningless macro... this should be replaced with generic
> > kernel_stack_pointer() macro.
> 
> Sure. This patch was just an example -- I can remove stack_addr() all
> over.
> 
> > > -	if (regs)
> > > -		save_stack_address(trace, regs->ip, nosched);
> > > +	if (regs) {
> > > +		/* XXX: Currently broken -- stack_addr(regs) doesn't match entry. */
> > > +		addr = regs->ip;
> > 
> > Since this part is for storing regs->ip as a top of call-stack, this
> > seems correct code. Stack unwind will be done next block.
> 
> This comment was referring to the usage of stack_addr(). stack_addr()
> doesn't give you the right result (it isn't the address of the return
> address -- it's slightly wrong). This is the main issue I was having --
> am I doing something wrong here?

Of course stack_addr() actually just returns where the stack is. It should
not return address, but maybe a return address from this event happens.
Note that the "regs != NULL" means you will be in the interrupt handler
and it will be returned to the regs->ip.


> > > +		//addr = ftrace_graph_ret_addr(current, &state.graph_idx, addr, stack_addr(regs));
> > 
> > so func graph return trampoline address will be shown only when unwinding stack entries.
> > I mean func-graph tracer is not used as an event, so it never kicks stackdump.
> 
> Just to make sure I understand what you're saying -- func-graph trace
> will never actually call __ftrace_stack_trace? Because if it does, then
> this code will be necessary (and then I'm a bit confused why the
> unwinder has func-graph trace code -- if stack traces are never taken
> under func-graph then the code in the unwinder is not necessary)

You seems misunderstanding. Even if this is not called from func-graph
tracer, the stack entries are already replaced with func-graph trampoline.
However, regs->ip (IRQ return address) is never replaced by the func-graph
trampoline.

> My reason for commenting this out is because at this point "state" isn't
> initialised and thus .graph_idx would not be correctly handled during
> unwind (and it's the same reason I commented it out later).

OK, but anyway, I think we don't need it.

> > > +		addr = kretprobe_ret_addr(current, addr, stack_addr(regs));
> > 
> > But since kretprobe will be an event, which can kick the stackdump.
> > BTW, from kretprobe, regs->ip should always be the trampoline handler, 
> > see arch/x86/kernel/kprobes/core.c:772 :-)
> > So it must be fixed always.
> 
> Right, but kretprobe_ret_addr() is returning the *original* return
> address (and we need to do an (addr == kretprobe_trampoline)). The
> real problem is that stack_addr(regs) isn't the same as it is during
> kretprobe setup (but kretprobe_ret_addr() works everywhere else).

I think stack_addr(regs) should be same when this is called from kretprobe
handler context. Otherwise, yes, it is not same, but in that case, regs->ip
is not kretprobe_trampoline too.

If you find kretprobe_trampoline on the "stack", of course it's address should be
same as it is during kretprobe setup, but if you find kretprobe_trampoline on the
regs->ip, that should always happen on kretprobe handler context. Otherwise,
some critical violation happens on kretprobe_trampoline. In that case, we should
dump the kretprobe_trampoline address itself, should not recover it.

> > > @@ -1856,6 +1870,41 @@ static int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs)
> > >  }
> > >  NOKPROBE_SYMBOL(pre_handler_kretprobe);
> > >  
> > > +unsigned long kretprobe_ret_addr(struct task_struct *tsk, unsigned long ret,
> > > +				 unsigned long *retp)
> > > +{
> > > +	struct kretprobe_instance *ri;
> > > +	unsigned long flags = 0;
> > > +	struct hlist_head *head;
> > > +	bool need_lock;
> > > +
> > > +	if (likely(ret != (unsigned long) &kretprobe_trampoline))
> > > +		return ret;
> > > +
> > > +	need_lock = !kretprobe_hash_is_locked(tsk);
> > > +	if (WARN_ON(need_lock))
> > > +		kretprobe_hash_lock(tsk, &head, &flags);
> > > +	else
> > > +		head = kretprobe_inst_table_head(tsk);
> > 
> > This may not work unless this is called from the kretprobe handler context,
> > since if we are out of kretprobe handler context, another CPU can lock the
> > hash table and it can be detected by kretprobe_hash_is_locked();.
> 
> Yeah, I noticed this as well when writing it (but needed a quick impl
> that I could test). I will fix this, thanks!
> 
> By is_kretprobe_handler_context() I imagine you are referring to
> checking is_kretprobe(current_kprobe())?

yes, that's correct :)

Thank you,

> 
> > So, we should check we are in the kretprobe handler context if tsk == current,
> > if not, we definately can lock the hash lock without any warning. This can
> > be something like;
> > 
> > if (is_kretprobe_handler_context()) {
> >   // kretprobe_hash_lock(current == tsk) has been locked by caller  
> >   if (tsk != current && kretprobe_hash(tsk) != kretprobe_hash(current))
> >     // the hash of tsk and current can be same.
> >     need_lock = true;
> > } else
> >   // we should take a lock for tsk.
> >   need_lock = true;
> 
> -- 
> Aleksa Sarai
> Senior Software Engineer (Containers)
> SUSE Linux GmbH
> <https://www.cyphar.com/>


-- 
Masami Hiramatsu <mhiramat@kernel.org>
