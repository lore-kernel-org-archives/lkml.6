Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12750C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 15:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D003B2184C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 15:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YcQr61jE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbfAWP1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 10:27:04 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38660 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfAWP1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 10:27:03 -0500
Received: by mail-wr1-f66.google.com with SMTP id v13so2945992wrw.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 07:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=yDbLpLuFIYkQ/guw0fQcvFkfPx76c/HlYc76JQ9aqCk=;
        b=YcQr61jEhiqDlC8X/xV4H6vt25/kFqr9U+e8tQpVkD+2M0wGoCech4EibZ47SBz80k
         nP//wMQ8FPCvNu5aDI4qmAUdhfWXoi1+Rit7W25p4wdF+KIIbw/TSDyFWAfj7A04lymZ
         gPOvxvMJ3WLcQ+XcxhN1zAAz/aD2ujJ9euJsg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yDbLpLuFIYkQ/guw0fQcvFkfPx76c/HlYc76JQ9aqCk=;
        b=ujngIwRuAfbaZdzM7Gj+LOd95+hMtbzOhGgBmy+9fNP+++OJP9PBtyKh42gAvBWJoQ
         Yfgqk05NSGHIVmq6ZhpObvE11rhIR/Tp5eGiX2a5iKgti2s+dtwILkWzXJM8YnzxYMJy
         Y0Mzq8iAybptZazGKcx1JNVlCz8tHTrGIYPk1DBnqpHiLJCJFc/50Q6FqDhq+qFZ/kNU
         hBlmNclz3cJK6R3HNvC6Mk/POa6wYE8rMMNTmkA9rPCZY3I4yDV9B74Ba0I8qU3+oNhu
         0CTuKq7I/Zy5VXbERJ7qfB9bADqUQSlrrLaDZMrCwUx9UbIVICrtO9t4iMdVjVMjZfZl
         6ahg==
X-Gm-Message-State: AJcUukd3QHtlwObXxfHdNA0Lu4an1eqO3VHkKnoldJtXOOv82NnOiQHU
        rODh2aivEAoADkI6g9tDvpbs8w==
X-Google-Smtp-Source: ALg8bN7m4cb7/KqiHU5QygfWxFu5/6GJJKkv9iV4uiZubyDpDTeeozFmr2lhcEt/7K1eT65jHn4uqQ==
X-Received: by 2002:a5d:49cd:: with SMTP id t13mr3360682wrs.144.1548257221426;
        Wed, 23 Jan 2019 07:27:01 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:5ca6:2921:648b:56b6])
        by smtp.gmail.com with ESMTPSA id b13sm92938536wrn.28.2019.01.23.07.27.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Jan 2019 07:27:00 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rjw@rjwysocki.net, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, patrick.bellasi@arm.com, pjt@google.com,
        bsegall@google.com, thara.gopinath@linaro.org,
        pkondeti@codeaurora.org, quentin.perret@arm.com,
        srinivas.pandruvada@linux.intel.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v9 0/3] sched/fair: update scale invariance of PELT
Date:   Wed, 23 Jan 2019 16:26:51 +0100
Message-Id: <1548257214-13745-1-git-send-email-vincent.guittot@linaro.org>
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

Changes since v8:
- add lockdep and clock updated check in rq_clock_pelt()

Vincent Guittot (3):
  sched/fair: move rq_of helper function
  sched/fair: update scale invariance of PELT
  sched/pelt: skip updating util_est when utilization is higher than
    cpu's capacity

 include/linux/sched.h   |  23 +++-------
 kernel/sched/core.c     |   1 +
 kernel/sched/deadline.c |   6 +--
 kernel/sched/fair.c     |  72 ++++++++++++++----------------
 kernel/sched/pelt.c     |  45 ++++++++++---------
 kernel/sched/pelt.h     | 114 ++++++++++++++++++++++++++++++++++++++++++++++--
 kernel/sched/rt.c       |   6 +--
 kernel/sched/sched.h    |  28 +++++++++++-
 8 files changed, 209 insertions(+), 86 deletions(-)

-- 
2.7.4

