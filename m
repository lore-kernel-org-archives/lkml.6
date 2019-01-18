Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 832C9C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 05:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EFA120855
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 05:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Lqot3MN3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbfARFpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 00:45:34 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34209 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbfARFpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 00:45:34 -0500
Received: by mail-pl1-f194.google.com with SMTP id w4so5857698plz.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 21:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=1GHCrIH/zhKjvR57yQojViA6vvVSllVOfQJXVhcIPV8=;
        b=Lqot3MN3q/rP4POvMC+G9EZaYGDfxuBoX+U8QsEsosKnYg7V2G5vgPMewV1LuxoaWM
         5I+GuZidL0D3+YAYzdtfP7zZWCRfRprwQRk9mtmuhiXW9WpEF7rlrpCg1puvAxHjbPDz
         pLlMMlKTjZzaMPRCLvBiCERwMhZ2H6hFWarxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1GHCrIH/zhKjvR57yQojViA6vvVSllVOfQJXVhcIPV8=;
        b=IY2BqibJL1ktxMPGr+Odl6kbqdIJZzEPnv2TvwZoPaasMCqD2JJguLW36nLOHR/H8y
         AjgeIv/wB0YkuKfcocJ1j0ucoZchTAsse5MMwA0rS0YubYfMqOZmuIZmy/2hYJzGoO9B
         UoCKSKTSom0DsydH/ke439ObB9gGAeKTpHs4ZHguymbkZjkpeK67maD2FPV6J7uHUlsl
         KBZ/xrQw7NI1HQdesWUqHjB1OAmzC9zVL/hWrcVCX7Ge5CagTDYB6lEIyIzHZjdWJi+y
         MMkz/02wXrG0oCgxW+EM6KPsgZmelp6rPQpPajELfhX3vYpsuqNDNyffqTPvDoUdfajg
         S6Pw==
X-Gm-Message-State: AJcUukdtvw3L+rwyF3/wAs5+xCUKANrLnSpYZ0q7ehfVqYYTn+L9B+8o
        BKq8Vxyx47MzGZuJp0i3UJysxQ==
X-Google-Smtp-Source: ALg8bN44GgQV1V9GC6wrvd8U+o3O/82fe/Z1pfqaauYKt/Y4QTetQjEjHU7/dFD+dHBxlqs69iOZyg==
X-Received: by 2002:a17:902:8a91:: with SMTP id p17mr18011684plo.316.1547790333630;
        Thu, 17 Jan 2019 21:45:33 -0800 (PST)
Received: from pramodku-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id l5sm476264pfi.56.2019.01.17.21.45.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 17 Jan 2019 21:45:33 -0800 (PST)
From:   Pramod Kumar <pramod.kumar@broadcom.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Suzuki K Poulose <Suzuki.Poulose@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Dave Martin <dave.martin@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Steve Capper <steve.capper@arm.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pramod Kumar <pramod.kumar@broadcom.com>
Subject: [PATCH RFC 1/1] arm64: Use PSCI calls for CPU stop when hotplug is supported
Date:   Fri, 18 Jan 2019 11:16:20 +0530
Message-Id: <1547790380-6276-1-git-send-email-pramod.kumar@broadcom.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CPU hotplug is supported, ipi_cpu_stop should use PSCI cpudie
call to stop the CPU. This call ensures L1/L2 cache flush,
CPUs cache-cohenrecy setting w.r.to interconnect.

Apart from this, this gives control to f/w to reduce power consumption
by take appropriate decesion on power rails for plugging-out core.

Signed-off-by: Pramod Kumar <pramod.kumar@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
---
 arch/arm64/kernel/smp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 1598d6f..360e52b 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -822,8 +822,13 @@ static void ipi_cpu_stop(unsigned int cpu)
 	local_daif_mask();
 	sdei_mask_local_cpu();
 
+#ifdef CONFIG_HOTPLUG_CPU
+	if (cpu_ops[cpu]->cpu_die)
+		cpu_ops[cpu]->cpu_die(cpu);
+#else
 	while (1)
 		cpu_relax();
+#endif
 }
 
 #ifdef CONFIG_KEXEC_CORE
-- 
1.9.1

