Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423621AbeE1LIc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:08:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:55840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423522AbeE1LIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:08:25 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lenny Szubowicz <lszubowi@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 099/272] ACPI: acpi_pad: Fix memory leak in power saving threads
Date: Mon, 28 May 2018 12:02:12 +0200
Message-Id: <20180528100249.436741026@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lenny Szubowicz <lszubowi@redhat.com>

[ Upstream commit 8b29d29abc484d638213dd79a18a95ae7e5bb402 ]

Fix once per second (round_robin_time) memory leak of about 1 KB in
each acpi_pad kernel idling thread that is activated.

Found by testing with kmemleak.

Signed-off-by: Lenny Szubowicz <lszubowi@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/acpi/acpi_pad.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -110,6 +110,7 @@ static void round_robin_cpu(unsigned int
 		cpumask_andnot(tmp, cpu_online_mask, pad_busy_cpus);
 	if (cpumask_empty(tmp)) {
 		mutex_unlock(&round_robin_lock);
+		free_cpumask_var(tmp);
 		return;
 	}
 	for_each_cpu(cpu, tmp) {
@@ -127,6 +128,8 @@ static void round_robin_cpu(unsigned int
 	mutex_unlock(&round_robin_lock);
 
 	set_cpus_allowed_ptr(current, cpumask_of(preferred_cpu));
+
+	free_cpumask_var(tmp);
 }
 
 static void exit_round_robin(unsigned int tsk_index)
