Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 530B7C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 03:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0879C2086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 03:42:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0879C2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbeK0Ois (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 09:38:48 -0500
Received: from mga05.intel.com ([192.55.52.43]:29176 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727571AbeK0Ois (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 09:38:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Nov 2018 19:42:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,285,1539673200"; 
   d="scan'208";a="253066293"
Received: from yjin15-mobl.ccr.corp.intel.com (HELO [10.239.161.30]) ([10.239.161.30])
  by orsmga004.jf.intel.com with ESMTP; 26 Nov 2018 19:42:17 -0800
Subject: Re: [PATCH 2/2] perf report: Display average IPC and IPC coverage per
 symbol
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <1543225254-5858-1-git-send-email-yao.jin@linux.intel.com>
 <1543225254-5858-3-git-send-email-yao.jin@linux.intel.com>
 <20181126095537.GC18780@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <bda91905-c08a-87e0-e49c-27eeaf9b711d@linux.intel.com>
Date:   Tue, 27 Nov 2018 11:42:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181126095537.GC18780@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/26/2018 5:55 PM, Jiri Olsa wrote:
> On Mon, Nov 26, 2018 at 05:40:54PM +0800, Jin Yao wrote:
> 
> SNIP
> 
>> diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
>> index f96c005..94f62c8 100644
>> --- a/tools/perf/util/sort.c
>> +++ b/tools/perf/util/sort.c
>> @@ -13,6 +13,7 @@
>>   #include "strlist.h"
>>   #include <traceevent/event-parse.h>
>>   #include "mem-events.h"
>> +#include "annotate.h"
>>   #include <linux/kernel.h>
>>   
>>   regex_t		parent_regex;
>> @@ -422,6 +423,47 @@ struct sort_entry sort_srcline_to = {
>>   	.se_width_idx	= HISTC_SRCLINE_TO,
>>   };
>>   
>> +static int hist_entry__sym_ipc_snprintf(struct hist_entry *he, char *bf,
>> +					size_t size, unsigned int width)
>> +{
>> +
>> +	struct symbol *sym = he->ms.sym;
>> +	struct map *map = he->ms.map;
>> +	struct perf_evsel *evsel = hists_to_evsel(he->hists);
>> +	struct annotation *notes;
>> +	double ipc = 0.0, coverage = 0.0;
>> +	char tmp[64];
>> +
>> +	if (!sym)
>> +		return repsep_snprintf(bf, size, "%-*s", width, "-");
>> +
>> +	if (!sym->annotated &&
>> +	    symbol__annotate2(sym, map, evsel, &annotation__default_options,
>> +			      NULL) < 0) {
>> +		return 0;
>> +	}
> 
> this seems to make the sorting extra long, would you
> please consider progress bar update for this?
> 
> should be added somewhere around hists sorting code
> 

Hi Jiri,

Sorting doesn't take long time in my test but the session event 
processing takes some time.

I just think maybe we need a new ops for stdio progress bar like what 
the tui_progress__ops does now. That should be benefit for all stdio usages.

That may be another separate patch-set.

Thanks
Jin Yao

> thanks,
> jirka
> 
