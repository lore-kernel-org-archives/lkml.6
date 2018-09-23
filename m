Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9658ECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 19:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B9AC21477
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 19:31:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B9AC21477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbeIXBaY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 21:30:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47916 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbeIXBaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 21:30:23 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5821F308624F;
        Sun, 23 Sep 2018 19:31:49 +0000 (UTC)
Received: from krava (ovpn-204-66.brq.redhat.com [10.40.204.66])
        by smtp.corp.redhat.com (Postfix) with SMTP id 53BFE1001F4A;
        Sun, 23 Sep 2018 19:31:46 +0000 (UTC)
Date:   Sun, 23 Sep 2018 21:31:45 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        kernel-team@lge.com
Subject: Re: [PATCH 37/48] perf record: Introduce struct record_thread
Message-ID: <20180923193145.GE30923@krava>
References: <20180913125450.21342-1-jolsa@kernel.org>
 <20180913125450.21342-38-jolsa@kernel.org>
 <20180917112615.GB18395@sejong>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180917112615.GB18395@sejong>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Sun, 23 Sep 2018 19:31:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 08:26:15PM +0900, Namhyung Kim wrote:
> Hi Jiri,
> 
> On Thu, Sep 13, 2018 at 02:54:39PM +0200, Jiri Olsa wrote:
> > Adding struct record_thread to carry the single thread's maps.
> > 
> > Link: http://lkml.kernel.org/n/tip-dsyi97xdc7ullvsisqmha0ca@git.kernel.org
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/perf/builtin-record.c | 179 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 179 insertions(+)
> > 
> > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > index 1b01cb4d06b8..5c6b56f164a9 100644
> > --- a/tools/perf/builtin-record.c
> > +++ b/tools/perf/builtin-record.c
> > @@ -65,6 +65,15 @@ struct switch_output {
> >  	bool		 set;
> >  };
> >  
> > +struct record_thread {
> > +	struct perf_mmap	**mmap;
> > +	int			  mmap_nr;
> > +	struct perf_mmap	**ovw_mmap;
> > +	int			  ovw_mmap_nr;
> > +	struct fdarray		  pollfd;
> > +	struct record		 *rec;
> > +};
> > +
> >  struct record {
> >  	struct perf_tool	tool;
> >  	struct record_opts	opts;
> > @@ -83,6 +92,8 @@ struct record {
> >  	bool			timestamp_boundary;
> >  	struct switch_output	switch_output;
> >  	unsigned long long	samples;
> > +	struct record_thread	*threads;
> > +	int			threads_cnt;
> >  };
> >  
> >  static volatile int auxtrace_record__snapshot_started;
> > @@ -967,6 +978,166 @@ static int record__synthesize(struct record *rec, bool tail)
> >  	return err;
> >  }
> >  
> > +static void
> > +record_thread__clean(struct record_thread *th)
> > +{
> > +	free(th->mmap);
> > +	free(th->ovw_mmap);
> > +}
> > +
> > +static void
> > +record__threads_clean(struct record *rec)
> > +{
> > +	struct record_thread *threads = rec->threads;
> > +	int i;
> > +
> > +	if (threads) {
> > +		for (i = 0; i < rec->threads_cnt; i++)
> > +			record_thread__clean(threads + i);
> > +	}
> > +}
> > +
> > +static void record_thread__init(struct record_thread *th, struct record *rec)
> > +{
> > +	memset(th, 0, sizeof(*th));
> > +	fdarray__init(&th->pollfd, 64);
> > +	th->rec = rec;
> > +}
> > +
> > +static int
> > +record_thread__mmap(struct record_thread *th, int nr, int nr_ovw)
> > +{
> > +	struct perf_mmap **mmap;
> > +
> > +	mmap = zalloc(sizeof(*mmap) * nr);
> > +	if (!mmap)
> > +		return -ENOMEM;
> > +
> > +	th->mmap    = mmap;
> > +	th->mmap_nr = nr;
> > +
> > +	if (nr_ovw) {
> > +		mmap = zalloc(sizeof(*mmap) * nr_ovw);
> > +		if (!mmap)
> > +			return -ENOMEM;
> > +
> > +		th->ovw_mmap    = mmap;
> > +		th->ovw_mmap_nr = nr;
> 
> s/nr;/nr_ovw;/ ?

right, thanks

> 
> 
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int
> > +record__threads_assign(struct record *rec)
> > +{
> > +	struct record_thread *threads = rec->threads;
> > +	struct record_thread *thread0 = threads;
> > +	struct perf_evlist *evlist = rec->evlist;
> > +	int i, j, nr, nr0, nr_ovw, nr_trk;
> > +	int ret = -ENOMEM;
> > +
> > +	nr     = evlist->mmap           ? evlist->nr_mmaps : 0;
> > +	nr_trk = evlist->track_mmap     ? evlist->nr_mmaps : 0;
> > +	nr_ovw = evlist->overwrite_mmap ? evlist->nr_mmaps : 0;
> > +
> > +	nr0  = nr_trk;
> > +	nr0 += nr;
> > +
> > +	if (record_thread__mmap(thread0, nr0, nr_ovw))
> > +		goto out_error;
> > +
> > +	for (i = 0; i < nr_ovw; i++)
> > +		thread0->ovw_mmap[i] = &evlist->overwrite_mmap[i];
> > +
> > +	for (i = 0; i < nr_trk; i++)
> > +		thread0->mmap[i] = &evlist->track_mmap[i];
> > +
> > +	for (j = 0; i < nr0 && j < nr; i++, j++)
> > +		thread0->mmap[i] = &evlist->mmap[j];
> 
> I'm not sure it'll work with the overwrite mmap well..

as you said in the later email, there's no support
for threads and overwrite mode

thanks,
jirka
