Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754030AbeEWF1d (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 01:27:33 -0400
Received: from mga11.intel.com ([192.55.52.93]:46868 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754007AbeEWF13 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 01:27:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,431,1520924400";
   d="scan'208";a="57687160"
From: Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>
To: alan@linux.intel.com, sakari.ailus@linux.intel.com, mchehab@kernel.org,
        gregkh@linuxfoundation.org
Cc: linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] media: staging: atomisp: Remove useless if statement
Date: Wed, 23 May 2018 10:51:32 +0530
Message-Id: <1527052896-30777-3-git-send-email-pankaj.laxminarayan.bharadiya@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527052896-30777-1-git-send-email-pankaj.laxminarayan.bharadiya@intel.com>
References: <1527052896-30777-1-git-send-email-pankaj.laxminarayan.bharadiya@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Local variable "requeue" is assigned only once to a constant "false"
value so "if(requeue)" condition will never be true.
Thus remove it.

Signed-off-by: Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>
---
 drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c b/drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c
index fa6ea50..c8c4d1d 100644
--- a/drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c
+++ b/drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c
@@ -883,7 +883,6 @@ void atomisp_buf_done(struct atomisp_sub_device *asd, int error,
 	struct videobuf_buffer *vb = NULL;
 	struct atomisp_video_pipe *pipe = NULL;
 	struct atomisp_css_buffer buffer;
-	bool requeue = false;
 	int err;
 	unsigned long irqflags;
 	struct atomisp_css_frame *frame = NULL;
@@ -1223,19 +1222,6 @@ void atomisp_buf_done(struct atomisp_sub_device *asd, int error,
 #ifdef ISP2401
 	atomic_set(&pipe->wdt_count, 0);
 #endif
-	/*
-	 * Requeue should only be done for 3a and dis buffers.
-	 * Queue/dequeue order will change if driver recycles image buffers.
-	 */
-	if (requeue) {
-		err = atomisp_css_queue_buffer(asd,
-					       stream_id, css_pipe_id,
-					       buf_type, &buffer);
-		if (err)
-			dev_err(isp->dev, "%s, q to css fails: %d\n",
-					__func__, err);
-		return;
-	}
 	if (!error && q_buffers)
 		atomisp_qbuffers_to_css(asd);
 #ifdef ISP2401
-- 
2.7.4
