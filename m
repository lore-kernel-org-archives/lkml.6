Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39830ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 20:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03EB62086B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 20:11:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03EB62086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbeJ0EuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 00:50:17 -0400
Received: from mga12.intel.com ([192.55.52.136]:58167 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727980AbeJ0EuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 00:50:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Oct 2018 13:11:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,429,1534834800"; 
   d="scan'208";a="102830184"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 26 Oct 2018 13:11:53 -0700
Received: from [10.252.142.77] (kliang2-mobl1.ccr.corp.intel.com [10.252.142.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 6A2A3580496;
        Fri, 26 Oct 2018 13:11:52 -0700 (PDT)
Subject: Re: A concern about overflow ring buffer mode
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org,
        Wang Nan <wangnan0@huawei.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <20181026.104513.2239058788450235574.davem@davemloft.net>
 <20181026183805.GD3353@kernel.org> <20181026184255.GE3353@kernel.org>
 <20181026190211.GF3353@kernel.org>
 <3b81c999-9039-94e9-7a74-cdbd48fca08b@linux.intel.com>
 <20181026191231.GG3353@kernel.org>
 <65cbd052-15d9-f3fb-4a8f-781c3ce7a297@linux.intel.com>
 <20181026192424.GH3353@kernel.org>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <4f84468f-37d9-cf1b-12c1-514ef74b6a48@linux.intel.com>
Date:   Fri, 26 Oct 2018 16:11:51 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181026192424.GH3353@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/26/2018 3:24 PM, Arnaldo Carvalho de Melo wrote:
> Em Fri, Oct 26, 2018 at 03:16:29PM -0400, Liang, Kan escreveu:
>>
>>
>> On 10/26/2018 3:12 PM, Arnaldo Carvalho de Melo wrote:
>>> Em Fri, Oct 26, 2018 at 03:07:40PM -0400, Liang, Kan escreveu:
>>>> On 10/26/2018 3:02 PM, Arnaldo Carvalho de Melo wrote:
>>>>> So, I'm adding the following to my tree to help in diagnosing problems
>>>>> with this overwrite mode:
>>>> Actually, you can use per-event overwrite term to disable overwrite mode for
>>>> perf top.
> <SMIP>
>>> I see, it will disable that opts->overwrite if it finds the no-overwrite
>>> in the per-event definition, so the equivalent of the option I added
>>> below:
> 
>>>        perf top --no-overwrite
> 
>>> is:
> 
>>>        perf top -e cycles/no-overwrite/
> 
>>> I checked and both have the same result. But I still think there is
>>> value in having the shorter form, ok?
> 
>> Sure.
> 
> Ok.
> 
> I think that we should default back to --no-overwrite till we get this
> sorted out, as the effect is easily noticeable, as David reported and I
> reproduced, when doing kernel builds.

It is mainly for performance reason to switch to overwrite mode. The 
impact was very small when I did my test. But now the effect is easily 
noticeable in other tests. Yes, I agree. We may change it back to 
non-overwrite mode until the issue is addressed.


> 
> On systems such as Knights Landing/Mill one can use --overwrite, knowing
> about this current map resolving limitation, i.e. for workloads where
> there are not that many short lived threads or mmap'ing, that could be
> possibly tolerable.

Could you please add this in the description of --overwrite?
It looks like the --overwrite is not default anymore.
+--overwrite::
+	This is the default, but for investigating problems with it or any 
other strange
+	behaviour like lots of unknown samples, we may want to disable this 
mode by using
+	--no-overwrite.



> 
> Fixing this properly will probably involve using the ordered_events code
> and two evlist, one for the PERF_RECORD_!SAMPLE in non-overwrite mode
> and the other for PERF_RECORD_SAMPLE in overwrite mode, else someone
> comes up with some better solution :-)
>

Supporting both overwrite and non-overwrite mode?
I think that needs some changes in kernel. May need to split the ring 
buffer for different mode. I think it should be very complex.
But I don't have a better solution for now. :)


Thanks,
Kan
