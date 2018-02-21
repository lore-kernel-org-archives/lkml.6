Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227mlfeexo1knQtgaOtRE0TcM/WZoNVDMULg3ZjMEfOOm9MyHiDCO3lbYGEBGvvN30dgPvj/
ARC-Seal: i=1; a=rsa-sha256; t=1519218354; cv=none;
        d=google.com; s=arc-20160816;
        b=ME4IGjA3922CocqJ0xUyjylhkETi3+u1tUVqAnFIQyREUGkULgEs7N8lxu7RQsiziL
         eG7Zb4FyO2Zr4m03xUw0nyxP1S6t3o72eemW2jw/dvfH8ZI95ayohnoHqlTpb4i643Y+
         sg2rsIwXYq4XiXBIXkT0tw7GCrDhmvoMfo0qQ0I9aKSEFVhE1hbzVAjhKVm6LyUKmIkG
         DBw6OhSpza/FMtbofQvM5AjdJWxNGjcUvu0Q7GoP/X7hVoz/tyQCH4Kk2sP1P9pZOtx1
         jDXgkwbdSQRCXQ3+uuSWLKyUHRl4pyhi93sLZkzkIdu/ep8mSIVpOhHJmqpwkVpV4pj5
         5oqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=GHypiwLnCgPFOT46eCdHFttLU8IfJYMh0nQz3q5Iohg=;
        b=ImZRloj9AjxiVt4BKERvByh1j4sIBwGrJTU+gGzBrHaUQQ/332NQ68PjVRoFZzLEsO
         g8vPUPr3OtTrddyyN/BI/JWkX3d2EHG+iVD2bpI+BlP/raRvM9mBtKwAv+V4c5jdU3y6
         5235MtrzGI60d331CrVAaqHyzGi30RTbuPAdx/AXL7S8PqutxMrxLcz0xbrGgbzjuk7K
         VeNdPXO660xn0cN+sjb06AtXj/MCb8ueklqUI2/+dS7e04EaKR5Sfn4uYWVTd+XeqKtO
         FxBubZMlNqZRZ9auEPeoagnmCPHOf3QNl12WRbBoYGygGlIw4BBmAo3RlM0ngmxGWZ93
         0/Zw==
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
Subject: [PATCH 4.15 010/163] RDMA/rxe: Fix a race condition related to the QP error state
Date: Wed, 21 Feb 2018 13:47:19 +0100
Message-Id: <20180221124530.563520274@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015265740362558?=
X-GMAIL-MSGID: =?utf-8?q?1593015905749435604?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -814,6 +814,8 @@ static int rxe_post_send_kernel(struct r
 			(queue_count(qp->sq.queue) > 1);
 
 	rxe_run_task(&qp->req.task, must_sched);
+	if (unlikely(qp->req.state == QP_STATE_ERROR))
+		rxe_run_task(&qp->comp.task, 1);
 
 	return err;
 }
