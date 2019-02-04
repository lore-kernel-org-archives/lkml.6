Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00021C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 07:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C154D20821
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 07:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbrZ43uk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbfBDHs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 02:48:59 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41333 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfBDHs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 02:48:58 -0500
Received: by mail-pl1-f194.google.com with SMTP id k15so602412pls.8;
        Sun, 03 Feb 2019 23:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=76p9aVxWLo32AEJ1Rl8I5ghi6Y4UtknRidPeoG302DE=;
        b=nbrZ43ukYYHYK2Uo2iw0HeFUS8ICiVBVCU6OvUaUySnM9bAvLH7BHN57gsZSs7ca21
         iyF5WbBeHTpAn3BGtHVICzr6LI2JJ9oGHCxN/EXd0EQy7TixsuBwSFh6VQyyilOxAVhA
         Pz81iFGIkMIW0g96BY4mUXk+zdqq1WKKRCeajvtjS+ETFDah8+5afMn0JvJqq2n5CdNq
         huQKbN1/VAkIF3RhC52I93WU4ux4/yVHMVRISlZdf7Oj9FYmIp2SMMcwuwwtaHYVd/m1
         mdACGoLsr1/KRGyLlxCiuD89Ysy56JIuKja9s4vH9hcWoucMj6BZ+mOleQDmxHfvaUkr
         kgKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=76p9aVxWLo32AEJ1Rl8I5ghi6Y4UtknRidPeoG302DE=;
        b=Cmhwk1xBwnYVOBjs4wafRQFqF53INGOm00/ulrC0QUTMttAsMN+a8Xqh+HiXJ6T9+a
         tDpfTPOfmHF3+4qv40Fo78NTPU8ElWvP4dITkAtBulB618UuXAl1VdQC+EHbVGx7hUe7
         H+vH2jL3nwtNLhjDznRPKrOvSgd0CmaopS6lkp1eG2b9N1SkIRf8NYuCIauxv0ELBgd4
         WFdY8NsY+X1XvaX1maFCYVws2OYlmhZLHXR+QwbP+iej7yRKKnmvv1vBkPelpJHElLXk
         mP8ehUExhEeVmgC6AB48e3svjM/+xUcWC2lWsFLTC8B0b6YMERMjQUpJa3Myx/z2Vsxp
         uCCA==
X-Gm-Message-State: AJcUukcLrnH0lTzdV7HS3zprTGD8WLhukUSHznebpzNcNAod2RApPgpB
        rcYl6HCjh7skxucjzpIpbfshGn95qSQ=
X-Google-Smtp-Source: ALg8bN5k15t+7cHIemFrKdRyHAdAxRMdK2kqRCZwXKfoEctZlu+MGYAMMOetgKM+oOPv4lzNJCZ61A==
X-Received: by 2002:a17:902:7687:: with SMTP id m7mr50210189pll.187.1549266538281;
        Sun, 03 Feb 2019 23:48:58 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id o1sm19347165pgn.63.2019.02.03.23.48.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Feb 2019 23:48:57 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v2] cpufreq: tegra124: add missing of_node_put()
Date:   Mon,  4 Feb 2019 02:48:54 -0500
Message-Id: <20190204074854.1538-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_cpu_device_node_get() will increase the refcount of device_node,
it is necessary to call of_node_put() at the end to release the
refcount.

Fixes: 9eb15dbbfa1a2 ("cpufreq: Add cpufreq driver for Tegra124")
Cc: <stable@vger.kernel.org> # 4.4+
Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
v2:
- move of_node_put() to the very end
---
 drivers/cpufreq/tegra124-cpufreq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/tegra124-cpufreq.c b/drivers/cpufreq/tegra124-cpufreq.c
index 43530254201a..4bb154f6c54c 100644
--- a/drivers/cpufreq/tegra124-cpufreq.c
+++ b/drivers/cpufreq/tegra124-cpufreq.c
@@ -134,6 +134,8 @@ static int tegra124_cpufreq_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, priv);
 
+	of_node_put(np);
+
 	return 0;
 
 out_switch_to_pllx:
-- 
2.17.0

