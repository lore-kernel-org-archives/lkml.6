Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751043AbeBBFxj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 00:53:39 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:34822 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750710AbeBBFxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 00:53:31 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 237FC6050D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cpandya@codeaurora.org
Subject: Re: [PATCH] of: cache phandle nodes to decrease cost of
 of_find_node_by_phandle()
To: Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1517429142-25727-1-git-send-email-frowand.list@gmail.com>
 <5dd35d8f-c430-237e-9863-2e73556f92ec@gmail.com>
 <CAL_JsqLV_bQ2pQ7hCRDP9_31kmKQjggWFDoCia-KmmO5CR3T5g@mail.gmail.com>
 <4f2b3755-9ef1-4817-7436-9f5aafb38b60@gmail.com>
From: Chintan Pandya <cpandya@codeaurora.org>
Message-ID: <cae45760-558d-c0b7-93aa-a137f46b2836@codeaurora.org>
Date: Fri, 2 Feb 2018 11:23:26 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <4f2b3755-9ef1-4817-7436-9f5aafb38b60@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/2/2018 2:39 AM, Frank Rowand wrote:
> On 02/01/18 06:24, Rob Herring wrote:
>> And so
>> far, no one has explained why a bigger cache got slower.
> 
> Yes, I still find that surprising.

I thought a bit about this. And realized that increasing the cache size 
should help improve the performance only if there are too many misses 
with the smaller cache. So, from my experiments some time back, I looked 
up the logs and saw the access pattern. Seems like, there is 
*not_too_much* juggling during look up by phandles.

See the access pattern here: 
https://drive.google.com/file/d/1qfAD8OsswNJABgAwjJf6Gr_JZMeK7rLV/view?usp=sharing

Sample log is pasted below where number in the last is phandle value.
	Line 8853: [   37.425405] OF: want to search this 262
	Line 8854: [   37.425453] OF: want to search this 262
	Line 8855: [   37.425499] OF: want to search this 262
	Line 8856: [   37.425549] OF: want to search this 15
	Line 8857: [   37.425599] OF: want to search this 5
	Line 8858: [   37.429989] OF: want to search this 253
	Line 8859: [   37.430058] OF: want to search this 253
	Line 8860: [   37.430217] OF: want to search this 253
	Line 8861: [   37.430278] OF: want to search this 253
	Line 8862: [   37.430337] OF: want to search this 253
	Line 8863: [   37.430399] OF: want to search this 254
	Line 8864: [   37.430597] OF: want to search this 254
	Line 8865: [   37.430656] OF: want to search this 254


Above explains why results with cache size 64 and 128 have almost 
similar results. Now, for cache size 256 we have degrading performance. 
I don't have a good theory here but I'm assuming that by making large SW 
cache, we miss the benefits of real HW cache which is typically smaller 
than our array size. Also, in my set up, I've set max_cpu=1 to reduce 
the variance. That again, should affect the cache holding pattern in HW 
and affect the perf numbers.


Chintan
-- 
Qualcom India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation
Collaborative Project
