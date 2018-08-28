Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0490BC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 09:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6B0B20658
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 09:19:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6B0B20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbeH1NJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 09:09:55 -0400
Received: from mga17.intel.com ([192.55.52.151]:34153 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727078AbeH1NJz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 09:09:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Aug 2018 02:19:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,298,1531810800"; 
   d="scan'208";a="80805541"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 28 Aug 2018 02:19:11 -0700
Received: from [10.125.252.157] (abudanko-mobl.ccr.corp.intel.com [10.125.252.157])
        by linux.intel.com (Postfix) with ESMTP id D2FA85803DA;
        Tue, 28 Aug 2018 02:19:08 -0700 (PDT)
Subject: Re: [PATCH v2 1/2]: perf util: map data buffer for preserving
 collected data
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
References: <e92805d0-3338-2ce5-5e88-369d406fe0a7@linux.intel.com>
 <e5591d27-5386-1d41-b09b-421316f75d07@linux.intel.com>
 <20180827083303.GD24695@krava>
 <2284a8e8-d90e-bd99-89c1-0b125ba2e205@linux.intel.com>
 <20180828084522.GD23727@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <48431c29-5642-c282-a760-c2dd99db8049@linux.intel.com>
Date:   Tue, 28 Aug 2018 12:19:06 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180828084522.GD23727@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 28.08.2018 11:45, Jiri Olsa wrote:
> On Mon, Aug 27, 2018 at 12:02:35PM +0300, Alexey Budankov wrote:
>> Hi,
>>
>> On 27.08.2018 11:33, Jiri Olsa wrote:
>>> On Thu, Aug 23, 2018 at 07:42:09PM +0300, Alexey Budankov wrote:
>>>
>>> SNIP
>>>
>>>> diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
>>>> index fc832676a798..e71d46cb01cc 100644
>>>> --- a/tools/perf/util/mmap.c
>>>> +++ b/tools/perf/util/mmap.c
>>>> @@ -155,6 +155,10 @@ void __weak auxtrace_mmap_params__set_idx(struct auxtrace_mmap_params *mp __mayb
>>>>  
>>>>  void perf_mmap__munmap(struct perf_mmap *map)
>>>>  {
>>>> +	if (map->data != NULL) {
>>>> +		munmap(map->data, perf_mmap__mmap_len(map));
>>>> +		map->data = NULL;
>>>> +	}
>>>>  	if (map->base != NULL) {
>>>>  		munmap(map->base, perf_mmap__mmap_len(map));
>>>>  		map->base = NULL;
>>>> @@ -190,6 +194,14 @@ int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp, int fd)
>>>>  		map->base = NULL;
>>>>  		return -1;
>>>>  	}
>>>> +	map->data = mmap(NULL, perf_mmap__mmap_len(map), PROT_READ | PROT_WRITE,
>>>> +			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>>>
>>> hum, why does map->data need to be mmap-ed?
>>
>> The same way as for kernel buffers. If you see better alternatives it could be applied.
> 
> I meant why not just allocate them with mmaloc?

Yep. Using malloc()/free() makes the implementation shorter. Included into [PATCH v4 1/2].

> 
> jirka
> 
