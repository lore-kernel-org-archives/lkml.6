Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932067AbeE3NVF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 09:21:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:49484 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752852AbeE3NVA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 09:21:00 -0400
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH] nvme: trace: add disk name to tracepoints
Date: Wed, 30 May 2018 15:20:49 +0200
Message-Id: <20180530132049.5890-1-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add disk name to tracepoints so we can better destinguish between
individual disks in the trace output.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/nvme/host/core.c  |  4 ++--
 drivers/nvme/host/trace.h | 32 ++++++++++++++++++++------------
 2 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 99b857e5a7a9..eb112ff2bede 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -647,9 +647,9 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req,
 
 	cmd->common.command_id = req->tag;
 	if (ns)
-		trace_nvme_setup_nvm_cmd(req->q->id, cmd);
+		trace_nvme_setup_nvm_cmd(ns->disk->disk_name, req->q->id, cmd);
 	else
-		trace_nvme_setup_admin_cmd(cmd);
+		trace_nvme_setup_admin_cmd(ns->disk->disk_name, cmd);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(nvme_setup_cmd);
diff --git a/drivers/nvme/host/trace.h b/drivers/nvme/host/trace.h
index ea91fccd1bc0..3d3f91b933db 100644
--- a/drivers/nvme/host/trace.h
+++ b/drivers/nvme/host/trace.h
@@ -76,9 +76,10 @@ const char *nvme_trace_parse_nvm_cmd(struct trace_seq *p, u8 opcode,
 	nvme_trace_parse_nvm_cmd(p, opcode, cdw10)
 
 TRACE_EVENT(nvme_setup_admin_cmd,
-	    TP_PROTO(struct nvme_command *cmd),
-	    TP_ARGS(cmd),
+	    TP_PROTO(char *disk_name, struct nvme_command *cmd),
+	    TP_ARGS(disk_name, cmd),
 	    TP_STRUCT__entry(
+		    __string(name, disk_name)
 		    __field(u8, opcode)
 		    __field(u8, flags)
 		    __field(u16, cid)
@@ -86,6 +87,7 @@ TRACE_EVENT(nvme_setup_admin_cmd,
 		    __array(u8, cdw10, 24)
 	    ),
 	    TP_fast_assign(
+		    __assign_str(name, disk_name);
 		    __entry->opcode = cmd->common.opcode;
 		    __entry->flags = cmd->common.flags;
 		    __entry->cid = cmd->common.command_id;
@@ -93,17 +95,19 @@ TRACE_EVENT(nvme_setup_admin_cmd,
 		    memcpy(__entry->cdw10, cmd->common.cdw10,
 			   sizeof(__entry->cdw10));
 	    ),
-	    TP_printk(" cmdid=%u, flags=0x%x, meta=0x%llx, cmd=(%s %s)",
-		      __entry->cid, __entry->flags, __entry->metadata,
+	    TP_printk("%s: cmdid=%u, flags=0x%x, meta=0x%llx, cmd=(%s %s)",
+		      __get_str(name), __entry->cid, __entry->flags,
+		      __entry->metadata,
 		      show_admin_opcode_name(__entry->opcode),
 		      __parse_nvme_admin_cmd(__entry->opcode, __entry->cdw10))
 );
 
 
 TRACE_EVENT(nvme_setup_nvm_cmd,
-	    TP_PROTO(int qid, struct nvme_command *cmd),
-	    TP_ARGS(qid, cmd),
+	    TP_PROTO(char *disk_name, int qid, struct nvme_command *cmd),
+	    TP_ARGS(disk_name, qid, cmd),
 	    TP_STRUCT__entry(
+		    __string(name, disk_name)
 		    __field(int, qid)
 		    __field(u8, opcode)
 		    __field(u8, flags)
@@ -113,6 +117,7 @@ TRACE_EVENT(nvme_setup_nvm_cmd,
 		    __array(u8, cdw10, 24)
 	    ),
 	    TP_fast_assign(
+		    __assign_str(name, disk_name);
 		    __entry->qid = qid;
 		    __entry->opcode = cmd->common.opcode;
 		    __entry->flags = cmd->common.flags;
@@ -122,9 +127,9 @@ TRACE_EVENT(nvme_setup_nvm_cmd,
 		    memcpy(__entry->cdw10, cmd->common.cdw10,
 			   sizeof(__entry->cdw10));
 	    ),
-	    TP_printk("qid=%d, nsid=%u, cmdid=%u, flags=0x%x, meta=0x%llx, cmd=(%s %s)",
-		      __entry->qid, __entry->nsid, __entry->cid,
-		      __entry->flags, __entry->metadata,
+	    TP_printk("%s: qid=%d, nsid=%u, cmdid=%u, flags=0x%x, meta=0x%llx, cmd=(%s %s)",
+		      __get_str(name), __entry->qid, __entry->nsid,
+		      __entry->cid, __entry->flags, __entry->metadata,
 		      show_opcode_name(__entry->opcode),
 		      __parse_nvme_cmd(__entry->opcode, __entry->cdw10))
 );
@@ -133,6 +138,7 @@ TRACE_EVENT(nvme_complete_rq,
 	    TP_PROTO(struct request *req),
 	    TP_ARGS(req),
 	    TP_STRUCT__entry(
+		    __string(name, req->rq_disk->disk_name)
 		    __field(int, qid)
 		    __field(int, cid)
 		    __field(u64, result)
@@ -141,6 +147,7 @@ TRACE_EVENT(nvme_complete_rq,
 		    __field(u16, status)
 	    ),
 	    TP_fast_assign(
+		    __assign_str(name, req->rq_disk->disk_name);
 		    __entry->qid = req->q->id;
 		    __entry->cid = req->tag;
 		    __entry->result = le64_to_cpu(nvme_req(req)->result.u64);
@@ -148,9 +155,10 @@ TRACE_EVENT(nvme_complete_rq,
 		    __entry->flags = nvme_req(req)->flags;
 		    __entry->status = nvme_req(req)->status;
 	    ),
-	    TP_printk("cmdid=%u, qid=%d, res=%llu, retries=%u, flags=0x%x, status=%u",
-		      __entry->cid, __entry->qid, __entry->result,
-		      __entry->retries, __entry->flags, __entry->status)
+	    TP_printk("%s: cmdid=%u, qid=%d, res=%llu, retries=%u, flags=0x%x, status=%u",
+		      __get_str(name), __entry->cid, __entry->qid,
+		      __entry->result, __entry->retries, __entry->flags,
+		      __entry->status)
 
 );
 
-- 
2.16.3
