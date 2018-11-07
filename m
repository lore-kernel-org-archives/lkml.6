Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E057C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 12:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1AFD2086C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 12:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QaRheIzw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1AFD2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730876AbeKGWAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 17:00:49 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50277 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbeKGWAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 17:00:48 -0500
Received: by mail-wm1-f66.google.com with SMTP id 124-v6so8960078wmw.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 04:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=G/+9Mm/FZQiUdTYOUTeXfBsPCncklksAWfMq+/ZZNpw=;
        b=QaRheIzwhbiuhZVUS2VKgRqRc354Xsh/vDU6gLjRplxSFauf8bFwuHMbM3caXYxb38
         KtN5gAHWXxwQuhnLzDVLXcAerbE3OM6YLsD8k1Ex4VtswYT6my0Hu6WevAEULZphKYQF
         VWTq+gSPe2Kt7DHmga/75jpWEK0fQQcvQkz9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=G/+9Mm/FZQiUdTYOUTeXfBsPCncklksAWfMq+/ZZNpw=;
        b=ipznn9CIFrcV4UhX7LXP2NqICG9a6QjnSVoJpOy2qYsggxnUl67Azmc8XyCRqz/J9H
         Ia0HQPiuQKBYxUpYC6YyNVsZABHxisYW1WpeWyyIdwTS7hZGPaJ2dPKA/mIuL2c5LmOp
         WLNblTWUwCozA5nvF2ptiLN60OYIzN2ZwPyeGVD7EZFk7ocBMg768F9Gzme4JMj3h6ms
         WO+gktgZ/1VXNhYavjcmjY8OEWEiISV6izFAfhlgzNPCzsciwb117amZJSnz3tyR/GzY
         ccfLBb/XQdk7KycsPLOY6e1vvkokRbnnT9TeX4KXTm5acyWhKbShhXPoIe3s/yfHGFtI
         D3WA==
X-Gm-Message-State: AGRZ1gIYpnrevGhDOJrWwJK1XeqdcDwQjQwnIMDMP73DKVufkFRtUyPB
        iyUpGord8PzgLlzcBRzIJMh34Q==
X-Google-Smtp-Source: AJdET5efMJrhZXNBjZOFZg1AgWx8oQglO2nH9hHVRW9PuV9X5uCUqNEaIxUKXRYKFc3lWc1c+nm7wQ==
X-Received: by 2002:a7b:c0cc:: with SMTP id s12-v6mr8496wmh.39.1541593835149;
        Wed, 07 Nov 2018 04:30:35 -0800 (PST)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id r188-v6sm1036270wmg.19.2018.11.07.04.30.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Nov 2018 04:30:34 -0800 (PST)
Date:   Wed, 7 Nov 2018 12:30:32 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Peter Zijlstra <peterz@infradead.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] kdb: Don't back trace on a cpu that didn't round
 up
Message-ID: <20181107123032.ytwzfkkwajuo4tsj@holly.lan>
References: <20181107010028.184543-1-dianders@chromium.org>
 <20181107010028.184543-5-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181107010028.184543-5-dianders@chromium.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 05:00:28PM -0800, Douglas Anderson wrote:
> If you have a CPU that fails to round up and then run 'btc' you'll end
> up crashing in kdb becaue we dereferenced NULL.  Let's add a check.
> It's wise to also set the task to NULL when leaving the debugger so
> that if we fail to round up on a later entry into the debugger we
> won't backtrace a stale task.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
> Changes in v3:
> - New for v3.
> 
> Changes in v2: None
> 
>  kernel/debug/debug_core.c |  1 +
>  kernel/debug/kdb/kdb_bt.c | 11 ++++++++++-
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
> index 324cba8917f1..08851077c20a 100644
> --- a/kernel/debug/debug_core.c
> +++ b/kernel/debug/debug_core.c
> @@ -587,6 +587,7 @@ static int kgdb_cpu_enter(struct kgdb_state *ks, struct pt_regs *regs,
>  			kgdb_info[cpu].exception_state &=
>  				~(DCPU_WANT_MASTER | DCPU_IS_SLAVE);
>  			kgdb_info[cpu].enter_kgdb--;
> +			kgdb_info[cpu].task = NULL;

This code isn't quite right.

In particular there are two exit paths from kgdb_cpu_enter() and this
code path is for slave exit only (and master may change the next time we
re-enter kgdb). It also looks very odd to have an unconditional clear
next to a decrement that takes account of debugger re-entrancy.

Note also that there is similar code in kdb_debugger.c (search for "zero
out any offline cpu data") which should be tidied up if we decide to do
the same clean up in a different way.

I'll leave it to you whether to fix the existing code or add new code
here but if you do add it in kgdb_cpu_enter() it must cover both return
paths, include debuggerinfo as well, and kdb_debugger.c needs to be
tidied up.


Daniel.


>  			smp_mb__before_atomic();
>  			atomic_dec(&slaves_in_kgdb);
>  			dbg_touch_watchdogs();
> diff --git a/kernel/debug/kdb/kdb_bt.c b/kernel/debug/kdb/kdb_bt.c
> index 7921ae4fca8d..7e2379aa0a1e 100644
> --- a/kernel/debug/kdb/kdb_bt.c
> +++ b/kernel/debug/kdb/kdb_bt.c
> @@ -186,7 +186,16 @@ kdb_bt(int argc, const char **argv)
>  		kdb_printf("btc: cpu status: ");
>  		kdb_parse("cpu\n");
>  		for_each_online_cpu(cpu) {
> -			sprintf(buf, "btt 0x%px\n", KDB_TSK(cpu));
> +			void *kdb_tsk = KDB_TSK(cpu);
> +
> +			/* If a CPU failed to round up we could be here */
> +			if (!kdb_tsk) {
> +				kdb_printf("WARNING: no task for cpu %ld\n",
> +					   cpu);
> +				continue;
> +			}
> +
> +			sprintf(buf, "btt 0x%px\n", kdb_tsk);
>  			kdb_parse(buf);
>  			touch_nmi_watchdog();
>  		}
> -- 
> 2.19.1.930.g4563a0d9d0-goog
> 
