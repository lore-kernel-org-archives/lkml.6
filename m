Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2270BuuUrPLMB3dK/mKRVpJ7QGNSpyOVIVy8sz6MGk9IKjmcEbsViWXptjXIdLRsUaBmYgJC
ARC-Seal: i=1; a=rsa-sha256; t=1517591357; cv=none;
        d=google.com; s=arc-20160816;
        b=nuypMQ4eNUuLK2LL/pu6GCS/lQTEbbmfgvBDJK33on3FfjjlsmIKiex7+cmgfy8tlc
         QZd2hCOI2AxQW4pilPofbRWWrB14ztPziI6cVAMF38hhkA4utjk5WtfCI3hexUYc74Zi
         a7M6J7oRQ1gDtkiQUPAoJDPjQx0VjwGIdGVVAEjH93BUSsRym5dI/j0CRwdpoTq5NRpH
         H+QYRIJRs0G1pg5oKmf4Oh1/XCIfOaMH4sLkMFJ4qeFszhm619jDGyPIgmLQhkA4sPv9
         82xcMClpje72we3RkosE4m7BZiJqOHIzC+C6yuKdrN+YrFWLDeKsfedV2tYE/WKiyVHW
         QAVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=FBacvDJBmucTKRaorU/3fgJl5gkB3qhm2bNabkUEFu8=;
        b=xefKJu42PRS2qJWm6L4+I7sLUVwBJNDus7umg6Fs6mKPKhRNQPvE3T+n7j8skeWv1K
         obDQDXvH5U/pG9e3g3+9OKM4SUm3kVa1k7dU4goRMZY2+ttLFDao8e7PKyCYcwcLxhnu
         Apo6zTMBOonHltPpchOKdSO4V7AUMpSz6THBSW8W/htHgsU5AzcSQPPc7xKLD11nj96g
         rn1San7nbh510D6Grt3+WbLfrGzOD82qZy0VYc/0cm3I7if4Y1/1cl/etBIhRW+pV9Eb
         CblBrNi3LrsdwZGO+3n1hAxmWc2XWcICjAGECkw1QMCu/6QuWuYOxaJobvCmedxboZnD
         coWA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	James Smart <james.smart@broadcom.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 051/156] nvmet-fc: correct ref counting error when deferred rcv used
Date: Fri,  2 Feb 2018 17:57:12 +0100
Message-Id: <20180202140842.587695866@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309875327453976?=
X-GMAIL-MSGID: =?utf-8?q?1591309875327453976?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Smart <jsmart2021@gmail.com>


[ Upstream commit 619c62dcc62b957d17cccde2081cad527b020883 ]

Whenever a cmd is received a reference is taken while looking up the
queue. The reference is removed after the cmd is done as the iod is
returned for reuse. The fod may be reused for a deferred (recevied but
no job context) cmd.  Existing code removes the reference only if the
fod is not reused for another command. Given the fod may be used for
one or more ios, although a reference was taken per io, it won't be
matched on the frees.

Remove the reference on every fod free. This pairs the references to
each io.

Signed-off-by: James Smart <james.smart@broadcom.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nvme/target/fc.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -532,15 +532,15 @@ nvmet_fc_free_fcp_iod(struct nvmet_fc_tg
 
 	tgtport->ops->fcp_req_release(&tgtport->fc_target_port, fcpreq);
 
+	/* release the queue lookup reference on the completed IO */
+	nvmet_fc_tgt_q_put(queue);
+
 	spin_lock_irqsave(&queue->qlock, flags);
 	deferfcp = list_first_entry_or_null(&queue->pending_cmd_list,
 				struct nvmet_fc_defer_fcp_req, req_list);
 	if (!deferfcp) {
 		list_add_tail(&fod->fcp_list, &fod->queue->fod_list);
 		spin_unlock_irqrestore(&queue->qlock, flags);
-
-		/* Release reference taken at queue lookup and fod allocation */
-		nvmet_fc_tgt_q_put(queue);
 		return;
 	}
 
@@ -759,6 +759,9 @@ nvmet_fc_delete_target_queue(struct nvme
 		tgtport->ops->fcp_req_release(&tgtport->fc_target_port,
 				deferfcp->fcp_req);
 
+		/* release the queue lookup reference */
+		nvmet_fc_tgt_q_put(queue);
+
 		kfree(deferfcp);
 
 		spin_lock_irqsave(&queue->qlock, flags);
