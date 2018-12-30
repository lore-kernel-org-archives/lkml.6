Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D39C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 17:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C8902084A
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 17:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbeL3R1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 12:27:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38544 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726216AbeL3R1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 12:27:18 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0731CC0495AE;
        Sun, 30 Dec 2018 17:27:18 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-31.ams2.redhat.com [10.36.116.31])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5477D60851;
        Sun, 30 Dec 2018 17:27:16 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/cpu/intel: Lower "ENERGY_PERF_BIAS: Set to normal" message log priority
Date:   Sun, 30 Dec 2018 18:27:15 +0100
Message-Id: <20181230172715.17469-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Sun, 30 Dec 2018 17:27:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "ENERGY_PERF_BIAS: Set to 'normal', was 'performance'" message triggers
on pretty much every Intel machine. The purpose of log messages with
a warning level is to notify the user of something which potentially is
a problem, or at least somewhat unexpected.

This message clearly does not match those criteria, so lower its log
priority from warning to info.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/x86/kernel/cpu/intel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index fc3c07fe7df5..3142fd7a9b32 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -611,8 +611,8 @@ static void init_intel_energy_perf(struct cpuinfo_x86 *c)
 	if ((epb & 0xF) != ENERGY_PERF_BIAS_PERFORMANCE)
 		return;
 
-	pr_warn_once("ENERGY_PERF_BIAS: Set to 'normal', was 'performance'\n");
-	pr_warn_once("ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)\n");
+	pr_info_once("ENERGY_PERF_BIAS: Set to 'normal', was 'performance'\n");
+	pr_info_once("ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)\n");
 	epb = (epb & ~0xF) | ENERGY_PERF_BIAS_NORMAL;
 	wrmsrl(MSR_IA32_ENERGY_PERF_BIAS, epb);
 }
-- 
2.20.1

