Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F25C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECF6A20672
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fCBRVLk7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECF6A20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbeLCQD3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 11:03:29 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41130 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbeLCQD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 11:03:29 -0500
Received: by mail-wr1-f65.google.com with SMTP id x10so12750466wrs.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 08:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=06FJKPDjtfdMx+1q4EAWwbubvg4EI5lJBwYBjs/Hhoc=;
        b=fCBRVLk7e8zijVcqeaatmESL/CPzITcZ9BXXxPmbydWZ/81hPfLIwCLV4M1C033b7n
         mT5Ux9blJd/exgMey+EVMUDc9vH7daj84qEYPlGh9KClcwKgWMityLGThStxa9rmN/ke
         MEE0B5CmK32znMmwGxHG3zbQ6vDV8xzC8APV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=06FJKPDjtfdMx+1q4EAWwbubvg4EI5lJBwYBjs/Hhoc=;
        b=J0ZGwBATx2GgljmvMe3ARQfpmf4666gyJPLEKBn7PgRC8kdmXg6xSLY9FCNS2rrBKa
         NFa3BM+XuXMsw/GDEKfbsJgxVKRyCQdNVvl0v1WVoDLj+m2ZisiatQmT74S7MUCPyfeo
         RE0zxu9u4Yh6Lj1/wJgcWJkpPiRHWb8bPcHs+TYa02sumH0FNcXyRCcCToI/t6P7u3i+
         IqZ24aBhdi9BQMY0cg+AFwdHcYOHRCaktHbjSOXbmo15mwqxQtiu/lUrp8hDrD/8SIEf
         799ihRQgiN044UFeFUfb9PPxzqMIEgh8oP1EpnMNxyoC927MVKuv7gey6Co2sQvHG2ju
         Y7qQ==
X-Gm-Message-State: AA+aEWZqKOk2Pj8Ff8MrT8DIJ55PXTEo5gtOzSw5QU9CYrrRdOgZxzak
        GPGBZFSvtsMTcFH5nid9Gw/HVA==
X-Google-Smtp-Source: AFSGD/XoQVdl5tVJQt/rAT3JozsoB8Ko6KdI4EtPhIcuzTmAcHPmjc2Ol9VBY3s5KLbWyO8DABtTeQ==
X-Received: by 2002:adf:e18d:: with SMTP id k13mr15029376wri.36.1543853001585;
        Mon, 03 Dec 2018 08:03:21 -0800 (PST)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id y185sm6151594wmg.34.2018.12.03.08.03.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 08:03:20 -0800 (PST)
Date:   Mon, 3 Dec 2018 16:03:18 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Will Deacon <will.deacon@arm.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Peter Zijlstra <peterz@infradead.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/4] kdb: Don't back trace on a cpu that didn't round
 up
Message-ID: <20181203160318.35idsm2vb3licod6@holly.lan>
References: <20181127173839.34328-1-dianders@chromium.org>
 <20181127173839.34328-5-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181127173839.34328-5-dianders@chromium.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 09:38:39AM -0800, Douglas Anderson wrote:
> If you have a CPU that fails to round up and then run 'btc' you'll end
> up crashing in kdb becaue we dereferenced NULL.  Let's add a check.
> It's wise to also set the task to NULL when leaving the debugger so
> that if we fail to round up on a later entry into the debugger we
> won't backtrace a stale task.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Acked-by: Daniel Thompson <daniel.thompson@linaro.org>

> ---
> 
> Changes in v6: None
> Changes in v5: None
> Changes in v4:
> - Also clear out .debuggerinfo.
> - Also clear out .debuggerinfo and .task for the master.
> - Remove clearing out in kdb_stub for offline CPUs; it's now redundant.
> 
> Changes in v3:
> - Don't back trace on a cpu that didn't round up new for v3.
> 
> Changes in v2: None
> 
>  kernel/debug/debug_core.c       |  4 ++++
>  kernel/debug/kdb/kdb_bt.c       | 11 ++++++++++-
>  kernel/debug/kdb/kdb_debugger.c |  7 -------
>  3 files changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
> index 1fb8b239e567..5cc608de6883 100644
> --- a/kernel/debug/debug_core.c
> +++ b/kernel/debug/debug_core.c
> @@ -592,6 +592,8 @@ static int kgdb_cpu_enter(struct kgdb_state *ks, struct pt_regs *regs,
>  				arch_kgdb_ops.correct_hw_break();
>  			if (trace_on)
>  				tracing_on();
> +			kgdb_info[cpu].debuggerinfo = NULL;
> +			kgdb_info[cpu].task = NULL;
>  			kgdb_info[cpu].exception_state &=
>  				~(DCPU_WANT_MASTER | DCPU_IS_SLAVE);
>  			kgdb_info[cpu].enter_kgdb--;
> @@ -724,6 +726,8 @@ static int kgdb_cpu_enter(struct kgdb_state *ks, struct pt_regs *regs,
>  	if (trace_on)
>  		tracing_on();
>  
> +	kgdb_info[cpu].debuggerinfo = NULL;
> +	kgdb_info[cpu].task = NULL;
>  	kgdb_info[cpu].exception_state &=
>  		~(DCPU_WANT_MASTER | DCPU_IS_SLAVE);
>  	kgdb_info[cpu].enter_kgdb--;
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
> diff --git a/kernel/debug/kdb/kdb_debugger.c b/kernel/debug/kdb/kdb_debugger.c
> index 15e1a7af5dd0..53a0df6e4d92 100644
> --- a/kernel/debug/kdb/kdb_debugger.c
> +++ b/kernel/debug/kdb/kdb_debugger.c
> @@ -118,13 +118,6 @@ int kdb_stub(struct kgdb_state *ks)
>  	kdb_bp_remove();
>  	KDB_STATE_CLEAR(DOING_SS);
>  	KDB_STATE_SET(PAGER);
> -	/* zero out any offline cpu data */
> -	for_each_present_cpu(i) {
> -		if (!cpu_online(i)) {
> -			kgdb_info[i].debuggerinfo = NULL;
> -			kgdb_info[i].task = NULL;
> -		}
> -	}
>  	if (ks->err_code == DIE_OOPS || reason == KDB_REASON_OOPS) {
>  		ks->pass_exception = 1;
>  		KDB_FLAG_SET(CATASTROPHIC);
> -- 
> 2.20.0.rc0.387.gc7a69e6b6c-goog
> 
