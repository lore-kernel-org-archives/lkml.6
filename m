Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2790034-1518098598-2-1589023058655950077
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, UNPARSEABLE_RELAY 0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518098597; b=rxpZhA3tFqnH2D0AJVkTo/05oZN+SVoJB3x1NBkjik++GZ+
    g+fe/X1XFIk1/ax0dleHmBB8txhoHi2OgjoXe4WbApoBdSPrepywRM/sLHbx4Z/n
    ufxaqpfXSJ14G8pcSjqwG9gRDm5useMSjiMk1DcWiI9GEG+2ye/Tcpt6Lz825LT+
    EzCK+OLxjhLb9RuCYh1t6PWb+qa+TZeIUWHvAcccfVE/7pKAzfVSDpxR4/qOVO4V
    F4tXALFcbql8NS4h2DMoW1eVtt84uiutrunUEuw01FJ9bMkfdp559FtLZUKSGbfo
    Xgt4cKvShCtanBJwB27gEgrJEO6Mr5h4iC4qG7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1518098597; bh=11zyEQa8XYisCH+fvhpLoOJyKo
    ZQaQBkOOugY+KNqsU=; b=FUOrl+oQ0J3HvZIoFhuEbURY6I+FlhanzYOj+w1Em0
    YgwrZxShzqExWOvhy3GH4GeW/ypwJYsLT6Nq8Z/BV1PReW+h0bpAx3em0JWrpbsM
    d+9SOoiYAv5wwMkZJGtyC2i2uXtlEzwLOaWldt3xDKshENv6ei+oXFZdyQpsdt52
    LrBQosPhfDODpF0u9S7q8IaQHVRG+UQyJBlIn4jf+WFOuzSMMtJB3RU6IyF90YnW
    G0k+QXCJe8KqzjiehOMpRwiOu0bK5E5JJe0kHNT7kLYnBxA5aDE3f/W5JnB00Xwn
    bUAA5B8un/l12x/HoYnd8t3K5KcCm8V48/Q482NvXizg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=jMn9akUn x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=jMn9akUn x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751153AbeBHODO (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Feb 2018 09:03:14 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:53576 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750961AbeBHODN (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 8 Feb 2018 09:03:13 -0500
From: Joao Martins <joao.m.martins@oracle.com>
To: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc: Joao Martins <joao.m.martins@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, stable@vger.kernel.org
Subject: [PATCH v3] xenbus: track caller request id
Date: Thu,  8 Feb 2018 14:02:56 +0000
Message-Id: <20180208140256.9647-1-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8798 signatures=668663
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802080164
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit fd8aa9095a95 ("xen: optimize xenbus driver for multiple concurrent
xenstore accesses") optimized xenbus concurrent accesses but in doing so
broke UABI of /dev/xen/xenbus. Through /dev/xen/xenbus applications are in
charge of xenbus message exchange with the correct header and body. Now,
after the mentioned commit the replies received by application will no
longer have the header req_id echoed back as it was on request (see
specification below for reference), because that particular field is being
overwritten by kernel.

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
back the original req_id.

Cc: <stable@vger.kernel.org> # 4.11
Fixes: fd8aa9095a ("xen: optimize xenbus driver for multiple concurrent xenstore accesses")
Reported-by: Bhavesh Davda <bhavesh.davda@oracle.com>
Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
---
Here's a link to a unit test (https://pastebin.com/N0kqNBnM) where req_id of
reply and response are being asserted each request. Without this patch
the assert will fail (e.g. try it with `./xswire_reqid_test name`). But
on <= v4.10 or >= v4.11 with the fix above, it will print domain name 10
times.

Changes since v2:
 * Add Juergen's Reviewed-by

Changes since v1:
 * Adjust commit message
 (Comments from Juergen on IRC)
 * Unilateraly save/restore req_id and remove xs_request_is_user()
 * Initialize req_id for kernel callers
---
 drivers/xen/xenbus/xenbus.h       | 1 +
 drivers/xen/xenbus/xenbus_comms.c | 1 +
 drivers/xen/xenbus/xenbus_xs.c    | 3 +++
 3 files changed, 5 insertions(+)

diff --git a/drivers/xen/xenbus/xenbus.h b/drivers/xen/xenbus/xenbus.h
index 149c5e7efc89..092981171df1 100644
--- a/drivers/xen/xenbus/xenbus.h
+++ b/drivers/xen/xenbus/xenbus.h
@@ -76,6 +76,7 @@ struct xb_req_data {
 	struct list_head list;
 	wait_queue_head_t wq;
 	struct xsd_sockmsg msg;
+	uint32_t caller_req_id;
 	enum xsd_sockmsg_type type;
 	char *body;
 	const struct kvec *vec;
diff --git a/drivers/xen/xenbus/xenbus_comms.c b/drivers/xen/xenbus/xenbus_comms.c
index 5b081a01779d..d239fc3c5e3d 100644
--- a/drivers/xen/xenbus/xenbus_comms.c
+++ b/drivers/xen/xenbus/xenbus_comms.c
@@ -309,6 +309,7 @@ static int process_msg(void)
 			goto out;
 
 		if (req->state == xb_req_state_wait_reply) {
+			req->msg.req_id = req->caller_req_id;
 			req->msg.type = state.msg.type;
 			req->msg.len = state.msg.len;
 			req->body = state.body;
diff --git a/drivers/xen/xenbus/xenbus_xs.c b/drivers/xen/xenbus/xenbus_xs.c
index 3e59590c7254..3f3b29398ab8 100644
--- a/drivers/xen/xenbus/xenbus_xs.c
+++ b/drivers/xen/xenbus/xenbus_xs.c
@@ -227,6 +227,8 @@ static void xs_send(struct xb_req_data *req, struct xsd_sockmsg *msg)
 	req->state = xb_req_state_queued;
 	init_waitqueue_head(&req->wq);
 
+	/* Save the caller req_id and restore it later in the reply */
+	req->caller_req_id = req->msg.req_id;
 	req->msg.req_id = xs_request_enter(req);
 
 	mutex_lock(&xb_write_mutex);
@@ -310,6 +312,7 @@ static void *xs_talkv(struct xenbus_transaction t,
 	req->num_vecs = num_vecs;
 	req->cb = xs_wake_up;
 
+	msg.req_id = 0;
 	msg.tx_id = t.id;
 	msg.type = type;
 	msg.len = 0;
-- 
2.11.0
