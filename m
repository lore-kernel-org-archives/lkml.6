Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0268C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 15:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADE67222E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 15:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GFXNSwlk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730634AbfBPPzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 10:55:43 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46746 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbfBPPzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 10:55:41 -0500
Received: by mail-pl1-f195.google.com with SMTP id o6so6458600pls.13;
        Sat, 16 Feb 2019 07:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=StebgaWkJn+wWz7B4sEy16s1bgip/Xp6UWFV/GYPtng=;
        b=GFXNSwlk2MawfF5n0PSY4ASiTNiHeAbDhqycEiXNLYAMp1nBz9mQeuatkADRG/Wwz1
         EtJEIfVAXC43Y1TY5SADMABb4gjJHZuhoBmdecJepXmvys7unccSPYY5ODr8WbzAqijp
         GDCLAlzyK678bz5p7vurnQzAWxinxLJfDMnKIyVSDeWEUj5pqrgqvVKKsObM8dkUyygi
         mFK0xfG6P7T53A2ylHScV1WF5wreQ1dEW06A+FWR9BZBBdh71mCllT43VadU4fz4lfkD
         +TcJLptQ1kLKo3v9CFVtt6IVKGQtDm3gPFZqOuUgAQVPFAGfeWetv/8xGxDsucnpOLp/
         3zYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=StebgaWkJn+wWz7B4sEy16s1bgip/Xp6UWFV/GYPtng=;
        b=Bsc0w7lCnxthaGnHllJU6Qj/Cd/IdzoSgC/uYzZS2efrefb/A4h1i9LYJhtQm7Zf1W
         RxL+eydBjhKUBmtt0GNl9jY3JBgkJ1VJYHKLHB26bai5RFpCYfG2T8J/ncYF/9D7SwV8
         7M+6TFZMw9KYaVSjo7tizqX5mQyuyBr5tXzuGsDOcDQX6O4GCc8lNvLz/Qv5qX3/DjZ5
         8o8t3S5ymvpbh3Bxv0eco58l6se23vCqQynren8irloOpLUYlGPa63ft3Wugg8uktZbm
         ZiVg1pft0aUZ/eO298rfvRHIdaUIN0PGGEoRF13sPWtYE6w/62q8yNt5wS+7Z9wQPQ3z
         UXIw==
X-Gm-Message-State: AHQUAuZXJp8AxdvSl8F1mDQStEb7Gk9H0oks7EuFIG6lbnWcdg3Wwpqu
        SoPHF4dK29OTjzD4atMWja21JbE/93o=
X-Google-Smtp-Source: AHgI3IYN9Jr/s+AdiISROKQn6AG5JH2srEnrfXytDCQN3bEUkseJNp5K3bA8ekxIbl2krAEjseXk7w==
X-Received: by 2002:a17:902:509:: with SMTP id 9mr15097942plf.94.1550332541340;
        Sat, 16 Feb 2019 07:55:41 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id u66sm14823319pfi.115.2019.02.16.07.55.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 Feb 2019 07:55:40 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 2/2] cpufreq: longhaul: remove unneeded semicolon
Date:   Sat, 16 Feb 2019 10:55:27 -0500
Message-Id: <20190216155527.11839-3-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190216155527.11839-1-tiny.windzz@gmail.com>
References: <20190216155527.11839-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The semicolon is unneeded, so remove it.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/cpufreq/longhaul.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/longhaul.c b/drivers/cpufreq/longhaul.c
index 279bd9e9fa95..fb546e0d0356 100644
--- a/drivers/cpufreq/longhaul.c
+++ b/drivers/cpufreq/longhaul.c
@@ -851,7 +851,7 @@ static int longhaul_cpu_init(struct cpufreq_policy *policy)
 	case TYPE_POWERSAVER:
 		pr_cont("Powersaver supported\n");
 		break;
-	};
+	}
 
 	/* Doesn't hurt */
 	longhaul_setup_southbridge();
-- 
2.17.0

