Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32063C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 15:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 004B82133F
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 15:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546270047;
	bh=J+jhDa++P2lAF2W8jeBH60smGdrrFUsU7A/bVOadJFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XvZrHHBK7Dj0QrYIYcgWS1lE7E/DabIYuQGXD2tecIPZ5sfphvdP70FGIw8L7CzYj
	 kdHrt9hxfhaK+Nt2RK/Hz6mqnpDvoGxv33wZhUcch2raTmSXcVythJeh81BAnnbjg3
	 8oG6esGQbye8kiDrctGT1F2PZCmTLIwcuVlJ0SDo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbeLaP1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 10:27:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:57240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727336AbeLaP1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 10:27:24 -0500
Received: from localhost.localdomain (unknown [183.128.55.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F73421720;
        Mon, 31 Dec 2018 15:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546270043;
        bh=J+jhDa++P2lAF2W8jeBH60smGdrrFUsU7A/bVOadJFk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=paySTRDSYfGNBLECZwJzDiSGrETmCUyghHyW899vSkwG93OJzMxvzlnnnxFufmFNQ
         W92T2DQycIB8QczSR4ocnewEGxEW9STI6D9nZ/YDao1OhSPbC/QNsch86JbTKeYnBC
         hX37KPg4fHGzWy9MlukRE8BuqdnOfl8sVW/S1y7o=
From:   guoren@kernel.org
To:     daniel.lezcano@linaro.org, tglx@linutronix.de
Cc:     guoren@kernel.org, linux-kernel@vger.kernel.org,
        Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH 13/14] clocksource/drivers/c-sky: fixup ftrace call-graph panic
Date:   Mon, 31 Dec 2018 23:27:04 +0800
Message-Id: <1546270024-3961-2-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546270024-3961-1-git-send-email-guoren@kernel.org>
References: <1546270024-3961-1-git-send-email-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

We must add notrace on sched_clock_read, because it's called
by ftrace_graph_caller.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 drivers/clocksource/timer-mp-csky.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-mp-csky.c b/drivers/clocksource/timer-mp-csky.c
index 3cb6dbc..183a995 100644
--- a/drivers/clocksource/timer-mp-csky.c
+++ b/drivers/clocksource/timer-mp-csky.c
@@ -97,7 +97,7 @@ static int csky_mptimer_dying_cpu(unsigned int cpu)
 /*
  * clock source
  */
-static u64 sched_clock_read(void)
+static u64 notrace sched_clock_read(void)
 {
 	return (u64)mfcr(PTIM_CCVR);
 }
-- 
2.7.4

