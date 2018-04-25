Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753745AbeDYL1v (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 07:27:51 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7630 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752051AbeDYL1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 07:27:34 -0400
From: YueHaibing <yuehaibing@huawei.com>
To: <benh@kernel.crashing.org>, <paulus@samba.org>, <mpe@ellerman.id.au>,
        <geoff@infradead.org>, <joe@perches.com>
CC: <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] powerpc/xics: add missing of_node_put() in error path
Date: Wed, 25 Apr 2018 19:27:07 +0800
Message-ID: <20180425112707.16392-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device node obtained with of_find_compatible_node() should be
released by calling of_node_put().  But it was not released when
of_get_property() failed.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 arch/powerpc/sysdev/xics/xics-common.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/sysdev/xics/xics-common.c b/arch/powerpc/sysdev/xics/xics-common.c
index 77e864d..e54a9e6 100644
--- a/arch/powerpc/sysdev/xics/xics-common.c
+++ b/arch/powerpc/sysdev/xics/xics-common.c
@@ -448,7 +448,10 @@ static void __init xics_get_server_size(void)
 		return;
 	isize = of_get_property(np, "ibm,interrupt-server#-size", NULL);
 	if (!isize)
+	{
+		of_node_put(np);
 		return;
+	}
 	xics_interrupt_server_size = be32_to_cpu(*isize);
 	of_node_put(np);
 }
-- 
2.7.0
