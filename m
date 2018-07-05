Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D56CC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC9FC24007
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:21:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC9FC24007
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754508AbeGENVZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 09:21:25 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:44097 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754469AbeGENVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 09:21:23 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R301e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07486;MF=xlpang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0T41JDi4_1530796875;
Received: from xunleideMacBook-Pro.local(mailfrom:xlpang@linux.alibaba.com fp:SMTPD_---0T41JDi4_1530796875)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 05 Jul 2018 21:21:16 +0800
Reply-To: xlpang@linux.alibaba.com
Subject: Re: [PATCH] sched/cputime: Ensure correct utime and stime proportion
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org
References: <20180622071542.61569-1-xlpang@linux.alibaba.com>
 <b9363fa9-826f-611f-3ab3-27e50c03422a@linux.alibaba.com>
 <20180626154908.GE2458@hirez.programming.kicks-ass.net>
 <e1b69cf9-a3a7-ea67-7c0e-d67ac81f29f1@linux.alibaba.com>
 <20180705104632.GE2494@hirez.programming.kicks-ass.net>
From:   Xunlei Pang <xlpang@linux.alibaba.com>
Message-ID: <bd275aff-61dd-557f-5b91-da4ce82f9501@linux.alibaba.com>
Date:   Thu, 5 Jul 2018 21:21:15 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180705104632.GE2494@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/5/18 6:46 PM, Peter Zijlstra wrote:
> On Wed, Jun 27, 2018 at 08:22:42PM +0800, Xunlei Pang wrote:
>> tick-based whole utime is utime_0, tick-based whole stime
>> is stime_0, scheduler time is rtime_0. 
> 
>> For a long time, the process runs mainly in userspace with
>> run-sleep patterns, and because two different clocks, it
>> is possible to have the following condition:
>>   rtime_0 < utime_0 (as with little stime_0)
> 
> I don't follow... what?
> 
> Why are you, and why do you think it makes sense to, compare rtime_0
> against utime_0 ?
> 
> The [us]time_0 are, per your earlier definition, ticks. They're not an
> actual measure of time. Do not compare the two, that makes no bloody
> sense.
> 

[us]time_0 is task_struct:utime{stime}, I cited directly from
cputime_adjust(), both in nanoseconds. I assumed "rtime_0 < utime_0"
here to simple the following proof to help explain the problem we met.
