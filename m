Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED0BC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56587213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LbDpQVTs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56587213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730924AbeK3Exi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:53:38 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34916 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730873AbeK3Exh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 23:53:37 -0500
Received: by mail-lf1-f66.google.com with SMTP id e26so2124680lfc.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 09:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BlcCn6JUkPvrmaJts0baXJ0tND3p8k02JN8jSxGv1B4=;
        b=LbDpQVTsDKH8Vlu8mCK1a/Q1So8giOTNrXCaxWic4ge8hs50DGuGqiu3yznF/H6DfO
         +aQ7qnYWh/XOAWTWRcJ69MBuJZNFn7LZR1kGuYEVa9jboM1knEsNrcqiNH7VfRM3ilvO
         gSEgA1FPTdTRPV2AKN8BL60FONcnUzCXet0/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BlcCn6JUkPvrmaJts0baXJ0tND3p8k02JN8jSxGv1B4=;
        b=iDBTlNvLohZP78F/3dgBpGU9EWfFuNf1fvPpqQuAArHzQPZXsVir23ua/uydeed3Kj
         M10UdbjIRpJC0/HiK6F9qWHMJ99DVaAs66W8Mt3uPgxm2+2105RNeI3AGNZ2g78ElhS6
         q7jFYePDzF9nPwoAeRPgaF+D2XXisUQ9CDBbn1re+LBwlFCBaXlALeEAFEjB2bFV23TT
         fPEUyT/32IQQEGsEBVe5NuTpeNXLwG7UJNUOUsBkTVYZvovwrpXtE5q/P8uVygq0Au57
         xYeDdo49IOgzRrAQ2zeKfsgtmzcRE8kFv3E+bwnaxla07Ih/G9N7u1KEUhhqWQaV/pR2
         M78w==
X-Gm-Message-State: AA+aEWaRZNqW/Z3GR0Bl/xno5iDN4RTXfU682Ik8RiRmU35slU8WSr1V
        VoJQG7vkmOMIWT+MSokTJ2fjTg==
X-Google-Smtp-Source: AFSGD/XL0A9ZxXXbqP0IGeMxZKK3Hk3+2ZxFydPtpCZkLTo460VYANs3KWIUvoIrurCDJv1WpTGhcQ==
X-Received: by 2002:a19:a60c:: with SMTP id p12mr1733898lfe.63.1543513645918;
        Thu, 29 Nov 2018 09:47:25 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id j76-v6sm393983ljb.12.2018.11.29.09.47.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 09:47:25 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Cc:     "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v10 10/27] MAINTAINERS: Update files for PSCI
Date:   Thu, 29 Nov 2018 18:46:43 +0100
Message-Id: <20181129174700.16585-11-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129174700.16585-1-ulf.hansson@linaro.org>
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The files for the PSCI firmware driver were moved to a sub-directory, let's
update MAINTAINERS to reflect that.

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v10:
	- None.
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 380e43f585d3..9805444711ab 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11919,7 +11919,7 @@ M:	Mark Rutland <mark.rutland@arm.com>
 M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
 L:	linux-arm-kernel@lists.infradead.org
 S:	Maintained
-F:	drivers/firmware/psci*.c
+F:	drivers/firmware/psci/
 F:	include/linux/psci.h
 F:	include/uapi/linux/psci.h
 
-- 
2.17.1

