Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 977FDC43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5399420836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fms5MZh+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5399420836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932674AbeFTR3B (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 13:29:01 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:40100 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754417AbeFTRWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 13:22:42 -0400
Received: by mail-lf0-f67.google.com with SMTP id q11-v6so467354lfc.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 10:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nn1c8Fl1Sgoee41Cdb6s6AY42Oe4mtKXW9dEF2Qclcg=;
        b=Fms5MZh+Y2NcSUQLJvVveQhOzXD9FJ9G/WS/pMfGFfAUOcdghZncGQ4QUcrTfiDHjG
         s2YHhha23J5+08pidu3G24Vkg+/C4+xmFvoJKQbQU8oz864aHSKGBBacDTfWGElmm00o
         SbDwCWScWvHyM0uj4Iv4vQ5gQpncl6f+1U75I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nn1c8Fl1Sgoee41Cdb6s6AY42Oe4mtKXW9dEF2Qclcg=;
        b=NXhkpsV9AeSHMDRPgk/PrMrJHj1e7VyTvA8ohLCWpHDWkxhNyCeC4Y19kIzMMdkJrP
         xiVXyb8GxPdm2UNpQWontEf11h/jD5YpYigVZjQHLSW5r3OnyNvo3NgSNWB6WKhCmv3Q
         edubNBa/9/IWAEVHaVfl3+n4ByEeywgO4SzI+F/pbJLldMTtVShR0+kSgJ5jxsmW6tIQ
         fG9FvX53HG/LHHgdGJ4pBVTDYe9X1cmIhwO1oJcu+5xIJJNWc4oU5/KNu2x1KmCq4S2L
         gyqOwT7AoBsm2XUQMobWifmjz2xm3cxzQaKdAOyt+IQdav8UEgYWLP8eh2Txe4fOdhtS
         hM1A==
X-Gm-Message-State: APt69E0GayNNABK/im7XnQiW4XSIZ/oCX6GYORSSsyjcj34A1ATCijrX
        xJtI+vWrC20Fp57OC8IEsCNhGQ==
X-Google-Smtp-Source: ADUXVKIp+MmPDN24YhDdaNyV+1Ej2navlR1CYNT8tfon9FH0v9XjFYh6yVpaxHrvw4RI+dky1S41Gg==
X-Received: by 2002:a19:5943:: with SMTP id n64-v6mr13137400lfb.107.1529515361033;
        Wed, 20 Jun 2018 10:22:41 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id b2-v6sm514441lji.85.2018.06.20.10.22.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 10:22:40 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org
Cc:     Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Lina Iyer <lina.iyer@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Juri Lelli <juri.lelli@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 03/26] PM / Domains: Add generic data pointer to genpd_power_state struct
Date:   Wed, 20 Jun 2018 19:22:03 +0200
Message-Id: <20180620172226.15012-4-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180620172226.15012-1-ulf.hansson@linaro.org>
References: <20180620172226.15012-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lina Iyer <lina.iyer@linaro.org>

Let's add a data pointer to the genpd_power_state struct, to allow
platforms to store per state specific data.

Cc: Lina Iyer <ilina@codeaurora.org>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
Co-developed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 include/linux/pm_domain.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 9206a4fef9ac..27fca748344a 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -44,6 +44,7 @@ struct genpd_power_state {
 	s64 residency_ns;
 	struct fwnode_handle *fwnode;
 	ktime_t idle_time;
+	void *data;
 };
 
 struct genpd_lock_ops;
-- 
2.17.1

