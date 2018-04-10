Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx494vQQ3g1w+hnaIT3pkS+7DPH+aEaAdrTjwPoZbeAh1M9jr4p9jk2ASwjcPW3SDcr1Gz6Pd
ARC-Seal: i=1; a=rsa-sha256; t=1523399731; cv=none;
        d=google.com; s=arc-20160816;
        b=vxKM7cvIfBroztjwg0PnP0wtowv9kXScXIwDtbl9218EB7BD9NUpQe+MqlzlY+FkNg
         6m+GlZRfOoUjQO0Lr52vZoFvB7GtgJBr97YCf6hG1YFO4W4LMsO9/g0UYnzLZ0kw1r82
         KWJZGbcxUd83xSDc+i8GsiNnrkkagUjI2AqwU2HgiY85AjjlluXGpcJiUq9vI6vEQX5Q
         oRiIYFiJNCHNUtAY19fxnnrhNxN/tPLp/SY+HmguIjU8poNb/MKrS6/3wWH55Mcq1zVK
         H5Qxv3UPpZOZvwzslZ+atwOvfXl4ULOHnBbCruOocph+TqRK85cLOK630VRXevSxJIPX
         nD0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=JKOzUenDmjKYFrFtU7K3//sEP4BJBbhMUFegO6X+BiQ=;
        b=gCJA2wARU34h+nCbaGuQkfpOYao2Eg3NTvRRKiTKEWvxuf2LR5vrzetoD+g53tnxYs
         5UG8u3djFzD/Z4IUyrksGcgQUPY4k2LAhnUsYbnMLzWNwvVW49xC/SZkGYJHYGdCZiwC
         19He6U8gRt/D7obTRKm808Xj68yQE2NbmBShtj1kQSzlbUQSQ/nPmcYjVf2amTYNmq7f
         QiECd+GP5IFpgg/EvTpCztQmIN1alx1OiEKypxR15aqci/kCZBJC50aIBhtHQBS/aNiW
         7nDowWL1VA6wZIicLCLG8+qwVlMRVOSIG1iP97mKCfKjUIIhPRcdpxXSzGbgfHkvWvDd
         y2gQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	James Smart <james.smart@broadcom.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 044/138] nvme_fcloop: fix abort race condition
Date: Wed, 11 Apr 2018 00:23:54 +0200
Message-Id: <20180410212907.231417880@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400002066547044?=
X-GMAIL-MSGID: =?utf-8?q?1597400397574278085?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Smart <jsmart2021@gmail.com>


[ Upstream commit 278e096063f1914fccfc77a617be9fc8dbb31b0e ]

A test case revealed a race condition of an i/o completing on a thread
parallel to the delete_association generating the aborts for the
outstanding ios on the controller.  The i/o completion was freeing the
target fcloop context, thus the abort task referenced the just-freed
memory.

Correct by clearing the target/initiator cross pointers in the io
completion and abort tasks before calling the callbacks. On aborts
that detect already finished io's, ensure the complete context is
called.

Signed-off-by: James Smart <james.smart@broadcom.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nvme/target/fcloop.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -374,6 +374,7 @@ fcloop_tgt_fcprqst_done_work(struct work
 
 	spin_lock(&tfcp_req->reqlock);
 	fcpreq = tfcp_req->fcpreq;
+	tfcp_req->fcpreq = NULL;
 	spin_unlock(&tfcp_req->reqlock);
 
 	if (tport->remoteport && fcpreq) {
@@ -615,11 +616,7 @@ fcloop_fcp_abort(struct nvme_fc_local_po
 
 	if (!tfcp_req)
 		/* abort has already been called */
-		return;
-
-	if (rport->targetport)
-		nvmet_fc_rcv_fcp_abort(rport->targetport,
-					&tfcp_req->tgt_fcp_req);
+		goto finish;
 
 	/* break initiator/target relationship for io */
 	spin_lock(&tfcp_req->reqlock);
@@ -627,6 +624,11 @@ fcloop_fcp_abort(struct nvme_fc_local_po
 	tfcp_req->fcpreq = NULL;
 	spin_unlock(&tfcp_req->reqlock);
 
+	if (rport->targetport)
+		nvmet_fc_rcv_fcp_abort(rport->targetport,
+					&tfcp_req->tgt_fcp_req);
+
+finish:
 	/* post the aborted io completion */
 	fcpreq->status = -ECANCELED;
 	schedule_work(&inireq->iniwork);
