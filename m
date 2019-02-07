Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC626C282CC
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 04:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2BE8218FE
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 04:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JM2BBt4c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfBGEeo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 23:34:44 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:47065 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbfBGEeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 23:34:44 -0500
Received: by mail-pl1-f194.google.com with SMTP id o6so4190376pls.13;
        Wed, 06 Feb 2019 20:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=TdWV8zaDsbS5D8yo5py6H+fVu+r9OXN8sENHXC5gOwM=;
        b=JM2BBt4ciTeNh0942oaqMXx1eMY81XikVvUDq/cne4pNWGT4EsoDLi1z8t+uOocymr
         2GdB2t/HrVn10Y2zuWrl87nG06UJMbLODzLTw1bELY7T0rdaBh77o37xwgoIZdlB7qHJ
         WZCIAds0bMmZcJqZr7AA3XRcWXUWFI6mL1yPApLvOjetfYGH+LLdw8xfWHKi3Iari0Kv
         nVJ4D5yVaLvdJXkXG4kWJlzfxm3hV1z2jXz77ur9apYq8bwrT/J2A0wd3O/LsxeZv/Yp
         OU0vSsMhnbXLgMkpGvgTR5s4HUuH72+HXMYqjnOIah/UdgxNTe7PVaTdqzZ+W0G/1nlL
         JsHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TdWV8zaDsbS5D8yo5py6H+fVu+r9OXN8sENHXC5gOwM=;
        b=nGeEcIJZwHq/foS74CV3ytEZCbKdlbkJjd0cPDCBOtm55v+CorTAprs3i9tBulnsCS
         uSy5yNiSYFduIXbj0zj3wvOKhCQdqQJ7BTYe4ZFDJOEvxRa+kGb8aZgp9dLyZ0lnPjig
         iTHT1tjsq1XzTisFF9jJygAYblUwRwBj/uq4uq0Rf9GsUIpweKWkL9/ghqDwoKxrNm+3
         OFcwqPHnSMmwpw4LXu15i0QvA5XA89o6Tuv7vMc6tBeNfS/f0OjtzNvboOfJJzqWkfQO
         7e7gTMKtTzEzfbC+rYTjEZaVQ8u1AjfU0UOtBOnb6FnRUJ1/XTZp/M3exbJwVK+vCfKc
         XB7A==
X-Gm-Message-State: AHQUAuZ/iFmK/SHDOsR/jVxdlpjFpYeXs6UwmjcEfx45FeTD67f1TMFt
        CT2MbXlIDfkNRISUE0V2CKk=
X-Google-Smtp-Source: AHgI3Ibx37dLZNjm6pPnxB136+eNX+WRjHgEr+5TORF6RkoglWEP6fJAT1pToaNKtY+792/ruCnHKw==
X-Received: by 2002:a17:902:e090:: with SMTP id cb16mr759219plb.32.1549514083415;
        Wed, 06 Feb 2019 20:34:43 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id o84sm19595648pfi.172.2019.02.06.20.34.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 20:34:42 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org, quentin.perret@arm.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 1/2] cpufreq: imx6q: Register an Energy Model
Date:   Wed,  6 Feb 2019 23:34:20 -0500
Message-Id: <20190207043420.3838-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Try and register an Energy Model from imx6q-cpufreq to allow
interested subsystems like the task scheduler to use the provided
information.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/cpufreq/imx6q-cpufreq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index 9fedf627e000..73bfd5bc3087 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -210,6 +210,7 @@ static int imx6q_cpufreq_init(struct cpufreq_policy *policy)
 	policy->clk = clks[ARM].clk;
 	ret = cpufreq_generic_init(policy, freq_table, transition_latency);
 	policy->suspend_freq = max_freq;
+	dev_pm_opp_of_register_em(policy->cpus);
 
 	return ret;
 }
-- 
2.17.0

