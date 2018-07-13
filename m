Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7DD7ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 22:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6856A2087C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 22:04:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6856A2087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732642AbeGMWUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 18:20:42 -0400
Received: from mout.gmx.net ([212.227.15.18]:34121 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726161AbeGMWUm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 18:20:42 -0400
Received: from homer.simpson.net ([185.221.151.209]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MGSDw-1frHSU0tM0-00DFv7; Sat, 14
 Jul 2018 00:03:46 +0200
Message-ID: <1531519424.23898.68.camel@gmx.de>
Subject: Re: [PATCH RT v2] arm64: fpsimd: use a local_lock() in addition to
 local_bh_disable()
From:   Mike Galbraith <efault@gmx.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org
Date:   Sat, 14 Jul 2018 00:03:44 +0200
In-Reply-To: <20180713174937.5ddaqpylalcmc3jq@linutronix.de>
References: <20180517124006.ohygrrpg7z2moqqt@linutronix.de>
         <20180522131004.3012953c@gandalf.local.home>
         <20180522172115.fpqguqlsq6bavtxy@linutronix.de>
         <20180522132429.6f1dcf92@gandalf.local.home>
         <20180522173333.aawadhkcekzvrswp@linutronix.de>
         <20180711092555.268adf7f@gandalf.local.home>
         <20180711133157.bvrza5vmthu6lwjd@linutronix.de>
         <20180711093346.782af07a@gandalf.local.home>
         <20180713174937.5ddaqpylalcmc3jq@linutronix.de>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:yXRApYKx7pqrb2kPf9QHv7XhL1nC5Y+ScVK8202lvg7UDAKMzK0
 pD2uvy84/JmQnJ0bWUBGcWoMKJg2VOrbJ6uZIXwVCCmhhtlJP0ocAnjg9AsvtGGKOeXabDQ
 9IJ47t16PZPj914x0wnqanRdYLhDawZxAAKCL7jl+9GDJ3sdsYkV/VlYD4kkkw4e9bCZ68b
 e0bnEQTt2Q9oCYszk+svQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:i0l+AlOr7mo=:pvxJjlRLJENJ9cIv/K0246
 7YuuZ4Mywi+ySO7WHiJLck4fWnBznUAII3NCV4wZQScpSUjNkXlLmCnHxKVZ/U/9mXZqOgcgM
 FPI3vnM27j4wKYcqsXhRJvQinJLMQkSoiN61h9N9hfoTWVaZ8O2F4ZgRdDMfzXNNyA1fWHpMN
 LLnFdhfu43QLq4BtYArQX2o/2CEbx2wSleg9u7n+senyhfxavp3KS32IRZ2oMjyVrnpm0YVgW
 CLVaO1nnsV9c/frcRHmz35ekSBdQgAbr2FnKLGo3Ck8I4QT8dNw8JSvdgxNO8QKCs/53Zpwxb
 z8nMUJBOVbzOtUXpBNyVQwbg3OyFM7y5p0wBxERKDlH8vBAeWthORm7lH62wf9oKbsTMKkPTH
 7OVpsCuQ4Z4e3Zrj3/cTYggiHH1QMsiUzfxdBcytajnUGOOl60gYs2hihFU5BTtgyGzwwEnfJ
 OlQCR6K2Q9YREaL+YuvhOxQk6wBuhReSHoAIjGkVlguK6E28YZelteSaEalqyZVJ+oz2CfsvU
 po9Bogns4o0N8H3/LqmGjwmJ8sc8qzlaMGkmL60HUphciO7LTVAnB5NPhxbIKy/44uFvAWjtV
 U8tY1m4yyIsK0/5/eXfIO54wutSgy230ma5fcX9Y66GSow3N/efd3HKeV9ahjeEO6RCFfzhOi
 SnxlEs4GS+FZgP8S4mg/9OxSCkq3pOS+R222b9ypmzwArOcV/qtArWx72xncvaVYYK1jpKw57
 jByNJ2qOuBAwQDDAbFAsnjxsFcmq079tcGmVaXoUv1j/1Bql4aqjeRW5FFTVJgrg3qCcQ9tXx
 2qll3bD
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-07-13 at 19:49 +0200, Sebastian Andrzej Siewior wrote:
> In v4.16-RT I noticed a number of warnings from task_fpsimd_load(). The
> code disables BH and expects that it is not preemptible. On -RT the
> task remains preemptible but remains the same CPU. This may corrupt the
> content of the SIMD registers if the task is preempted during
> saving/restoring those registers.
> Add a locallock around this process. This avoids that the any function
> within the locallock block is invoked more than once on the same CPU.
> 
> The kernel_neon_begin() can't be kept preemptible. If the task-switch notices
> TIF_FOREIGN_FPSTATE then it would restore task's SIMD state and we lose the
> state of registers used for in-kernel-work. We would require additional storage
> for the in-kernel copy of the registers. But then the NEON-crypto checks for
> the need-resched flag so it shouldn't that bad.
> The preempt_disable() avoids the context switch while the kernel uses the SIMD
> registers. Unfortunately we have to balance out the migrate_disable() counter
> because local_lock_bh() is invoked in different context compared to its unlock
> counterpart.
> 
> __efi_fpsimd_begin() should not use kernel_fpu_begin() due to its
> preempt_disable() context and instead save the registers always in its
> extra spot on RT.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> 
> This seems to make work (crypto chacha20-neon + cyclictest). I have no
> EFI so I have no clue if saving SIMD while calling to EFI works.

All is not well on cavium test box.  I'm seeing random errors ala...

./include/linux/fs.h:3137:11: internal compiler error: Segmentation fault
./include/linux/bio.h:175:1: internal compiler error: in grokdeclarator, at c/c-decl.c:7023

...during make -j96 (2*cpus) kbuild.  Turns out 4.14-rt has this issue
as well, which is unsurprising if it's related to fpsimd woes.  Box
does not exhibit the issue with NONRT kernels, PREEMPT or NOPREEMPT.

To file under FWIW, arm64 configured SLE15-RT, 4.12 based kernel
containing virgin @stable arch/arm64/kernel/fpsimd.c, does not exhibit
the problem. (relevant? dunno, it may be unrelated to fpsimd.c).

	-Mike
