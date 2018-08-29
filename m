Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD90C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 081122084E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="P/Ql1Ewq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 081122084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbeH2RQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 13:16:20 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41237 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727316AbeH2RQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 13:16:19 -0400
Received: by mail-wr1-f65.google.com with SMTP id z96-v6so4808310wrb.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 06:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TO1pU8JCMBu+caKwSvxQuWK2iY1ODZK5b9aWTRPwaCg=;
        b=P/Ql1EwqHhseHyku5t1Dgwfe7jPgYorqfQ5b7LVFE80A3XWZ5nDQe3LcScSJlUTD2S
         MjAif9mZViQo/CgmYFM5L1wP6iLV3+Oj0Edzti4ex/T5ZDopjukqWI1LDAI+NkzZsdd0
         RB1Udj2qHfXbBa4mqCzypTMVxdhKed7YlMP/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TO1pU8JCMBu+caKwSvxQuWK2iY1ODZK5b9aWTRPwaCg=;
        b=RmlnU5zv6sxJ0JjqSDjqlyGPHqfK1SdriOx39QduGrTgRsTP7mGoCO5mXQ9yQ6g8xB
         xUoc71mo2tnUirun4iRlODTUmi20H58aNtyZ/yDP9GU6829i2aEqxnaja5CArgL8moZH
         sWOOB4vkSoE/BdbfpzAaPaHWoqJ42jEwedpSiB3pdDslZR3q7pTgAPpBktE25Cp8iIUW
         4qGlEX70bFVYSSkH2WKrKN096ugtoWZna4zO6SBSeFd3qE54VN8rYSyZLAH2NoFN+VSe
         DY7LugOetBxlUMCT20YFdEGJI8X6j1/bPoCdwz6pzwiJLHHqvcltlge0Ss89fWVt44go
         b/Ig==
X-Gm-Message-State: APzg51ANKuSsb49e1iNBrnNq9BF28MzroDH0Kt3Dem5fjFwRK6+18Nkr
        pIiDdbv0tRuzY1lT1mki6BAMFA==
X-Google-Smtp-Source: ANB0VdaGxjz19y3JosuBf/gRyQ/pp+EJz31vwrNffc9KO79kLONqxUNdQ7nH7Bx1/OcPffJ/UKvkZg==
X-Received: by 2002:a5d:6984:: with SMTP id g4-v6mr4191595wru.232.1535548762085;
        Wed, 29 Aug 2018 06:19:22 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:4c23:4749:7ea6:c5af])
        by smtp.gmail.com with ESMTPSA id a37-v6sm9532723wrc.21.2018.08.29.06.19.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 Aug 2018 06:19:21 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     Vincent Guittot <vincent.guittot@linaro.org>
Subject: [RFC PATCH 3/4] sched/topology: remove smt_gain
Date:   Wed, 29 Aug 2018 15:19:11 +0200
Message-Id: <1535548752-4434-4-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535548752-4434-1-git-send-email-vincent.guittot@linaro.org>
References: <1535548752-4434-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

smt_gain is used to compute the capacity of CPUs of a SMT core with the
constraint 1 < smt_gain < 2 in order to be able to compute number of CPUs
per core. The field has_free_capacity of struct numa_stat, which was the
last user of this computation of number of CPUs per core, has been removed
by :

  commit 2d4056fafa19 ("sched/numa: Remove numa_has_capacity()")

We can now remove this constraint on core capacity and use the defautl value
SCHED_CAPACITY_SCALE for SMT CPUs. With this remove, SCHED_CAPACITY_SCALE
becomes the maximum compute capacity of CPUs on every systems. This should
help to simplify some code and remove fields like rd->max_cpu_capacity

Furthermore, arch_scale_cpu_capacity() is used with a NULL sd in several other
places in the code when it wants the capacity of a CPUs to scale
some metrics like in pelt, deadline or schedutil. In case on SMT, the value
returned is not the capacity of SMT CPUs but default SCHED_CAPACITY_SCALE.

Remove the smt_gain field from sched_domain struct

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org (open list)
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 include/linux/sched/topology.h | 1 -
 kernel/sched/sched.h           | 3 ---
 kernel/sched/topology.c        | 2 --
 3 files changed, 6 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 2634774..212792b 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -89,7 +89,6 @@ struct sched_domain {
 	unsigned int newidle_idx;
 	unsigned int wake_idx;
 	unsigned int forkexec_idx;
-	unsigned int smt_gain;
 
 	int nohz_idle;			/* NOHZ IDLE status */
 	int flags;			/* See SD_* */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 4a2e8ca..b1715b8 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1758,9 +1758,6 @@ unsigned long arch_scale_freq_capacity(int cpu)
 static __always_inline
 unsigned long arch_scale_cpu_capacity(struct sched_domain *sd, int cpu)
 {
-	if (sd && (sd->flags & SD_SHARE_CPUCAPACITY) && (sd->span_weight > 1))
-		return sd->smt_gain / sd->span_weight;
-
 	return SCHED_CAPACITY_SCALE;
 }
 #endif
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 56a0fed..069c924 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1129,7 +1129,6 @@ sd_init(struct sched_domain_topology_level *tl,
 
 		.last_balance		= jiffies,
 		.balance_interval	= sd_weight,
-		.smt_gain		= 0,
 		.max_newidle_lb_cost	= 0,
 		.next_decay_max_lb_cost	= jiffies,
 		.child			= child,
@@ -1155,7 +1154,6 @@ sd_init(struct sched_domain_topology_level *tl,
 	if (sd->flags & SD_SHARE_CPUCAPACITY) {
 		sd->flags |= SD_PREFER_SIBLING;
 		sd->imbalance_pct = 110;
-		sd->smt_gain = 1178; /* ~15% */
 
 	} else if (sd->flags & SD_SHARE_PKG_RESOURCES) {
 		sd->flags |= SD_PREFER_SIBLING;
-- 
2.7.4

