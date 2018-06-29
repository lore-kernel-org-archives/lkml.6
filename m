Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F115C6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 20:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBEC427C32
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 20:01:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBEC427C32
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937196AbeF2UBg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 16:01:36 -0400
Received: from mga11.intel.com ([192.55.52.93]:19117 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936809AbeF2UAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 16:00:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jun 2018 13:00:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,287,1526367600"; 
   d="scan'208";a="241791991"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.44])
  by fmsmga006.fm.intel.com with ESMTP; 29 Jun 2018 13:00:46 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Johannes Thumshirn <jthumshirn@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Keith Busch <keith.busch@intel.com>
Subject: [PATCHv3 2/4] nvme: use hw qid in trace events
Date:   Fri, 29 Jun 2018 13:59:58 -0600
Message-Id: <20180629200000.16171-3-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180629200000.16171-1-keith.busch@intel.com>
References: <20180629200000.16171-1-keith.busch@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can not match a command to its completion based on the command
id alone. We need the submitting queue identifier to pair with the
completion, so this patch adds that to the trace buffer.

This patch is also collapsing the admin and IO submission traces into a
single one so we don't need to duplicate this and creating unnecessary
code branches: we know if the command is an admin vs IO based on the qid.

And since we're here, the patch fixes the trace code formatting.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/nvme/host/core.c  |   5 +-
 drivers/nvme/host/trace.h | 113 +++++++++++++++++++++-------------------------
 2 files changed, 53 insertions(+), 65 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 46df030b2c3f..90eb7c55415b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -652,10 +652,7 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req,
 	}
 
 	cmd->common.command_id = req->tag;
-	if (ns)
-		trace_nvme_setup_nvm_cmd(req->q->id, cmd);
-	else
-		trace_nvme_setup_admin_cmd(cmd);
+	trace_nvme_setup_cmd(req, cmd);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(nvme_setup_cmd);
diff --git a/drivers/nvme/host/trace.h b/drivers/nvme/host/trace.h
index 01390f0e1671..67ca8d8e78e1 100644
--- a/drivers/nvme/host/trace.h
+++ b/drivers/nvme/host/trace.h
@@ -24,6 +24,15 @@
 
 #include "nvme.h"
 
