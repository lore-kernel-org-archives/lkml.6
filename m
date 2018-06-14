Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id C3483C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 20:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7680A208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 20:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uLuImVj5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7680A208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936042AbeFNUbc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 16:31:32 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:41371 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755424AbeFNUba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 16:31:30 -0400
Received: by mail-wr0-f196.google.com with SMTP id h10-v6so7727148wrq.8;
        Thu, 14 Jun 2018 13:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=cWhwXgX0H/4LBeqGgsmdRAVmtYeX6gotDwpvdxcDw0c=;
        b=uLuImVj58ES72/I0qxuh3e3CeS5uGK67/TGon2gTqQMTXgbDuiG0eRXabzf+ymE/WZ
         RjldI94R3Dr8Az13zaJLxCbrrvkb5N+VTFdb59/3ioVS1Nnvgt4wSt8pSUCgQXoulvzb
         2DkMAwB3V6dgPT6Erheboiu6HZa7p69FDTRJWM9Uo9tlNe8M8lrkMeQiZRyrQiWzx9cW
         eD+xmjyXvhAZBS4IrM/dZT3BnC6BB10q4nSTCwu3NgQdWX4G97FvihUW32e11zE4igqV
         lwW2Bjc6M++Xy97KyVX+tKK/S6Zc/Gx5EEkKA9cEcaPZgfc4kH5LsT14XVq9T7unuCrZ
         tfHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cWhwXgX0H/4LBeqGgsmdRAVmtYeX6gotDwpvdxcDw0c=;
        b=WZuthBb/m8OukYhTDRxhcvON1fMdTzPQf8uXD/4bH9b8rJvAwnxIOTjADOLKofytxT
         Mf/MVQXZZm/y0q5cYKL6paPgMiSwsrkjR36OhPo1Gqx/8h2I8WZK3WBl6GlurJEsrwyk
         eRW8QUuCxhbEpY7dZ/q+KPTtJHYzDr+OIYcftUy9w8pgwyJVkr7oGUxPWL0DAFoSaJtc
         Wp6gDpf3ng+FVBaN3L/q+HSvW8MG+JWoT26evSXA3jLgE0yQSfubvK3DL6hnUOvHF/YJ
         0ouQUjP31SOhP8HjUkSZIBfT/rtqWsuFhX4gHHevlgc8VRpBqX0HU8U1DA3eElOLSDkb
         Dm6A==
X-Gm-Message-State: APt69E3iLzta/8psRsUpkD2mivgQvWnz/3YTBdSnIEyRowN+W/K9ax8+
        XKPxs7aAjRJ2Gd0q02nI76I=
X-Google-Smtp-Source: ADUXVKJ6gC0Vc//1D4LhgJPeDYFqkyeZa7867OyxnhdHQrN77qPT/GaYvDdSjFIMtCxxL38dlQk+Tg==
X-Received: by 2002:adf:de08:: with SMTP id b8-v6mr3547219wrm.39.1529008288734;
        Thu, 14 Jun 2018 13:31:28 -0700 (PDT)
Received: from gcc67.tetaneutral.net (gcc67.tetaneutral.net. [2a03:7220:8080:c00::1])
        by smtp.gmail.com with ESMTPSA id w126-v6sm28584wmw.29.2018.06.14.13.31.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 13:31:27 -0700 (PDT)
From:   ilia.lin@gmail.com
To:     Ilia Lin <ilia.lin@gmail.com>, Ilia Lin <ilialin@codeaurora.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: kryo: Fix possible error code dereference
Date:   Thu, 14 Jun 2018 22:29:21 +0200
Message-Id: <20180614202921.32535-1-ilia.lin@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ilia Lin <ilia.lin@gmail.com>

In event of error returned by the nvmem_cell_read() non-pointer value
may be dereferenced. Fix this with error handling.

Signed-off-by: Ilia Lin <ilia.lin@gmail.com>
---
 drivers/cpufreq/qcom-cpufreq-kryo.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/qcom-cpufreq-kryo.c b/drivers/cpufreq/qcom-cpufreq-kryo.c
index d049fe4b80c4..5e9511223ce9 100644
--- a/drivers/cpufreq/qcom-cpufreq-kryo.c
+++ b/drivers/cpufreq/qcom-cpufreq-kryo.c
@@ -115,6 +115,8 @@ static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
 
 	speedbin = nvmem_cell_read(speedbin_nvmem, &len);
 	nvmem_cell_put(speedbin_nvmem);
+	if (IS_ERR(speedbin))
+		return PTR_ERR(speedbin);
 
 	switch (msm8996_version) {
 	case MSM8996_V3:
-- 
2.11.0

