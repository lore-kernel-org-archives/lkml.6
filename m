Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9199BC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 05:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DC6920672
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 05:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Dj9m70el"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DC6920672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbeLMFXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 00:23:20 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46741 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbeLMFXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 00:23:19 -0500
Received: by mail-qt1-f194.google.com with SMTP id y20so822271qtm.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 21:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=T+bov1s7uPUUt2flzevFiGtl1wqIIJ2TOIfomd+w+To=;
        b=Dj9m70eleoZgBa8BKuA1YWEPUTpmJnw/74UHJOuBoD5eqOrACBo9OZIeQy6rZqX8vV
         xkWDwoYJRFOoySx9t0MJlH7lX1r7UXY1PQFuRdglNHjyJo33DSt/t/KzOdEeNheFIfbw
         95tzZeaCQql9OE9OgzsaKZpwPv/sJvyYGX2xmxdz1LRwZhSaN+FjVS6/4dWn5fH8hng5
         /lb4X0x8BT+xk4MuS0uI82bN+L0T/qxexHYFSx4k52Z8cIrsYE5bBQ+y48ozint0D619
         SifA6g8TkQoVniVsHZ5/ehsWF2kzadkYYpF4Y8gl2VhO1q6y2KWETqFnX3kmUNIPQ6dR
         rIVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=T+bov1s7uPUUt2flzevFiGtl1wqIIJ2TOIfomd+w+To=;
        b=uPzoJePrxio28j7a/PxYhIbhqK3QDdyBTADkqvqO8C+icSoirz2Tn0N2DMyamo48Z8
         9uauzdqmFhI2rcut/daUzml4Pdjo/qtUeYsTQzPNKYRVctGrnyDOl2n9Fsqb8ipvg+0Y
         BsbNrzZQI+glsyy8FjpIQjQxm+jfqCuN0LJ73GJ3xnRf4/XpRh2BbhyG4IA+vrKxMc7z
         vFpHbKU2V1UAA0xBPUMPrlrxWabnyjBy+YO+RSv25QbzUhu1kIuJWIQQd6NmFHoLWvrb
         RiYy7j2RrVEibOA4fuIVJ9uaf8nDucr+ITiJf8NAbWtEFMxVvyBgIm0mkKhoAzD1eHxr
         V27g==
X-Gm-Message-State: AA+aEWZ4E8fbEn+I3IiHod5Jc5yNdwQj6QEySdldRw7V29Xx73j9H9vg
        X+trLJmukgv6IiyLMzO8xXra1Q==
X-Google-Smtp-Source: AFSGD/Vu5/NTqWAqWCepYpmLvF9kyNshrMAVmb7Ev3/8VWn4Zu9TNixizeNE6rpP1R2Ab3SakKtagw==
X-Received: by 2002:a0c:9239:: with SMTP id a54mr21531273qva.17.1544678598851;
        Wed, 12 Dec 2018 21:23:18 -0800 (PST)
Received: from ovpn-121-90.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id u4sm460607qkk.51.2018.12.12.21.23.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 21:23:18 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     catalin.marinas@arm.com, will.deacon@arm.com
Cc:     marc.zyngier@arm.com, james.morse@arm.com,
        takahiro.akashi@linaro.org, ard.biesheuvel@linaro.org,
        linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] arm64: invalidate TLB before turning MMU on
Date:   Thu, 13 Dec 2018 00:22:59 -0500
Message-Id: <20181213052259.56352-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <1544654224.18411.11.camel@lca.pw>
References: <1544654224.18411.11.camel@lca.pw>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On this HPE Apollo 70 arm64 server with 256 CPUs, triggering a crash
dump just hung. It has 4 threads on each core. Each 2-core share a same
L1 and L2 caches, so that is 8 CPUs shares those. All CPUs share a same
L3 cache.

It turned out that this was due to the TLB contained stale entries (or
uninitialized junk which just happened to look valid) from the first
kernel before turning the MMU on in the second kernel which caused this
instruction hung,

msr	sctlr_el1, x0

Signed-off-by: Qian Cai <cai@lca.pw>
---
 arch/arm64/kernel/head.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 4471f570a295..5196f3d729de 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -771,6 +771,10 @@ ENTRY(__enable_mmu)
 	msr	ttbr0_el1, x2			// load TTBR0
 	msr	ttbr1_el1, x1			// load TTBR1
 	isb
+	dsb	nshst
+	tlbi	vmalle1				// invalidate TLB
+	dsb	nsh
+	isb
 	msr	sctlr_el1, x0
 	isb
 	/*
-- 
2.17.2 (Apple Git-113)

