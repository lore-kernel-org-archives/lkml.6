Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA46ECDE3A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F8BB20858
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kFjTPb7G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F8BB20858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbeJIXnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 19:43:22 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39405 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbeJIXm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 19:42:56 -0400
Received: by mail-qk1-f194.google.com with SMTP id q5-v6so1313043qki.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 09:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rGWgMI1+Sov2UL2W3G/z4V3AYRc3F2jCrmMhsGLsaSc=;
        b=kFjTPb7GvlvcqqUl63mme8PN5mlZcwqjW+ATtvnaJEl0XoFJMZ8Ay1WAVuHps+VgBx
         svfB27nf95qf95qR0svOwo2QaQGuIHYeV61E9ryxHuKhYiNtk9JwfuH+E/lPn6jUjiY8
         6ZdgxI8FTxReaKCHOyf6fDISPoGJVymJosJYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rGWgMI1+Sov2UL2W3G/z4V3AYRc3F2jCrmMhsGLsaSc=;
        b=S2FjR4xu8SEpt5htU4xN8VjGZ7SxzsyrZbWVsYjdieZQ2lx0imKQuoWGCt3eWCC76t
         h/PDlUjgrm/e1I8wa0PUcfpy/xDp8rNlmAZogoEn8KVMp3QlgdnYTAQ3COjVkgCQfubh
         +58ixRuhcInVGk1kKTlx4PK37ORiF2Up+hPpnEeW1155H0l2DF8f46jilwTIic9e2Xk9
         JmFl5I6XXOwC6z5SXQkTtxlMVz0yz9l02F5mdSgmuvEmBqrcrCKAmCtTgvRFd3+hPgjz
         LTSdIgNY4E0T5GfQL2o9++fWOaOzmPlZ3U+1jjD6YlKA5Bi++H8pi0ec0TNAWAc8OOxF
         lTkA==
X-Gm-Message-State: ABuFfojC3wQHPOmPVKfRk6ey+urbtJ0ZkVDmgowYkwb2XYw77BcFYPhw
        rivMCQHwJHU0OFw3lFbI4Oe8+LWbrSF+Qw==
X-Google-Smtp-Source: ACcGV623kJLkZQiUxZJJo6nB6kUKKEBO8H3Wa0J3aczqBf0XkWyLIqCJ5/jP19nGCkEAEcbZbhcoeQ==
X-Received: by 2002:a37:10a7:: with SMTP id 39-v6mr22580045qkq.131.1539102312277;
        Tue, 09 Oct 2018 09:25:12 -0700 (PDT)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-245-97.washdc.fios.verizon.net. [71.255.245.97])
        by smtp.googlemail.com with ESMTPSA id o7-v6sm10441169qkc.67.2018.10.09.09.25.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Oct 2018 09:25:11 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, rui.zhang@intel.com
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        amit.kachhap@gmail.com, viresh.kumar@linaro.org,
        javi.merino@kernel.org, edubezval@gmail.com,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        quentin.perret@arm.com, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org
Subject: [RFC PATCH 4/7] sched: Initialize per cpu thermal pressure structure
Date:   Tue,  9 Oct 2018 12:24:59 -0400
Message-Id: <1539102302-9057-5-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org>
References: <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initialize per cpu max_capacity_info during scheduler init.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 drivers/base/arch_topology.c | 1 +
 kernel/sched/core.c          | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index e7cb0c6..542745f 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -126,6 +126,7 @@ void topology_normalize_cpu_scale(void)
 		pr_debug("cpu_capacity: CPU%d cpu_capacity=%lu\n",
 			cpu, topology_get_cpu_scale(NULL, cpu));
 	}
+	populate_max_capacity_info();
 	mutex_unlock(&cpu_scale_mutex);
 }
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 625bc98..f0eed1a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5868,6 +5868,8 @@ void __init sched_init_smp(void)
 	init_sched_rt_class();
 	init_sched_dl_class();
 
+	populate_max_capacity_info();
+
 	sched_smp_initialized = true;
 }
 
-- 
2.1.4

