Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF42AC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 14:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B07BD2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 14:42:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B07BD2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbeLJOmE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 09:42:04 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:33479 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726888AbeLJOmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 09:42:04 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gWMkw-0005Vh-JX; Mon, 10 Dec 2018 15:41:58 +0100
Date:   Mon, 10 Dec 2018 15:41:58 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 29/29] x86/fpu: Defer FPU state load until return to
 userspace
Message-ID: <20181210144158.46sbqy5b3lkhcra5@linutronix.de>
References: <20181128222035.2996-1-bigeasy@linutronix.de>
 <20181128222035.2996-30-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20181128222035.2996-30-bigeasy@linutronix.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-11-28 23:20:35 [+0100], To linux-kernel@vger.kernel.org wrote:
> --- a/arch/x86/kernel/fpu/signal.c
> +++ b/arch/x86/kernel/fpu/signal.c
> @@ -228,13 +228,12 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
>  	struct task_struct *tsk = current;
>  	struct fpu *fpu = &tsk->thread.fpu;
>  	int state_size = fpu_kernel_xstate_size;
> -	union fpregs_state *state;
> -	void *tmp;
>  	struct user_i387_ia32_struct env;
>  	struct user_i387_ia32_struct *envp = NULL;
>  	int ret = 0;
>  	u64 xfeatures = 0;
>  	int fx_only = 0;
> +	int err;
>  
…
>  	} else if (use_fxsr()) {
> -		ret = __copy_from_user(&state->fxsave, buf_fx, state_size);
> -		if (ret)
> +		ret = __copy_from_user(&fpu->state.fxsave, buf_fx, state_size);
> +		if (ret) {
> +			err = -EFAULT;
>  			goto err_out;
> +		}

After reworking the series after addressing the comments for 08/29 I
noticed that `err' should have been `ret'. 

Sebastian
