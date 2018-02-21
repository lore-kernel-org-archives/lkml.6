Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226eoNMDRcYpFzRXi7fsuQMidDU0eZdH5+BLrTGxnRvCxGOzurYIfXMh0/D7t6PM5orhu13+
ARC-Seal: i=1; a=rsa-sha256; t=1519218357; cv=none;
        d=google.com; s=arc-20160816;
        b=rU+hsPQh0yBb/JPKDNMx0o4pdBm9KV2edmIPy6gUiHH5+J9J3UrGTov5X9wmiGSv71
         A3PF+DC9jGxfI/Dm+Xqg2+OLP6auVf0Dqu0Lg6yGC2oq/b+3qPxMOJ9nqhYW68Ccoupy
         GmcZ9Vu+x5sYGEaXmaZbSbFQ5x7MEo4uJ52zd4vPCILz9GiccGa5SbNSjCX5lYwy74ai
         S5sBZnYqqWXFZ7ZKgPkObWBb7obTjDxVAjTJwrRNoX4mi+hulqtjpneMmDTBJ6X+BMsy
         d7L9j3Z2d09EtHbMKhBYQlHC/6yIcbFsZHwYk9QM+kf7FkWz8PHyXz5QJS6dFx49ToCF
         3gHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=euLTwpMQBUKIWRjqjkFVaOmYdSaa3bSMpsrZWOnaGfk=;
        b=OmXMv0D6hD/MaZ/YcD0MD7yGbSaZzM07TTMHqni9P+LUG23OMgIMYU3+PFLOqWZQlF
         6JSfNqNpRuu/Z8aHs65Qa40REbtWba1/RirWipv8ualX+I5qdxkmpRgqxffpA20VBhp/
         65HKCGHlgsrqe/02SANwDOxQJ2tveO+FGa8n8qjnHFK6UJSpyZL+lSiT8rF+VeCbFhLu
         8j8rx7Ls7UT9lNTppf8DFIqFCTpn+kfSyyT/Pxjg8nFlzbAS/4bPWzBEyX62eYVuXqO2
         SzcpV3lkNuY8ZxWHlSVao6Fqs9m45JNszhyVdvlhAgAaJmczWK380gdUpbRoVqDq0bLc
         jEJw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Moni Shoua <monis@mellanox.com>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Doug Ledford <dledford@redhat.com>
Subject: [PATCH 4.15 011/163] RDMA/rxe: Fix a race condition in rxe_requester()
Date: Wed, 21 Feb 2018 13:47:20 +0100
Message-Id: <20180221124530.623695921@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015411073533153?=
X-GMAIL-MSGID: =?utf-8?q?1593015909148009510?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bart Van Assche <bart.vanassche@wdc.com>

commit 65567e41219888feec72fee1de98ccf1efbbc16d upstream.

The rxe driver works as follows:
* The send queue, receive queue and completion queues are implemented as
  circular buffers.
* ib_post_send() and ib_post_recv() calls are serialized through a spinlock.
* Removing elements from various queues happens from tasklet
  context. Tasklets are guaranteed to run on at most one CPU. This serializes
  access to these queues. See also rxe_completer(), rxe_requester() and
  rxe_responder().
* rxe_completer() processes the skbs queued onto qp->resp_pkts.
* rxe_requester() handles the send queue (qp->sq.queue).
* rxe_responder() processes the skbs queued onto qp->req_pkts.

Since rxe_drain_req_pkts() processes qp->req_pkts, calling
rxe_drain_req_pkts() from rxe_requester() is racy. Hence this patch.

Reported-by: Moni Shoua <monis@mellanox.com>
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: stable@vger.kernel.org
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/sw/rxe/rxe_loc.h  |    1 -
 drivers/infiniband/sw/rxe/rxe_req.c  |    9 +--------
 drivers/infiniband/sw/rxe/rxe_resp.c |    2 +-
 3 files changed, 2 insertions(+), 10 deletions(-)

--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -237,7 +237,6 @@ int rxe_srq_from_attr(struct rxe_dev *rx
 
 void rxe_release(struct kref *kref);
 
-void rxe_drain_req_pkts(struct rxe_qp *qp, bool notify);
 int rxe_completer(void *arg);
 int rxe_requester(void *arg);
 int rxe_responder(void *arg);
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -594,15 +594,8 @@ int rxe_requester(void *arg)
 	rxe_add_ref(qp);
 
 next_wqe:
-	if (unlikely(!qp->valid)) {
-		rxe_drain_req_pkts(qp, true);
+	if (unlikely(!qp->valid || qp->req.state == QP_STATE_ERROR))
 		goto exit;
-	}
-
-	if (unlikely(qp->req.state == QP_STATE_ERROR)) {
-		rxe_drain_req_pkts(qp, true);
-		goto exit;
-	}
 
 	if (unlikely(qp->req.state == QP_STATE_RESET)) {
 		qp->req.wqe_index = consumer_index(qp->sq.queue);
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -1210,7 +1210,7 @@ static enum resp_states do_class_d1e_err
 	}
 }
 
-void rxe_drain_req_pkts(struct rxe_qp *qp, bool notify)
+static void rxe_drain_req_pkts(struct rxe_qp *qp, bool notify)
 {
 	struct sk_buff *skb;
 
