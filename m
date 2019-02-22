Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E6FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 02:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9FA3207E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 02:38:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbfBVCiO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 21:38:14 -0500
Received: from mail5.windriver.com ([192.103.53.11]:57630 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725961AbfBVCiN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 21:38:13 -0500
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x1M2ZEo0020727
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Thu, 21 Feb 2019 18:35:44 -0800
Received: from [128.224.155.96] (128.224.155.96) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.435.0; Thu, 21 Feb
 2019 18:35:19 -0800
Subject: Re: [PATCH] perf record: Add support for limit perf output file size
To:     Jiri Olsa <jolsa@redhat.com>
References: <20190221064419.6166-1-jiwei.sun@windriver.com>
 <20190221095623.GE10990@krava>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <namhyung@kernel.org>,
        <ast@kernel.org>, <daniel@iogearbox.net>, <kafai@fb.com>,
        <songliubraving@fb.com>, <yhs@fb.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
From:   Jiwei Sun <Jiwei.Sun@windriver.com>
Message-ID: <0f611580-6ff7-f9cb-e7c0-511acbdb9f62@windriver.com>
Date:   Fri, 22 Feb 2019 10:34:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20190221095623.GE10990@krava>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [128.224.155.96]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jirka,

On 02/21/2019 05:56 PM, Jiri Olsa wrote:
> On Thu, Feb 21, 2019 at 02:44:19PM +0800, Jiwei Sun wrote:
>> The patch adds a new option to limit the output file size, then based
>> on it, we can create a wrapper of the perf command that uses the option
>> to avoid exhausting the disk space by the unconscious user.
>>
>> Signed-off-by: Jiwei Sun <jiwei.sun@windriver.com>
>> ---
>>  tools/perf/builtin-record.c | 39 +++++++++++++++++++++++++++++++++++++
>>  1 file changed, 39 insertions(+)
>>
>> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
>> index 882285fb9f64..28a03929166d 100644
>> --- a/tools/perf/builtin-record.c
>> +++ b/tools/perf/builtin-record.c
>> @@ -81,6 +81,7 @@ struct record {
>>  	bool			timestamp_boundary;
>>  	struct switch_output	switch_output;
>>  	unsigned long long	samples;
>> +	unsigned long		output_max_size;	/* = 0: unlimited */
> 
> please rebase to latest Arnaldo's perf/core,
> there are new fields in here now

OK, thanks for your response, and I will send a v2 patch based on the branch perf/core.

> 
>>  };
>>  
>>  static volatile int auxtrace_record__snapshot_started;
>> @@ -106,6 +107,12 @@ static bool switch_output_time(struct record *rec)
>>  	       trigger_is_ready(&switch_output_trigger);
>>  }
>>  
>> +static bool record__output_max_size_exceeded(struct record *rec)
>> +{
>> +	return (rec->output_max_size &&
>> +			rec->bytes_written >= rec->output_max_size);
>> +}
>> +
>>  static int record__write(struct record *rec, struct perf_mmap *map __maybe_unused,
>>  			 void *bf, size_t size)
>>  {
>> @@ -118,6 +125,9 @@ static int record__write(struct record *rec, struct perf_mmap *map __maybe_unuse
>>  
>>  	rec->bytes_written += size;
>>  
>> +	if (record__output_max_size_exceeded(rec))
>> +		raise(SIGTERM);
> 
> perhaps display some message saying we reached the limit
> 
> other than that looks good to me

OK, I will add some warning message in the v2 patch.

Thanks,
Regards,
Jiwei

> 
> thanks,
> jirka
> 
> 
>> +
>>  	if (switch_output_size(rec))
>>  		trigger_hit(&switch_output_trigger);
>>  
>> @@ -1639,6 +1649,33 @@ static int parse_clockid(const struct option *opt, const char *str, int unset)
>>  	return -1;
>>  }
>>  
>> +static int parse_output_max_size(const struct option *opt, const char *str,
>> +				 int unset)
>> +{
>> +	unsigned long *s = (unsigned long *)opt->value;
>> +	static struct parse_tag tags_size[] = {
>> +		{ .tag  = 'B', .mult = 1       },
>> +		{ .tag  = 'K', .mult = 1 << 10 },
>> +		{ .tag  = 'M', .mult = 1 << 20 },
>> +		{ .tag  = 'G', .mult = 1 << 30 },
>> +		{ .tag  = 0 },
>> +	};
>> +	unsigned long val;
>> +
>> +	if (unset) {
>> +		*s = 0;
>> +		return 0;
>> +	}
>> +
>> +	val = parse_tag_value(str, tags_size);
>> +	if (val != (unsigned long) -1) {
>> +		*s = val;
>> +		return 0;
>> +	}
>> +
>> +	return -1;
>> +}
>> +
>>  static int record__parse_mmap_pages(const struct option *opt,
>>  				    const char *str,
>>  				    int unset __maybe_unused)
>> @@ -1946,6 +1983,8 @@ static struct option __record_options[] = {
>>  		     &nr_cblocks_default, "n", "Use <n> control blocks in asynchronous trace writing mode (default: 1, max: 4)",
>>  		     record__aio_parse),
>>  #endif
>> +	OPT_CALLBACK(0, "output-max-size", &record.output_max_size,
>> +		     "size", "Output file maximum size", parse_output_max_size),
>>  	OPT_END()
>>  };
>>  
>> -- 
>> 2.20.1
>>
> 
