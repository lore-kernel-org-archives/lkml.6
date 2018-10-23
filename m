Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ACBAC004D3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 00:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EE8F20674
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 00:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bHkaTFob"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EE8F20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbeJWJC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 05:02:28 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39269 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbeJWJC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 05:02:28 -0400
Received: by mail-pg1-f195.google.com with SMTP id r9-v6so19814575pgv.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 17:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k3+bItRF3HKCtN+9C7ArzY191B1xYpBEEhPHoA7vIXw=;
        b=bHkaTFobWgbWT5mIXIOQZ5qK8lldzm7qDRokIUEJX53p30T2rvTymLzT2Es9n3r6ww
         vGpS+lQf4lnSktDfumT8rdN2pmoMK997xbTNbYHCdcUMaUhoRkKGGH4LfiQlx1yPBRP2
         26uYYp4xEA1srMlpxXxBR2PJ1sNZwXm9S1dfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k3+bItRF3HKCtN+9C7ArzY191B1xYpBEEhPHoA7vIXw=;
        b=ZOtA9GTzP1GzDaZFk/4CZfm5oLtWjRuo53WeWktlHNVDcO0vKE/ZOs+X4AoMWoNj0r
         UnUGe6m3PY012VifeGaGBq3W05ojZS4wH6200xURe+ZBDTvwAVwalo+4sAHlV4Gjh3F6
         6vshGgzteTycYbxVIqDlD/JCIbhwo2aho9oovPn/I6k//PfI+4pdDAzncVltLwlYwdmh
         4k+RVOl2r/hKJ8ns8S70CGL/yTP4ao+WUvQNbL3i0rtdfu/gLBgedDT2BHBJKjm+3+RV
         rrDJVbSn7c2+OHhYt59eeHPX2yrGzUOLgbol6j+GLYZpN7vdvTtvlM7i75d5GpFXbVGn
         2vqg==
X-Gm-Message-State: ABuFfoipfWUKLbueHCtfWNSuTX3dDQnsmb72I2Zgavz8NK3kiPwRqu0N
        CeeSfcNDmdoFEBW549traN/Q4w==
X-Google-Smtp-Source: AJdET5f6AMOMteHlFt/HHLwsBtp1ghAu3qZgHH/geNeFsXcl0ZrD+HgT+7M0Mylbpxco+Lw7UQwrhQ==
X-Received: by 2002:a63:da14:: with SMTP id c20mr1008831pgh.233.1540255295429;
        Mon, 22 Oct 2018 17:41:35 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id q25-v6sm54060475pfk.154.2018.10.22.17.41.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 17:41:34 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Philipp Klocke <Phil_K97@gmx.de>,
        Guenter Roeck <groeck@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] sched: Make sched_feat(x) boolean for !CONFIG_SCHED_DEBUG
Date:   Mon, 22 Oct 2018 17:41:16 -0700
Message-Id: <20181023004116.77465-1-mka@chromium.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If scheduler debugging is disabled sched_feat() resolves to a constant
value that can be non-boolean. clang raises a warning when it detects
that a non-boolean constant is used as operand in logical expressions:

kernel/sched/core.c:208:26: warning: use of logical '&&' with constant
  operand [-Wconstant-logical-operand]
    if ((irq_delta + steal) && sched_feat(NONTASK_CAPACITY))
                            ^  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Convert the original expression to boolean by means of a double not
operation.

Reported-by: Philipp Klocke <Phil_K97@gmx.de>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 kernel/sched/sched.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 4a2e8cae63c4..b9387d35e261 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1393,7 +1393,7 @@ static const_debug __maybe_unused unsigned int sysctl_sched_features =
 	0;
 #undef SCHED_FEAT
 
-#define sched_feat(x) (sysctl_sched_features & (1UL << __SCHED_FEAT_##x))
+#define sched_feat(x) (!!(sysctl_sched_features & (1UL << __SCHED_FEAT_##x)))
 
 #endif /* SCHED_DEBUG && HAVE_JUMP_LABEL */
 
-- 
2.19.1.568.g152ad8e336-goog

