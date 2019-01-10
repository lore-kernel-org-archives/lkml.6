Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F8C4C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E0B0208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547146530;
	bh=dujX2oB3nNV9MMnH+dUcS3thxJASmL+IFJqzqfjKPuM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=r6xHHXi2RLGWHQIi2LMcffXQHLo+cUjD9JkOwN0Nn7zh4BB2HjObm/vlU8Aj1wmF4
	 cb6Rdb4ecz5nQXEQHHNWJ+Te7XXtDTyKA01DkA/24DOmtp0J4JeQ8//AujraLP23Ec
	 OpiFR/APsYyuNydBfUBDGF6kPXIouiyxXTx6gxNM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729183AbfAJSz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 13:55:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:54634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727000AbfAJSz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 13:55:28 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30C54206B7;
        Thu, 10 Jan 2019 18:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547146527;
        bh=dujX2oB3nNV9MMnH+dUcS3thxJASmL+IFJqzqfjKPuM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KdkAQPcrIYGVomGC1wY0T0SX784Hxtl2kExGxp6h6cqcZNx7eWl0kQoLZCTb5cINJ
         Prc1fpXpINpo7TD3491P9ohXq+DtRIiav2AGzSTmfptD/yZDPBoisJUi2FTqPatjQP
         z/ZNlUWkuxlRj1YFc5Q3ru1SFiHe2q8a38jexzH4=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8AD6541AB5; Thu, 10 Jan 2019 15:55:24 -0300 (-03)
Date:   Thu, 10 Jan 2019 15:55:24 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v6 perf, bpf-next 1/7] perf, bpf: Introduce
 PERF_RECORD_KSYMBOL
Message-ID: <20190110185524.GO22483@kernel.org>
References: <20190109192111.130995-1-songliubraving@fb.com>
 <20190109192111.130995-2-songliubraving@fb.com>
 <20190110182403.GN22483@kernel.org>
 <064FBBA4-A0D0-4335-BCE7-902724CE2988@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <064FBBA4-A0D0-4335-BCE7-902724CE2988@fb.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jan 10, 2019 at 06:40:37PM +0000, Song Liu escreveu:
> 
> 
> > On Jan 10, 2019, at 10:24 AM, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > 
> > Em Wed, Jan 09, 2019 at 11:21:05AM -0800, Song Liu escreveu:
> >> For better performance analysis of dynamically JITed and loaded kernel
> >> functions, such as BPF programs, this patch introduces
> >> PERF_RECORD_KSYMBOL, a new perf_event_type that exposes kernel symbol
> >> register/unregister information to user space.
> >> 
> >> The following data structure is used for PERF_RECORD_KSYMBOL.
> >> 
> >>    /*
> >>     * struct {
> >>     *      struct perf_event_header        header;
> >>     *      u64                             addr;
> >>     *      u32                             len;
> >>     *      u16                             ksym_type;
> >>     *      u16                             flags;
> >>     *      char                            name[];
> >>     *      struct sample_id                sample_id;
> >>     * };
> >>     */
> > 
> > So, I couldn't find where this gets used, the intention here is just to
> > add the interfaces and afterwards is that you will wire this up? I would
> > like to test the whole shebang to see it working.
> 
> I guess you meant PERF_RECORD_BPF_EVENT not being used? 
> 
> PERF_RECORD_KSYMBOL is used by BPF in 3/7 and 5/7. I tested 

Oops, I didn't look at 3/7, just read its cset summary line and as it
says:

Subject: [PATCH v6 perf, bpf-next 3/7] perf, bpf: introduce PERF_RECORD_BPF_EVENT

I didn't thought it was related, perhaps break it down into one that
states that it is wiring up PERF_RECORD_KSYMBOL, and at that point we
could just test it, getting the notifications for new kallsyms related
to BPF?

> PERF_RECORD_BPF_EVENT with dump_trace. As we separate RECORD_KSYMBOL from
> RECORD_BPF_EVENT, user space won't use BPF_EVENT until annotation support.  

Right, so why not just introduce PERF_RECORD_KSYMBOL, make it be used by
tooling, etc, then move on to PERF_RECORD_BPF_EVENT?

- Arnaldo
 
