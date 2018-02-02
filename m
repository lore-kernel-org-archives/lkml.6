Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225+o8WTbbyUfqXKvio6Z7Cnn2J1o1lHsWyZ0hPugQENTU4zW5uUXmJbSVuL9xUTk9+Q/oNV
ARC-Seal: i=1; a=rsa-sha256; t=1517591343; cv=none;
        d=google.com; s=arc-20160816;
        b=dHJMzAZ6cFDZqmq3nMpIa1eIceNlpnyLs+uVeNaPDUKJax3jxYOE5jAlFIUlH7dSFK
         CujIBuJsM8Z3vr4ONy7qTZ9lHKGIS/HRmnyfrsC7bARonfIRgu7xsS7V0tx/GXDMtkay
         6B+HOuUpHWL6obYKibFURKEOrY1IuJLdMscUOifea79lln9M0U11EEZVpCkmpzYRI/j3
         IZ4GLf7vHOC9FxrIsmoYz2+YaPZvFIV7vhEqVNbxKATjIYmaW6oxN2PoNAPRDqQxLI9g
         SJy/WrXf2Pop1F60tke5cMVt5lAwAJGosFPu0nZuBEJgeah1w6YpX/Slk1Fg/S42pk9A
         ghCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=RFoo1pW/eOz9oI5U6AjzWMbmhJ0x+mlncc9HLMf7Duw=;
        b=gSNs6KOOFXNUYYpddzyTjkj/CD8Wixrw86QAvNWT/f+3gfjdXRC0SvNcAqxDIkyzVS
         EwtMM5rb1A8e4bqYplZrrh7fK4e5fIycm+ECxXYKqRHbkRRdJwJN/QXKmhSM2nBY1021
         3Qn9kwUGnT5M2Sk8QoCVpttMPEHTYw5yU7AxtZdiS4PjMwkTRvxwR8hVgTovCmn9Tqbr
         I4sC2tw2wtYf/OD0UhuQg7tGd1j0kVMNMmX/R2hLBkqRpOdQUMLqcOJa/bByK9MJoukw
         jmRPAxTv0RbzqwqDZ0rrh0KbU4Qgo9g1iqI1w67FoPMcL8luPiNMhr9H9nlxnQ3GlO4Y
         iXEw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 047/156] nvme-fc: check if queue is ready in queue_rq
Date: Fri,  2 Feb 2018 17:57:08 +0100
Message-Id: <20180202140842.408782073@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309860688652888?=
X-GMAIL-MSGID: =?utf-8?q?1591309860688652888?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sagi Grimberg <sagi@grimberg.me>


[ Upstream commit 9e0ed16ab9a9aaf670b81c9cd05b5e50defed654 ]

In case the queue is not LIVE (fully functional and connected at the nvmf
level), we cannot allow any commands other than connect to pass through.

Add a new queue state flag NVME_FC_Q_LIVE which is set after nvmf connect
and cleared in queue teardown.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: James Smart <james.smart@broadcom.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nvme/host/fc.c |   19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -41,6 +41,7 @@
 
 enum nvme_fc_queue_flags {
 	NVME_FC_Q_CONNECTED = (1 << 0),
+	NVME_FC_Q_LIVE = (1 << 1),
 };
 
 #define NVMEFC_QUEUE_DELAY	3		/* ms units */
@@ -1654,6 +1655,7 @@ nvme_fc_free_queue(struct nvme_fc_queue
 	if (!test_and_clear_bit(NVME_FC_Q_CONNECTED, &queue->flags))
 		return;
 
+	clear_bit(NVME_FC_Q_LIVE, &queue->flags);
 	/*
 	 * Current implementation never disconnects a single queue.
 	 * It always terminates a whole association. So there is never
@@ -1661,7 +1663,6 @@ nvme_fc_free_queue(struct nvme_fc_queue
 	 */
 
 	queue->connection_id = 0;
-	clear_bit(NVME_FC_Q_CONNECTED, &queue->flags);
 }
 
 static void
@@ -1740,6 +1741,8 @@ nvme_fc_connect_io_queues(struct nvme_fc
 		ret = nvmf_connect_io_queue(&ctrl->ctrl, i);
 		if (ret)
 			break;
+
+		set_bit(NVME_FC_Q_LIVE, &ctrl->queues[i].flags);
 	}
 
 	return ret;
@@ -2048,6 +2051,14 @@ busy:
 	return BLK_STS_RESOURCE;
 }
 
+static inline blk_status_t nvme_fc_is_ready(struct nvme_fc_queue *queue,
+		struct request *rq)
+{
+	if (unlikely(!test_bit(NVME_FC_Q_LIVE, &queue->flags)))
+		return nvmf_check_init_req(&queue->ctrl->ctrl, rq);
+	return BLK_STS_OK;
+}
+
 static blk_status_t
 nvme_fc_queue_rq(struct blk_mq_hw_ctx *hctx,
 			const struct blk_mq_queue_data *bd)
@@ -2063,6 +2074,10 @@ nvme_fc_queue_rq(struct blk_mq_hw_ctx *h
 	u32 data_len;
 	blk_status_t ret;
 
+	ret = nvme_fc_is_ready(queue, rq);
+	if (unlikely(ret))
+		return ret;
+
 	ret = nvme_setup_cmd(ns, rq, sqe);
 	if (ret)
 		return ret;
@@ -2398,6 +2413,8 @@ nvme_fc_create_association(struct nvme_f
 	if (ret)
 		goto out_disconnect_admin_queue;
 
+	set_bit(NVME_FC_Q_LIVE, &ctrl->queues[0].flags);
+
 	/*
 	 * Check controller capabilities
 	 *
