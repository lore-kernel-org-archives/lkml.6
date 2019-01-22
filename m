Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9557AC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 21:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49B7820866
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 21:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="bpG16L4S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfAVVxQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 16:53:16 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35808 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbfAVVxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 16:53:16 -0500
Received: by mail-wr1-f66.google.com with SMTP id 96so109204wrb.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 13:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OwmuQJG4J84U89kSAZNwKuCo+PTAbgAaqzPSmSChnAc=;
        b=bpG16L4SOLYvpuRIPx8dRRKcd+z03KHJ2Pz4pISAmhhR3bcMFUcFDDeC+Svt5Ju4Bn
         MrUAE8mqpheCD1h/RL7C+73N+9g+pTqGgpbs0zKmleo5jj5go1XvYwkOBzlKG6DXVeyl
         e7uYpLpkP+EIdR7HYUrjV65FY2s404anwGQzQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OwmuQJG4J84U89kSAZNwKuCo+PTAbgAaqzPSmSChnAc=;
        b=o9ilbknaT1FuqFSuUe2+9YJxsGabF1HKmDO6EEkDj3jBbxXmXQK8NcaSgdCcMxpV9O
         KXsBbaZo8xyHy9yNHA3YWFPvL+2EMfLbq5qHJPwPu4T2KQJ8taMDcluo4D0lAQC+yGi4
         n+w8k5Hadq25/3us/oc2j8N8Tbl15setoSAvs2Yece30b1Qu+r/804e1xO1UPL6jNxT4
         YMSHjgHGR/KLaiFRJXXtjuudHuNQc+uy5Rg0QdXkPvGcWG7khSurKjSv2CKmjnQKPcP+
         4nFF8KxKEr4qvyLbIHbyHEHAXhbvxUlUluZycm2e76FmwEz6Jr3B90HESUq85QnUT/yq
         c2Cg==
X-Gm-Message-State: AJcUukcfX/GsxLCWOMFQoBc2HqYAERBjLFXd+Z/wzulmD4NL49ryAHKC
        s40VaLocGg0flvzsLlU3LrRIiA==
X-Google-Smtp-Source: ALg8bN7Gzq9C4cKv6LWzGLOmVLD9nUDbjCr0xcb66f/IfNtht8pTXjzVPnI+NP96jvPIS2TVIFVXrQ==
X-Received: by 2002:adf:ee89:: with SMTP id b9mr35964284wro.246.1548193993781;
        Tue, 22 Jan 2019 13:53:13 -0800 (PST)
Received: from localhost ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id c65sm54802277wma.24.2019.01.22.13.53.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 13:53:13 -0800 (PST)
Date:   Tue, 22 Jan 2019 16:53:11 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Viktor Rosendahl <Viktor.Rosendahl@bmw.de>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] preemptirq_delay_test: Add the burst feature and a
 sysfs trigger
Message-ID: <20190122215311.GA200493@google.com>
References: <1548074113-16599-1-git-send-email-Viktor.Rosendahl@bmw.de>
 <1548074113-16599-3-git-send-email-Viktor.Rosendahl@bmw.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548074113-16599-3-git-send-email-Viktor.Rosendahl@bmw.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viktor,

Could you CC me on the other patches as well, next time? I am quite
interested and recently have worked on the latency tracer.

Some comments below:

On Mon, Jan 21, 2019 at 02:35:11PM +0200, Viktor Rosendahl wrote:
> This burst feature enables the user to generate a burst of
> preempt/irqsoff latencies. This makes it possible to test whether we
> are able to detect latencies that systematically occur very close to
> each other.
> 
> In addition, there is a sysfs trigger, so that it's not necessary to
> reload the module to repeat the test. The trigger will appear as
> /sys/kernel/preemptirq_delay_test/trigger in sysfs.
> 
> Signed-off-by: Viktor Rosendahl <Viktor.Rosendahl@bmw.de>
> ---
>  kernel/trace/preemptirq_delay_test.c | 139 +++++++++++++++++++++++----
>  1 file changed, 120 insertions(+), 19 deletions(-)
> 
> diff --git a/kernel/trace/preemptirq_delay_test.c b/kernel/trace/preemptirq_delay_test.c
> index d8765c952fab..1fc3cdbdd293 100644
> --- a/kernel/trace/preemptirq_delay_test.c
> +++ b/kernel/trace/preemptirq_delay_test.c
> @@ -3,6 +3,7 @@
>   * Preempt / IRQ disable delay thread to test latency tracers
>   *
>   * Copyright (C) 2018 Joel Fernandes (Google) <joel@joelfernandes.org>
> + * Copyright (C) 2018 BMW Car IT GmbH
>   */
>  
>  #include <linux/trace_clock.h>
> @@ -10,18 +11,23 @@
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
>  #include <linux/kernel.h>
> +#include <linux/kobject.h>
>  #include <linux/kthread.h>
>  #include <linux/module.h>
>  #include <linux/printk.h>
>  #include <linux/string.h>
> +#include <linux/sysfs.h>
>  
>  static ulong delay = 100;
> -static char test_mode[10] = "irq";
> +static char test_mode[12] = "irq";
> +static uint burst_size = 1;
>  
> -module_param_named(delay, delay, ulong, S_IRUGO);
> -module_param_string(test_mode, test_mode, 10, S_IRUGO);
> -MODULE_PARM_DESC(delay, "Period in microseconds (100 uS default)");
> -MODULE_PARM_DESC(test_mode, "Mode of the test such as preempt or irq (default irq)");
> +module_param_named(delay, delay, ulong, 0444);
> +module_param_string(test_mode, test_mode, 12, 0444);
> +module_param_named(burst_size, burst_size, uint, 0444);
> +MODULE_PARM_DESC(delay, "Period in microseconds (100 us default)");
> +MODULE_PARM_DESC(test_mode, "Mode of the test such as preempt, irq, or alternate (default irq)");
> +MODULE_PARM_DESC(burst_size, "The size of a burst (default 1)");

