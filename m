Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2BAC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AB3F21841
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547219256;
	bh=wjE9uR5M0TT/QxYDCTsIEVmP99Bv/yDRjEZVbFLmEek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LnRUnlhzT05cKikaZjWwB3GzcK1CXjzakDQsOfi5hQY66SJRZ3UZL2Dhf3NeSEpVg
	 zLMN8GfVpgbHVLQFWx/I3NObJ/cg2S40jM7fyaoXFNaoTvBC9qyXroxuSJsMpDHlXP
	 663kgoiY6um6ZFm7U8F00fKUvJ76vzsl+GzlPzc4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388512AbfAKO2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:28:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:47048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387563AbfAKO2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:28:22 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1ED4621841;
        Fri, 11 Jan 2019 14:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547216901;
        bh=wjE9uR5M0TT/QxYDCTsIEVmP99Bv/yDRjEZVbFLmEek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p8vfXPJUguW5+Xzs2sHGbe3u/JWkB2/e8WJGkoBAZM5eqBrXBV2pANwOTa/Ovi1QD
         Q0lxU9Cw+1r250RKPhlaJDco5ZBT/XxMfoHNX1Cid/3X1SotvgmQLP4XgsdHSJYA9C
         FIsIlZZGTm5bY6/mhw3b8DhlLI4uHbRK3mP3Ejz0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steffen Maier <maier@linux.ibm.com>,
        Jens Remus <jremus@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.9 33/63] scsi: zfcp: fix posting too many status read buffers leading to adapter shutdown
Date:   Fri, 11 Jan 2019 15:14:36 +0100
Message-Id: <20190111131050.837812978@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131046.387528003@linuxfoundation.org>
References: <20190111131046.387528003@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steffen Maier <maier@linux.ibm.com>

commit 60a161b7e5b2a252ff0d4c622266a7d8da1120ce upstream.

Suppose adapter (open) recovery is between opened QDIO queues and before
(the end of) initial posting of status read buffers (SRBs). This time
window can be seconds long due to FSF_PROT_HOST_CONNECTION_INITIALIZING
causing by design looping with exponential increase sleeps in the function
performing exchange config data during recovery
[zfcp_erp_adapter_strat_fsf_xconf()]. Recovery triggered by local link up.

Suppose an event occurs for which the FCP channel would send an unsolicited
notification to zfcp by means of a previously posted SRB.  We saw it with
local cable pull (link down) in multi-initiator zoning with multiple
NPIV-enabled subchannels of the same shared FCP channel.

As soon as zfcp_erp_adapter_strategy_open_fsf() starts posting the initial
status read buffers from within the adapter's ERP thread, the channel does
send an unsolicited notification.

Since v2.6.27 commit d26ab06ede83 ("[SCSI] zfcp: receiving an unsolicted
status can lead to I/O stall"), zfcp_fsf_status_read_handler() schedules
adapter->stat_work to re-fill the just consumed SRB from a work item.

Now the ERP thread and the work item post SRBs in parallel.  Both contexts
call the helper function zfcp_status_read_refill().  The tracking of
missing (to be posted / re-filled) SRBs is not thread-safe due to separate
atomic_read() and atomic_dec(), in order to depend on posting
success. Hence, both contexts can see
atomic_read(&adapter->stat_miss) == 1. One of the two contexts posts
one too many SRB. Zfcp gets QDIO_ERROR_SLSB_STATE on the output queue
(trace tag "qdireq1") leading to zfcp_erp_adapter_shutdown() in
zfcp_qdio_handler_error().

An obvious and seemingly clean fix would be to schedule stat_work from the
ERP thread and wait for it to finish. This would serialize all SRB
re-fills. However, we already have another work item wait on the ERP
thread: adapter->scan_work runs zfcp_fc_scan_ports() which calls
zfcp_fc_eval_gpn_ft(). The latter calls zfcp_erp_wait() to wait for all the
open port recoveries during zfcp auto port scan, but in fact it waits for
any pending recovery including an adapter recovery. This approach leads to
a deadlock.  [see also v3.19 commit 18f87a67e6d6 ("zfcp: auto port scan
resiliency"); v2.6.37 commit d3e1088d6873
("[SCSI] zfcp: No ERP escalation on gpn_ft eval");
v2.6.28 commit fca55b6fb587
("[SCSI] zfcp: fix deadlock between wq triggered port scan and ERP")
fixing v2.6.27 commit c57a39a45a76
("[SCSI] zfcp: wait until adapter is finished with ERP during auto-port");
v2.6.27 commit cc8c282963bd
("[SCSI] zfcp: Automatically attach remote ports")]

Instead make the accounting of missing SRBs atomic for parallel execution
in both the ERP thread and adapter->stat_work.

Signed-off-by: Steffen Maier <maier@linux.ibm.com>
Fixes: d26ab06ede83 ("[SCSI] zfcp: receiving an unsolicted status can lead to I/O stall")
Cc: <stable@vger.kernel.org> #2.6.27+
Reviewed-by: Jens Remus <jremus@linux.ibm.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/s390/scsi/zfcp_aux.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/s390/scsi/zfcp_aux.c
+++ b/drivers/s390/scsi/zfcp_aux.c
@@ -275,16 +275,16 @@ static void zfcp_free_low_mem_buffers(st
  */
 int zfcp_status_read_refill(struct zfcp_adapter *adapter)
 {
-	while (atomic_read(&adapter->stat_miss) > 0)
+	while (atomic_add_unless(&adapter->stat_miss, -1, 0))
 		if (zfcp_fsf_status_read(adapter->qdio)) {
+			atomic_inc(&adapter->stat_miss); /* undo add -1 */
 			if (atomic_read(&adapter->stat_miss) >=
 			    adapter->stat_read_buf_num) {
 				zfcp_erp_adapter_reopen(adapter, 0, "axsref1");
 				return 1;
 			}
 			break;
-		} else
-			atomic_dec(&adapter->stat_miss);
+		}
 	return 0;
 }
 


