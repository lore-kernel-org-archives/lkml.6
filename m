Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C14C282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E96421916
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:47:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbfBGMrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 07:47:00 -0500
Received: from ozlabs.org ([203.11.71.1]:56077 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727430AbfBGMq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 07:46:58 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 43wJ3g4cNBz9sNJ; Thu,  7 Feb 2019 23:46:55 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     linuxppc-dev@ozlabs.org
Cc:     akpm@linux-foundation.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        dyoung@redhat.com, sergey.senozhatsky@gmail.com, pmladek@suse.com
Subject: [PATCH v3 6/7] powerpc/powernv: Add opal details to dump stack arch description
Date:   Thu,  7 Feb 2019 23:46:34 +1100
Message-Id: <20190207124635.3885-6-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190207124635.3885-1-mpe@ellerman.id.au>
References: <20190207124635.3885-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Once we have unflattened the device tree we can easily grab these opal
version details and add them to dump stack arch description, which is
printed in case of an oops.

eg: Hardware name: ... opal:v6.2

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/powernv/setup.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index 14befee4b3f1..1bfb422436fb 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -156,8 +156,33 @@ static void __init pnv_setup_arch(void)
 	/* XXX PMCS */
 }
 
+static void __init pnv_add_dump_stack_arch_desc(void)
+{
+	struct device_node *dn;
+	const char *version;
+
+	dn = of_find_node_by_path("/ibm,opal/firmware");
+	if (!dn)
+		return;
+
+	version = of_get_property(dn, "version", NULL);
+	if (!version)
+		version = of_get_property(dn, "git-id", NULL);
+
+	if (version)
+		dump_stack_add_arch_desc("opal:%s", version);
+
+	version = of_get_property(dn, "mi-version", NULL);
+	if (version)
+		dump_stack_add_arch_desc("mi:%s", version);
+
+	of_node_put(dn);
+}
+
 static void __init pnv_init(void)
 {
+	pnv_add_dump_stack_arch_desc();
+
 	/*
 	 * Initialize the LPC bus now so that legacy serial
 	 * ports can be found on it
-- 
2.20.1

