Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0468AC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AA2827639
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kRVPhDOp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AA2827639
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966947AbeF1PpY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 11:45:24 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33954 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932316AbeF1PpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 11:45:23 -0400
Received: by mail-wr0-f195.google.com with SMTP id a12-v6so6020615wro.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 08:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=8Ek+YDiDlqnTjlj3EgwbitngcyayYVQm4V9ARSwfL4w=;
        b=kRVPhDOpSRsVYQaMtgKLcU/gSOU6aIJdlqOJstZIGbRcBDRANEReK+1UCKZy6BmAmm
         McCqrSlUrrkPAUDBzxlDd+N0YKEFR1v2h0HrvTPLRK4tT26JRHc3Oreul6AMmQI5gZIk
         BS/NnYr0l4iooduEMzTGFBkYDGT5lZEzSQxhk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8Ek+YDiDlqnTjlj3EgwbitngcyayYVQm4V9ARSwfL4w=;
        b=eVbAsjt84JfalOZOzj0SMRh7ZKyUZYQ9fT0D02r5/u/28i1AAJnGJWdbN+vC2nJ0MU
         L057qJOaJgazBXlkoxHSQAR70EBq17nOCjSLZETZCJOSAvLVVUZYB8XzeqbACC87RdIG
         DuCcSfXhEZaTh9ryTdI627hkFVeBaPBChJIVqG1XEde+5uxXTYnobMonq49QwiOJcMVW
         NGbJ4BGtTTSPl00qS95l+gTcZqkDjpumZ84GlT/3MXiKLzawd/TmsdbaojqSYWTP4hl6
         m4An9BGCoyPoM40yTMSGbsrke7hy0pptXSt1gn8POeL3CepslQEevcRA8wizv6Ylg91+
         agdQ==
X-Gm-Message-State: APt69E3OZsu3oHij9u7HLfDIYmpmJbyfEgnSwbLag7mWoKrXaBIvfSiv
        0qQYPQU3jATFAQHf1G+y9/+XTA==
X-Google-Smtp-Source: AAOMgpdQ2ui0WHFzzbmyQ2OQnFN02fLeYjPzI51B9k04oUmdTCmFZjEfcg5ntKersomYqpLrTVCtQQ==
X-Received: by 2002:a5d:4c4c:: with SMTP id n12-v6mr9004354wrt.71.1530200721550;
        Thu, 28 Jun 2018 08:45:21 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:21c3:ec41:bec9:c38])
        by smtp.gmail.com with ESMTPSA id i4-v6sm6202115wrq.28.2018.06.28.08.45.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 28 Jun 2018 08:45:20 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rjw@rjwysocki.net, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, viresh.kumar@linaro.org,
        valentin.schneider@arm.com, patrick.bellasi@arm.com,
        joel@joelfernandes.org, daniel.lezcano@linaro.org,
        quentin.perret@arm.com, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v7 00/11] track CPU utilization
Date:   Thu, 28 Jun 2018 17:45:03 +0200
Message-Id: <1530200714-4504-1-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset initially tracked only the utilization of RT rq. During
OSPM summit, it has been discussed the opportunity to extend it in order
to get an estimate of the utilization of the CPU.

- Patches 1 move pelt code in a dedicated file and remove some blank lines
  
- Patches 2-3 add utilization tracking for rt_rq.

When both cfs and rt tasks compete to run on a CPU, we can see some frequency
drops with schedutil governor. In such case, the cfs_rq's utilization doesn't
reflect anymore the utilization of cfs tasks but only the remaining part that
is not used by rt tasks. We should monitor the stolen utilization and take
it into account when selecting OPP. This patchset doesn't change the OPP
selection policy for RT tasks but only for CFS tasks

A rt-app use case which creates an always running cfs thread and a rt threads
that wakes up periodically with both threads pinned on same CPU, show lot of 
frequency switches of the CPU whereas the CPU never goes idles during the 
test. I can share the json file that I used for the test if someone is
interested in.

For a 15 seconds long test on a hikey 6220 (octo core cortex A53 platfrom),
the cpufreq statistics outputs (stats are reset just before the test) : 
$ cat /sys/devices/system/cpu/cpufreq/policy0/stats/total_trans
without patchset : 1230
with patchset : 14

