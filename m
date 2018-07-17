Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B9EECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 01:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52481208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 01:49:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52481208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731250AbeGQCTu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 22:19:50 -0400
Received: from lgeamrelo11.lge.com ([156.147.23.51]:53577 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730267AbeGQCTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 22:19:50 -0400
Received: from unknown (HELO lgemrelse7q.lge.com) (156.147.1.151)
        by 156.147.23.51 with ESMTP; 17 Jul 2018 10:49:41 +0900
X-Original-SENDERIP: 156.147.1.151
X-Original-MAILFROM: namhyung@kernel.org
Received: from unknown (HELO sejong) (10.177.227.17)
        by 156.147.1.151 with ESMTP; 17 Jul 2018 10:49:41 +0900
X-Original-SENDERIP: 10.177.227.17
X-Original-MAILFROM: namhyung@kernel.org
Date:   Tue, 17 Jul 2018 10:49:40 +0900
From:   Namhyung Kim <namhyung@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Kan Liang <kan.liang@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Lukasz Odzioba <lukasz.odzioba@intel.com>,
        Wang Nan <wangnan0@huawei.com>, kernel-team@lge.com
Subject: Re: [PATCH 1/4] perf tools: Fix struct comm_str removal crash
Message-ID: <20180717014940.GA9295@sejong>
References: <20180712142023.16915-1-jolsa@kernel.org>
 <20180712142023.16915-2-jolsa@kernel.org>
 <20180715130827.GA5071@danjae.aot.lge.com>
 <20180716102934.GA14153@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180716102934.GA14153@krava>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On Mon, Jul 16, 2018 at 12:29:34PM +0200, Jiri Olsa wrote:
> On Sun, Jul 15, 2018 at 10:08:27PM +0900, Namhyung Kim wrote:
> 
> SNIP
> 
> > > Because thread 2 first decrements the refcnt and only after then it
> > > removes the struct comm_str from the list, the thread 1 can find this
> > > object on the list with refcnt equls to 0 and hit the assert.
> > > 
> > > This patch fixes the thread 2 path, by removing the struct comm_str
> > > FIRST from the list and only AFTER calling comm_str__put on it. This
> > > way the thread 1 finds only valid objects on the list.
> > 
> > I'm not sure we can unconditionally remove the comm_str from the tree.
> > It should be removed only if refcount is going to zero IMHO.
> > Otherwise it could end up having multiple comm_str entry for a same
> > name.
> 
> right, but it wouldn't crash ;-)
> 
> how about attached change, that actualy deals with the refcnt
> race I'm running the tests now, seems ok so far

I think we can keep if the refcount is back to non-zero.  What about this?
(not tested..)


static struct comm_str *comm_str__get(cs)
{
    if (cs)
        refcount_inc_no_warn(&cs->refcnt);  // should be added
    return cs;
}

static void comm_str__put(cs)
{
    if (cs && refcount_dec_and_test(&cs->refcnt)) {
        down_write(&comm_str_lock);
        /* might race with comm_str__findnew() */
        if (!refcount_read(&cs->refcnt)) {
            rb_erase(&cs->rb_node, &comm_str_root);
            zfree(&cs->str);
            free(cs);
        }
        up_write(&comm_str_lock);
    }
}


Thanks,
Namhyung


> 
> 
> ---
> diff --git a/tools/perf/util/comm.c b/tools/perf/util/comm.c
> index 7798a2cc8a86..592b03548021 100644
> --- a/tools/perf/util/comm.c
> +++ b/tools/perf/util/comm.c
> @@ -18,22 +18,27 @@ struct comm_str {
>  static struct rb_root comm_str_root;
>  static struct rw_semaphore comm_str_lock = {.lock = PTHREAD_RWLOCK_INITIALIZER,};
>  
> -static struct comm_str *comm_str__get(struct comm_str *cs)
> +static bool comm_str__get(struct comm_str *cs)
>  {
> -	if (cs)
> -		refcount_inc(&cs->refcnt);
> -	return cs;
> +	return cs ? refcount_inc_not_zero(&cs->refcnt) : false;
>  }
>  
> -static void comm_str__put(struct comm_str *cs)
> +static int comm_str__put(struct comm_str *cs, bool lock)
>  {
> -	if (cs && refcount_dec_and_test(&cs->refcnt)) {
> +	if (!cs || !refcount_dec_and_test(&cs->refcnt))
> +		return 0;
> +
> +	if (lock)
>  		down_write(&comm_str_lock);
> -		rb_erase(&cs->rb_node, &comm_str_root);
> +
> +	rb_erase(&cs->rb_node, &comm_str_root);
> +
> +	if (lock)
>  		up_write(&comm_str_lock);
> -		zfree(&cs->str);
> -		free(cs);
> -	}
> +
> +	zfree(&cs->str);
> +	free(cs);
> +	return 1;
>  }
>  
>  static struct comm_str *comm_str__alloc(const char *str)
> @@ -67,9 +72,22 @@ struct comm_str *__comm_str__findnew(const char *str, struct rb_root *root)
>  		parent = *p;
>  		iter = rb_entry(parent, struct comm_str, rb_node);
>  
> -		cmp = strcmp(str, iter->str);
> -		if (!cmp)
> -			return comm_str__get(iter);
> +		/*
> +		 * If we race with comm_str__put, iter->refcnt == 0
> +		 * and it will be removed within comm_str__put
> +		 * thread shortly, ignore it in this search.
> +		 */
> +		if (comm_str__get(iter)) {
> +			cmp = strcmp(str, iter->str);
> +			if (!cmp)
> +				return iter;
> +			/*
> +			 * If we actualy had to remove the item, restart
> +			 * the search to have the clean tree search.
> +			 */
> +			if (comm_str__put(iter, false))
> +				return __comm_str__findnew(str, root);
> +		}
>  
>  		if (cmp < 0)
>  			p = &(*p)->rb_left;
> @@ -125,7 +143,7 @@ int comm__override(struct comm *comm, const char *str, u64 timestamp, bool exec)
>  	if (!new)
>  		return -ENOMEM;
>  
> -	comm_str__put(old);
> +	comm_str__put(old, true);
>  	comm->comm_str = new;
>  	comm->start = timestamp;
>  	if (exec)
> @@ -136,7 +154,7 @@ int comm__override(struct comm *comm, const char *str, u64 timestamp, bool exec)
>  
>  void comm__free(struct comm *comm)
>  {
> -	comm_str__put(comm->comm_str);
> +	comm_str__put(comm->comm_str, true);
>  	free(comm);
>  }
>  
