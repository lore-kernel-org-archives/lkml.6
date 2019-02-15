Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DA5C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 527952082F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:09:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388415AbfBOSJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 13:09:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33116 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387853AbfBOSJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 13:09:22 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8B0DD1219DB;
        Fri, 15 Feb 2019 18:09:21 +0000 (UTC)
Received: from sandy.ghostprotocols.net (ovpn-112-20.phx2.redhat.com [10.3.112.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 795395D6A9;
        Fri, 15 Feb 2019 18:09:20 +0000 (UTC)
Received: by sandy.ghostprotocols.net (Postfix, from userid 1000)
        id 8E65555CD; Fri, 15 Feb 2019 16:09:16 -0200 (BRST)
Date:   Fri, 15 Feb 2019 16:09:16 -0200
From:   Arnaldo Carvalho de Melo <acme@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     Netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>
Subject: Re: [PATCH v2 perf,bpf 11/11] perf, bpf: save information about
 short living bpf programs
Message-ID: <20190215180916.GJ5784@redhat.com>
References: <20190214235624.2579307-1-songliubraving@fb.com>
 <20190215000045.2592135-1-songliubraving@fb.com>
 <20190215000045.2592135-2-songliubraving@fb.com>
 <20190215144146.GF5784@redhat.com>
 <62DB92A4-F708-4E89-B668-4EAFD0FA6731@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62DB92A4-F708-4E89-B668-4EAFD0FA6731@fb.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 15 Feb 2019 18:09:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Feb 15, 2019 at 05:13:01PM +0000, Song Liu escreveu:
> > On Feb 15, 2019, at 6:41 AM, Arnaldo Carvalho de Melo <acme@redhat.com> wrote:
> > Em Thu, Feb 14, 2019 at 04:00:45PM -0800, Song Liu escreveu:
> >> +pthread_t poll_thread;
> >> +
> >> +int bpf_event__start_polling_thread(struct bpf_event_poll_args *args)
> >> +{
> >> +	struct perf_evsel *counter;
> >> +
> >> +	args->evlist = perf_evlist__new();
> >> +
> >> +	if (args->evlist == NULL)
> >> +		return -1;
> >> +
> >> +	if (perf_evlist__create_maps(args->evlist, args->target))
> > 		goto out_delete_evlist;
> >> +
> >> +	if (perf_evlist__add_bpf_tracker(args->evlist))
> > 		goto out_delete_evlist;
> >> +
> >> +	evlist__for_each_entry(args->evlist, counter) {
> >> +		if (perf_evsel__open(counter, args->evlist->cpus,
> >> +				     args->evlist->threads) < 0)
> > 			goto out_delete_evlist;
> >> +	}
> >> +
> >> +	if (perf_evlist__mmap(args->evlist, UINT_MAX))
> > 		goto out_delete_evlist;
> >> +
> >> +	evlist__for_each_entry(args->evlist, counter) {
> >> +		if (perf_evsel__enable(counter))
> > 			goto out_delete_evlist;
> >> +	}
> >> +
> >> +	if (pthread_create(&poll_thread, NULL, bpf_poll_thread, args))
> > 		goto out_delete_evlist;	
> >> +
> >> +	return 0;
> > out_delete_evlist:
> > 	perf_evlist__delete(args->evlist);
> > 	args->evlist = NULL;

Have you seen the error handling suggestion above?

> >> +int perf_evlist__add_bpf_tracker(struct perf_evlist *evlist)
> >> +{
> >> +	struct perf_event_attr attr = {
> >> +		.type	          = PERF_TYPE_SOFTWARE,
> >> +		.config           = PERF_COUNT_SW_DUMMY,
> >> +		.watermark        = 1,
> >> +		.bpf_event        = 1,
> >> +		.wakeup_watermark = 1,
> >> +		.size	   = sizeof(attr), /* to capture ABI version */
> >> +	};
> >> +	struct perf_evsel *evsel = perf_evsel__new_idx(&attr,
> >> +						       evlist->nr_entries);
> >> +
> >> +	if (evsel == NULL)
> >> +		return -ENOMEM;
> >> +
> >> +	perf_evlist__add(evlist, evsel);

> > You could use:
 
> > 	struct perf_evlist *evlist = perf_evlist__new_dummy();
> > 	if (evlist != NULL) {
> > 		struct perf_evsel *evsel == perf_evlist__first(evlist);
> > 		evsel->attr.bpf_event = evsel->attr.watermark = evsel->attr.wakeup_watermark = 1;
> > 		return 0;
> > 	}
> > 	return -1;
 
> This looks cleaner. Let me fix in next version. 

> > Because in this case all you'll have in this evlist is the bpf tracker,
> > right? The add_bpf_tracker would be handy if we would want to have a
> > pre-existing evlist with some other events and wanted to add a bpf
> > tracker, no?

> I think all we need is a side-band evlist instead of the main evlist. May
> be we should call it side-band evlist, and make it more generic?

Sure, you could for instance have something like:

	struct perf_event_attr attr = {
		.watermark        = 1,
		.bpf_event        = 1,
		.wakeup_watermark = 1,
	}
 	struct perf_evlist *evlist = perf_evlist__new_side_band(&attr);


And the other details will be set by it, i.e. the .config

	.type	          = PERF_TYPE_SOFTWARE,
	.config           = PERF_COUNT_SW_DUMMY,
	.size	   = sizeof(attr), /* to capture ABI version */

And the idx arg.

- Arnaldo
