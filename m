Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D8C4C004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 023CD2089A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NyVks4hp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 023CD2089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbeJBOJA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 10:09:00 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38501 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbeJBOIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 10:08:48 -0400
Received: by mail-wm1-f67.google.com with SMTP id 193-v6so1082673wme.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 00:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZAZV7TSRGTTOn8i3VUsUuDTLiKlP22KY3CKFP4aWfqM=;
        b=NyVks4hpZvec6NdAmePSWZoJpMdhY7iogqMQDB5GbmG0mCsW8lfAOI0te8QVi3w2kH
         37bXm5D0BCQSh2s+RwnHte5n5eVfqwzLHi/klgLCNKneLuFDOlVGHbwvNy1sGT+pXiJW
         EXMpqhwT4A9g4F97ZO1hIFrrO3WzI07DCandc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZAZV7TSRGTTOn8i3VUsUuDTLiKlP22KY3CKFP4aWfqM=;
        b=uUTZNZrpO2Kavn/eaVSCxbOnnBcBahojdKrgy3iw2stTeel7f2YmP28pifYkWDrQLy
         MbWvRVU7tXpgF2s+jIiYStpYcUKOwyKs/0oCy4XX8SelcORVMycaLOoUy/J2iSoZZSNB
         HuE+9swwdCK3R2Az1R1EIorrgbD9MY15Iwg16h97F+gxf2BtmXbgspC8kcEJJhSauI7W
         DCYI9Un+XalEXRYM6Pfy3sAOWURVlyhC7/51XxFCSR2jDoehYzU8ap/t2spdThd0bw2u
         xJjxA+XFu5nEgdBe+nhb+nlcbsXFYzohij0IZMxo9Mvd4fW77QY3bbIZseLRwWAyetZV
         +sdA==
X-Gm-Message-State: ABuFfogEkqCBT1SerpJxyocDrwl2v5KLlJ03QF0fF/FEJ5PznfiWi1wY
        lRcwsiYydrLaN3HXFb7BNyDoOA==
X-Google-Smtp-Source: ACcGV61OPXb4fnq7ZxjP4Ux4mWoJutcU2DcmuIt2z1qBw/8DyUoSVM1E4BvnXm5ZWCyuJhhm2EHVqg==
X-Received: by 2002:a1c:c708:: with SMTP id x8-v6mr918489wmf.116.1538465217554;
        Tue, 02 Oct 2018 00:26:57 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:99b3:4272:8254:6430])
        by smtp.gmail.com with ESMTPSA id t24-v6sm3550552wra.5.2018.10.02.00.26.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Oct 2018 00:26:56 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     valentin.schneider@arm.com, Morten.Rasmussen@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [RESEND PATCH 2/3] sched/fair: trigger asym_packing during idle load balance
Date:   Tue,  2 Oct 2018 09:26:38 +0200
Message-Id: <1538465199-20176-3-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538465199-20176-1-git-send-email-vincent.guittot@linaro.org>
References: <1538465199-20176-1-git-send-email-vincent.guittot@linaro.org>
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
index 0ed99ad2..00f2171 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8460,7 +8460,7 @@ static int need_active_balance(struct lb_env *env)
 {
 	struct sched_domain *sd = env->sd;
 
-	if (env->idle == CPU_NEWLY_IDLE) {
+	if (env->idle != CPU_NOT_IDLE) {
 
 		/*
 		 * ASYM_PACKING needs to force migrate tasks from busy but
-- 
2.7.4

