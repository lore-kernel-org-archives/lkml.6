Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F197BC46464
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 16:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8818219C4
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 16:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aAes6E+f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8818219C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbeHLSsk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 14:48:40 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37636 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728333AbeHLSsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 14:48:39 -0400
Received: by mail-wm0-f65.google.com with SMTP id n11-v6so6448455wmc.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Aug 2018 09:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V/KD4PZAGRjRkYZ8ZQmu8anS2A7JIpWJS7JiZdKweu4=;
        b=aAes6E+f295M09g4lYl2w+zmOWFBPesp3HWKkqOQ5wPP5kvZPb7W5oWINgh1HcevCw
         oqkiFY51eG1PKuRYLMhZ+6B5AcRNNzTuCtfUB5xloqeK9tSAkUa15MIGFDbIYy9AmU8N
         AYXGe4AeVpuXtaiZrDMTZjIay1m0kZOJIQcQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V/KD4PZAGRjRkYZ8ZQmu8anS2A7JIpWJS7JiZdKweu4=;
        b=L1najRhW8bTOVt9ytHbj5fv9RDbv55qIvZ15fkaXdgX5uJSCkfQN5TVyNWc+nDhRxV
         rftW/XSAH1CajoKyaxLZA16fENKs2Gl/i0FS2X1gHgveNjVgk//eWYJRC/39UrmP5tBa
         gVD6+bihaqNwDQnJeeycFKMWspBRrSkoh3+cDIzcs3uaqnSfsaeRZ7I8W/ClcEbtHQI+
         WSLr22BJ1UK0aqn62Mw1/gI+XO69Ku314RgtiRjr0WQLcQQwFrWHTgKnQhQt96/kdQco
         l5Bk6B5Um3HXqyJrwW0VNk/Ej5chzTbl3rwmS4B5j6NRoEcMD+4S7NlrtJwgu2uwbKh6
         DijQ==
X-Gm-Message-State: AOUpUlEDXu1XJXvafHg/Wiig2zlwvyftDH6xdEUqA8YanwLLETHsczle
        pocWxOY0F7RjSB5a3TfmfrDnvg==
X-Google-Smtp-Source: AA+uWPwUjljUvyDSo5RIJEKnpg6GAQDUGnFPU/b15XwILTLs5Oxj4ZvrxXpODptJ+gh11ntgmMPFYA==
X-Received: by 2002:a1c:4885:: with SMTP id v127-v6mr5928679wma.161.1534090207747;
        Sun, 12 Aug 2018 09:10:07 -0700 (PDT)
Received: from localhost.localdomain ([45.76.138.171])
        by smtp.gmail.com with ESMTPSA id t6-v6sm7437369wmf.8.2018.08.12.09.10.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 12 Aug 2018 09:10:06 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ramesh Thomas <ramesh.thomas@intel.com>,
        linux-kernel@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 4/5] cpuidle: menu: Don't stay in shallow state for a long time
Date:   Mon, 13 Aug 2018 00:09:30 +0800
Message-Id: <1534090171-14464-5-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534090171-14464-1-git-send-email-leo.yan@linaro.org>
References: <1534090171-14464-1-git-send-email-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid staying in a shallow state for a long time, the menu governor
relies on not stopping tick when detects the prediction is shorter than
the tick event.  This is just luckily to cover most cases but cannot say
it is completely safe.  For example, if the prediction is 2000us and the
TICK_USEC=1000 so it's impossible to meet the condition
'data->predicted_us < TICK_USEC' and this lead to stop the tick for a
shallow state; finally the CPU is possible to stay in this shallow state
for very long time.

This patch checks the candidate idle state isn't deepest one and find if
the timer will come after more than 2 times of the maximum target
residency, though the governor selects a shallow state according to
prediction, due the timer is most reliable waken up source but it will
come very late, so the CPU has chance to stay in the shallow state
for a long time; the patch doesn't stop the tick for this case so can
avoid powernightmares issue.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/cpuidle/governors/menu.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index 4f02207..566c65c 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -284,6 +284,10 @@ static unsigned int get_typical_interval(struct menu_device *data)
 static bool menu_decide_stopping_tick(struct cpuidle_driver *drv,
 				      struct menu_device *data, int idx)
 {
+	int max_target_residency;
+
+	max_target_residency = drv->states[drv->state_count-1].target_residency;
+
 	/*
 	 * If the tick has been stopped yet, force to stop it afterwards and
 	 * don't give chance to set *stop_tick to false.
@@ -302,6 +306,23 @@ static bool menu_decide_stopping_tick(struct cpuidle_driver *drv,
 	if (data->predicted_us < TICK_USEC)
 		return false;
 
+	/*
+	 * The candidate idle state isn't deepest one, on the other hand
+	 * the most reliable wakeup source is timer (compare against to
+	 * interrupts) says it will come after more than 2 times of maximum
+	 * target residency, this means the CPU has risk to stay in shallow
+	 * state for more than 2 times of maximum target residency.
+	 *
+	 * It's acceptable to stay in the shallow state at this time but we
+	 * need to ensure to wake up the CPU by tick to check if has better
+	 * choice.  Finally it can have choice to select deeper state and
+	 * avoid the CPU staying in shallow state for very long time and
+	 * without any wake up event.
+	 */
+	if (idx < drv->state_count - 1 &&
+	    data->next_timer_us > max_target_residency * 2)
+		return false;
+
 	/* Otherwise, let's stop the tick at this time. */
 	return true;
 }
-- 
2.7.4

