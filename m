Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2F5C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEB73217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NCZdPJo3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730087AbeLSQz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 11:55:58 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38730 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727544AbeLSQz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 11:55:58 -0500
Received: by mail-wr1-f67.google.com with SMTP id v13so20229709wrw.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 08:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tIB/dUd9ElKQXjOyP0jBb9ur8VSui0md/nlD1FTG09w=;
        b=NCZdPJo3+1PVKnSzm9/e+XPjeeQ1tVIcRTAYJ6qF/8WOBC5o8Dbdvgr+RhsroA+FPI
         +lSiqHIRoTVlYwSznKb5ChGg2bSiCVjlfCSmGjOIe6eHkKMZUzLeSx+YS83o0czAMgOM
         JvBJRlPOZUnNmZJ9LmLpks90En7hw48g3b1Ws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tIB/dUd9ElKQXjOyP0jBb9ur8VSui0md/nlD1FTG09w=;
        b=O6+J2qCVggtCZc0PKro5dJthDFGzQksHSHjbbypqvdPMchR3QpkB+IfUtGgszYQydt
         HzMyv8T2snc5FG+frWJOzxV5svEopc6bWxe+KVkJgoeYZB2BnsAjY9edTL+QliEp0b9G
         B09OVa/87gxiTyRu7azx8z8jonVXGSpeCKAHPn3I2GC5mDbydOUygKm1jUiCSXb8sqMJ
         L3/N6N9S3CTLtUx5Vhh6O7IXLPOEOtrXwTu01rg/KQ9xTrP7qoDXev2dTOu36m2CG7Nh
         ucWrrjTny40phb7uM+j/eM/OsAPAaXs35kTTpm7waAtqD4nGjmj0/QprQW8gF9jvuqsO
         7BeA==
X-Gm-Message-State: AA+aEWaxgOQG97ksF1/qmXb/mRqDFw4bChJvh3G9hJyQrq9PsLL4lfdg
        Sn9J7jKLQqHvbADxb1L4H8j1Yg==
X-Google-Smtp-Source: AFSGD/XmLACU44KbaxHXdZQGOV+3WR5q743rqUojYanHmNxr37M7UYRZ65NGB67t28J3YVYo3oYZCg==
X-Received: by 2002:adf:a1d2:: with SMTP id v18mr18453414wrv.87.1545238555836;
        Wed, 19 Dec 2018 08:55:55 -0800 (PST)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id c12sm4481262wrs.82.2018.12.19.08.55.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 08:55:55 -0800 (PST)
Date:   Wed, 19 Dec 2018 16:55:53 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Will Deacon <will.deacon@arm.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Peter Zijlstra <peterz@infradead.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-kernel@vger.kernel.org
Subject: Re: [REPOST PATCH v6 4/4] kdb: Don't back trace on a cpu that didn't
 round up
Message-ID: <20181219165553.otpt6ovcshxu7a7p@holly.lan>
References: <20181205033828.6156-1-dianders@chromium.org>
 <20181205033828.6156-5-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181205033828.6156-5-dianders@chromium.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 07:38:28PM -0800, Douglas Anderson wrote:
> If you have a CPU that fails to round up and then run 'btc' you'll end
> up crashing in kdb becaue we dereferenced NULL.  Let's add a check.
> It's wise to also set the task to NULL when leaving the debugger so
> that if we fail to round up on a later entry into the debugger we
> won't backtrace a stale task.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>

Applied! Thanks.


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
> 2.20.0.rc1.387.gf8505762e3-goog
> 
