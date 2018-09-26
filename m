Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC3F5C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FFBF2152C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:06:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FFBF2152C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbeIZWUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 18:20:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:53734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727067AbeIZWUJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 18:20:09 -0400
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48B072151C;
        Wed, 26 Sep 2018 16:06:29 +0000 (UTC)
Date:   Wed, 26 Sep 2018 12:06:23 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Song Liu <songliubraving@fb.com>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, Masami Hiramatsu <mhiramat@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH RESEND] trace_uprobe: support reference counter in
 fd-based uprobe
Message-ID: <20180926120623.7cbf2003@vmware.local.home>
In-Reply-To: <20180924211236.4149482-1-songliubraving@fb.com>
References: <20180924211236.4149482-1-songliubraving@fb.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Sep 2018 14:12:36 -0700
Song Liu <songliubraving@fb.com> wrote:

> This patch enables uprobes with reference counter in fd-based uprobe.
> Highest 40 bits of perf_event_attr.config is used to stored offset
> of the reference counter (semaphore).
> 
> Format information in /sys/bus/event_source/devices/uprobe/format/ is
> updated to reflect this new feature.
> 
> Signed-off-by: Song Liu <songliubraving@fb.com>
> Reviewed-and-tested-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  include/linux/trace_events.h    |  3 +-
>  kernel/events/core.c            | 49 ++++++++++++++++++++++++++-------
>  kernel/trace/trace_event_perf.c |  7 +++--

Peter,

This is based off of some uprobe code in my tree (which I just finished
testing and need to push to linux-next). But can you give an ack to the
perf parts?

Thanks!

-- Steve


