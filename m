Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E86C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 00:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C132222D9
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 00:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TT+TsD1m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390637AbfBPAT0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 19:19:26 -0500
Received: from mail-qk1-f201.google.com ([209.85.222.201]:41622 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730550AbfBPATZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 19:19:25 -0500
Received: by mail-qk1-f201.google.com with SMTP id u197so9480855qka.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 16:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=jjGpWmojnHUt14UZi64MIH6xh6crUDPxGXrjBJAVrn0=;
        b=TT+TsD1myHEzF7m8KRiLYBfIw4r9DrAEkHKInT4/cVReHzVS0zsB9jn31ewME94Y8N
         TAgQ2DmCwR8s2qJ25G3urS5uAG/uzRM8qBkrck7zfz3o+CcGKBp62dbkUDrCbyQdJ18o
         aCmHWCCFWQ2CTQr0Nx6MURyUqQ04TUHsf9JvH2n1qaVzjXm52qHp8fuHtlojd+MEwp/8
         CpHQDpWB5ufpOpwyMxb7z0UgGdEGyqXNbW2WE1mbaC7iBJW4uzuTR8RQvfBGPkR4dG1o
         oc9dKw9aFHgcc2qGeroDepBV1OmVZkYqlGJYvAfBtFD5DrYOJtIdiJZOgJoYM4ZcWc+B
         QqLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=jjGpWmojnHUt14UZi64MIH6xh6crUDPxGXrjBJAVrn0=;
        b=fVIzQFaOIEuX+rmitd8nNro05a5XzAHnx4VLOu+xnTVBTrt/22yjp0vENPebF5fhd8
         yYCVA5HXPHmt+okv0prHahn25Avx9Df8R2h5ARtXWZRxsExx+1B294qWdQbLa5vOf8yk
         Sv0LKNZlmvwKJl126DtsG8Mvp+6zIAQIp9GH8zlx4vwd44/bQndGncoU1s0BtJXAZ+SV
         s0JXbXO6Ir6Viurhds/UeFbeZt1tPZPn/Si8Tp1nt9s9uej6yk2mSlql5vGXO2OEcRB7
         +sKY2a+kuCWLpNi5jxWIE9s6Bqf5uSaPXRqLDW2bYek39skr7KflwfUmvzMbQr9BYSUV
         WjIQ==
X-Gm-Message-State: AHQUAuaORGvaWsIMTkGpbrilRmtN7CQomNZko7Plt3MLIZj3Is8z2+Z5
        mt8ch5Oc1Qllu/P3F7WaYzxPsyvA/kN/
X-Google-Smtp-Source: AHgI3IaoKYI6JPVgWn3AJawhXw9QwnXzkC1DmguPZBh/XMrRvnfNQ2HfOAs5mHBFNt0SuZ4W9pYX44hEuPBF
X-Received: by 2002:a0c:b996:: with SMTP id v22mr6879761qvf.2.1550276364715;
 Fri, 15 Feb 2019 16:19:24 -0800 (PST)
Date:   Fri, 15 Feb 2019 16:19:20 -0800
Message-Id: <20190216001920.178053-1-rajatja@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
Subject: [PATCH] platform/x86: intel_pmc_core: Avoid a u32 overflow
From:   Rajat Jain <rajatja@google.com>
To:     Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Vishwanath Somayaji <vishwanath.somayaji@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     rajatxjain@gmail.com, Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The register (SLP_S0_RES) at offset slp_s0_offset is a 32 bit register.
The pmc_core_adjust_slp_s0_step() could overflow the u32 value while
returning it after adjusting the step. Thus change to u64, this is
already accounted for in debugfs attribute (that wants to output a
64 bit value).

Signed-off-by: Rajat Jain <rajatja@google.com>
---
 drivers/platform/x86/intel_pmc_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index 22dbf115782e..f90f4dd25151 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -328,9 +328,9 @@ static inline void pmc_core_reg_write(struct pmc_dev *pmcdev, int
 	writel(val, pmcdev->regbase + reg_offset);
 }
 
-static inline u32 pmc_core_adjust_slp_s0_step(u32 value)
+static inline u64 pmc_core_adjust_slp_s0_step(u32 value)
 {
-	return value * SPT_PMC_SLP_S0_RES_COUNTER_STEP;
+	return (u64)value * SPT_PMC_SLP_S0_RES_COUNTER_STEP;
 }
 
 static int pmc_core_dev_state_get(void *data, u64 *val)
-- 
2.21.0.rc0.258.g878e2cd30e-goog

