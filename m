Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55B9C65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 14:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AAB7206B2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 14:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iaRVm2Ht"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AAB7206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729222AbeJEVfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 17:35:41 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55774 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728817AbeJEVfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 17:35:41 -0400
Received: by mail-wm1-f65.google.com with SMTP id 206-v6so2091790wmb.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 07:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=c5HF0jYr16gGL3z80h5CxAC4aDebU06EfnaFYSLQo/4=;
        b=iaRVm2HtOmekIFfY/MELV+xm5Z1md/XXjowsvuSjMENN2m1CSLffgFAF4Vt1b3T0b/
         cBq13e4xgrF9LxrQt9Oi+dech1sbqM3xPi5/JylqmQG1WvAStaQ3kJ/O2sXqimuKv1j4
         6zr3oCYqcUOjx+4DIa21VlV6xTAXcdaxD1JGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=c5HF0jYr16gGL3z80h5CxAC4aDebU06EfnaFYSLQo/4=;
        b=lFz/ppI5bU/fMpEnb0fwCHnatVt/xRY7gNj2xm7Hgw17+BCcxsWyqW+1oNFH9Ei0B5
         3PTf7vTR6PqzK/3m3hML+NYHAr51n8o8cl8s5dQSZiqiVB9/Q4mgZtnmeZs842o/ykv1
         P4DY1ikjkDZD7suzPVd18mHE7slJYUWGLML+2/AmoNNZ4nb4395Xin+pNKz1GEXBEfll
         tThopFoR4gZpL1g/q4w6qkh0ZEUTx8DtuwKvc2+OwIQMmrNiSBmLGOWjUfIgTolBu+4Y
         oMQyFDeWnuIoGbRQCUD29KxsGDD1G6CgFjjsi8Uq+Xgw1Tcs6WKhORxHlwVmBFhDk2Jk
         8pkQ==
X-Gm-Message-State: ABuFfoihT9AyZ+SVyrjdtXFfPqkJMPcV7w3IhrCPONMdHKYx/Sm1XFw7
        LjpwB6WDj2XuC63ehcDmNznG0w==
X-Google-Smtp-Source: ACcGV603DxJcd32qFTgj1Nf1kXPMBcINVuOPp4lcOZ9J+e40JqPb1ib9gpfZBUq+XnmTy3zJqakDjw==
X-Received: by 2002:a1c:3288:: with SMTP id y130-v6mr7978721wmy.11.1538750199749;
        Fri, 05 Oct 2018 07:36:39 -0700 (PDT)
Received: from localhost.localdomain (151.240.136.77.rev.sfr.net. [77.136.240.151])
        by smtp.gmail.com with ESMTPSA id t24-v6sm14080377wra.5.2018.10.05.07.36.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 Oct 2018 07:36:38 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 12/13] clocksource: Remove obsolete CLOCKSOURCE_OF_DECLARE
Date:   Fri,  5 Oct 2018 16:35:41 +0200
Message-Id: <1538750143-4282-12-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538750143-4282-1-git-send-email-daniel.lezcano@linaro.org>
References: <20181005143253.GE1881@mai>
 <1538750143-4282-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macro CLOCKSOURCE_OF_DECLARE was renamed more TIMER_OF_DECLARE, and we
kept an alias CLOCKSOURCE_OF_DECLARE in order to smooth the transition for
drivers.

This change was done 1.5 year ago, we can reasonably remove this backward
compatible macro as it is no longer used anywhere.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 include/linux/clocksource.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index 3089189..4c58c1e 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -257,9 +257,6 @@ extern int clocksource_i8253_init(void);
 #define TIMER_OF_DECLARE(name, compat, fn) \
 	OF_DECLARE_1_RET(timer, name, compat, fn)
 
-#define CLOCKSOURCE_OF_DECLARE(name, compat, fn) \
-	TIMER_OF_DECLARE(name, compat, fn)
-
 #ifdef CONFIG_TIMER_PROBE
 extern void timer_probe(void);
 #else
-- 
2.7.4

