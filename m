Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752435AbeDLJWB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 05:22:01 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40573 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750743AbeDLJV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 05:21:59 -0400
X-Google-Smtp-Source: AIpwx48BQZV+NLW0HZJz+tihVHOcorHG7OoMuePflSqmzWwRtNJZ1bTnmrLxvOXQ8UgPJUruozmtqg==
From: Jack Wang <jinpu.wang@profitbricks.com>
X-Google-Original-From: Jack Wang <jinpu.wangl@profitbricks.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        elliott@hpe.com, Jack Wang <jinpu.wang@profitbricks.com>
Subject: [PATCH v2] block: ratelimite pr_err on IO path
Date: Thu, 12 Apr 2018 11:21:55 +0200
Message-Id: <1523524915-25170-1-git-send-email-jinpu.wangl@profitbricks.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jack Wang <jinpu.wang@profitbricks.com>

This avoid soft lockup below:
[ 2328.328429] Call Trace:
[ 2328.328433]  vprintk_emit+0x229/0x2e0
[ 2328.328436]  ? t10_pi_type3_verify_ip+0x20/0x20
[ 2328.328437]  printk+0x52/0x6e
[ 2328.328439]  t10_pi_verify+0x9e/0xf0
[ 2328.328441]  bio_integrity_process+0x12e/0x220
[ 2328.328442]  ? t10_pi_type1_verify_crc+0x20/0x20
[ 2328.328443]  bio_integrity_verify_fn+0xde/0x140
[ 2328.328447]  process_one_work+0x13f/0x370
[ 2328.328449]  worker_thread+0x62/0x3d0
[ 2328.328450]  ? rescuer_thread+0x2f0/0x2f0
[ 2328.328452]  kthread+0x116/0x150
[ 2328.328454]  ? __kthread_parkme+0x70/0x70
[ 2328.328457]  ret_from_fork+0x35/0x40

Signed-off-by: Jack Wang <jinpu.wang@profitbricks.com>
---
v2: keep the message in same line as Robert and coding style suggested

 block/t10-pi.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/block/t10-pi.c b/block/t10-pi.c
index a98db38..6faf8c1 100644
--- a/block/t10-pi.c
+++ b/block/t10-pi.c
@@ -84,10 +84,11 @@ static blk_status_t t10_pi_verify(struct blk_integrity_iter *iter,
 
 			if (be32_to_cpu(pi->ref_tag) !=
 			    lower_32_bits(iter->seed)) {
-				pr_err("%s: ref tag error at location %llu " \
-				       "(rcvd %u)\n", iter->disk_name,
-				       (unsigned long long)
-				       iter->seed, be32_to_cpu(pi->ref_tag));
+				pr_err_ratelimited("%s: ref tag error at location %llu (rcvd %u)\n",
+						   iter->disk_name,
+						   (unsigned long long)
+						   iter->seed,
+						   be32_to_cpu(pi->ref_tag));
 				return BLK_STS_PROTECTION;
 			}
 			break;
@@ -101,10 +102,11 @@ static blk_status_t t10_pi_verify(struct blk_integrity_iter *iter,
 		csum = fn(iter->data_buf, iter->interval);
 
 		if (pi->guard_tag != csum) {
-			pr_err("%s: guard tag error at sector %llu " \
-			       "(rcvd %04x, want %04x)\n", iter->disk_name,
-			       (unsigned long long)iter->seed,
-			       be16_to_cpu(pi->guard_tag), be16_to_cpu(csum));
+			pr_err_ratelimited("%s: guard tag error at sector %llu (rcvd %04x, want %04x)\n",
+					   iter->disk_name,
+					   (unsigned long long)iter->seed,
+					   be16_to_cpu(pi->guard_tag),
+					   be16_to_cpu(csum));
 			return BLK_STS_PROTECTION;
 		}
 
-- 
2.7.4
