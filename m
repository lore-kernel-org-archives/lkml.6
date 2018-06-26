Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF5AC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 12:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6314426A50
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 12:20:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6314426A50
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934965AbeFZMUA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 08:20:00 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:45237 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933509AbeFZMT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 08:19:59 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=xlpang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0T3NEMS9_1530015589;
Received: from xunleideMacBook-Pro.local(mailfrom:xlpang@linux.alibaba.com fp:SMTPD_---0T3NEMS9_1530015589)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 26 Jun 2018 20:19:49 +0800
Subject: Re: [PATCH] sched/cputime: Ensure correct utime and stime proportion
From:   Xunlei Pang <xlpang@linux.alibaba.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org
References: <20180622071542.61569-1-xlpang@linux.alibaba.com>
Message-ID: <b9363fa9-826f-611f-3ab3-27e50c03422a@linux.alibaba.com>
Date:   Tue, 26 Jun 2018 20:19:49 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180622071542.61569-1-xlpang@linux.alibaba.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/22/18 3:15 PM, Xunlei Pang wrote:
> We use per-cgroup cpu usage statistics similar to "cgroup rstat",
> and encountered a problem that user and sys usages are wrongly
> split sometimes.
> 
> Run tasks with some random run-sleep pattern for a long time, and
> when tick-based time and scheduler sum_exec_runtime hugely drifts
> apart(scheduler sum_exec_runtime is less than tick-based time),
> the current implementation of cputime_adjust() will produce less
> sys usage than the actual use after changing to run a different
> workload pattern with high sys. This is because total tick-based
> utime and stime are used to split the total sum_exec_runtime.
> 
> Same problem exists on utime and stime from "/proc/<pid>/stat".
> 
> [Example]
> Run some random run-sleep patterns for minutes, then change to run
> high sys pattern, and watch.
> 1) standard "top"(which is the correct one):
>    4.6 us, 94.5 sy,  0.0 ni,  0.9 id, 0.0 wa, 0.0 hi, 0.0 si, 0.0 st
> 2) our tool parsing utime and stime from "/proc/<pid>/stat":
>    20.5 usr, 78.4 sys
> We can see "20.5 usr" displayed in 2) was incorrect, it recovers
> gradually with time: 9.7 usr, 89.5 sys
> 
High sys probably means there's something abnormal on the kernel
path, it may hide issues, so we should make it fairly reliable.
It can easily hit this problem with our per-cgroup statistics.

Hi Peter, any comment on this patch?
