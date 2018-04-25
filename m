Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754729AbeDYOo6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 10:44:58 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36518 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754473AbeDYOoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 10:44:55 -0400
X-Google-Smtp-Source: AIpwx4+EKv1iS8dFTxMJfdzy/Q5PXJTRaZLHo6msGL4jNOr3AHYC6ewiQ6HQaUbuoauYOZPjrYDZ+A==
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: tony.luck@intel.com, fenghua.yu@intel.com
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: [PATCH] IA64: tiocx: use put_device() instead of kfree()
Date: Wed, 25 Apr 2018 20:14:45 +0530
Message-Id: <1bcbd268184312155aec041bdd87c775ddb7cd8f.1524667391.git.arvind.yadav.cs@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Never directly free @dev after calling device_register(), even
if it returned an error. Always use put_device() to give up the
reference initialized.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 arch/ia64/sn/kernel/tiocx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/ia64/sn/kernel/tiocx.c b/arch/ia64/sn/kernel/tiocx.c
index 32d0380..fd515bc 100644
--- a/arch/ia64/sn/kernel/tiocx.c
+++ b/arch/ia64/sn/kernel/tiocx.c
@@ -209,7 +209,7 @@ cx_device_register(nasid_t nasid, int part_num, int mfg_num,
 	dev_set_name(&cx_dev->dev, "%d", cx_dev->cx_id.nasid);
 	r = device_register(&cx_dev->dev);
 	if (r) {
-		kfree(cx_dev);
+		put_device(&cx_dev->dev);
 		return r;
 	}
 	get_device(&cx_dev->dev);
-- 
2.7.4
