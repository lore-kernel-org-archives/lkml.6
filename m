Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 139FDC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 18:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A84E32084E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 18:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nv7oFHXP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A84E32084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732144AbeGSTPk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 15:15:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:59858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731699AbeGSTPj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 15:15:39 -0400
Received: from jouet.infradead.org (177.207.137.44.dynamic.adsl.gvt.net.br [177.207.137.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D20FD206B7;
        Thu, 19 Jul 2018 18:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532025077;
        bh=hUIwSEelIS/cOaCDU+a04TxQFmY7S9wvG+CVfo1vG04=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nv7oFHXPm/I7kAYyBYubrLRCqhifYrPq8QVzah2bSvw3csDJyA3HiC8SsRKqIMbqr
         Q6dbA1dP5w6KYSXteqkFaqmnwGdmrqiE/cIlauGBLd387LExVlkQLmrOmifXpFnvGB
         utYixELAK+xd3RoUhrFS2YRjFT/02UxhmVzvJl5Y=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id B750A14486C; Thu, 19 Jul 2018 15:31:14 -0300 (-03)
Date:   Thu, 19 Jul 2018 15:31:14 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Kan Liang <kan.liang@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Lukasz Odzioba <lukasz.odzioba@intel.com>,
        Wang Nan <wangnan0@huawei.com>
Subject: Re: [PATCH 4/4] perf tools: Fix struct comm_str removal crash
Message-ID: <20180719183114.GB2812@kernel.org>
References: <20180719143345.12963-1-jolsa@kernel.org>
 <20180719143345.12963-5-jolsa@kernel.org>
 <20180719182843.GA2812@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180719182843.GA2812@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jul 19, 2018 at 03:28:43PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Thu, Jul 19, 2018 at 04:33:45PM +0200, Jiri Olsa escreveu:
> > +++ b/tools/perf/util/comm.c
> > @@ -18,11 +18,9 @@ struct comm_str {
> >  static struct rb_root comm_str_root;
> >  static struct rw_semaphore comm_str_lock = {.lock = PTHREAD_RWLOCK_INITIALIZER,};
> >  
> > -static struct comm_str *comm_str__get(struct comm_str *cs)
> > +static bool comm_str__get(struct comm_str *cs)
> >  {
> > -	if (cs)
> > -		refcount_inc(&cs->refcnt);
> > -	return cs;
> > +	return cs ? refcount_inc_not_zero(&cs->refcnt) : false;
> >  }
> 
> I don't like changing the semantics of a __get() operation this way, I
> think it should stay like all the others, i.e. return the object with
> the desired refcount or return NULL if that is not possible.
> 
> Otherwise we'll have to switch gears when debugging refcounts in various
> objects, that start having slightly different semantics for reference
> counting.
> 
> We should try to find a fix that maintains the semantics of refcounting.

After looking at the code, this refcount_inc_not_zero returns bool comes
from the kernel, trying to see how this is used with __get() operations
there, if at all.

- Arnaldo
