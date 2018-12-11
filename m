Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB1BC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F57E2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:36:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jLPoKvET"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F57E2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbeLKKgZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 05:36:25 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33226 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbeLKKgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 05:36:25 -0500
Received: by mail-lj1-f195.google.com with SMTP id v1-v6so12526007ljd.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 02:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wf2D+An8STpqHZf/qaAI2vHrjnNZQXc99ukZ3AdxPrg=;
        b=jLPoKvETB+88mgEPM/i5i0IOynbOp2fTkz05nlYOXsAwA2dncMxwM2SYZ0hvNeCo2r
         RIHCmjooddPCRMMYpsGCjBMNqly07ul6WoYTxsL4U7dUj8RQqDtFmWL+Q8si4bs0RSsf
         4nAFpDpXco4T8CxYsYGD3Gx9HfwpmryC0NoB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wf2D+An8STpqHZf/qaAI2vHrjnNZQXc99ukZ3AdxPrg=;
        b=myAmuqXdDU7IeVOldRfknWVwazq3EE7GCbC2ybWUdGdDUw6qBE/mmJ0dB16s9UUmZ1
         75EKQ2cCEaoQwuis5uUrbHFrRBhAN/kzB1LNZZ1+jGOkVDHJZ6xE6MOfTHOwzRESMw35
         tzBbnANpomU9uUI8A3+A9kHFKzWKqxDfYPvTCkhJQBlAgOkclYR1auKqXoPPYeboET1a
         AiXmnvZHXm8BTM+wDFFsIY66Kf6aNI3373Biowsfc7tH7Tyah9TEoILpdbLz3hFouTmE
         92R715asmwkzGPgjX/kWU8+baFF2sJN6z5judzWPCU/bYfGX8WLT1r/FoRqiQFRh+Cia
         2ZDw==
X-Gm-Message-State: AA+aEWb+c0yVuuKPKdexc6WHK20oyAbtAS1jmscAtI3KPN7yD2jTezUI
        Wj5Q6QpMdakyFHgvTmK5bhBajA==
X-Google-Smtp-Source: AFSGD/UY4Eix4nphc1MLEE1Y5Ld+5YaFrU/PUg78Mi+fOjM0AR7fJ927jd0ga3+ZFLfmPx23bQuXBw==
X-Received: by 2002:a2e:5747:: with SMTP id r7-v6mr9181316ljd.141.1544524583163;
        Tue, 11 Dec 2018 02:36:23 -0800 (PST)
Received: from localhost (c-732171d5.07-21-73746f28.bbcust.telenor.se. [213.113.33.115])
        by smtp.gmail.com with ESMTPSA id t9-v6sm2623024ljj.87.2018.12.11.02.36.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 02:36:22 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     hch@lst.de
Cc:     m.szyprowski@samsung.com, robin.murphy@arm.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] dma-debug: fix soft lockup when a lot of debug are enabled
Date:   Tue, 11 Dec 2018 11:36:16 +0100
Message-Id: <20181211103616.22137-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running a kernel in qemu with enough debugging options (slub-debug,
ftrace, kcov, kasan, ubsan, ...) enabled together, that results in a
slow initcall. So a 'watchdog: BUG: soft lockup' happens:

[   44.105619] Call trace:
[   44.106709]  __slab_alloc+0x70/0x88
[   44.107757]  kmem_cache_alloc_trace+0x13c/0x590
[   44.108764]  prealloc_memory+0xb8/0x240
[   44.109768]  dma_debug_init+0x174/0x1f0
[   44.110725]  do_one_initcall+0x430/0x8b0
[   44.111719]  do_initcall_level+0x548/0x5b4
[   44.112672]  do_initcalls+0x28/0x4c
[   44.113628]  do_basic_setup+0x34/0x3c
[   44.114559]  kernel_init_freeable+0x194/0x24c
[   44.115570]  kernel_init+0x24/0x18c
[   44.116498]  ret_from_fork+0x10/0x18

Rework to call cond_resched(), in the function prealloc_memory()'s
for-loop.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 kernel/dma/debug.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 231ca4628062..2abdc265aec4 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -767,6 +767,7 @@ static int prealloc_memory(u32 num_entries)
 	int i;
 
 	for (i = 0; i < num_entries; ++i) {
+		cond_resched();
 		entry = kzalloc(sizeof(*entry), GFP_KERNEL);
 		if (!entry)
 			goto out_err;
-- 
2.19.2

