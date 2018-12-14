Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70627C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7440206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fb2pJjke"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729641AbeLNQCM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 11:02:12 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44456 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbeLNQCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 11:02:08 -0500
Received: by mail-wr1-f66.google.com with SMTP id z5so5910665wrt.11
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 08:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bEsSijZyC8zHwK9eeXI5Xlit0fDMhlGIwei2/4qKE5U=;
        b=fb2pJjkeqFw4gsOmDX2q3ZBWp+kyZrEWa3zh2f5JCrV4xrawRuMRAMOwX7Cv27iq2d
         WoKOl1wWuADauCD6inwCoGnp8WlRQmsT5Dwj+zKFj6vW4+yxHpoQ+T85Au5Y9LOAo6wS
         jG1gUx7otTmGq9rfG7MWhgu9pdZOK+BCC0qPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bEsSijZyC8zHwK9eeXI5Xlit0fDMhlGIwei2/4qKE5U=;
        b=On9p7VR0nQU78YNYYC8DxpYr5GDPeM0Tl1+5Pd2IBhDj5KwRiT4Zrx6euG9KH53Bvf
         5YRiSU93YaHnX+T6vkXTFSyjwgmASqssRdRTEiJERifmqqK2Oh6PFuFxO0os86P5aNa6
         SjmjkTY0R+3iwunJftrEOS/jftuQn1drWHCCIQn2b/yEgbAY/ZVQnNw1lm4qt6EKHUTu
         ZU+j8fhVkFybVTzS2Ex/COq865bRtip0EVDUydwBLfQijcoqlu6Nmvz+Yr1N6b/31X9B
         PQD+RSAUeP2o1bakV/0bRGmm4BAKEhe4lwS1vFwpUEgsL3Wy9H8wgHqWw3fBuuvAiV3h
         1PgQ==
X-Gm-Message-State: AA+aEWZ1JZKOrPkOIukdQMaN3hu9inemEt9BvO/uZDr+U+pyCwWWCZPU
        SMJg7YMvXVdjdROid642pH25gA==
X-Google-Smtp-Source: AFSGD/XuchGlHBeVXOG/LJzFTa3SeuGo7uNfq5EhYCzAbBqJ8TzG9g0vS7ADyoHlf7Y2w0r2UBuOOw==
X-Received: by 2002:adf:fd87:: with SMTP id d7mr2958962wrr.74.1544803326747;
        Fri, 14 Dec 2018 08:02:06 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:ed2e:a6ad:f6ef:ff8e])
        by smtp.gmail.com with ESMTPSA id e17sm7888738wri.36.2018.12.14.08.02.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 14 Dec 2018 08:02:05 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     valentin.schneider@arm.com, Morten.Rasmussen@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2 2/3] sched/fair: trigger asym_packing during idle load balance
Date:   Fri, 14 Dec 2018 17:01:56 +0100
Message-Id: <1544803317-7610-3-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544803317-7610-1-git-send-email-vincent.guittot@linaro.org>
References: <1544803317-7610-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

newly idle load balance is not always triggered when a cpu becomes idle.
This prevent the scheduler to get a chance to migrate task for asym packing.
Enable active migration because of asym packing during idle load balance too.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c215f7a..9591e7a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8861,7 +8861,7 @@ static int need_active_balance(struct lb_env *env)
 {
 	struct sched_domain *sd = env->sd;
 
-	if (env->idle == CPU_NEWLY_IDLE) {
+	if (env->idle != CPU_NOT_IDLE) {
 
 		/*
 		 * ASYM_PACKING needs to force migrate tasks from busy but
-- 
2.7.4

