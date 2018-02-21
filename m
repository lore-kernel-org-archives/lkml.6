Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227pQHmcH7lrYS2c7m1TW96JJNcOoICaQcPVIkYRfI5fG9cWOsWbl8x1YUlZGspdDatweREP
ARC-Seal: i=1; a=rsa-sha256; t=1519217744; cv=none;
        d=google.com; s=arc-20160816;
        b=MCJPLci7NXFyvDsNUqyKUP2aeStqZKrhXHC5fwpzX6a9o0YG1FZjni0Z12lTIhZpsn
         JRDAS8O/QKVP2zA9N+Y9jydqCtAgwdrNKXFNgA6Qp35NF5hymi33NO9a+IDkGMheW/mM
         flOqNmymxThI1G50sEWjgMUInI+CGH8tc4VSUpIw30nWNT2+gHjncX04prU1cHUkzijy
         H6CLE0v82kvbsShWgWUxkD5/Z9bvRFSRsXZ8h8fOTi4Mpe7tErA6I/1x7vc1ciugdW+e
         3rT0BlikC0ARUrFEfzTbawBfr0WV8QkuJI3xecc/m4buhZ3obfidKrcUms4jnjtVP84/
         J6sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=wj1Vy4FBQahwvnhyqEn5pBg4WyLq8uaXNJFzK5NWjj4=;
        b=alPdiTBTVg63qHaRmH/xyRhKgV9BwrAead4aj4AbisFYP/9U6BLrJ9D9+seqAFL1UO
         5mjkbMCoXwnQ7SGFdcucBgHy4vGg+tSA2NcuBHzlbDqxHdKeyVc5w8slXjXmq7eUpa5J
         FC2GMhf56aLUfUeoyQOSr+oceCGVlvrvs682HRETbPYJNl1Go48kIdojRCeaDN8dFA5g
         QaxsnS2+xwoFZjRkt8q9m1fMiF7idp7bL8NzFTVhceBqYiy8LvKaWt8yEawsmNo+Aa8g
         fDnERtGGbH25bVbbcBTjbmE4w7kfi04VOp9pbaEHNQKAtFfwOJ/xjabioCpfzKKAorCj
         iwug==
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
Subject: [PATCH 4.9 38/77] RDMA/rxe: Fix a race condition related to the QP error state
Date: Wed, 21 Feb 2018 13:48:47 +0100
Message-Id: <20180221124433.780975956@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124432.172390020@linuxfoundation.org>
References: <20180221124432.172390020@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015265740362558?=
X-GMAIL-MSGID: =?utf-8?q?1593015265740362558?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -848,6 +848,8 @@ static int rxe_post_send_kernel(struct r
 			(queue_count(qp->sq.queue) > 1);
 
 	rxe_run_task(&qp->req.task, must_sched);
+	if (unlikely(qp->req.state == QP_STATE_ERROR))
+		rxe_run_task(&qp->comp.task, 1);
 
 	return err;
 }
