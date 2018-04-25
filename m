Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754121AbeDYXI3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 19:08:29 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:11077 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754086AbeDYXIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 19:08:24 -0400
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 25 Apr 2018 16:08:24 -0700
From: Rohit Khanna <rokhanna@nvidia.com>
To: <catalin.marinas@arm.com>, <will.deacon@arm.com>
CC: <linux-kernel@vger.kernel.org>, Rohit Khanna <rokhanna@nvidia.com>
Subject: [PATCH] arm64: skip cpu nodes marked as disabled in DT
Date: Wed, 25 Apr 2018 16:08:32 -0700
Message-ID: <1524697712-20208-1-git-send-email-rokhanna@nvidia.com>
X-Mailer: git-send-email 2.1.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Skip the CPU nodes that are marked as disabled in DT.

Bug 1828570

Signed-off-by: Rohit Khanna <rokhanna@nvidia.com>
Reviewed-on: http://git-master/r/1245333
Reviewed-by: Alexander Van Brunt <avanbrunt@nvidia.com>
---
 arch/arm64/kernel/smp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index f3e2e3aec0b0..2b4371b0948d 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -578,6 +578,10 @@ static void __init of_parse_and_init_cpus(void)
 	for_each_node_by_type(dn, "cpu") {
 		u64 hwid = of_get_cpu_mpidr(dn);
 
+		/* Check to see if the cpu is disabled */
+		if (!of_device_is_available(dn))
+			goto next;
+
 		if (hwid == INVALID_HWID)
 			goto next;
 
-- 
2.1.4
