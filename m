Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C926C282D7
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 06:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA8362082F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 06:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lNTXAKiF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbfBDGNP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 01:13:15 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33949 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727606AbfBDGNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 01:13:14 -0500
Received: by mail-pg1-f194.google.com with SMTP id d9so2319689pgl.1;
        Sun, 03 Feb 2019 22:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5Gausx/cyWWafynU5XyNkm7wd646uUx+dwp5lsiCJts=;
        b=lNTXAKiFDBpQKWrbAvQDn6aWkES7opfrXSPlvyZ7+ADKCW5IYO/iIggHKosJPoM4et
         AlGYXa0S99Z8RUHLbiCqQSmUZ4QytKOMF7a7/rdczDYtK1GIVvsOzPSdNaAjAleaI8NH
         C5rFFOFMUsY1RGqwxVt8jHR37iPrwmHopLzoIFlSfMQUc50U/iiEJuixSat7tXKCsu5x
         QsTfNDpsYOcT48BukR7u3GHL4anpcN9YsyYyRyP2pOXyluY0ZrWlDKFLtVAE9qzIlEj2
         YIt4VAgWdiur2qIMyxW9QVSnja+h2VkHn0sfsIfGMyMCZsI0Klvieu3xZTcf/7Hl72Wz
         aj7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5Gausx/cyWWafynU5XyNkm7wd646uUx+dwp5lsiCJts=;
        b=qPyoG6lvHTqJ0nU9hK8MlIgqF1H81kv9umpL+u9TOKLiD8B9M2kMmNnoL6U1F9maZP
         rfd+eQezTgee3Fq3+Nw4lkQK1nYiwUQ149NPSrAsuMzrNqY91QQnoPsjJTXyHeUI4vWw
         LVjTKOuwroAlBXfAKjT0fDHnTIyBxHDt3xzw6eE6JmEduzyosrqg4NPUgXx/71B9+Csm
         JZVnJOScjWJHhhFsoqvnvy4Y/DtGRTAmJJyXUTKsJgTB9XVF/gJps8zTj5iJ7RcEMpfK
         hgW8m5G9087cfxPks4CqlXUQ1kpox6waZ7b+rzsvb5no0REKP8kc6fCiuxZsfnMZPbKX
         2XsQ==
X-Gm-Message-State: AJcUukfY8/jLO2FAfZ13BxKS3NgoyTUjfJleYMvTwbsl9wWBnrc66w1Z
        Lx5l2/MrGXEpRLxFiW6CEpo=
X-Google-Smtp-Source: ALg8bN5cu13pzCmiiiSbiIkXrZHGMq6ehl+S1QjwIu79JiFCtiKHaoCVGudsQHZOoD4faui02a6qjQ==
X-Received: by 2002:a62:11c7:: with SMTP id 68mr49589399pfr.21.1549260793672;
        Sun, 03 Feb 2019 22:13:13 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id o13sm20049150pfk.57.2019.02.03.22.13.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Feb 2019 22:13:12 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     ilia.lin@gmail.com, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] cpufreq: qcom-kryo: make some variables static
Date:   Mon,  4 Feb 2019 01:13:10 -0500
Message-Id: <20190204061310.1211-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variables are local to the source and do not
need to be in global scope, so make them static.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/cpufreq/qcom-cpufreq-kryo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-kryo.c b/drivers/cpufreq/qcom-cpufreq-kryo.c
index 2a3675c24032..1c8583cc06a2 100644
--- a/drivers/cpufreq/qcom-cpufreq-kryo.c
+++ b/drivers/cpufreq/qcom-cpufreq-kryo.c
@@ -42,7 +42,7 @@ enum _msm8996_version {
 	NUM_OF_MSM8996_VERSIONS,
 };
 
-struct platform_device *cpufreq_dt_pdev, *kryo_cpufreq_pdev;
+static struct platform_device *cpufreq_dt_pdev, *kryo_cpufreq_pdev;
 
 static enum _msm8996_version qcom_cpufreq_kryo_get_msm_id(void)
 {
-- 
2.17.0

