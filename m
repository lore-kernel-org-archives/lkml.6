Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 531EEC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 14:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 257312085B
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 14:54:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 257312085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387396AbeKFAOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 19:14:21 -0500
Received: from foss.arm.com ([217.140.101.70]:45286 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbeKFAOV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 19:14:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E922A78;
        Mon,  5 Nov 2018 06:54:16 -0800 (PST)
Received: from e110439-lin.cambridge.arm.com (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4C6AC3F5CF;
        Mon,  5 Nov 2018 06:54:14 -0800 (PST)
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH v2 0/3] util_est regression fixup and cleanups
Date:   Mon,  5 Nov 2018 14:53:57 +0000
Message-Id: <20181105145400.935-1-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a respin of:

   https://lore.kernel.org/lkml/20181030160947.19581-1-patrick.bellasi@arm.com/

rebased on v4.20-rc1, which addresses Peter's comments by also adding a
couple of additional cleanup patches on top.

Tests on a 40 CPUs Intel(R) Xeon(R) CPU E5-2690 v2 @ 3.00GHz system
still reports the ~10-15% Execl Throughput improvements after applying
the first patch. Those benefits are not there if we remove the
additional test on "current == p" which Peter was asking about.

I guess the race condition described in the new inline comment I've now
added could be the reason for the additional test being required, but I
did not really verified that guess.
I've just kept both conditions but swapped them since we will probably
be more likely to call cpu_util_without() with a task which is
eventually marked as task_on_rq_queued().

The second patch is pretty simple, while the last one implements what
Peter suggested in the previous review. I did not used something similar
to sub_positive, as suggested by Peter, just because in my tests that
implementation seems to affect negatively the Execl Throughput tests
results by reducing the speedup we get with the proposed version.

Best Patrick

Patrick Bellasi (3):
  sched/fair: util_est: fix cpu_util_wake for execl
  sched/fair: util_est: mask UTIL_AVG_UNCHANGED usages
  sched/fair: add lsub_positive and use it consistently

 kernel/sched/fair.c | 85 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 64 insertions(+), 21 deletions(-)

-- 
2.18.0

