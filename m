Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE8F3C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 08:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A906F20856
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 08:47:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730739AbfAQIr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 03:47:57 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42247 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbfAQIr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 03:47:56 -0500
Received: by mail-wr1-f67.google.com with SMTP id q18so9985259wrx.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 00:47:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nJ5FIQcO/KUWBPafrvdLfOZ+L0cWF/hZD+T0jG3VQII=;
        b=NVjHn55IU4/3V6Mypr+qr++Y36wXpd7TxzUE9HmAMfvR9wb37GAdbvNL420DAN/4ji
         VmAaLUCLhBF4AAnXyWDynv5hthhgrSDp2o9N75SEhh0hqV80qkTdYTkC0SIfGwUC2KOo
         BejpqYCkR2VbD/gxe4GG2grMBwM5rLgFLBABfj58VLQlzHfTb7PqSnkUo2CkRZf3xYOU
         AEeix2JUORKaOHvDQdkrUhvfF1VYr2aZ4tzMaSWO7lVkT3TzDFHH+U8HN0tEI8m6Opeh
         swYxcKFl1ARfqg4MoWwyuWb7XCKVAwQYWbcYrp2HbdxZ553z2kKBurp0Hp0JLW0JChLr
         Ed8g==
X-Gm-Message-State: AJcUuke1Os00QG1iypOWCG2chwQndX2iKLZuaQy6w2OEknt8Ye9qHqT5
        FQbHivaRbFEnaWtvxvL0xHPnbg==
X-Google-Smtp-Source: ALg8bN68txKtpbCCjF/iZwLSGq1d12i/9c0nRFWfPuCXq2QOF0duRegsUN0s2d5fye2OHfxsCe1gcw==
X-Received: by 2002:a5d:63c3:: with SMTP id c3mr10835525wrw.215.1547714874654;
        Thu, 17 Jan 2019 00:47:54 -0800 (PST)
Received: from localhost.localdomain.home ([151.15.254.62])
        by smtp.gmail.com with ESMTPSA id 199sm41984992wmh.21.2019.01.17.00.47.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 00:47:53 -0800 (PST)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        tj@kernel.org
Cc:     linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org, lizefan@huawei.com,
        cgroups@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH v6 0/5] sched/deadline: fix cpusets bandwidth accounting
Date:   Thu, 17 Jan 2019 09:47:34 +0100
Message-Id: <20190117084739.17078-1-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

v6 of a series of patches, originally authored by Mathieu, with the intent
of fixing a long standing issue of SCHED_DEADLINE bandwidth accounting.
As originally reported by Steve [1], when hotplug and/or (certain)
cpuset reconfiguration operations take place, DEADLINE bandwidth
accounting information is lost since root domains are destroyed and
recreated.

Mathieu's approach is based on restoring bandwidth accounting info on
the newly created root domains by iterating through the (DEADLINE) tasks
belonging to the configured cpuset(s).

Apart from some minor refactoring needed to rebase the set on top of
Waiman Long's cpuset for cgroup series (now mainline), two changes worth
of notice:

 - added some more descriptive comments about why callback_lock gives
   the holder read-only access to cpusets [Steve] 04/05
 - call cgroup_enable_task_cg_list if we need to traverse the list of
   tasks belonging to a particular cgroup (to rebuild its bandwidth),
   but such list is not yet ready (this can for example happen if CPUs
   are hotplugged during early boot stages) 05/05

Set also available at

 https://github.com/jlelli/linux.git fixes/deadline/root-domain-accounting-v6

Thanks,

- Juri

[1] https://lkml.org/lkml/2016/2/3/966

Juri Lelli (1):
  cgroup/cpuset: make callback_lock raw

Mathieu Poirier (4):
  sched/topology: Adding function partition_sched_domains_locked()
  sched/core: Streamlining calls to task_rq_unlock()
  sched/core: Prevent race condition between cpuset and
    __sched_setscheduler()
  cpuset: Rebuild root domain deadline accounting information

 include/linux/cgroup.h         |   1 +
 include/linux/cpuset.h         |   6 ++
 include/linux/sched.h          |   5 ++
 include/linux/sched/deadline.h |   8 ++
 include/linux/sched/topology.h |  10 +++
 kernel/cgroup/cgroup.c         |   2 +-
 kernel/cgroup/cpuset.c         | 159 +++++++++++++++++++++++++--------
 kernel/sched/core.c            |  34 ++++---
 kernel/sched/deadline.c        |  31 +++++++
 kernel/sched/sched.h           |   3 -
 kernel/sched/topology.c        |  32 +++++--
 11 files changed, 234 insertions(+), 57 deletions(-)

-- 
2.17.2

