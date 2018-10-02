Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2492C64EBC
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60A0A20666
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n0tBlNNF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60A0A20666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbeJCFUw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 01:20:52 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50207 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbeJCFUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 01:20:52 -0400
Received: by mail-wm1-f67.google.com with SMTP id s12-v6so3806701wmc.0;
        Tue, 02 Oct 2018 15:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7COVNgoUxWRFYJfErKst2gvfTbMi6GzF5VFDBPSnFvo=;
        b=n0tBlNNFPHJ3tXP984tM81G6RvURGtBl4lRJiNCR12eRD996mApObEDSTCZKeRUKtJ
         x6HNB7nTE/Zbi4QkESjZHWI5a32IIA3KHI4z7xi+8UGtRN4mAzMuVi9OaDcKg+GyS12O
         IMk7W3MU+ZrfZbBwjqcn8BxetPu0i9zCLeEUaynPoHaKWEZm1xfA2g6vIzNu1llMOeVK
         bjRgdaf6muiBR/flll7mNw7wc3ncNG0NZbxQv11UHJRLQYUDGGAMzTAiitBqcRtYW18T
         WlBQVCh53RSeronwPYJoD1EeltIJrgH6M+1q/sBnL2scYNG+Mt/yEabPojK+doP81FOD
         +Z9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7COVNgoUxWRFYJfErKst2gvfTbMi6GzF5VFDBPSnFvo=;
        b=OkvINIt+g2Eytq4XInzAss0po0caXE/XpYv/9h0xFjLc1ZCxbsVgIZIBUKGDcvHVdY
         Q3+1/WmkeLAMOCkD7gdmoZ7afVrMXRSsr/3l7xmEr31aA1+v9TT7RpcgbqSMJrAjo0Qz
         8Uwbij2yxpGDyzK0aZ1cX6bEe4W6f0nWc51alW4xMhL+NxvQpT64nHVoVKgIgEe8A8VV
         PgDmZIOvoOIh+KV3M3Blf0IhGdZO0uWejW0YrzislSLvQYjXj2OlWQUbS3qwCtBNUidj
         HbIJPe3YrxwqN1hhslz47MtDXCaMAkHIKLxrNCP+nC3ZWd8vPOCrOnSyf6ox7ZrtLvEE
         VBdg==
X-Gm-Message-State: ABuFfogmHkscs/w1LV2P9F3EurR6zljlXgb0cAsd5SaC2r93v/a1IHCv
        2WzOeffR5/vSYsIccs1S9mI=
X-Google-Smtp-Source: ACcGV63XHQnevco13uYq7wfDhlT8Aw5v6Bz9WgV9aCTMBZCT6rir1vF5Jna6p0aIVVlVHWA4iIhyGw==
X-Received: by 2002:a1c:be09:: with SMTP id o9-v6mr3208734wmf.109.1538519711932;
        Tue, 02 Oct 2018 15:35:11 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id b1-v6sm15161426wrt.43.2018.10.02.15.35.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 15:35:11 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] cpufreq / CPPC: Mark acpi_ids as used
Date:   Tue,  2 Oct 2018 15:34:57 -0700
Message-Id: <20181002223457.7564-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

drivers/cpufreq/cppc_cpufreq.c:431:36: warning: variable 'cppc_acpi_ids'
is not needed and will not be emitted [-Wunneeded-internal-declaration]
static const struct acpi_device_id cppc_acpi_ids[] = {
                                   ^
1 warning generated.

Mark the definition as used so that Clang understands we don't want this
warning while not inhibiting Clang's dead code elimination from removing
the unreferenced internal symbol when moving the data it contains to the
globally available symbol via MODULE_DEVICE_TABLE.

$ nm -S drivers/cpufreq/cppc_cpufreq.o | grep acpi | tail -1
0000000000000000 0000000000000040 R __mod_acpi__cppc_acpi_ids_device_table

Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 30f302149730..fd25c21cee72 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -428,7 +428,7 @@ MODULE_LICENSE("GPL");
 
 late_initcall(cppc_cpufreq_init);
 
-static const struct acpi_device_id cppc_acpi_ids[] = {
+static const struct acpi_device_id cppc_acpi_ids[] __used = {
 	{ACPI_PROCESSOR_DEVICE_HID, },
 	{}
 };
-- 
2.19.0

