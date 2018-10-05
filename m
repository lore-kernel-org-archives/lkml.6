Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D658C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 14:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D73E206B2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 14:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="N4fkSwRf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D73E206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbeJEVfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 17:35:16 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40463 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729079AbeJEVfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 17:35:15 -0400
Received: by mail-wm1-f65.google.com with SMTP id z204-v6so2158200wmc.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 07:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zYFW6zRcVWgOSX94iYyvnnU1cnHxMesXqS4FKh6YYF8=;
        b=N4fkSwRf9I2ditkSIc0ew9bugOW4GXH2AMxHF4n/1Fkcv2NdGRKEyYkJwjjb5JIMOo
         NT6uX7S0Yud+k6qj0wjG9VriMs5UqYuKrzbpwZYdj0aVeX8YUsatNFMo8dIr92JXxvD1
         jsxWyhi29xUq5J9i4k2Cvwg1U1nF5JMHBnLlY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zYFW6zRcVWgOSX94iYyvnnU1cnHxMesXqS4FKh6YYF8=;
        b=AaJgdUaUDuSkX7sf51eSkfio71XfhbL8mzrPKWSI6MPESi2fVqj8Vm2viU54LFwogW
         vb1jboeout1hu5mGksFCdiuspp2Iwk6401ITKfRR/V4Q4qRL8916AWpZHmKTwwS+BgwS
         mS3iKqQ+TocSPt33oL/lwqA69QvPAsQRzdnyExv2mquv/8ThqvnFD5PBpFq5vNjaiel3
         BnzDD6g0bT8TGO0Vrz+ViFdYnVA479p7hjbSRqFKQLmhTR5WhoSEl2Nj/ABcTLJ3dNos
         tkzf9nfIWu01NwM0aE7lHUx9yxceVM8jyl40ihHW1s23O67YZhI8V8OJNfcAXTiypoLu
         XBFw==
X-Gm-Message-State: ABuFfohvJaIj/2mxtaLnWK5p//AuelsU6ecygIMLyH6jQ8+/ktn11F8d
        pKwrKus7deEyI3mbupBVNUqicA==
X-Google-Smtp-Source: ACcGV62wW6prrI2kMcJL9LKwNmotf/5rWjsrktGcza9pwxiamtRtdnXORee2n5LyZmSl/jQtibPaXw==
X-Received: by 2002:a1c:ae08:: with SMTP id x8-v6mr7796891wme.86.1538750174762;
        Fri, 05 Oct 2018 07:36:14 -0700 (PDT)
Received: from localhost.localdomain (151.240.136.77.rev.sfr.net. [77.136.240.151])
        by smtp.gmail.com with ESMTPSA id t24-v6sm14080377wra.5.2018.10.05.07.36.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 Oct 2018 07:36:14 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 07/13] clocksource/drivers/sh_cmt: Fix clocksource width for 32-bit machines
Date:   Fri,  5 Oct 2018 16:35:36 +0200
Message-Id: <1538750143-4282-7-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538750143-4282-1-git-send-email-daniel.lezcano@linaro.org>
References: <20181005143253.GE1881@mai>
 <1538750143-4282-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

The driver seems to abuse *unsigned long* not only for the (32-bit)
register values but also for the 'sh_cmt_channel::total_cycles' which
needs to always be 64-bit -- as a result, the clocksource's mask is
needlessly clamped down to 32-bits on the 32-bit machines...

Fixes: 19bdc9d061bc ("clocksource: sh_cmt clocksource support")
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/sh_cmt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
index efaf00d..0c74489 100644
--- a/drivers/clocksource/sh_cmt.c
+++ b/drivers/clocksource/sh_cmt.c
@@ -100,7 +100,7 @@ struct sh_cmt_channel {
 	raw_spinlock_t lock;
 	struct clock_event_device ced;
 	struct clocksource cs;
-	unsigned long total_cycles;
+	u64 total_cycles;
 	bool cs_enabled;
 };
 
@@ -605,8 +605,8 @@ static u64 sh_cmt_clocksource_read(struct clocksource *cs)
 {
 	struct sh_cmt_channel *ch = cs_to_sh_cmt(cs);
 	unsigned long flags;
-	unsigned long value;
 	u32 has_wrapped;
+	u64 value;
 	u32 raw;
 
 	raw_spin_lock_irqsave(&ch->lock, flags);
@@ -680,7 +680,7 @@ static int sh_cmt_register_clocksource(struct sh_cmt_channel *ch,
 	cs->disable = sh_cmt_clocksource_disable;
 	cs->suspend = sh_cmt_clocksource_suspend;
 	cs->resume = sh_cmt_clocksource_resume;
-	cs->mask = CLOCKSOURCE_MASK(sizeof(unsigned long) * 8);
+	cs->mask = CLOCKSOURCE_MASK(sizeof(u64) * 8);
 	cs->flags = CLOCK_SOURCE_IS_CONTINUOUS;
 
 	dev_info(&ch->cmt->pdev->dev, "ch%u: used as clock source\n",
-- 
2.7.4

