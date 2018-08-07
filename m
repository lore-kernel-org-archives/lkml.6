Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55391C46472
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 15:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0834921984
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 15:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="G4Q2PFD8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0834921984
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390067AbeHGSLe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 14:11:34 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37749 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbeHGSLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 14:11:33 -0400
Received: by mail-wr1-f66.google.com with SMTP id u12-v6so16267505wrr.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 08:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Oi6O5vuULRS3qk8TZ9FMdKH2yubJ0L/xr/jup60upw4=;
        b=G4Q2PFD8DmvwEUMVS0nuzVo+S2aU3kQZKcbUAMd6wzw7UkIj7GM9rpuDLe/AxwuEC4
         vxj3iiC9ZEBKwjnzNvDwE6ZUo4guIdrAPfA93dcyGXf3MOTHrvNVIVC/xxzBjC009wK3
         BJdVfUqt3Ibo3WItw0+8hi9dbcEUQJ4D2jp7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Oi6O5vuULRS3qk8TZ9FMdKH2yubJ0L/xr/jup60upw4=;
        b=D75ZQeHbZKPP/BCEtr4wPJbieySVh0rBXWiFQ9NWNZ1TYCJGc4Fn2u8onoLGYbwe+L
         Vpw/NdsGMk4KAA0wh+E4az7qw036/p8BSFpQqeb7Mv4NH7VYHxGxRxYNWMUDUBXXsvGg
         vUk0NHdMniqZ51flj3J0uOprONiIWMp5thAhpqsXe8J77Y735i1ZEXYOdaK7OkrUVaqF
         kSERCkyQdr7W1pA+CvvBOS9Hj0GqRUqGfCp5xPcN/NT3Dx6Vwwyy7/nBQlrUlFHOcFnG
         jFFvsHDBm58gwiZPBIe5Wq8AOuqyqWiYjGuhgRBRLtJXuctE0wtW+xTAvlWIPGl2/1c4
         zZ2w==
X-Gm-Message-State: AOUpUlFK4TBqLw/zDUOpHjspWqvxfBp+wpoLw2Qkht5WnZvPznd7HPTY
        XbwJAcYHMH1P9oWuZbwxWU8TFw==
X-Google-Smtp-Source: AAOMgpf6gd9MjzK0qdHAY4CBGo5xg7WM92iAbQOgq+6IFZ8zsgmBNDK9kre3bpRjWh/czateXrm8Eg==
X-Received: by 2002:adf:bbd4:: with SMTP id z20-v6mr13463970wrg.183.1533657395823;
        Tue, 07 Aug 2018 08:56:35 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:41ad:95bb:4cb8:621f])
        by smtp.gmail.com with ESMTPSA id y203-v6sm2903644wmd.1.2018.08.07.08.56.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Aug 2018 08:56:34 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     valentin.schneider@arm.com, Morten.Rasmussen@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 2/3] sched/fair: trigger asym_packing during idle load balance
Date:   Tue,  7 Aug 2018 17:56:26 +0200
Message-Id: <1533657387-29039-3-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533657387-29039-1-git-send-email-vincent.guittot@linaro.org>
References: <1533657387-29039-1-git-send-email-vincent.guittot@linaro.org>
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
index c376cd0..5f1b6c6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8364,7 +8364,7 @@ static int need_active_balance(struct lb_env *env)
 {
 	struct sched_domain *sd = env->sd;
 
-	if (env->idle == CPU_NEWLY_IDLE) {
+	if (env->idle != CPU_NOT_IDLE) {
 
 		/*
 		 * ASYM_PACKING needs to force migrate tasks from busy but
-- 
2.7.4

