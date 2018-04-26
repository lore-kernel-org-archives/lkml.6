Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753205AbeDZTtd (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 15:49:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:40763 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751615AbeDZTtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 15:49:32 -0400
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Keith Busch <keith.busch@intel.com>
Cc: Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH] nvme: change order of qid and cmdid in completion trace
Date: Thu, 26 Apr 2018 13:49:26 -0600
Message-Id: <20180426194926.18767-1-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Keith reported that command submission and command completion
tracepoints have the order of the cmdid and qid fileds swapped.

While it isn't easily possible to change the command submission
tracepoint, as there is a regression test parsing it in blktests we
can swap the command completion tracepoint to have the fileds aligned.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
Reported-by: Keith Busch <keith.busch@intel.com>
---
 drivers/nvme/host/trace.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/trace.h b/drivers/nvme/host/trace.h
index ea91fccd1bc0..01390f0e1671 100644
--- a/drivers/nvme/host/trace.h
+++ b/drivers/nvme/host/trace.h
@@ -148,8 +148,8 @@ TRACE_EVENT(nvme_complete_rq,
 		    __entry->flags = nvme_req(req)->flags;
 		    __entry->status = nvme_req(req)->status;
 	    ),
-	    TP_printk("cmdid=%u, qid=%d, res=%llu, retries=%u, flags=0x%x, status=%u",
-		      __entry->cid, __entry->qid, __entry->result,
+	    TP_printk("qid=%d, cmdid=%u, res=%llu, retries=%u, flags=0x%x, status=%u",
+		      __entry->qid, __entry->cid, __entry->result,
 		      __entry->retries, __entry->flags, __entry->status)
 
 );
-- 
2.16.3
