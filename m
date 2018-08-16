Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C110C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0721620C0D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qdfz2LOk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0721620C0D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731201AbeHPTvj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 15:51:39 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37594 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730213AbeHPTvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 15:51:37 -0400
Received: by mail-wr1-f68.google.com with SMTP id u12-v6so4756908wrr.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 09:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3znMJbeQWkhLxICWhFJ+SqqBYPCgwq4EtBhKQqaIsps=;
        b=Qdfz2LOkYSdPyOD6TF+CsHVZ1DQJ6SPsLHaTDZx6EUtQLd23d2RMLG1E8xYieWfmi0
         35/AmLoOx83QJWTN1HZ9yU5Lspwkvbq6DJRAwJThsXqJ4BVXAZfMroynE6qWHx4R8AfY
         gF9ziapCrvqBV2WmxW7cYVl5wifsyBlZgE750=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3znMJbeQWkhLxICWhFJ+SqqBYPCgwq4EtBhKQqaIsps=;
        b=dtfH7ySeKZ/UZqjoUOjoCWE4qzuncx6g9OCBFCyTylnGQuMGJpMa//BUuK3VTOYsVf
         f3B0TWrgKiN/FaagnOB1eAIgVziEtCkl5RoERDPHdniPoRx7HchVLo57VVFYQUkcCy5p
         dZmTx95acQXMAyzq1U8bX904GOELaQ8Y1sfcTuAgMLV1mlJCcsEfdIStHfldi+VxL1dT
         p8GC0LktD5AsEuCWu2RQRwKwdQMNy++TTQHd+sLY5yos0xBhVRGtphqmxayPFBG0w6mK
         FgXTu0ETSjcfoNyNfn9i6BJ5HiAZkKR2KJnYpb04koPXAZHR1KhLP/WxKWKO+Uyks6uS
         DRow==
X-Gm-Message-State: APzg51DxyFyYMdsTYzQnyxpDd032vwdfq3Fm3g0q0EGb2hPjwpE2ADBd
        uIf4jziDlc65zYLykNqzNrUODg==
X-Google-Smtp-Source: AA+uWPwWS/QySF33dPVDrO2aBfFGPIBTJiu2eHnJV1CpMvyar4ur01j4J0pgrG6ck3LRNqv/bL4wJw==
X-Received: by 2002:adf:ac41:: with SMTP id v59-v6mr632378wrc.7.1534438318284;
        Thu, 16 Aug 2018 09:51:58 -0700 (PDT)
Received: from localhost.localdomain (146-241-5-103.dyn.eolo.it. [146.241.5.103])
        by smtp.gmail.com with ESMTPSA id o3-v6sm30036180wrj.31.2018.08.16.09.51.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Aug 2018 09:51:57 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX/IMPROVEMENT 2/4] block, bfq: always update the budget of an entity when needed
Date:   Thu, 16 Aug 2018 18:51:16 +0200
Message-Id: <20180816165118.17402-3-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180816165118.17402-1-paolo.valente@linaro.org>
References: <20180816165118.17402-1-paolo.valente@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the next child entity to serve changes for a given parent entity,
the budget of that parent entity must be updated accordingly.
Unfortunately, this update is not performed, by mistake, for the
entities that happen to switch from having no child entity to serve,
to having one child entity to serve.

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-wf2q.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index dbc07b456059..d558fd26740c 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -130,10 +130,14 @@ static bool bfq_update_next_in_service(struct bfq_sched_data *sd,
 	if (!change_without_lookup) /* lookup needed */
 		next_in_service = bfq_lookup_next_entity(sd, expiration);
 
-	if (next_in_service)
-		parent_sched_may_change = !sd->next_in_service ||
+	if (next_in_service) {
+		bool new_budget_triggers_change =
 			bfq_update_parent_budget(next_in_service);
 
+		parent_sched_may_change = !sd->next_in_service ||
+			new_budget_triggers_change;
+	}
+
 	sd->next_in_service = next_in_service;
 
 	if (!next_in_service)
-- 
2.16.1

