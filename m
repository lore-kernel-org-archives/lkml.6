Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDB9C6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 20:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D15127C27
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 20:01:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D15127C27
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965530AbeF2UBD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 16:01:03 -0400
Received: from mga11.intel.com ([192.55.52.93]:19117 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937102AbeF2UAs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 16:00:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jun 2018 13:00:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,287,1526367600"; 
   d="scan'208";a="241791995"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.44])
  by fmsmga006.fm.intel.com with ESMTP; 29 Jun 2018 13:00:47 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Johannes Thumshirn <jthumshirn@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Keith Busch <keith.busch@intel.com>
Subject: [PATCHv3 3/4] nvme: add controller name to trace events
Date:   Fri, 29 Jun 2018 13:59:59 -0600
Message-Id: <20180629200000.16171-4-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180629200000.16171-1-keith.busch@intel.com>
References: <20180629200000.16171-1-keith.busch@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This appends the controller instance to the nvme trace buffer to
distinguish which controller is dispatching and completing a command.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/nvme/host/trace.h | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/trace.h b/drivers/nvme/host/trace.h
index 67ca8d8e78e1..8058f1c9a33e 100644
--- a/drivers/nvme/host/trace.h
+++ b/drivers/nvme/host/trace.h
@@ -95,6 +95,7 @@ TRACE_EVENT(nvme_setup_cmd,
 	    TP_PROTO(struct request *req, struct nvme_command *cmd),
 	    TP_ARGS(req, cmd),
 	    TP_STRUCT__entry(
+		__field(int, ctrl_id)
 		__field(int, qid)
 		__field(u8, opcode)
 		__field(u8, flags)
@@ -105,6 +106,7 @@ TRACE_EVENT(nvme_setup_cmd,
 	    ),
 	    TP_fast_assign(
 		__assign_nvme_qid(req, __entry->qid);
+		__entry->ctrl_id = nvme_req(req)->ctrl->instance;
 		__entry->opcode = cmd->common.opcode;
 		__entry->flags = cmd->common.flags;
 		__entry->cid = cmd->common.command_id;
@@ -113,9 +115,9 @@ TRACE_EVENT(nvme_setup_cmd,
 		memcpy(__entry->cdw10, cmd->common.cdw10,
 		       sizeof(__entry->cdw10));
 	    ),
-	    TP_printk("qid=%d, cmdid=%u, nsid=%u, flags=0x%x, meta=0x%llx, cmd=(%s %s)",
-		      __entry->qid, __entry->nsid, __entry->cid, 
-		      __entry->flags, __entry->metadata,
+	    TP_printk("nvme%d: qid=%d, cmdid=%u, nsid=%u, flags=0x%x, meta=0x%llx, cmd=(%s %s)",
+		      __entry->ctrl_id, __entry->qid, __entry->nsid,
+		      __entry->cid, __entry->flags, __entry->metadata,
 		      show_opcode_name(__entry->qid, __entry->opcode),
 		      parse_nvme_cmd(__entry->qid, __entry->opcode, __entry->cdw10))
 );
@@ -124,6 +126,7 @@ TRACE_EVENT(nvme_complete_rq,
 	    TP_PROTO(struct request *req),
 	    TP_ARGS(req),
 	    TP_STRUCT__entry(
+		__field(int, ctrl_id)
 		__field(int, qid)
 		__field(int, cid)
 		__field(u64, result)
@@ -133,15 +136,17 @@ TRACE_EVENT(nvme_complete_rq,
 	    ),
 	    TP_fast_assign(
 		__assign_nvme_qid(req, __entry->qid);
+		__entry->ctrl_id = nvme_req(req)->ctrl->instance;
 		__entry->cid = req->tag;
 		__entry->result = le64_to_cpu(nvme_req(req)->result.u64);
 		__entry->retries = nvme_req(req)->retries;
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

