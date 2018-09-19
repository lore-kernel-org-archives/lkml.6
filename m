Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22ED6ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 18:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6420A20877
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 18:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kRs85kFA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6420A20877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732525AbeITACG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 20:02:06 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35184 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727983AbeITACG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 20:02:06 -0400
Received: by mail-wm1-f66.google.com with SMTP id o18-v6so8101546wmc.0;
        Wed, 19 Sep 2018 11:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K/d27DgCUtnhw9MT2yWGph8lhnAhvl8DFjT3VverdYA=;
        b=kRs85kFAXQtn7SqKRKV5Eff/UlgDMOQNH6QFoVyvon1g+ipmldm31hzffJ/myr4PGw
         vetSHAHXrJrPWzcnk4omRwH+90hTz9z4a68aVC9rmOGnM1QP4zj0zlk8XS3hWRskdzh2
         2p/ypNY5rYYcwAiTFaGy+bUnaNF/apReYsTCO3ixEPUsn47fC2h9jpJRQ6+/6hjflwIU
         TnvvVcmvvABptrl1H3gGMBwNJ1lXr+kMRvPxl9i5jvl+akNb7Rnw8sHEFFB0lrUXId2N
         5ygJedpnSY0Up3N20AJhM5rhN/k3y9yrWWFBg/c/Cq7ZgbXFoGEtcgygn8g9DIjwMU3s
         PRGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K/d27DgCUtnhw9MT2yWGph8lhnAhvl8DFjT3VverdYA=;
        b=N7LCz1w8jqV7Ywmym9eXhCZMn+W2pl9adhKe4Ffark2zDXfXKMU6ZyUDIZ2WQP6CwU
         K5rPsswepxkk1tQ0P6QpWGVBjlyYL46wTlFThGk+hsiwCJt4WivKa1bu7QcTmjDL1Eq8
         P3cjXN40igCpGH7HId2nitluP/SNz9Ob6sspgNptdwUM0vWP4P11KZlfbA7JkHYjYB4c
         ydcLaVMoOl/6ib1HM+CEpxd0k42PYn9LqJAvGmu1vstmhodajYW0h/4DMnt+nRN3XyCf
         A6c38+hcEPchmWu+arB25Gp6R8Mo+4oYUhOUBeJrMFmF+nS4gcgARoWzhgbvC1JM6aQY
         r8MA==
X-Gm-Message-State: APzg51Dp36j8/bj/Mjed9Qo6MyW1dXs1wjyVL4CYhqneRpKV8ytUFJp+
        fmm26R3gsLj8l5DyccSeQyk=
X-Google-Smtp-Source: ANB0VdY71TpZFOwPycgMDkArCF+jxcLZjosXtdhWE7meDGRbu4BPLHIFVeeMt/1JPIZFX67d/iZx2Q==
X-Received: by 2002:a1c:99c2:: with SMTP id b185-v6mr22030447wme.15.1537381376783;
        Wed, 19 Sep 2018 11:22:56 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id q16-v6sm14445922wrw.2.2018.09.19.11.22.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 11:22:56 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Ilia Lin <ilia.lin@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH v2] cpufreq: qcom-kryo: Fix section mismatch warning
Date:   Wed, 19 Sep 2018 11:22:47 -0700
Message-Id: <20180919182247.1101-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARNING: vmlinux.o(.text+0x8aa424): Section mismatch in reference from
the function qcom_cpufreq_kryo_probe() to the function
.init.text:qcom_cpufreq_kryo_get_msm_id()
The function qcom_cpufreq_kryo_probe() references
the function __init qcom_cpufreq_kryo_get_msm_id().
This is often because qcom_cpufreq_kryo_probe lacks a __init
annotation or the annotation of qcom_cpufreq_kryo_get_msm_id is wrong.

Add the '__init' annotation to qcom_cpufreq_kryo_probe so that there is
no more mismatch warning.

Fixes: 46e2856b8e18 ("cpufreq: Add Kryo CPU scaling driver")
Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

v1 -> v2:

Add '__init' to qcom_cpufreq_kryo_probe instead of removing it from
qcom_cpufreq_kryo_get_msm_id.

 drivers/cpufreq/qcom-cpufreq-kryo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-kryo.c b/drivers/cpufreq/qcom-cpufreq-kryo.c
index a1830fa25fc5..e001ef8ea7de 100644
--- a/drivers/cpufreq/qcom-cpufreq-kryo.c
+++ b/drivers/cpufreq/qcom-cpufreq-kryo.c
@@ -73,7 +73,7 @@ static enum _msm8996_version __init qcom_cpufreq_kryo_get_msm_id(void)
 	return version;
 }
 
-static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
+static int __init qcom_cpufreq_kryo_probe(struct platform_device *pdev)
 {
 	struct opp_table *opp_tables[NR_CPUS] = {0};
 	enum _msm8996_version msm8996_version;
-- 
2.19.0

