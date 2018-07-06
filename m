Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5158C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D29023FCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SKK/0jQG";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SKK/0jQG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D29023FCE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933512AbeGFNRl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 09:17:41 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46702 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932995AbeGFNRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 09:17:40 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D219060B10; Fri,  6 Jul 2018 13:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530883059;
        bh=C0wZRSoBsd64ftAJtYMmcgGiDLJt1wVerCRn9qgur1Q=;
        h=From:To:Cc:Subject:Date:From;
        b=SKK/0jQG6ZP4KR2OL424/X0ENK5eFteB2Z1P0vPdv6s8MCKyGRbzN8g1caF/X1vYN
         1XFAtmf4ivfVM8PMsoj+BTizPL9tY+fBEZTOmSqZdUJTbo95EG87G/DDpMAQoSeWZ/
         uTbF73IYqSgXcPnZG73s0o2M4X/bmvFLMphcaNiM=
Received: from mojha-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 495B0606FA;
        Fri,  6 Jul 2018 13:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530883059;
        bh=C0wZRSoBsd64ftAJtYMmcgGiDLJt1wVerCRn9qgur1Q=;
        h=From:To:Cc:Subject:Date:From;
        b=SKK/0jQG6ZP4KR2OL424/X0ENK5eFteB2Z1P0vPdv6s8MCKyGRbzN8g1caF/X1vYN
         1XFAtmf4ivfVM8PMsoj+BTizPL9tY+fBEZTOmSqZdUJTbo95EG87G/DDpMAQoSeWZ/
         uTbF73IYqSgXcPnZG73s0o2M4X/bmvFLMphcaNiM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 495B0606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
From:   Mukesh Ojha <mojha@codeaurora.org>
To:     john.stultz@linaro.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Cc:     gkohli@codeaurora.org, cpandya@codeaurora.org,
        neeraju@codeaurora.org, Mukesh Ojha <mojha@codeaurora.org>
Subject: [PATCH v3] time: Fix incorrect sleeptime injection when suspend fails
Date:   Fri,  6 Jul 2018 18:47:27 +0530
Message-Id: <1530883047-17452-1-git-send-email-mojha@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, there exists a corner case assuming when there is
only one clocksource e.g RTC, and system failed to go to
suspend mode. While resume rtc_resume() injects the sleeptime
as timekeeping_rtc_skipresume() returned 'false' (default value
of sleeptime_injected) due to which we can see mismatch in
timestamps.

This issue can also come in a system where more than one
clocksource are present and very first suspend fails.

Fix this by handling `sleeptime_injected` flag properly.

Success case:
------------
                                        {sleeptime_injected=false}
rtc_suspend() => timekeeping_suspend() => timekeeping_resume() =>

(sleeptime injected)
 rtc_resume()

Failure case:
------------
         {failure in sleep path} {sleeptime_injected=false}
rtc_suspend()     =>          rtc_resume()

sleeptime injected again which was not required as the suspend failed)

Originally-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
---
Changes in v3:
 * Updated commit subject and description.
 * Updated the patch as per the fix given by Thomas Gleixner.

Changes in v2:
 * Updated the commit text.
 * Removed extra variable and used the earlier static
   variable 'sleeptime_injected'.

 kernel/time/timekeeping.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 4786df9..32ae9ae 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1510,8 +1510,20 @@ void __weak read_boot_clock64(struct timespec64 *ts)
 	ts->tv_nsec = 0;
 }
 
-/* Flag for if timekeeping_resume() has injected sleeptime */
-static bool sleeptime_injected;
+/*
+ * Flag reflecting whether timekeeping_resume() has injected sleeptime.
+ *
+ * The flag starts of true and is only cleared when a suspend reaches
+ * timekeeping_suspend(), timekeeping_resume() sets it when the timekeeper
+ * clocksource is not stopping across suspend and has been used to update
+ * sleep time. If the timekeeper clocksource has stopped then the flag
+ * stays false and is used by the RTC resume code to decide whether sleep
+ * time must be injected and if so the flag gets set then.
+ *
+ * If a suspend fails before reaching timekeeping_resume() then the flag
+ * stays true and prevents erroneous sleeptime injection.
+ */
+static bool sleeptime_injected = true;
 
 /* Flag for if there is a persistent clock on this platform */
 static bool persistent_clock_exists;
@@ -1646,6 +1658,8 @@ void timekeeping_inject_sleeptime64(struct timespec64 *delta)
 	raw_spin_lock_irqsave(&timekeeper_lock, flags);
 	write_seqcount_begin(&tk_core.seq);
 
+	sleeptime_injected = true;
+
 	timekeeping_forward_now(tk);
 
 	__timekeeping_inject_sleeptime(tk, delta);
@@ -1671,7 +1685,6 @@ void timekeeping_resume(void)
 	struct timespec64 ts_new, ts_delta;
 	u64 cycle_now;
 
-	sleeptime_injected = false;
 	read_persistent_clock64(&ts_new);
 
 	clockevents_resume();
@@ -1743,6 +1756,8 @@ int timekeeping_suspend(void)
 	if (timekeeping_suspend_time.tv_sec || timekeeping_suspend_time.tv_nsec)
 		persistent_clock_exists = true;
 
+	sleeptime_injected = false;
+
 	raw_spin_lock_irqsave(&timekeeper_lock, flags);
 	write_seqcount_begin(&tk_core.seq);
 	timekeeping_forward_now(tk);
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project

