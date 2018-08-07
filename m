Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6FEBC46473
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 15:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 919A821984
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 15:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CZGyoVQE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 919A821984
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390081AbeHGSLf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 14:11:35 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33083 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388481AbeHGSLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 14:11:34 -0400
Received: by mail-wr1-f66.google.com with SMTP id g6-v6so16284482wrp.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 08:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zsbT0P20/sYtkb53CZMMxTX0UzHPPoWw6TQr3C9fHXs=;
        b=CZGyoVQEbRJTOPIWdQDZjNw6wGPqEVRUM/eKPkzdL8HEZZG9q4PLdESaURmaXDmfEI
         edsUe5Jk90EF8XmG8g0iV0AFe+F0RZA6vguo5bqt/w6Mi7pvZQKSWds1JuK2A1AUrTc3
         InhsmpJcKSJsfboerQhNENN9WE2e3mvPoAs/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zsbT0P20/sYtkb53CZMMxTX0UzHPPoWw6TQr3C9fHXs=;
        b=OTL4UE7ywFpzZCWzZOrz87tTdAzgS6IpwiUZNk9RnU6UZQTylpENjp2OqqXAP2eyPu
         pbhcZK4cZ4+IlyD9VqBCIq2KMnVsJ7yC/GNHT1Omvb0Mp89YhBtkZVc1kcF4omZaovLu
         twDn/6/MCzsk6efBOWfBtDRlMNb9hQ3IsvhzNBkrOSqJKR0kmCrskSXF1mqohmcGSivJ
         RtlnSleQDoxRpbZlnovEu71d1/GWcVut58aZvajv2oabIC6AzMrE3l1oIDRSC6QxpMqd
         N3akdTxB8OrtjuByCZxFAxq/ZtyzFe3V+Fl6/QsIm1YRkfKshfGOIQP5Ek2im04KdA5a
         HZCg==
X-Gm-Message-State: AOUpUlHOoaep0LUiKLFFOc4FObYlK5bdmqg719MriTVHglslDbpuap/i
        rdWETFeRJcQFPlLBUVJjWU17S41/nFU=
X-Google-Smtp-Source: AAOMgpd0FyCjhSpY5Sbco+gT6A7SrQNvwCLSJP6ZdWigixFAMID5DA35nRniitc0J2qAS4lSFJIeXg==
X-Received: by 2002:adf:a197:: with SMTP id u23-v6mr13916157wru.50.1533657396773;
        Tue, 07 Aug 2018 08:56:36 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:41ad:95bb:4cb8:621f])
        by smtp.gmail.com with ESMTPSA id y203-v6sm2903644wmd.1.2018.08.07.08.56.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Aug 2018 08:56:36 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     valentin.schneider@arm.com, Morten.Rasmussen@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 3/3] sched/fair: fix unnecessary increase of balance interval
Date:   Tue,  7 Aug 2018 17:56:27 +0200
Message-Id: <1533657387-29039-4-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533657387-29039-1-git-send-email-vincent.guittot@linaro.org>
References: <1533657387-29039-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of active balance, we increase the balance interval to cover
pinned tasks cases not covered by all_pinned logic. Neverthless, the active
migration triggered by asym packing should be treated as the normal
unbalanced case and reset the interval to default value otherwise active
migration for asym_packing can be easily delayed for hundreds of ms
because of this all_pinned detection mecanism.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5f1b6c6..ceb6bed 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8360,22 +8360,32 @@ static struct rq *find_busiest_queue(struct lb_env *env,
  */
 #define MAX_PINNED_INTERVAL	512
 
-static int need_active_balance(struct lb_env *env)
+static inline bool
+asym_active_balance(enum cpu_idle_type idle, unsigned int flags, int dst, int src)
 {
-	struct sched_domain *sd = env->sd;
-
-	if (env->idle != CPU_NOT_IDLE) {
+	if (idle != CPU_NOT_IDLE) {
 
 		/*
 		 * ASYM_PACKING needs to force migrate tasks from busy but
 		 * lower priority CPUs in order to pack all tasks in the
 		 * highest priority CPUs.
 		 */
-		if ((sd->flags & SD_ASYM_PACKING) &&
-		    sched_asym_prefer(env->dst_cpu, env->src_cpu))
-			return 1;
+		if ((flags & SD_ASYM_PACKING) &&
+		    sched_asym_prefer(dst, src))
+			return true;
 	}
 
+	return false;
+}
+
+static int need_active_balance(struct lb_env *env)
+{
+	struct sched_domain *sd = env->sd;
+
+
+	if (asym_active_balance(env->idle, sd->flags, env->dst_cpu, env->src_cpu))
+		return 1;
+
 	/*
 	 * The dst_cpu is idle and the src_cpu CPU has only 1 CFS task.
 	 * It's worth migrating the task if the src_cpu's capacity is reduced
@@ -8650,7 +8660,8 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 	} else
 		sd->nr_balance_failed = 0;
 
-	if (likely(!active_balance)) {
+	if (likely(!active_balance) ||
+	    asym_active_balance(env.idle, sd->flags, env.dst_cpu, env.src_cpu)) {
 		/* We were unbalanced, so reset the balancing interval */
 		sd->balance_interval = sd->min_interval;
 	} else {
-- 
2.7.4

