Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E538DECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9039220856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:09:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IiaYsxHu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9039220856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbeGXQQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 12:16:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:59868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727512AbeGXQQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 12:16:08 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4848820856;
        Tue, 24 Jul 2018 15:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532444952;
        bh=STAGxzWU9mM74j1xVx0BEPOJVgEwxTEBQi3N+aNhsuE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IiaYsxHuNx3etUF/iwo7b+46dADVIK3OrWI2SxFiTadOAYQTtCHWKpowjHAzyDhz+
         o3eSrTLVHHyQQBaBCA3SO7gUQgeYf1FPi3I8cUA/djlxOuCypbDd7YdaxbRSHcXxzj
         pOjlWFv0GXTxpgz1/03QpkwLvBFAD6kDZlK16GkA=
Date:   Wed, 25 Jul 2018 00:09:09 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Hiraku Toyooka <hiraku.toyooka@cybertrust.co.jp>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/3] [BUGFIX] tracing: Fix double free of
 event_trigger_data
Message-Id: <20180725000909.6c8b2f3881ee75c4f6bd466b@kernel.org>
In-Reply-To: <20180723221006.60cc7aa9@vmware.local.home>
References: <153149923649.11274.14970833360963898112.stgit@devbox>
        <153149926702.11274.12489440326560729788.stgit@devbox>
        <20180723221006.60cc7aa9@vmware.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jul 2018 22:10:06 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sat, 14 Jul 2018 01:27:47 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Fix a double free bug of event_trigger_data caused by
