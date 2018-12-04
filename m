Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DEE1C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19E4A208A3
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lisiU2Ig"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19E4A208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbeLDICe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 03:02:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:50932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725983AbeLDICe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 03:02:34 -0500
Received: from devnote (p35161-mobac01.tokyo.ocn.ne.jp [153.233.26.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD1FB20850;
        Tue,  4 Dec 2018 08:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543910553;
        bh=E3JVcOtKtd48xM7mKtfGHU7pzt7S7wSzrsimNLkgXng=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lisiU2IgrGcuua4xiAj1XGYaK8UK5cRGccegG2vCAGfJOJpsQVZHwGY+VR4IBqSyg
         0QzLNPn0uPqomJaXu4Sq2oQWqd/IemlbuWBjib38cVRQF3ZzkqIR4kZzoqKo3CADnS
         3yZS3fo5tGVHd0DZYqS6ZAMOMsLUPxqcRlHJhnu0=
Date:   Tue, 4 Dec 2018 17:02:29 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@amacapital.net>
Subject: Re: Strange hang with gcc 8 of kprobe multiple_kprobes test
Message-Id: <20181204170229.4442d43ce956d48619c1d232@kernel.org>
In-Reply-To: <20181204164007.956a3458c9fd301b3d173eba@kernel.org>
References: <20181203211807.17e03384@vmware.local.home>
        <20181204164007.956a3458c9fd301b3d173eba@kernel.org>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Dec 2018 16:40:07 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hi Steve,
> 
> On Mon, 3 Dec 2018 21:18:07 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > Hi Masami,
> > 
> > I started testing some of my new code and the system got into a
> > strange state. Debugging further, I found the cause came from the
> > kprobe tests. It became stranger to me that I could reproduce it with
> > older kernels. I went back as far as 4.16 and it triggered. I thought
> > this very strange because I ran this test on all those kernels in the
> > past.
> > 
> > After a bit of hair pulling, I figured out what changed. I upgraded to
> > gcc 8.1 (and I reproduce it with 8.2 as well). I convert back to gcc 7
> > and the tests pass without issue.
> 
> OK, let me see.
> 
> > The issue that I notice when the system gets into this strange state is
> > that I can't log into the box. Nor can I reboot. Basically it's
> > anything to do with systemd just doesn't work (insert your jokes here
> > now, and then let's move on).
> > 
> > I was able to narrow down what the exact function was that caused the
> > issues and it is: update_vsyscall()
> > 
> > gcc 7 looks like this:
> > 
> > ffffffff81004bf0 <update_vsyscall>:
> > ffffffff81004bf0:       e8 0b cc 9f 00          callq  ffffffff81a01800 <__fentry__>
> >                         ffffffff81004bf1: R_X86_64_PC32 __fentry__-0x4
> > ffffffff81004bf5:       48 8b 07                mov    (%rdi),%rax
> > ffffffff81004bf8:       8b 15 96 5f 34 01       mov    0x1345f96(%rip),%edx        # ffffffff8234ab94 <vclocks_used>
> >                         ffffffff81004bfa: R_X86_64_PC32 vclocks_used-0x4
> > ffffffff81004bfe:       83 05 7b 84 6f 01 01    addl   $0x1,0x16f847b(%rip)        # ffffffff826fd080 <vsyscall_gtod_data>
> >                         ffffffff81004c00: R_X86_64_PC32 vsyscall_gtod_data-0x5
> > ffffffff81004c05:       8b 48 24                mov    0x24(%rax),%ecx
> > ffffffff81004c08:       b8 01 00 00 00          mov    $0x1,%eax
> > ffffffff81004c0d:       d3 e0                   shl    %cl,%eax
> > 
> > And gcc 8 looks like this:
> > 
> > ffffffff81004c90 <update_vsyscall>:
> > ffffffff81004c90:       e8 6b cb 9f 00          callq  ffffffff81a01800 <__fentry__>
> >                         ffffffff81004c91: R_X86_64_PC32 __fentry__-0x4
> > ffffffff81004c95:       48 8b 07                mov    (%rdi),%rax
> > ffffffff81004c98:       83 05 e1 93 6f 01 01    addl   $0x1,0x16f93e1(%rip)        # ffffffff826fe080 <vsyscall_gtod_data>
> 
> Hm this is a RIP relative instruction, it should be modified by kprobes.
> 
> >                         ffffffff81004c9a: R_X86_64_PC32 vsyscall_gtod_data-0x5
> > ffffffff81004c9f:       8b 50 24                mov    0x24(%rax),%edx
> > ffffffff81004ca2:       8b 05 ec 5e 34 01       mov    0x1345eec(%rip),%eax        # ffffffff8234ab94 <vclocks_used>
> >                         ffffffff81004ca4: R_X86_64_PC32 vclocks_used-0x4
> > 
> > The test adds a kprobe (optimized) at udpate_vsyscall+5. And will
> > insert a jump on the two instructions after fentry. The difference
> > between v7 and v8 is that v7 is touching vclocks_used and v8 is
> > touching vsyscall_gtod_data.
> > 
> > Is there some black magic going on with the vsyscall area with
> > vsyscall_gtod_data that is causing havoc when a kprobe is added there?
> 
> I think it might miss something when preprocessing RIP relative instruction.

Ah, I got it. I thought it had been fixed, but not...

In arch/x86/kernel/kprobes/opt.c, copy_optimized_instructions() does a copy
loop, but only update src and dest cursors, but not update real address
which is used for adjusting RIP relative instruction.

        while (len < RELATIVEJUMP_SIZE) {
                ret = __copy_instruction(dest + len, src + len, real, &insn);
                if (!ret || !can_boost(&insn, src + len))
                        return -EINVAL;
                len += ret;
        }

I remember I have fixed this, and actually WE did it :-D

https://lkml.org/lkml/2018/8/23/1203

Ah, we hit a same bug...

Ingo, could you pick the patch? Should I resend it?

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
