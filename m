Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752101AbeBAKhp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 05:37:45 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:35376 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751520AbeBAKhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 05:37:40 -0500
From: Joao Martins <joao.m.martins@oracle.com>
To: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc: Joao Martins <joao.m.martins@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>
Subject: [PATCH] xenbus: track user request id
Date: Thu,  1 Feb 2018 10:37:21 +0000
Message-Id: <20180201103721.5432-1-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8791 signatures=668659
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802010140
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit fd8aa9095a95 ("xen: optimize xenbus driver for multiple concurrent
xenstore accesses") optimized xenbus concurrent accesses but in doing so
may have broke UABI of /dev/xen/xenbus. Through /dev/xen/xenbus
applications are in charge of exchange xenbus message exchange with the
correct header and body. Now, after the mentioned commit the replies
received by application will no longer have the header req_id echoed back
as it was on request (see specification below for reference), because that
particular field is being overwritten by kernel.

struct xsd_sockmsg
{
 uint32_t type;  /* XS_??? */
 uint32_t req_id;/* Request identifier, echoed in daemon's response.  */
 uint32_t tx_id; /* Transaction id (0 if not related to a transaction). */
 uint32_t len;   /* Length of data following this. */

 /* Generally followed by nul-terminated string(s). */
};

Before there was only one request at a time so req_id could simply be
forwarded back and forth. To allow simultaneous requests we need a
different req_id for each message thus kernel keeps a monotonic increasing
counter for this field and is written on every request irrespective of
userspace value.

Forwarding again the req_id on userspace requests is not a solution because
we would open the possibility of userspace-generated req_id colliding with
kernel ones. So this patch instead takes another route which is to
artificially keep user req_id while keeping the xenbus logic as is. We do
that by saving the original req_id before xs_send(), use the private kernel
counter as req_id and then once reply comes and was validated, we restore
back the original req_id. Note however that we only do this when requests
come from userspace.

Fixes: fd8aa9095a ("xen: optimize xenbus driver for multiple concurrent xenstore accesses")
Reported-by: Bhavesh Davda <bhavesh.davda@oracle.com>
Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
Sending out for some feedback first, more to double check whether this indeed
constitutes a problem. If it does I'll need to include a 
"Cc: <stable@vger.kernel.org> # 4.11" on the next iteration.

Here's also a link to a test (https://pastebin.com/2q51j2sR) where req_id
of reply and response are asserted. Without this patch the assert will
fail (e.g. try it with `./xswire_reqid_test name`). But on <= v4.10 or v4.11+
with the fix above, it will print domain name 10 times.

Thanks!
---
 drivers/xen/xenbus/xenbus.h       | 3 +++
 drivers/xen/xenbus/xenbus_comms.c | 2 ++
 drivers/xen/xenbus/xenbus_xs.c    | 6 ++++++
 3 files changed, 11 insertions(+)

diff --git a/drivers/xen/xenbus/xenbus.h b/drivers/xen/xenbus/xenbus.h
index 149c5e7efc89..d0954896214e 100644
--- a/drivers/xen/xenbus/xenbus.h
+++ b/drivers/xen/xenbus/xenbus.h
@@ -76,6 +76,7 @@ struct xb_req_data {
 	struct list_head list;
 	wait_queue_head_t wq;
 	struct xsd_sockmsg msg;
+	uint32_t user_req_id;
 	enum xsd_sockmsg_type type;
 	char *body;
 	const struct kvec *vec;
@@ -132,4 +133,6 @@ void xenbus_ring_ops_init(void);
 int xenbus_dev_request_and_reply(struct xsd_sockmsg *msg, void *par);
 void xenbus_dev_queue_reply(struct xb_req_data *req);
 
+#define xs_request_is_user(_r) ((_r)->cb == xenbus_dev_queue_reply)
+
 #endif
diff --git a/drivers/xen/xenbus/xenbus_comms.c b/drivers/xen/xenbus/xenbus_comms.c
index 5b081a01779d..b08fe7d00372 100644
--- a/drivers/xen/xenbus/xenbus_comms.c
+++ b/drivers/xen/xenbus/xenbus_comms.c
@@ -309,6 +309,8 @@ static int process_msg(void)
 			goto out;
 
 		if (req->state == xb_req_state_wait_reply) {
+			if (xs_request_is_user(req))
+				req->msg.req_id = req->user_req_id;
 			req->msg.type = state.msg.type;
 			req->msg.len = state.msg.len;
 			req->body = state.body;
diff --git a/drivers/xen/xenbus/xenbus_xs.c b/drivers/xen/xenbus/xenbus_xs.c
index 3e59590c7254..a908d706be7f 100644
--- a/drivers/xen/xenbus/xenbus_xs.c
+++ b/drivers/xen/xenbus/xenbus_xs.c
@@ -227,6 +227,12 @@ static void xs_send(struct xb_req_data *req, struct xsd_sockmsg *msg)
 	req->state = xb_req_state_queued;
 	init_waitqueue_head(&req->wq);
 
+	/*
+	 * Request comes from userspace so save the original req_id
+	 * and restore it later in the reply.
+	 */
+	if (xs_request_is_user(req))
+		req->user_req_id = req->msg.req_id;
 	req->msg.req_id = xs_request_enter(req);
 
 	mutex_lock(&xb_write_mutex);
-- 
2.11.0