Where are we bounds checking the burst_size here? It seems like a high
burst_size can overflow your array of functions.

>  
>  static void busy_wait(ulong time)
>  {
> @@ -34,37 +40,132 @@ static void busy_wait(ulong time)
>  	} while ((end - start) < (time * 1000));
>  }
>  
> -static int preemptirq_delay_run(void *data)
> +static __always_inline void irqoff_test(void)
>  {
>  	unsigned long flags;
> +	local_irq_save(flags);
> +	busy_wait(delay);
> +	local_irq_restore(flags);
> +}
> +
> +static __always_inline void preemptoff_test(void)
> +{
> +	preempt_disable();
> +	busy_wait(delay);
> +	preempt_enable();
> +}
>  
> -	if (!strcmp(test_mode, "irq")) {
> -		local_irq_save(flags);
> -		busy_wait(delay);
> -		local_irq_restore(flags);
> -	} else if (!strcmp(test_mode, "preempt")) {
> -		preempt_disable();
> -		busy_wait(delay);
> -		preempt_enable();
> +static void execute_preemptirqtest(int idx)
> +{
> +	if (!strcmp(test_mode, "irq"))
> +		irqoff_test();
> +	else if (!strcmp(test_mode, "preempt"))
> +		preemptoff_test();
> +	else if (!strcmp(test_mode, "alternate")) {
> +		if (idx % 2 == 0)
> +			irqoff_test();
> +		else
> +			preemptoff_test();
>  	}
> +}
> +
> +#define DECLARE_TESTFN(POSTFIX)				\
> +	static void preemptirqtest_##POSTFIX(int idx)	\
> +	{						\
> +		execute_preemptirqtest(idx);		\
> +	}						\
> +
> +DECLARE_TESTFN(0)
> +DECLARE_TESTFN(1)
> +DECLARE_TESTFN(2)
> +DECLARE_TESTFN(3)
> +DECLARE_TESTFN(4)
> +DECLARE_TESTFN(5)
> +DECLARE_TESTFN(6)
> +DECLARE_TESTFN(7)
> +DECLARE_TESTFN(8)
> +DECLARE_TESTFN(9)

You really only need 2 functions here, since the odd and even suffixed
functions are identical.

> +static void (*testfuncs[])(int)  = {
> +	preemptirqtest_0,
> +	preemptirqtest_1,
> +	preemptirqtest_2,
> +	preemptirqtest_3,
> +	preemptirqtest_4,
> +	preemptirqtest_5,
> +	preemptirqtest_6,
> +	preemptirqtest_7,
> +	preemptirqtest_8,
> +	preemptirqtest_9,
> +};

And then just have an array of 2 functions. Or nuke the array.

> +#define NR_TEST_FUNCS ARRAY_SIZE(testfuncs)
> +
> +static int preemptirq_delay_run(void *data)
> +{
> +
> +	int i;
> +
> +	for (i = 0; i < burst_size; i++)
> +		(testfuncs[i % NR_TEST_FUNCS])(i);
>  	return 0;
>  }
>  
> -static int __init preemptirq_delay_init(void)
> +static struct task_struct *preemptirq_start_test(void)
>  {
>  	char task_name[50];
> -	struct task_struct *test_task;
>  
>  	snprintf(task_name, sizeof(task_name), "%s_test", test_mode);
> +	return kthread_run(preemptirq_delay_run, NULL, task_name);
> +}
> +
> +
> +static ssize_t trigger_store(struct kobject *kobj, struct kobj_attribute *attr,
> +			 const char *buf, size_t count)
> +{
> +	preemptirq_start_test();
> +	return count;
> +}

I honestly feel a sysfs trigger file is pointless. Why can't the module be
reloaded? Note also that module parameters can be changed after the module
has been loaded. Perhaps that can be used as a trigger? So if the test_mode
is changed, then the test is re-run.

However, if Steve prefers the sysfs trigger file, then I am Ok with that.

thanks,

 - Joel

