Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B662C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 13:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27B79218DE
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 13:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546436606;
	bh=EXVLsjJndhhREKVRe7zUPO1uhd6Jb/krnDkMBUNq/kI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=l2oaj/uBGhQQkuCuYIMiF/kO96ZcPg3qGzOSQhKDgM7xgLC6Avc1bJDIbPyeSi7rF
	 lPrTZ+CqO5awY+I8jdd9grW1vGuiETtIQi0q7OIE2/BSGi98XkgqOLO90DLqLkl+0v
	 cDyfl3bToDa5RLCx30bRr29gxb2FcePIreb0C0oQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729949AbfABNnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 08:43:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:40600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729553AbfABNnY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 08:43:24 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C83FC218DE;
        Wed,  2 Jan 2019 13:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546436604;
        bh=EXVLsjJndhhREKVRe7zUPO1uhd6Jb/krnDkMBUNq/kI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CA31iYYQwRKqUpAng2oQixM6tRzre0C41gQmlcrq9zLl5+aqjKj9BuHh+l8oxjPb8
         RZg5IaQsJIlEn601++2w3CGy3OvVxhPW93nzvq9apNK1YYWSD8RGpuhED0MV7/tTZG
         +he/FaCl0tNGuAIkSNAW7DqzoAhFQf/Bn/XzwlSg=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C2D9040F61; Wed,  2 Jan 2019 10:43:20 -0300 (-03)
Date:   Wed, 2 Jan 2019 10:43:20 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] perf thread-stack: Allocate an array of thread stacks
Message-ID: <20190102134320.GA15460@kernel.org>
References: <20181221120620.9659-1-adrian.hunter@intel.com>
 <20181221120620.9659-7-adrian.hunter@intel.com>
 <20190101182852.GA13760@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190101182852.GA13760@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jan 01, 2019 at 07:28:52PM +0100, Jiri Olsa escreveu:
> On Fri, Dec 21, 2018 at 02:06:18PM +0200, Adrian Hunter wrote:
> > In preparation for fixing thread stack processing for the idle task,
> > allocate an array of thread stacks.
> > 
> > Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> > ---
> >  tools/perf/util/thread-stack.c | 30 ++++++++++++++++++------------
> >  1 file changed, 18 insertions(+), 12 deletions(-)
> > 
> > diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
> > index 4340381d54c2..a896d89fe5f7 100644
> > --- a/tools/perf/util/thread-stack.c
> > +++ b/tools/perf/util/thread-stack.c
> > @@ -114,20 +114,26 @@ static int thread_stack__init(struct thread_stack *ts, struct thread *thread,
> >  static struct thread_stack *thread_stack__new(struct thread *thread,
> >  					      struct call_return_processor *crp)
> >  {
> > -	struct thread_stack *ts;
> > -
> > -	ts = zalloc(sizeof(struct thread_stack));
> > -	if (!ts)
> > -		return NULL;
> > -
> > -	ts->arr_sz = 1;
> > -
> > -	if (thread_stack__init(ts, thread, crp)) {
> > -		free(ts);
> > -		return NULL;
> > +	struct thread_stack *ts = thread->ts, *new_ts;
> > +	unsigned int old_sz = ts ? ts->arr_sz : 0;
> > +	unsigned int new_sz = 1;
> > +
> > +	if (!ts || new_sz > old_sz) {
> > +		new_ts = calloc(new_sz, sizeof(*ts));
> > +		if (!new_ts)
> > +			return NULL;
> > +		if (ts)
> > +			memcpy(new_ts, ts, old_sz * sizeof(*ts));
> > +		new_ts->arr_sz = new_sz;
> > +		if (thread->ts)
> > +			zfree(&thread->ts);
> 
> you don't need to check for thread->ts,
> anyway it looks all good, for the patchset:
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

I'll fix that when merging, which I'm now doing.

Thanks,

- Arnaldo
