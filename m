Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD813ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 13:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78FDF20685
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 13:01:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CkTq4bSW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78FDF20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729319AbeJaV67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 17:58:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:38042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729126AbeJaV67 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 17:58:59 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27FB020664;
        Wed, 31 Oct 2018 13:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540990862;
        bh=hGcxkvCQYtgFRIO0XLedgUPj3ukkVMtAOhyLVh+BLSw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CkTq4bSWfbxoFrIMxK+zsrkZlIrFVywok4ETQCXTrakJL4Aa3U/4PMnXi6QnDx93/
         QzcWsDh2u1ObSVuJnCW50pFf6Uy4icO3gjmtIuLmVuCJMTblXYQYweGjzNTVkWI+NM
         gVs126Tmmy1QderKw/8tXYfRr6XD6Uabzn4wSu0U=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 7CC6F142C5F; Wed, 31 Oct 2018 10:00:59 -0300 (-03)
Date:   Wed, 31 Oct 2018 10:00:59 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     David Miller <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, jolsa@redhat.com,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH] perf: Don't clone maps from parent when synthesizing
 forks
Message-ID: <20181031130059.GD10660@kernel.org>
References: <20181030.222404.2085088822877051075.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181030.222404.2085088822877051075.davem@davemloft.net>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Oct 30, 2018 at 10:24:04PM -0700, David Miller escreveu:
> 
> When synthesizing FORK events, we are trying to create thread objects
> for the already running tasks on the machine.
> 
> Normally, for a kernel FORK event, we want to clone the parent's maps
> because that is what the kernel just did.
> 
> But when synthesizing, this should not be done.  If we do, we end up
> with overlapping maps as we process the sythesized MMAP2 events that
> get delivered shortly thereafter.
> 
> Use the FORK event misc flags in an internal way to signal this
> situation, so we can elide the map clone when appropriate.

Thanks, applied.

- Arnaldo
 
