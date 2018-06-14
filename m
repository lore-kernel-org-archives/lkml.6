Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A9B6DC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 05:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DE11208D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 05:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NtxktNH5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DE11208D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752747AbeFNFXr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 01:23:47 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:37971 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751455AbeFNFXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 01:23:44 -0400
Received: by mail-pf0-f196.google.com with SMTP id b74-v6so2610028pfl.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 22:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ow4kgHJRH3Epm9EoRn5M/2VWmBNQRdnsiOvwaNtwhjk=;
        b=NtxktNH5u7I/3HIKDix9yBicsNrKAETnO0j6ck4/Xp7s0sJw774sEj3EY1MCUBiYmA
         Gkn2JgXiowZPjws6RrrvyUgOvxco02mIfMoPJk2X72IdU3EcNbSFpBjtde9MILsH1308
         95TKZn5gEkX11yLzvLSJeWuoi6fjc9oEuTwuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ow4kgHJRH3Epm9EoRn5M/2VWmBNQRdnsiOvwaNtwhjk=;
        b=lfYchGn1b/XF4Sb6RNp2FCz0p4JcqUpYoFVALH577QEmvLBDtjALMZVSAP7zjQk8ct
         tvIYkxk+pq73JmsrwwRZHwMoexlG4JK2tERn7Q+fsq6TrTlN9I7IJnnDm9aRC/HflgxV
         7bn2+tcjtNZhphuqK3X1WroD6hzq5u5ipATSl+EyUj+cRYdnxaeTagjECWO0rmhevHSI
         SH/UvWtqSnYaPyXFiKcF4BhjNpcZtE8LAwFyLRIQ1IWnalgf9shrKjcjRiYWW+A20U93
         PIij0zQxWHO/X3lWc34438ZnevQxE9Pw83M58GN79NFYjJz3Eftv9YbQN2mLow8Co4ZI
         pWag==
X-Gm-Message-State: APt69E1rUevsMT69OaBhvSq9oxRhdgmf6YN26HSHyXYNn8wU5JUVqyB9
        JaIdYz8HLrfwXMFfcnpglO0DDw==
X-Google-Smtp-Source: ADUXVKIPa0I25j+Wuyt37zqnxYcDhZW68smrXskCd+7vHSrJazamc5Nb6beHR1+rw/tgzEjQ9535Bg==
X-Received: by 2002:a63:8048:: with SMTP id j69-v6mr975916pgd.429.1528953823470;
        Wed, 13 Jun 2018 22:23:43 -0700 (PDT)
Received: from localhost ([223.226.91.101])
        by smtp.gmail.com with ESMTPSA id u1-v6sm5902641pfn.59.2018.06.13.22.23.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 22:23:42 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] PM / Domains: Fix return value of of_genpd_opp_to_performance_state()
Date:   Thu, 14 Jun 2018 10:53:34 +0530
Message-Id: <3d3687c030535189885d84c57dbffb034c4461c2.1528953706.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a2c
In-Reply-To: <b90f44d35e8e0fa9c81b3a88d05449a580be5567.1528953706.git.viresh.kumar@linaro.org>
References: <b90f44d35e8e0fa9c81b3a88d05449a580be5567.1528953706.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_genpd_opp_to_performance_state() should return 0 for errors, but the
dummy routine isn't doing that. Fix it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 include/linux/pm_domain.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 9206a4fef9ac..139f79c8477a 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -276,7 +276,7 @@ static inline unsigned int
 of_genpd_opp_to_performance_state(struct device *dev,
 				  struct device_node *opp_node)
 {
-	return -ENODEV;
+	return 0;
 }
 
 static inline int genpd_dev_pm_attach(struct device *dev)
-- 
2.18.0.rc1.242.g61856ae69a2c

