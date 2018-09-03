Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 942C7C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 03:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2386220856
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 03:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="R8Z2AiC5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2386220856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725866AbeICH4h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 03:56:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:32838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725762AbeICH4h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 03:56:37 -0400
Received: from devnote (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D77220652;
        Mon,  3 Sep 2018 03:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535945902;
        bh=ugwYJXlLP8c1/vRfYCjG9F8O8+60gmmCC871imf4h3A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=R8Z2AiC5ubkqLlticDJQbu/85VrM5Y9Dz3LFwnCYJMH3QXtk9zzHtgYISSoqu6VKf
         EvTGb+nNN6ijf9JGG+ItQ+Wf0D6ffgTgBSZ46Xs8rsk141jk+lSQVlvR0+44pwodSw
         H4+QgjUYqoT1gtm3LaSMzlEAZ7BCIDgdGgfgaTM4=
Date:   Mon, 3 Sep 2018 12:38:18 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Michael Rodin <michael@rodin.online>,
        linux-kernel@vger.kernel.org
Subject: Re: [BUGFIX PATCH -tip] kprobes/x86: Fix to copy RIP relative
 instruction correctly
Message-Id: <20180903123818.09681817c4bfe597549ea986@kernel.org>
In-Reply-To: <20180824165719.77d1d624d629ad3907dbb55c@kernel.org>
References: <153504457253.22602.1314289671019919596.stgit@devbox>
        <20180823214109.5b8f5756@vmware.local.home>
        <20180824165719.77d1d624d629ad3907dbb55c@kernel.org>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

Could you pick this fix to urgent branch?

Thank you,

On Fri, 24 Aug 2018 16:57:19 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Thu, 23 Aug 2018 21:41:09 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Fri, 24 Aug 2018 02:16:12 +0900
> > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > 
> > > Dump of assembler code from 0xffffffffa000207a to 0xffffffffa00020ea:
> > > 	54	push   %rsp
> > > ...
> > > 	48 83 c4 08	add    $0x8,%rsp
> > > 	9d	popfq
> > > 	48 89 f0	mov    %rsi,%rax
> > > 	8b 35 82 7d db e2	mov    -0x1d24827e(%rip),%esi
> > >         # 0xffffffff82db9e67 <nr_cpu_ids+3>
> > > 
> > > As it shows, the 2nd mov accesses *(nr_cpu_ids+3) instead of
> > > *nr_cpu_ids. This leads a kernel freeze because cpumask_next()
> > > always returns 0 and for_each_cpu() never ended.
> > 
> > Ouch! Nice catch.
> > 
> > > 
> > > Fixing this by adding len correctly to real RIP address while
> > > copying.
> > > 
> > > Fixes: 63fef14fc98a ("kprobes/x86: Make insn buffer always ROX and use text_poke()")
> > > Reported-by: Michael Rodin <michael@rodin.online>
> > > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > > Cc: stable@vger.kernel.org
> > > ---
> > >  arch/x86/kernel/kprobes/opt.c |    3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
> > > index eaf02f2e7300..e92672b8b490 100644
> > > --- a/arch/x86/kernel/kprobes/opt.c
> > > +++ b/arch/x86/kernel/kprobes/opt.c
> > > @@ -189,7 +189,8 @@ static int copy_optimized_instructions(u8 *dest, u8 *src, u8 *real)
> > >  	int len = 0, ret;
> > >  
> > >  	while (len < RELATIVEJUMP_SIZE) {
> > > -		ret = __copy_instruction(dest + len, src + len, real, &insn);
> > > +		ret = __copy_instruction(dest + len, src + len, real + len,
> > > +			&insn);
> > >  		if (!ret || !can_boost(&insn, src + len))
> > >  			return -EINVAL;
> > >  		len += ret;
> > 
> > Looking at the change that broke this we have:
> > 
> > > -static int copy_optimized_instructions(u8 *dest, u8 *src)
> > > +static int copy_optimized_instructions(u8 *dest, u8 *src, u8 *real)
> > >  {
> > >         struct insn insn;
> > >         int len = 0, ret;
> > >  
> > >         while (len < RELATIVEJUMP_SIZE) {
> > > -               ret = __copy_instruction(dest + len, src + len, &insn);
> > > +               ret = __copy_instruction(dest + len, src + len, real, &insn);
> > 
> > Where "real" was added as a parameter to __copy_instruction. Note that
> > we pass in "dest + len" but not "real + len" as you patch fixes.
> > __copy_instruction was changed by the bad commit with:
> > 
> > > -int __copy_instruction(u8 *dest, u8 *src, struct insn *insn)
> > > +int __copy_instruction(u8 *dest, u8 *src, u8 *real, struct insn *insn)
> > >  {
> > >         kprobe_opcode_t buf[MAX_INSN_SIZE];
> > >         unsigned long recovered_insn =
> > > @@ -387,11 +388,11 @@ int __copy_instruction(u8 *dest, u8 *src, struct insn *insn)
> > >                  * have given.
> > >                  */
> > >                 newdisp = (u8 *) src + (s64) insn->displacement.value
> > > -                         - (u8 *) dest;
> > > +                         - (u8 *) real;
> > 
> > "real" replaces "dest", which was the first parameter to __copy_instruction.
> > 
> > >                         return 0;
> > 
> > And:
> > 
> > >  int arch_prepare_optimized_kprobe(struct optimized_kprobe *op,
> > >                                   struct kprobe *__unused)
> > >  {
> > > -       u8 *buf;
> > > -       int ret;
> > > +       u8 *buf = NULL, *slot;
> > > +       int ret, len;
> > >         long rel;
> > >  
> > >         if (!can_optimize((unsigned long)op->kp.addr))
> > >                 return -EILSEQ;
> > >  
> > > -       op->optinsn.insn = get_optinsn_slot();
> > > -       if (!op->optinsn.insn)
> > > +       buf = kzalloc(MAX_OPTINSN_SIZE, GFP_KERNEL);
> > > +       if (!buf)
> > >                 return -ENOMEM;
> > >  
> > > +       op->optinsn.insn = slot = get_optinsn_slot();
> > > +       if (!slot) {
> > > +               ret = -ENOMEM;
> > > +               goto out;
> > > +       }
> > > +
> > >         /*
> > >          * Verify if the address gap is in 2GB range, because this uses
> > >          * a relative jump.
> > >          */
> > > -       rel = (long)op->optinsn.insn - (long)op->kp.addr + RELATIVEJUMP_SIZE;
> > > +       rel = (long)slot - (long)op->kp.addr + RELATIVEJUMP_SIZE;
> > >         if (abs(rel) > 0x7fffffff) {
> > > -               __arch_remove_optimized_kprobe(op, 0);
> > > -               return -ERANGE;
> > > +               ret = -ERANGE;
> > > +               goto err;
> > >         }
> > >  
> > > -       buf = (u8 *)op->optinsn.insn;
> > 
> > "slot" is equivalent to the old "buf".
> > 
> > > -       set_memory_rw((unsigned long)buf & PAGE_MASK, 1);
> > > +       /* Copy arch-dep-instance from template */
> > > +       memcpy(buf, &optprobe_template_entry, TMPL_END_IDX);
> > >  
> > >         /* Copy instructions into the out-of-line buffer */
> > > -       ret = copy_optimized_instructions(buf + TMPL_END_IDX, op->kp.addr);
> > > -       if (ret < 0) {
> > > -               __arch_remove_optimized_kprobe(op, 0);
> > > -               return ret;
> > > -       }
> > > +       ret = copy_optimized_instructions(buf + TMPL_END_IDX, op->kp.addr,
> > > +                                         slot + TMPL_END_IDX);
> > 
> > We pass in "real" as "slot + TMPL_END_IDX" and "dest" as "buf +
> > TMPL_END_IDX", thus to make it be equivalent to the code before this
> > commit, "real" should have "+ len" added to it in order to be
> > equivalent to what was there before.
> 
> Right! The broken commit splits trampoline buffer into 
> "temporary" destination buffer and "real" trampoline buffer,
> and use the "real" address for RIP-relative adjustment.
> However, I forgot to introduce update the "real" address
> in the copying loop.
> 
> > 
> > That said...
> > 
> > Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> Thanks!
> 
> 
> -- 
> Masami Hiramatsu <mhiramat@kernel.org>


-- 
Masami Hiramatsu <mhiramat@kernel.org>
