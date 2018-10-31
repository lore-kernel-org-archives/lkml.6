Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D800ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 13:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22DA920664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 13:01:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22DA920664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729332AbeJaV7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 17:59:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48818 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729128AbeJaV7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 17:59:46 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2998CC0495A6;
        Wed, 31 Oct 2018 13:01:50 +0000 (UTC)
Received: from krava (unknown [10.43.17.150])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6DCC368393;
        Wed, 31 Oct 2018 13:01:47 +0000 (UTC)
Date:   Wed, 31 Oct 2018 14:01:38 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     David Miller <davem@davemloft.net>
Cc:     acme@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: Don't clone maps from parent when synthesizing
 forks
Message-ID: <20181031130138.GA13216@krava>
References: <20181030.222404.2085088822877051075.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181030.222404.2085088822877051075.davem@davemloft.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Wed, 31 Oct 2018 13:01:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 10:24:04PM -0700, David Miller wrote:

SNIP

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

could you please put some comment in here shortly
explaining the reason behind this flag

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

we could move all this into one line:

	return do_maps_clone ? map_groups__clone(thread, parent->mg) : 0;

thanks,
jirka

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
