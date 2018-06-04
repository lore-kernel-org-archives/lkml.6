Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751779AbeFDSAF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 14:00:05 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:37520 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751467AbeFDSAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 14:00:02 -0400
X-IronPort-AV: E=Sophos;i="5.49,476,1520870400";
   d="scan'208";a="81550572"
From: adam.manzanares@wdc.com
To: viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org
Cc: axboe@kernel.dk, bcrl@kvack.org, mingo@kernel.org, tglx@linutronix.de,
        kstewart@linuxfoundation.org, peterz@infradead.org,
        pombredanne@nexb.com, gregkh@linuxfoundation.org,
        bigeasy@linutronix.de, rgoldwyn@suse.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-aio@kvack.org,
        linux-api@vger.kernel.org, hch@infradread.org, jmoyer@redhat.com,
        willy@infradead.org, smfrench@gmail.com,
        Adam Manzanares <adam.manzanares@wdc.com>
Subject: [PATCH 1/2] fs: aio ioprio add explicit block layer dependence
Date: Mon,  4 Jun 2018 10:59:56 -0700
Message-Id: <20180604175957.2647-1-adam.manzanares@wdc.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adam Manzanares <adam.manzanares@wdc.com>

Previously, the ioprio_check_cap function was only defined when CONFIG_BLOCK
was set. Make this relationship explicit and add a stub for !CONFIG_BLOCK.

Signed-off-by: Adam Manzanares <adam.manzanares@wdc.com>
---
 include/linux/ioprio.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/ioprio.h b/include/linux/ioprio.h
index 4a28cec49ec3..9e30ed6443db 100644
--- a/include/linux/ioprio.h
+++ b/include/linux/ioprio.h
@@ -77,6 +77,13 @@ extern int ioprio_best(unsigned short aprio, unsigned short bprio);
 
 extern int set_task_ioprio(struct task_struct *task, int ioprio);
 
+#ifdef CONFIG_BLOCK
 extern int ioprio_check_cap(int ioprio);
+#else
+static inline int ioprio_check_cap(int ioprio)
+{
+	return -ENOTBLK;
+}
+#endif /* CONFIG_BLOCK */
 
 #endif
-- 
2.17.0
