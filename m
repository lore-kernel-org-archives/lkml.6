Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 441DFC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 20:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05E62279A9
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 20:57:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05E62279A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936097AbeF1U5h (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 16:57:37 -0400
Received: from mga09.intel.com ([134.134.136.24]:31844 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935830AbeF1U5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 16:57:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jun 2018 13:57:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,284,1526367600"; 
   d="scan'208";a="50702328"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.44])
  by fmsmga007.fm.intel.com with ESMTP; 28 Jun 2018 13:56:57 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Johannes Thumshirn <jthumshirn@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <keith.busch@intel.com>
Subject: [PATCH 4/5] nvme: trace controller name
Date:   Thu, 28 Jun 2018 14:56:00 -0600
Message-Id: <20180628205601.13742-4-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180628205601.13742-1-keith.busch@intel.com>
References: <20180628205601.13742-1-keith.busch@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This appends the controller instance to the trace buffer for nvme commands
to distinguish what controller is dispatching a command.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/nvme/host/trace.h | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/trace.h b/drivers/nvme/host/trace.h
index bca3451caa37..57344980af16 100644
--- a/drivers/nvme/host/trace.h
+++ b/drivers/nvme/host/trace.h
@@ -79,6 +79,7 @@ TRACE_EVENT(nvme_setup_nvm_cmd,
 	    TP_PROTO(struct request *req, struct nvme_command *cmd),
 	    TP_ARGS(req, cmd),
 	    TP_STRUCT__entry(
+		    __field(int, ctrl_id)
 		    __field(int, qid)
 		    __field(u8, opcode)
 		    __field(u8, flags)
@@ -88,6 +89,7 @@ TRACE_EVENT(nvme_setup_nvm_cmd,
 		    __array(u8, cdw10, 24)
 	    ),
 	    TP_fast_assign(
+		    __entry->ctrl_id = nvme_req(req)->ctrl->instance;
 		    __entry->qid = blk_mq_request_hctx_idx(req) + !!req->rq_disk;
 		    __entry->opcode = cmd->common.opcode;
 		    __entry->flags = cmd->common.flags;
@@ -97,9 +99,9 @@ TRACE_EVENT(nvme_setup_nvm_cmd,
 		    memcpy(__entry->cdw10, cmd->common.cdw10,
 			   sizeof(__entry->cdw10));
 	    ),
-	    TP_printk("qid=%d, nsid=%u, cmdid=%u, flags=0x%x, meta=0x%llx, cmd=(%s %s)",
-		      __entry->qid, __entry->nsid, __entry->cid,
-		      __entry->flags, __entry->metadata,
+	    TP_printk("nvme%d: qid=%d, cmdid=%u, nsid=%u, flags=0x%x, meta=0x%llx, cmd=(%s %s)",
+		      __entry->ctrl_id, __entry->qid, __entry->nsid,
+		      __entry->cid, __entry->flags, __entry->metadata,
 		      __entry->qid ?
 				show_opcode_name(__entry->opcode) :
 				show_admin_opcode_name(__entry->opcode),
@@ -112,6 +114,7 @@ TRACE_EVENT(nvme_complete_rq,
 	    TP_PROTO(struct request *req),
 	    TP_ARGS(req),
 	    TP_STRUCT__entry(
+		    __field(int, ctrl_id)
 		    __field(int, qid)
 		    __field(int, cid)
 		    __field(u64, result)
@@ -120,6 +123,7 @@ TRACE_EVENT(nvme_complete_rq,
 		    __field(u16, status)
 	    ),
 	    TP_fast_assign(
+		    __entry->ctrl_id = nvme_req(req)->ctrl->instance;
 		    __entry->qid = blk_mq_request_hctx_idx(req) + !!req->rq_disk;
 		    __entry->cid = req->tag;
 		    __entry->result = le64_to_cpu(nvme_req(req)->result.u64);
@@ -127,9 +131,10 @@ TRACE_EVENT(nvme_complete_rq,
 		    __entry->flags = nvme_req(req)->flags;
 		    __entry->status = nvme_req(req)->status;
 	    ),
-	    TP_printk("qid=%d, cmdid=%u, res=%llu, retries=%u, flags=0x%x, status=%u",
-		      __entry->qid, __entry->cid, __entry->result,
-		      __entry->retries, __entry->flags, __entry->status)
+	    TP_printk("nvme%d: qid=%d, cmdid=%u, res=%llu, retries=%u, flags=0x%x, status=%u",
+		      __entry->ctrl_id,  __entry->qid, __entry->cid,
+		      __entry->result, __entry->retries, __entry->flags,
+		      __entry->status)
 
 );
 
-- 
2.14.3

