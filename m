Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91809C4646D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 02:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3268121A6D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 02:00:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3268121A6D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbeHGEMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 00:12:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:51830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726908AbeHGEMi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 00:12:38 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E01A21A70;
        Tue,  7 Aug 2018 02:00:42 +0000 (UTC)
Date:   Mon, 6 Aug 2018 22:00:40 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] tracing: Partial revert of "tracing: Centralize
 preemptirq tracepoints and unify their usage"
Message-ID: <20180806220040.68ab0771@gandalf.local.home>
In-Reply-To: <20180806215432.45ae5f9a@gandalf.local.home>
References: <20180806215432.45ae5f9a@gandalf.local.home>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Aug 2018 21:54:32 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> --- a/kernel/trace/trace_preemptirq.c
> +++ b/kernel/trace/trace_preemptirq.c
> @@ -20,40 +20,52 @@ static DEFINE_PER_CPU(int, tracing_irq_cpu);
>  void trace_hardirqs_on(void)
>  {
>  	if (!this_cpu_read(tracing_irq_cpu))
> -		return;
> +		goto out;
>  
>  	trace_irq_enable_rcuidle(CALLER_ADDR0, CALLER_ADDR1);
>  	this_cpu_write(tracing_irq_cpu, 0);
> +
> + out:
> +	lockdep_hardirqs_on(CALLER_ADDR0);
>  }
>  EXPORT_SYMBOL(trace_hardirqs_on);
>  
>  void trace_hardirqs_off(void)
>  {
>  	if (this_cpu_read(tracing_irq_cpu))
> -		return;
> +		goto out;
>  
>  	this_cpu_write(tracing_irq_cpu, 1);
>  	trace_irq_disable_rcuidle(CALLER_ADDR0, CALLER_ADDR1);
> +
> + out:
> +	lockdep_hardirqs_off(CALLER_ADDR0);
>  }
>  EXPORT_SYMBOL(trace_hardirqs_off);
>  
>  __visible void trace_hardirqs_on_caller(unsigned long caller_addr)
>  {
>  	if (!this_cpu_read(tracing_irq_cpu))
> -		return;
> +		goto out;
>  
>  	trace_irq_enable_rcuidle(CALLER_ADDR0, caller_addr);
>  	this_cpu_write(tracing_irq_cpu, 0);
> +
> + out:
> +	lockdep_hardirqs_on(CALLER_ADDR0);
>  }
>  EXPORT_SYMBOL(trace_hardirqs_on_caller);
>  
>  __visible void trace_hardirqs_off_caller(unsigned long caller_addr)
>  {
>  	if (this_cpu_read(tracing_irq_cpu))
> -		return;
> +		goto out;
>  
>  	this_cpu_write(tracing_irq_cpu, 1);
>  	trace_irq_disable_rcuidle(CALLER_ADDR0, caller_addr);
> +
> + out:
> +	lockdep_hardirqs_off(CALLER_ADDR0);
>  }
>  EXPORT_SYMBOL(trace_hardirqs_off_caller);
>  #endif /* CONFIG_TRACE_IRQFLAGS */

Hmm, the gotos above are rather ugly. This look better?

-- Steve


diff --git a/kernel/trace/trace_preemptirq.c b/kernel/trace/trace_preemptirq.c
index e76b78bf258e..fa656b25f427 100644
--- a/kernel/trace/trace_preemptirq.c
+++ b/kernel/trace/trace_preemptirq.c
@@ -19,41 +19,45 @@ static DEFINE_PER_CPU(int, tracing_irq_cpu);
 
 void trace_hardirqs_on(void)
 {
-	if (!this_cpu_read(tracing_irq_cpu))
-		return;
+	if (this_cpu_read(tracing_irq_cpu)) {
+		trace_irq_enable_rcuidle(CALLER_ADDR0, CALLER_ADDR1);
+		this_cpu_write(tracing_irq_cpu, 0);
+	}
 
-	trace_irq_enable_rcuidle(CALLER_ADDR0, CALLER_ADDR1);
-	this_cpu_write(tracing_irq_cpu, 0);
+	lockdep_hardirqs_on(CALLER_ADDR0);
 }
 EXPORT_SYMBOL(trace_hardirqs_on);
 
 void trace_hardirqs_off(void)
 {
-	if (this_cpu_read(tracing_irq_cpu))
-		return;
+	if (!this_cpu_read(tracing_irq_cpu)) {
+		this_cpu_write(tracing_irq_cpu, 1);
+		trace_irq_disable_rcuidle(CALLER_ADDR0, CALLER_ADDR1);
+	}
 
-	this_cpu_write(tracing_irq_cpu, 1);
-	trace_irq_disable_rcuidle(CALLER_ADDR0, CALLER_ADDR1);
+	lockdep_hardirqs_off(CALLER_ADDR0);
 }
 EXPORT_SYMBOL(trace_hardirqs_off);
 
 __visible void trace_hardirqs_on_caller(unsigned long caller_addr)
 {
-	if (!this_cpu_read(tracing_irq_cpu))
-		return;
+	if (this_cpu_read(tracing_irq_cpu)) {
+		trace_irq_enable_rcuidle(CALLER_ADDR0, caller_addr);
+		this_cpu_write(tracing_irq_cpu, 0);
+	}
 
-	trace_irq_enable_rcuidle(CALLER_ADDR0, caller_addr);
-	this_cpu_write(tracing_irq_cpu, 0);
+	lockdep_hardirqs_on(CALLER_ADDR0);
 }
 EXPORT_SYMBOL(trace_hardirqs_on_caller);
 
 __visible void trace_hardirqs_off_caller(unsigned long caller_addr)
 {
-	if (this_cpu_read(tracing_irq_cpu))
-		return;
+	if (!this_cpu_read(tracing_irq_cpu)) {
+		this_cpu_write(tracing_irq_cpu, 1);
+		trace_irq_disable_rcuidle(CALLER_ADDR0, caller_addr);
+	}
 
-	this_cpu_write(tracing_irq_cpu, 1);
-	trace_irq_disable_rcuidle(CALLER_ADDR0, caller_addr);
+	lockdep_hardirqs_off(CALLER_ADDR0);
 }
 EXPORT_SYMBOL(trace_hardirqs_off_caller);
 #endif /* CONFIG_TRACE_IRQFLAGS */
