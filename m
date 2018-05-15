Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752336AbeEOW1G (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 18:27:06 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:34046 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752002AbeEOW1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 18:27:05 -0400
Date: Wed, 16 May 2018 00:26:45 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Josh Poimboeuf <jpoimboe@redhat.com>
cc: Alexey Dobriyan <adobriyan@gmail.com>,
        "Anvin, H Peter" <h.peter.anvin@intel.com>,
        "Ye, Xiaolong" <xiaolong.ye@intel.com>, Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>, Denys Vlasenko <dvlasenk@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        "tipbuild@zytor.com" <tipbuild@zytor.com>, "lkp@01.org" <lkp@01.org>
Subject: Re: [lkp-robot] [x86/asm] 51bad67ffb: int3:#[##]
In-Reply-To: <20180515222211.ods5hzne46hozojq@treble>
Message-ID: <alpine.DEB.2.21.1805160026060.1605@nanos.tec.linutronix.de>
References: <20180515080033.GA7714@yexl-desktop> <20180515210757.GA12225@avx2> <C40DC70F50313144AB3AF8625D4F407F90689B42@ORSMSX101.amr.corp.intel.com> <20180515214337.GA18021@avx2> <20180515222211.ods5hzne46hozojq@treble>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 May 2018, Josh Poimboeuf wrote:
> On Wed, May 16, 2018 at 12:43:37AM +0300, Alexey Dobriyan wrote:
> > On Tue, May 15, 2018 at 09:25:53PM +0000, Anvin, H Peter wrote:
> > > Why is that a problem?
> > > Code: 00 00 00 eb e6 cc cc cc cc cc cc cc cc cc cc cc cc cc fa 8d b6 00 00 00 00 e8 5d e8 8f ff 8b 44 24 34 83 e0 03 83 f8 03 72 28 cc &lt;cc&gt; cc cc cc cc cc cc fa 8d b6 00 00 00 00 e8 3d e8 8f ff 89 e0
> > > 
> > > EIP: ret_from_intr+0xd/0x14 SS:ESP: 0068:8603bfb4
> > > 
> > > INT3 slipped through M586 =&gt; X86_ALIGNMENT_16 :-\
> > 
> > I could make the patch x86_64 only, but!
> > 
> > It crashed into the middle of the padding.
> > 
> > 796ef8fc <ret_from_intr>:
> > 796ef8fc:       8b 44 24 34             mov    eax,DWORD PTR [esp+0x34]
> > 796ef900:       83 e0 03                and    eax,0x3
> > 796ef903:       83 f8 03                cmp    eax,0x3
> > 796ef906:       72 28                   jb     796ef930 <resume_kernel>
> > 796ef908:       cc                      int3
> > 796ef909:       cc       <========>     int3
> > 796ef90a:       cc                      int3
> > 796ef90b:       cc                      int3
> > 796ef90c:       cc                      int3
> > 796ef90d:       cc                      int3
> > 796ef90e:       cc                      int3
> > 796ef90f:       cc                      int3
> 
> The padding isn't needed there, and the resume_userspace symbol is never
> used, so wouldn't this fix it?

Gack. Right you are. I assumed that the ENTRY() is used without checking ....

> 
> diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
> index bef8e2b202a8..9e56243c984c 100644
> --- a/arch/x86/entry/entry_32.S
> +++ b/arch/x86/entry/entry_32.S
> @@ -338,7 +338,6 @@ ret_from_intr:
>  	cmpl	$USER_RPL, %eax
>  	jb	resume_kernel			# not returning to v8086 or userspace
>  
> -ENTRY(resume_userspace)
>  	DISABLE_INTERRUPTS(CLBR_ANY)
>  	TRACE_IRQS_OFF
>  	movl	%esp, %eax
> 
