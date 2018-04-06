Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/1r2hyC2fw30YPJMIYFjuPjL1lVoRJGSfWIJ5JlBR8XE/u0QjOTnU7QGhjeOA5xkjvlCqp
ARC-Seal: i=1; a=rsa-sha256; t=1523021386; cv=none;
        d=google.com; s=arc-20160816;
        b=u+oZU0G9OPh1qTU97VeWzq/2+TZPTBBIbROc6YvTGuc+STN7nce5VO/EVQCCp7+zhB
         PG23pDwf2orCxbt5XgdVVU0Wytd8Ubb8eQwAOcHKPbgZF167CxTC5KKTBO4gXhAEcbTQ
         LSc3j1z/M27OXrGSkn/D95wKxCDl5IUJtRnIdnX5S8JTpoqSlDXR4odZYpqfBIb3cQnF
         ekT8d5435Z+TAmGuAIdazuEM+0fgeTce9kbSi6mlZQasv8BnCE+AWKsNcce3pu1p2txY
         qw8lJ70RaUvkiuLu7OPEWGXncpTsPVFReUesjKdm/wcN8+egUL3GViLX4v1Jidnf6LaG
         l5Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=JTmIQ6kcR6Ql4yBy77dO7jwVRl7B+6/kOa6A+eQysWA=;
        b=tRZBzT0ikDVCG5jgOanTcNNOwzpzdchOCJMhtjyIKSUff6E0lFKWkXHTkIU4JlXI5a
         wyPI2Fdq/Axoy2HZpQwbzhXcLnimdVzTGS/EYS8xFzN/4L+NWWr6g4O9eJN3mjlMrqNf
         vHTUGbjbtvU0GpLghhBXxDpkCRoyVySNVzXuLUzYTXNiAR7zTdFc+ElbVX44E40Jbh27
         bzHgHcyQd6URMwcLeG+/1qpqfWO0K4D1YE2sBkhziE9RsK1ztcdq8+D8ehydeyNJUe48
         LLRK6T8Wma4+m7qQSO+G0nWeVvmwkiqJknn9HYIhn0Xgwjk3Qh9kxtQb0dmOQpfjIzu/
         YnwA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	David Lechner <david@lechnology.com>,
	Krzysztof Opasiak <k.opasiak@samsung.com>,
	Felipe Balbi <felipe.balbi@linux.intel.com>,
	Jerry Zhang <zhangjerry@google.com>
Subject: [PATCH 4.4 10/72] usb: gadget: f_hid: fix: Prevent accessing released memory
Date: Fri,  6 Apr 2018 15:23:11 +0200
Message-Id: <20180406084305.924231914@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084305.210085169@linuxfoundation.org>
References: <20180406084305.210085169@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003606960811734?=
X-GMAIL-MSGID: =?utf-8?q?1597003673205725174?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Krzysztof Opasiak <kopasiak90@gmail.com>

commit aa65d11aa008f4de58a9cee7e121666d9d68505e upstream.

When we unlock our spinlock to copy data to user we may get
disabled by USB host and free the whole list of completed out
requests including the one from which we are copying the data
to user memory.

To prevent from this let's remove our working element from
the list and place it back only if there is sth left when we
finish with it.

Fixes: 99c515005857 ("usb: gadget: hidg: register OUT INT endpoint for SET_REPORT")
Cc: stable@vger.kernel.org
Tested-by: David Lechner <david@lechnology.com>
Signed-off-by: Krzysztof Opasiak <k.opasiak@samsung.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Cc: Jerry Zhang <zhangjerry@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/gadget/function/f_hid.c |   24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

--- a/drivers/usb/gadget/function/f_hid.c
+++ b/drivers/usb/gadget/function/f_hid.c
@@ -223,6 +223,13 @@ static ssize_t f_hidg_read(struct file *
 	/* pick the first one */
 	list = list_first_entry(&hidg->completed_out_req,
 				struct f_hidg_req_list, list);
+
+	/*
+	 * Remove this from list to protect it from beign free()
+	 * while host disables our function
+	 */
+	list_del(&list->list);
+
 	req = list->req;
 	count = min_t(unsigned int, count, req->actual - list->pos);
 	spin_unlock_irqrestore(&hidg->spinlock, flags);
@@ -238,15 +245,20 @@ static ssize_t f_hidg_read(struct file *
 	 * call, taking into account its current read position.
 	 */
 	if (list->pos == req->actual) {
-		spin_lock_irqsave(&hidg->spinlock, flags);
-		list_del(&list->list);
 		kfree(list);
-		spin_unlock_irqrestore(&hidg->spinlock, flags);
 
 		req->length = hidg->report_length;
 		ret = usb_ep_queue(hidg->out_ep, req, GFP_KERNEL);
-		if (ret < 0)
+		if (ret < 0) {
+			free_ep_req(hidg->out_ep, req);
 			return ret;
+		}
+	} else {
+		spin_lock_irqsave(&hidg->spinlock, flags);
+		list_add(&list->list, &hidg->completed_out_req);
+		spin_unlock_irqrestore(&hidg->spinlock, flags);
+
+		wake_up(&hidg->read_queue);
 	}
 
 	return count;
@@ -490,14 +502,18 @@ static void hidg_disable(struct usb_func
 {
 	struct f_hidg *hidg = func_to_hidg(f);
 	struct f_hidg_req_list *list, *next;
+	unsigned long flags;
 
 	usb_ep_disable(hidg->in_ep);
 	usb_ep_disable(hidg->out_ep);
 
+	spin_lock_irqsave(&hidg->spinlock, flags);
 	list_for_each_entry_safe(list, next, &hidg->completed_out_req, list) {
+		free_ep_req(hidg->out_ep, list->req);
 		list_del(&list->list);
 		kfree(list);
 	}
+	spin_unlock_irqrestore(&hidg->spinlock, flags);
 }
 
 static int hidg_set_alt(struct usb_function *f, unsigned intf, unsigned alt)
