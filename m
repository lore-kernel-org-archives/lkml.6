Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78CD6C282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AA2221902
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:47:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbfBGMrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 07:47:09 -0500
Received: from ozlabs.org ([203.11.71.1]:49295 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726836AbfBGMq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 07:46:59 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 43wJ3h6wmRz9sNQ; Thu,  7 Feb 2019 23:46:56 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     linuxppc-dev@ozlabs.org
Cc:     akpm@linux-foundation.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        dyoung@redhat.com, sergey.senozhatsky@gmail.com, pmladek@suse.com
Subject: [PATCH v3 7/7] powerpc/pseries: Add firmware details to dump stack arch description
Date:   Thu,  7 Feb 2019 23:46:35 +1100
Message-Id: <20190207124635.3885-7-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190207124635.3885-1-mpe@ellerman.id.au>
References: <20190207124635.3885-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Once we have unflattened the device tree we can easily grab these
firmware version details and add them to dump stack arch description,
which is printed in case of an oops.

Currently /hypervisor only exists on KVM, so if we don't find that look
for something that suggests we're on phyp and if so that's probably a
good guess. The actual content of the ibm,fw-net-version seems to be
a full path so is too long to add to the description.

Hardware name: ... of:'IBM,FW860.42 (SV860_138)' hv:phyp

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/pseries/setup.c | 35 ++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 41f62ca27c63..dfb084f5a573 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -923,6 +923,39 @@ static void pSeries_cmo_feature_init(void)
 	pr_debug(" <- fw_cmo_feature_init()\n");
 }
 
+static void __init pseries_add_dump_stack_arch_desc(void)
+{
+	struct device_node *dn;
+	const char *prop;
+
+	dn = of_find_node_by_path("/openprom");
+	if (dn) {
+		prop = of_get_property(dn, "model", NULL);
+		if (prop)
+			dump_stack_add_arch_desc("of:'%s'", prop);
+
+		of_node_put(dn);
+	}
+
+	dn = of_find_node_by_path("/hypervisor");
+	if (dn) {
+		prop = of_get_property(dn, "compatible", NULL);
+		if (prop)
+			dump_stack_add_arch_desc("hv:%s", prop);
+
+		of_node_put(dn);
+	} else {
+		dn = of_find_node_by_path("/");
+		if (dn) {
+			prop = of_get_property(dn, "ibm,fw-net-version", NULL);
+			if (prop)
+				dump_stack_add_arch_desc("hv:phyp");
+
+			of_node_put(dn);
+		}
+	}
+}
+
 /*
  * Early initialization.  Relocation is on but do not reference unbolted pages
  */
@@ -930,6 +963,8 @@ static void __init pseries_init(void)
 {
 	pr_debug(" -> pseries_init()\n");
 
+	pseries_add_dump_stack_arch_desc();
+
 #ifdef CONFIG_HVC_CONSOLE
 	if (firmware_has_feature(FW_FEATURE_LPAR))
 		hvc_vio_init_early();
-- 
2.20.1

