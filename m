Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+ogPNFAPGPI35bERRevhd2/j1dG3NNGlJ5LLslKl3LG4rzSLBYEOVjOhhOLX7zNKZhN/R2
ARC-Seal: i=1; a=rsa-sha256; t=1524405572; cv=none;
        d=google.com; s=arc-20160816;
        b=lZ2nloz7ONobzFN5R7dOsggQnRhQ69CWLOVYRXhMLdJnV8cNguMaLCUmwXvGGNiSKx
         GLFsLk5qNczqaP8MjaZD69O8SPvwnWrQcvb2w/X+jgB4fetloQ4zyehSPKNdlOpLd4Nu
         0tIQM+2dMHN342JhfE5yFKgbdg7qNgFrNCs58jLPIo1Wny/Q1QKEmDYQrEFSg6vyd+A/
         0XszzSfT5RzVnqJN1KvnQEXui36Oh1bnL2OTucIXDuUQeCbNZOEJPUqbveOd24cz5JOO
         j2Pi74wzqLs23bJsxRXTzhk6fiM89j01SIWb2pKR/UStvDKCg+ut1hgbLZGLUvUjEcKd
         BOVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=mAPnNuH3+5SCX3L4yChw/Iu0jQ8+KYI9P4QXmFfyO5s=;
        b=WgUZJChxkn9DY3bcEvej6rPH9Z3DpDJhRwQQJA35tm///Jp7foFWx1XuLlqAqQAXYq
         gyi9xVx9aXcOGnXk3cW53c2yk42E/HlcVz/2NTbDe7PWs0fDziAFm9G82WKifOFBJe8R
         XCFxMqV6IeVvAEJGMT6WPUYq3edks1//MO8ZCkIJI86SWnsn+yKfWHuIxYgHCU3ICIEh
         +hKp1gT7TeMjYzuSKgnbxsDXY5Wx4cg9SuQeXtGPWfB4/wdu8Gm2z6gInl6LcMwFtoTY
         7e2aNWO29jNeSTOtavFeSd9P0ojmiWoZsz6zf2zhOf5pLT2voCz8qCds7tkFDrVK3wi4
         0j3g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Christoph Hellwig <hch@lst.de>,
	Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.16 115/196] IB/srpt: Fix an out-of-bounds stack access in srpt_zerolength_write()
Date: Sun, 22 Apr 2018 15:52:15 +0200
Message-Id: <20180422135110.211098751@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455097373735122?=
X-GMAIL-MSGID: =?utf-8?q?1598455097373735122?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bart Van Assche <bart.vanassche@wdc.com>

commit 2a78cb4db487372152bed2055c038f9634d595e8 upstream.

Avoid triggering an out-of-bounds stack access by changing the type
of 'wr' from ib_send_wr into ib_rdma_wr.

This patch fixes the following KASAN bug report:

BUG: KASAN: stack-out-of-bounds in rxe_post_send+0x7a9/0x9a0 [rdma_rxe]
Read of size 8 at addr ffff880068197a48 by task kworker/2:1/44

Workqueue: ib_cm cm_work_handler [ib_cm]
Call Trace:
 dump_stack+0x8e/0xcd
 print_address_description+0x6f/0x280
 kasan_report+0x25a/0x380
 __asan_load8+0x54/0x90
 rxe_post_send+0x7a9/0x9a0 [rdma_rxe]
 srpt_zerolength_write+0xf0/0x180 [ib_srpt]
 srpt_cm_rtu_recv+0x68/0x110 [ib_srpt]
 srpt_rdma_cm_handler+0xbb/0x15b [ib_srpt]
 cma_ib_handler+0x1aa/0x4a0 [rdma_cm]
 cm_process_work+0x30/0x100 [ib_cm]
 cm_work_handler+0xa86/0x351b [ib_cm]
 process_one_work+0x475/0x9f0
 worker_thread+0x69/0x690
 kthread+0x1ad/0x1d0
 ret_from_fork+0x3a/0x50

Fixes: aaf45bd83eba ("IB/srpt: Detect session shutdown reliably")
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: stable@vger.kernel.org
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/ulp/srpt/ib_srpt.c |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -838,16 +838,19 @@ static int srpt_post_recv(struct srpt_de
  */
 static int srpt_zerolength_write(struct srpt_rdma_ch *ch)
 {
-	struct ib_send_wr wr, *bad_wr;
+	struct ib_send_wr *bad_wr;
+	struct ib_rdma_wr wr = {
+		.wr = {
+			.opcode		= IB_WR_RDMA_WRITE,
+			.wr_cqe		= &ch->zw_cqe,
+			.send_flags	= IB_SEND_SIGNALED,
+		}
+	};
 
 	pr_debug("%s-%d: queued zerolength write\n", ch->sess_name,
 		 ch->qp->qp_num);
 
-	memset(&wr, 0, sizeof(wr));
-	wr.opcode = IB_WR_RDMA_WRITE;
-	wr.wr_cqe = &ch->zw_cqe;
-	wr.send_flags = IB_SEND_SIGNALED;
-	return ib_post_send(ch->qp, &wr, &bad_wr);
+	return ib_post_send(ch->qp, &wr.wr, &bad_wr);
 }
 
 static void srpt_zerolength_write_done(struct ib_cq *cq, struct ib_wc *wc)
