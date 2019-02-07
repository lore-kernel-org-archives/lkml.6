Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5187FC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B84B21916
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbfBGMrX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 07:47:23 -0500
Received: from ozlabs.org ([203.11.71.1]:46035 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727151AbfBGMqy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 07:46:54 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 43wJ3c4m5Qz9s4V; Thu,  7 Feb 2019 23:46:52 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     linuxppc-dev@ozlabs.org
Cc:     akpm@linux-foundation.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        dyoung@redhat.com, sergey.senozhatsky@gmail.com, pmladek@suse.com
Subject: [PATCH v3 3/7] powerpc/64: Add logical PVR to the dump stack arch description
Date:   Thu,  7 Feb 2019 23:46:31 +1100
Message-Id: <20190207124635.3885-3-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190207124635.3885-1-mpe@ellerman.id.au>
References: <20190207124635.3885-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we detect a logical PVR add that to the dump stack arch
description, which is printed in case of an oops.

eg: Hardware name: ... lpvr:0xf000004

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/prom.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index ea2c3498067d..38a90097469a 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -371,8 +371,10 @@ static int __init early_init_dt_scan_cpus(unsigned long node,
 	 */
 	if (!dt_cpu_ftrs_in_use()) {
 		prop = of_get_flat_dt_prop(node, "cpu-version", NULL);
-		if (prop && (be32_to_cpup(prop) & 0xff000000) == 0x0f000000)
+		if (prop && (be32_to_cpup(prop) & 0xff000000) == 0x0f000000) {
 			identify_cpu(0, be32_to_cpup(prop));
+			dump_stack_add_arch_desc("lpvr:0x%04x", be32_to_cpup(prop));
+		}
 
 		check_cpu_feature_properties(node);
 		check_cpu_pa_features(node);
-- 
2.20.1

