Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1AC4ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 11:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FCF52147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 11:31:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FCF52147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbeIQQ62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 12:58:28 -0400
Received: from lgeamrelo11.lge.com ([156.147.23.51]:56729 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727134AbeIQQ61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 12:58:27 -0400
Received: from unknown (HELO lgeamrelo01.lge.com) (156.147.1.125)
        by 156.147.23.51 with ESMTP; 17 Sep 2018 20:31:31 +0900
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: namhyung@kernel.org
Received: from unknown (HELO sejong) (10.177.227.17)
        by 156.147.1.125 with ESMTP; 17 Sep 2018 20:31:31 +0900
X-Original-SENDERIP: 10.177.227.17
X-Original-MAILFROM: namhyung@kernel.org
Date:   Mon, 17 Sep 2018 20:31:31 +0900
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
Subject: Re: [PATCH 39/48] perf record: Move waking into struct record
Message-ID: <20180917113131.GD18395@sejong>
References: <20180913125450.21342-1-jolsa@kernel.org>
 <20180913125450.21342-40-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180913125450.21342-40-jolsa@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 02:54:41PM +0200, Jiri Olsa wrote:
> We need to keep global number of 'waking' now.
> 
> TODO: make this multiple threads safe.

Why not using atomic APIs?

Thanks,
Namhyung


> 
> Link: http://lkml.kernel.org/n/tip-veetgk62aisdt1cxaa6fbgox@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/builtin-record.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index d6fef646b67f..62ff4411ce39 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -94,6 +94,7 @@ struct record {
>  	unsigned long long	samples;
>  	struct record_thread	*threads;
>  	int			threads_cnt;
> +	unsigned long		waking;
>  };
>  
>  static __thread struct record_thread *thread;
> @@ -1143,7 +1144,6 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  {
>  	int err;
>  	int status = 0;
> -	unsigned long waking = 0;
>  	const bool forks = argc > 0;
>  	struct perf_tool *tool = &rec->tool;
>  	struct record_opts *opts = &rec->opts;
> @@ -1400,8 +1400,8 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  
>  			if (!quiet)
>  				fprintf(stderr, "[ perf record: dump data: Woken up %ld times ]\n",
> -					waking);
> -			waking = 0;
> +					rec->waking);
> +			rec->waking = 0;
>  			fd = record__switch_output(rec, false);
>  			if (fd < 0) {
>  				pr_err("Failed to switch to new file\n");
> @@ -1425,7 +1425,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  			 */
>  			if (err > 0 || (err < 0 && errno == EINTR))
>  				err = 0;
> -			waking++;
> +			rec->waking++;
>  
>  			if (perf_evlist__filter_pollfd(rec->evlist, POLLERR | POLLHUP) == 0)
>  				draining = true;
> @@ -1454,7 +1454,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  	}
>  
>  	if (!quiet)
> -		fprintf(stderr, "[ perf record: Woken up %ld times to write data ]\n", waking);
> +		fprintf(stderr, "[ perf record: Woken up %ld times to write data ]\n", rec->waking);
>  
>  	if (target__none(&rec->opts.target))
>  		record__synthesize_workload(rec, true);
> -- 
> 2.17.1
> 
