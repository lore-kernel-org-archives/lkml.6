Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F6DECDFBD
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 00:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA93520652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 00:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jf2R5AZm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA93520652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730926AbeGTBYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 21:24:34 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33138 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729215AbeGTBYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 21:24:33 -0400
Received: by mail-pg1-f194.google.com with SMTP id r5-v6so5233821pgv.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 17:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Dw/oxzW8/jxmVrKujqloAZWpXoumHLdiLMxwHNKgBis=;
        b=Jf2R5AZmRlR1FrKf0N8PUA60L9fHAFGCMl+kwD9C5lcKya1wGSGf4qfQepewreL+M+
         1oVSk1Nid2kSvQCCPW0R9Z72a1cYhUhwzBmShS591/Pt3zhqSlTcPT8LH4RQxFavlCHb
         Cl+aKB4h9pn7BWnTyD9ePGP8+t2lB7iHB2KtU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Dw/oxzW8/jxmVrKujqloAZWpXoumHLdiLMxwHNKgBis=;
        b=IyeJ2V+nrpwzVq5WxtWK8NZ/kSMm9MVPX9BfLKxfvQ/xUDYR4LTPWeOp0CXwCmqA4D
         MokZhQK/Hj7EK8kKJvdol2Mva7sDTIcZtq93AGrtdczJYXi+CHcckME8ZrUprt9LktdJ
         rCX4JnNXldhoKRMxn+qNEjc7Mh4D+QRuL0dpp9iAOVmIUnm5Zbd5gQ7tcoY6ofMGXivH
         0zPkgtWriVfeK+X5tc9ySIlrtTZA8y9arm6SVnsFQbd09jltblV/85FHkHaLF3NdECtm
         48MyNvIyQFo4aH8/lkHs2OvA/IXcJJtVzHXQQZOXbEMenceAHYzMs56bw5YYHawzNtjI
         5heg==
X-Gm-Message-State: AOUpUlFjzosaaqYF53AkPN9b2WEU5hyN2flO0EgvQZU0iw7Cg9wMP1W1
        hfp9wcBmoJEhajlxfID0K+MvGMqZ6no=
X-Google-Smtp-Source: AAOMgpcz3LrcLWbk5etGyhitDy3l5l4zsrpDn1Vex0AgNVP/l+K+YkkpkE/cIOBnwymGSxH2sPPcgg==
X-Received: by 2002:a63:195e:: with SMTP id 30-v6mr11843169pgz.192.1532047134389;
        Thu, 19 Jul 2018 17:38:54 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:600:5100:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id x5-v6sm383881pfh.67.2018.07.19.17.38.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Jul 2018 17:38:53 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Miroslav Lichvar <mlichvar@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Prarit Bhargava <prarit@redhat.com>,
        Stephen Boyd <sboyd@kernel.org>,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH 1/5] ntp: Remove redundant arguments
Date:   Thu, 19 Jul 2018 17:38:43 -0700
Message-Id: <1532047127-26699-2-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532047127-26699-1-git-send-email-john.stultz@linaro.org>
References: <1532047127-26699-1-git-send-email-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Mosnacek <omosnace@redhat.com>

The 'ts' argument of process_adj_status() and process_adjtimex_modes()
is unused and can be safely removed.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Miroslav Lichvar <mlichvar@redhat.com>
Cc: Richard Cochran <richardcochran@gmail.com>
Cc: Prarit Bhargava <prarit@redhat.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 kernel/time/ntp.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index 10a7905..3eddac2 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -642,7 +642,7 @@ void ntp_notify_cmos_timer(void)
 /*
  * Propagate a new txc->status value into the NTP state:
  */
-static inline void process_adj_status(struct timex *txc, struct timespec64 *ts)
+static inline void process_adj_status(struct timex *txc)
 {
 	if ((time_status & STA_PLL) && !(txc->status & STA_PLL)) {
 		time_state = TIME_OK;
@@ -665,12 +665,10 @@ static inline void process_adj_status(struct timex *txc, struct timespec64 *ts)
 }
 
 
-static inline void process_adjtimex_modes(struct timex *txc,
-						struct timespec64 *ts,
-						s32 *time_tai)
+static inline void process_adjtimex_modes(struct timex *txc, s32 *time_tai)
 {
 	if (txc->modes & ADJ_STATUS)
-		process_adj_status(txc, ts);
+		process_adj_status(txc);
 
 	if (txc->modes & ADJ_NANO)
 		time_status |= STA_NANO;
@@ -735,7 +733,7 @@ int __do_adjtimex(struct timex *txc, struct timespec64 *ts, s32 *time_tai)
 
 		/* If there are input parameters, then process them: */
 		if (txc->modes)
-			process_adjtimex_modes(txc, ts, time_tai);
+			process_adjtimex_modes(txc, time_tai);
 
 		txc->offset = shift_right(time_offset * NTP_INTERVAL_FREQ,
 				  NTP_SCALE_SHIFT);
-- 
2.7.4

