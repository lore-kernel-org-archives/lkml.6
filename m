Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225n2td/opaAWvXxbm+rfffr6EC2BWPdAkGnIJFNFDOm1hT1AczXUYHwSszzURBOIJm/8i88
ARC-Seal: i=1; a=rsa-sha256; t=1519217880; cv=none;
        d=google.com; s=arc-20160816;
        b=j0VcPvUYjfNXwrrw4bEeboj/e7uv2WlcNBCDGXOnfwXoeavDu4s7xQvAiWpdIahMTA
         VLHMmY0WrVq2xJ9g0oaVu9+kDgZsuuZejKTqHDV6rC/u50wErU9pYQyNx6cOEx5H6mQw
         dhaY+YRoZdJfxEyBBZaIjN1+D9Uh+iJh7fCEz/HIeENsgiqly4PIe39JAqGtWE3B94u1
         vH9lYyGRRJdS3We2yPugrvD1pNq4VdYu6X5V+0ywTAs/zK6yamDHnTC9TFEGGFFMLJd7
         tVrHJeTKqAgw3+4vmeN1dcxpMzn7ofULOuQgSUlaUsqMxFJPQbow77ePBueGLcyuvzim
         CZeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=GuVvlr9w7oxZ/d619Jg1gzqBgfg2J3sSYuLnsnuoFrY=;
        b=HIXEV1SuCKKGmYPSPRlQ2p0KGjsJrw5YIRHfmwWmDS4XPCCorwdSb2fp5s/uNXm6w4
         ayT7E170sOThpu5kpIeeakxZ8WEgjfycvT+BtiksT+JawmJR+kJxHCmvLZ4abYHOIBBw
         QpllFboef6+SsRKS3GU/bB/z3HNRHwKzPlKd6r6uwhBlOhlCDtby0r6Iw4EoLmQl0Joe
         TV19b6pThW/5lRpSuar3LUkTugMSWD6b8JUkzkPLulFDvnKnFFnPT7/tzoeXTv8ruf7T
         AZo4VT1oSaobUcIQCAzw64UggKcqryxur0YEdCwdsRJbUxvn1WOR4z2QbM7hAz+f0Msy
         PNuw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Moni Shoua <monis@mellanox.com>,
	Doug Ledford <dledford@redhat.com>
Subject: [PATCH 4.14 011/167] RDMA/rxe: Fix a race condition related to the QP error state
Date: Wed, 21 Feb 2018 13:47:02 +0100
Message-Id: <20180221124525.220543030@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015265740362558?=
X-GMAIL-MSGID: =?utf-8?q?1593015408515746576?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bart Van Assche <bart.vanassche@wdc.com>

commit 6f301e06de4cf9ab7303f5acd43e64fcd4aa04be upstream.

The following sequence:
* Change queue pair state into IB_QPS_ERR.
* Post a work request on the queue pair.

Triggers the following race condition in the rdma_rxe driver:
* rxe_qp_error() triggers an asynchronous call of rxe_completer(), the function
  that examines the QP send queue.
* rxe_post_send() posts a work request on the QP send queue.

If rxe_completer() runs prior to rxe_post_send(), it will drain the send
queue and the driver will assume no further action is necessary.
However, once we post the send to the send queue, because the queue is
in error, no send completion will ever happen and the send will get
stuck.  In order to process the send, we need to make sure that
rxe_completer() gets run after a send is posted to a queue pair in an
error state.  This patch ensures that happens.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Moni Shoua <monis@mellanox.com>
Cc: <stable@vger.kernel.org> # v4.8
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/sw/rxe/rxe_verbs.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -813,6 +813,8 @@ static int rxe_post_send_kernel(struct r
 			(queue_count(qp->sq.queue) > 1);
 
 	rxe_run_task(&qp->req.task, must_sched);
+	if (unlikely(qp->req.state == QP_STATE_ERROR))
+		rxe_run_task(&qp->comp.task, 1);
 
 	return err;
 }
