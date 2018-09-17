Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35194ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 11:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB123214D5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 11:26:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB123214D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbeIQQxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 12:53:21 -0400
Received: from lgeamrelo13.lge.com ([156.147.23.53]:52874 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726824AbeIQQxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 12:53:21 -0400
Received: from unknown (HELO lgeamrelo02.lge.com) (156.147.1.126)
        by 156.147.23.53 with ESMTP; 17 Sep 2018 20:26:16 +0900
X-Original-SENDERIP: 156.147.1.126
X-Original-MAILFROM: namhyung@kernel.org
Received: from unknown (HELO sejong) (10.177.227.17)
        by 156.147.1.126 with ESMTP; 17 Sep 2018 20:26:16 +0900
X-Original-SENDERIP: 10.177.227.17
X-Original-MAILFROM: namhyung@kernel.org
Date:   Mon, 17 Sep 2018 20:26:15 +0900
From:   Namhyung Kim <namhyung@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        kernel-team@lge.com
Subject: Re: [PATCH 37/48] perf record: Introduce struct record_thread
Message-ID: <20180917112615.GB18395@sejong>
References: <20180913125450.21342-1-jolsa@kernel.org>
 <20180913125450.21342-38-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180913125450.21342-38-jolsa@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On Thu, Sep 13, 2018 at 02:54:39PM +0200, Jiri Olsa wrote:
> Adding struct record_thread to carry the single thread's maps.
> 
> Link: http://lkml.kernel.org/n/tip-dsyi97xdc7ullvsisqmha0ca@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/builtin-record.c | 179 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 179 insertions(+)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 1b01cb4d06b8..5c6b56f164a9 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -65,6 +65,15 @@ struct switch_output {
>  	bool		 set;
>  };
>  
> +struct record_thread {
> +	struct perf_mmap	**mmap;
> +	int			  mmap_nr;
> +	struct perf_mmap	**ovw_mmap;
> +	int			  ovw_mmap_nr;
> +	struct fdarray		  pollfd;
> +	struct record		 *rec;
> +};
> +
>  struct record {
>  	struct perf_tool	tool;
>  	struct record_opts	opts;
> @@ -83,6 +92,8 @@ struct record {
>  	bool			timestamp_boundary;
>  	struct switch_output	switch_output;
>  	unsigned long long	samples;
> +	struct record_thread	*threads;
> +	int			threads_cnt;
>  };
>  
>  static volatile int auxtrace_record__snapshot_started;
> @@ -967,6 +978,166 @@ static int record__synthesize(struct record *rec, bool tail)
>  	return err;
>  }
>  
> +static void
> +record_thread__clean(struct record_thread *th)
> +{
> +	free(th->mmap);
> +	free(th->ovw_mmap);
> +}
> +
> +static void
> +record__threads_clean(struct record *rec)
> +{
> +	struct record_thread *threads = rec->threads;
> +	int i;
> +
> +	if (threads) {
> +		for (i = 0; i < rec->threads_cnt; i++)
> +			record_thread__clean(threads + i);
> +	}
> +}
> +
> +static void record_thread__init(struct record_thread *th, struct record *rec)
> +{
> +	memset(th, 0, sizeof(*th));
> +	fdarray__init(&th->pollfd, 64);
> +	th->rec = rec;
> +}
> +
> +static int
> +record_thread__mmap(struct record_thread *th, int nr, int nr_ovw)
> +{
> +	struct perf_mmap **mmap;
> +
> +	mmap = zalloc(sizeof(*mmap) * nr);
> +	if (!mmap)
> +		return -ENOMEM;
> +
> +	th->mmap    = mmap;
> +	th->mmap_nr = nr;
> +
> +	if (nr_ovw) {
> +		mmap = zalloc(sizeof(*mmap) * nr_ovw);
> +		if (!mmap)
> +			return -ENOMEM;
> +
> +		th->ovw_mmap    = mmap;
> +		th->ovw_mmap_nr = nr;

s/nr;/nr_ovw;/ ?


> +	}
> +
> +	return 0;
> +}
> +
> +static int
> +record__threads_assign(struct record *rec)
> +{
> +	struct record_thread *threads = rec->threads;
> +	struct record_thread *thread0 = threads;
> +	struct perf_evlist *evlist = rec->evlist;
> +	int i, j, nr, nr0, nr_ovw, nr_trk;
> +	int ret = -ENOMEM;
> +
> +	nr     = evlist->mmap           ? evlist->nr_mmaps : 0;
> +	nr_trk = evlist->track_mmap     ? evlist->nr_mmaps : 0;
> +	nr_ovw = evlist->overwrite_mmap ? evlist->nr_mmaps : 0;
> +
> +	nr0  = nr_trk;
> +	nr0 += nr;
> +
> +	if (record_thread__mmap(thread0, nr0, nr_ovw))
> +		goto out_error;
> +
> +	for (i = 0; i < nr_ovw; i++)
> +		thread0->ovw_mmap[i] = &evlist->overwrite_mmap[i];
> +
> +	for (i = 0; i < nr_trk; i++)
> +		thread0->mmap[i] = &evlist->track_mmap[i];
> +
> +	for (j = 0; i < nr0 && j < nr; i++, j++)
> +		thread0->mmap[i] = &evlist->mmap[j];

I'm not sure it'll work with the overwrite mmap well..

Thanks,
Namhyung


> +
> +	ret = 0;
> +
> +out_error:
> +	return ret;
> +}
