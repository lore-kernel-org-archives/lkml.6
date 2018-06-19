Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17060C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EEA12083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:46:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EEA12083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755836AbeFSFqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 01:46:50 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:38147 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755376AbeFSFqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 01:46:49 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R881e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04455;MF=xlpang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0T2zTT.K_1529387192;
Received: from xunleideMacBook-Pro.local(mailfrom:xlpang@linux.alibaba.com fp:SMTPD_---0T2zTT.K_1529387192)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 19 Jun 2018 13:46:32 +0800
Reply-To: xlpang@linux.alibaba.com
Subject: Re: [PATCH 2/2] sched/fair: Advance global expiration when period
 timer is restarted
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Ben Segall <bsegall@google.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20180618091657.21939-1-xlpang@linux.alibaba.com>
 <CAM_iQpV-9_Q_xdNAobSq1bZXPm0kALAq1+Jc3BFpVAaQ2E_czQ@mail.gmail.com>
From:   Xunlei Pang <xlpang@linux.alibaba.com>
Message-ID: <fce1910a-ea42-7706-4b3f-56a1f972be9c@linux.alibaba.com>
Date:   Tue, 19 Jun 2018 13:46:31 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAM_iQpV-9_Q_xdNAobSq1bZXPm0kALAq1+Jc3BFpVAaQ2E_czQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/19/18 12:36 PM, Cong Wang wrote:
> On Mon, Jun 18, 2018 at 2:16 AM, Xunlei Pang <xlpang@linux.alibaba.com> wrote:
>> I noticed the group frequently got throttled even it consumed
>> low cpu usage, this caused some jitters on the response time
>> to some of our business containers enabling cpu quota.
>>
>> It's very easy to reproduce:
>> mkdir /sys/fs/cgroup/cpu/test
>> cd /sys/fs/cgroup/cpu/test
>> echo 100000 > cpu.cfs_quota_us
>> echo $$ > tasks
>> then repeat:
>> cat cpu.stat |grep nr_throttled  // nr_throttled will increase
>>
>> After some analysis, we found that cfs_rq::runtime_remaining will
>> be cleared by expire_cfs_rq_runtime() due to two equal but stale
>> "cfs_{b|q}->runtime_expires" after period timer is re-armed.
>>
>> The global expiration should be advanced accordingly when the
>> bandwidth period timer is restarted.
>>
> 
> I observed the same problem and already sent some patches:
> 
> https://lkml.org/lkml/2018/5/22/37
> https://lkml.org/lkml/2018/5/22/38
> https://lkml.org/lkml/2018/5/22/35
> 

Looks they are related to large slice setting and unused slack
under large number of cpus, the issue I described is a little
different.
