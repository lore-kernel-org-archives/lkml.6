Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CBE0C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 13:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2127226BA7
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 13:52:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2127226BA7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935853AbeFZNwM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 09:52:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:44393 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935502AbeFZNvs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 09:51:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id F0B1CAF13;
        Tue, 26 Jun 2018 13:51:46 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <keith.busch@intel.com>
Cc:     Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH] nvme: trace: add disk name to tracepoints
Date:   Tue, 26 Jun 2018 15:51:41 +0200
Message-Id: <20180626135141.14088-3-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180626135141.14088-1-jthumshirn@suse.de>
References: <20180626135141.14088-1-jthumshirn@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add disk name to tracepoints so we can better distinguish between
individual disks in the trace output and admin commands which
are represented without a disk name.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/nvme/host/core.c  |  4 ++--
 drivers/nvme/host/trace.h | 39 +++++++++++++++++++++++++--------------
 2 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 62602af9eb77..cc1340948245 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -655,9 +655,9 @@ blk_status_t nvme_setup_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	cmd->common.command_id = req->tag;
 	nvme_req(req)->ctrl = ctrl;
 	if (ns)
-		trace_nvme_setup_nvm_cmd(req->q->id, cmd);
+		trace_nvme_setup_nvm_cmd(req, cmd, ns->disk->disk_name);
 	else
-		trace_nvme_setup_admin_cmd(cmd);
+		trace_nvme_setup_admin_cmd(req, cmd);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(nvme_setup_cmd);
diff --git a/drivers/nvme/host/trace.h b/drivers/nvme/host/trace.h
index 01390f0e1671..371a816cd225 100644
--- a/drivers/nvme/host/trace.h
+++ b/drivers/nvme/host/trace.h
@@ -76,9 +76,10 @@ const char *nvme_trace_parse_nvm_cmd(struct trace_seq *p, u8 opcode,
 	nvme_trace_parse_nvm_cmd(p, opcode, cdw10)
 
 TRACE_EVENT(nvme_setup_admin_cmd,
-	    TP_PROTO(struct nvme_command *cmd),
-	    TP_ARGS(cmd),
+	    TP_PROTO(struct request *req, struct nvme_command *cmd),
+	    TP_ARGS(req, cmd),
 	    TP_STRUCT__entry(
+		    __field(int, ctrl_id)
 		    __field(u8, opcode)
 		    __field(u8, flags)
 		    __field(u16, cid)
@@ -86,6 +87,7 @@ TRACE_EVENT(nvme_setup_admin_cmd,
 		    __array(u8, cdw10, 24)
 	    ),
 	    TP_fast_assign(
+		    __entry->ctrl_id = nvme_req(req)->ctrl->cntlid;
 		    __entry->opcode = cmd->common.opcode;
 		    __entry->flags = cmd->common.flags;
 		    __entry->cid = cmd->common.command_id;
@@ -93,17 +95,21 @@ TRACE_EVENT(nvme_setup_admin_cmd,
 		    memcpy(__entry->cdw10, cmd->common.cdw10,
 			   sizeof(__entry->cdw10));
 	    ),
-	    TP_printk(" cmdid=%u, flags=0x%x, meta=0x%llx, cmd=(%s %s)",
-		      __entry->cid, __entry->flags, __entry->metadata,
+	    TP_printk("nvme%d: cmdid=%u, flags=0x%x, meta=0x%llx, cmd=(%s %s)",
+		      __entry->ctrl_id, __entry->cid, __entry->flags,
+		      __entry->metadata,
 		      show_admin_opcode_name(__entry->opcode),
 		      __parse_nvme_admin_cmd(__entry->opcode, __entry->cdw10))
 );
 
 
 TRACE_EVENT(nvme_setup_nvm_cmd,
-	    TP_PROTO(int qid, struct nvme_command *cmd),
-	    TP_ARGS(qid, cmd),
+	    TP_PROTO(struct request *req, struct nvme_command *cmd,
+		     char *disk_name),
+	    TP_ARGS(req, cmd, disk_name),
 	    TP_STRUCT__entry(
+		    __string(name, disk_name)
+		    __field(int, ctrl_id)
 		    __field(int, qid)
 		    __field(u8, opcode)
 		    __field(u8, flags)
@@ -113,7 +119,9 @@ TRACE_EVENT(nvme_setup_nvm_cmd,
 		    __array(u8, cdw10, 24)
 	    ),
 	    TP_fast_assign(
-		    __entry->qid = qid;
+		    __assign_str(name, disk_name);
+		    __entry->ctrl_id = nvme_req(req)->ctrl->cntlid;
+		    __entry->qid = req->q->id;
 		    __entry->opcode = cmd->common.opcode;
 		    __entry->flags = cmd->common.flags;
 		    __entry->cid = cmd->common.command_id;
@@ -122,10 +130,10 @@ TRACE_EVENT(nvme_setup_nvm_cmd,
 		    memcpy(__entry->cdw10, cmd->common.cdw10,
 			   sizeof(__entry->cdw10));
 	    ),
-	    TP_printk("qid=%d, nsid=%u, cmdid=%u, flags=0x%x, meta=0x%llx, cmd=(%s %s)",
-		      __entry->qid, __entry->nsid, __entry->cid,
-		      __entry->flags, __entry->metadata,
-		      show_opcode_name(__entry->opcode),
+	    TP_printk("nvme%d: disk=%s, qid=%d, nsid=%u, cmdid=%u, flags=0x%x, meta=0x%llx, cmd=(%s %s)",
+		      __entry->ctrl_id, __get_str(name), __entry->qid,
+		      __entry->nsid, __entry->cid, __entry->flags,
+		      __entry->metadata, show_opcode_name(__entry->opcode),
 		      __parse_nvme_cmd(__entry->opcode, __entry->cdw10))
 );
 
@@ -133,6 +141,7 @@ TRACE_EVENT(nvme_complete_rq,
 	    TP_PROTO(struct request *req),
 	    TP_ARGS(req),
 	    TP_STRUCT__entry(
+		    __field(int, ctrl_id)
 		    __field(int, qid)
 		    __field(int, cid)
 		    __field(u64, result)
@@ -141,6 +150,7 @@ TRACE_EVENT(nvme_complete_rq,
 		    __field(u16, status)
 	    ),
 	    TP_fast_assign(
+		    __entry->ctrl_id = nvme_req(req)->ctrl->cntlid;
 		    __entry->qid = req->q->id;
 		    __entry->cid = req->tag;
 		    __entry->result = le64_to_cpu(nvme_req(req)->result.u64);
@@ -148,9 +158,10 @@ TRACE_EVENT(nvme_complete_rq,
 		    __entry->flags = nvme_req(req)->flags;
 		    __entry->status = nvme_req(req)->status;
 	    ),
-	    TP_printk("qid=%d, cmdid=%u, res=%llu, retries=%u, flags=0x%x, status=%u",
-		      __entry->qid, __entry->cid, __entry->result,
-		      __entry->retries, __entry->flags, __entry->status)
+	    TP_printk("nvme%d: qid=%d, cmdid=%u, res=%llu, retries=%u, flags=0x%x, status=%u",
+		      __entry->ctrl_id, __entry->qid, __entry->cid,
+		      __entry->result,  __entry->retries, __entry->flags,
+		      __entry->status)
 
 );
 
-- 
2.16.4

