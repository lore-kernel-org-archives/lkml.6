Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752724AbeC0N4n (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 09:56:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43946 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752275AbeC0N4l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 09:56:41 -0400
From: Lenny Szubowicz <lszubowi@redhat.com>
To: rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: acpi_pad: Fix memory leak in power saving threads
Date: Tue, 27 Mar 2018 09:56:40 -0400
Message-Id: <1522159000-7778-1-git-send-email-lszubowi@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix once per second (round_robin_time) memory leak of about 1 KB in
each acpi_pad kernel idling thread that is activated.

Found by testing with kmemleak.

Signed-off-by: Lenny Szubowicz <lszubowi@redhat.com>
---
 drivers/acpi/acpi_pad.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
index 7544310..552c1f7 100644
--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -110,6 +110,7 @@ static void round_robin_cpu(unsigned int tsk_index)
 		cpumask_andnot(tmp, cpu_online_mask, pad_busy_cpus);
 	if (cpumask_empty(tmp)) {
 		mutex_unlock(&round_robin_lock);
+		free_cpumask_var(tmp);
 		return;
 	}
 	for_each_cpu(cpu, tmp) {
@@ -127,6 +128,8 @@ static void round_robin_cpu(unsigned int tsk_index)
 	mutex_unlock(&round_robin_lock);
 
 	set_cpus_allowed_ptr(current, cpumask_of(preferred_cpu));
+
+	free_cpumask_var(tmp);
 }
 
 static void exit_round_robin(unsigned int tsk_index)
-- 
1.8.3.1