> Thanks,
> Song
> 
> >> Signed-off-by: Song Liu <songliubraving@fb.com>
> >> ---
> >> include/linux/perf_event.h      | 13 +++++
> >> include/uapi/linux/perf_event.h | 26 ++++++++-
> >> kernel/events/core.c            | 98 ++++++++++++++++++++++++++++++++-
> >> 3 files changed, 135 insertions(+), 2 deletions(-)
> >> 
> >> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> >> index 1d5c551a5add..6b5f08db5ef3 100644
> >> --- a/include/linux/perf_event.h
> >> +++ b/include/linux/perf_event.h
> >> @@ -1113,6 +1113,13 @@ static inline void perf_event_task_sched_out(struct task_struct *prev,
> >> }
> >> 
> >> extern void perf_event_mmap(struct vm_area_struct *vma);
> >> +
> >> +/* callback function to generate ksymbol name */
> >> +typedef int (perf_ksymbol_get_name_f)(char *name, int name_len, void *data);
> >> +extern void perf_event_ksymbol(u16 ksym_type, u64 addr, u32 len,
> >> +			       bool unregister,
> >> +			       perf_ksymbol_get_name_f get_name, void *data);
> >> +
> >> extern struct perf_guest_info_callbacks *perf_guest_cbs;
> >> extern int perf_register_guest_info_callbacks(struct perf_guest_info_callbacks *callbacks);
> >> extern int perf_unregister_guest_info_callbacks(struct perf_guest_info_callbacks *callbacks);
> >> @@ -1333,6 +1340,12 @@ static inline int perf_unregister_guest_info_callbacks
> >> (struct perf_guest_info_callbacks *callbacks)				{ return 0; }
> >> 
> >> static inline void perf_event_mmap(struct vm_area_struct *vma)		{ }
> >> +
> >> +typedef int (perf_ksymbol_get_name_f)(char *name, int name_len, void *data);
> >> +static inline void perf_event_ksymbol(u16 ksym_type, u64 addr, u32 len,
> >> +				      bool unregister,
> >> +				      perf_ksymbol_get_name_f get_name,
> >> +				      void *data) 			{ }
> >> static inline void perf_event_exec(void)				{ }
> >> static inline void perf_event_comm(struct task_struct *tsk, bool exec)	{ }
> >> static inline void perf_event_namespaces(struct task_struct *tsk)	{ }
> >> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> >> index 9de8780ac8d9..68c4da0227c5 100644
> >> --- a/include/uapi/linux/perf_event.h
> >> +++ b/include/uapi/linux/perf_event.h
> >> @@ -372,7 +372,8 @@ struct perf_event_attr {
> >> 				context_switch :  1, /* context switch data */
> >> 				write_backward :  1, /* Write ring buffer from end to beginning */
> >> 				namespaces     :  1, /* include namespaces data */
> >> -				__reserved_1   : 35;
> >> +				ksymbol        :  1, /* include ksymbol events */
> >> +				__reserved_1   : 34;
> >> 
> >> 	union {
> >> 		__u32		wakeup_events;	  /* wakeup every n events */
> >> @@ -965,9 +966,32 @@ enum perf_event_type {
> >> 	 */
> >> 	PERF_RECORD_NAMESPACES			= 16,
> >> 
> >> +	/*
> >> +	 * Record ksymbol register/unregister events:
> >> +	 *
> >> +	 * struct {
> >> +	 *	struct perf_event_header	header;
> >> +	 *	u64				addr;
> >> +	 *	u32				len;
> >> +	 *	u16				ksym_type;
> >> +	 *	u16				flags;
> >> +	 *	char				name[];
> >> +	 *	struct sample_id		sample_id;
> >> +	 * };
> >> +	 */
> >> +	PERF_RECORD_KSYMBOL			= 17,
> >> +
> >> 	PERF_RECORD_MAX,			/* non-ABI */
> >> };
> >> 
> >> +enum perf_record_ksymbol_type {
> >> +	PERF_RECORD_KSYMBOL_TYPE_UNKNOWN	= 0,
> >> +	PERF_RECORD_KSYMBOL_TYPE_BPF		= 1,
> >> +	PERF_RECORD_KSYMBOL_TYPE_MAX		/* non-ABI */
> >> +};
> >> +
> >> +#define PERF_RECORD_KSYMBOL_FLAGS_UNREGISTER	(1 << 0)
> >> +
> >> #define PERF_MAX_STACK_DEPTH		127
> >> #define PERF_MAX_CONTEXTS_PER_STACK	  8
> >> 
> >> diff --git a/kernel/events/core.c b/kernel/events/core.c
> >> index 3cd13a30f732..ef27f2776999 100644
> >> --- a/kernel/events/core.c
> >> +++ b/kernel/events/core.c
> >> @@ -385,6 +385,7 @@ static atomic_t nr_namespaces_events __read_mostly;
> >> static atomic_t nr_task_events __read_mostly;
> >> static atomic_t nr_freq_events __read_mostly;
> >> static atomic_t nr_switch_events __read_mostly;
> >> +static atomic_t nr_ksymbol_events __read_mostly;
> >> 
> >> static LIST_HEAD(pmus);
> >> static DEFINE_MUTEX(pmus_lock);
> >> @@ -4235,7 +4236,7 @@ static bool is_sb_event(struct perf_event *event)
> >> 
> >> 	if (attr->mmap || attr->mmap_data || attr->mmap2 ||
> >> 	    attr->comm || attr->comm_exec ||
> >> -	    attr->task ||
> >> +	    attr->task || attr->ksymbol ||
> >> 	    attr->context_switch)
> >> 		return true;
> >> 	return false;
> >> @@ -4305,6 +4306,8 @@ static void unaccount_event(struct perf_event *event)
> >> 		dec = true;
> >> 	if (has_branch_stack(event))
> >> 		dec = true;
> >> +	if (event->attr.ksymbol)
> >> +		atomic_dec(&nr_ksymbol_events);
> >> 
> >> 	if (dec) {
> >> 		if (!atomic_add_unless(&perf_sched_count, -1, 1))
> >> @@ -7650,6 +7653,97 @@ static void perf_log_throttle(struct perf_event *event, int enable)
> >> 	perf_output_end(&handle);
> >> }
> >> 
> >> +/*
> >> + * ksymbol register/unregister tracking
> >> + */
> >> +
> >> +struct perf_ksymbol_event {
> >> +	const char	*name;
> >> +	int		name_len;
> >> +	struct {
> >> +		struct perf_event_header        header;
> >> +		u64				addr;
> >> +		u32				len;
> >> +		u16				ksym_type;
> >> +		u16				flags;
> >> +	} event_id;
> >> +};
> >> +
> >> +static int perf_event_ksymbol_match(struct perf_event *event)
> >> +{
> >> +	return event->attr.ksymbol;
> >> +}
> >> +
> >> +static void perf_event_ksymbol_output(struct perf_event *event, void *data)
> >> +{
> >> +	struct perf_ksymbol_event *ksymbol_event = data;
> >> +	struct perf_output_handle handle;
> >> +	struct perf_sample_data sample;
> >> +	int ret;
> >> +
> >> +	if (!perf_event_ksymbol_match(event))
> >> +		return;
> >> +
> >> +	perf_event_header__init_id(&ksymbol_event->event_id.header,
> >> +				   &sample, event);
> >> +	ret = perf_output_begin(&handle, event,
> >> +				ksymbol_event->event_id.header.size);
> >> +	if (ret)
> >> +		return;
> >> +
> >> +	perf_output_put(&handle, ksymbol_event->event_id);
> >> +	__output_copy(&handle, ksymbol_event->name, ksymbol_event->name_len);
> >> +	perf_event__output_id_sample(event, &handle, &sample);
> >> +
> >> +	perf_output_end(&handle);
> >> +}
> >> +
> >> +void perf_event_ksymbol(u16 ksym_type, u64 addr, u32 len, bool unregister,
> >> +			perf_ksymbol_get_name_f get_name, void *data)
> >> +{
> >> +	struct perf_ksymbol_event ksymbol_event;
> >> +	char name[KSYM_NAME_LEN];
> >> +	u16 flags = 0;
> >> +	int name_len;
> >> +
> >> +	if (!atomic_read(&nr_ksymbol_events))
> >> +		return;
> >> +
> >> +	if (ksym_type >= PERF_RECORD_KSYMBOL_TYPE_MAX ||
> >> +	    ksym_type == PERF_RECORD_KSYMBOL_TYPE_UNKNOWN)
> >> +		goto err;
> >> +
> >> +	get_name(name, KSYM_NAME_LEN, data);
> >> +	name_len = strlen(name) + 1;
> >> +	while (!IS_ALIGNED(name_len, sizeof(u64)))
> >> +		name[name_len++] = '\0';
> >> +	BUILD_BUG_ON(KSYM_NAME_LEN % sizeof(u64));
> >> +
> >> +	if (unregister)
> >> +		flags |= PERF_RECORD_KSYMBOL_FLAGS_UNREGISTER;
> >> +
> >> +	ksymbol_event = (struct perf_ksymbol_event){
> >> +		.name = name,
> >> +		.name_len = name_len,
> >> +		.event_id = {
> >> +			.header = {
> >> +				.type = PERF_RECORD_KSYMBOL,
> >> +				.size = sizeof(ksymbol_event.event_id) +
> >> +					name_len,
> >> +			},
> >> +			.addr = addr,
> >> +			.len = len,
> >> +			.ksym_type = ksym_type,
> >> +			.flags = flags,
> >> +		},
> >> +	};
> >> +
> >> +	perf_iterate_sb(perf_event_ksymbol_output, &ksymbol_event, NULL);
> >> +	return;
> >> +err:
> >> +	WARN_ONCE(1, "%s: Invalid KSYMBOL type 0x%x\n", __func__, ksym_type);
> >> +}
> >> +
> >> void perf_event_itrace_started(struct perf_event *event)
> >> {
> >> 	event->attach_state |= PERF_ATTACH_ITRACE;
> >> @@ -9900,6 +9994,8 @@ static void account_event(struct perf_event *event)
> >> 		inc = true;
> >> 	if (is_cgroup_event(event))
> >> 		inc = true;
> >> +	if (event->attr.ksymbol)
> >> +		atomic_inc(&nr_ksymbol_events);
> >> 
> >> 	if (inc) {
> >> 		/*
> >> -- 
> >> 2.17.1
> > 
> > -- 
> > 
> > - Arnaldo

-- 

- Arnaldo
