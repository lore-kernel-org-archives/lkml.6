Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6EB9C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 14:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 947AD2186A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 14:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Iqjwx8o+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730562AbeLTOyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 09:54:38 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52161 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729217AbeLTOyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 09:54:38 -0500
Received: by mail-wm1-f68.google.com with SMTP id b11so2355058wmj.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 06:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1aBp5LxJH6+t5l6K90aaA3r7dWGab6glXC9WTdCKErQ=;
        b=Iqjwx8o+MdK/BIDth34Ad0ep1dkGMIQo4l5cJ1CxpXzUu9Vfro1MiOM1ySk615h0Wo
         a1yfcwPgyQcGiyryN+hPY38b7+JhXKO8nahSpUn97lFvSWm15md/Dx6c6JjcgErPmN3V
         oHT40nKHZXpaMFnZzZ1aZvTCpsMkQGi2gzY9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1aBp5LxJH6+t5l6K90aaA3r7dWGab6glXC9WTdCKErQ=;
        b=mR9gVY1enOQKUyqHjQwl889ifFmGxiCMvvJcV5x6sEwe/gnNIcwgm6K4e7mdMrXcgZ
         lVJ5hWEojf4Ge4eFU9nO38SMNydLtZiqi1J26i9RcMC36kuRf+JEGSYoV/7Z9UeQCLoF
         dIPysZRXvHljn8J7CmLaNKcNX+3xx4TX3sLraHMAECSDXp+JjQii73k7kP+VlDe55ZjU
         HU9kuhS4VS2oBnAC/SE8gsyAvflKJ0KDEntoBCbHphsWX17DBrG6CgFNw53jzTWaGTHe
         S4ItsIdgC8seE0NOunA6G+SF7kbl+jMEQRYr7JpP3ZDDAhqUZS3Oo6lXedg6BCNSqC/w
         bYAQ==
X-Gm-Message-State: AA+aEWYjlPETq6vukyBY0i4o3JxZBVmT3KV+1F9JRGEF+nFbwrGXyC4C
        sWm4Dc9aZmbcYP+WPIT8c/62y4fHSj42KQ==
X-Google-Smtp-Source: AFSGD/XZHDS4cLDIMcYh0zDp5KF+qyTgyywbJoDBzo91lXIB2OKq8yQVy0v+hu5nyAB1VwHrmSqt2w==
X-Received: by 2002:a1c:c60e:: with SMTP id w14mr12555103wmf.18.1545317676000;
        Thu, 20 Dec 2018 06:54:36 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:f9b3:37c1:b11a:64ce])
        by smtp.gmail.com with ESMTPSA id h131sm10118802wmd.17.2018.12.20.06.54.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Dec 2018 06:54:35 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     valentin.schneider@arm.com, Morten.Rasmussen@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v4 1/3] sched/fair: fix rounding issue for asym packing
Date:   Thu, 20 Dec 2018 15:54:30 +0100
Message-Id: <1545317670-10490-1-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545292547-18770-2-git-send-email-vincent.guittot@linaro.org>
References: <1545292547-18770-2-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When check_asym_packing() is triggered, the imbalance is set to :
  busiest_stat.avg_load * busiest_stat.group_capacity / SCHED_CAPACITY_SCALE
But busiest_stat.avg_load equals :
  sgs->group_load *SCHED_CAPACITY_SCALE / sgs->group_capacity
These divisions can generate a rounding that will make imbalance slightly
lower than the weighted load of the cfs_rq.
But this is enough to skip the rq in find_busiest_queue and prevents asym
migration to happen.

Directly set imbalance to busiest's sgs->group_load to remove the rounding.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/fair.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ca46964..1e4bed4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8476,9 +8476,7 @@ static int check_asym_packing(struct lb_env *env, struct sd_lb_stats *sds)
 	if (sched_asym_prefer(busiest_cpu, env->dst_cpu))
 		return 0;
 
-	env->imbalance = DIV_ROUND_CLOSEST(
-		sds->busiest_stat.avg_load * sds->busiest_stat.group_capacity,
-		SCHED_CAPACITY_SCALE);
+	env->imbalance = sds->busiest_stat.group_load;
 
 	return 1;
 }
-- 
2.7.4

