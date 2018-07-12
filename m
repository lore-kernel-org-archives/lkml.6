Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F18C7ECDFB0
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 20:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B247D21480
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 20:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QBC2vYnx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B247D21480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732565AbeGLU2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 16:28:37 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45357 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732412AbeGLU2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 16:28:37 -0400
Received: by mail-pg1-f195.google.com with SMTP id n9-v6so3928429pgp.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 13:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9bUP2F3+OSzuN3gwWFejoa3QoGwS6wuL+2HP34SBFLE=;
        b=QBC2vYnxv6kQX3Iyk6/8NcPcoO6V/FaxCBhB/+oa97WPxylrjsk3Vun1OrW7LlGJWK
         B/UQjh/QpIBNg6ERC1YBsmULpAikOCRZf32kIs9y0AOxyPjwQ6fmJnfk5RkuJfoFfojp
         0qsZHWNKzkJYOQhi5Usi989nxPzWBSQBrMu1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9bUP2F3+OSzuN3gwWFejoa3QoGwS6wuL+2HP34SBFLE=;
        b=gv9xyUwweRTVNNo5PQClEFjDmDyEtv2OrBsFbBycxXID3UXfr8tscE7WQ4C9NEXFFC
         Q14l548MndCpXTNhdPlqWIIyW3MY7y//8A/0+pFJJtOdhuBwqFaPaSagfkKU9bECB86C
         ConWCOnqc4YivQEtRwWWnQ08PQ39cy97hfV7lpXv66ZVTbVDphLLwXjdJuPbUZET3vsG
         tIbbRk2U2nzUPngqdZfaanuspFjeNOQDm3Rw+6msNgoYSEvPHalDHIb7hFH4mnP+DiyI
         EOlksubDf7gEw45nQWM/Knph/3SzWhux7anv8WhIXcoAu/yoaK2riLL+6MGe296rUM2n
         fhNg==
X-Gm-Message-State: AOUpUlGwoPcPmkrnXxnEyA4uxSQsosjqNeapiNHl4RjpiBGW7tceSdEk
        K7iNePeDMAG6bOJTsx/wJC3QJc/6Wic=
X-Google-Smtp-Source: AAOMgpcsSn6IDnOhjquzZ1SxsUjitGKATZI9w972Wk3uQQxFhlSOrhn8DoxKxPu4KGEyVNbe7YmcdQ==
X-Received: by 2002:a63:bc0a:: with SMTP id q10-v6mr3382301pge.70.1531426648118;
        Thu, 12 Jul 2018 13:17:28 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:600:5100:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id e7-v6sm22647000pgc.55.2018.07.12.13.17.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Jul 2018 13:17:27 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Miroslav Lichvar <mlichvar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Prarit Bhargava <prarit@redhat.com>,
        Stephen Boyd <sboyd@kernel.org>,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH 2/2] timekeeping: Update multiplier when NTP frequency is set directly
Date:   Thu, 12 Jul 2018 13:17:21 -0700
Message-Id: <1531426641-20076-3-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531426641-20076-1-git-send-email-john.stultz@linaro.org>
References: <1531426641-20076-1-git-send-email-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miroslav Lichvar <mlichvar@redhat.com>

When the NTP frequency is set directly from userspace using the
ADJ_FREQUENCY or ADJ_TICK timex mode, immediately update the
timekeeper's multiplier instead of waiting for the next tick.

This removes a hidden non-deterministic delay in setting of the
frequency and allows an extremely tight control of the system clock
with update rates close to or even exceeding the kernel HZ.

The update is limited to archs using modern timekeeping
(!ARCH_USES_GETTIMEOFFSET).

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Miroslav Lichvar <mlichvar@redhat.com>
Cc: Richard Cochran <richardcochran@gmail.com>
Cc: Prarit Bhargava <prarit@redhat.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Miroslav Lichvar <mlichvar@redhat.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 kernel/time/timekeeping.c | 36 ++++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 4786df9..6772011 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -34,6 +34,14 @@
 #define TK_MIRROR		(1 << 1)
 #define TK_CLOCK_WAS_SET	(1 << 2)
 
+enum timekeeping_adv_mode {
+	/* Update timekeeper when a tick has passed */
+	TK_ADV_TICK,
+
+	/* Update timekeeper on a direct frequency change */
+	TK_ADV_FREQ
+};
+
 /*
  * The most important data for readout fits into a single 64 byte
  * cache line.
@@ -2021,11 +2029,11 @@ static u64 logarithmic_accumulation(struct timekeeper *tk, u64 offset,
 	return offset;
 }
 
-/**
- * update_wall_time - Uses the current clocksource to increment the wall time
- *
+/*
+ * timekeeping_advance - Updates the timekeeper to the current time and
+ * current NTP tick length
  */
-void update_wall_time(void)
+static void timekeeping_advance(enum timekeeping_adv_mode mode)
 {
 	struct timekeeper *real_tk = &tk_core.timekeeper;
 	struct timekeeper *tk = &shadow_timekeeper;
@@ -2042,14 +2050,17 @@ void update_wall_time(void)
 
 #ifdef CONFIG_ARCH_USES_GETTIMEOFFSET
 	offset = real_tk->cycle_interval;
+
+	if (mode != TK_ADV_TICK)
+		goto out;
 #else
 	offset = clocksource_delta(tk_clock_read(&tk->tkr_mono),
 				   tk->tkr_mono.cycle_last, tk->tkr_mono.mask);
-#endif
 
 	/* Check if there's really nothing to do */
-	if (offset < real_tk->cycle_interval)
+	if (offset < real_tk->cycle_interval && mode == TK_ADV_TICK)
 		goto out;
+#endif
 
 	/* Do some additional sanity checking */
 	timekeeping_check_update(tk, offset);
@@ -2106,6 +2117,15 @@ void update_wall_time(void)
 }
 
 /**
+ * update_wall_time - Uses the current clocksource to increment the wall time
+ *
+ */
+void update_wall_time(void)
+{
+	timekeeping_advance(TK_ADV_TICK);
+}
+
+/**
  * getboottime64 - Return the real time of system boot.
  * @ts:		pointer to the timespec64 to be set
  *
@@ -2327,6 +2347,10 @@ int do_adjtimex(struct timex *txc)
 	write_seqcount_end(&tk_core.seq);
 	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
 
+	/* Update the multiplier immediately if frequency was set directly */
+	if (txc->modes & (ADJ_FREQUENCY | ADJ_TICK))
+		timekeeping_advance(TK_ADV_FREQ);
+
 	if (tai != orig_tai)
 		clock_was_set();
 
-- 
2.7.4

