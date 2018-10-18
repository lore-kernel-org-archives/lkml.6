Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC65C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 13:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3D592098A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 13:28:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3D592098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbeJRV32 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 17:29:28 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:34558 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbeJRV31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 17:29:27 -0400
Received: from [213.61.215.195] (helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gD8LR-0000UN-Ry; Thu, 18 Oct 2018 15:28:10 +0200
Date:   Thu, 18 Oct 2018 15:28:08 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Tim Chen <tim.c.chen@linux.intel.com>
cc:     Jiri Kosina <jikos@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [Patch v3 07/13] x86/process Add arch_set_dumpable
In-Reply-To: <6c8538c428d6335efae926c1e6a6fd26a3f9a1b8.1539798901.git.tim.c.chen@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1810181522230.1647@nanos.tec.linutronix.de>
References: <cover.1539798901.git.tim.c.chen@linux.intel.com> <6c8538c428d6335efae926c1e6a6fd26a3f9a1b8.1539798901.git.tim.c.chen@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Oct 2018, Tim Chen wrote:

> Add arch_set_dumpable for setting architecture specific security
> modifications on processes according to its dumpable properties.
> Non dumpable processes are security sensitive and they can be modified
> to gain architecture specific security defenses via arch_set_dumpable.

You love that sentence, right? But it's still wrong.

arch_set_dumpable() does arch specific extra modifications depending on
'value'. It's not a one way street. It can tighten or relax.

> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> ---
>  fs/exec.c | 6 ++++++

And this is related to the subsystem in $subject (x86/process) in which way?

>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index e204830..6f329fc 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1940,6 +1940,11 @@ void set_binfmt(struct linux_binfmt *new)
>  }
>  EXPORT_SYMBOL(set_binfmt);
>  
> +void __weak arch_set_dumpable(struct task_struct *tsk, unsigned int value)
> +{
> +	return;
> +}
> +
>  /*
>   * set_dumpable stores three-value SUID_DUMP_* into mm->flags.
>   */
> @@ -1956,6 +1961,7 @@ void set_dumpable(struct task_struct *tsk, unsigned int value)
>  		old = READ_ONCE(tsk->mm->flags);
>  		new = (old & ~MMF_DUMPABLE_MASK) | value;
>  	} while (cmpxchg(&tsk->mm->flags, old, new) != old);
> +	arch_set_dumpable(tsk, value);

So now the obvious question. set_dumpable() operates on tsk->mm. i.e. it's
a process wide operation. But arch_set_dumpable() operates on the task
itself. What about the other tasks of that process?

Thanks,

	tglx
