Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752590AbeBCDzp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 22:55:45 -0500
Received: from mail-pl0-f48.google.com ([209.85.160.48]:37968 "EHLO
        mail-pl0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752577AbeBCDzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 22:55:39 -0500
X-Google-Smtp-Source: AH8x226ArBQAfCLoK+jlwf5dFQBFRU8SBml1iAUB/konkQvuP0iN7NMh4r2Cq63ZWmKlZ+ghS5WMhw==
Subject: Re: [PATCH] of: cache phandle nodes to decrease cost of
 of_find_node_by_phandle()
To: Chintan Pandya <cpandya@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1517429142-25727-1-git-send-email-frowand.list@gmail.com>
 <5dd35d8f-c430-237e-9863-2e73556f92ec@gmail.com>
 <CAL_JsqLV_bQ2pQ7hCRDP9_31kmKQjggWFDoCia-KmmO5CR3T5g@mail.gmail.com>
 <4f2b3755-9ef1-4817-7436-9f5aafb38b60@gmail.com>
 <cae45760-558d-c0b7-93aa-a137f46b2836@codeaurora.org>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <f38afa06-fedb-4fbc-6721-f3bae4260316@gmail.com>
Date: Fri, 2 Feb 2018 19:55:35 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <cae45760-558d-c0b7-93aa-a137f46b2836@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/01/18 21:53, Chintan Pandya wrote:
> 
> 
> On 2/2/2018 2:39 AM, Frank Rowand wrote:
>> On 02/01/18 06:24, Rob Herring wrote:
>>> And so
>>> far, no one has explained why a bigger cache got slower.
>>
>> Yes, I still find that surprising.
> 
> I thought a bit about this. And realized that increasing the cache size should help improve the performance only if there are too many misses with the smaller cache. So, from my experiments some time back, I looked up the logs and saw the access pattern. Seems like, there is *not_too_much* juggling during look up by phandles.
> 
> See the access pattern here: https://drive.google.com/file/d/1qfAD8OsswNJABgAwjJf6Gr_JZMeK7rLV/view?usp=sharing

Thanks!  Very interesting.

I was somewhat limited at playing detective with this, because the phandle
values are not consistent with the dts file you are currently working
with (arch/arm64/boot/dts/qcom/sda670-mtp.dts).  For example, I could
not determine what the target nodes for the hot phandle values.  That
information _could_ possibly point at algorithms within the devicetree
core code that could be improved.  Or maybe not.  Hard to tell until
actually looking at the data.

Anyway, some observations were possible.

There are 485 unique phandle values searched for.

The ten phandle values most frequently referenced account for
3932 / 6745 (or 58%) of all references.

Without the corresponding devicetree I can not tell how many nodes
need to be scanned to locate each of these ten values (using the
existing algorithm).  Thus I can not determine how much scanning
would be eliminated by caching just the nodes corresponding to
these ten phandle values.

There are 89 phandle values that were searched for 10 times
or more, accounting for 86% of the searches.

Only 164 phandle values were searched for just one time.

303 phandle values were searched for just one or two times.

Here is a more complete picture:

  10 values each used 100 or more times; searches:  3932   58%
  11 values each used  90 or more times; searches:  3994   59%
  12 values each used  80 or more times; searches:  4045   60%
  13 values each used  70 or more times; searches:  4093   61%
  14 values each used  60 or more times; searches:  4136   61%
  15 values each used  50 or more times; searches:  4178   62%
  18 values each used  40 or more times; searches:  4300   64%
  32 values each used  30 or more times; searches:  4774   71%
  54 values each used  20 or more times; searches:  5293   78%
  89 values each used  10 or more times; searches:  5791   86%
  93 values each used   9 or more times; searches:  5827   86%
 117 values each used   8 or more times; searches:  6019   89%
 122 values each used   7 or more times; searches:  6054   90%
 132 values each used   6 or more times; searches:  6114   91%
 144 values each used   5 or more times; searches:  6174   92%
 162 values each used   4 or more times; searches:  6246   93%
 181 values each used   3 or more times; searches:  6303   93%
 320 values each used   2 or more times; searches:  6581   98%
 484 values each used   1 or more times; searches:  6746  100%

A single system does not prove anything.  It is possible that
other devicetrees would exhibit similarly long tailed behavior,
but that is just wild speculation on my part.

_If_ the long tail is representative of other systems, then
identifying a few hot spots could be useful, but fixing them
is not likely to significantly reduce the overhead of calls
to of_find_node_by_phandle().  Some method of reducing the
overhead of each call would be the answer for a system of
this class.


> Sample log is pasted below where number in the last is phandle value.
>     Line 8853: [   37.425405] OF: want to search this 262
>     Line 8854: [   37.425453] OF: want to search this 262
>     Line 8855: [   37.425499] OF: want to search this 262
>     Line 8856: [   37.425549] OF: want to search this 15
>     Line 8857: [   37.425599] OF: want to search this 5
>     Line 8858: [   37.429989] OF: want to search this 253
>     Line 8859: [   37.430058] OF: want to search this 253
>     Line 8860: [   37.430217] OF: want to search this 253
>     Line 8861: [   37.430278] OF: want to search this 253
>     Line 8862: [   37.430337] OF: want to search this 253
>     Line 8863: [   37.430399] OF: want to search this 254
>     Line 8864: [   37.430597] OF: want to search this 254
>     Line 8865: [   37.430656] OF: want to search this 254
> 
> 
> Above explains why results with cache size 64 and 128 have almost similar results. Now, for cache size 256 we have degrading performance. I don't have a good theory here but I'm assuming that by making large SW cache, we miss the benefits of real HW cache which is typically smaller than our array size. Also, in my set up, I've set max_cpu=1 to reduce the variance. That again, should affect the cache holding pattern in HW and affect the perf numbers.
> 
> 
> Chintan
