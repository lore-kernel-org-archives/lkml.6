Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D6C2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47CBE2148D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbfBUJ42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 04:56:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48234 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725823AbfBUJ41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 04:56:27 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0DF483082AED;
        Thu, 21 Feb 2019 09:56:27 +0000 (UTC)
Received: from krava (unknown [10.43.17.20])
        by smtp.corp.redhat.com (Postfix) with SMTP id 7D7DD27BB0;
        Thu, 21 Feb 2019 09:56:24 +0000 (UTC)
Date:   Thu, 21 Feb 2019 10:56:23 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jiwei Sun <jiwei.sun@windriver.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH] perf record: Add support for limit perf output file size
Message-ID: <20190221095623.GE10990@krava>
References: <20190221064419.6166-1-jiwei.sun@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221064419.6166-1-jiwei.sun@windriver.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Thu, 21 Feb 2019 09:56:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 02:44:19PM +0800, Jiwei Sun wrote:
> The patch adds a new option to limit the output file size, then based
> on it, we can create a wrapper of the perf command that uses the option
> to avoid exhausting the disk space by the unconscious user.
> 
> Signed-off-by: Jiwei Sun <jiwei.sun@windriver.com>
> ---
>  tools/perf/builtin-record.c | 39 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 882285fb9f64..28a03929166d 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -81,6 +81,7 @@ struct record {
>  	bool			timestamp_boundary;
>  	struct switch_output	switch_output;
>  	unsigned long long	samples;
> +	unsigned long		output_max_size;	/* = 0: unlimited */

please rebase to latest Arnaldo's perf/core,
there are new fields in here now

>  };
>  
>  static volatile int auxtrace_record__snapshot_started;
> @@ -106,6 +107,12 @@ static bool switch_output_time(struct record *rec)
>  	       trigger_is_ready(&switch_output_trigger);
>  }
>  
> +static bool record__output_max_size_exceeded(struct record *rec)
> +{
> +	return (rec->output_max_size &&
> +			rec->bytes_written >= rec->output_max_size);
> +}
> +
>  static int record__write(struct record *rec, struct perf_mmap *map __maybe_unused,
>  			 void *bf, size_t size)
>  {
> @@ -118,6 +125,9 @@ static int record__write(struct record *rec, struct perf_mmap *map __maybe_unuse
>  
>  	rec->bytes_written += size;
>  
> +	if (record__output_max_size_exceeded(rec))
> +		raise(SIGTERM);

perhaps display some message saying we reached the limit

other than that looks good to me

thanks,
jirka


> +
>  	if (switch_output_size(rec))
>  		trigger_hit(&switch_output_trigger);
>  
> @@ -1639,6 +1649,33 @@ static int parse_clockid(const struct option *opt, const char *str, int unset)
>  	return -1;
>  }
>  
> +static int parse_output_max_size(const struct option *opt, const char *str,
> +				 int unset)
> +{
> +	unsigned long *s = (unsigned long *)opt->value;
> +	static struct parse_tag tags_size[] = {
> +		{ .tag  = 'B', .mult = 1       },
> +		{ .tag  = 'K', .mult = 1 << 10 },
> +		{ .tag  = 'M', .mult = 1 << 20 },
> +		{ .tag  = 'G', .mult = 1 << 30 },
> +		{ .tag  = 0 },
> +	};
> +	unsigned long val;
> +
> +	if (unset) {
> +		*s = 0;
> +		return 0;
> +	}
> +
> +	val = parse_tag_value(str, tags_size);
> +	if (val != (unsigned long) -1) {
> +		*s = val;
> +		return 0;
> +	}
> +
> +	return -1;
> +}
> +
>  static int record__parse_mmap_pages(const struct option *opt,
>  				    const char *str,
>  				    int unset __maybe_unused)
> @@ -1946,6 +1983,8 @@ static struct option __record_options[] = {
>  		     &nr_cblocks_default, "n", "Use <n> control blocks in asynchronous trace writing mode (default: 1, max: 4)",
>  		     record__aio_parse),
>  #endif
> +	OPT_CALLBACK(0, "output-max-size", &record.output_max_size,
> +		     "size", "Output file maximum size", parse_output_max_size),
>  	OPT_END()
>  };
>  
> -- 
> 2.20.1
> 