If we replace the cfs thread of rt-app by a sysbench cpu test, we can see
performance improvements:

- Without patchset :
Test execution summary:
    total time:                          15.0009s
    total number of events:              4903
    total time taken by event execution: 14.9972
    per-request statistics:
         min:                                  1.23ms
         avg:                                  3.06ms
         max:                                 13.16ms
         approx.  95 percentile:              12.73ms

Threads fairness:
    events (avg/stddev):           4903.0000/0.00
    execution time (avg/stddev):   14.9972/0.00

- With patchset:
Test execution summary:
    total time:                          15.0014s
    total number of events:              7694
    total time taken by event execution: 14.9979
    per-request statistics:
         min:                                  1.23ms
         avg:                                  1.95ms
         max:                                 10.49ms
         approx.  95 percentile:              10.39ms

Threads fairness:
    events (avg/stddev):           7694.0000/0.00
    execution time (avg/stddev):   14.9979/0.00

The performance improvement is 56% for this use case.

- Patches 4-5 add utilization tracking for dl_rq in order to solve similar
  problem as with rt_rq. Nevertheless, we keep using dl bandwidth as default
  level of requirement for dl tasks. The dl utilization is used to check that
  the CPU is not overloaded which is not always reflected when using dl
  bandwidth

- Patches 6-7 add utilization tracking for interrupt and use it select OPP
  A test with iperf on hikey 6220 gives: 
    w/o patchset	    w/ patchset
    Tx 276 Mbits/sec        304 Mbits/sec +10%
    Rx 299 Mbits/sec        328 Mbits/sec +09%
    
    8 iterations of iperf -c server_address -r -t 5
    stdev is lower than 1%
    Only WFI idle state is enable (shallowest arm idle state)

- Patch 8 merges sugov_aggregate_util and sugov_get_util as proposed by Peter

- Patches 9 uses rt, dl and interrupt utilization in the scale_rt_capacity()
  and remove  the use of sched_rt_avg_update.

- Patches 10 removes the unused sched_avg_update code

- Patch 11 removes the unused sched_time_avg_ms

Change since v6:
- add more comments load tracking metrics 
- merge sugov_aggregate_util and sugov_get_util

Change since v4:
- add support of periodic update of blocked utilization
- rebase on lastest tip/sched/core

Change since v3:
- add support of periodic update of blocked utilization
- rebase on lastest tip/sched/core

Change since v2:
- move pelt code into a dedicated pelt.c file
- rebase on load tracking changes

Change since v1:
- Only a rebase. I have addressed the comments on previous version in
  patch 1/2


Vincent Guittot (11):
  sched/pelt: Move pelt related code in a dedicated file
  sched/rt: add rt_rq utilization tracking
  cpufreq/schedutil: use rt utilization tracking
  sched/dl: add dl_rq utilization tracking
  cpufreq/schedutil: use dl utilization tracking
  sched/irq: add irq utilization tracking
  cpufreq/schedutil: take into account interrupt
  sched: schedutil: remove sugov_aggregate_util()
  sched: use pelt for scale_rt_capacity()
  sched: remove rt_avg code
  proc/sched: remove unused sched_time_avg_ms

 include/linux/sched/sysctl.h     |   1 -
 kernel/sched/Makefile            |   2 +-
 kernel/sched/core.c              |  38 +---
 kernel/sched/cpufreq_schedutil.c |  65 ++++---
 kernel/sched/deadline.c          |   8 +-
 kernel/sched/fair.c              | 403 +++++----------------------------------
 kernel/sched/pelt.c              | 399 ++++++++++++++++++++++++++++++++++++++
 kernel/sched/pelt.h              |  72 +++++++
 kernel/sched/rt.c                |  15 +-
 kernel/sched/sched.h             |  68 +++++--
 kernel/sysctl.c                  |   8 -
 11 files changed, 632 insertions(+), 447 deletions(-)
 create mode 100644 kernel/sched/pelt.c
 create mode 100644 kernel/sched/pelt.h

-- 
2.7.4

