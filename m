Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48678C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 23:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3E54259C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 23:44:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3E54259C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752811AbeF0XoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 19:44:10 -0400
Received: from mga11.intel.com ([192.55.52.93]:18418 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752461AbeF0XoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 19:44:09 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jun 2018 16:44:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,281,1526367600"; 
   d="scan'208";a="67883412"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.44])
  by fmsmga001.fm.intel.com with ESMTP; 27 Jun 2018 16:44:03 -0700
Date:   Wed, 27 Jun 2018 17:43:13 -0600
From:   Keith Busch <keith.busch@linux.intel.com>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Johannes Thumshirn <jthumshirn@suse.de>,
        Keith Busch <keith.busch@intel.com>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme: trace: add disk name to tracepoints
Message-ID: <20180627234313.GB10657@localhost.localdomain>
References: <20180626135141.14088-1-jthumshirn@suse.de>
 <20180626135141.14088-3-jthumshirn@suse.de>
 <20180626150106.GB6628@localhost.localdomain>
 <20180627073328.aws2apvc357jobge@linux-x5ow.site>
 <1e7d0f93-9d20-1b99-58c4-651b1d0dedf0@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e7d0f93-9d20-1b99-58c4-651b1d0dedf0@grimberg.me>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 11:06:22AM +0300, Sagi Grimberg wrote:
> 
> > > Not related to your patch, but I did notice that the req->q->id isn't
> > > really useful here since that's not the hardware context identifier.
> > > That's just some ida assigned software identifier. For the admin command
> > > completion trace, it's actually a little confusing to see the qid in the
> > > trace.
> > 
> > It was actually requested by Martin so we can easily see which request
> > got dispatched/completed on which request queue.
> 
> Would be good in the future to display the hwqid, but we'll need to work
> before we can do that.

I'd really like to see nvme qid, and it would allow for nice trace
filters.  We could use a little help from blk-mq to get the hctx's
queue_num from a struct request. I think following should get us that
(haven't tested just yet)

---
diff --git a/block/blk-mq.c b/block/blk-mq.c
index b429d515b568..c6478833464d 100644
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
index 46df030b2c3f..6a30c154aa99 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -653,7 +653,7 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req,
 
 	cmd->common.command_id = req->tag;
 	if (ns)
-		trace_nvme_setup_nvm_cmd(req->q->id, cmd);
+		trace_nvme_setup_nvm_cmd(req, cmd);
 	else
 		trace_nvme_setup_admin_cmd(cmd);
 	return ret;
diff --git a/drivers/nvme/host/trace.h b/drivers/nvme/host/trace.h
index 01390f0e1671..95ebe803424b 100644
--- a/drivers/nvme/host/trace.h
+++ b/drivers/nvme/host/trace.h
@@ -79,6 +79,7 @@ TRACE_EVENT(nvme_setup_admin_cmd,
 	    TP_PROTO(struct nvme_command *cmd),
 	    TP_ARGS(cmd),
 	    TP_STRUCT__entry(
+		    __field(int, qid)
 		    __field(u8, opcode)
 		    __field(u8, flags)
 		    __field(u16, cid)
@@ -86,6 +87,7 @@ TRACE_EVENT(nvme_setup_admin_cmd,
 		    __array(u8, cdw10, 24)
 	    ),
 	    TP_fast_assign(
+		    __entry->qid = 0;
 		    __entry->opcode = cmd->common.opcode;
 		    __entry->flags = cmd->common.flags;
 		    __entry->cid = cmd->common.command_id;
@@ -93,16 +95,16 @@ TRACE_EVENT(nvme_setup_admin_cmd,
 		    memcpy(__entry->cdw10, cmd->common.cdw10,
 			   sizeof(__entry->cdw10));
 	    ),
-	    TP_printk(" cmdid=%u, flags=0x%x, meta=0x%llx, cmd=(%s %s)",
-		      __entry->cid, __entry->flags, __entry->metadata,
+	    TP_printk("qid=%d, cmdid=%u, flags=0x%x, meta=0x%llx, cmd=(%s %s)",
+		      __entry->qid, __entry->cid, __entry->flags, __entry->metadata,
 		      show_admin_opcode_name(__entry->opcode),
 		      __parse_nvme_admin_cmd(__entry->opcode, __entry->cdw10))
 );
 
 
 TRACE_EVENT(nvme_setup_nvm_cmd,
-	    TP_PROTO(int qid, struct nvme_command *cmd),
-	    TP_ARGS(qid, cmd),
+	    TP_PROTO(struct request *req, struct nvme_command *cmd),
+	    TP_ARGS(req, cmd),
 	    TP_STRUCT__entry(
 		    __field(int, qid)
 		    __field(u8, opcode)
@@ -113,7 +115,7 @@ TRACE_EVENT(nvme_setup_nvm_cmd,
 		    __array(u8, cdw10, 24)
 	    ),
 	    TP_fast_assign(
-		    __entry->qid = qid;
+		    __entry->qid = blk_mq_request_hctx_idx(req) + !!req->rq_disk;
 		    __entry->opcode = cmd->common.opcode;
 		    __entry->flags = cmd->common.flags;
 		    __entry->cid = cmd->common.command_id;
@@ -141,7 +143,7 @@ TRACE_EVENT(nvme_complete_rq,
 		    __field(u16, status)
 	    ),
 	    TP_fast_assign(
-		    __entry->qid = req->q->id;
+		    __entry->qid = blk_mq_request_hctx_idx(req) + !!req->rq_disk;
 		    __entry->cid = req->tag;
 		    __entry->result = le64_to_cpu(nvme_req(req)->result.u64);
 		    __entry->retries = nvme_req(req)->retries;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index e3147eb74222..af91b2d31a04 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -248,6 +248,7 @@ static inline u16 blk_mq_unique_tag_to_tag(u32 unique_tag)
 }
 
 
+unsigned int blk_mq_request_hctx_idx(struct request *rq);
 int blk_mq_request_started(struct request *rq);
 void blk_mq_start_request(struct request *rq);
 void blk_mq_end_request(struct request *rq, blk_status_t error);
--
