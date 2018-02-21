Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227eR2Uqeo0puIQRb0MgjT+xw3KorCP3P+Rcf8y0zFWzmadVpqgo5e/Svzrb0d6y7UPXWHWf
ARC-Seal: i=1; a=rsa-sha256; t=1519218677; cv=none;
        d=google.com; s=arc-20160816;
        b=Jskm+9yhsCO+PIeESN4li3/b8IlWg5bW6ST4cJ27R6Y2d20IMBIV3yY2fRlPOfWFA3
         ANrmVdQvvxuatcrRyxDzlQmiWdG4/QUlPpZPHkVj/SvRdlzRWPCIBcG74bQ4bBY1XCWE
         Qe6cm3YgQP/ew7qC1yHB1jUQ09cKbQdrixg2uaqbmNDsK4NrW/kSBg4PYz0Aq554jYAq
         wxMxyLzaGsm+5Vf0TIANisaOP/TIAPT294p7T6FjwxhiUCzserSFyBF9lx8fqQatsQHq
         ffcpcN5MQeMPbVs6x7bAkaapg3LEnnE8n9hyyspBXNiqk4A94oHfCIRIE9GnS1/S+xVk
         7KTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=qamg/zfZjwgwUjZyV5GJR3CRq4QX2xIBROYqFA4F7N0=;
        b=gamsxPP07xuYLUehJHaJxeQ5rre5iLpebgkA/d0oNTRa6ZUWuonSR2D2GdfGPNimxo
         HXAak0MtcOptEq6S2IDSgOrSis4CTXtuhR8WNg1dtnF81esiMt86/ZN6oGa19GyM2tIC
         Vzsg+VpHlQZqwFt73HUD3mf0wkXTuK9WlbQHw5ojtu0dJ6ODgHWS85nNYW0c3k87JFTV
         VtJQRJ9WHe+6V8YivcCvt43oPRfgv3A2FXsneKw2tH3XKaFX23pGBfofkz08qZ5x1DwO
         SxsM5SKXOKk+22sTcw3VhDbtISiUzfZmGSgWWzb5HVgsCfBoDP9Eow3PJNkFn49yNVsW
         ToYA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Bhavesh Davda <bhavesh.davda@oracle.com>,
	Joao Martins <joao.m.martins@oracle.com>,
	Juergen Gross <jgross@suse.com>
Subject: [PATCH 4.15 123/163] xenbus: track caller request id
Date: Wed, 21 Feb 2018 13:49:12 +0100
Message-Id: <20180221124536.906856947@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015734784139984?=
X-GMAIL-MSGID: =?utf-8?q?1593016243971771738?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Joao Martins <joao.m.martins@oracle.com>

commit 29fee6eed2811ff1089b30fc579a2d19d78016ab upstream.

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
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/xen/xenbus/xenbus.h       |    1 +
 drivers/xen/xenbus/xenbus_comms.c |    1 +
 drivers/xen/xenbus/xenbus_xs.c    |    3 +++
 3 files changed, 5 insertions(+)

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
--- a/drivers/xen/xenbus/xenbus_comms.c
+++ b/drivers/xen/xenbus/xenbus_comms.c
@@ -309,6 +309,7 @@ static int process_msg(void)
 			goto out;
 
 		if (req->state == xb_req_state_wait_reply) {
+			req->msg.req_id = req->caller_req_id;
 			req->msg.type = state.msg.type;
 			req->msg.len = state.msg.len;
 			req->body = state.body;
--- a/drivers/xen/xenbus/xenbus_xs.c
+++ b/drivers/xen/xenbus/xenbus_xs.c
@@ -227,6 +227,8 @@ static void xs_send(struct xb_req_data *
 	req->state = xb_req_state_queued;
 	init_waitqueue_head(&req->wq);
 
+	/* Save the caller req_id and restore it later in the reply */
+	req->caller_req_id = req->msg.req_id;
 	req->msg.req_id = xs_request_enter(req);
 
 	mutex_lock(&xb_write_mutex);
@@ -310,6 +312,7 @@ static void *xs_talkv(struct xenbus_tran
 	req->num_vecs = num_vecs;
 	req->cb = xs_wake_up;
 
+	msg.req_id = 0;
 	msg.tx_id = t.id;
 	msg.type = type;
 	msg.len = 0;