+#define __assign_nvme_qid(req, qid)					\
+	do {								\
+		if (req->rq_disk)					\
+			qid = 1 + blk_mq_unique_tag_to_hwq(		\
+					blk_mq_unique_tag(req));	\
+		else							\
+			qid = 0;					\
+	} while (0)
+
 #define nvme_admin_opcode_name(opcode)	{ opcode, #opcode }
 #define show_admin_opcode_name(val)					\
 	__print_symbolic(val,						\
@@ -52,11 +61,11 @@
 
 const char *nvme_trace_parse_admin_cmd(struct trace_seq *p, u8 opcode,
 				       u8 *cdw10);
-#define __parse_nvme_admin_cmd(opcode, cdw10) \
+#define __parse_admin_cmd(opcode, cdw10) \
 	nvme_trace_parse_admin_cmd(p, opcode, cdw10)
 
 #define nvme_opcode_name(opcode)	{ opcode, #opcode }
-#define show_opcode_name(val)					\
+#define show_nvm_opcode_name(val)				\
 	__print_symbolic(val,					\
 		nvme_opcode_name(nvme_cmd_flush),		\
 		nvme_opcode_name(nvme_cmd_write),		\
@@ -70,83 +79,65 @@ const char *nvme_trace_parse_admin_cmd(struct trace_seq *p, u8 opcode,
 		nvme_opcode_name(nvme_cmd_resv_acquire),	\
 		nvme_opcode_name(nvme_cmd_resv_release))
 
+#define show_opcode_name(qid, opcode)					\
+	(qid ? show_nvm_opcode_name(opcode) : show_admin_opcode_name(opcode))
+
 const char *nvme_trace_parse_nvm_cmd(struct trace_seq *p, u8 opcode,
 				     u8 *cdw10);
-#define __parse_nvme_cmd(opcode, cdw10) \
+#define __parse_nvm_cmd(opcode, cdw10) \
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
+#define parse_nvme_cmd(qid, opcode, cdw10) 			\
+	(qid ? __parse_nvm_cmd(opcode, cdw10) : 		\
+	       __parse_admin_cmd(opcode, cdw10))
 
-TRACE_EVENT(nvme_setup_nvm_cmd,
-	    TP_PROTO(int qid, struct nvme_command *cmd),
-	    TP_ARGS(qid, cmd),
+TRACE_EVENT(nvme_setup_cmd,
+	    TP_PROTO(struct request *req, struct nvme_command *cmd),
+	    TP_ARGS(req, cmd),
 	    TP_STRUCT__entry(
-		    __field(int, qid)
-		    __field(u8, opcode)
-		    __field(u8, flags)
-		    __field(u16, cid)
-		    __field(u32, nsid)
-		    __field(u64, metadata)
-		    __array(u8, cdw10, 24)
+		__field(int, qid)
+		__field(u8, opcode)
+		__field(u8, flags)
+		__field(u16, cid)
+		__field(u32, nsid)
+		__field(u64, metadata)
+		__array(u8, cdw10, 24)
 	    ),
 	    TP_fast_assign(
-		    __entry->qid = qid;
-		    __entry->opcode = cmd->common.opcode;
-		    __entry->flags = cmd->common.flags;
-		    __entry->cid = cmd->common.command_id;
-		    __entry->nsid = le32_to_cpu(cmd->common.nsid);
-		    __entry->metadata = le64_to_cpu(cmd->common.metadata);
-		    memcpy(__entry->cdw10, cmd->common.cdw10,
-			   sizeof(__entry->cdw10));
+		__assign_nvme_qid(req, __entry->qid);
+		__entry->opcode = cmd->common.opcode;
+		__entry->flags = cmd->common.flags;
+		__entry->cid = cmd->common.command_id;
+		__entry->nsid = le32_to_cpu(cmd->common.nsid);
+		__entry->metadata = le64_to_cpu(cmd->common.metadata);
+		memcpy(__entry->cdw10, cmd->common.cdw10,
+		       sizeof(__entry->cdw10));
 	    ),
-	    TP_printk("qid=%d, nsid=%u, cmdid=%u, flags=0x%x, meta=0x%llx, cmd=(%s %s)",
-		      __entry->qid, __entry->nsid, __entry->cid,
+	    TP_printk("qid=%d, cmdid=%u, nsid=%u, flags=0x%x, meta=0x%llx, cmd=(%s %s)",
+		      __entry->qid, __entry->nsid, __entry->cid, 
 		      __entry->flags, __entry->metadata,
-		      show_opcode_name(__entry->opcode),
-		      __parse_nvme_cmd(__entry->opcode, __entry->cdw10))
+		      show_opcode_name(__entry->qid, __entry->opcode),
+		      parse_nvme_cmd(__entry->qid, __entry->opcode, __entry->cdw10))
 );
 
 TRACE_EVENT(nvme_complete_rq,
 	    TP_PROTO(struct request *req),
 	    TP_ARGS(req),
 	    TP_STRUCT__entry(
-		    __field(int, qid)
-		    __field(int, cid)
-		    __field(u64, result)
-		    __field(u8, retries)
-		    __field(u8, flags)
-		    __field(u16, status)
+		__field(int, qid)
+		__field(int, cid)
+		__field(u64, result)
+		__field(u8, retries)
+		__field(u8, flags)
+		__field(u16, status)
 	    ),
 	    TP_fast_assign(
-		    __entry->qid = req->q->id;
-		    __entry->cid = req->tag;
-		    __entry->result = le64_to_cpu(nvme_req(req)->result.u64);
-		    __entry->retries = nvme_req(req)->retries;
-		    __entry->flags = nvme_req(req)->flags;
-		    __entry->status = nvme_req(req)->status;
+		__assign_nvme_qid(req, __entry->qid);
+		__entry->cid = req->tag;
+		__entry->result = le64_to_cpu(nvme_req(req)->result.u64);
+		__entry->retries = nvme_req(req)->retries;
+		__entry->flags = nvme_req(req)->flags;
+		__entry->status = nvme_req(req)->status;
 	    ),
 	    TP_printk("qid=%d, cmdid=%u, res=%llu, retries=%u, flags=0x%x, status=%u",
 		      __entry->qid, __entry->cid, __entry->result,
-- 
2.14.3

