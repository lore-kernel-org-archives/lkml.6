Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226XCJjdQeVAW03f9Jq2GK5z1FFKtg6/ZmDoZzhjaHbtnGm+9eGrXp4RQ2sJkLCkKqipHgLk
ARC-Seal: i=1; a=rsa-sha256; t=1517591346; cv=none;
        d=google.com; s=arc-20160816;
        b=h77o0o5ji0oCRHBt5DYkCtU2fz0UGhyPYLpn2mu/XgbEbH0ZnbwrXXF5aDKwuIXakV
         cUvpcznPeYx0rpAF5iQYTjEZ0TcduOkucdAc6n2kXIcLInXUnelOMbHH8hZAKP19+WIS
         giaMBC12XUWm94u4GKJpZvYLQ+KuIO0B54lhJESXpQuuyAUStkjaZn3hiSWZ3ULqcfuz
         HE4YaDyadh7prrJKOw4CYoQA9On2orJfGpGZeR+0BV0gI0k78eozsBM/0RUM+VU7cZQq
         1GnVUu4c6Qna3rZ5/l0uBI5er5dKnkMxVb/cJPnheZDyVXgA2guEpvF3qepXPTTNxxey
         PVnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=o/yMhAJfS28dMdxEpF6BxKvQsyM9vgvUqGmxFw48GGs=;
        b=QF0TNBc8KtKJQI4pxjFZZ9T+OrIWGNKV/dQesGhLdyRlDF7g89iwLlGoMe0ssC0i8i
         18WymUDhbZeY7cKZ9RwVIyPVS/ahxjcF/XYZtQduZYSNQnePMU0vvWzdc2PKk7Gny0IH
         Wwm0D7F4iHRE/9EZ73WkVSR2aAsExZHDOfG/HQ8fU+cCa39ciLI7OpNaj9IKHNZWyp8E
         6VMjxiqwSj+pKuYb2dgwyuL1JblBtJmfpE1beR4UGtZN/HR2+TdF8rDFVSopZx6M5WWR
         sJsms/JPxq+m2FKyY/spAOYUuQl4bjBCUwe4WUu/QhLItwUb0oipR1V81uDISY+ehLED
         Yw/w==
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
Subject: [PATCH 4.14 048/156] nvme-loop: check if queue is ready in queue_rq
Date: Fri,  2 Feb 2018 17:57:09 +0100
Message-Id: <20180202140842.455058767@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309863324650538?=
X-GMAIL-MSGID: =?utf-8?q?1591309863324650538?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sagi Grimberg <sagi@grimberg.me>


[ Upstream commit 9d7fab04b95e8c26014a9bfc1c943b8360b44c17 ]

In case the queue is not LIVE (fully functional and connected at the nvmf
level), we cannot allow any commands other than connect to pass through.

Add a new queue state flag NVME_LOOP_Q_LIVE which is set after nvmf connect
and cleared in queue teardown.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nvme/target/loop.c |   25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -61,10 +61,15 @@ static inline struct nvme_loop_ctrl *to_
 	return container_of(ctrl, struct nvme_loop_ctrl, ctrl);
 }
 
+enum nvme_loop_queue_flags {
+	NVME_LOOP_Q_LIVE	= 0,
+};
+
 struct nvme_loop_queue {
 	struct nvmet_cq		nvme_cq;
 	struct nvmet_sq		nvme_sq;
 	struct nvme_loop_ctrl	*ctrl;
+	unsigned long		flags;
 };
 
 static struct nvmet_port *nvmet_loop_port;
@@ -153,6 +158,14 @@ nvme_loop_timeout(struct request *rq, bo
 	return BLK_EH_HANDLED;
 }
 
+static inline blk_status_t nvme_loop_is_ready(struct nvme_loop_queue *queue,
+		struct request *rq)
+{
+	if (unlikely(!test_bit(NVME_LOOP_Q_LIVE, &queue->flags)))
+		return nvmf_check_init_req(&queue->ctrl->ctrl, rq);
+	return BLK_STS_OK;
+}
+
 static blk_status_t nvme_loop_queue_rq(struct blk_mq_hw_ctx *hctx,
 		const struct blk_mq_queue_data *bd)
 {
@@ -162,6 +175,10 @@ static blk_status_t nvme_loop_queue_rq(s
 	struct nvme_loop_iod *iod = blk_mq_rq_to_pdu(req);
 	blk_status_t ret;
 
+	ret = nvme_loop_is_ready(queue, req);
+	if (unlikely(ret))
+		return ret;
+
 	ret = nvme_setup_cmd(ns, req, &iod->cmd);
 	if (ret)
 		return ret;
@@ -275,6 +292,7 @@ static const struct blk_mq_ops nvme_loop
 
 static void nvme_loop_destroy_admin_queue(struct nvme_loop_ctrl *ctrl)
 {
+	clear_bit(NVME_LOOP_Q_LIVE, &ctrl->queues[0].flags);
 	nvmet_sq_destroy(&ctrl->queues[0].nvme_sq);
 	blk_cleanup_queue(ctrl->ctrl.admin_q);
 	blk_mq_free_tag_set(&ctrl->admin_tag_set);
@@ -305,8 +323,10 @@ static void nvme_loop_destroy_io_queues(
 {
 	int i;
 
-	for (i = 1; i < ctrl->ctrl.queue_count; i++)
+	for (i = 1; i < ctrl->ctrl.queue_count; i++) {
+		clear_bit(NVME_LOOP_Q_LIVE, &ctrl->queues[i].flags);
 		nvmet_sq_destroy(&ctrl->queues[i].nvme_sq);
+	}
 }
 
 static int nvme_loop_init_io_queues(struct nvme_loop_ctrl *ctrl)
@@ -346,6 +366,7 @@ static int nvme_loop_connect_io_queues(s
 		ret = nvmf_connect_io_queue(&ctrl->ctrl, i);
 		if (ret)
 			return ret;
+		set_bit(NVME_LOOP_Q_LIVE, &ctrl->queues[i].flags);
 	}
 
 	return 0;
@@ -387,6 +408,8 @@ static int nvme_loop_configure_admin_que
 	if (error)
 		goto out_cleanup_queue;
 
+	set_bit(NVME_LOOP_Q_LIVE, &ctrl->queues[0].flags);
+
 	error = nvmf_reg_read64(&ctrl->ctrl, NVME_REG_CAP, &ctrl->ctrl.cap);
 	if (error) {
 		dev_err(ctrl->ctrl.device,
