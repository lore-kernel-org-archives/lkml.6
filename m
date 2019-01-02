Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A601C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 13:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25B1D218DE
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 13:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546436856;
	bh=af7rCfmSnkwpyvq7GmTMqubSQ20RPrguoyUvYgjY540=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2JQGQNerwPojLZqi1Px4j1nxZyQnCSqacvujWwtDm3Gk8YIoUzFPPKM1uXGysZ9Vc
	 sBJJq5OURLW+W/RP32/U/WWkjm/nj6hO/NrQMuSAQqLBshsBHYyBKbah7ZJ7taMaCj
	 nctz4FinXyhUhgZf+hDU30vwAZGoDVm61/k3f4Pk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729603AbfABNrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 08:47:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:47280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727294AbfABNre (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 08:47:34 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2834218DE;
        Wed,  2 Jan 2019 13:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546436853;
        bh=af7rCfmSnkwpyvq7GmTMqubSQ20RPrguoyUvYgjY540=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HLUhONr2zqWhukjKJrWB2bMFsR1EtF1/q7R6XZjNMNJQZ7Df7kvQFKI0ClA3q7NBm
         xINRf7waP5KWKnhW6m6bggdpKjKDQ4mAqfEZMcKqxfI+9i3765cRDtY8f1wN7Zhx2a
         UyeTA3/31CVIT5JfIXAEHn6xnxuZ4ijzEgg65wMI=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A791340F61; Wed,  2 Jan 2019 10:47:29 -0300 (-03)
Date:   Wed, 2 Jan 2019 10:47:29 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] perf thread-stack: Avoid direct reference to the
 thread's stack
Message-ID: <20190102134729.GB15460@kernel.org>
References: <20181221120620.9659-1-adrian.hunter@intel.com>
 <20181221120620.9659-4-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181221120620.9659-4-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Dec 21, 2018 at 02:06:15PM +0200, Adrian Hunter escreveu:
> In preparation for fixing thread stack processing for the idle task,
> avoid direct reference to the thread's stack. The thread stack will change
> to an array of thread stacks, at which point the meaning of the direct
> reference will change.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/util/thread-stack.c | 81 ++++++++++++++++++++--------------
>  1 file changed, 49 insertions(+), 32 deletions(-)
> 
> diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
> index 068c7c8db4be..e13127755293 100644
> --- a/tools/perf/util/thread-stack.c
> +++ b/tools/perf/util/thread-stack.c
> @@ -111,9 +111,16 @@ static struct thread_stack *thread_stack__new(struct thread *thread,
>  		ts->kernel_start = 1ULL << 63;
>  	ts->crp = crp;
>  
> +	thread->ts = ts;
> +
>  	return ts;
>  }
>  
> +static inline struct thread_stack *thread_stack__ts(struct thread *thread)
> +{
> +	return thread ? thread->ts : NULL;
> +}

So, this is a 'thread' method, so it should be instead:

static inline struct thread_stack *thread__stack(struct thread *thread)

perhaps?

Or thread__ts() or the longer thread__thread_stack(), I think
thread__stack() is ok, I'm doing it tentatively in my local branch,
holler if you disagree.

- Arnaldo
  

