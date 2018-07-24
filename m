Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94063ECDE5F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 02:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C67F20874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 02:25:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C67F20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388352AbeGXD3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 23:29:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:56640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388194AbeGXD3o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 23:29:44 -0400
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA6A420874;
        Tue, 24 Jul 2018 02:25:36 +0000 (UTC)
Date:   Mon, 23 Jul 2018 22:25:34 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Hiraku Toyooka <hiraku.toyooka@cybertrust.co.jp>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/3] [BUGFIX] ring_buffer: tracing: Inherit the tracing
 setting to next ring buffer
Message-ID: <20180723222534.368ea01b@vmware.local.home>
In-Reply-To: <153149929558.11274.11730609978254724394.stgit@devbox>
References: <153149923649.11274.14970833360963898112.stgit@devbox>
        <153149929558.11274.11730609978254724394.stgit@devbox>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Jul 2018 01:28:15 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Inherit the tracing on/off setting on ring_buffer to next
> trace buffer when taking a snapshot.
> 
> Taking a snapshot is done by swapping with backup ring buffer
> (max_tr_buffer). But since the tracing on/off setting is set
> in the ring buffer, when swapping it, tracing on/off setting
> can also be changed. This causes a strange result like below;
> 
>   /sys/kernel/debug/tracing # cat tracing_on
>   1
>   /sys/kernel/debug/tracing # echo 0 > tracing_on
>   /sys/kernel/debug/tracing # echo 1 > snapshot
>   /sys/kernel/debug/tracing # cat tracing_on
>   1
>   /sys/kernel/debug/tracing # echo 1 > snapshot
>   /sys/kernel/debug/tracing # cat tracing_on
>   0
> 
> We don't touch tracing_on, but snapshot changes tracing_on
> setting each time. This must be a bug, because user never know
> that each "ring_buffer" stores tracing-enable state and
> snapshot is done by swapping ring buffers.
> 
> This patch fixes above strange behavior.
> 


OK, so the issue is that the tracing_on state is saved with the buffer
itself. And when we swap the buffer, we also swap the state.


> Fixes: commit debdd57f5145 ("tracing: Make a snapshot feature available from userspace")
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Hiraku Toyooka <hiraku.toyooka@cybertrust.co.jp>
> Cc: stable@vger.kernel.org
> ---
>  include/linux/ring_buffer.h |    1 +
>  kernel/trace/ring_buffer.c  |   12 ++++++++++++
>  kernel/trace/trace.c        |    6 ++++++
>  3 files changed, 19 insertions(+)
> 
> diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
> index b72ebdff0b77..003d09ab308d 100644
> --- a/include/linux/ring_buffer.h
> +++ b/include/linux/ring_buffer.h
> @@ -165,6 +165,7 @@ void ring_buffer_record_enable(struct ring_buffer *buffer);
>  void ring_buffer_record_off(struct ring_buffer *buffer);
>  void ring_buffer_record_on(struct ring_buffer *buffer);
>  int ring_buffer_record_is_on(struct ring_buffer *buffer);
> +int ring_buffer_record_is_set_on(struct ring_buffer *buffer);
>  void ring_buffer_record_disable_cpu(struct ring_buffer *buffer, int cpu);
>  void ring_buffer_record_enable_cpu(struct ring_buffer *buffer, int cpu);
>  
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 6a46af21765c..4038ed74ab95 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -3227,6 +3227,18 @@ int ring_buffer_record_is_on(struct ring_buffer *buffer)
>  }
>  
>  /**
> + * ring_buffer_record_is_set_on - return true if the ring buffer is set writable
> + * @buffer: The ring buffer to see if write is set enabled
> + *
> + * Returns true if the ring buffer is set writable by ring_buffer_record_on().
> + * Note that this does NOT mean it is in a writable state.

I'd add a little more context here. Something like:

  * It may return true when the ring buffer has been disabled by
  * ring_buffer_record_disable(), as that is a temporary disabling of
  * the ring buffer.

-- Steve

> + */
> +int ring_buffer_record_is_set_on(struct ring_buffer *buffer)
> +{
> +	return !(atomic_read(&buffer->record_disabled) & RB_BUFFER_OFF);
> +}
> +
> +/**
>   * ring_buffer_record_disable_cpu - stop all writes into the cpu_buffer
>   * @buffer: The ring buffer to stop writes to.
>   * @cpu: The CPU buffer to stop
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 2556d8c097d2..bbd5a94a7ef1 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -1378,6 +1378,12 @@ update_max_tr(struct trace_array *tr, struct task_struct *tsk, int cpu)
>  
>  	arch_spin_lock(&tr->max_lock);
>  
> +	/* Inherit the recordable setting from trace_buffer */
> +	if (ring_buffer_record_is_set_on(tr->trace_buffer.buffer))
> +		ring_buffer_record_on(tr->max_buffer.buffer);
> +	else
> +		ring_buffer_record_off(tr->max_buffer.buffer);
> +
>  	swap(tr->trace_buffer.buffer, tr->max_buffer.buffer);
>  
>  	__update_max_tr(tr, tsk, cpu);

