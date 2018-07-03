Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC4A3C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 19:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A138924592
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 19:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Im2K1+9t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A138924592
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752786AbeGCTge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 15:36:34 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35922 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752105AbeGCTgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 15:36:32 -0400
Received: by mail-pf0-f193.google.com with SMTP id u16-v6so1486484pfh.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 12:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=pGrxGNn7UAs9qvT/dbK1Fzjj6AmfYYcIWE9WhtcC8u4=;
        b=Im2K1+9tDfAoMQklXs+XckHWYeAfa9jVIkxDJlq9bL8DealfUTb3gmzLozotNunVrF
         ZRQUtlXpTnGcxr2EuwxVMJUdlIQEeC1yv302LzsPfoS4Bd8VFqONnLC+U0YOp+PVs2nX
         U7JaHwAve4AlXrCh4N97pwWsUEu82b5+SXl+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pGrxGNn7UAs9qvT/dbK1Fzjj6AmfYYcIWE9WhtcC8u4=;
        b=JVPpl9lqHQV9Ja46VB/r4zaPcoFHALeKjbyuZFhCgt4zAGYbvJunx4bsJLMhDdJ62+
         oMHohY/mu8kA83I1EjEmgzqGzqAgJR0I2T+I2hRpQvZbp7nJo9QTjFpO/2b6+EcuGyP7
         ElWZnrqyqRaeWo+zKpOd2EXXRriJ+3iVyXqFUbsoUzGzzRAY8Y9xrBLvy8tOJqjT58uL
         Er7MXBkFfEffXEZNAjKNvbjUOp76Zsp1wkdQMvXgbCjGuIfkAO5cAv98xAO7xalf37r9
         R4ecZv9jTM4QkkCAgna543B9r1m38loaf5WFfV0hXRzxfo4lCsJp58klPP8WKhBoNYTj
         SrkA==
X-Gm-Message-State: APt69E2O0FxJ/JYSz0ZIvFhaQ2zzGlK+2qYsBJ1nYC1IoR+0scAOW0k8
        rxK9VCedJBTHw07Im1+uyD3HoRJck9w=
X-Google-Smtp-Source: AAOMgpd1uPsnKl5w9E3KnqgSwtPJKxQ4b9uPNlJKN32ZiTDu6PWOyoYWqyzU0DssKQcZhq3hdoVh3w==
X-Received: by 2002:a63:ec14:: with SMTP id j20-v6mr8514017pgh.28.1530646591108;
        Tue, 03 Jul 2018 12:36:31 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:600:5100:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id e10-v6sm3132905pgv.48.2018.07.03.12.36.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Jul 2018 12:36:30 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Miroslav Lichvar <mlichvar@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Prarit Bhargava <prarit@redhat.com>,
        Stephen Boyd <sboyd@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: [RFC][PATCH] selftest: timers: Tweak raw_skew to SKIP when ADJ_OFFSET is in progress
Date:   Tue,  3 Jul 2018 12:36:27 -0700
Message-Id: <1530646587-12101-1-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the past we've warned when ADJ_OFFSET was in progress, usually
caused by ntpd or some other time adjusting daemon running in non
steady sate, which can cause the skew calculations to be incorrect

Thus, this patch sets a flag which we check when we fail so that
we don't cause false negatives.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Miroslav Lichvar <mlichvar@redhat.com>
Cc: Richard Cochran <richardcochran@gmail.com>
Cc: Prarit Bhargava <prarit@redhat.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
Suggested-by: Miroslav Lichvar <mlichvar@redhat.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 tools/testing/selftests/timers/raw_skew.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/timers/raw_skew.c b/tools/testing/selftests/timers/raw_skew.c
index ca6cd14..d3fc453 100644
--- a/tools/testing/selftests/timers/raw_skew.c
+++ b/tools/testing/selftests/timers/raw_skew.c
@@ -94,6 +94,7 @@ int main(int argv, char **argc)
 	struct timespec mon, raw, start, end;
 	long long delta1, delta2, interval, eppm, ppm;
 	struct timex tx1, tx2;
+	int adj_offset_bad = 0;
 
 	setbuf(stdout, NULL);
 
@@ -108,8 +109,10 @@ int main(int argv, char **argc)
 	start = mon;
 	delta1 = diff_timespec(mon, raw);
 
-	if (tx1.offset)
+	if (tx1.offset) {
 		printf("WARNING: ADJ_OFFSET in progress, this will cause inaccurate results\n");
+		adj_offset_bad = 1;
+	}
 
 	printf("Estimating clock drift: ");
 	sleep(120);
@@ -134,6 +137,10 @@ int main(int argv, char **argc)
 	printf(" %lld.%i(act)", ppm/1000, abs((int)(ppm%1000)));
 
 	if (llabs(eppm - ppm) > 1000) {
+		if (adj_offset_bad) {
+			printf("	[SKIP]\n");
+			return ksft_exit_skip("ADJ_OFFSET in progress. Shutdown NTPd or other time steering daemons\n");
+		}
 		printf("	[FAILED]\n");
 		return ksft_exit_fail();
 	}
-- 
2.7.4

