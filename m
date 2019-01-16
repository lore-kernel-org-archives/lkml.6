Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A0D1C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 09:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A81720866
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 09:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wme85a2H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391774AbfAPJnX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 04:43:23 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32775 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388916AbfAPJnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 04:43:22 -0500
Received: by mail-wr1-f67.google.com with SMTP id c14so6170061wrr.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 01:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=gmrUEBN/TU0biqMENVyhoYfn8KZ7Wp87NPDLMd/c9Ow=;
        b=Wme85a2HDEmwtJNoYTCLn8Pqdov+Fx0j5issecOl8FyKhPdhts18cggX573Z9xRpr7
         /rfT4Du25JAXJEiEIKcjwC+hMLRQEy+jEPYCe1TJ4jDP4F5blbJLbR8wPb5LU1t6kSzL
         GvTGOn4DfOAiU7wWWNF5VJSfg6A0SAQtM5c9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gmrUEBN/TU0biqMENVyhoYfn8KZ7Wp87NPDLMd/c9Ow=;
        b=q78Cya2mSk3P/T4UDll+ZKkPzIZrUonZAfyLvV0Ro57F5z6+5GGtmKXLBhWliNGy/C
         plyDGXz7YDJFnJA81DtyJXOPv4NTVzmCIhHiwbX+Uf2Pugg4/CC3WrXJCL2qZiqnbpXj
         z8VrgrwdFKhmJcTpgwlM7ZK1Yu4nN7KwoR9chg63Y4napboZVpeUzHPdyeh6dAPi32lS
         dwcq/LxuFtwWc9Qj27Lj3dHug3b4aJOKhT91D5TeNXgenRltoG+D4RN/lym7xJN2zj1n
         GMCE29BzKUly41d9rgmynZWBMf52mmwpzaQB6pHIqkgxPnTwvHbr6mWsnSHCI1etVmgQ
         Yv6Q==
X-Gm-Message-State: AJcUukeil4iOw/nZNZUMO8DFJxs86hhA6KgSeu3bijFbXMNdSNvVxFPH
        XWqQ5p8i2h0Bs5gh67xpLRVEMg==
X-Google-Smtp-Source: ALg8bN4tlpxGRzYxEGYUC+YZh3+JuqLlorODUe9PvmdAXcCFTtbODJhpOMmBQFDr9WJrnikvIoPR8w==
X-Received: by 2002:adf:9f10:: with SMTP id l16mr7011372wrf.206.1547631801231;
        Wed, 16 Jan 2019 01:43:21 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:596d:a8c4:e914:fdde])
        by smtp.gmail.com with ESMTPSA id k19sm115996304wre.5.2019.01.16.01.43.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Jan 2019 01:43:20 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rjw@rjwysocki.net, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, patrick.bellasi@arm.com, pjt@google.com,
        bsegall@google.com, thara.gopinath@linaro.org,
        pkondeti@codeaurora.org, quentin.perret@arm.com,
        srinivas.pandruvada@linux.intel.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v8 0/3] sched/fair: update scale invariance of PELT
Date:   Wed, 16 Jan 2019 10:43:08 +0100
Message-Id: <1547631791-16018-1-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This new version of the scale invariance patchset adds an important change
compare to v3 and before. It still scales the time to reflect the
amount of work that has been done during the elapsed running time but this
is now done at rq level instead of per entity and rt/dl/cfs_rq. The main
advantage is that it is done once per clock update and we don't need to
maintain per sched_avg's stolen_idle_time anymore. This also ensures that
all pelt signals will be always synced for a rq.

Changes since v7:
- Add patch 3 to skip updating util_est when utilization is higher than
  cpu's capacity

Vincent Guittot (3):
  sched/fair: move rq_of helper function
  sched/fair: update scale invariance of PELT
  sched/pelt: skip updating util_est when utilization is higher than
    cpu's capacity

 include/linux/sched.h   |  23 +++-------
 kernel/sched/core.c     |   1 +
 kernel/sched/deadline.c |   6 +--
 kernel/sched/fair.c     |  72 ++++++++++++++-----------------
 kernel/sched/pelt.c     |  45 +++++++++++---------
 kernel/sched/pelt.h     | 111 ++++++++++++++++++++++++++++++++++++++++++++++--
 kernel/sched/rt.c       |   6 +--
 kernel/sched/sched.h    |  28 +++++++++++-
 8 files changed, 206 insertions(+), 86 deletions(-)

-- 
2.7.4