> > calling unregister_trigger() from register_snapshot_trigger().
> > This kicks a kernel BUG if double free checker is enabled
> > as below;
> > 
> >  kernel BUG at /home/mhiramat/ksrc/linux/mm/slub.c:296!
> >  invalid opcode: 0000 [#1] SMP PTI
> >  CPU: 2 PID: 4312 Comm: ftracetest Not tainted 4.18.0-rc1+ #44
> >  Hardware name: ASUS All Series/B85M-G, BIOS 2108 08/11/2014
> >  RIP: 0010:set_freepointer.part.37+0x0/0x10
> >  Code: 41 b8 01 00 00 00 29 c8 4d 8d 0c 0c b9 10 00 00 00 50 e8 e3 28 23 00 8b 53 08 5e 5f 89 d1 81 e1 00 04 00 00 e9 e9 fe ff ff 90 <0f> 0b 0f 1f 40 00 66 2e 0f 1f 84 00 00 00 00 00 48 c7 c6 90 7f 0d
> >  RSP: 0018:ffffa799caa3bd90 EFLAGS: 00010246
> >  RAX: ffff9b825f8c8e80 RBX: ffff9b825f8c8e80 RCX: ffff9b825f8c8e80
> >  RDX: 0000000000021562 RSI: ffff9b830e9e70e0 RDI: 0000000000000202
> >  RBP: 0000000000000246 R08: 0000000000000001 R09: 0000000000000000
> >  R10: 0000000000000000 R11: 0000000000000000 R12: ffff9b830e0072c0
> >  R13: ffffeb8e0d7e3200 R14: ffffffff961db7af R15: 00000000fffffffe
> >  FS:  00007f135ba9f700(0000) GS:ffff9b830e800000(0000) knlGS:0000000000000000
> >  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >  CR2: 0000563736b5f3a2 CR3: 0000000295916005 CR4: 00000000001606e0
> >  Call Trace:
> >   kfree+0x35d/0x380
> >   event_trigger_callback+0x13f/0x1c0
> >   event_trigger_write+0xf2/0x1a0
> >   ? lock_acquire+0x9f/0x200
> >   __vfs_write+0x26/0x170
> >   ? rcu_read_lock_sched_held+0x6b/0x80
> >   ? rcu_sync_lockdep_assert+0x2e/0x60
> >   ? __sb_start_write+0x13e/0x1a0
> >   ? vfs_write+0x18a/0x1b0
> >   vfs_write+0xc1/0x1b0
> >   ksys_write+0x45/0xa0
> >   do_syscall_64+0x60/0x200
> >   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > 
> > unregister_trigger() will free given event_trigger_data
> > at last. But that event_trigger_data will be freed again
> > in event_trigger_callback() if register_snapshot_trigger()
> > is failed, and causes a double free bug.
> > 
> > Registering the data should be the final operation in the
> > register function on normal path, because the trigger
> > must be ready for taking action right after it is
> > registered.
> 
> Nice catch. I can reproduce this. But this patch is fixing the symptom
> and not the disease.
> 
> > 
> > Fixes: commit 93e31ffbf417 ("tracing: Add 'snapshot' event trigger command")
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Tom Zanussi <tom.zanussi@linux.intel.com>
> > Cc: stable@vger.kernel.org
> > ---
> >  kernel/trace/trace.c                |    5 +++++
> >  kernel/trace/trace.h                |    2 ++
> >  kernel/trace/trace_events_trigger.c |   10 ++++++----
> >  3 files changed, 13 insertions(+), 4 deletions(-)
> > 
> > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > index f054bd6a1c66..2556d8c097d2 100644
> > --- a/kernel/trace/trace.c
> > +++ b/kernel/trace/trace.c
> > @@ -980,6 +980,11 @@ static void free_snapshot(struct trace_array *tr)
> >  	tr->allocated_snapshot = false;
> >  }
> >  
> > +void tracing_free_snapshot_instance(struct trace_array *tr)
> > +{
> > +	free_snapshot(tr);
> > +}
> > +
> >  /**
> >   * tracing_alloc_snapshot - allocate snapshot buffer.
> >   *
> > diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> > index f8f86231ad90..03468bb8a79a 100644
> > --- a/kernel/trace/trace.h
> > +++ b/kernel/trace/trace.h
> > @@ -1823,12 +1823,14 @@ static inline void trace_event_eval_update(struct trace_eval_map **map, int len)
> >  #ifdef CONFIG_TRACER_SNAPSHOT
> >  void tracing_snapshot_instance(struct trace_array *tr);
> >  int tracing_alloc_snapshot_instance(struct trace_array *tr);
> > +void tracing_free_snapshot_instance(struct trace_array *tr);
> >  #else
> >  static inline void tracing_snapshot_instance(struct trace_array *tr) { }
> >  static inline int tracing_alloc_snapshot_instance(struct trace_array *tr)
> >  {
> >  	return 0;
> >  }
> > +static inline void tracing_free_snapshot_instance(struct trace_array *tr) { }
> >  #endif
> >  
> >  extern struct trace_iterator *tracepoint_print_iter;
> > diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
> > index d18249683682..40e2f4406b2c 100644
> > --- a/kernel/trace/trace_events_trigger.c
> > +++ b/kernel/trace/trace_events_trigger.c
> > @@ -1079,11 +1079,13 @@ register_snapshot_trigger(char *glob, struct event_trigger_ops *ops,
> >  			  struct event_trigger_data *data,
> >  			  struct trace_event_file *file)
> >  {
> > -	int ret = register_trigger(glob, ops, data, file);
> > +	int free_if_fail = !file->tr->allocated_snapshot;
> > +	int ret = 0;
> >  
> > -	if (ret > 0 && tracing_alloc_snapshot_instance(file->tr) != 0) {
> > -		unregister_trigger(glob, ops, data, file);
> > -		ret = 0;
> > +	if (!tracing_alloc_snapshot_instance(file->tr)) {
> > +		ret = register_trigger(glob, ops, data, file);
> > +		if (ret == 0 && free_if_fail)
> > +			tracing_free_snapshot_instance(file->tr);
> >  	}
> >  
> >  	return ret;
> 
> Really, when we register_trigger() we should be able to freely call
> unresgister_trigger() with no side effects like the above happens.
> Instead of doing the above, I believe this is a better approach:
> 
> Thoughts?

Hmm, your patch seems to leak a memory since event_trigger_init() will
be called twice on same trigger_data (Note that event_trigger_init()
does not init ref counter, but increment it.) So we should decrement
it when we find it is succeeded. Moreover, if register_trigger()
fails before calling data->ops->init() (see -EEXIST case), the ref
counter will be 0 (-1 +1). But if it fails after data->ops->init(),
the ref counter will be 1 (-1 +1 +1). It still be unstable.
(Ah, that means we may have another trouble...)

> 
> P.S. This brings up another minor bug. The failure should return ENOMEM
> not ENOENT.

Hmm it seems we should review the register_trigger() implementation.
It should return the return value of trace_event_trigger_enable_disable(),
shouldn't it?

Thank you,

> 
> -- Steve
> 
> diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
> index d18249683682..d15a746bcdfb 100644
> --- a/kernel/trace/trace_events_trigger.c
> +++ b/kernel/trace/trace_events_trigger.c
> @@ -679,6 +679,7 @@ event_trigger_callback(struct event_command *cmd_ops,
>  		goto out_free;
>  
>   out_reg:
> +	event_trigger_init(trigger_ops, trigger_data);
>  	ret = cmd_ops->reg(glob, trigger_ops, trigger_data, file);
>  	/*
>  	 * The above returns on success the # of functions enabled,
> @@ -687,9 +688,9 @@ event_trigger_callback(struct event_command *cmd_ops,
>  	 */
>  	if (!ret) {
>  		ret = -ENOENT;
> -		goto out_free;
> +		goto out_free_trigger;
>  	} else if (ret < 0)
> -		goto out_free;
> +		goto out_free_trigger;
>  	ret = 0;
>   out:
>  	return ret;
> @@ -699,6 +700,10 @@ event_trigger_callback(struct event_command *cmd_ops,
>  		cmd_ops->set_filter(NULL, trigger_data, NULL);
>  	kfree(trigger_data);
>  	goto out;
> +
> + out_free_trigger:
> +	event_trigger_free(trigger_ops, trigger_data);
> +	goto out;
>  }
>  
>  /**


-- 
Masami Hiramatsu <mhiramat@kernel.org>
