Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F36ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 11:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE9FC214C5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 11:37:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE9FC214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbeIQREO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 13:04:14 -0400
Received: from lgeamrelo12.lge.com ([156.147.23.52]:60177 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728137AbeIQREO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 13:04:14 -0400
Received: from unknown (HELO lgeamrelo04.lge.com) (156.147.1.127)
        by 156.147.23.52 with ESMTP; 17 Sep 2018 20:37:17 +0900
X-Original-SENDERIP: 156.147.1.127
X-Original-MAILFROM: namhyung@kernel.org
Received: from unknown (HELO sejong) (10.177.227.17)
        by 156.147.1.127 with ESMTP; 17 Sep 2018 20:37:17 +0900
X-Original-SENDERIP: 10.177.227.17
X-Original-MAILFROM: namhyung@kernel.org
Date:   Mon, 17 Sep 2018 20:37:16 +0900
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
Subject: Re: [PATCH 44/48] perf record: Add --threads option
Message-ID: <20180917113716.GE18395@sejong>
References: <20180913125450.21342-1-jolsa@kernel.org>
 <20180913125450.21342-45-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180913125450.21342-45-jolsa@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 02:54:46PM +0200, Jiri Olsa wrote:
> Allows to assign number to record::threads_cnt and thus
> to create multiple threads. At this point we don't allow
> to specify number of threads, instead we assign it number
> of evlist's mmaps to have a single thread for each.
> 
> Link: http://lkml.kernel.org/n/tip-ijl786fsk46q6g01is378a5t@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/builtin-record.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index fbca1d15b90d..ada6f795d492 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -102,6 +102,7 @@ struct record {
>  	unsigned long long	samples;
>  	struct record_thread	*threads;
>  	int			threads_cnt;
> +	bool			threads_set;
>  	int			threads_signal_cnt;
>  	pthread_mutex_t		threads_signal_mutex;
>  	pthread_cond_t		threads_signal_cond;
> @@ -1133,11 +1134,38 @@ record__threads_create(struct record *rec)
>  	return threads ? 0 : -ENOMEM;
>  }
>  
> +static int record__threads_cnt(struct record *rec)
> +{
> +	struct perf_evlist *evlist = rec->evlist;
> +	int cnt;
> +
> +	if (rec->threads_set) {
> +		if (rec->threads_cnt) {
> +			pr_err("failed: Can't specify number of threads yet.\n");
> +			return -EINVAL;
> +		}
> +		if (evlist->overwrite_mmap) {
> +			pr_err("failed: Can't use multiple threads with overwrite mmaps yet.\n");
> +			return -EINVAL;

Ah, ok.  You made it incompatible with the overwrite mode..

Thanks,
Namhyung


> +		}
> +		cnt = evlist->nr_mmaps;
> +	} else {
> +		cnt = 1;
> +	}
> +
> +	rec->threads_cnt = cnt;
> +	return 0;
> +}
> +
>  static int
>  record__threads_config(struct record *rec)
>  {
>  	int ret;
>  
> +	ret = record__threads_cnt(rec);
> +	if (ret)
> +		goto out;
> +
>  	ret = record__threads_create(rec);
>  	if (ret)
>  		goto out;
> @@ -2119,6 +2147,8 @@ static struct option __record_options[] = {
>  		    "Parse options then exit"),
>  	OPT_BOOLEAN(0, "index", &record.opts.index,
>  		    "make index for sample data to speed-up processing"),
> +	OPT_INTEGER_OPTARG_SET(0, "threads", &record.threads_cnt, &record.threads_set,
> +			       "count", "Enabled threads (count)", 0),
>  	OPT_END()
>  };
>  
> @@ -2267,6 +2297,12 @@ int cmd_record(int argc, const char **argv)
>  		goto out;
>  	}
>  
> +	/*
> +	 * Threads need index data file.
> +	 */
> +	if (record.threads_set)
> +		record.opts.index = true;
> +
>  	if (rec->opts.index) {
>  		if (!rec->opts.sample_time) {
>  			pr_err("Sample timestamp is required for indexing\n");
> -- 
> 2.17.1
> 
