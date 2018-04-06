Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49mJC5j0vqb6FIJRsvkDn2Lg0IJRkcf49yqWWfxYWEKj6fK+PY+bhvLTeOwnjA96PUV4hU6
ARC-Seal: i=1; a=rsa-sha256; t=1523021323; cv=none;
        d=google.com; s=arc-20160816;
        b=rT+wTXhZpQ5Yb6odIsZ00p1sly489wE3LPKYmM1NY2cVHeErt8JBGxfYJf6AB1B3+N
         kx53DH1izCEH3wk2D6203SAFRoK1GDsCAh5fc9DJv0PWQhqABJbmFzLZTkytb/7w3T6F
         UnHJgHwxGR0nHANy4SmLe0oq56V+LGNBTTeJf5mEANe/uOAA0gHLschOXdGkmd5KNMGl
         Lsn0FJyOApGDNAe2YI5LAkj0V+t1q+eXYtitYFvg1zNBziszOSmOydxn5aRWaJgwJQ1U
         oXnu2H+ANq0ZPPgRVYc851cpwkcxeMKmp1UyzDapNzcBZGwra/7nAHDgHNZIyunSxiPF
         gCzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=gL3KADZIG4MRd6/hG8ljzwikeEpvNmhj9r+0ZzwFyqE=;
        b=N9AEhdJFcI30iRaaFvz+CSAXAtmyUKDqmgN9iLC7t7SskbvjWhFM4mwP0qo5umXWnX
         iGu6ymBlp6l/xOQI1jkyFHP8qWIvR6i4bK93g2sHAdo+p/RGlZPlbEu4qaO4CH1qUoWC
         Zuv200V6Lb/i+hzJpt9nPMZRVdbB8ey2/h2FuDOegKi1eOrQc/piYkbVyGPIqXXU95wJ
         CBtx5h7qLv5v5tSaAjXvFIzDwM64qBKA8xYXmGuAP8QM6os5kM3yRQeXquHoLGRzWGUU
         qMZSs5NqWgXpmz7tKYX8yYcPYWVbWRJIzbfuIK8uZyU1D1YU4dsn90X9IgrFsnE8RyNu
         ArHw==
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
Subject: [PATCH 3.18 46/93] usb: gadget: f_hid: fix: Prevent accessing released memory
Date: Fri,  6 Apr 2018 15:23:15 +0200
Message-Id: <20180406084226.933085007@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084224.918716300@linuxfoundation.org>
References: <20180406084224.918716300@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003606960811734?=
X-GMAIL-MSGID: =?utf-8?q?1597003606960811734?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -197,6 +197,13 @@ static ssize_t f_hidg_read(struct file *
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
@@ -212,15 +219,20 @@ static ssize_t f_hidg_read(struct file *
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
@@ -455,6 +467,7 @@ static void hidg_disable(struct usb_func
 {
 	struct f_hidg *hidg = func_to_hidg(f);
 	struct f_hidg_req_list *list, *next;
+	unsigned long flags;
 
 	usb_ep_disable(hidg->in_ep);
 	hidg->in_ep->driver_data = NULL;
@@ -462,10 +475,13 @@ static void hidg_disable(struct usb_func
 	usb_ep_disable(hidg->out_ep);
 	hidg->out_ep->driver_data = NULL;
 
+	spin_lock_irqsave(&hidg->spinlock, flags);
 	list_for_each_entry_safe(list, next, &hidg->completed_out_req, list) {
+		free_ep_req(hidg->out_ep, list->req);
 		list_del(&list->list);
 		kfree(list);
 	}
+	spin_unlock_irqrestore(&hidg->spinlock, flags);
 }
 
 static int hidg_set_alt(struct usb_function *f, unsigned intf, unsigned alt)
