Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E8FC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CEFB2089E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="B0YQOoaw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CEFB2089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731274AbeHPTvk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 15:51:40 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35749 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731207AbeHPTvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 15:51:39 -0400
Received: by mail-wm0-f65.google.com with SMTP id o18-v6so4985504wmc.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 09:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MFwx1lYhKb+srSCn4IHsLo9KuWJaInJYfQS9cQKsfGY=;
        b=B0YQOoawMAWJoKCm802FdEDxe+UJlMEdwCA5khaGmZ6p39K7Gw81QwN3BK6cQ4Cne9
         46NGpbhJ51XNytJO+w2Guj6f4a3QM5b4DzYQ/P7Jl+3njrMM9Gl05ABT3k3fsSn5Uk0z
         9RhpKol9CpwSX/CrqFTSLyfqkPiX6+u3vJhvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MFwx1lYhKb+srSCn4IHsLo9KuWJaInJYfQS9cQKsfGY=;
        b=rN3qwnSK/ymc2Xv/W3hDSMBenIkgojngjBsVzRRcM5UDpoE+8dDQNfbbZpQoOY/wR9
         +xhOcA863G3bR1RV+t/atrkkKP0zwCQsi8DXRWz3F4gm5uqpj/2vrxLJMgqW1yrRuDAH
         frjNwBfhUjm8f0sewp+j5cpCltIxzDLdl1MXIno/Iclqa/LzJW8cot7SEAIqGDfhz9wS
         osAK4MaOaKY7GSQXAo7KRWMZJ1foq+ubBb22h9yt0VjXVGpqhSyBUu0v18PZOHpywjVr
         Wk7dia0B25//AtI6DXTTH9CuL/KzNSUlJO3GQDnRHqhGRLPuAxEkNxAF5ziAhJptuZmM
         dBvw==
X-Gm-Message-State: AOUpUlFhUrJc1ZvopAp0P5ZZtHlGRB+EZKdBaK12dJy/I/B+7WcHxiM5
        RTDTXZjdaRyFw8zSpWRNEl6lpQ==
X-Google-Smtp-Source: AA+uWPwr8H40l7SBG7TeV8yJsewmFD/cOCOvAujDeuipc9hfqW98c0U7EWYT90WTsi6YFzKCFe3qlg==
X-Received: by 2002:a1c:9550:: with SMTP id x77-v6mr15682250wmd.135.1534438320867;
        Thu, 16 Aug 2018 09:52:00 -0700 (PDT)
Received: from localhost.localdomain (146-241-5-103.dyn.eolo.it. [146.241.5.103])
        by smtp.gmail.com with ESMTPSA id o3-v6sm30036180wrj.31.2018.08.16.09.51.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Aug 2018 09:52:00 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX/IMPROVEMENT 4/4] block, bfq: improve code of bfq_bfqq_charge_time
Date:   Thu, 16 Aug 2018 18:51:18 +0200
Message-Id: <20180816165118.17402-5-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180816165118.17402-1-paolo.valente@linaro.org>
References: <20180816165118.17402-1-paolo.valente@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bfq_bfqq_charge_time contains some lengthy and redundant code. This
commit trims and condenses that code.

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-wf2q.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index d558fd26740c..ae52bff43ce4 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -881,15 +881,11 @@ void bfq_bfqq_charge_time(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 			  unsigned long time_ms)
 {
 	struct bfq_entity *entity = &bfqq->entity;
-	int tot_serv_to_charge = entity->service;
-	unsigned int timeout_ms = jiffies_to_msecs(bfq_timeout);
-
-	if (time_ms > 0 && time_ms < timeout_ms)
-		tot_serv_to_charge =
-			(bfqd->bfq_max_budget * time_ms) / timeout_ms;
-
-	if (tot_serv_to_charge < entity->service)
-		tot_serv_to_charge = entity->service;
+	unsigned long timeout_ms = jiffies_to_msecs(bfq_timeout);
+	unsigned long bounded_time_ms = min(time_ms, timeout_ms);
+	int serv_to_charge_for_time =
+		(bfqd->bfq_max_budget * bounded_time_ms) / timeout_ms;
+	int tot_serv_to_charge = max(serv_to_charge_for_time, entity->service);
 
 	/* Increase budget to avoid inconsistencies */
 	if (tot_serv_to_charge > entity->budget)
-- 
2.16.1

