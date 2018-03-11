Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932447AbeCKXCX (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 19:02:23 -0400
Received: from cmta20.telus.net ([209.171.16.93]:52408 "EHLO cmta20.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932355AbeCKXCV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 19:02:21 -0400
X-Authority-Analysis: v=2.2 cv=Pr98V0E3 c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=kj9zAlcOel0A:10 a=FGbulvE0AAAA:8
 a=VwQbUJbxAAAA:8 a=P-Pedy7ncC1TvRnTAiwA:9 a=CjuIK1q_8ugA:10
 a=svzTaB3SJmTkU8mK-ULk:22 a=AjGcO6oz07-iQ99wixmX:22
From: "Doug Smythies" <dsmythies@telus.net>
To: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc: "'Rik van Riel'" <riel@surriel.com>,
        "'Mike Galbraith'" <mgalbraith@suse.de>,
        "'Thomas Gleixner'" <tglx@linutronix.de>,
        "'Paul McKenney'" <paulmck@linux.vnet.ibm.com>,
        "'Thomas Ilsche'" <thomas.ilsche@tu-dresden.de>,
        "'Frederic Weisbecker'" <fweisbec@gmail.com>,
        "'Linux PM'" <linux-pm@vger.kernel.org>,
        "'Aubrey Li'" <aubrey.li@linux.intel.com>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
        "'Doug Smythies'" <dsmythies@telus.net>
References: <2450532.XN8DODrtDf@aspire.rjw.lan> <000701d3b889$eadd5340$c097f9c0$@net> <001801d3b90c$99232600$cb697200$@net> uy66ebKjsFfdwuy6Be0qnb v2lnemfac1Konv3GbegAC4
In-Reply-To: v2lnemfac1Konv3GbegAC4
Subject: RE: [RFC/RFT][PATCH v3 0/6] sched/cpuidle: Idle loop rework
Date: Sun, 11 Mar 2018 16:02:14 -0700
Message-ID: <000c01d3b98d$016eeb10$044cc130$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdO5Iqo8D92TMYoqSVyabI5dAwHWqAAKkqFgAA9qg9A=
Content-Language: en-ca
X-CMAE-Envelope: MS4wfGSMf/JZWUvALWtRoFQ525uFAtHA+g6S5WqXusVgmuPvKOe6KLET/fdu2uPqwMkJEAhXMH/MliIX0S3UG2rCjpQ4q414KhjpBoDUh9ISAeqAsx4FPGOR
 VmLM/WTba4N1PPApxl/nGds7r+opJjHzmXUT6u7+akvGS3RDeQ448cu6vDBy9BgyAwwlnfdEHKsDuxYuZg7T0uzs/UhVNdec9Nv/HtRqV0Y4oXVvDgIB41UF
 LrlVj/7BVK9J+q+8A7TFwW0dkBASo0pm7fiql9Zus2jzqut3wRuGaRX0KbfXLlfScncK64IgUKQIjy3yHhuQZhMlzEoxhkLRR7JQHNH4OeQWTwV27A45QfMB
 bmGE/c8HPfBtdt/XNMy639xvVGnQyPPlrJT5Wufbx0J63qYqI8xYwPRlnfWFbAxHEbKV4BcxFoVlBGS8QanZRs0q2lgsajcwNjVgo0Z/6sAYi2a/SFjyux5F
 fBn/oBHsXZkuzZxSDzqxdKDg779kXyE/EhxYAuCmOpUn5s3piaoZ2m1taZ0=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018.03.11 08:52 Doug Smythies wrote:
> On 2018.03.11 03:22 Rafael J. Wysocki wrote:
>> On Sunday, March 11, 2018 8:43:02 AM CET Doug Smythies wrote:
>>> On 2018.03.10 15:55 Rafael J. Wysocki wrote: 
>>>> On Saturday, March 10, 2018 5:07:36 PM CET Doug Smythies wrote:
>>>>> On 2018.03.10 01:00 Rafael J. Wysocki wrote:
>>>
>>> ... [snip] ...
>>> 
>>>> The information that they often spend more time than a tick
>>>> period in state 0 in one go *is* relevant, though.
>>>>
>>>>
>>>> That issue can be dealt with in a couple of ways and the patch below is a
>>>> rather straightforward attempt to do that.  The idea, basically, is to discard
>>>> the result of governor prediction if the tick has been stopped alread and
>>>> the predicted idle duration is within the tick range.
>>>
>>>> Please try it on top of the v3 and tell me if you see an improvement.
>>> 
>>> It seems pretty good so far.
>>> See a new line added to the previous graph, "rjwv3plus".
>>> 
>>> http://fast.smythies.com/rjwv3plus_100.png
>>
>> OK, cool!
>>
>> Below is a respin of the last patch which also prevents shallow states from
>> being chosen due to interactivity_req when the tick is stopped.
>>
>> You may also add a poll_idle() fix I've just posted:
>>
>> https://patchwork.kernel.org/patch/10274595/
>>
>> on top of this.  It makes quite a bit of a difference for me. :-)
>
> I will add and test, but I already know from testing previous versions
> of this patch, from Rik van Riel and myself, that the results will be
> awesome.

And the results are indeed awesome.

A four hour 100% load on one CPU test was run, with trace, however
there is nothing to report, as everything is great.

The same graph as the last couple of days, with a new line added for
V3 + the respin of patch 7 of 6 + the poll-idle fix, called rjwv3pp,
is here:

http://fast.smythies.com/rjwv3pp_100.png

... Doug
