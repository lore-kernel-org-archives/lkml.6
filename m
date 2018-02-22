Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933493AbeBVRXH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 12:23:07 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:54408 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933386AbeBVRXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 12:23:05 -0500
From: Colin King <colin.king@canonical.com>
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] xen/pvcalls: fix null pointer dereference on map->sock
Date: Thu, 22 Feb 2018 17:22:59 +0000
Message-Id: <20180222172259.10381-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently if map is null then a potential null pointer deference
occurs when calling sock_release on map->sock.  I believe the
actual intention was to call sock_release on sock instead. Fix
this.

Fixes: 5db4d286a8ef ("xen/pvcalls: implement connect command")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/xen/pvcalls-back.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/pvcalls-back.c b/drivers/xen/pvcalls-back.c
index 156e5aea36db..b1092fbefa63 100644
--- a/drivers/xen/pvcalls-back.c
+++ b/drivers/xen/pvcalls-back.c
@@ -416,7 +416,7 @@ static int pvcalls_back_connect(struct xenbus_device *dev,
 					sock);
 	if (!map) {
 		ret = -EFAULT;
-		sock_release(map->sock);
+		sock_release(sock);
 	}
 
 out:
-- 
2.15.1
