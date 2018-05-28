Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424107AbeE1LLo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:11:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:59570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423797AbeE1LLh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:11:37 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 168/272] powerpc/vas: Fix cleanup when VAS is not configured
Date: Mon, 28 May 2018 12:03:21 +0200
Message-Id: <20180528100254.901010371@linuxfoundation.org>
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

From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>

[ Upstream commit 45ddea8a73a25461387eb8e87f3e0ecca084799b ]

When VAS is not configured, unregister the platform driver. Also simplify
cleanup by delaying vas debugfs init until we know VAS is configured.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/platforms/powernv/vas-debug.c |   11 +++++++++++
 arch/powerpc/platforms/powernv/vas.c       |    6 +++---
 2 files changed, 14 insertions(+), 3 deletions(-)

--- a/arch/powerpc/platforms/powernv/vas-debug.c
+++ b/arch/powerpc/platforms/powernv/vas-debug.c
@@ -179,6 +179,7 @@ void vas_instance_init_dbgdir(struct vas
 {
 	struct dentry *d;
 
+	vas_init_dbgdir();
 	if (!vas_debugfs)
 		return;
 
@@ -201,8 +202,18 @@ free_name:
 	vinst->dbgdir = NULL;
 }
 
+/*
+ * Set up the "root" VAS debugfs dir. Return if we already set it up
+ * (or failed to) in an earlier instance of VAS.
+ */
 void vas_init_dbgdir(void)
 {
+	static bool first_time = true;
+
+	if (!first_time)
+		return;
+
+	first_time = false;
 	vas_debugfs = debugfs_create_dir("vas", NULL);
 	if (IS_ERR(vas_debugfs))
 		vas_debugfs = NULL;
--- a/arch/powerpc/platforms/powernv/vas.c
+++ b/arch/powerpc/platforms/powernv/vas.c
@@ -160,8 +160,6 @@ static int __init vas_init(void)
 	int found = 0;
 	struct device_node *dn;
 
-	vas_init_dbgdir();
-
 	platform_driver_register(&vas_driver);
 
 	for_each_compatible_node(dn, NULL, "ibm,vas") {
@@ -169,8 +167,10 @@ static int __init vas_init(void)
 		found++;
 	}
 
-	if (!found)
+	if (!found) {
+		platform_driver_unregister(&vas_driver);
 		return -ENODEV;
+	}
 
 	pr_devel("Found %d instances\n", found);
 
