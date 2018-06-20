Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38295C43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6081208A1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="f2VcVFbD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6081208A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754585AbeFTRXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 13:23:06 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:40150 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932508AbeFTRXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 13:23:02 -0400
Received: by mail-lf0-f66.google.com with SMTP id q11-v6so468869lfc.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 10:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=stG9JEg6XvAPhk1WXN8yw0kJgHmvBt8xw2+9hMCUZkw=;
        b=f2VcVFbDfq9GSnU9aRX+cuwWeC5t6Q+VTY8OIA7tl5quE3ybq3CkS2okHfLFvK4DaB
         r2rx3eh+WCoq4BDEeNQH1tUNm/BP63ik6rxXvPBVOpsDqktGFJeeRGRbrjCRjp+hyYvp
         /8RrYoYpqhwY/LXgfnXmcTiALQ3hGXNLO2Imo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=stG9JEg6XvAPhk1WXN8yw0kJgHmvBt8xw2+9hMCUZkw=;
        b=t9jB6X5tDwtC4lLYrFAfaZ3hv9pJ7bU3DK97uC5IFV0+fS2KpsLT6u+U/bVuYtdItV
         HFqSUhhYMAGMIemyB5qDhHam/ElOKQ8LN8+X0573UVyjjVSEusEfxfGM0JFySkp2nTbE
         8WolcVx+gDNtz3fGBkunnKTqqOvLwepd/pr8h53+Wt56L5mKyKZqZ3xhuCRaxuoqmK6E
         ugottU5LInPSvpF0HRnSFLl9YlLfsSAZQF7tmRKYbC7oJ/LtefFT2IBqYZbSdzUw61fF
         ENRdbDuwKBef5s95blnCA/mp5WJJEtemZwX0ETXVRqzRu87gZbWEQm1mJfBrWYEL0+u9
         pVnQ==
X-Gm-Message-State: APt69E25C3cD5W3jV8czlNIIf5HoRH6iFvPhcXUYyOd8b9kYRcj2jeVN
        jcxabCd2Fk8tfERCuTdBbgTZWQ==
X-Google-Smtp-Source: ADUXVKLfyVEi5Cpmhgw449fGDSJ+NkJx7M9qWFFzfXqCwwyMscCj75rg7qW2MBn4WoGyz7l8b/kaLw==
X-Received: by 2002:a2e:84d7:: with SMTP id q23-v6mr14273971ljh.126.1529515380784;
        Wed, 20 Jun 2018 10:23:00 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id b2-v6sm514441lji.85.2018.06.20.10.22.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 10:22:59 -0700 (PDT)
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
Subject: [PATCH v8 14/26] MAINTAINERS: Update files for PSCI
Date:   Wed, 20 Jun 2018 19:22:14 +0200
Message-Id: <20180620172226.15012-15-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180620172226.15012-1-ulf.hansson@linaro.org>
References: <20180620172226.15012-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The files for the PSCI firmware driver were moved to a sub-directory,
let's update MAINTAINERS to reflect that.

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9d5eeff51b5f..3f28c21d0ad0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11389,7 +11389,7 @@ M:	Mark Rutland <mark.rutland@arm.com>
 M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
 L:	linux-arm-kernel@lists.infradead.org
 S:	Maintained
-F:	drivers/firmware/psci*.c
+F:	drivers/firmware/psci/
 F:	include/linux/psci.h
 F:	include/uapi/linux/psci.h
 
-- 
2.17.1

