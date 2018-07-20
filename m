Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570CFECDE5F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 00:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DC452086D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 00:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OpYAudPi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DC452086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731019AbeGTBYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 21:24:36 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34991 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729215AbeGTBYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 21:24:35 -0400
Received: by mail-pg1-f196.google.com with SMTP id e6-v6so5243774pgv.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 17:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EHPjg8dBQT3ytvd8eqbuqxN2QkOBzh0H7YT9D+lKcVU=;
        b=OpYAudPiTdNtPt5Xh8MO3qtqNeEts+PmcyT5TrsDbZ8gFsGFEvYMb2XDfb4SKw9rFa
         R8q5tOnJt3bY2T/6L+kAWyP7XNkmQoJY6bmxd1xBwTd1wtCi5K2JYe7d1BFYI7suomtP
         FNAmP1kQFCQK3d+dK1fTl4HJxWLNUKoVMdAwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EHPjg8dBQT3ytvd8eqbuqxN2QkOBzh0H7YT9D+lKcVU=;
        b=JDAl6isYW8j+XCxAdPSPw/Un72MNHgrveFep1Cxrsh9DluNeE4WrwIk18rnco6LCH3
         7msioWDcAt+N8FUakt7EBA3k8hyJmEUDYg9TIc3XjsdMQzPQsq2hIKqDI7PaPh7D1h8V
         ZM5qizv8Xti4Edy0/JkRXdvxz/mvlN/i8GPhk0TmXAN0QnJvrdB4d6l7j5x0pXz5w6Sk
         crD7ND4cWWne233jzs8MvxByGRWB/BLB8sobCK3w5GaK+qxIQ1vVp7jyASxRljfnO6JI
         qtNCtP7gTDJP9Y5xYgB2k2J9J2VQk3osYixfVN4m6iIKvu4WHpmQ+mlrrCIHqKdVL0NS
         WR/Q==
X-Gm-Message-State: AOUpUlHQH9XvdUMn+7dEBTAea2o+Gc5vm/4CQzEibhJEafscHh1ul9I+
        IBnc8UZ5FKzlcUPytT/Oe8sxnHi8gLE=
X-Google-Smtp-Source: AAOMgpciEaHOJycK6y0zv+vQNI4uqaz+feNKk/cSVg7Y5I1YmFM383/wFw768t+5Y8kU1MKyDsQejw==
X-Received: by 2002:a65:6104:: with SMTP id z4-v6mr11992199pgu.361.1532047136761;
        Thu, 19 Jul 2018 17:38:56 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:600:5100:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id x5-v6sm383881pfh.67.2018.07.19.17.38.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Jul 2018 17:38:55 -0700 (PDT)
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
Subject: [PATCH 2/5] ntp: Use kstrtos64 for s64 variable
Date:   Thu, 19 Jul 2018 17:38:44 -0700
Message-Id: <1532047127-26699-3-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532047127-26699-1-git-send-email-john.stultz@linaro.org>
References: <1532047127-26699-1-git-send-email-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Mosnacek <omosnace@redhat.com>

...instead of kstrtol with a dirty cast.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Miroslav Lichvar <mlichvar@redhat.com>
Cc: Richard Cochran <richardcochran@gmail.com>
Cc: Prarit Bhargava <prarit@redhat.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 kernel/time/ntp.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index 3eddac2..a627cae 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -1020,12 +1020,11 @@ void __hardpps(const struct timespec64 *phase_ts, const struct timespec64 *raw_t
 
 static int __init ntp_tick_adj_setup(char *str)
 {
-	int rc = kstrtol(str, 0, (long *)&ntp_tick_adj);
-
+	int rc = kstrtos64(str, 0, &ntp_tick_adj);
 	if (rc)
 		return rc;
-	ntp_tick_adj <<= NTP_SCALE_SHIFT;
 
+	ntp_tick_adj <<= NTP_SCALE_SHIFT;
 	return 1;
 }
 
-- 
2.7.4

