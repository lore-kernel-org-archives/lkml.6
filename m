Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E5A9C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 10:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1131A2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 10:28:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1131A2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbeHVNwy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 09:52:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59478 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726849AbeHVNwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 09:52:54 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7MAODKD077720
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 06:28:35 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m14y9jjme-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 06:28:34 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Wed, 22 Aug 2018 11:28:33 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 22 Aug 2018 11:28:29 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7MASSYk32964834
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 22 Aug 2018 10:28:28 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4F3A452052;
        Wed, 22 Aug 2018 13:28:28 +0100 (BST)
Received: from [9.195.41.244] (unknown [9.195.41.244])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id EB2EA52050;
        Wed, 22 Aug 2018 13:28:24 +0100 (BST)
Subject: Re: [PATCH] trace_uprobe: support reference count in fd-based uprobe
To:     Song Liu <songliubraving@fb.com>, linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com, Masami Hiramatsu <mhiramat@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Teng Qin <qinteng@fb.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20180821222307.1071060-1-songliubraving@fb.com>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date:   Wed, 22 Aug 2018 15:58:20 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180821222307.1071060-1-songliubraving@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18082210-4275-0000-0000-000002AD92E9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082210-4276-0000-0000-000037B69786
Message-Id: <aa068d01-c776-894f-0a7e-b81da1f624c2@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-22_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808220106
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/22/2018 03:53 AM, Song Liu wrote:
> This patch applies on top of Ravi Bangoria's work that enables reference
> count for uprobe:
> 
>   https://lkml.org/lkml/2018/8/20/37
> 
> After Ravi's work, the effort to enable it in fd-based uprobe is straight
> forward. Highest 40 bits of perf_event_attr.config is used to stored offset
> of the reference count (semaphore).
> 
> Format information in /sys/bus/event_source/devices/uprobe/format/ is
> updated to reflect this new feature.

LGTM

Reviewed-and-tested-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>


> 
> Signed-off-by: Song Liu <songliubraving@fb.com>
> Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Teng Qin <qinteng@fb.com>
> ---
>  include/linux/trace_events.h    |  3 +-
>  kernel/events/core.c            | 49 ++++++++++++++++++++++++++-------
>  kernel/trace/trace_event_perf.c |  7 +++--
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
> index 8f0434a9951a..75a0219be420 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -8363,30 +8363,39 @@ static struct pmu perf_tracepoint = {
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
> @@ -8396,7 +8405,7 @@ static struct pmu perf_kprobe = {
>  	.start		= perf_swevent_start,
>  	.stop		= perf_swevent_stop,
>  	.read		= perf_swevent_read,
> -	.attr_groups	= probe_attr_groups,
> +	.attr_groups	= kprobe_attr_groups,
>  };
>  
>  static int perf_kprobe_event_init(struct perf_event *event)
> @@ -8428,6 +8437,24 @@ static int perf_kprobe_event_init(struct perf_event *event)
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
> @@ -8437,12 +8464,13 @@ static struct pmu perf_uprobe = {
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
> @@ -8458,7 +8486,8 @@ static int perf_uprobe_event_init(struct perf_event *event)
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
> 