> +
>  static int thread_stack__push(struct thread_stack *ts, u64 ret_addr,
>  			      bool trace_end)
>  {
> @@ -226,8 +233,10 @@ static int __thread_stack__flush(struct thread *thread, struct thread_stack *ts)
>  
>  int thread_stack__flush(struct thread *thread)
>  {
> -	if (thread->ts)
> -		return __thread_stack__flush(thread, thread->ts);
> +	struct thread_stack *ts = thread->ts;
> +
> +	if (ts)
> +		return __thread_stack__flush(thread, ts);
>  
>  	return 0;
>  }
> @@ -235,16 +244,18 @@ int thread_stack__flush(struct thread *thread)
>  int thread_stack__event(struct thread *thread, u32 flags, u64 from_ip,
>  			u64 to_ip, u16 insn_len, u64 trace_nr)
>  {
> +	struct thread_stack *ts = thread_stack__ts(thread);
> +
>  	if (!thread)
>  		return -EINVAL;
>  
> -	if (!thread->ts) {
> -		thread->ts = thread_stack__new(thread, NULL);
> -		if (!thread->ts) {
> +	if (!ts) {
> +		ts = thread_stack__new(thread, NULL);
> +		if (!ts) {
>  			pr_warning("Out of memory: no thread stack\n");
>  			return -ENOMEM;
>  		}
> -		thread->ts->trace_nr = trace_nr;
> +		ts->trace_nr = trace_nr;
>  	}
>  
>  	/*
> @@ -252,14 +263,14 @@ int thread_stack__event(struct thread *thread, u32 flags, u64 from_ip,
>  	 * the stack might be completely invalid.  Better to report nothing than
>  	 * to report something misleading, so flush the stack.
>  	 */
> -	if (trace_nr != thread->ts->trace_nr) {
> -		if (thread->ts->trace_nr)
> -			__thread_stack__flush(thread, thread->ts);
> -		thread->ts->trace_nr = trace_nr;
> +	if (trace_nr != ts->trace_nr) {
> +		if (ts->trace_nr)
> +			__thread_stack__flush(thread, ts);
> +		ts->trace_nr = trace_nr;
>  	}
>  
>  	/* Stop here if thread_stack__process() is in use */
> -	if (thread->ts->crp)
> +	if (ts->crp)
>  		return 0;
>  
>  	if (flags & PERF_IP_FLAG_CALL) {
> @@ -270,7 +281,7 @@ int thread_stack__event(struct thread *thread, u32 flags, u64 from_ip,
>  		ret_addr = from_ip + insn_len;
>  		if (ret_addr == to_ip)
>  			return 0; /* Zero-length calls are excluded */
> -		return thread_stack__push(thread->ts, ret_addr,
> +		return thread_stack__push(ts, ret_addr,
>  					  flags & PERF_IP_FLAG_TRACE_END);
>  	} else if (flags & PERF_IP_FLAG_TRACE_BEGIN) {
>  		/*
> @@ -280,10 +291,10 @@ int thread_stack__event(struct thread *thread, u32 flags, u64 from_ip,
>  		 * address, so try to pop that. Also, do not expect a call made
>  		 * when the trace ended, to return, so pop that.
>  		 */
> -		thread_stack__pop(thread->ts, to_ip);
> -		thread_stack__pop_trace_end(thread->ts);
> +		thread_stack__pop(ts, to_ip);
> +		thread_stack__pop_trace_end(ts);
>  	} else if ((flags & PERF_IP_FLAG_RETURN) && from_ip) {
> -		thread_stack__pop(thread->ts, to_ip);
> +		thread_stack__pop(ts, to_ip);
>  	}
>  
>  	return 0;
> @@ -291,21 +302,25 @@ int thread_stack__event(struct thread *thread, u32 flags, u64 from_ip,
>  
>  void thread_stack__set_trace_nr(struct thread *thread, u64 trace_nr)
>  {
> -	if (!thread || !thread->ts)
> +	struct thread_stack *ts = thread_stack__ts(thread);
> +
> +	if (!ts)
>  		return;
>  
> -	if (trace_nr != thread->ts->trace_nr) {
> -		if (thread->ts->trace_nr)
> -			__thread_stack__flush(thread, thread->ts);
> -		thread->ts->trace_nr = trace_nr;
> +	if (trace_nr != ts->trace_nr) {
> +		if (ts->trace_nr)
> +			__thread_stack__flush(thread, ts);
> +		ts->trace_nr = trace_nr;
>  	}
>  }
>  
>  void thread_stack__free(struct thread *thread)
>  {
> -	if (thread->ts) {
> -		__thread_stack__flush(thread, thread->ts);
> -		zfree(&thread->ts->stack);
> +	struct thread_stack *ts = thread->ts;
> +
> +	if (ts) {
> +		__thread_stack__flush(thread, ts);
> +		zfree(&ts->stack);
>  		zfree(&thread->ts);
>  	}
>  }
> @@ -318,6 +333,7 @@ static inline u64 callchain_context(u64 ip, u64 kernel_start)
>  void thread_stack__sample(struct thread *thread, struct ip_callchain *chain,
>  			  size_t sz, u64 ip, u64 kernel_start)
>  {
> +	struct thread_stack *ts = thread_stack__ts(thread);
>  	u64 context = callchain_context(ip, kernel_start);
>  	u64 last_context;
>  	size_t i, j;
> @@ -330,15 +346,15 @@ void thread_stack__sample(struct thread *thread, struct ip_callchain *chain,
>  	chain->ips[0] = context;
>  	chain->ips[1] = ip;
>  
> -	if (!thread || !thread->ts) {
> +	if (!ts) {
>  		chain->nr = 2;
>  		return;
>  	}
>  
>  	last_context = context;
>  
> -	for (i = 2, j = 1; i < sz && j <= thread->ts->cnt; i++, j++) {
> -		ip = thread->ts->stack[thread->ts->cnt - j].ret_addr;
> +	for (i = 2, j = 1; i < sz && j <= ts->cnt; i++, j++) {
> +		ip = ts->stack[ts->cnt - j].ret_addr;
>  		context = callchain_context(ip, kernel_start);
>  		if (context != last_context) {
>  			if (i >= sz - 1)
> @@ -590,7 +606,7 @@ int thread_stack__process(struct thread *thread, struct comm *comm,
>  			  struct addr_location *to_al, u64 ref,
>  			  struct call_return_processor *crp)
>  {
> -	struct thread_stack *ts = thread->ts;
> +	struct thread_stack *ts = thread_stack__ts(thread);
>  	int err = 0;
>  
>  	if (ts && !ts->crp) {
> @@ -600,10 +616,9 @@ int thread_stack__process(struct thread *thread, struct comm *comm,
>  	}
>  
>  	if (!ts) {
> -		thread->ts = thread_stack__new(thread, crp);
> -		if (!thread->ts)
> +		ts = thread_stack__new(thread, crp);
> +		if (!ts)
>  			return -ENOMEM;
> -		ts = thread->ts;
>  		ts->comm = comm;
>  	}
>  
> @@ -668,7 +683,9 @@ int thread_stack__process(struct thread *thread, struct comm *comm,
>  
>  size_t thread_stack__depth(struct thread *thread)
>  {
> -	if (!thread->ts)
> +	struct thread_stack *ts = thread_stack__ts(thread);
> +
> +	if (!ts)
>  		return 0;
> -	return thread->ts->cnt;
> +	return ts->cnt;
>  }
> -- 
> 2.17.1

-- 

- Arnaldo
