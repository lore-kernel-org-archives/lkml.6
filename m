Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753852AbeCFOWX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 09:22:23 -0500
Received: from mga09.intel.com ([134.134.136.24]:19664 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753553AbeCFOWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 09:22:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,431,1515484800";
   d="scan'208";a="25639580"
Subject: Re: [PATCH 2/7] perf auxtrace: Prevent decoding when --no-itrace
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
References: <1520327598-1317-1-git-send-email-adrian.hunter@intel.com>
 <1520327598-1317-3-git-send-email-adrian.hunter@intel.com>
 <20180306140624.GE10176@kernel.org>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <8c596a3a-de1e-1d39-17b4-ae5db7543f7f@intel.com>
Date: Tue, 6 Mar 2018 16:21:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180306140624.GE10176@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/03/18 16:06, Arnaldo Carvalho de Melo wrote:
> Em Tue, Mar 06, 2018 at 11:13:13AM +0200, Adrian Hunter escreveu:
>> Prevent auxtrace_queues__process_index() from queuing AUX area data for
>> decoding when the --no-itrace option has been used.
> 
> So I'm putting this one both on perf/urgent and on perf/core, the rest
> just on perf/core, ok?

Yes, thank you!

Have you got this one also:

	https://marc.info/?l=linux-kernel&m=151980982703990

> 
> - Arnaldo
>  
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>> ---
>>  tools/perf/util/auxtrace.c | 15 +++++++++------
>>  1 file changed, 9 insertions(+), 6 deletions(-)
>>
>> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
>> index 9faf3b5367db..6470ea2aa25e 100644
>> --- a/tools/perf/util/auxtrace.c
>> +++ b/tools/perf/util/auxtrace.c
>> @@ -60,6 +60,12 @@
>>  #include "sane_ctype.h"
>>  #include "symbol/kallsyms.h"
>>  
>> +static bool auxtrace__dont_decode(struct perf_session *session)
>> +{
>> +	return !session->itrace_synth_opts ||
>> +	       session->itrace_synth_opts->dont_decode;
>> +}
>> +
>>  int auxtrace_mmap__mmap(struct auxtrace_mmap *mm,
>>  			struct auxtrace_mmap_params *mp,
>>  			void *userpg, int fd)
>> @@ -762,6 +768,9 @@ int auxtrace_queues__process_index(struct auxtrace_queues *queues,
>>  	size_t i;
>>  	int err;
>>  
>> +	if (auxtrace__dont_decode(session))
>> +		return 0;
>> +
>>  	list_for_each_entry(auxtrace_index, &session->auxtrace_index, list) {
>>  		for (i = 0; i < auxtrace_index->nr; i++) {
>>  			ent = &auxtrace_index->entries[i];
>> @@ -892,12 +901,6 @@ int perf_event__synthesize_auxtrace_info(struct auxtrace_record *itr,
>>  	return err;
>>  }
>>  
>> -static bool auxtrace__dont_decode(struct perf_session *session)
>> -{
>> -	return !session->itrace_synth_opts ||
>> -	       session->itrace_synth_opts->dont_decode;
>> -}
>> -
>>  int perf_event__process_auxtrace_info(struct perf_tool *tool __maybe_unused,
>>  				      union perf_event *event,
>>  				      struct perf_session *session)
>> -- 
>> 1.9.1
> 
