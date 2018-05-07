Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752486AbeEGN5x (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 09:57:53 -0400
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:48660 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752136AbeEGN5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 09:57:50 -0400
From: Julia Cartwright <julia@ni.com>
To: <bigeasy@linutronix.de>, <tglx@linutronix.de>
CC: <linux-rt-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        Alexander Stein <alexander.stein@systec-electronic.com>
Subject: [PATCH RT 2/2] squashfs: make use of local lock in multi_cpu decompressor
Date: Mon, 7 May 2018 08:58:57 -0500
Message-ID: <20180507135857.7565-2-julia@ni.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180507135857.7565-1-julia@ni.com>
References: <4064553.Shs7ScuBS6@ws-stein> <20180507135857.7565-1-julia@ni.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-07_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the squashfs multi_cpu decompressor makes use of
get_cpu_ptr()/put_cpu_ptr(), which unconditionally disable preemption
during decompression.

Because the workload is distributed across CPUs, all CPUs can observe a
very high wakeup latency, which has been seen to be as much as 8000us.

Convert this decompressor to make use of a local lock, which will allow
execution of the decompressor with preemption-enabled, but also ensure
concurrent accesses to the percpu compressor data on the local CPU will
be serialized.

Reported-by: Alexander Stein <alexander.stein@systec-electronic.com>
Tested-by: Alexander Stein <alexander.stein@systec-electronic.com>
Signed-off-by: Julia Cartwright <julia@ni.com>
---
 fs/squashfs/decompressor_multi_percpu.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/squashfs/decompressor_multi_percpu.c b/fs/squashfs/decompressor_multi_percpu.c
index 23a9c28ad8ea..6a73c4fa88e7 100644
--- a/fs/squashfs/decompressor_multi_percpu.c
+++ b/fs/squashfs/decompressor_multi_percpu.c
@@ -10,6 +10,7 @@
 #include <linux/slab.h>
 #include <linux/percpu.h>
 #include <linux/buffer_head.h>
+#include <linux/locallock.h>
 
 #include "squashfs_fs.h"
 #include "squashfs_fs_sb.h"
@@ -25,6 +26,8 @@ struct squashfs_stream {
 	void		*stream;
 };
 
+static DEFINE_LOCAL_IRQ_LOCK(stream_lock);
+
 void *squashfs_decompressor_create(struct squashfs_sb_info *msblk,
 						void *comp_opts)
 {
@@ -79,10 +82,15 @@ int squashfs_decompress(struct squashfs_sb_info *msblk, struct buffer_head **bh,
 {
 	struct squashfs_stream __percpu *percpu =
 			(struct squashfs_stream __percpu *) msblk->stream;
-	struct squashfs_stream *stream = get_cpu_ptr(percpu);
-	int res = msblk->decompressor->decompress(msblk, stream->stream, bh, b,
-		offset, length, output);
-	put_cpu_ptr(stream);
+	struct squashfs_stream *stream;
+	int res;
+
+	stream = get_locked_ptr(stream_lock, percpu);
+
+	res = msblk->decompressor->decompress(msblk, stream->stream, bh, b,
+			offset, length, output);
+
+	put_locked_ptr(stream_lock, stream);
 
 	if (res < 0)
 		ERROR("%s decompression failed, data probably corrupt\n",
-- 
2.17.0
