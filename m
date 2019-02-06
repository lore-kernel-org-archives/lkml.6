Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00AA0C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0C7720818
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549456817;
	bh=ZXpq9Sqb2KI/E3kMrW5d9B7wMsaNfxXLmEe3YvvG1Gk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OEsU1cl8vf8Crnbdd1XLGGgDMsbHMMC+y8TIRbUjcabkRpPCcdFPMcMgj4ukm+LyT
	 RXrEbnehCy6w4vxBvtTAoT1bg5+XO1UIt5Q6jS8P92MxetQuU18z8umpGd3UDF4j4G
	 uwtoawq2ygLFLiRZDPA8TXP14HE+wV+FgwqArHfs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730492AbfBFMkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 07:40:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:38856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729091AbfBFMkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 07:40:10 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D153620818;
        Wed,  6 Feb 2019 12:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549456808;
        bh=ZXpq9Sqb2KI/E3kMrW5d9B7wMsaNfxXLmEe3YvvG1Gk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gs6nEE+4gxexbqstls+V3DU7TwWVycCiPchvK8dsoy41wzjr3bFHbym225BpxPNiZ
         BR9JPihoT1V1xtjJY3TmH9e95rfZ8mbf9Wlam5BGSGdneUpZeP/7cs288LF+itB7hN
         Bd0k3/k3IWci7Vy8hPQQsDJDvPd0KIpoOrysAdyU=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D47744034F; Wed,  6 Feb 2019 09:39:49 -0300 (-03)
Date:   Wed, 6 Feb 2019 09:39:49 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] perf thread-stack: Represent jmps to the start of a
 different symbol
Message-ID: <20190206123949.GB32016@kernel.org>
References: <20190109091835.5570-1-adrian.hunter@intel.com>
 <20190109091835.5570-5-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190109091835.5570-5-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jan 09, 2019 at 11:18:33AM +0200, Adrian Hunter escreveu:
> The compiler might optimize a call/ret combination by making it a jmp.
> However the thread-stack does not presently cater for that, so that such
> control flow is not visible in the call graph. Make it visible by recording
> on the stack a branch to the start of a different symbol. Note, that means
> when a ret pops the stack, all jmps must be popped off first.
> 
> Example:
> 
> $ cat jmp-to-fn.c
> __attribute__((noinline)) int bar(void)
> {
>         return -1;
> }
> 
> __attribute__((noinline)) int foo(void)
> {
>         return bar() + 1;
> }
> 
> int main()
> {
>         return foo();
> }
> $ gcc -ggdb3 -Wall -Wextra -O2 -o jmp-to-fn jmp-to-fn.c
> $ objdump -d jmp-to-fn
> <SNIP>
> 0000000000001040 <main>:
>     1040:       31 c0                   xor    %eax,%eax
>     1042:       e9 09 01 00 00          jmpq   1150 <foo>
> <SNIP>
> 0000000000001140 <bar>:
>     1140:       b8 ff ff ff ff          mov    $0xffffffff,%eax
>     1145:       c3                      retq
> <SNIP>
> 0000000000001150 <foo>:
>     1150:       31 c0                   xor    %eax,%eax
>     1152:       e8 e9 ff ff ff          callq  1140 <bar>
>     1157:       83 c0 01                add    $0x1,%eax
>     115a:       c3                      retq
> <SNIP>
> $ perf record -o jmp-to-fn.perf.data -e intel_pt/cyc/u ./jmp-to-fn
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0,017 MB jmp-to-fn.perf.data ]
> $ perf script -i jmp-to-fn.perf.data --itrace=be -s ~/libexec/perf-core/scripts/python/export-to-sqlite.py jmp-to-fn.db branches calls
> 2019-01-08 13:24:58.783069 Creating database...
> 2019-01-08 13:24:58.794650 Writing records...
> 2019-01-08 13:24:59.008050 Adding indexes
> 2019-01-08 13:24:59.015802 Done
> $  ~/libexec/perf-core/scripts/python/exported-sql-viewer.py jmp-to-fn.db

So, while testing this I notice that we need to do the python3
conversions for these scripts as well:

