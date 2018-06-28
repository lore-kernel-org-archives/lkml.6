Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F75C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 21:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B34A8279DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 21:51:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B34A8279DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966688AbeF1VvB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 17:51:01 -0400
Received: from mga05.intel.com ([192.55.52.43]:16533 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966094AbeF1VvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 17:51:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jun 2018 14:51:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,285,1526367600"; 
   d="scan'208";a="67214448"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.44])
  by fmsmga004.fm.intel.com with ESMTP; 28 Jun 2018 14:50:48 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Johannes Thumshirn <jthumshirn@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Keith Busch <keith.busch@intel.com>
Subject: [PATCHv2 1/4] nvme: trace nvme queue identifiers
Date:   Thu, 28 Jun 2018 15:49:53 -0600
Message-Id: <20180628214956.13877-2-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180628214956.13877-1-keith.busch@intel.com>
References: <20180628214956.13877-1-keith.busch@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can not match a command to its completion based on the command id
alone. We need the submitting queue identifier to pair the completion,
so this patch adds that to the trace buffer.

This patch is also collapsing the admin and io submission traces into
a single one since we don't need to duplicate this and creating
unnecessary code branches.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/nvme/host/core.c  |  7 +++----
 drivers/nvme/host/trace.h | 41 ++++++++++-------------------------------
 2 files changed, 13 insertions(+), 35 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 46df030b2c3f..398a5fb26603 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -97,6 +97,8 @@ static dev_t nvme_chr_devt;
 static struct class *nvme_class;
 static struct class *nvme_subsys_class;
 
+static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
+					   unsigned nsid);
 static void nvme_ns_remove(struct nvme_ns *ns);
 static int nvme_revalidate_disk(struct gendisk *disk);
 static void nvme_put_subsystem(struct nvme_subsystem *subsys);
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
index 01390f0e1671..42c99445dd96 100644
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
+		    __entry->qid = blk_mq_unique_tag_to_hwq(blk_mq_unique_tag(req)) + !!req->rq_disk;
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
+		    __entry->qid = blk_mq_unique_tag_to_hwq(blk_mq_unique_tag(req)) + !!req->rq_disk;
 		    __entry->cid = req->tag;
 		    __entry->result = le64_to_cpu(nvme_req(req)->result.u64);
 		    __entry->retries = nvme_req(req)->retries;
-- 
2.14.3

