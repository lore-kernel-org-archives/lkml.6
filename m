Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EFF2ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 12:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E859C208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 12:06:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E859C208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730822AbeGMMUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 08:20:47 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34613 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729725AbeGMMUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 08:20:46 -0400
Received: by mail-wr1-f65.google.com with SMTP id c13-v6so24842639wrt.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 05:06:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ILKno5NaKUEbyMuUls0HrviOSFZetAYwzNI50BZB3s4=;
        b=ZCn/W7B4nOoSoxzq26e6Z7qAmafRzZsMcVMWzXK9VEU87PIcaoIY4fjgxNINfP1G2R
         sVxtVi3LyrMpffZtnVB3j+2lw26v8TSLNBEvY6ys2StWA6B0pAdW4SI5bzeWx2O5aNcI
         3Sz5xM2TQe8QxIxmq2gM3iCnvA7QCBPpeJNs52kPdLy5NR3oaI5lFy3mwcLOPgXYXMMg
         9P/cE9ya+DYjOY+7CHjVcu/JTuE8Qthubz3IwYawhyIyi7nzXaGygzUqqjP3Dblxkg9k
         7xZeP7MIlaFWVfxpdgN3DF5gbQz15n41fWL4CcQJ4+6ksiS7p6ysVawOHbWLy07u00Od
         N32w==
X-Gm-Message-State: AOUpUlFUQIS6OorHvyco/kfuttDPTAWyJar2t1T3i/jhbQ6TQWiJLImq
        C0uvK/rCyQdH8RSL4HlS5aCvOw==
X-Google-Smtp-Source: AAOMgpdIOiSU7tGMxrcLZuzefMYcV9mUehq2s/oKSie7dB5aVZZ7U+lgiygFlQADt6apZemPEBMISw==
X-Received: by 2002:adf:8bd7:: with SMTP id w23-v6mr4532662wra.208.1531483581564;
        Fri, 13 Jul 2018 05:06:21 -0700 (PDT)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id i6-v6sm23316328wrr.10.2018.07.13.05.06.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Jul 2018 05:06:20 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>
Cc:     Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: [PATCH 2/3] ntp: Use kstrtos64 for s64 variable
Date:   Fri, 13 Jul 2018 14:06:41 +0200
Message-Id: <20180713120642.22147-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180713120642.22147-1-omosnace@redhat.com>
References: <20180713120642.22147-1-omosnace@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

...instead of kstrtol with a dirty cast.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 kernel/time/ntp.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index 25031ffb5d25..6c764addef3e 100644
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
2.17.1

