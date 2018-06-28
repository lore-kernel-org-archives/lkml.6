Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8DA0C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 01:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F00925953
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 01:00:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F00925953
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752704AbeF1BAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 21:00:35 -0400
Received: from mga02.intel.com ([134.134.136.20]:21694 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751011AbeF1BAe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 21:00:34 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jun 2018 18:00:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,281,1526367600"; 
   d="scan'208";a="70581116"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.44])
  by orsmga002.jf.intel.com with ESMTP; 27 Jun 2018 18:00:32 -0700
Date:   Wed, 27 Jun 2018 18:59:43 -0600
From:   Keith Busch <keith.busch@linux.intel.com>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH] nvme: trace: add disk name to tracepoints
Message-ID: <20180628005943.GC10657@localhost.localdomain>
References: <20180626135141.14088-1-jthumshirn@suse.de>
 <20180626135141.14088-3-jthumshirn@suse.de>
 <20180626150106.GB6628@localhost.localdomain>
 <20180627073328.aws2apvc357jobge@linux-x5ow.site>
 <1e7d0f93-9d20-1b99-58c4-651b1d0dedf0@grimberg.me>
 <20180627234313.GB10657@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627234313.GB10657@localhost.localdomain>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thinking more on this, not using the hw qid really limits the utility
out of using these trace events: We may not be able to match a completion
to the submission without it since cmdid alone isn't enough to match up
the two events.

Here's an updated proposal and actually tested. I was also able to
combine admin and io submissions.

---
diff --git a/block/blk-mq.c b/block/blk-mq.c
index b429d51..c647883 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -466,6 +466,12 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 }
 EXPORT_SYMBOL_GPL(blk_mq_alloc_request_hctx);
 
+unsigned int blk_mq_request_hctx_idx(struct request *rq)
+{
+	return blk_mq_map_queue(rq->q, rq->mq_ctx->cpu)->queue_num;
+}
+EXPORT_SYMBOL_GPL(blk_mq_request_hctx_idx);
+
 static void __blk_mq_free_request(struct request *rq)
 {
 	struct request_queue *q = rq->q;
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 46df030..f46bde2 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -652,10 +654,7 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req,
 	}
 
 	cmd->common.command_id = req->tag;
-	if (ns)
-		trace_nvme_setup_nvm_cmd(req->q->id, cmd);
-	else
-		trace_nvme_setup_admin_cmd(cmd);
+	trace_nvme_setup_nvm_cmd(req, cmd);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(nvme_setup_cmd);
diff --git a/drivers/nvme/host/trace.h b/drivers/nvme/host/trace.h
index 01390f0..bca3451 100644
--- a/drivers/nvme/host/trace.h
+++ b/drivers/nvme/host/trace.h
@@ -75,34 +75,9 @@ const char *nvme_trace_parse_nvm_cmd(struct trace_seq *p, u8 opcode,
 #define __parse_nvme_cmd(opcode, cdw10) \
 	nvme_trace_parse_nvm_cmd(p, opcode, cdw10)
 
-TRACE_EVENT(nvme_setup_admin_cmd,
-	    TP_PROTO(struct nvme_command *cmd),
-	    TP_ARGS(cmd),
-	    TP_STRUCT__entry(
-		    __field(u8, opcode)
-		    __field(u8, flags)
-		    __field(u16, cid)
-		    __field(u64, metadata)
-		    __array(u8, cdw10, 24)
-	    ),
-	    TP_fast_assign(
-		    __entry->opcode = cmd->common.opcode;
-		    __entry->flags = cmd->common.flags;
-		    __entry->cid = cmd->common.command_id;
-		    __entry->metadata = le64_to_cpu(cmd->common.metadata);
-		    memcpy(__entry->cdw10, cmd->common.cdw10,
-			   sizeof(__entry->cdw10));
-	    ),
-	    TP_printk(" cmdid=%u, flags=0x%x, meta=0x%llx, cmd=(%s %s)",
-		      __entry->cid, __entry->flags, __entry->metadata,
-		      show_admin_opcode_name(__entry->opcode),
-		      __parse_nvme_admin_cmd(__entry->opcode, __entry->cdw10))
-);
-
-
 TRACE_EVENT(nvme_setup_nvm_cmd,
-	    TP_PROTO(int qid, struct nvme_command *cmd),
-	    TP_ARGS(qid, cmd),
+	    TP_PROTO(struct request *req, struct nvme_command *cmd),
+	    TP_ARGS(req, cmd),
 	    TP_STRUCT__entry(
 		    __field(int, qid)
 		    __field(u8, opcode)
@@ -113,7 +88,7 @@ TRACE_EVENT(nvme_setup_nvm_cmd,
 		    __array(u8, cdw10, 24)
 	    ),
 	    TP_fast_assign(
-		    __entry->qid = qid;
+		    __entry->qid = blk_mq_request_hctx_idx(req) + !!req->rq_disk;
 		    __entry->opcode = cmd->common.opcode;
 		    __entry->flags = cmd->common.flags;
 		    __entry->cid = cmd->common.command_id;
@@ -125,8 +100,12 @@ TRACE_EVENT(nvme_setup_nvm_cmd,
 	    TP_printk("qid=%d, nsid=%u, cmdid=%u, flags=0x%x, meta=0x%llx, cmd=(%s %s)",
 		      __entry->qid, __entry->nsid, __entry->cid,
 		      __entry->flags, __entry->metadata,
-		      show_opcode_name(__entry->opcode),
-		      __parse_nvme_cmd(__entry->opcode, __entry->cdw10))
+		      __entry->qid ?
+				show_opcode_name(__entry->opcode) :
+				show_admin_opcode_name(__entry->opcode),
+		      __entry->qid ?
+				__parse_nvme_cmd(__entry->opcode, __entry->cdw10) :
+				__parse_nvme_admin_cmd(__entry->opcode, __entry->cdw10))
 );
 
 TRACE_EVENT(nvme_complete_rq,
@@ -141,7 +120,7 @@ TRACE_EVENT(nvme_complete_rq,
 		    __field(u16, status)
 	    ),
 	    TP_fast_assign(
-		    __entry->qid = req->q->id;
+		    __entry->qid = blk_mq_request_hctx_idx(req) + !!req->rq_disk;
 		    __entry->cid = req->tag;
 		    __entry->result = le64_to_cpu(nvme_req(req)->result.u64);
 		    __entry->retries = nvme_req(req)->retries;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index e3147eb..af91b2d 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -248,6 +248,7 @@ static inline u16 blk_mq_unique_tag_to_tag(u32 unique_tag)
 }
 
 
+unsigned int blk_mq_request_hctx_idx(struct request *rq);
 int blk_mq_request_started(struct request *rq);
 void blk_mq_start_request(struct request *rq);
 void blk_mq_end_request(struct request *rq, blk_status_t error);
--
