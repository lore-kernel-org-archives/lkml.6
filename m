Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F587C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B14320868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JwmxF/K2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B14320868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbeLABVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 20:21:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:54584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726398AbeLABVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 20:21:31 -0500
Received: from devnote (p35161-mobac01.tokyo.ocn.ne.jp [153.233.26.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C90C120834;
        Fri, 30 Nov 2018 14:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543587124;
        bh=M/+wNYbegUA6uYYyF9Fu5tByIQMK3FsO5dS4dlNtSGM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JwmxF/K21DxyQasD5gDED+jSZmF43P94Q/ZSsPoiOm0JzG1fUp2KQpUiM2xGM0Gw1
         Mval7vtTnVzfWj98FyK3YW6onio1RZPUJYtTUe1Db2BioOchR1Q41mxCCN2eJUChu/
         vDgctZt52LdWPEG3OeGT7fcC4xvr9BcOdgiU24G0=
Date:   Fri, 30 Nov 2018 23:11:58 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andy Lutomirski <luto@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, systemtap@sourceware.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [RFC][PATCH 00/14] function_graph: Rewrite to allow multiple
 users
Message-Id: <20181130231158.d095ee9483e38d964ba26741@kernel.org>
In-Reply-To: <20181129222435.26fad0ea@vmware.local.home>
References: <20181122012708.491151844@goodmis.org>
        <20181126182112.422b914dd00ecb36e15f7b07@kernel.org>
        <20181126113215.4259d473@gandalf.local.home>
        <20181129232927.74ca5f294e97fc58b15bf8c6@kernel.org>
        <20181129114652.3696d6d7@gandalf.local.home>
        <20181130112658.337e92b79e243034973b6997@kernel.org>
        <20181129222435.26fad0ea@vmware.local.home>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Nov 2018 22:24:35 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 30 Nov 2018 11:26:58 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > On Thu, 29 Nov 2018 11:46:52 -0500
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > > On Thu, 29 Nov 2018 23:29:27 +0900
> > > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > >   
> > > > > One way to solve this is to also have a counter array that gets updated
> > > > > every time the index array gets updated. And save the counter to the
> > > > > shadow stack index as well. This way, we only call the return if the
> > > > > counter on the stack matches what's in the counter on the counter array
> > > > > for the index.    
> > > > 
> > > > Hmm, but we already know the current stack "header" entry when calling
> > > > handlers, don't we? I thought we just calcurate out from curr_ret_stack.  
> > > 
> > > Basically we have this:
> > > 
> > >  array: | &fgraph_ops_1 | &fgraph_ops_2 | &fgraph_ops_stub | ...
> > > 
> > > On entry of function we do:
> > >   
> > 	push header(including original ret_addr) onto ret_stack
> 
> We can't put the ret_addr of the callback on the stack. What if that
> ret_addr is a module, and it gets unloaded? We must not call it.

But in that case, how can we recover the original addr on the kernel (real)
stack? I don't call the entry, but kretprobe handler will need the info
to record as a caller-address.

> > 
> > > 	for (i = 0; i < array_entries; i++) {
> > > 		if (array[i]->entryfunc(...)) {
> > > 			push i onto ret_stack;
> > > 		}
> > > 	}
> > > 
> > > On the return side, we do:
> > > 
> > > 	idx = pop ret_stack;
> > > 
> > > 	array[idx]->retfunc(...);  
> > 
> > So at this point we have the header on ret_stack, don't we? :)
> > 
> > Anyway, I think we may provide an API for unwinder to find correct
> > original return address form ret_stack. That is OK for me.
> 
> Yes. In fact, I have something that worked for that. I'll have to test
> it some more.

Great! I think it will be enough for kretprobe.

> > > > I need only sizeof(unsigned long). If the kretprobe user requires more,
> > > > it will be fall back to current method -- get an "instance" and store
> > > > its address to the entry :-)  
> > > 
> > > Awesome, then this shouldn't be too hard to implement.  
> > 
> > Oops, anyway I noticed that I must store a value on each area so that we can
> > identify which kretprobe is using that if there are several kretprobes on same
> > function. So, kretprobe implementation will be something like below.
> > 
> > kretprobe_retfunc(trace, regs)
> > {
> > 	kp = get_kprobe(trace->func);
> > 
> > 	if (private == to_kretprobe(kp)) // this is directly mapped to current kprobe
> > 		goto found_kretprobe;
> > 
> > 	if (!list_empty(&kp->list)) {	// we need to find from multiple kretprobes
> > 		list_for_each_entry(kp, &kp->list, list)
> > 			if (private == kp)
> > 				goto found_kretprobe;
> > 	}
> > 
> > 	// Or this must be an instance
> > 	struct kretprobe_instance *ri = trace->private;
> > 	rp = ri->rp;
> > 	if (valid_kretprobe(rp))
> > 		rp->handler(ri, regs);
> > 	kretprobe_recycle_instance(ri);
> > 	goto out;
> > 
> > found_kretprobe:
> > 	struct kretprobe_instance rii = {.rp = to_kretprobe(kp),
> > 		.ret_addr=trace->ret, .task = current}
> > 	rp->handler(&rii, regs);
> > 
> > out:
> > 	return 0;
> > }
> > 
> > I think we talked about pt_regs, which is redundant for return probe, so it should
> > be just a return value. (but how we pass it? trace->retval?)
> 
> Yeah, we can add that.

OK, then I will start with making a fake pt_regs on stack and call handler,
which will be something like,

	struct pt_regs regs = {};
	regs_set_return_value(&regs, trace->retval);
	rp->handler(ri, &regs);

Thank you,

> > That is OK for ftrace (but the transition needs more code).
> > And I would like to ask ebpf and systemtap people that is OK since it will change
> > the kernel ABI.
> 
> I agree.
> 
> -- Steve


-- 
Masami Hiramatsu <mhiramat@kernel.org>
