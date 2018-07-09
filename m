Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D1E3C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 05:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2308208A3
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 05:52:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2308208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754468AbeGIFws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 01:52:48 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:39212 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750996AbeGIFwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 01:52:47 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01355;MF=xlpang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0T4G08X3_1531115558;
Received: from xunleideMacBook-Pro.local(mailfrom:xlpang@linux.alibaba.com fp:SMTPD_---0T4G08X3_1531115558)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 09 Jul 2018 13:52:38 +0800
Reply-To: xlpang@linux.alibaba.com
Subject: Re: [PATCH] sched/cputime: Ensure correct utime and stime proportion
From:   Xunlei Pang <xlpang@linux.alibaba.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org
References: <20180622071542.61569-1-xlpang@linux.alibaba.com>
 <b9363fa9-826f-611f-3ab3-27e50c03422a@linux.alibaba.com>
 <20180626154908.GE2458@hirez.programming.kicks-ass.net>
 <e1b69cf9-a3a7-ea67-7c0e-d67ac81f29f1@linux.alibaba.com>
 <20180705104632.GE2494@hirez.programming.kicks-ass.net>
 <bd275aff-61dd-557f-5b91-da4ce82f9501@linux.alibaba.com>
Message-ID: <5a3354c1-d3fe-33dc-53cf-6eb621177052@linux.alibaba.com>
Date:   Mon, 9 Jul 2018 13:52:38 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <bd275aff-61dd-557f-5b91-da4ce82f9501@linux.alibaba.com>
Content-Type: multipart/mixed;
 boundary="------------BE11F3B1CFC23A9FAB906983"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------BE11F3B1CFC23A9FAB906983
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit

Hi Peter,

On 7/5/18 9:21 PM, Xunlei Pang wrote:
> On 7/5/18 6:46 PM, Peter Zijlstra wrote:
>> On Wed, Jun 27, 2018 at 08:22:42PM +0800, Xunlei Pang wrote:
>>> tick-based whole utime is utime_0, tick-based whole stime
>>> is stime_0, scheduler time is rtime_0. 
>>
>>> For a long time, the process runs mainly in userspace with
>>> run-sleep patterns, and because two different clocks, it
>>> is possible to have the following condition:
>>>   rtime_0 < utime_0 (as with little stime_0)
>>
>> I don't follow... what?
>>
>> Why are you, and why do you think it makes sense to, compare rtime_0
>> against utime_0 ?
>>
>> The [us]time_0 are, per your earlier definition, ticks. They're not an
>> actual measure of time. Do not compare the two, that makes no bloody
>> sense.
>>
> 
> [us]time_0 is task_struct:utime{stime}, I cited directly from
> cputime_adjust(), both in nanoseconds. I assumed "rtime_0 < utime_0"
> here to simple the following proof to help explain the problem we met.
> 

Please see the enclosure for the reproducer cputime_adjust.tgz
(process_top.sh, usr_sys.c):
gcc usr_sys.c -o usr_sys
Firstly, the function consume_sys() in usr_sys.c yields 100% sys
which can be verified as follows:
$ taskset -c 0 ./usr_sys 1
$ ./process_top.sh $(pidof usr_sys)
0.0 usr,  100.0 sys
0.0 usr,  100.0 sys


Tested on my local box on 4.17.0 by executing "taskset -c 0 ./usr_sys",
then executing "./process_top.sh $(pidof usr_sys)" to watch.
1) Before this patch
50.0 usr,  0.0 sys
50.0 usr,  1.0 sys
50.0 usr,  0.0 sys
50.0 usr,  0.0 sys
49.0 usr,  4.0 sys //switch to consume 100% sys, ignore this line
12.0 usr,  88.0 sys
11.0 usr,  89.0 sys
10.0 usr,  90.0 sys
10.0 usr,  90.0 sys
9.0 usr,  91.0 sys
8.0 usr,  91.0 sys

Obviously there were around 10% sys wrongly goes to usr

2) After this patch
50.0 usr,  0.0 sys
50.0 usr,  0.0 sys
50.0 usr,  0.0 sys
50.0 usr,  0.0 sys
11.0 usr,  76.0 sys //switch to consume 100% sys, ignore this line
1.0 usr,  100.0 sys
0.0 usr,  100.0 sys
1.0 usr,  100.0 sys
0.0 usr,  100.0 sys
0.0 usr,  100.0 sys

So it displayed the correct result as we expected after this patch.

Thanks,
Xunlei

--------------BE11F3B1CFC23A9FAB906983
Content-Type: application/x-gzip;
 name="cputime_adjust.tgz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="cputime_adjust.tgz"

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
--------------BE11F3B1CFC23A9FAB906983--