>  kernel/trace/trace_probe.h      |  3 +-
>  kernel/trace/trace_uprobe.c     |  4 ++-
>  5 files changed, 50 insertions(+), 16 deletions(-)
> 
> diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> index 78a010e19ed4..4130a5497d40 100644
> --- a/include/linux/trace_events.h
> +++ b/include/linux/trace_events.h
> @@ -575,7 +575,8 @@ extern int bpf_get_kprobe_info(const struct perf_event *event,
>  			       bool perf_type_tracepoint);
>  #endif
>  #ifdef CONFIG_UPROBE_EVENTS
> -extern int  perf_uprobe_init(struct perf_event *event, bool is_retprobe);
> +extern int  perf_uprobe_init(struct perf_event *event,
> +			     unsigned long ref_ctr_offset, bool is_retprobe);
>  extern void perf_uprobe_destroy(struct perf_event *event);
>  extern int bpf_get_uprobe_info(const struct perf_event *event,
>  			       u32 *fd_type, const char **filename,
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index c80549bf82c6..a4ad5235ec9b 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -8368,30 +8368,39 @@ static struct pmu perf_tracepoint = {
>   *
>   * PERF_PROBE_CONFIG_IS_RETPROBE if set, create kretprobe/uretprobe
>   *                               if not set, create kprobe/uprobe
> + *
> + * The following values specify a reference counter (or semaphore in the
> + * terminology of tools like dtrace, systemtap, etc.) Userspace Statically
> + * Defined Tracepoints (USDT). Currently, we use 40 bit for the offset.
> + *
> + * PERF_UPROBE_REF_CTR_OFFSET_BITS	# of bits in config as th offset
> + * PERF_UPROBE_REF_CTR_OFFSET_SHIFT	# of bits to shift left
>   */
>  enum perf_probe_config {
>  	PERF_PROBE_CONFIG_IS_RETPROBE = 1U << 0,  /* [k,u]retprobe */
> +	PERF_UPROBE_REF_CTR_OFFSET_BITS = 40,
> +	PERF_UPROBE_REF_CTR_OFFSET_SHIFT = 64 - PERF_UPROBE_REF_CTR_OFFSET_BITS,
>  };
> 
>  PMU_FORMAT_ATTR(retprobe, "config:0");
> +#endif
> 
> -static struct attribute *probe_attrs[] = {
> +#ifdef CONFIG_KPROBE_EVENTS
> +static struct attribute *kprobe_attrs[] = {
>  	&format_attr_retprobe.attr,
>  	NULL,
>  };
> 
> -static struct attribute_group probe_format_group = {
> +static struct attribute_group kprobe_format_group = {
>  	.name = "format",
> -	.attrs = probe_attrs,
> +	.attrs = kprobe_attrs,
>  };
> 
> -static const struct attribute_group *probe_attr_groups[] = {
> -	&probe_format_group,
> +static const struct attribute_group *kprobe_attr_groups[] = {
> +	&kprobe_format_group,
>  	NULL,
>  };
> -#endif
> 
> -#ifdef CONFIG_KPROBE_EVENTS
>  static int perf_kprobe_event_init(struct perf_event *event);
>  static struct pmu perf_kprobe = {
>  	.task_ctx_nr	= perf_sw_context,
> @@ -8401,7 +8410,7 @@ static struct pmu perf_kprobe = {
>  	.start		= perf_swevent_start,
>  	.stop		= perf_swevent_stop,
>  	.read		= perf_swevent_read,
> -	.attr_groups	= probe_attr_groups,
> +	.attr_groups	= kprobe_attr_groups,
>  };
> 
>  static int perf_kprobe_event_init(struct perf_event *event)
> @@ -8433,6 +8442,24 @@ static int perf_kprobe_event_init(struct perf_event *event)
>  #endif /* CONFIG_KPROBE_EVENTS */
> 
>  #ifdef CONFIG_UPROBE_EVENTS
> +PMU_FORMAT_ATTR(ref_ctr_offset, "config:63-24");
> +
> +static struct attribute *uprobe_attrs[] = {
> +	&format_attr_retprobe.attr,
> +	&format_attr_ref_ctr_offset.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group uprobe_format_group = {
> +	.name = "format",
> +	.attrs = uprobe_attrs,
> +};
> +
> +static const struct attribute_group *uprobe_attr_groups[] = {
> +	&uprobe_format_group,
> +	NULL,
> +};
> +
>  static int perf_uprobe_event_init(struct perf_event *event);
>  static struct pmu perf_uprobe = {
>  	.task_ctx_nr	= perf_sw_context,
> @@ -8442,12 +8469,13 @@ static struct pmu perf_uprobe = {
>  	.start		= perf_swevent_start,
>  	.stop		= perf_swevent_stop,
>  	.read		= perf_swevent_read,
> -	.attr_groups	= probe_attr_groups,
> +	.attr_groups	= uprobe_attr_groups,
>  };
> 
>  static int perf_uprobe_event_init(struct perf_event *event)
>  {
>  	int err;
> +	unsigned long ref_ctr_offset;
>  	bool is_retprobe;
> 
>  	if (event->attr.type != perf_uprobe.type)
> @@ -8463,7 +8491,8 @@ static int perf_uprobe_event_init(struct perf_event *event)
>  		return -EOPNOTSUPP;
> 
>  	is_retprobe = event->attr.config & PERF_PROBE_CONFIG_IS_RETPROBE;
> -	err = perf_uprobe_init(event, is_retprobe);
> +	ref_ctr_offset = event->attr.config >> PERF_UPROBE_REF_CTR_OFFSET_SHIFT;
> +	err = perf_uprobe_init(event, ref_ctr_offset, is_retprobe);
>  	if (err)
>  		return err;
> 
> diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_perf.c
> index 69a3fe926e8c..76217bbef815 100644
> --- a/kernel/trace/trace_event_perf.c
> +++ b/kernel/trace/trace_event_perf.c
> @@ -290,7 +290,8 @@ void perf_kprobe_destroy(struct perf_event *p_event)
>  #endif /* CONFIG_KPROBE_EVENTS */
> 
>  #ifdef CONFIG_UPROBE_EVENTS
> -int perf_uprobe_init(struct perf_event *p_event, bool is_retprobe)
> +int perf_uprobe_init(struct perf_event *p_event,
> +		     unsigned long ref_ctr_offset, bool is_retprobe)
>  {
>  	int ret;
>  	char *path = NULL;
> @@ -312,8 +313,8 @@ int perf_uprobe_init(struct perf_event *p_event, bool is_retprobe)
>  		goto out;
>  	}
> 
> -	tp_event = create_local_trace_uprobe(
> -		path, p_event->attr.probe_offset, is_retprobe);
> +	tp_event = create_local_trace_uprobe(path, p_event->attr.probe_offset,
> +					     ref_ctr_offset, is_retprobe);
>  	if (IS_ERR(tp_event)) {
>  		ret = PTR_ERR(tp_event);
>  		goto out;
> diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
> index 5f52668e165d..03b10f3201a5 100644
> --- a/kernel/trace/trace_probe.h
> +++ b/kernel/trace/trace_probe.h
> @@ -412,6 +412,7 @@ create_local_trace_kprobe(char *func, void *addr, unsigned long offs,
>  extern void destroy_local_trace_kprobe(struct trace_event_call *event_call);
> 
>  extern struct trace_event_call *
> -create_local_trace_uprobe(char *name, unsigned long offs, bool is_return);
> +create_local_trace_uprobe(char *name, unsigned long offs,
> +			  unsigned long ref_ctr_offset, bool is_return);
>  extern void destroy_local_trace_uprobe(struct trace_event_call *event_call);
>  #endif
> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> index 3a7c73c40007..d09638706fe0 100644
> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
> @@ -1405,7 +1405,8 @@ static int unregister_uprobe_event(struct trace_uprobe *tu)
> 
>  #ifdef CONFIG_PERF_EVENTS
>  struct trace_event_call *
> -create_local_trace_uprobe(char *name, unsigned long offs, bool is_return)
> +create_local_trace_uprobe(char *name, unsigned long offs,
> +			  unsigned long ref_ctr_offset, bool is_return)
>  {
>  	struct trace_uprobe *tu;
>  	struct path path;
> @@ -1437,6 +1438,7 @@ create_local_trace_uprobe(char *name, unsigned long offs, bool is_return)
> 
>  	tu->offset = offs;
>  	tu->path = path;
> +	tu->ref_ctr_offset = ref_ctr_offset;
>  	tu->filename = kstrdup(name, GFP_KERNEL);
>  	init_trace_event_call(tu, &tu->tp.call);
> 
> --
> 2.17.1

