Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935726AbeE3F7b convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 01:59:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50282 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S934498AbeE3F73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 01:59:29 -0400
Date: Wed, 30 May 2018 07:59:20 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [GIT PULL] two more s390 bug fixes for 4.17
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
X-TM-AS-GCONF: 00
x-cbid: 18053005-0040-0000-0000-0000043F2A01
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18053005-0041-0000-0000-000026447BF4
Message-Id: <20180530075920.1f73275a@mschwideX1>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-30_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=846 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1805300069
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull from the 'for-linus' branch of

	git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git for-linus

to receive the following updates:

Two bug fixes for 4.17

 * A missing -msoft-float for the compile of the kexec purgatory

 * A fix for the dasd driver to avoid the double use of a field in
   the 'struct request'

Philipp Rudo (1):
      s390/purgatory: Fix endless interrupt loop

Sebastian Ott (1):
      s390/dasd: use blk_mq_rq_from_pdu for per request data

 arch/s390/purgatory/Makefile | 2 +-
 drivers/s390/block/dasd.c    | 7 +++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/s390/purgatory/Makefile b/arch/s390/purgatory/Makefile
index e9525bc..1ace023 100644
--- a/arch/s390/purgatory/Makefile
+++ b/arch/s390/purgatory/Makefile
@@ -21,7 +21,7 @@ LDFLAGS_purgatory.ro += -z nodefaultlib
 KBUILD_CFLAGS := -fno-strict-aliasing -Wall -Wstrict-prototypes
 KBUILD_CFLAGS += -Wno-pointer-sign -Wno-sign-compare
 KBUILD_CFLAGS += -fno-zero-initialized-in-bss -fno-builtin -ffreestanding
-KBUILD_CFLAGS += -c -MD -Os -m64
+KBUILD_CFLAGS += -c -MD -Os -m64 -msoft-float
 KBUILD_CFLAGS += $(call cc-option,-fno-PIE)
 
 $(obj)/purgatory.ro: $(PURGATORY_OBJS) FORCE
diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 04143c0..02c03e4 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -3034,7 +3034,8 @@ static blk_status_t do_dasd_request(struct blk_mq_hw_ctx *hctx,
 	cqr->callback_data = req;
 	cqr->status = DASD_CQR_FILLED;
 	cqr->dq = dq;
-	req->completion_data = cqr;
+	*((struct dasd_ccw_req **) blk_mq_rq_to_pdu(req)) = cqr;
+
 	blk_mq_start_request(req);
 	spin_lock(&block->queue_lock);
 	list_add_tail(&cqr->blocklist, &block->ccw_queue);
@@ -3058,12 +3059,13 @@ static blk_status_t do_dasd_request(struct blk_mq_hw_ctx *hctx,
  */
 enum blk_eh_timer_return dasd_times_out(struct request *req, bool reserved)
 {
-	struct dasd_ccw_req *cqr = req->completion_data;
 	struct dasd_block *block = req->q->queuedata;
 	struct dasd_device *device;
+	struct dasd_ccw_req *cqr;
 	unsigned long flags;
 	int rc = 0;
 
+	cqr = *((struct dasd_ccw_req **) blk_mq_rq_to_pdu(req));
 	if (!cqr)
 		return BLK_EH_NOT_HANDLED;
 
@@ -3169,6 +3171,7 @@ static int dasd_alloc_queue(struct dasd_block *block)
 	int rc;
 
 	block->tag_set.ops = &dasd_mq_ops;
+	block->tag_set.cmd_size = sizeof(struct dasd_ccw_req *);
 	block->tag_set.nr_hw_queues = DASD_NR_HW_QUEUES;
 	block->tag_set.queue_depth = DASD_MAX_LCU_DEV * DASD_REQ_PER_DEV;
 	block->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
