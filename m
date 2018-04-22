Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/ZHdBUwavr6bgDNYAzf+tzcyn13NwYcXnvdUwTFsA6ngZ98M2YXi1oXc+LqtBAcpr2PlgQ
ARC-Seal: i=1; a=rsa-sha256; t=1524405903; cv=none;
        d=google.com; s=arc-20160816;
        b=kcZJEdM0j62n/zEbLDNX1IN1oMcnjfa6ginjc4LmrJ+WXNPh73I1ToDRAefRDOTuOg
         W3D5XgGrdm1hKlPyJA+w256TvkyMnMtexsCcxcqd/4BSKVarSgTBx1tFbw1S3Ran3nlr
         9mI1LSNa52b3ebvjQQRdT4uJvxI4ZMHvWS6Qp2NY/1WaLFCFvBcx9YjMbMX+0iMlA8Ur
         pQALKkZLvIeDIoZ7dADfQi283Nc3Zaqd5nzFx+57sO+SEyRAH6NcoYCGCujsby91L7eb
         j4znhDyNV/RdCVUMbCbkb7h6bcDTt9eYcTJ0lx5DStlAH5Ln6R9kyuawpuTQi3Wdh283
         XaoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=2WMG5zgstKWbGCqSyDml1cnb1dfbCbVOMSWA9cYwE8I=;
        b=rN/FOoKGX9hvnxHCyIqTS60KnnLJ2mHIZAp0JeRDKuGh+3spjAJ6YQooIKNRbiEJUV
         Mw8ZUwu1MH0N8P+gTPUU4VpoBsh3NnMcLH93SsEtN9VfBACjXkoXlwhoTeJ7O3EsTC+d
         Ci5FtI0//Wt6W2X786nSiV9ePFO4H4rXFe5l5LZTmmfLvur1MjyKzHiiOpQtDfiSoz8C
         0RAZWy4dZnwZLAYStBeEuZIZC9sgj7JpAluRil/3y4ZPPqN38+bHjNQVzdGMl2+7/uqC
         WtiyCdz09ZIFnM82q0el6nc2SRvLG9ynaBzX6CUhzUY2yqvwTKtVAD2yAZya4GysY120
         QZoA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tuba Yavuz <tuba@ece.ufl.edu>,
	Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH 4.14 041/164] usb: dwc3: gadget: never call ->complete() from ->ep_queue()
Date: Sun, 22 Apr 2018 15:51:48 +0200
Message-Id: <20180422135137.093321163@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454942163672502?=
X-GMAIL-MSGID: =?utf-8?q?1598455445418606060?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Felipe Balbi <felipe.balbi@linux.intel.com>

commit c91815b596245fd7da349ecc43c8def670d2269e upstream.

This is a requirement which has always existed but, somehow, wasn't
reflected in the documentation and problems weren't found until now
when Tuba Yavuz found a possible deadlock happening between dwc3 and
f_hid. She described the situation as follows:

spin_lock_irqsave(&hidg->write_spinlock, flags); // first acquire
/* we our function has been disabled by host */
if (!hidg->req) {
	free_ep_req(hidg->in_ep, hidg->req);
	goto try_again;
}

[...]

status = usb_ep_queue(hidg->in_ep, hidg->req, GFP_ATOMIC);
=>
	[...]
	=> usb_gadget_giveback_request
		=>
		f_hidg_req_complete
			=>
			spin_lock_irqsave(&hidg->write_spinlock, flags); // second acquire

Note that this happens because dwc3 would call ->complete() on a
failed usb_ep_queue() due to failed Start Transfer command. This is,
anyway, a theoretical situation because dwc3 currently uses "No
Response Update Transfer" command for Bulk and Interrupt endpoints.

It's still good to make this case impossible to happen even if the "No
Reponse Update Transfer" command is changed.

Reported-by: Tuba Yavuz <tuba@ece.ufl.edu>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/dwc3/gadget.c |   43 +++++++++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 18 deletions(-)

--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -174,18 +174,8 @@ static void dwc3_ep_inc_deq(struct dwc3_
 	dwc3_ep_inc_trb(&dep->trb_dequeue);
 }
 
-/**
- * dwc3_gadget_giveback - call struct usb_request's ->complete callback
- * @dep: The endpoint to whom the request belongs to
- * @req: The request we're giving back
- * @status: completion code for the request
- *
- * Must be called with controller's lock held and interrupts disabled. This
- * function will unmap @req and call its ->complete() callback to notify upper
- * layers that it has completed.
- */
-void dwc3_gadget_giveback(struct dwc3_ep *dep, struct dwc3_request *req,
-		int status)
+void dwc3_gadget_del_and_unmap_request(struct dwc3_ep *dep,
+		struct dwc3_request *req, int status)
 {
 	struct dwc3			*dwc = dep->dwc;
 
@@ -198,18 +188,35 @@ void dwc3_gadget_giveback(struct dwc3_ep
 
 	if (req->trb)
 		usb_gadget_unmap_request_by_dev(dwc->sysdev,
-						&req->request, req->direction);
+				&req->request, req->direction);
 
 	req->trb = NULL;
-
 	trace_dwc3_gadget_giveback(req);
 
+	if (dep->number > 1)
+		pm_runtime_put(dwc->dev);
+}
+
+/**
+ * dwc3_gadget_giveback - call struct usb_request's ->complete callback
+ * @dep: The endpoint to whom the request belongs to
+ * @req: The request we're giving back
+ * @status: completion code for the request
+ *
+ * Must be called with controller's lock held and interrupts disabled. This
+ * function will unmap @req and call its ->complete() callback to notify upper
+ * layers that it has completed.
+ */
+void dwc3_gadget_giveback(struct dwc3_ep *dep, struct dwc3_request *req,
+		int status)
+{
+	struct dwc3			*dwc = dep->dwc;
+
+	dwc3_gadget_del_and_unmap_request(dep, req, status);
+
 	spin_unlock(&dwc->lock);
 	usb_gadget_giveback_request(&dep->endpoint, &req->request);
 	spin_lock(&dwc->lock);
-
-	if (dep->number > 1)
-		pm_runtime_put(dwc->dev);
 }
 
 /**
@@ -1233,7 +1240,7 @@ static int __dwc3_gadget_kick_transfer(s
 		if (req->trb)
 			memset(req->trb, 0, sizeof(struct dwc3_trb));
 		dep->queued_requests--;
-		dwc3_gadget_giveback(dep, req, ret);
+		dwc3_gadget_del_and_unmap_request(dep, req, ret);
 		return ret;
 	}
 
