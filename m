Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932890AbeCJSVn (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 13:21:43 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:38434 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932670AbeCJSVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 13:21:40 -0500
X-Google-Smtp-Source: AG47ELuGXDyEElbQbZ210ZdMDy3RX6AuLD2khR+7zkrkcg8ssWER9Evj9cTN8Y4I2Z41rBo6rdmQvg==
From: Andiry Xu <jix024@eng.ucsd.edu>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org
Cc: dan.j.williams@intel.com, andy.rudoff@intel.com, coughlan@redhat.com,
        swanson@cs.ucsd.edu, david@fromorbit.com, jack@suse.com,
        swhiteho@redhat.com, miklos@szeredi.hu, andiry.xu@gmail.com,
        Andiry Xu <jix024@cs.ucsd.edu>
Subject: [RFC v2 69/83] Super: Add module param inplace_data_updates.
Date: Sat, 10 Mar 2018 10:18:50 -0800
Message-Id: <1520705944-6723-70-git-send-email-jix024@eng.ucsd.edu>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520705944-6723-1-git-send-email-jix024@eng.ucsd.edu>
References: <1520705944-6723-1-git-send-email-jix024@eng.ucsd.edu>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andiry Xu <jix024@cs.ucsd.edu>

Provide inplace data updates option if people prefer inplace
updates to copy-on-write.

Signed-off-by: Andiry Xu <jix024@cs.ucsd.edu>
---
 fs/nova/nova.h  | 1 +
 fs/nova/super.c | 7 ++++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/nova/nova.h b/fs/nova/nova.h
index 1c2205e..6c94a9b 100644
--- a/fs/nova/nova.h
+++ b/fs/nova/nova.h
@@ -138,6 +138,7 @@ extern unsigned int nova_dbgmask;
 
 
 extern int measure_timing;
+extern int inplace_data_updates;
 
 
 extern unsigned int blk_type_to_shift[NOVA_BLOCK_TYPE_MAX];
diff --git a/fs/nova/super.c b/fs/nova/super.c
index 9710be8..980b1d7 100644
--- a/fs/nova/super.c
+++ b/fs/nova/super.c
@@ -43,10 +43,14 @@
 
 int measure_timing;
 int support_clwb;
+int inplace_data_updates;
 
 module_param(measure_timing, int, 0444);
 MODULE_PARM_DESC(measure_timing, "Timing measurement");
 
+module_param(inplace_data_updates, int, 0444);
+MODULE_PARM_DESC(inplace_data_updates, "Perform data updates in-place (i.e., not atomically)");
+
 module_param(nova_dbgmask, int, 0444);
 MODULE_PARM_DESC(nova_dbgmask, "Control debugging output");
 
@@ -541,7 +545,8 @@ static int nova_fill_super(struct super_block *sb, void *data, int silent)
 		goto out;
 	}
 
-	nova_dbg("measure timing %d\n", measure_timing);
+	nova_dbg("measure timing %d, inplace data update %d\n",
+			measure_timing, inplace_data_updates);
 
 	get_random_bytes(&random, sizeof(u32));
 	atomic_set(&sbi->next_generation, random);
-- 
2.7.4
