Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C85B9C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 14:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 900BD2089F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 14:39:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="U3C1wZIb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 900BD2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbeJCV1g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 17:27:36 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45795 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727256AbeJCV1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 17:27:35 -0400
Received: by mail-lj1-f195.google.com with SMTP id j4-v6so1571469ljc.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 07:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xjIfDLEOSbswJu1KU5trsLmIXoVIJYa2zHdFwxdeDkw=;
        b=U3C1wZIbccVX95gm6USfQzQ0KIFAGQLNCGJxAHczc0sW6zurvyAsLwcGQZKmye94yN
         TdWwdXGnFiIhk1GqGfBo5C5OXqJxbyB6FLYPahHeGXQqpmvMfHYQmFd/aPsdOJCaEB4I
         rxHYsizpoJLG7SeQHX+4NEJ9kXI/taVpgxH1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xjIfDLEOSbswJu1KU5trsLmIXoVIJYa2zHdFwxdeDkw=;
        b=FfZJAFchbcyZ0Xx5xr/Uo04yGd/wbu7eiJZoKEw6o8M8w8t5tmX9mxgJDYD9qTWOSf
         j0am5N9rU6R9dkxL0aMLMlPIWTzqXkOjpxYjLh2gNtZTvNWJABuNPVhZ8kMjHIqz+6Nu
         jRXBuMfnfM3gIbkxSDwrz6g1XZMM37OmyKRPXHohvMebbW/t662XdEqOc7WyVnczc4WX
         fA2aXnAzaCLZqbVgR7qZRqU6qdE7bzoQ9z3Qe93JHVSKhEb2/R5c+h2qQmzBcSeycYII
         qQ3ZUUPrZYcLy/7HEfgL2qgHNip09JI1YAsUZW6+N1UEHJws3YK0XHB6WfjnwtpPUbZ1
         u8XQ==
X-Gm-Message-State: ABuFfogXtcw/09hw4jxIPSDj+qjw7Xjio0TFOcXB/pbmmqa+Him44b0p
        ZqHcFFWN3INLuku1h41Zxhondw==
X-Google-Smtp-Source: ACcGV61z6YccPbjrV9ap4UqG6C7FdyslfItrbDmr+r8uVsqkpaonCiN5ShavWM01TG7ypXVgx40HvA==
X-Received: by 2002:a2e:9c59:: with SMTP id t25-v6mr1431593ljj.107.1538577533544;
        Wed, 03 Oct 2018 07:38:53 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id 18-v6sm380867ljo.74.2018.10.03.07.38.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 07:38:52 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Cc:     Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 08/11] MAINTAINERS: Update files for PSCI
Date:   Wed,  3 Oct 2018 16:38:21 +0200
Message-Id: <20181003143824.13059-9-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181003143824.13059-1-ulf.hansson@linaro.org>
References: <20181003143824.13059-1-ulf.hansson@linaro.org>
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
index b22e7fdfd2ea..710b906037ce 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11624,7 +11624,7 @@ M:	Mark Rutland <mark.rutland@arm.com>
 M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
 L:	linux-arm-kernel@lists.infradead.org
 S:	Maintained
-F:	drivers/firmware/psci*.c
+F:	drivers/firmware/psci/
 F:	include/linux/psci.h
 F:	include/uapi/linux/psci.h
 
-- 
2.17.1

