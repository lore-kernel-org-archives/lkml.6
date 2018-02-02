Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2948269-1517591413-2-13220015460043400418
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517591413; b=mf9FzaeBm70PUcwwHDyUUE1Z0a9tXA8aZ6XVQOduQHiWudY
    gW779UueRNIztrM0A/nM8d4j0viWVUc3rTQXrLvQDH/Ni1VEHXDA9BOsvtjAr+Mz
    7Qwj6TTZJHy3z97CHSt8t8r+c4aRhuYcbtL1hoEhw7f0kaWmJMrwVO9RwGZwlQCK
    1KEsT3u7vSC3gK/OMfnF9fGQajCfvVvtrA8m1SKyBdgB5QxZtFl+EHwM5Bptq/bp
    IV+KnLoj66ulpFgGm79j7VDSKCkcDl6iTN1FSfRk74hAToMp31lUp5RCL8OmNW06
    Ydz8R9m9jUHzUWzcye9kmIS6RJzbnIQSh6yG/Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517591413; bh=rfT31DRsrLOQRY3XyBN77dAWWs
    6ODFGifoG9DYjSYFE=; b=XX0o8Xk7QatV0kKA67LqmDZ4u2pn8T8gbfQO9+VsAV
    ZqA39jKU2TkS+5z8ad+ppQQ6IlHUZLgAkYeUj6LblFZCGEAXK8Fdu/8dhc4cRFi1
    HK59T12jUq7l2p6rXdd8FmtEf58Pgz1AJHYPcSQSPRBpRdLlJ1TUN3QEWn1ddXKK
    jEZJTY3fnyXbe25NSTptkBQr0RdwOB5w3OTup7RlqluhR6iPN5MLmo/NSVnRlbDW
    s/1Kp2gfiQQQ/6xuyggU+aGxLG6OrJ4LdVDbGzkqGa3OgLahPvTxwBoxom7d+/m7
    Lqzp+pgBMvMUrJN0cL+BYGYdBeeyFLkZcAY9aleNx2lw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753281AbeBBRKH (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:10:07 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:38086 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752773AbeBBRKC (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:10:02 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
        Max Gurtovoy <maxg@mellanox.com>,
        Christoph Hellwig <hch@lst.de>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 066/156] nvme-rdma: dont complete requests before a send work request has completed
Date: Fri,  2 Feb 2018 17:57:27 +0100
Message-Id: <20180202140843.274307950@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sagi Grimberg <sagi@grimberg.me>


[ Upstream commit 4af7f7ff92a42b6c713293c99e7982bcfcf51a70 ]

In order to guarantee that the HCA will never get an access violation
(either from invalidated rkey or from iommu) when retrying a send
operation we must complete a request only when both send completion and
the nvme cqe has arrived. We need to set the send/recv completions flags
atomically because we might have more than a single context accessing the
request concurrently (one is cq irq-poll context and the other is
user-polling used in IOCB_HIPRI).

Only then we are safe to invalidate the rkey (if needed), unmap the host
buffers, and complete the IO.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nvme/host/rdma.c |   28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -67,6 +67,9 @@ struct nvme_rdma_request {
 	struct nvme_request	req;
 	struct ib_mr		*mr;
 	struct nvme_rdma_qe	sqe;
+	union nvme_result	result;
+	__le16			status;
+	refcount_t		ref;
 	struct ib_sge		sge[1 + NVME_RDMA_MAX_INLINE_SEGMENTS];
 	u32			num_sge;
 	int			nents;
@@ -1177,6 +1180,7 @@ static int nvme_rdma_map_data(struct nvm
 	req->num_sge = 1;
 	req->inline_data = false;
 	req->mr->need_inval = false;
+	refcount_set(&req->ref, 2); /* send and recv completions */
 
 	c->common.flags |= NVME_CMD_SGL_METABUF;
 
@@ -1213,8 +1217,19 @@ static int nvme_rdma_map_data(struct nvm
 
 static void nvme_rdma_send_done(struct ib_cq *cq, struct ib_wc *wc)
 {
-	if (unlikely(wc->status != IB_WC_SUCCESS))
+	struct nvme_rdma_qe *qe =
+		container_of(wc->wr_cqe, struct nvme_rdma_qe, cqe);
+	struct nvme_rdma_request *req =
+		container_of(qe, struct nvme_rdma_request, sqe);
+	struct request *rq = blk_mq_rq_from_pdu(req);
+
+	if (unlikely(wc->status != IB_WC_SUCCESS)) {
 		nvme_rdma_wr_error(cq, wc, "SEND");
+		return;
+	}
+
+	if (refcount_dec_and_test(&req->ref))
+		nvme_end_request(rq, req->status, req->result);
 }
 
 /*
@@ -1359,14 +1374,19 @@ static int nvme_rdma_process_nvme_rsp(st
 	}
 	req = blk_mq_rq_to_pdu(rq);
 
-	if (rq->tag == tag)
-		ret = 1;
+	req->status = cqe->status;
+	req->result = cqe->result;
 
 	if ((wc->wc_flags & IB_WC_WITH_INVALIDATE) &&
 	    wc->ex.invalidate_rkey == req->mr->rkey)
 		req->mr->need_inval = false;
 
-	nvme_end_request(rq, cqe->status, cqe->result);
+	if (refcount_dec_and_test(&req->ref)) {
+		if (rq->tag == tag)
+			ret = 1;
+		nvme_end_request(rq, req->status, req->result);
+	}
+
 	return ret;
 }
 
