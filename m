Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3553EC43610
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 02:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC41B223DD
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 02:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/FMMQph"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC41B223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732783AbeKNMsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 07:48:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:52212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732756AbeKNMsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 07:48:14 -0500
Received: from lerouge.suse.de (lfbn-ncy-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71C8C2245E;
        Wed, 14 Nov 2018 02:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542163624;
        bh=2SpaE9ejknQ4F8xSmr2VXaMf4rvtizdjBRZy/8ccywA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k/FMMQphECrJl1jCsSsdUUXA73AvDcZHq90F8m4Bb4rmr95ihSxpCz3zVpbfZFJD5
         RPl1/RDF8OaDKs/yvYqxj3o3aweZFuBXpGd5p+w9NodvY74aHsilLPAR2xI+8uIa5m
         88pD7Vwkw4ZU+/+bDSguzKYrVg/xHMocrh5sWQ70=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Rik van Riel <riel@redhat.com>
Subject: [PATCH 21/25] procfs: Use vtime aware kcpustat accessor
Date:   Wed, 14 Nov 2018 03:46:05 +0100
Message-Id: <1542163569-20047-22-git-send-email-frederic@kernel.org>
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
 fs/proc/stat.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/fs/proc/stat.c b/fs/proc/stat.c
index 535eda7..2eed662 100644
--- a/fs/proc/stat.c
+++ b/fs/proc/stat.c
@@ -95,16 +95,20 @@ static int show_stat(struct seq_file *p, void *v)
 	getboottime64(&boottime);
 
 	for_each_possible_cpu(i) {
-		user += kcpustat_cpu(i).cpustat[CPUTIME_USER];
-		nice += kcpustat_cpu(i).cpustat[CPUTIME_NICE];
-		system += kcpustat_cpu(i).cpustat[CPUTIME_SYSTEM];
+		u64 cpu_user, cpu_nice, cpu_sys, cpu_guest, cpu_guest_nice;
+
+		kcpustat_cputime(&kcpustat_cpu(i), i, &cpu_user, &cpu_nice,
+				 &cpu_sys, &cpu_guest, &cpu_guest_nice);
+		user += cpu_user;
+		nice += cpu_nice;
+		system += cpu_sys;
 		idle += get_idle_time(i);
 		iowait += get_iowait_time(i);
 		irq += kcpustat_cpu(i).cpustat[CPUTIME_IRQ];
 		softirq += kcpustat_cpu(i).cpustat[CPUTIME_SOFTIRQ];
 		steal += kcpustat_cpu(i).cpustat[CPUTIME_STEAL];
-		guest += kcpustat_cpu(i).cpustat[CPUTIME_GUEST];
-		guest_nice += kcpustat_cpu(i).cpustat[CPUTIME_GUEST_NICE];
+		guest += cpu_guest;
+		guest_nice += guest_nice;
 		sum += kstat_cpu_irqs_sum(i);
 		sum += arch_irq_stat_cpu(i);
 
@@ -130,17 +134,14 @@ static int show_stat(struct seq_file *p, void *v)
 	seq_putc(p, '\n');
 
 	for_each_online_cpu(i) {
+		kcpustat_cputime(&kcpustat_cpu(i), i, &user, &nice,
+				 &system, &guest, &guest_nice);
 		/* Copy values here to work around gcc-2.95.3, gcc-2.96 */
-		user = kcpustat_cpu(i).cpustat[CPUTIME_USER];
-		nice = kcpustat_cpu(i).cpustat[CPUTIME_NICE];
-		system = kcpustat_cpu(i).cpustat[CPUTIME_SYSTEM];
 		idle = get_idle_time(i);
 		iowait = get_iowait_time(i);
 		irq = kcpustat_cpu(i).cpustat[CPUTIME_IRQ];
 		softirq = kcpustat_cpu(i).cpustat[CPUTIME_SOFTIRQ];
 		steal = kcpustat_cpu(i).cpustat[CPUTIME_STEAL];
-		guest = kcpustat_cpu(i).cpustat[CPUTIME_GUEST];
-		guest_nice = kcpustat_cpu(i).cpustat[CPUTIME_GUEST_NICE];
 		seq_printf(p, "cpu%d", i);
 		seq_put_decimal_ull(p, " ", nsec_to_clock_t(user));
 		seq_put_decimal_ull(p, " ", nsec_to_clock_t(nice));
-- 
2.7.4

