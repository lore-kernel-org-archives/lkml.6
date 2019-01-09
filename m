Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79116C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5279920821
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:15:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730223AbfAIJPY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 04:15:24 -0500
Received: from mga18.intel.com ([134.134.136.126]:62032 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727387AbfAIJPX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 04:15:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2019 01:15:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,456,1539673200"; 
   d="scan'208";a="308838252"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 09 Jan 2019 01:15:22 -0800
Received: from [10.125.252.236] (abudanko-mobl.ccr.corp.intel.com [10.125.252.236])
        by linux.intel.com (Postfix) with ESMTP id 6113758056F;
        Wed,  9 Jan 2019 01:15:20 -0800 (PST)
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [PATCH v2 4/4] perf record: implement --affinity=node|cpu option
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <e8fccb5e-31b7-b3a0-74bf-490c2d439ab4@linux.intel.com>
 <b94a028a-131b-3b5c-1158-3f2d26ffb84d@linux.intel.com>
 <20190101213918.GC13760@krava>
Organization: Intel Corp.
Message-ID: <58fb01b1-a522-3d2f-58fd-aaa975a49d84@linux.intel.com>
Date:   Wed, 9 Jan 2019 12:15:19 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190101213918.GC13760@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 02.01.2019 0:39, Jiri Olsa wrote:
> On Mon, Dec 24, 2018 at 03:28:33PM +0300, Alexey Budankov wrote:
>>
>> Implement --affinity=node|cpu option for the record mode defaulting
>> to system affinity mask bouncing.
>>
>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
>> ---
>>  tools/perf/Documentation/perf-record.txt |  5 +++++
>>  tools/perf/builtin-record.c              | 18 ++++++++++++++++++
>>  2 files changed, 23 insertions(+)
>>
>> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
>> index d232b13ea713..efb839784f32 100644
>> --- a/tools/perf/Documentation/perf-record.txt
>> +++ b/tools/perf/Documentation/perf-record.txt
>> @@ -440,6 +440,11 @@ Use <n> control blocks in asynchronous (Posix AIO) trace writing mode (default:
>>  Asynchronous mode is supported only when linking Perf tool with libc library
>>  providing implementation for Posix AIO API.
>>  
>> +--affinity=mode::
>> +Set affinity mask of trace reading thread according to the policy defined by 'mode' value:
>> +  node - thread affinity mask is set to NUMA node cpu mask of the processed mmap buffer
>> +  cpu  - thread affinity mask is set to cpu of the processed mmap buffer
>> +
>>  --all-kernel::
>>  Configure all used events to run in kernel space.
>>  
>> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
>> index eea96794ee45..57dc3a45d16f 100644
>> --- a/tools/perf/builtin-record.c
>> +++ b/tools/perf/builtin-record.c
>> @@ -1653,6 +1653,21 @@ static int parse_clockid(const struct option *opt, const char *str, int unset)
>>  	ui__warning("unknown clockid %s, check man page\n", ostr);
>>  	return -1;
>>  }
>> +static int record__parse_affinity(const struct option *opt, const char *str, int unset)
>> +{
>> +	struct record_opts *opts = (struct record_opts *)opt->value;
>> +
>> +	if (!unset) {
>> +		if (str) {
>> +			if (!strcasecmp(str, "node"))
>> +				opts->affinity = PERF_AFFINITY_NODE;
>> +			else if (!strcasecmp(str, "cpu"))
>> +				opts->affinity = PERF_AFFINITY_CPU;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>>  
>>  static int record__parse_mmap_pages(const struct option *opt,
>>  				    const char *str,
>> @@ -1961,6 +1976,9 @@ static struct option __record_options[] = {
>>  		     &nr_cblocks_default, "n", "Use <n> control blocks in asynchronous trace writing mode (default: 1, max: 4)",
>>  		     record__aio_parse),
>>  #endif
>> +	OPT_CALLBACK(0, "affinity", &record.opts, "node|cpu",
>> +		     "Set affinity mask of trace reading thread to NUMA node cpu mask or cpu of processed mmap buffer",
>> +		     record__parse_affinity),
> 
> so this makes sense only when there's --aio and LIBNUMA
> in place.. we should check for those and allow this only
> for these

Serial trace streaming also benefits from that.

Thanks,
Alexey

> 
> jirka
> 
