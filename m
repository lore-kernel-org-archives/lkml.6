Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35C3C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 06:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E9CC20645
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 06:33:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E9CC20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbeIKLbG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 07:31:06 -0400
Received: from mga02.intel.com ([134.134.136.20]:63163 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726429AbeIKLbF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 07:31:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Sep 2018 23:33:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,359,1531810800"; 
   d="scan'208";a="84879052"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.98]) ([10.237.72.98])
  by fmsmga002.fm.intel.com with ESMTP; 10 Sep 2018 23:32:21 -0700
Subject: Re: [PATCH V2] perf tools: Fix maps__find_symbol_by_name()
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        linux-kernel@vger.kernel.org
References: <20180907085116.25782-1-adrian.hunter@intel.com>
 <20180910143444.GK5147@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <2745898f-48e0-98ec-c6d0-e7b59becc769@intel.com>
Date:   Tue, 11 Sep 2018 09:30:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180910143444.GK5147@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/09/18 17:34, Arnaldo Carvalho de Melo wrote:
> Em Fri, Sep 07, 2018 at 11:51:16AM +0300, Adrian Hunter escreveu:
>> Commit 1c5aae7710bb ("perf machine: Create maps for x86 PTI entry
>> trampolines") revealed a problem with maps__find_symbol_by_name() that
> 
> Can we have this with a Fixes: 1c5aae7710bb?
> 
> So that that, combined with the CC: stable, tells which stable kernels
> should get that fix, I think there are scripts harvesting Fixes: tags to
> help stable maintainers :-)

It seemed like potentially an existing issue so I did not want to limit how
far back it got applied.

> 
> - Arnaldo
> 
>> resulted in probes not being found e.g.
>>
>> 	$ sudo perf probe xsk_mmap
>> 	xsk_mmap is out of .text, skip it.
>> 	Probe point 'xsk_mmap' not found.
>> 	   Error: Failed to add events.
>>
>> maps__find_symbol_by_name() can optionally return the map of the found
>> symbol. It can get the map wrong because, in fact, the symbol is found
>> on the map's dso, not allowing for the possibility that the dso has more
>> than one map. Fix by always checking the map contains the symbol.
>>
>> Reported-by: Björn Töpel <bjorn.topel@intel.com>
>> Tested-by: Björn Töpel <bjorn.topel@intel.com>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>> ---
>>
>>
>> Changes in V2:
>>
>> 	Expanded commit message
>> 	Corrected email address
>>
>>
>>  tools/perf/util/map.c | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
>> index 3f07a587c8e6..354e54550d2b 100644
>> --- a/tools/perf/util/map.c
>> +++ b/tools/perf/util/map.c
>> @@ -574,6 +574,13 @@ struct symbol *map_groups__find_symbol(struct map_groups *mg,
>>  	return NULL;
>>  }
>>  
>> +static bool map__contains_symbol(struct map *map, struct symbol *sym)
>> +{
>> +	u64 ip = map->unmap_ip(map, sym->start);
>> +
>> +	return ip >= map->start && ip < map->end;
>> +}
>> +
>>  struct symbol *maps__find_symbol_by_name(struct maps *maps, const char *name,
>>  					 struct map **mapp)
>>  {
>> @@ -589,6 +596,10 @@ struct symbol *maps__find_symbol_by_name(struct maps *maps, const char *name,
>>  
>>  		if (sym == NULL)
>>  			continue;
>> +		if (!map__contains_symbol(pos, sym)) {
>> +			sym = NULL;
>> +			continue;
>> +		}
>>  		if (mapp != NULL)
>>  			*mapp = pos;
>>  		goto out;
>> -- 
>> 2.17.1
> 

