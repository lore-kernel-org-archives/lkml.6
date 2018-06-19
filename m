Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A3D3C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 14:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA71C2083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 14:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HJUQpTiY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA71C2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966550AbeFSOCr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 10:02:47 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53587 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966111AbeFSOCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 10:02:46 -0400
Received: by mail-wm0-f65.google.com with SMTP id x6-v6so583394wmc.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 07:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Ctd76Nwcdm/gu8YSl6riGcz8gnZ0lC31LC7xeRPsRHo=;
        b=HJUQpTiYGMPhgpNXV6da7Wyz6FS0Dwwq+EgMbTspnuP5QddMjUCTDSF3pst2usKUXb
         qD5ftzXlBkJssZMGKxYymZxqLk9jFhYYO9ml6Hf8+Nuqa43K+bbKCUkIH4NROkKferCI
         ntJ96b+eeCSR25mugoLlL0peKULO+qpcsDe1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ctd76Nwcdm/gu8YSl6riGcz8gnZ0lC31LC7xeRPsRHo=;
        b=FWfOiEZee8WeLziOjPZ1tkBWSLFxTSTh/YWc1KTdYKQeXgLPtfEtWEHnul17BGBLrL
         XPDvwkhuL1qgg2JXZUTBKO/h6HEt+iOKSDxFHw/xrcP6dpH2guCvxkergF3tMlXXr7h+
         d2RdNPBK/1D/vP6+POoVfMT8C3nuC/Hq9tfSUxOf8nUa7nJHleVvIEV0clYUCoLycwuE
         rcmn4jqDlxkHc66vHwhvcxR2GcOJX+Hd9+72EuZK2sAeDHOvgnwwUjjQ67HbI+UBhXj6
         tnAs/OPiIvmHAx/taP05ZoqzjQOBF13t44vOgPSgE91af4JD/PToRxVFaA4WHTRUdBXu
         wXlw==
X-Gm-Message-State: APt69E3LIK3zM5ep5h7jcaV/9y0yYYUZiRyJqDYSrnZcXiEJkxN4ZOqH
        w/NuBOGbjQmu+7ZIBrWeJPPx9Q==
X-Google-Smtp-Source: ADUXVKLJ2Aqd2EVZRUaOAeMDrd5vOUWoj2QY1x62wj41FCt3YKxR0vy2TQFIy8pc26YG4bEV3WwgyQ==
X-Received: by 2002:a1c:96d3:: with SMTP id y202-v6mr11674786wmd.76.1529416965190;
        Tue, 19 Jun 2018 07:02:45 -0700 (PDT)
Received: from mai.localdomain (135-224-190-109.dsl.ovh.fr. [109.190.224.135])
        by smtp.gmail.com with ESMTPSA id o16-v6sm18375298wrp.8.2018.06.19.07.02.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Jun 2018 07:02:44 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
Subject: [PATCH] sched/core: Remove useless hrtimer_active check
Date:   Tue, 19 Jun 2018 16:02:43 +0200
Message-Id: <1529416963-20271-1-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function tick_clear() checks if the timer is active and in this case
cancels the timer. However, hrtimer_cancel does the same check.

Perhaps, this test is made on purpose to skip some function calls for
efficiency reasons but if it is not the case we can safely remove it.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 kernel/sched/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d155518..aa46aa6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -218,8 +218,7 @@ void update_rq_clock(struct rq *rq)
 
 static void hrtick_clear(struct rq *rq)
 {
-	if (hrtimer_active(&rq->hrtick_timer))
-		hrtimer_cancel(&rq->hrtick_timer);
+	hrtimer_cancel(&rq->hrtick_timer);
 }
 
 /*
-- 
2.7.4

