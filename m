Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8AFEECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D3FC2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:44:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D3FC2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729306AbeGRLVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 07:21:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42532 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728711AbeGRLVa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 07:21:30 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1F518401EF0B;
        Wed, 18 Jul 2018 10:44:12 +0000 (UTC)
Received: from krava (unknown [10.43.17.196])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3B512178B8;
        Wed, 18 Jul 2018 10:44:09 +0000 (UTC)
Date:   Wed, 18 Jul 2018 12:44:08 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
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
Message-ID: <20180718104408.GA15068@krava>
References: <20180712142023.16915-1-jolsa@kernel.org>
 <20180712142023.16915-2-jolsa@kernel.org>
 <20180715130827.GA5071@danjae.aot.lge.com>
 <20180716102934.GA14153@krava>
 <20180717014940.GA9295@sejong>
 <20180717090245.GB8631@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717090245.GB8631@krava>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 18 Jul 2018 10:44:12 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 18 Jul 2018 10:44:12 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 11:02:45AM +0200, Jiri Olsa wrote:

SNIP

> +/*
> + * Pure refs increase without any chec/warn.
> + */
> +static inline void refcount_inc_no_warn(refcount_t *r)
> +{
> +	atomic_inc(&r->refs);
> +}
> +
>  /*
>   * Similar to atomic_dec_and_test(), it will WARN on underflow and fail to
>   * decrement when saturated at UINT_MAX.
> diff --git a/tools/perf/util/comm.c b/tools/perf/util/comm.c
> index 7798a2cc8a86..a2e338cf29d7 100644
> --- a/tools/perf/util/comm.c
> +++ b/tools/perf/util/comm.c
> @@ -21,7 +21,7 @@ static struct rw_semaphore comm_str_lock = {.lock = PTHREAD_RWLOCK_INITIALIZER,}
>  static struct comm_str *comm_str__get(struct comm_str *cs)
>  {
>  	if (cs)
> -		refcount_inc(&cs->refcnt);
> +		refcount_inc_no_warn(&cs->refcnt);
>  	return cs;
>  }
>  
> @@ -29,10 +29,12 @@ static void comm_str__put(struct comm_str *cs)
>  {
>  	if (cs && refcount_dec_and_test(&cs->refcnt)) {
>  		down_write(&comm_str_lock);
> -		rb_erase(&cs->rb_node, &comm_str_root);
> +		if (refcount_read(&cs->refcnt) == 0) {
> +			rb_erase(&cs->rb_node, &comm_str_root);
> +			zfree(&cs->str);
> +			free(cs);
> +		}
>  		up_write(&comm_str_lock);
> -		zfree(&cs->str);
> -		free(cs);
>  	}
>  }
>  

I'm still getting crashes with this code, there's another race
in comm_str__put, consider following paths (with 'cs' struct comm_str data):

thread 0:
  ...
  comm_str__put
    refcount_dec_and_test(&cs->refcnt) == true
    down_write(&comm_str_lock);
--> cs->refcnt == 0, but we are blocked and waiting for the lock to remove cs, and meanwhile:

	thread 1:
	  ...
	  __comm_str__findnew(...
	    comm_str__get(cs)
----------> cs->refcnt == 1

	thread 2:
	  ...
	  comm_str__put
	    refcount_dec_and_test(&cs->refcnt) == true
----------> cs->refcnt == 0, thread 2 gets the lock and removes cs
	  ...


thread 0:
  ...
--> comm_str__put gets the lock and removes 'cs' which aborts with double free


we don't have this problem if we ignore objects that dropped to
refcnt == 0, which was what my previous change was doing

jirka
