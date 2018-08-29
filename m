Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9468C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DAB120850
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jAhDek+j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DAB120850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbeH2RQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 13:16:15 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51629 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727204AbeH2RQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 13:16:15 -0400
Received: by mail-wm0-f66.google.com with SMTP id y2-v6so5268847wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 06:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=NqMThzsq4pYitWYL5pTdFaPZZ615qLYQAXaKuFsxLDM=;
        b=jAhDek+j9GxWC55ME9ohxUqg/BWQMy1ZHS9n8cnBvH58nFwlj+CcqaZPsrFB4HJgpx
         ker6EX5ViHuxiTVqD6lNr2nezPBqt9bIbYT57MuQQDrY7gT8is4lQHOl/lHL3VZ8KeXb
         IRKyJyu1VotyPdFdxU1hiHZT2mQvnwaUo9GnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NqMThzsq4pYitWYL5pTdFaPZZ615qLYQAXaKuFsxLDM=;
        b=M1MMtMwJY/9hwzfl+Sl4O83Xn4f5XUstH2wvrUVKWYC1C0+K/LqtbR+AoVeRL0P8wk
         G/nn0/2Mupw4gn8TAyy987ryr26RPec7pCl3eXuprIFO+OwluUvh3j4YtFFdKF6PJQLM
         3SqOK+p9LeYzjG9+HvKMkHZ0DsZqijZi60ineNNCNvQMCAADVM7F/1BoKdmcm2fmTXGC
         gHPM7DKuiCteqdns1HrfNDxypNijxEoUpzz3uLzODEuIEgX0fHQBo0/s/8MwVgtgnU25
         l+nPOs+qDluKC0wq2yq6zleBlPmJGfRASjtETVf7BO2WE6JVn40UWA4/U21dLATl/wiS
         Y9Dw==
X-Gm-Message-State: APzg51AkcRf9md9+glfKHqtVA2oMiQxgWpGQSSnGqu5hY+J6Xz+/lHDb
        ZJpMAehlLdoUUMaAPr1GvwAGvA==
X-Google-Smtp-Source: ANB0VdY7u/spnrDDuzGI3qQjvCX+8uPIp3g3d2cRnlNR1LcC3uC0vYYWFLdCJLwK5/T6Amcnj0w57w==
X-Received: by 2002:a1c:7301:: with SMTP id d1-v6mr4192759wmb.34.1535548758899;
        Wed, 29 Aug 2018 06:19:18 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:4c23:4749:7ea6:c5af])
        by smtp.gmail.com with ESMTPSA id a37-v6sm9532723wrc.21.2018.08.29.06.19.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 Aug 2018 06:19:17 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Rik van Riel <riel@surriel.com>
Subject: [PATCH 0/4] sched/numa: remove unused code
Date:   Wed, 29 Aug 2018 15:19:08 +0200
Message-Id: <1535548752-4434-1-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With:
  commit 2d4056fafa19 ("sched/numa: Remove numa_has_capacity()")
some code and fields are not used anymore.

Patch 1-2 remove the unused code.

Patch 3 goes a bit further and removes smt_gain field from sched_domain.

Patch 4 removes sd parameter from arch_scale_cpu_capacity once the last
user has been removed by patch 3

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: linux-kernel@vger.kernel.org (open list)

Vincent Guittot (4):
  sched/numa: remove unused code from update_numa_stats()
  sched/numa: remove unused nr_running field
  sched/numa: remove smt_gain
  sched/topology: remove unused sd param from arch_scale_cpu_capacity()

 arch/arm/kernel/topology.c       |  2 +-
 drivers/base/arch_topology.c     |  6 +++---
 include/linux/arch_topology.h    |  2 +-
 include/linux/sched/topology.h   |  1 -
 kernel/sched/cpufreq_schedutil.c |  2 +-
 kernel/sched/deadline.c          |  2 +-
 kernel/sched/fair.c              | 32 +++++---------------------------
 kernel/sched/pelt.c              |  2 +-
 kernel/sched/sched.h             |  7 ++-----
 kernel/sched/topology.c          |  2 --
 10 files changed, 15 insertions(+), 43 deletions(-)

-- 
2.7.4

