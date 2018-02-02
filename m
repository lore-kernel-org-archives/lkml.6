Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225+E+YHeRtAyOwuGed3zHCoS2Pqz35XsTFxJNQne0uqnJQe0toiC206LbnRF90InW/cGQEc
ARC-Seal: i=1; a=rsa-sha256; t=1517591340; cv=none;
        d=google.com; s=arc-20160816;
        b=rooSIBMbyiVCVdnvRLk2hOrUVhsNlgzUioVwCkjN/4d50HEdMaOYA5ZgyblE5UKvON
         opPUC6FPSLhkFD/g3gAGXrzgtbm1qgCseXXMbzLTuDlG9eAqonUqngPGfVbxszzTggHc
         We9yzyuqicAD0B95IRoadvrzNVLyjE1zwTwx7gxs+1tLv27mFaWJzDnyzGYM1BFMBanJ
         sttY1gXfgHGYLNsZp4Sao3abm4o4OrW6piYVwt9ydEBrCZ41EunkOVp2mnG9kbi+eP3Z
         DapkQcEPLIc6r9ONMwozkbZuqi8Gp1wI7JHLqqcksf0VF0Ao49lTJ/pLhPzU5KvxgREM
         D/xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=TpS6mtTKZFk7vcmP4mBfigAk2vsvS4UUp4ctNHNMMbQ=;
        b=nnX8ami33epyyPGw0VP9kSdsmsnyTmS5VYVBs0a0aSRzdLgdoz7Z2Zvb/314Oijwl2
         70vCtS4hBYdpfPcAoxhk6KK594oT//0iviA5kHvyoA65LkMAzFJNH88G2ns2WzQtRxtN
         iZ0zO6vFDgEwxjpuFAKc4oi8IZVuK7k33jJiL3Y4UKUXJGTQmJy4JJRGMV+lAdkrtdF8
         TqJosrAUX+lTM4ku1TqnR5pNogFzv8CT9CPrmj1NLBbhibitRpX6dHm5ac6e3ImCw9of
         9BoiE1kanf4trNUH51YOF30d1i9UDu8OAw7LbtoDQ938my77iH6y3Kz6gmXdmU1rM5m8
         bWOA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 046/156] nvme-fabrics: introduce init command check for a queue that is not alive
Date: Fri,  2 Feb 2018 17:57:07 +0100
Message-Id: <20180202140842.363281541@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309857367943191?=
X-GMAIL-MSGID: =?utf-8?q?1591309857367943191?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sagi Grimberg <sagi@grimberg.me>


[ Upstream commit 48832f8d58cfedb2f9bee11bbfbb657efb42e7e7 ]

When the fabrics queue is not alive and fully functional, no commands
should be allowed to pass but connect (which moves the queue to a fully
functional state). Any other command should be failed, with either
temporary status BLK_STS_RESOUCE or permanent status BLK_STS_IOERR.

This is shared across all fabrics, hence move the check to fabrics
library.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nvme/host/fabrics.h |   30 ++++++++++++++++++++++++++++++
 drivers/nvme/host/rdma.c    |   30 +++++-------------------------
 2 files changed, 35 insertions(+), 25 deletions(-)

--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -142,4 +142,34 @@ void nvmf_free_options(struct nvmf_ctrl_
 int nvmf_get_address(struct nvme_ctrl *ctrl, char *buf, int size);
 bool nvmf_should_reconnect(struct nvme_ctrl *ctrl);
 
+static inline blk_status_t nvmf_check_init_req(struct nvme_ctrl *ctrl,
+		struct request *rq)
+{
+	struct nvme_command *cmd = nvme_req(rq)->cmd;
+
+	/*
+	 * We cannot accept any other command until the connect command has
+	 * completed, so only allow connect to pass.
+	 */
+	if (!blk_rq_is_passthrough(rq) ||
+	    cmd->common.opcode != nvme_fabrics_command ||
+	    cmd->fabrics.fctype != nvme_fabrics_type_connect) {
+		/*
+		 * Reconnecting state means transport disruption, which can take
+		 * a long time and even might fail permanently, fail fast to
+		 * give upper layers a chance to failover.
+		 * Deleting state means that the ctrl will never accept commands
+		 * again, fail it permanently.
+		 */
+		if (ctrl->state == NVME_CTRL_RECONNECTING ||
+		    ctrl->state == NVME_CTRL_DELETING) {
+			nvme_req(rq)->status = NVME_SC_ABORT_REQ;
+			return BLK_STS_IOERR;
+		}
+		return BLK_STS_RESOURCE; /* try again later */
+	}
+
+	return BLK_STS_OK;
+}
+
 #endif /* _NVME_FABRICS_H */
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1603,31 +1603,11 @@ nvme_rdma_timeout(struct request *rq, bo
  * We cannot accept any other command until the Connect command has completed.
  */
 static inline blk_status_t
-nvme_rdma_queue_is_ready(struct nvme_rdma_queue *queue, struct request *rq)
+nvme_rdma_is_ready(struct nvme_rdma_queue *queue, struct request *rq)
 {
-	if (unlikely(!test_bit(NVME_RDMA_Q_LIVE, &queue->flags))) {
-		struct nvme_command *cmd = nvme_req(rq)->cmd;
-
-		if (!blk_rq_is_passthrough(rq) ||
-		    cmd->common.opcode != nvme_fabrics_command ||
-		    cmd->fabrics.fctype != nvme_fabrics_type_connect) {
-			/*
-			 * reconnecting state means transport disruption, which
-			 * can take a long time and even might fail permanently,
-			 * fail fast to give upper layers a chance to failover.
-			 * deleting state means that the ctrl will never accept
-			 * commands again, fail it permanently.
-			 */
-			if (queue->ctrl->ctrl.state == NVME_CTRL_RECONNECTING ||
-			    queue->ctrl->ctrl.state == NVME_CTRL_DELETING) {
-				nvme_req(rq)->status = NVME_SC_ABORT_REQ;
-				return BLK_STS_IOERR;
-			}
-			return BLK_STS_RESOURCE; /* try again later */
-		}
-	}
-
-	return 0;
+	if (unlikely(!test_bit(NVME_RDMA_Q_LIVE, &queue->flags)))
+		return nvmf_check_init_req(&queue->ctrl->ctrl, rq);
+	return BLK_STS_OK;
 }
 
 static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
@@ -1646,7 +1626,7 @@ static blk_status_t nvme_rdma_queue_rq(s
 
 	WARN_ON_ONCE(rq->tag < 0);
 
-	ret = nvme_rdma_queue_is_ready(queue, rq);
+	ret = nvme_rdma_is_ready(queue, rq);
 	if (unlikely(ret))
 		return ret;
 
