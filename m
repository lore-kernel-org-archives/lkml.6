Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A1CC43610
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 02:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F420B223DD
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 02:47:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mvgofs3m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F420B223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732826AbeKNMsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 07:48:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:52290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732805AbeKNMsT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 07:48:19 -0500
Received: from lerouge.suse.de (lfbn-ncy-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F37472243E;
        Wed, 14 Nov 2018 02:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542163628;
        bh=JFXS5i8eTB4cAikdvtCNCZPSmUeGLFLG5bRLnQHQfYk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mvgofs3minyr7C1OIcEZZS7jth73knSDqKHcqA1D8B2Ebc4iQj7kRl6K1b4QxKl0r
         tV2wAVGgMFi9Is0UEwJHJ1Sn+Bg3hD6GtZar7Of5AVjaCfPBhwKOWYXbxXEIwKPERD
         SqtcBpOD9xjXiRK2dAPNQKfAmSM/B+QB+mH02QDc=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Rik van Riel <riel@redhat.com>
Subject: [PATCH 23/25] leds: Use vtime aware kcpustat accessors
Date:   Wed, 14 Nov 2018 03:46:07 +0100
Message-Id: <1542163569-20047-24-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542163569-20047-1-git-send-email-frederic@kernel.org>
References: <1542163569-20047-1-git-send-email-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have a vtime safe kcpustat accessor, use it to fix frozen
kcpustat values on nohz_full CPUs.

Reported-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rik van Riel <riel@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wanpeng Li <wanpengli@tencent.com>
Cc: Ingo Molnar <mingo@kernel.org>
---
 drivers/leds/trigger/ledtrig-activity.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/leds/trigger/ledtrig-activity.c b/drivers/leds/trigger/ledtrig-activity.c
index bcbf41c..b4a1f66 100644
--- a/drivers/leds/trigger/ledtrig-activity.c
+++ b/drivers/leds/trigger/ledtrig-activity.c
@@ -60,9 +60,12 @@ static void led_activity_function(struct timer_list *t)
 	curr_used = 0;
 
 	for_each_possible_cpu(i) {
-		curr_used += kcpustat_cpu(i).cpustat[CPUTIME_USER]
-			  +  kcpustat_cpu(i).cpustat[CPUTIME_NICE]
-			  +  kcpustat_cpu(i).cpustat[CPUTIME_SYSTEM]
+		u64 user, nice, sys, guest, guest_nice;
+
+		kcpustat_cputime(&kcpustat_cpu(i), i, &user, &nice, &sys,
+				 &guest, &guest_nice);
+
+		curr_used += user + nice + sys
 			  +  kcpustat_cpu(i).cpustat[CPUTIME_SOFTIRQ]
 			  +  kcpustat_cpu(i).cpustat[CPUTIME_IRQ];
 		cpus++;
-- 
2.7.4

