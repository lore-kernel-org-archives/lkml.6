Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B86CC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CF4D20700
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896363;
	bh=/6lcY4rCFCxqnC+xfp99Jtt/kVm5EkHjNYwsVMxCuhk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2odqTR7Vnp/7vr/VMQLsgTfgCdphEsDCB1fI3MI3sbjwhf66nkj6NVbmG5nBATyH5
	 2p2fCt+QHwfjNBH01fQknm1I+RR1a6j3XCKhd60dSuaEFzpTBcW0IjUDQIcJ49RAjx
	 Qiy5PPAsSDIFuk+HmQc/1FAwlS7de+nbIB1APisA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733159AbfBKOqB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:46:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:59078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733150AbfBKOp6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:45:58 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 593C7206BA;
        Mon, 11 Feb 2019 14:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896357;
        bh=/6lcY4rCFCxqnC+xfp99Jtt/kVm5EkHjNYwsVMxCuhk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kxe4v4G+YLVjnKhY4GL/+OAIwRXyb9GAfxe+QDiz8NSzOji17EURuF0FIWj/cucro
         rM2HeoHICETTX5gecPQqqUvXEJSVTdyZVJVp7S6mpbvHTXx2MhwvNUWnkLgKmr/m7Q
         O7Nbn0u+uvie04IAjKHE5P0f4+N3bdgqWO/a8wY4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zhizhou Zhang <zhizhouzhang@asrmicro.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 128/313] tee: optee: avoid possible double list_del()
Date:   Mon, 11 Feb 2019 15:16:48 +0100
Message-Id: <20190211141902.301220227@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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



