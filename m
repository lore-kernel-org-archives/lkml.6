Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D33BC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7BE320868
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:28:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7BE320868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbeICSsp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 14:48:45 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41192 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbeICSsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 14:48:45 -0400
Received: by mail-wr1-f67.google.com with SMTP id z96-v6so862663wrb.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 07:28:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ej7dARzLP/rqxdCr4eqfg0VPjClpkECnxSzRdiDawP8=;
        b=QhJVYkpOvfziAHkgiMtRgvpkKmE82xp57PQn4Be1zjyBkie4tzbxsqpVbuXAlXc+j2
         rxZ1Fn1yTjkWS+x0Z/9r91rVhOYnqcwumD/0ig2jkJKOpPtUWKWhLvl8XRghbi1wNasK
         dhcxG6+F9/j9sPxlSSXVkdvLWBJUJxDfZrN9sa+DNZl/MXvpwB08aYHVozQ4fY0U7cfU
         LSyjpZLooXau9lGiC0MYo3Fv6tXtvRNfkNjU4KGJK0Cc7BQ5qkZsoEJEV79zHWPWebDi
         QL9SU0cioQtSALj/iHuXU/W+s1KuRm0+62TgbI6llNe8TSAN0v+d6cb7A8pEx2EGZBHb
         /+UA==
X-Gm-Message-State: APzg51D/Gf0rd8G6S7g++pT55OHXKl8AxFG7hWnbLfL2OJmlJCkXVeqY
        oK1F4E3WY/3FKRbXE1fbc0+vQw==
X-Google-Smtp-Source: ANB0VdaTzVEHUzaavNMmlvUyO1WboEvuukmA/wfC7ac2qjCKw+FNsRnRuYwRpe6Y1IaGEi+aIlnQog==
X-Received: by 2002:adf:dcc1:: with SMTP id x1-v6mr8683391wrm.21.1535984899038;
        Mon, 03 Sep 2018 07:28:19 -0700 (PDT)
Received: from localhost.localdomain.com ([151.15.227.30])
        by smtp.gmail.com with ESMTPSA id b74-v6sm14175880wma.8.2018.09.03.07.28.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Sep 2018 07:28:18 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org, lizefan@huawei.com,
        cgroups@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH v5 0/5] sched/deadline: fix cpusets bandwidth accounting
Date:   Mon,  3 Sep 2018 16:27:56 +0200
Message-Id: <20180903142801.20046-1-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

v5 of a series of patches, originally authored by Mathieu, with the intent
of fixing a long standing issue of SCHED_DEADLINE bandwidth accounting.
As originally reported by Steve [1], when hotplug and/or (certain)
cpuset reconfiguration operations take place, DEADLINE bandwidth
accounting information is lost since root domains are destroyed and
recreated.

Mathieu's approach is based on restoring bandwidth accounting info on
the newly created root domains by iterating through the (DEADLINE) tasks
belonging to the configured cpuset(s).

Main problem of v4 was caused by the trylocking of cpuset_mutex. As
noticed by Steve [2], if multiple tasks are created at they same time
only the first gets to grab the mutex, the other get -EBUSY and need to
retry. Not really nice. So, in v5 I'm proposing to use callback_lock
instead of cpuset_mutex, which AFAIU should be enough to grant read-only
safe access to cpusets.

01/05 has been dropped because it wasn't really adding much and was
only causing false positives.

05/05 is still too much DEADLINE specific I guess, but let's first agree
on foundations patches.

Set also available at

 https://github.com/jlelli/linux.git fixes/deadline/root-domain-accounting-v5

Thanks,

- Juri

[1] https://lkml.org/lkml/2016/2/3/966
[2] https://lore.kernel.org/lkml/20180614161142.69f186a6@gandalf.local.home/

Juri Lelli (1):
  cgroup/cpuset: make callback_lock raw

Mathieu Poirier (4):
  sched/topology: Adding function partition_sched_domains_locked()
  sched/core: Streamlining calls to task_rq_unlock()
  sched/core: Prevent race condition between cpuset and
    __sched_setscheduler()
  cpuset: Rebuild root domain deadline accounting information

 include/linux/cpuset.h         |   6 ++
 include/linux/sched.h          |   5 ++
 include/linux/sched/deadline.h |   8 ++
 include/linux/sched/topology.h |  10 +++
 kernel/cgroup/cpuset.c         | 147 +++++++++++++++++++++++++--------
 kernel/sched/core.c            |  34 +++++---
 kernel/sched/deadline.c        |  31 +++++++
 kernel/sched/sched.h           |   3 -
 kernel/sched/topology.c        |  30 +++++--
 9 files changed, 222 insertions(+), 52 deletions(-)

-- 
2.17.1

