Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A1CEC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1508F20880
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548690675;
	bh=bN+mdi3GIbdRSrd/hzdW3MpGARdNVV8CVrPJZ0ZNI0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h5+Xo/2HwFsfGiIxcO4udqRAkSFOA6OtlO0p74dPxYSgjGmMTE7+bMvKz6G29keN1
	 6q2MZ9nd1KfODAfmZdD4/W8BLR9dQ2FQQIcpUAhQMOdEjJTpaCfqgZZ5mwk5ETcxbf
	 Q2iMV8vljXL8HfQ8eGKK41EQUbt6/6zWtaKysaLo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbfA1PvN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:51:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:37806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729041AbfA1PvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:51:08 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DDE52147A;
        Mon, 28 Jan 2019 15:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690667;
        bh=bN+mdi3GIbdRSrd/hzdW3MpGARdNVV8CVrPJZ0ZNI0I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dJ/3HvlZdn846/OF3qMzwGZpH4EGLakYU8quanLSSgmo+1ZwYpLSHBDD1RasSqKxx
         jIKmDBKye9oD0TcQuNY+sxfvH3cxQuzJn5IGdPTLvSO0s3SD57NSGOuaiGx6oATqHL
         V/d+OxZiswW9+fGuN7+IyDSkXbSy3JUszzEdn+G4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zhizhou Zhang <zhizhouzhang@asrmicro.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 160/304] tee: optee: avoid possible double list_del()
Date:   Mon, 28 Jan 2019 10:41:17 -0500
Message-Id: <20190128154341.47195-160-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhizhou Zhang <zhizhouzhang@asrmicro.com>

[ Upstream commit b2d102bd0146d9eb1fa630ca0cd19a15ef2f74c8 ]

This bug occurs when:

- a new request arrives, one thread(let's call it A) is pending in
  optee_supp_req() with req->busy is initial value false.

- tee-supplicant is killed, then optee_supp_release() is called, this
  function calls list_del(&req->link), and set supp->ctx to NULL. And
  it also wake up process A.

- process A continues, it firstly checks supp->ctx which is NULL,
  then checks req->busy which is false, at last run list_del(&req->link).
  This triggers double list_del() and results kernel panic.

For solve this problem, we rename req->busy to req->in_queue, and
associate it with state of whether req is linked to supp->reqs. So we
can just only check req->in_queue to make decision calling list_del()
or not.

Signed-off-by: Zhizhou Zhang <zhizhouzhang@asrmicro.com>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tee/optee/supp.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/tee/optee/supp.c b/drivers/tee/optee/supp.c
index df35fc01fd3e..43626e15703a 100644
--- a/drivers/tee/optee/supp.c
+++ b/drivers/tee/optee/supp.c
@@ -19,7 +19,7 @@
 struct optee_supp_req {
 	struct list_head link;
 
-	bool busy;
+	bool in_queue;
 	u32 func;
 	u32 ret;
 	size_t num_params;
@@ -54,7 +54,6 @@ void optee_supp_release(struct optee_supp *supp)
 
 	/* Abort all request retrieved by supplicant */
 	idr_for_each_entry(&supp->idr, req, id) {
-		req->busy = false;
 		idr_remove(&supp->idr, id);
 		req->ret = TEEC_ERROR_COMMUNICATION;
 		complete(&req->c);
@@ -63,6 +62,7 @@ void optee_supp_release(struct optee_supp *supp)
 	/* Abort all queued requests */
 	list_for_each_entry_safe(req, req_tmp, &supp->reqs, link) {
 		list_del(&req->link);
+		req->in_queue = false;
 		req->ret = TEEC_ERROR_COMMUNICATION;
 		complete(&req->c);
 	}
@@ -103,6 +103,7 @@ u32 optee_supp_thrd_req(struct tee_context *ctx, u32 func, size_t num_params,
 	/* Insert the request in the request list */
 	mutex_lock(&supp->mutex);
 	list_add_tail(&req->link, &supp->reqs);
+	req->in_queue = true;
 	mutex_unlock(&supp->mutex);
 
 	/* Tell an eventual waiter there's a new request */
@@ -130,9 +131,10 @@ u32 optee_supp_thrd_req(struct tee_context *ctx, u32 func, size_t num_params,
 			 * will serve all requests in a timely manner and
 			 * interrupting then wouldn't make sense.
 			 */
-			interruptable = !req->busy;
-			if (!req->busy)
+			if (req->in_queue) {
 				list_del(&req->link);
+				req->in_queue = false;
+			}
 		}
 		mutex_unlock(&supp->mutex);
 
@@ -176,7 +178,7 @@ static struct optee_supp_req  *supp_pop_entry(struct optee_supp *supp,
 		return ERR_PTR(-ENOMEM);
 
 	list_del(&req->link);
-	req->busy = true;
+	req->in_queue = false;
 
 	return req;
 }
@@ -318,7 +320,6 @@ static struct optee_supp_req *supp_pop_req(struct optee_supp *supp,
 	if ((num_params - nm) != req->num_params)
 		return ERR_PTR(-EINVAL);
 
-	req->busy = false;
 	idr_remove(&supp->idr, id);
 	supp->req_id = -1;
 	*num_meta = nm;
-- 
2.19.1