[acme@quaco adrian]$ objdump -d jmp-to-fn > /tmp/bla
[acme@quaco adrian]$ vim /tmp/bla
[acme@quaco adrian]$ perf record -o jmp-to-fn.perf.data -e intel_pt/cyc/u ./jmp-to-fn
Couldn't synthesize bpf events.
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.017 MB jmp-to-fn.perf.data ]
[acme@quaco adrian]$ perf script -i jmp-to-fn.perf.data --itrace=be -s ~/libexec/perf-core/scripts/python/export-to-sqlite.py jmp-to-fn.db branches calls
  File "/home/acme/libexec/perf-core/scripts/python/export-to-sqlite.py", line 103
    print datetime.datetime.today(), "Creating database..."
                 ^
SyntaxError: invalid syntax
Error running python script /home/acme/libexec/perf-core/scripts/python/export-to-sqlite.py
[acme@quaco adrian]$

Mostly are simple, i.e. in this case we need something like:

  print(str(datetime.datetime.today()) + "Creating database...")


for a really crude conversion, but one that would make this work with
both python2 and python3 (make PYTHON=python3 when building perf).

 
> Before:
> 
>     main
>         -> bar
> 
> After:
> 
>     main
>         -> foo
>             -> bar
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  .../scripts/python/export-to-postgresql.py    |  2 +-
>  tools/perf/scripts/python/export-to-sqlite.py |  2 +-
>  tools/perf/util/thread-stack.c                | 30 +++++++++++++++++--
>  tools/perf/util/thread-stack.h                |  3 ++
>  4 files changed, 33 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/scripts/python/export-to-postgresql.py b/tools/perf/scripts/python/export-to-postgresql.py
> index 0564dd7377f2..30130213da7e 100644
> --- a/tools/perf/scripts/python/export-to-postgresql.py
> +++ b/tools/perf/scripts/python/export-to-postgresql.py
> @@ -478,7 +478,7 @@ if perf_db_export_calls:
>  			'branch_count,'
>  			'call_id,'
>  			'return_id,'
> -			'CASE WHEN flags=1 THEN \'no call\' WHEN flags=2 THEN \'no return\' WHEN flags=3 THEN \'no call/return\' ELSE \'\' END AS flags,'
> +			'CASE WHEN flags=0 THEN \'\' WHEN flags=1 THEN \'no call\' WHEN flags=2 THEN \'no return\' WHEN flags=3 THEN \'no call/return\' WHEN flags=6 THEN \'jump\' ELSE flags END AS flags,'
>  			'parent_call_path_id'
>  		' FROM calls INNER JOIN call_paths ON call_paths.id = call_path_id')
>  
> diff --git a/tools/perf/scripts/python/export-to-sqlite.py b/tools/perf/scripts/python/export-to-sqlite.py
> index 245caf2643ed..ed237f2ed03f 100644
> --- a/tools/perf/scripts/python/export-to-sqlite.py
> +++ b/tools/perf/scripts/python/export-to-sqlite.py
> @@ -320,7 +320,7 @@ if perf_db_export_calls:
>  			'branch_count,'
>  			'call_id,'
>  			'return_id,'
> -			'CASE WHEN flags=1 THEN \'no call\' WHEN flags=2 THEN \'no return\' WHEN flags=3 THEN \'no call/return\' ELSE \'\' END AS flags,'
> +			'CASE WHEN flags=0 THEN \'\' WHEN flags=1 THEN \'no call\' WHEN flags=2 THEN \'no return\' WHEN flags=3 THEN \'no call/return\' WHEN flags=6 THEN \'jump\' ELSE flags END AS flags,'
>  			'parent_call_path_id'
>  		' FROM calls INNER JOIN call_paths ON call_paths.id = call_path_id')
>  
> diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
> index 7f8eff018c16..f52c0f90915d 100644
> --- a/tools/perf/util/thread-stack.c
> +++ b/tools/perf/util/thread-stack.c
> @@ -38,6 +38,7 @@
>   * @cp: call path
>   * @no_call: a 'call' was not seen
>   * @trace_end: a 'call' but trace ended
> + * @non_call: a branch but not a 'call' to the start of a different symbol
>   */
>  struct thread_stack_entry {
>  	u64 ret_addr;
> @@ -47,6 +48,7 @@ struct thread_stack_entry {
>  	struct call_path *cp;
>  	bool no_call;
>  	bool trace_end;
> +	bool non_call;
>  };
>  
>  /**
> @@ -268,6 +270,8 @@ static int thread_stack__call_return(struct thread *thread,
>  		cr.flags |= CALL_RETURN_NO_CALL;
>  	if (no_return)
>  		cr.flags |= CALL_RETURN_NO_RETURN;
> +	if (tse->non_call)
> +		cr.flags |= CALL_RETURN_NON_CALL;
>  
>  	return crp->process(&cr, crp->data);
>  }
> @@ -510,6 +514,7 @@ static int thread_stack__push_cp(struct thread_stack *ts, u64 ret_addr,
>  	tse->cp = cp;
>  	tse->no_call = no_call;
>  	tse->trace_end = trace_end;
> +	tse->non_call = false;
>  
>  	return 0;
>  }
> @@ -531,14 +536,16 @@ static int thread_stack__pop_cp(struct thread *thread, struct thread_stack *ts,
>  							 timestamp, ref, false);
>  	}
>  
> -	if (ts->stack[ts->cnt - 1].ret_addr == ret_addr) {
> +	if (ts->stack[ts->cnt - 1].ret_addr == ret_addr &&
> +	    !ts->stack[ts->cnt - 1].non_call) {
>  		return thread_stack__call_return(thread, ts, --ts->cnt,
>  						 timestamp, ref, false);
>  	} else {
>  		size_t i = ts->cnt - 1;
>  
>  		while (i--) {
> -			if (ts->stack[i].ret_addr != ret_addr)
> +			if (ts->stack[i].ret_addr != ret_addr ||
> +			    ts->stack[i].non_call)
>  				continue;
>  			i += 1;
>  			while (ts->cnt > i) {
> @@ -757,6 +764,25 @@ int thread_stack__process(struct thread *thread, struct comm *comm,
>  		err = thread_stack__trace_begin(thread, ts, sample->time, ref);
>  	} else if (sample->flags & PERF_IP_FLAG_TRACE_END) {
>  		err = thread_stack__trace_end(ts, sample, ref);
> +	} else if (sample->flags & PERF_IP_FLAG_BRANCH &&
> +		   from_al->sym != to_al->sym && to_al->sym &&
> +		   to_al->addr == to_al->sym->start) {
> +		struct call_path_root *cpr = ts->crp->cpr;
> +		struct call_path *cp;
> +
> +		/*
> +		 * The compiler might optimize a call/ret combination by making
> +		 * it a jmp. Make that visible by recording on the stack a
> +		 * branch to the start of a different symbol. Note, that means
> +		 * when a ret pops the stack, all jmps must be popped off first.
> +		 */
> +		cp = call_path__findnew(cpr, ts->stack[ts->cnt - 1].cp,
> +					to_al->sym, sample->addr,
> +					ts->kernel_start);
> +		err = thread_stack__push_cp(ts, 0, sample->time, ref, cp, false,
> +					    false);
> +		if (!err)
> +			ts->stack[ts->cnt - 1].non_call = true;
>  	}
>  
>  	return err;
> diff --git a/tools/perf/util/thread-stack.h b/tools/perf/util/thread-stack.h
> index 1f626f4a1c40..b7c04e19ad41 100644
> --- a/tools/perf/util/thread-stack.h
> +++ b/tools/perf/util/thread-stack.h
> @@ -35,10 +35,13 @@ struct call_path;
>   *
>   * CALL_RETURN_NO_CALL: 'return' but no matching 'call'
>   * CALL_RETURN_NO_RETURN: 'call' but no matching 'return'
> + * CALL_RETURN_NON_CALL: a branch but not a 'call' to the start of a different
> + *                       symbol
>   */
>  enum {
>  	CALL_RETURN_NO_CALL	= 1 << 0,
>  	CALL_RETURN_NO_RETURN	= 1 << 1,
> +	CALL_RETURN_NON_CALL	= 1 << 2,
>  };
>  
>  /**
> -- 
> 2.17.1

-- 

- Arnaldo
