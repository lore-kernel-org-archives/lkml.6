Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE187C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BB5520835
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1nJJJHb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BB5520835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbeH3Xun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 19:50:43 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36018 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727512AbeH3Xum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 19:50:42 -0400
Received: by mail-lf1-f68.google.com with SMTP id x207-v6so2465825lff.3;
        Thu, 30 Aug 2018 12:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=24D2xYMS1kl/6uS1au+qCp+5yBJn8LdO0/0NnBhxSSg=;
        b=S1nJJJHb5pS9It/9yH37sQxmO9EUzwEaRLeLjeD5UXCwL1JfWVPE693PNrgOzMGXbc
         Swf0HkDXDGnrzsFHHkFnKAlYgWGQbwqbastvEqsjplFSxGNBdyH3JIwaGaaB0Cm6J17M
         M+7m+31fXp6NYg4d+8ilSTtn5e7aGviAd9sueT7fLyYUzIrLrXoOtEecAUSR+JkI5oiN
         oy6uqI5mW9KvkUbak+44RFjZVrn8CEOULymJyfpjK2hIVCLcRIeC7qNcWEsKZUL/vZ6u
         2wFAzOxztKMo7dTlBtOvn5i1LhzZSwmgjGG72tFChHIQFsI4LuxU+aK6e7slU0aFxzoQ
         8Vhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=24D2xYMS1kl/6uS1au+qCp+5yBJn8LdO0/0NnBhxSSg=;
        b=Zrx1oh5jhstmESgcOV4pbRoyoPqUiS+Ltqb91A1VCZkBmuCzRREsqrgQJHQML3uqSm
         hwEK8NZrNJLl7bKSIX6FkM5rjdWdXSL1BAk4RmzLv9D6BiAGXO6R8nYxxA+6jb9IxryC
         fQ49YNIKZRe/nCtnPVeIZKaXQPKn+IJCB813UbRhuks5CXniMDFK+xqzDjjzFqdnDi4k
         D8qIJiGiZYUu5PGwWwHIz8jotz3oI09UW3rKKuufxqXux8PPiAk9qdMZNzBT01aFU/D8
         nYHoK01ITB5J7nfxA/PzEPYmAZ6+sy1bRJsA7Ul9ePE/D6f5kotq2cCSSx3m+lVtglEC
         JURg==
X-Gm-Message-State: APzg51BN+Jfopirku/5bLBzwgXH2T1106RwZ9PGb7VwEZqqc8TF9tzmK
        W8pU70SBfdm3WN0mMVGAric=
X-Google-Smtp-Source: ANB0VdZ75VgKlcbJXjGHQwH4/O4y15G17qCHmLjOE1p5FXj5ZTJ3wFuz3c+mREcMsWvKSnuyAQo0Jw==
X-Received: by 2002:a19:8f10:: with SMTP id r16-v6mr8873826lfd.1.1535658414451;
        Thu, 30 Aug 2018 12:46:54 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id x3-v6sm1381191ljb.25.2018.08.30.12.46.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 12:46:53 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/5] ARM: tegra: Create tegra20-cpufreq device on Tegra30
Date:   Thu, 30 Aug 2018 22:43:54 +0300
Message-Id: <20180830194356.14059-4-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180830194356.14059-1-digetx@gmail.com>
References: <20180830194356.14059-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra20-cpufreq driver require a platform device in order to be loaded,
instantiate a simple platform device for the driver during of the machines
late initialization. Driver now supports Tegra30 SoC's, hence create the
device on Tegra30 machines.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/tegra.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
index 67d8ae60ac67..b559e22eab76 100644
--- a/arch/arm/mach-tegra/tegra.c
+++ b/arch/arm/mach-tegra/tegra.c
@@ -111,6 +111,10 @@ static void __init tegra_dt_init_late(void)
 	if (IS_ENABLED(CONFIG_ARCH_TEGRA_2x_SOC) &&
 	    of_machine_is_compatible("nvidia,tegra20"))
 		platform_device_register_simple("tegra20-cpufreq", -1, NULL, 0);
+
+	if (IS_ENABLED(CONFIG_ARCH_TEGRA_3x_SOC) &&
+	    of_machine_is_compatible("nvidia,tegra30"))
+		platform_device_register_simple("tegra20-cpufreq", -1, NULL, 0);
 }
 
 static const char * const tegra_dt_board_compat[] = {
-- 
2.18.0

