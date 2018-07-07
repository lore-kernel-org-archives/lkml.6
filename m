Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872FAC6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 21:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31339208A2
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 21:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="DDUuKz+M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31339208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754432AbeGGVRC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 17:17:02 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:33138 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754328AbeGGVRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 17:17:00 -0400
Received: from trochilidae.lan (unknown [IPv6:2a02:169:34d6::127])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 88B025C1056;
        Sat,  7 Jul 2018 23:16:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1530998219;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:content-type:content-transfer-encoding:
         in-reply-to:references; bh=Z5oRubTtJit946mXozw/XxbbfK/cJ2WUdTqGrd2GL+A=;
        b=DDUuKz+Mn6AApCXv6XDZWj7dsUaQ8SdqiuByaPbwpKl9hYUKKS9ZnJPojs4K27AooP8Nat
        EaHWQCGi0bHIwSfsSD6iL+8O5uyqlTuVJs1J39OcMFsyPtYT702bzvl1aT5w5RUMwFlPok
        6dNYeOP4HV9gZEFZ/lHNp0LEGoOnQ7o=
From:   Stefan Agner <stefan@agner.ch>
To:     will.deacon@arm.com, mark.rutland@arm.com
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        namhyung@kernel.org, jolsa@redhat.com, linux@armlinux.org.uk,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH] arm: perf: prevent unbind/bind via sysfs
Date:   Sat,  7 Jul 2018 23:16:56 +0200
Message-Id: <20180707211656.2920-1-stefan@agner.ch>
X-Mailer: git-send-email 2.18.0
X-Spamd-Result: default: False [-2.10 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[11];
         FROM_EQ_ENVFROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         TO_DN_SOME(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         MID_CONTAINS_FROM(1.00)[];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unbinding and rebinding the ARM PMU driver via sysfs leads to a
warning followed by more errors:
  WARNING: CPU: 0 PID: 217 at kernel/irq/chip.c:1034 irq_modify_status+0x150/0x16c
  ..
  genirq: Flags mismatch irq 19. 00010c04 (arm-pmu) vs. 00010c04 (arm-pmu)
  hw perfevents: unable to request IRQ19 for ARM PMU counters
  hw perfevents: /pmu: failed to register PMU devices!
  armv7-pmu: probe of pmu failed with error -16

The driver is clearly not designed to be removed. Disable bind/
unbind for this driver.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/kernel/perf_event_v7.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
index 57f01e059f39..5a5116794440 100644
--- a/arch/arm/kernel/perf_event_v7.c
+++ b/arch/arm/kernel/perf_event_v7.c
@@ -2030,6 +2030,7 @@ static struct platform_driver armv7_pmu_driver = {
 	.driver		= {
 		.name	= "armv7-pmu",
 		.of_match_table = armv7_pmu_of_device_ids,
+		.suppress_bind_attrs = true,
 	},
 	.probe		= armv7_pmu_device_probe,
 };
-- 
2.18.0

