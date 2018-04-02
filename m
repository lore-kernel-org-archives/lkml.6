Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751971AbeDBFpR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 01:45:17 -0400
Received: from mx58.baidu.com ([61.135.168.58]:24170 "EHLO
        tc-sys-mailedm03.tc.baidu.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750714AbeDBFpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 01:45:16 -0400
From: Li RongQing <lirongqing@baidu.com>
To: linux-kernel@vger.kernel.org, tglx@linutronix.de
Subject: [PATCH] genirq: only scan the present CPUs
Date: Mon,  2 Apr 2018 13:45:02 +0800
Message-Id: <1522647902-11426-1-git-send-email-lirongqing@baidu.com>
X-Mailer: git-send-email 1.7.10.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lots of application will read /proc/stat, like ps and vmstat, but we
find the reading time are spreading on Purley platform which has lots
of possible CPUs and interrupt.

To reduce the reading time, only scan the present CPUs, not all possible
CPUs, which speeds the reading of /proc/stat 20 times on Purley platform
which has 56 present CPUs, and 224 possible CPUs

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 kernel/irq/irqdesc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 49b54e9979cc..8f489b73733e 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -902,7 +902,7 @@ unsigned int kstat_irqs(unsigned int irq)
 
 	if (!desc || !desc->kstat_irqs)
 		return 0;
-	for_each_possible_cpu(cpu)
+	for_each_present_cpu(cpu)
 		sum += *per_cpu_ptr(desc->kstat_irqs, cpu);
 	return sum;
 }
-- 
2.11.0
