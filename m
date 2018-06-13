Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D479BC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 12:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8982420020
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 12:17:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8982420020
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935525AbeFMMR3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 08:17:29 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40113 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935286AbeFMMR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 08:17:27 -0400
Received: by mail-wm0-f65.google.com with SMTP id n5-v6so4945774wmc.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 05:17:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PKgY4yhdsqbBT9TreIXxdpXyQPOuGke2Y2wj4sR80zk=;
        b=br196EFCmjpJDRhHxDQWpzJxvZ2X3J9cVplKK5Fe2PXlcMf/OToAj4V14pvZ28r3jI
         A/hScBao+FfglImzL+z50QCiqVUtTECZQSVvwh7X05f1lWZ3PKlcJbydASibGNzYgYIG
         EAcoy5i+6kzsDu+o/0BrZqVRd3cb4M4QDAZ6ipuWRYKv6PIkR+/ph5e+WfU+QbyW/2qA
         Fs+0IHW27yknPTj7pqJM7bRVIt9cc9tM0nbNCB8EvSSh6HpWEW4gswVtrXz6xwumVXlq
         4liHJ9KBBHVos2pnTMQm0aJ74ghzlztlZkPO0uEoIYpbKAPjxEJJfJQBiIVYtAXrqCCG
         ymwQ==
X-Gm-Message-State: APt69E3IhhX3yTsqqebIpu1hcIwhfNUsUWlSroXiLKPCULzabij8rid5
        xtmp98qPpgZSlC7GpNwoZgvXjg==
X-Google-Smtp-Source: ADUXVKLrltS5Dk9omvwTPnfRyeYdzPeZFA0vsi5iaIEujDFC2OV08IvOVL0LxTX50y4Kcz+7MCdNkA==
X-Received: by 2002:a1c:5d0e:: with SMTP id r14-v6mr2675200wmb.152.1528892246147;
        Wed, 13 Jun 2018 05:17:26 -0700 (PDT)
Received: from localhost.localdomain.com ([151.15.207.242])
        by smtp.gmail.com with ESMTPSA id 137-v6sm4943673wmv.28.2018.06.13.05.17.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Jun 2018 05:17:25 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org, lizefan@huawei.com,
        cgroups@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH v4 0/5] sched/deadline: fix cpusets bandwidth accounting
Date:   Wed, 13 Jun 2018 14:17:06 +0200
Message-Id: <20180613121711.5018-1-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is v4 of a series of patches, authored by Mathieu (thanks for your
work and for allowing me to try to move this forward), with the intent
of fixing a long standing issue of SCHED_DEADLINE bandwidth accounting.
As originally reported by Steve [1], when hotplug and/or (certain)
cpuset reconfiguration operations take place, DEADLINE bandwidth
accounting information is lost since root domains are destroyed and
recreated.

Mathieu's approach is based on restoring bandwidth accounting info on
the newly created root domains by iterating through the (DEADLINE) tasks
belonging to the configured cpuset(s).

v3 still had issues (IMHO) because __sched_setscheduler() might race
with the aforementioned restore operation (and it actually looks racy
with cpuset ops in general), but grabbing cpuset_mutex from potential
atomic contexs is a no-go.

I reworked v3 solution a bit ending-up with something that seems to be
working [2]. The idea is simply to trylock such mutex and return -EBUSY
to the user if we raced with cpuset ops. It's gross, but didn't find
anything better (and working) yet. :/

I also don't particularly like 05/05, as it introduces lot of DEADLINE-
iness into cpuset.c. I decided not to change Mathieu's patch for the
moment and see if better approaches are suggested (a per-class thing
maybe, even though other classes don't suffer from this problem and it
is so still going to be DEADLINE specific).

I also left out Mathieu's subsequent patches to focus on this crucial
fix. They can easily come later, IMHO.

Set also available at

 https://github.com/jlelli/linux.git fixes/deadline/root-domain-accounting-v4

Thanks,

- Juri

[1] https://lkml.org/lkml/2016/2/3/966
[2] compare -before (that confirms what Steve saw) with -after
    https://git.io/vhKfW

Mathieu Poirier (5):
  sched/topology: Add check to backup comment about hotplug lock
  sched/topology: Adding function partition_sched_domains_locked()
  sched/core: Streamlining calls to task_rq_unlock()
  sched/core: Prevent race condition between cpuset and
    __sched_setscheduler()
  cpuset: Rebuild root domain deadline accounting information

 include/linux/cpuset.h         |  6 ++++
 include/linux/sched.h          |  5 +++
 include/linux/sched/deadline.h |  8 +++++
 include/linux/sched/topology.h | 10 ++++++
 kernel/cgroup/cpuset.c         | 79 +++++++++++++++++++++++++++++++++++++++++-
 kernel/sched/core.c            | 38 ++++++++++++++------
 kernel/sched/deadline.c        | 31 +++++++++++++++++
 kernel/sched/sched.h           |  3 --
 kernel/sched/topology.c        | 32 ++++++++++++++---
 9 files changed, 193 insertions(+), 19 deletions(-)

-- 
2.14.3

