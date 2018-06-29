Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DE4C6778C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 20:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B41727C27
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 20:01:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B41727C27
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937311AbeF2UBC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 16:01:02 -0400
Received: from mga11.intel.com ([192.55.52.93]:19117 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932890AbeF2UAs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 16:00:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jun 2018 13:00:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,287,1526367600"; 
   d="scan'208";a="241791999"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.44])
  by fmsmga006.fm.intel.com with ESMTP; 29 Jun 2018 13:00:47 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Johannes Thumshirn <jthumshirn@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Keith Busch <keith.busch@intel.com>
Subject: [PATCHv3 4/4] nvme: add disk name to trace events
Date:   Fri, 29 Jun 2018 14:00:00 -0600
Message-Id: <20180629200000.16171-5-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180629200000.16171-1-keith.busch@intel.com>
References: <20180629200000.16171-1-keith.busch@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will print the disk name to the nvme event trace for io requests so
a user can better distinguish traffic to different disks. This can be used
to  create disk based filters. For example, to see only nvme0n2 traffic:

  echo "disk == \"nvme0n2\"" > /sys/kernel/debug/tracing/events/nvme/filter

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/nvme/host/trace.c | 11 +++++++++++
 drivers/nvme/host/trace.h | 31 ++++++++++++++++++++++++-------
 2 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/trace.c b/drivers/nvme/host/trace.c
index 41944bbef835..25b0e310f4a8 100644
--- a/drivers/nvme/host/trace.c
+++ b/drivers/nvme/host/trace.c
@@ -128,3 +128,14 @@ const char *nvme_trace_parse_nvm_cmd(struct trace_seq *p,
 		return nvme_trace_common(p, cdw10);
 	}
 }
+
+const char *nvme_trace_disk_name(struct trace_seq *p, char *name)
+{
+	const char *ret = trace_seq_buffer_ptr(p);
+
+	if (*name)
+		trace_seq_printf(p, "disk=%s, ", name);
+	trace_seq_putc(p, 0);
+
+	return ret;
+}
diff --git a/drivers/nvme/host/trace.h b/drivers/nvme/host/trace.h
index 8058f1c9a33e..84d12224ea4f 100644
--- a/drivers/nvme/host/trace.h
+++ b/drivers/nvme/host/trace.h
@@ -91,10 +91,23 @@ const char *nvme_trace_parse_nvm_cmd(struct trace_seq *p, u8 opcode,
 	(qid ? __parse_nvm_cmd(opcode, cdw10) : 		\
 	       __parse_admin_cmd(opcode, cdw10))
 
+#define __assign_disk_name(name, disk)					\
+	do {								\
+		if (disk)						\
+			memcpy(name, disk->disk_name, DISK_NAME_LEN);	\
+		else							\
+			memset(name, 0, DISK_NAME_LEN);			\
+	} while (0)
+
+const char *nvme_trace_disk_name(struct trace_seq *p, char *name);
+#define __print_disk_name(name)				\
+	nvme_trace_disk_name(p, name)
+
 TRACE_EVENT(nvme_setup_cmd,
 	    TP_PROTO(struct request *req, struct nvme_command *cmd),
 	    TP_ARGS(req, cmd),
 	    TP_STRUCT__entry(
+		__array(char, disk, DISK_NAME_LEN)
 		__field(int, ctrl_id)
 		__field(int, qid)
 		__field(u8, opcode)
@@ -112,12 +125,14 @@ TRACE_EVENT(nvme_setup_cmd,
 		__entry->cid = cmd->common.command_id;
 		__entry->nsid = le32_to_cpu(cmd->common.nsid);
 		__entry->metadata = le64_to_cpu(cmd->common.metadata);
+		__assign_disk_name(__entry->disk, req->rq_disk);
 		memcpy(__entry->cdw10, cmd->common.cdw10,
 		       sizeof(__entry->cdw10));
 	    ),
-	    TP_printk("nvme%d: qid=%d, cmdid=%u, nsid=%u, flags=0x%x, meta=0x%llx, cmd=(%s %s)",
-		      __entry->ctrl_id, __entry->qid, __entry->nsid,
-		      __entry->cid, __entry->flags, __entry->metadata,
+	    TP_printk("nvme%d: %sqid=%d, cmdid=%u, nsid=%u, flags=0x%x, meta=0x%llx, cmd=(%s %s)",
+		      __entry->ctrl_id, __print_disk_name(__entry->disk),
+		      __entry->qid, __entry->nsid, __entry->cid,
+		      __entry->flags, __entry->metadata,
 		      show_opcode_name(__entry->qid, __entry->opcode),
 		      parse_nvme_cmd(__entry->qid, __entry->opcode, __entry->cdw10))
 );
@@ -126,6 +141,7 @@ TRACE_EVENT(nvme_complete_rq,
 	    TP_PROTO(struct request *req),
 	    TP_ARGS(req),
 	    TP_STRUCT__entry(
+		__array(char, disk, DISK_NAME_LEN)
 		__field(int, ctrl_id)
 		__field(int, qid)
 		__field(int, cid)
@@ -142,11 +158,12 @@ TRACE_EVENT(nvme_complete_rq,
 		__entry->retries = nvme_req(req)->retries;
 		__entry->flags = nvme_req(req)->flags;
 		__entry->status = nvme_req(req)->status;
+		__assign_disk_name(__entry->disk, req->rq_disk);
 	    ),
-	    TP_printk("nvme%d: qid=%d, cmdid=%u, res=%llu, retries=%u, flags=0x%x, status=%u",
-		      __entry->ctrl_id,  __entry->qid, __entry->cid,
-		      __entry->result, __entry->retries, __entry->flags,
-		      __entry->status)
+	    TP_printk("nvme%d: %sqid=%d, cmdid=%u, res=%llu, retries=%u, flags=0x%x, status=%u",
+		      __entry->ctrl_id, __print_disk_name(__entry->disk),
+		      __entry->qid, __entry->cid, __entry->result,
+		      __entry->retries, __entry->flags, __entry->status)
 
 );
 
-- 
2.14.3

