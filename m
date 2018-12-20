Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C58C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 07:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3B5921720
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 07:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y/N7UaR0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730757AbeLTHz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 02:55:58 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54646 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727232AbeLTHzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 02:55:55 -0500
Received: by mail-wm1-f66.google.com with SMTP id a62so924272wmh.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 23:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SlBtkRSyk5NHoysVqYAQ3q4Z+DHM3H/qzoVSFkfbj34=;
        b=Y/N7UaR01MZ9zjpYKlA8dpIHsDzdewGmTT3wypxGl4ygv2VkfO1P4nR2S8uOeueKSZ
         zZUniYt9zSX+rfSOi/TbO4RJS44jzYP0ZPQ8cQkYDcUlz9YJTmYy6PjiwLYqbOgVqXMG
         mmVlZxOKPoealoTCkYLFb9cuLZlLuikDdu05k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SlBtkRSyk5NHoysVqYAQ3q4Z+DHM3H/qzoVSFkfbj34=;
        b=KA0tiTSsFXcWnBAM4/Ee0iSwSYdq3TaFHEweWfyae0GPVG4QRyJLpN0FQaQtLdcmGi
         O02OTW01NiLeHOne35jhnqatEJdaVuRQ3rQAaN1rt/xeS5iDdaSq0P4pn0IKbsrCpm57
         2JrU/ZMivm+c9R15/4eXXvlbTzseUv1NZZaDjsIuAGZA2Bbn+tLPWbS+e4FCszyh7mNY
         /18XroZd3TpjrarcNJ1vR8VlNErQparKtZi0OOMxPPZ1MTXNHMhgvH7ObdSdds1IejW3
         HDhFctyL7r6+ff9aHPfXImoCVb/oBuMKq1JXCwEH8c5mT20GWfbmbZnElbNUSnpE1Mee
         L/RA==
X-Gm-Message-State: AA+aEWZf0mv+kv/kWp46yKM2QupNstvmwtp97hvDfjGEHPXrNKB7JLwV
        tB0QYMvQKIy2Yjlidr62TMgGcQ==
X-Google-Smtp-Source: AFSGD/XQYopALI/pkeP6q0h8RuLSk57zU0MTeqJByWJ7M2aSqKWHGSJKiNgVFgdRcr8bgxNbgdhKHQ==
X-Received: by 2002:a1c:9d57:: with SMTP id g84mr9612559wme.16.1545292553240;
        Wed, 19 Dec 2018 23:55:53 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:f9b3:37c1:b11a:64ce])
        by smtp.gmail.com with ESMTPSA id c10sm8773299wrw.49.2018.12.19.23.55.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Dec 2018 23:55:52 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     valentin.schneider@arm.com, Morten.Rasmussen@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 2/3] sched/fair: trigger asym_packing during idle load balance
Date:   Thu, 20 Dec 2018 08:55:46 +0100
Message-Id: <1545292547-18770-3-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545292547-18770-1-git-send-email-vincent.guittot@linaro.org>
References: <1545292547-18770-1-git-send-email-vincent.guittot@linaro.org>
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
index 9b31247..487c73e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8853,7 +8853,7 @@ static int need_active_balance(struct lb_env *env)
 {
 	struct sched_domain *sd = env->sd;
 
-	if (env->idle == CPU_NEWLY_IDLE) {
+	if (env->idle != CPU_NOT_IDLE) {
 
 		/*
 		 * ASYM_PACKING needs to force migrate tasks from busy but
-- 
2.7.4

