Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38425C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 17:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0068E20652
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 17:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eG96rQKc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729421AbfAQRoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 12:44:24 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38393 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727488AbfAQRoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 12:44:19 -0500
Received: by mail-wr1-f66.google.com with SMTP id v13so11995935wrw.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 09:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uaMFbDW5vM+8+YXiAv83MSY7jn86Anovx+UGEgOqUgo=;
        b=eG96rQKcFDARA+T56ZPel3qPYMvZY17GJQHiufMe2UrmJUbvHXxyYWuuA0odZAKgRU
         a/NuFZ5N7FUeQoqaCioqPiSPOkSS9/ATjS4+C2cZsSOSaY6VUU6dqwxo8EzPhNheMPdW
         QSPEoNOIceDz4tuuJsoIzmL1B5CGfFAtlHVxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uaMFbDW5vM+8+YXiAv83MSY7jn86Anovx+UGEgOqUgo=;
        b=TwRyd50xTBM46gGo60jv3ygvmWDCrcQc2eXjBVPqV5anvgwaY9WxBoQa3WkN9A6SF5
         hchCd2d/RzcXCy1p3hKFWAKxFC3PPJKyDtC1Sz5qBMBBRbwTxsQDCTxkzbBcTvAVD730
         CWldk9tBZVnt/QpVtb32LPvyvgE1zLXAdRyxhzzqSt5hzThk2Kc4gstpVORZWTEPLY3x
         BB90i0lgwW3F/LROP3i4dWQ0HSHmVRnKwhByEVNF1MqBrhFboJlHEXIi501/zPLxY6Fk
         TvjBnnGvc1oTTYW1E4mOHc695AuBQHLph7uL+0fGvo/aBp/8CSvFHG0EyAyh8FRr70ls
         Rdaw==
X-Gm-Message-State: AJcUukcbvtjRe5aeuV5hEDnVh4qsRGVmKTsE2L8FCRgTmnhD+9p45lEq
        kFfk9Ifk1m8YN8xmvoqgQBZuxqn2w2CP4A==
X-Google-Smtp-Source: ALg8bN4QzvYxTIZXXUAZRYJ3aVkCYVLiX9jEagCkh05D2TpwW+TdKP/okfihElKSR9vD497i1NdiDw==
X-Received: by 2002:a5d:6684:: with SMTP id l4mr14022779wru.154.1547747057358;
        Thu, 17 Jan 2019 09:44:17 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:8435:96d6:e03:9e78])
        by smtp.gmail.com with ESMTPSA id i186sm47583622wmd.19.2019.01.17.09.44.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 17 Jan 2019 09:44:16 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     valentin.schneider@arm.com, Morten.Rasmussen@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v4 2/3] sched/fair: trigger asym_packing during idle load balance
Date:   Thu, 17 Jan 2019 18:44:08 +0100
Message-Id: <1547747049-6320-3-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547747049-6320-1-git-send-email-vincent.guittot@linaro.org>
References: <1547747049-6320-1-git-send-email-vincent.guittot@linaro.org>
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
index 1e4bed4..bd3b0ac 100644
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

