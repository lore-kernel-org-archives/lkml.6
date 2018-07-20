Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CFC5ECDE5F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 01:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B34B220673
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 01:21:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B34B220673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730913AbeGTCGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 22:06:44 -0400
Received: from lgeamrelo11.lge.com ([156.147.23.51]:41876 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730598AbeGTCGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 22:06:44 -0400
Received: from unknown (HELO lgemrelse7q.lge.com) (156.147.1.151)
        by 156.147.23.51 with ESMTP; 20 Jul 2018 10:20:56 +0900
X-Original-SENDERIP: 156.147.1.151
X-Original-MAILFROM: namhyung@kernel.org
Received: from unknown (HELO sejong) (10.177.227.17)
        by 156.147.1.151 with ESMTP; 20 Jul 2018 10:20:56 +0900
X-Original-SENDERIP: 10.177.227.17
X-Original-MAILFROM: namhyung@kernel.org
Date:   Fri, 20 Jul 2018 10:20:55 +0900
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Kan Liang <kan.liang@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Lukasz Odzioba <lukasz.odzioba@intel.com>,
        Wang Nan <wangnan0@huawei.com>, kernel-team@lge.com
Subject: Re: [PATCH 4/4] perf tools: Fix struct comm_str removal crash
Message-ID: <20180720012055.GA8457@sejong>
References: <20180719143345.12963-1-jolsa@kernel.org>
 <20180719143345.12963-5-jolsa@kernel.org>
 <20180719182843.GA2812@kernel.org>
 <20180719183114.GB2812@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180719183114.GB2812@kernel.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Thu, Jul 19, 2018 at 03:31:14PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Jul 19, 2018 at 03:28:43PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Thu, Jul 19, 2018 at 04:33:45PM +0200, Jiri Olsa escreveu:
> > > +++ b/tools/perf/util/comm.c
> > > @@ -18,11 +18,9 @@ struct comm_str {
> > >  static struct rb_root comm_str_root;
> > >  static struct rw_semaphore comm_str_lock = {.lock = PTHREAD_RWLOCK_INITIALIZER,};
> > >  
> > > -static struct comm_str *comm_str__get(struct comm_str *cs)
> > > +static bool comm_str__get(struct comm_str *cs)
> > >  {
> > > -	if (cs)
> > > -		refcount_inc(&cs->refcnt);
> > > -	return cs;
> > > +	return cs ? refcount_inc_not_zero(&cs->refcnt) : false;
> > >  }
> > 
> > I don't like changing the semantics of a __get() operation this way, I
> > think it should stay like all the others, i.e. return the object with
> > the desired refcount or return NULL if that is not possible.
> > 
> > Otherwise we'll have to switch gears when debugging refcounts in various
> > objects, that start having slightly different semantics for reference
> > counting.
> > 
> > We should try to find a fix that maintains the semantics of refcounting.
> 
> After looking at the code, this refcount_inc_not_zero returns bool comes
> from the kernel, trying to see how this is used with __get() operations
> there, if at all.

Something like this?

static struct comm_str *comm_str__get(struct comm_str *cs)
{
    if (cs && refcount_inc_not_zero(&cs->refcnt))
        return cs;
    return NULL;
}


Other than that I don't have better idea, so

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung
