Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA990C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86DCE2080A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:20:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86DCE2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729276AbeJ3DKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 23:10:07 -0400
Received: from mga03.intel.com ([134.134.136.65]:22522 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728150AbeJ3DKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 23:10:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2018 11:20:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,441,1534834800"; 
   d="scan'208";a="86516055"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 29 Oct 2018 11:20:18 -0700
Received: from [10.251.20.185] (kliang2-mobl1.ccr.corp.intel.com [10.251.20.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 457C45803C2;
        Mon, 29 Oct 2018 11:20:17 -0700 (PDT)
Subject: Re: [PATCHES/RFC] Re: A concern about overflow ring buffer mode
To:     David Miller <davem@davemloft.net>
Cc:     acme@kernel.org, linux-kernel@vger.kernel.org, wangnan0@huawei.com,
        jolsa@kernel.org, namhyung@kernel.org, kan.liang@intel.com,
        ak@linux.intel.com, yao.jin@linux.intel.com, peterz@infradead.org
References: <0247fca0-5a94-9a83-cefa-282804316729@linux.intel.com>
 <20181029.104008.791032322062574758.davem@davemloft.net>
 <b488a063-276c-ab8f-954e-f68e951146b4@linux.intel.com>
 <20181029.104827.680192866924184016.davem@davemloft.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <d3626e3f-5993-7ee7-f817-48e9dcee17f4@linux.intel.com>
Date:   Mon, 29 Oct 2018 14:20:15 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181029.104827.680192866924184016.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/29/2018 1:48 PM, David Miller wrote:
> From: "Liang, Kan" <kan.liang@linux.intel.com>
> Date: Mon, 29 Oct 2018 13:42:56 -0400
> 
>>
>>
>> On 10/29/2018 1:40 PM, David Miller wrote:
>>> From: "Liang, Kan" <kan.liang@linux.intel.com>
>>> Date: Mon, 29 Oct 2018 10:33:06 -0400
>>>
>>>> I just realized that the problem in KNL will be back if we switch
>>>> back to non-overwrite mode.
>>> What is KNL?
>>>
>> Intel Xeon Phi Processor, Knights Landing.
> 
> I don't understand how a specific piece of hardware directly leads to
> ring buffer processing timeouts, or multi-minute thread map processing
> times...

Perf top processes all samples in a serial way. With the number of CPU 
increasing under the heavy load, the number of samples increase 
dramatically. The processing time also increase significantly.
When the processing time is longer than display refresh time, only the 
stale data is shown.

I use KNL as an example. Because the problem is even worse on KNL. There 
is nothing output with perf top.

In theory, it's a problem for all large scale platforms.

> 
> You'll have to explain all of the details of your test scenerio, and
> the exact problems triggers, which

My test was the same as yours, just running a parallel kernel build on KNL.

> caused you to write these patches
> which causes serious regressions for what I consider a core simple use
> case of perf top.

I agree that the warning message is annoying. I will try to find another 
way to deliver the message. But I think we do need the warning message.

You didn't see any warning before the patch. I think it is just because 
perf top hides the problem.

Thanks,
Kan
> 
> And that's running perf top during a parallel kernel build.
> 
> 
