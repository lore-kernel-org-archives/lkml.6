Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132B4ECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 06:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF3972098A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 06:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQ+AaLGF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF3972098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730869AbeISLli (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 07:41:38 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45191 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbeISLli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 07:41:38 -0400
Received: by mail-wr1-f67.google.com with SMTP id 20-v6so4388712wrb.12;
        Tue, 18 Sep 2018 23:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7hagEbggvoLZIYezGxMnjPOey+uo75RiEGUD26cr68s=;
        b=DQ+AaLGFiSBJfG/kX3hz3W7MxaG3+FWM1mOIFUKTxBHffdk1KbBIs7QrnaajyqaSEG
         icWLrlIR9QtGiB46SJ0bybuxB3f0TCrMah08/i+6hX6qE6Nk1A2ZGv+f3N6A+pn3Jcxf
         xR83gouLQuuqYAOVtvWNu1KdgHnn4LIIqTotOySU/NjsJS02nIV3faBjI/az3Cx4M4MZ
         SrgDEvJu61tc0oZAAwJaUOrzibBaGgOx/+qRJqIQ0WQnk8bzQYXMsYzBs6w6+YYEzmEQ
         O8iTYWLK80nNq+6XqDu53U0krRvx0zBpB+m1EogdV+E3b9VFVFVvRQhbOOfWJC+pIT/V
         QH1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7hagEbggvoLZIYezGxMnjPOey+uo75RiEGUD26cr68s=;
        b=e01/164RWJIEMuLDXmaHw47DHw7U+JTJafOh7/x3M1atUEJrUWWcOyKg7GBkE4VW6X
         j16Ctau1l7shOi2jcr35dfrL3BFI5MBPhxH6xzZRVx5CCrYLK0n1dr3LZsrka7RZG1Jf
         XreLMSjwiVvr4q+Z9/t47a5LkN9Z3AczXg+KWsboUGfDfbCoSmp61qee+mnJKWAQyMyr
         W9eIOvVjQ12SwaTZT7VNAwGQ61GGviznyaG3LhnLk+sXR1mK5T6jv3ohq/4x3A424yXF
         cfvGwcAgcEVnhe1hWf3qWN+vKEWks0m5IdtjJDROF4fpxsoAMA4EANiLyHHBSy65oxoj
         T3ig==
X-Gm-Message-State: APzg51AO/nOcAZ35Z7hCWhiudKAqSlNHwXdpv6DSHCFjkcpa/0kACsIJ
        3KXot6+qkgPwHauKHeDCwQk=
X-Google-Smtp-Source: ANB0VdbBRw1ejBcOFDRFu6lB1fbdWyyM/5ujGW4mWTVCpjptm4iWt7l1ehVcIJwkbLFujtiJnaxshA==
X-Received: by 2002:adf:d4c6:: with SMTP id w6-v6mr26199077wrk.185.1537337116820;
        Tue, 18 Sep 2018 23:05:16 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id 1-v6sm6341101wmf.47.2018.09.18.23.05.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Sep 2018 23:05:15 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Ilia Lin <ilia.lin@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] cpufreq: qcom-kryo: Fix section mismatch warning
Date:   Tue, 18 Sep 2018 23:05:04 -0700
Message-Id: <20180919060504.29281-1-natechancellor@gmail.com>
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

Remove the '__init' from qcom_cpufreq_kryo_get_msm_id so that there is
no more mismatch warning.

Fixes: 46e2856b8e18 ("cpufreq: Add Kryo CPU scaling driver")
Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/cpufreq/qcom-cpufreq-kryo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-kryo.c b/drivers/cpufreq/qcom-cpufreq-kryo.c
index a1830fa25fc5..4ea0afc8964c 100644
--- a/drivers/cpufreq/qcom-cpufreq-kryo.c
+++ b/drivers/cpufreq/qcom-cpufreq-kryo.c
@@ -44,7 +44,7 @@ enum _msm8996_version {
 
 struct platform_device *cpufreq_dt_pdev, *kryo_cpufreq_pdev;
 
-static enum _msm8996_version __init qcom_cpufreq_kryo_get_msm_id(void)
+static enum _msm8996_version qcom_cpufreq_kryo_get_msm_id(void)
 {
 	size_t len;
 	u32 *msm_id;
-- 
2.19.0