> Signed-off-by: David S. Miller <davem@davemloft.net>
> 
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index f35eb72739c0..9de8780ac8d9 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -646,10 +646,12 @@ struct perf_event_mmap_page {
>   *
>   *   PERF_RECORD_MISC_MMAP_DATA  - PERF_RECORD_MMAP* events
>   *   PERF_RECORD_MISC_COMM_EXEC  - PERF_RECORD_COMM event
> + *   PERF_RECORD_MISC_FORK_EXEC  - PERF_RECORD_FORK event (perf internal)
>   *   PERF_RECORD_MISC_SWITCH_OUT - PERF_RECORD_SWITCH* events
>   */
>  #define PERF_RECORD_MISC_MMAP_DATA		(1 << 13)
>  #define PERF_RECORD_MISC_COMM_EXEC		(1 << 13)
> +#define PERF_RECORD_MISC_FORK_EXEC		(1 << 13)
>  #define PERF_RECORD_MISC_SWITCH_OUT		(1 << 13)
>  /*
>   * These PERF_RECORD_MISC_* flags below are safely reused
> diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
> index f35eb72739c0..9de8780ac8d9 100644
> --- a/tools/include/uapi/linux/perf_event.h
> +++ b/tools/include/uapi/linux/perf_event.h
> @@ -646,10 +646,12 @@ struct perf_event_mmap_page {
>   *
>   *   PERF_RECORD_MISC_MMAP_DATA  - PERF_RECORD_MMAP* events
>   *   PERF_RECORD_MISC_COMM_EXEC  - PERF_RECORD_COMM event
> + *   PERF_RECORD_MISC_FORK_EXEC  - PERF_RECORD_FORK event (perf internal)
>   *   PERF_RECORD_MISC_SWITCH_OUT - PERF_RECORD_SWITCH* events
>   */
>  #define PERF_RECORD_MISC_MMAP_DATA		(1 << 13)
>  #define PERF_RECORD_MISC_COMM_EXEC		(1 << 13)
> +#define PERF_RECORD_MISC_FORK_EXEC		(1 << 13)
>  #define PERF_RECORD_MISC_SWITCH_OUT		(1 << 13)
>  /*
>   * These PERF_RECORD_MISC_* flags below are safely reused
> diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
> index bc646185f8d9..e9c108a6b1c3 100644
> --- a/tools/perf/util/event.c
> +++ b/tools/perf/util/event.c
> @@ -308,6 +308,7 @@ static int perf_event__synthesize_fork(struct perf_tool *tool,
>  	event->fork.pid  = tgid;
>  	event->fork.tid  = pid;
>  	event->fork.header.type = PERF_RECORD_FORK;
> +	event->fork.header.misc = PERF_RECORD_MISC_FORK_EXEC;
>  
>  	event->fork.header.size = (sizeof(event->fork) + machine->id_hdr_size);
>  
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 111ae858cbcb..214b7979c4e7 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -1708,6 +1708,7 @@ int machine__process_fork_event(struct machine *machine, union perf_event *event
>  	struct thread *parent = machine__findnew_thread(machine,
>  							event->fork.ppid,
>  							event->fork.ptid);
> +	bool do_maps_clone = true;
>  	int err = 0;
>  
>  	if (dump_trace)
> @@ -1737,8 +1738,11 @@ int machine__process_fork_event(struct machine *machine, union perf_event *event
>  	thread = machine__findnew_thread(machine, event->fork.pid,
>  					 event->fork.tid);
>  
> +	if (event->fork.header.misc & PERF_RECORD_MISC_FORK_EXEC)
> +		do_maps_clone = false;
> +
>  	if (thread == NULL || parent == NULL ||
> -	    thread__fork(thread, parent, sample->time) < 0) {
> +	    thread__fork(thread, parent, sample->time, do_maps_clone) < 0) {
>  		dump_printf("problem processing PERF_RECORD_FORK, skipping event.\n");
>  		err = -1;
>  	}
> diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
> index 2048d393ece6..54b2c9ceba9f 100644
> --- a/tools/perf/util/thread.c
> +++ b/tools/perf/util/thread.c
> @@ -330,7 +330,8 @@ static int thread__prepare_access(struct thread *thread)
>  }
>  
>  static int thread__clone_map_groups(struct thread *thread,
> -				    struct thread *parent)
> +				    struct thread *parent,
> +				    bool do_maps_clone)
>  {
>  	/* This is new thread, we share map groups for process. */
>  	if (thread->pid_ == parent->pid_)
> @@ -341,15 +342,14 @@ static int thread__clone_map_groups(struct thread *thread,
>  			 thread->pid_, thread->tid, parent->pid_, parent->tid);
>  		return 0;
>  	}
> -
>  	/* But this one is new process, copy maps. */
> -	if (map_groups__clone(thread, parent->mg) < 0)
> +	if (do_maps_clone &&
> +	    map_groups__clone(thread, parent->mg) < 0)
>  		return -ENOMEM;
> -
>  	return 0;
>  }
>  
> -int thread__fork(struct thread *thread, struct thread *parent, u64 timestamp)
> +int thread__fork(struct thread *thread, struct thread *parent, u64 timestamp, bool do_maps_clone)
>  {
>  	if (parent->comm_set) {
>  		const char *comm = thread__comm_str(parent);
> @@ -362,7 +362,7 @@ int thread__fork(struct thread *thread, struct thread *parent, u64 timestamp)
>  	}
>  
>  	thread->ppid = parent->tid;
> -	return thread__clone_map_groups(thread, parent);
> +	return thread__clone_map_groups(thread, parent, do_maps_clone);
>  }
>  
>  void thread__find_cpumode_addr_location(struct thread *thread, u64 addr,
> diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
> index 07606aa6998d..7e30fe99b74b 100644
> --- a/tools/perf/util/thread.h
> +++ b/tools/perf/util/thread.h
> @@ -87,7 +87,7 @@ struct comm *thread__comm(const struct thread *thread);
>  struct comm *thread__exec_comm(const struct thread *thread);
>  const char *thread__comm_str(const struct thread *thread);
>  int thread__insert_map(struct thread *thread, struct map *map);
> -int thread__fork(struct thread *thread, struct thread *parent, u64 timestamp);
> +int thread__fork(struct thread *thread, struct thread *parent, u64 timestamp, bool do_maps_clone);
>  size_t thread__fprintf(struct thread *thread, FILE *fp);
>  
>  struct thread *thread__main_thread(struct machine *machine, struct thread *thread);
